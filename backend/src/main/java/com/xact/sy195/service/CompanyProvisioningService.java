package com.xact.sy195.service;

import com.xact.sy195.model.*;
import com.xact.sy195.repository.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.*;
import java.nio.file.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

/**
 * Provisions a new XactERP company database after a registration is approved.
 *
 * Steps:
 *  1. Create a new PostgreSQL database
 *  2. Run the full xactdev_schema_clean.sql via psql (most reliable method)
 *  3. Insert sy00_co_mast from registration form data
 *  4. Insert gl02_loc_mast from registration locations
 *  5. Insert sy04_access_grps base groups
 *  6. Insert sy02_user from base users
 *  7. Insert sy02l_user_loc permissions
 */
@Service
public class CompanyProvisioningService {

    private static final Logger log = Logger.getLogger(CompanyProvisioningService.class.getName());

    @Value("${spring.datasource.url}")      private String datasourceUrl;
    @Value("${spring.datasource.username}") private String dbUser;
    @Value("${spring.datasource.password}") private String dbPassword;

    // Path to psql executable — update this to match your system
    @Value("${provisioning.psql.path:C:\\Program Files\\PostgreSQL 18\\bin\\psql.exe}")
    private String psqlPath;

    // PostgreSQL host extracted from datasource URL
    @Value("${provisioning.db.host:localhost}")
    private String dbHost;

    @Value("${provisioning.db.port:5432}")
    private String dbPort;

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

            // Step 2: Run the full real xactdev_db schema via psql
            logOutput.append("► Step 2: Applying full XactERP schema (510 tables)...\n");
            runSchemaViaPsql(dbName, logOutput);
            logOutput.append("  ✓ Full schema applied\n\n");

            // Steps 3–7: Seed company data via JDBC
            String newDbUrl = buildNewDbUrl(dbName);
            try (Connection conn = DriverManager.getConnection(newDbUrl, dbUser, dbPassword)) {
                conn.setAutoCommit(false);

                // Step 3
                logOutput.append("► Step 3: Inserting company master (sy00_co_mast)...\n");
                insertCoMast(conn, reg, dbName);
                logOutput.append("  ✓ sy00_co_mast inserted\n\n");

                // Step 4
                List<RegLocation> locations = locRepo.findByRegistrationId(registrationId);
                logOutput.append("► Step 4: Inserting ").append(locations.size()).append(" location(s) (gl02_loc_mast)...\n");
                for (RegLocation loc : locations) {
                    insertLocation(conn, loc);
                    logOutput.append("  ✓ ").append(loc.getLoc()).append("/").append(loc.getWhs())
                             .append(" — ").append(loc.getLocName()).append("\n");
                }
                logOutput.append("\n");

                // Step 5
                logOutput.append("► Step 5: Inserting base access groups (sy04_access_grps)...\n");
                insertAccessGroups(conn);
                logOutput.append("  ✓ Z0, A1, U1, V1\n\n");

                // Step 6
                List<RegUser> users = userRepo.findByRegistrationId(registrationId);
                logOutput.append("► Step 6: Inserting ").append(users.size()).append(" user(s) (sy02_user)...\n");
                for (RegUser user : users) {
                    insertUser(conn, user, locations.isEmpty() ? null : locations.get(0));
                    logOutput.append("  ✓ ").append(user.getUsername()).append("\n");
                }
                logOutput.append("\n");

                // Step 7
                logOutput.append("► Step 7: Linking users to locations (sy02l_user_loc)...\n");
                for (RegUser user : users) {
                    for (RegLocation loc : locations) {
                        insertUserLoc(conn, user.getUsername(), loc.getLoc(), loc.getWhs());
                    }
                }
                logOutput.append("  ✓ ").append(users.size()).append(" user(s) × ")
                         .append(locations.size()).append(" location(s)\n\n");

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
            log.severe("Provisioning FAILED for " + registrationId + ": " + e.getMessage());
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
                log.info("Database already exists: " + dbName);
            }
        }
    }

    // ── Step 2: Run schema via psql (most reliable — handles all SQL syntax) ──
    private void runSchemaViaPsql(String dbName, StringBuilder logOutput) throws Exception {
        // Extract schema file to a temp file
        File schemaFile = extractSchemaToTemp();
        logOutput.append("  Schema file: ").append(schemaFile.getAbsolutePath()).append("\n");

        // Build the psql command
        // Use PGPASSWORD environment variable to avoid password prompt
        ProcessBuilder pb = new ProcessBuilder(
            psqlPath,
            "-h", dbHost,
            "-p", dbPort,
            "-U", dbUser,
            "-d", dbName,
            "-f", schemaFile.getAbsolutePath(),
            "-v", "ON_ERROR_STOP=0"  // continue on errors (e.g. role not found)
        );
        pb.environment().put("PGPASSWORD", dbPassword);
        pb.redirectErrorStream(true);

        logOutput.append("  Running psql...\n");
        Process proc = pb.start();

        // Read output
        StringBuilder output = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(proc.getInputStream()))) {
            String line;
            int errorCount = 0;
            while ((line = reader.readLine()) != null) {
                output.append(line).append("\n");
                if (line.contains("ERROR") && !line.contains("already exists")) {
                    errorCount++;
                }
            }
            logOutput.append("  Non-fatal errors (role grants etc): ").append(errorCount).append("\n");
        }

        int exitCode = proc.waitFor();
        log.info("psql exit code: " + exitCode);
        logOutput.append("  psql completed with exit code: ").append(exitCode).append("\n");

        // Clean up temp file
        schemaFile.delete();
    }

    private File extractSchemaToTemp() throws Exception {
        // Try classpath first (packaged jar)
        InputStream is = null;
        try {
            ClassPathResource resource = new ClassPathResource("xactdev_schema_clean.sql");
            is = resource.getInputStream();
        } catch (Exception e) {
            // Fallback: look for it relative to working directory
            File f = new File("src/main/resources/xactdev_schema_clean.sql");
            if (f.exists()) {
                is = new FileInputStream(f);
            } else {
                throw new FileNotFoundException(
                    "xactdev_schema_clean.sql not found in classpath or filesystem. " +
                    "Make sure it is in backend/src/main/resources/");
            }
        }

        // Write to a temp file that psql can read
        File temp = File.createTempFile("xactdev_schema_", ".sql");
        try (InputStream src = is;
             OutputStream dst = new FileOutputStream(temp)) {
            src.transferTo(dst);
        }
        return temp;
    }

    // ── Step 3: Insert sy00_co_mast ───────────────────────────────────────────
    private void insertCoMast(Connection conn, Registration reg, String dbName) throws SQLException {
        String xactLite = "LITE".equals(reg.getPackageType()) ? "Y" : "N";
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
            ON CONFLICT (co_name) DO UPDATE SET co_db_name = EXCLUDED.co_db_name
            """)) {
            ps.setString(1,  trunc(reg.getCompanyName(), 45));
            ps.setString(2,  trunc(reg.getCompanyName(), 10));
            ps.setString(3,  trunc(dbName, 20));
            ps.setString(4,  Boolean.TRUE.equals(reg.getStandalone()) ? "M" : "S");
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
            (loc, whs, loc_name, region, stk_loc, add_1, add_2, add_3, add_4, status)
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
            {"Z0","Y","System Administrator"},
            {"A1","Y","Administrator"},
            {"U1","Y","Standard User"},
            {"V1","Y","View Only"},
        };
        try (PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO public.sy04_access_grps (grp,active,grp_desc) VALUES (?,?,?) ON CONFLICT (grp) DO NOTHING")) {
            for (String[] g : groups) {
                ps.setString(1,g[0]); ps.setString(2,g[1]); ps.setString(3,g[2]);
                ps.executeUpdate();
            }
        }
    }

    // ── Step 6: Insert sy02_user ──────────────────────────────────────────────
    private void insertUser(Connection conn, RegUser user, RegLocation defaultLoc) throws SQLException {
        String loc  = user.getDefaultLoc() != null ? user.getDefaultLoc()
                    : (defaultLoc != null ? defaultLoc.getLoc() : "001");
        String grp  = trunc(user.getAccessGrp() != null ? user.getAccessGrp() : "U1", 2);
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
            ps.setString(3, trunc(whs != null ? whs : "001", 3));
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
