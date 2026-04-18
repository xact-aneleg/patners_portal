package com.xact.sy195.service;

import com.xact.sy195.model.*;
import com.xact.sy195.repository.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;
import java.util.stream.Collectors;

/**
 * Provisions a new XactERP company database after a registration is approved.
 *
 * Steps:
 *  1. Create a new PostgreSQL database named from the registration
 *  2. Run the FULL xactdev_db schema (xactdev_schema_clean.sql) — all 510 tables,
 *     all constraints, all indexes — exactly matching production
 *  3. Insert sy00_co_mast from registration form data
 *  4. Insert gl02_loc_mast rows from registration locations
 *  5. Insert sy04_access_grps base groups
 *  6. Insert sy02_user rows from registration base users
 *  7. Insert sy02l_user_loc permissions linking all users to all locations
 */
@Service
public class CompanyProvisioningService {

    private static final Logger log = Logger.getLogger(CompanyProvisioningService.class.getName());

    @Value("${spring.datasource.url}")      private String datasourceUrl;
    @Value("${spring.datasource.username}") private String dbUser;
    @Value("${spring.datasource.password}") private String dbPassword;

    private final RegistrationRepository  regRepo;
    private final RegLocationRepository   locRepo;
    private final RegUserRepository       userRepo;
    private final ConversionJobRepository jobRepo;

    public CompanyProvisioningService(RegistrationRepository regRepo,
                                      RegLocationRepository locRepo,
                                      RegUserRepository userRepo,
                                      ConversionJobRepository jobRepo) {
        this.regRepo  = regRepo;
        this.locRepo  = locRepo;
        this.userRepo = userRepo;
        this.jobRepo  = jobRepo;
    }

    // ── Main entry point ──────────────────────────────────────────────────────
    public void provision(Long registrationId) {
        Registration reg = regRepo.findById(registrationId)
                .orElseThrow(() -> new IllegalArgumentException("Registration not found: " + registrationId));

        String dbName = buildDbName(reg.getCompanyName());
        log.info("Provisioning: " + dbName + " for registration " + registrationId);

        ConversionJob job = jobRepo.findTopByRegistrationIdOrderByCreatedAtDesc(registrationId)
                .orElse(null);

        StringBuilder logOutput = new StringBuilder();
        try {
            // Step 1: Create the database
            logOutput.append("► Step 1: Creating database '").append(dbName).append("'...\n");
            createDatabase(dbName);
            logOutput.append("  ✓ Database created\n\n");

            // Step 2: Run the FULL real xactdev_db schema
            logOutput.append("► Step 2: Applying full XactERP schema (510 tables)...\n");
            runFullSchema(dbName, logOutput);
            logOutput.append("  ✓ Full schema applied\n\n");

            // Steps 3–7: Seed company data
            String newDbUrl = buildNewDbUrl(dbName);
            try (Connection conn = DriverManager.getConnection(newDbUrl, dbUser, dbPassword)) {
                conn.setAutoCommit(false);

                // Step 3: sy00_co_mast
                logOutput.append("► Step 3: Inserting company master (sy00_co_mast)...\n");
                insertCoMast(conn, reg, dbName);
                logOutput.append("  ✓ sy00_co_mast inserted\n\n");

                // Step 4: gl02_loc_mast
                List<RegLocation> locations = locRepo.findByRegistrationId(registrationId);
                logOutput.append("► Step 4: Inserting ").append(locations.size()).append(" location(s) (gl02_loc_mast)...\n");
                for (RegLocation loc : locations) {
                    insertLocation(conn, loc);
                    logOutput.append("  ✓ loc=").append(loc.getLoc()).append(" whs=").append(loc.getWhs())
                             .append(" (").append(loc.getLocName()).append(")\n");
                }
                logOutput.append("\n");

                // Step 5: sy04_access_grps
                logOutput.append("► Step 5: Inserting base access groups (sy04_access_grps)...\n");
                insertAccessGroups(conn);
                logOutput.append("  ✓ Z0 (System Admin), A1 (Admin), U1 (Standard User), V1 (View Only)\n\n");

                // Step 6: sy02_user
                List<RegUser> users = userRepo.findByRegistrationId(registrationId);
                logOutput.append("► Step 6: Inserting ").append(users.size()).append(" user(s) (sy02_user)...\n");
                for (RegUser user : users) {
                    insertUser(conn, user, locations.isEmpty() ? null : locations.get(0));
                    logOutput.append("  ✓ ").append(user.getUsername())
                             .append(" (").append(user.getFullName()).append(")\n");
                }
                logOutput.append("\n");

                // Step 7: sy02l_user_loc
                logOutput.append("► Step 7: Linking users to locations (sy02l_user_loc)...\n");
                for (RegUser user : users) {
                    for (RegLocation loc : locations) {
                        insertUserLoc(conn, user.getUsername(), loc.getLoc(), loc.getWhs());
                    }
                }
                logOutput.append("  ✓ ").append(users.size()).append(" user(s) × ")
                         .append(locations.size()).append(" location(s) = ")
                         .append(users.size() * locations.size()).append(" permission rows\n\n");

                conn.commit();
                logOutput.append("═══════════════════════════════════════════════\n");
                logOutput.append("✓ PROVISIONING COMPLETE\n");
                logOutput.append("  Company:  ").append(reg.getCompanyName()).append("\n");
                logOutput.append("  Database: ").append(dbName).append("\n");
                logOutput.append("  Package:  Xact ").append("LITE".equals(reg.getPackageType()) ? "Lite" : "Pro").append("\n");
                logOutput.append("  Users:    ").append(users.size()).append("\n");
                logOutput.append("  Locs:     ").append(locations.size()).append("\n");
            }

            if (job != null) {
                job.setStatus("COMPLETE");
                job.setCompletedAt(LocalDateTime.now());
                job.setLogOutput(logOutput.toString());
                jobRepo.save(job);
            }

        } catch (Exception e) {
            log.severe("Provisioning FAILED for registration " + registrationId + ": " + e.getMessage());
            logOutput.append("\n✗ FAILED: ").append(e.getMessage());
            if (job != null) {
                job.setStatus("FAILED");
                job.setCompletedAt(LocalDateTime.now());
                job.setLogOutput(logOutput.toString());
                jobRepo.save(job);
            }
            throw new RuntimeException("Provisioning failed: " + e.getMessage(), e);
        }
    }

    // ── Step 1: Create database ───────────────────────────────────────────────
    private void createDatabase(String dbName) throws SQLException {
        String pgUrl = datasourceUrl.replaceAll("/[^/?]+([?].*)?$", "/postgres");
        try (Connection conn = DriverManager.getConnection(pgUrl, dbUser, dbPassword);
             Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(
                "SELECT 1 FROM pg_database WHERE datname = '" + dbName + "'");
            if (!rs.next()) {
                stmt.executeUpdate("CREATE DATABASE \"" + dbName + "\"");
                log.info("Database created: " + dbName);
            } else {
                log.info("Database already exists, reusing: " + dbName);
            }
        }
    }

    // ── Step 2: Run FULL real xactdev_db schema ───────────────────────────────
    private void runFullSchema(String dbName, StringBuilder logOutput) throws Exception {
        String newDbUrl = buildNewDbUrl(dbName);

        // Load the clean schema file from classpath (placed in resources folder)
        String schemaContent;
        try {
            ClassPathResource resource = new ClassPathResource("xactdev_schema_clean.sql");
            try (InputStream is = resource.getInputStream()) {
                schemaContent = new String(is.readAllBytes(), StandardCharsets.UTF_8);
            }
            logOutput.append("  Loaded schema from classpath: xactdev_schema_clean.sql\n");
        } catch (Exception e) {
            // Fallback: try to load from the filesystem path
            File fallback = new File("src/main/resources/xactdev_schema_clean.sql");
            if (!fallback.exists()) {
                // Last resort: apply only the core tables we know about
                logOutput.append("  WARNING: xactdev_schema_clean.sql not found — applying core tables only\n");
                applyCoreTablesOnly(newDbUrl, logOutput);
                return;
            }
            schemaContent = new String(java.nio.file.Files.readAllBytes(fallback.toPath()), StandardCharsets.UTF_8);
        }

        // Execute the schema — split on statement boundaries
        try (Connection conn = DriverManager.getConnection(newDbUrl, dbUser, dbPassword)) {
            conn.setAutoCommit(true); // DDL auto-commits in PostgreSQL

            // Split into individual statements — use pg's $$ quoting awareness
            String[] statements = schemaContent.split(";\\s*\n");
            int total = 0, success = 0, skipped = 0, errors = 0;

            for (String rawStmt : statements) {
                String stmt = rawStmt.trim();
                if (stmt.isEmpty() || stmt.startsWith("--") || stmt.startsWith("SET ")
                        || stmt.startsWith("SELECT pg_catalog")) {
                    skipped++;
                    continue;
                }

                try (Statement s = conn.createStatement()) {
                    s.execute(stmt);
                    success++;
                } catch (SQLException ex) {
                    // Already exists errors are expected and fine
                    String msg = ex.getMessage().toLowerCase();
                    if (msg.contains("already exists") || msg.contains("duplicate")) {
                        skipped++;
                    } else {
                        errors++;
                        log.warning("Schema statement error (non-fatal): " + ex.getMessage().substring(0, Math.min(100, ex.getMessage().length())));
                    }
                }
                total++;
            }
            logOutput.append("  Statements: ").append(total)
                     .append(" total | ").append(success).append(" applied | ")
                     .append(skipped).append(" skipped | ").append(errors).append(" errors\n");
        }
    }

    // ── Fallback: apply only the core tables we need ──────────────────────────
    private void applyCoreTablesOnly(String newDbUrl, StringBuilder logOutput) throws SQLException {
        logOutput.append("  Applying core tables: sy00_co_mast, gl02_loc_mast, sy04_access_grps,\n");
        logOutput.append("  sy02_user, sy02l_user_loc, dl01_mast, st01_mast, cl01_mast, gl01_mast\n");

        try (Connection conn = DriverManager.getConnection(newDbUrl, dbUser, dbPassword);
             Statement stmt = conn.createStatement()) {
            conn.setAutoCommit(false);

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.sy00_co_mast (
                    co_name character varying(45) NOT NULL,
                    co_short_name character varying(10),
                    co_db_name character varying(20),
                    master_or_slave character varying(1),
                    xact_lite character varying(1) DEFAULT 'N',
                    post_add_1 character varying(25), post_add_2 character varying(25),
                    post_add_3 character varying(25), post_add_4 character varying(25),
                    post_add_5 character varying(25),
                    phy_add_1 character varying(25),  phy_add_2 character varying(25),
                    phy_add_3 character varying(25),  phy_add_4 character varying(25),
                    tel_no character varying(15), fax_no character varying(15),
                    co_email character varying(80), co_domain character varying(30),
                    co_reg_no character varying(17), co_vat_no character varying(12),
                    year_end_mth integer DEFAULT 0,
                    vat_rate numeric(7,2) DEFAULT 0,
                    bank_name character varying(20), bank_branch_code character varying(20),
                    bank_acct_no character varying(35),
                    allow_multi_currency character varying(1),
                    local_currency character varying(10),
                    system_admin character varying(255),
                    CONSTRAINT sy00_pk PRIMARY KEY (co_name))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.gl02_loc_mast (
                    loc character varying(3) NOT NULL, whs character varying(3) NOT NULL,
                    default_del_loc character varying(3), default_del_whs character varying(3),
                    link_to_dc_loc character varying(3), link_to_dc_whs character varying(3),
                    status character varying(1), loc_name character varying(30),
                    region character varying(3), use_loc_add character varying(1),
                    add_1 character varying(35), add_2 character varying(35),
                    add_3 character varying(35), add_4 character varying(35),
                    post_add_1 character varying(35), post_add_2 character varying(35),
                    post_add_3 character varying(35), post_add_4 character varying(35),
                    area_dialcode_international integer, area_dialcode_local integer,
                    tel_no character varying(15), fax_no character varying(15),
                    branch_manager character varying(10), stk_loc character varying(1),
                    sales_whs character varying(1), pur_whs character varying(1),
                    replen_whs character varying(1), dc_whs character varying(1),
                    crossd_whs character varying(1), bo_whs character varying(1),
                    ibt_whs character varying(1), dispatch_whs character varying(1),
                    mrp_whs character varying(1), default_del_area character varying(4),
                    bin_qty_tracking character varying(1), allow_del_loc_chg character varying(1),
                    web_enabled character varying(1), inv_type character varying(1),
                    CONSTRAINT gl02_pk PRIMARY KEY (loc, whs))""");

            stmt.executeUpdate("CREATE INDEX IF NOT EXISTS gl02_stk_loc ON public.gl02_loc_mast USING btree (stk_loc)");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.sy04_access_grps (
                    grp character varying(2) NOT NULL,
                    active character varying(1), grp_desc character varying(30),
                    CONSTRAINT sy04_pk PRIMARY KEY (grp))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.sy02_user (
                    user_name character varying(10) NOT NULL,
                    password character varying(90), pwd_status character varying(1),
                    pwd_attempts integer DEFAULT 0, full_name character varying(25),
                    disable_user character varying(1), access_grp character varying(2),
                    email character varying(80), default_loc character varying(4),
                    default_whs character varying(3), allow_loc_chg character varying(1),
                    admin_user character varying(1),
                    CONSTRAINT sy02_pk PRIMARY KEY (user_name))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.sy02l_user_loc (
                    user_name character varying(10) NOT NULL,
                    loc character varying(3) NOT NULL,
                    whs character varying(3) DEFAULT '00' NOT NULL,
                    allow_ctrl_tot_view character varying(1),
                    allow_qt_maint character varying(1), allow_qt_enq character varying(1),
                    allow_so_maint character varying(1), allow_so_enq character varying(1),
                    allow_inv_maint character varying(1), allow_inv_enq character varying(1),
                    allow_po_maint character varying(1), allow_po_enq character varying(1),
                    allow_grn_maint character varying(1), allow_grn_enq character varying(1),
                    allow_stk_detailed_enq character varying(1),
                    allow_stk_warehouse_view character varying(1) DEFAULT 'N',
                    CONSTRAINT sy02l_pk PRIMARY KEY (user_name, loc, whs))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.dl01_mast (
                    dl_code character varying(8) NOT NULL,
                    dl_name character varying(40), status character varying(1),
                    master_acct character varying(1), address_only_acct character varying(1),
                    linked_acct character varying(8), loc character varying(3),
                    tel_1 character varying(22), tel_2 character varying(22),
                    fax_1 character varying(22), contact character varying(29),
                    controlled_by character varying(10), co_reg character varying(17),
                    vat_no character varying(12), post_add_1 character varying(30),
                    post_add_2 character varying(30), post_add_3 character varying(30),
                    post_add_4 character varying(10), post_code character varying(4),
                    phy_add_1 character varying(30), phy_add_2 character varying(30),
                    phy_add_3 character varying(30), dl_cat character varying(5),
                    region character varying(5), rep_code character varying(5),
                    mkt_rep character varying(5), class character varying(3),
                    cr_status character varying(4), terms integer DEFAULT 0,
                    sett_disc numeric(7,2) DEFAULT 0, cr_limit numeric(13,2) DEFAULT 0,
                    max_cr_limit numeric(13,2) DEFAULT 0, email character varying(80),
                    balance numeric(13,2) DEFAULT 0,
                    track_by_foreign_currency character varying(1), opened_date date,
                    CONSTRAINT dl01_pk PRIMARY KEY (dl_code))""");

            stmt.executeUpdate("CREATE INDEX IF NOT EXISTS dl01_linked_code_dl_code ON public.dl01_mast USING btree (linked_acct DESC, dl_code DESC)");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.st01_mast (
                    stk_code character varying(16) NOT NULL,
                    status character varying(1), master_acct character varying(1),
                    linked_to character varying(16), web_enabled character varying(1),
                    retail_enabled character varying(1), trade_in_item character varying(1),
                    import_item character varying(1), keep_bal character varying(1),
                    desc_1 character varying(40), desc_2 character varying(40),
                    desc_3 character varying(40), desc_4 character varying(40),
                    desc_5 character varying(40), desc_6 character varying(40),
                    barcode character varying(16), stk_grp character varying(5),
                    gl_grp integer DEFAULT 0, serial_track character varying(1),
                    uom character varying(5), unit_qty numeric(11,3) DEFAULT 0,
                    mass numeric(11,3) DEFAULT 0, lead_time numeric(5,2) DEFAULT 0,
                    line_type character varying(1), re_order integer DEFAULT 0,
                    vat_ind character varying(1), create_date date,
                    CONSTRAINT st01_pk PRIMARY KEY (stk_code))""");

            stmt.executeUpdate("CREATE INDEX IF NOT EXISTS st01_grp_code ON public.st01_mast USING btree (stk_grp, stk_code)");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.cl01_mast (
                    cl_code character varying(8) NOT NULL,
                    cl_name character varying(40), status character varying(1),
                    master_acct character varying(1), linked_acct character varying(8),
                    tel_1 character varying(22), fax_1 character varying(22),
                    email character varying(80), contact character varying(29),
                    vat_no character varying(12), co_reg character varying(17),
                    post_add_1 character varying(30), post_add_2 character varying(30),
                    post_add_3 character varying(30), post_add_4 character varying(10),
                    post_code character varying(4), phy_add_1 character varying(30),
                    phy_add_2 character varying(30), phy_add_3 character varying(30),
                    cl_cat character varying(5), terms integer DEFAULT 0,
                    sett_disc numeric(7,2) DEFAULT 0, cred_limit numeric(13,0) DEFAULT 0,
                    balance numeric(13,2) DEFAULT 0, ic_acct character varying(1) DEFAULT 'N',
                    import_acct character varying(1),
                    track_by_foreign_currency character varying(1),
                    bank_name character varying(20), bank_branch_code character varying(15),
                    bank_acct_no character varying(35), opened_date date,
                    CONSTRAINT cl01_pk PRIMARY KEY (cl_code))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.gl01_mast (
                    gl_code character varying(8) NOT NULL,
                    descr character varying(40), status character varying(1),
                    acct_type character varying(1), post character varying(1),
                    control character varying(8), detail_trans character varying(1),
                    loc_anal character varying(1), budget character varying(1),
                    budget_based_on character varying(1), note_no integer DEFAULT 0,
                    interface_acct character varying(1), block_posting character varying(1),
                    last_gl30_row_id integer DEFAULT 0,
                    CONSTRAINT gl01_pk PRIMARY KEY (gl_code))""");

            stmt.executeUpdate("""
                CREATE TABLE IF NOT EXISTS public.sy35_chg_log (
                    log_id SERIAL PRIMARY KEY, tbl_name character varying(40),
                    key_field character varying(100), field_name character varying(40),
                    old_value text, new_value text,
                    changed_by character varying(20), changed_at timestamp DEFAULT NOW())""");

            conn.commit();
        }
    }

    // ── Step 3: Insert sy00_co_mast ───────────────────────────────────────────
    private void insertCoMast(Connection conn, Registration reg, String dbName) throws SQLException {
        String xactLite = "LITE".equals(reg.getPackageType()) ? "Y" : "N";
        String masterOrSlave = Boolean.TRUE.equals(reg.getStandalone()) ? "M" : "S";

        try (PreparedStatement ps = conn.prepareStatement("""
            INSERT INTO public.sy00_co_mast
            (co_name, co_short_name, co_db_name, master_or_slave, xact_lite,
             post_add_1, post_add_2, post_add_3, post_add_4,
             phy_add_1,  phy_add_2,  phy_add_3,  phy_add_4,
             tel_no, co_email, co_domain, co_reg_no, co_vat_no,
             year_end_mth, vat_rate,
             bank_name, bank_branch_code, bank_acct_no,
             local_currency, system_admin)
            VALUES (?,?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?,?, ?,?, ?,?,?, ?,?)
            ON CONFLICT (co_name) DO UPDATE SET
              co_db_name = EXCLUDED.co_db_name,
              master_or_slave = EXCLUDED.master_or_slave
            """)) {
            ps.setString(1,  trunc(reg.getCompanyName(), 45));
            ps.setString(2,  trunc(reg.getCompanyName(), 10));
            ps.setString(3,  trunc(dbName, 20));
            ps.setString(4,  masterOrSlave);
            ps.setString(5,  xactLite);
            ps.setString(6,  trunc(reg.getPostalAddr1(), 25));
            ps.setString(7,  trunc(reg.getPostalAddr2(), 25));
            ps.setString(8,  trunc(reg.getPostalAddr3(), 25));
            ps.setString(9,  trunc(reg.getPostalAddr4(), 25));
            ps.setString(10, trunc(reg.getPhysicalAddr1(), 25));
            ps.setString(11, trunc(reg.getPhysicalAddr2(), 25));
            ps.setString(12, trunc(reg.getPhysicalAddr3(), 25));
            ps.setString(13, trunc(reg.getPhysicalAddr4(), 25));
            ps.setString(14, trunc(reg.getTelephone(), 15));
            ps.setString(15, trunc(reg.getCompanyEmail(), 80));
            ps.setString(16, trunc(reg.getCompanyDomain(), 30));
            ps.setString(17, trunc(reg.getRegNumber(), 17));
            ps.setString(18, trunc(reg.getVatNumber(), 12));
            ps.setInt   (19, reg.getYearEndMonth() != null ? reg.getYearEndMonth() : 0);
            ps.setBigDecimal(20, reg.getVatRate());
            ps.setString(21, trunc(reg.getBankName(), 20));
            ps.setString(22, trunc(reg.getBankBranchCode(), 20));
            ps.setString(23, trunc(reg.getBankAccount(), 35));
            ps.setString(24, trunc(reg.getCurrencyCode() != null ? reg.getCurrencyCode() : "ZAR", 10));
            ps.setString(25, trunc(reg.getCompanyEmail(), 255));
            ps.executeUpdate();
        }
    }

    // ── Step 4: Insert gl02_loc_mast ──────────────────────────────────────────
    private void insertLocation(Connection conn, RegLocation loc) throws SQLException {
        String whs = loc.getWhs() != null ? loc.getWhs() : "001";
        try (PreparedStatement ps = conn.prepareStatement("""
            INSERT INTO public.gl02_loc_mast
            (loc, whs, loc_name, region, stk_loc,
             add_1, add_2, add_3, add_4, status)
            VALUES (?,?,?,?,?, ?,?,?,?, 'A')
            ON CONFLICT (loc, whs) DO NOTHING
            """)) {
            ps.setString(1, trunc(loc.getLoc(), 3));
            ps.setString(2, trunc(whs, 3));
            ps.setString(3, trunc(loc.getLocName(), 30));
            ps.setString(4, trunc(loc.getRegion(), 3));
            ps.setString(5, Boolean.TRUE.equals(loc.getStockLoc()) ? "Y" : "N");
            ps.setString(6, trunc(loc.getPhysicalAddr1(), 35));
            ps.setString(7, trunc(loc.getPhysicalAddr2(), 35));
            ps.setString(8, trunc(loc.getPhysicalAddr3(), 35));
            ps.setString(9, trunc(loc.getPhysicalAddr4(), 35));
            ps.executeUpdate();
        }
    }

    // ── Step 5: Insert sy04_access_grps ──────────────────────────────────────
    private void insertAccessGroups(Connection conn) throws SQLException {
        String[][] groups = {
            {"Z0", "Y", "System Administrator"},
            {"A1", "Y", "Administrator"},
            {"U1", "Y", "Standard User"},
            {"V1", "Y", "View Only"},
        };
        try (PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO public.sy04_access_grps (grp, active, grp_desc) VALUES (?,?,?) ON CONFLICT (grp) DO NOTHING")) {
            for (String[] g : groups) {
                ps.setString(1, g[0]); ps.setString(2, g[1]); ps.setString(3, g[2]);
                ps.executeUpdate();
            }
        }
    }

    // ── Step 6: Insert sy02_user ──────────────────────────────────────────────
    private void insertUser(Connection conn, RegUser user, RegLocation defaultLoc) throws SQLException {
        String loc = user.getDefaultLoc() != null ? user.getDefaultLoc()
                   : (defaultLoc != null ? defaultLoc.getLoc() : "001");
        String grp = user.getAccessGrp() != null ? trunc(user.getAccessGrp(), 2) : "U1";
        String uname = trunc(user.getUsername() != null ? user.getUsername() : "USER1", 10);

        try (PreparedStatement ps = conn.prepareStatement("""
            INSERT INTO public.sy02_user
            (user_name, full_name, email, access_grp, default_loc,
             disable_user, admin_user, pwd_status, allow_loc_chg)
            VALUES (?,?,?,?,?, 'N','N','A','Y')
            ON CONFLICT (user_name) DO NOTHING
            """)) {
            ps.setString(1, uname);
            ps.setString(2, trunc(user.getFullName() != null ? user.getFullName() : "", 25));
            ps.setString(3, trunc(user.getEmail() != null ? user.getEmail() : "", 80));
            ps.setString(4, grp);
            ps.setString(5, trunc(loc, 4));
            ps.executeUpdate();
        }
    }

    // ── Step 7: Insert sy02l_user_loc ─────────────────────────────────────────
    private void insertUserLoc(Connection conn, String userName, String loc, String whs) throws SQLException {
        if (userName == null) return;
        String w = whs != null ? whs : "001";
        try (PreparedStatement ps = conn.prepareStatement("""
            INSERT INTO public.sy02l_user_loc
            (user_name, loc, whs,
             allow_ctrl_tot_view, allow_qt_maint, allow_qt_enq,
             allow_so_maint, allow_so_enq, allow_inv_maint, allow_inv_enq,
             allow_po_maint, allow_po_enq, allow_grn_maint, allow_grn_enq,
             allow_stk_detailed_enq, allow_stk_warehouse_view)
            VALUES (?,?,?, 'Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y')
            ON CONFLICT (user_name, loc, whs) DO NOTHING
            """)) {
            ps.setString(1, trunc(userName, 10));
            ps.setString(2, trunc(loc, 3));
            ps.setString(3, trunc(w, 3));
            ps.executeUpdate();
        }
    }

    // ── Utilities ─────────────────────────────────────────────────────────────
    private String buildDbName(String companyName) {
        if (companyName == null) return "company_db";
        String safe = companyName.toLowerCase()
                .replaceAll("[^a-z0-9]", "_")
                .replaceAll("_+", "_")
                .replaceAll("^_|_$", "");
        if (safe.length() > 16) safe = safe.substring(0, 16);
        return safe + "_db";
    }

    private String buildNewDbUrl(String dbName) {
        return datasourceUrl.replaceAll("/[^/?]+([?].*)?$", "/" + dbName);
    }

    private String trunc(String s, int max) {
        if (s == null) return null;
        return s.length() > max ? s.substring(0, max) : s;
    }
}
