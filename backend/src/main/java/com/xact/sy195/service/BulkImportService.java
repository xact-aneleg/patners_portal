package com.xact.sy195.service;

import com.xact.sy195.dto.FilterDTOs.*;
import com.xact.sy195.model.*;
import com.xact.sy195.repository.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;

@Service
public class BulkImportService {

    private final Dl01Repository    dl01Repo;
    private final St01Repository    st01Repo;
    private final Cl01Repository    cl01Repo;
    private final Gl01Repository    gl01Repo;
    private final ValidationService validationService;

    public BulkImportService(Dl01Repository dl01Repo, St01Repository st01Repo,
                              Cl01Repository cl01Repo, Gl01Repository gl01Repo,
                              ValidationService validationService) {
        this.dl01Repo          = dl01Repo;
        this.st01Repo          = st01Repo;
        this.cl01Repo          = cl01Repo;
        this.gl01Repo          = gl01Repo;
        this.validationService = validationService;
    }

    // ── Header reader — reads from row 2 (index 2) which has real DB column names ──
    // Row 0 = defaults, Row 1 = types, Row 2 = column names, Row 3+ = data
    private Map<String, Integer> readHeaders(Sheet sheet) {
        Map<String, Integer> map = new LinkedHashMap<>();
        Row headerRow = sheet.getRow(2); // real column names in row 2
        if (headerRow == null) headerRow = sheet.getRow(0); // fallback
        if (headerRow == null) return map;
        for (Cell cell : headerRow) {
            String val = cell.getStringCellValue().trim().toLowerCase();
            if (!val.isBlank()) map.put(val, cell.getColumnIndex());
        }
        return map;
    }

    // ── Debtors — dl01_mast with real column names ────────────────────────────
    public ImportResponseDTO importDebtors(MultipartFile file) {
        ImportResponseDTO resp = new ImportResponseDTO();
        try (InputStream is = file.getInputStream(); Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> h = readHeaders(sheet);
            int startRow = 3; // data starts row 3

            for (int i = startRow; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null || isBlankRow(row)) continue;
                resp.setTotalRows(resp.getTotalRows() + 1);
                try {
                    // PK: dl_code VARCHAR(8) — required
                    String dlCode = str(row, h, "dl_code");
                    if (blank(dlCode)) { addErr(resp, i, "dl01_mast", "dl_code", "", "dl_code is required"); continue; }
                    dlCode = dlCode.trim().toUpperCase();
                    if (dlCode.length() > 8) dlCode = dlCode.substring(0, 8);

                    String codeErr = validationService.validate("dl_code", dlCode, "C", true);
                    if (codeErr != null) { addErr(resp, i, "dl01_mast", "dl_code", dlCode, codeErr); continue; }

                    Optional<Dl01Mast> existingDl = dl01Repo.findById(dlCode);
                    boolean isNew = !existingDl.isPresent();
                    Dl01Mast r = existingDl.orElse(new Dl01Mast());
                    r.setDlCode(dlCode);

                    // Mandatory: dl_name for new records
                    if (isNew && blank(str(row, h, "dl_name"))) { addErr(resp, i, "dl01_mast", "dl_name", dlCode, "dl_name is required for new records"); continue; }
                    // Enum: status
                    String dlStatusRaw = strDef(row, h, "status", "A").toUpperCase();
                    if (!dlStatusRaw.equals("A") && !dlStatusRaw.equals("I")) { addErr(resp, i, "dl01_mast", "status", dlCode, "status must be A or I, got: " + dlStatusRaw); continue; }
                    // Enum: cr_status
                    String crStatusRaw = strDef(row, h, "cr_status", "GOOD").toUpperCase();
                    if (!Set.of("GOOD","HOLD","COD").contains(crStatusRaw)) { addErr(resp, i, "dl01_mast", "cr_status", dlCode, "cr_status must be GOOD, HOLD or COD, got: " + crStatusRaw); continue; }
                    // Enum: master_acct
                    String dlMasterRaw = strDef(row, h, "master_acct", "N").toUpperCase();
                    if (!dlMasterRaw.equals("Y") && !dlMasterRaw.equals("N")) { addErr(resp, i, "dl01_mast", "master_acct", dlCode, "master_acct must be Y or N, got: " + dlMasterRaw); continue; }

                    // Real column names from xactdev_db schema
                    setStr(r::setDlName,          str(row, h, "dl_name"),           40);
                    setStr(r::setStatus,           dlStatusRaw,                       1);
                    setStr(r::setMasterAcct,       dlMasterRaw,                       1);
                    setStr(r::setAddressOnlyAcct,  strDef(row, h, "address_only_acct","N"), 1);
                    setStr(r::setLinkedAcct,       str(row, h, "linked_acct"),        8);
                    setStr(r::setLoc,              str(row, h, "loc"),                3);
                    setStr(r::setFilingCode,       str(row, h, "filing_code"),        8);
                    setStr(r::setTel1,             str(row, h, "tel_1"),             22);
                    setStr(r::setTel2,             str(row, h, "tel_2"),             22);
                    setStr(r::setFax1,             str(row, h, "fax_1"),             22);
                    setStr(r::setContact,          str(row, h, "contact"),           29);
                    setStr(r::setControlledBy,     str(row, h, "controlled_by"),     10);
                    setStr(r::setCoReg,            str(row, h, "co_reg"),            17);
                    setStr(r::setVatNo,            str(row, h, "vat_no"),            12);
                    setStr(r::setPostAdd1,         str(row, h, "post_add_1"),        30);
                    setStr(r::setPostAdd2,         str(row, h, "post_add_2"),        30);
                    setStr(r::setPostAdd3,         str(row, h, "post_add_3"),        30);
                    setStr(r::setPostAdd4,         str(row, h, "post_add_4"),        10);
                    setStr(r::setPostCode,         str(row, h, "post_code"),          4);
                    setStr(r::setPhyAdd1,          str(row, h, "phy_add_1"),         30);
                    setStr(r::setPhyAdd2,          str(row, h, "phy_add_2"),         30);
                    setStr(r::setPhyAdd3,          str(row, h, "phy_add_3"),         30);
                    setStr(r::setPhyAdd4,          str(row, h, "phy_add_4"),         20);
                    setStr(r::setDlCat,            str(row, h, "dl_cat"),             5);
                    setStr(r::setRegion,           str(row, h, "region"),             5);
                    setStr(r::setRepCode,          str(row, h, "rep_code"),           5);
                    setStr(r::setMktRep,           str(row, h, "mkt_rep"),            5);
                    setStr(r::setClassCode,        str(row, h, "class"),              3);
                    setStr(r::setCrStatus,         crStatusRaw,                       4);
                    setStr(r::setInvType,          str(row, h, "inv_type"),           1);
                    setStr(r::setTrackByForeignCurrency, str(row, h, "track_by_foreign_currency"), 1);

                    // Numeric fields
                    setBd(r::setSettDisc,          str(row, h, "sett_disc"));
                    setBd(r::setCrLimit,           str(row, h, "cr_limit"));
                    setBd(r::setMaxCrLimit,        str(row, h, "max_cr_limit"));
                    setInt(r::setTerms,            str(row, h, "terms"));

                    // Email validation
                    String email = str(row, h, "email");
                    if (!blank(email)) {
                        String emailErr = validationService.validate("email", email, "E", false);
                        if (emailErr != null) { addErr(resp, i, "dl01_mast", "email", dlCode, emailErr); continue; }
                        r.setEmail(email.length() > 80 ? email.substring(0, 80) : email);
                    }
                    setStr(r::setInvEmail,   str(row, h, "inv_email"),  80);
                    setStr(r::setStmtEmail,  str(row, h, "stmt_email"), 80);
                    setStr(r::setQtEmail,    str(row, h, "qt_email"),   80);

                    // Date
                    setDate(r::setOpenedDate, str(row, h, "opened_date"));

                    // Custom fields
                    setStr(r::setCustomField1,  str(row, h, "custom_field_1"),  20);
                    setStr(r::setCustomField2,  str(row, h, "custom_field_2"),  20);
                    setStr(r::setCustomField3,  str(row, h, "custom_field_3"),  20);
                    setStr(r::setCustomField4,  str(row, h, "custom_field_4"),  20);
                    setStr(r::setCustomField5,  str(row, h, "custom_field_5"),  20);

                    dl01Repo.save(r);
                    addOk(resp, i, "dl01_mast", dlCode);
                } catch (Exception e) {
                    addErr(resp, i, "dl01_mast", "?", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addErr(resp, 0, "dl01_mast", "file", "", "Cannot read file: " + e.getMessage());
        }
        return resp;
    }

    // ── Stock — st01_mast with real column names ──────────────────────────────
    public ImportResponseDTO importStock(MultipartFile file) {
        ImportResponseDTO resp = new ImportResponseDTO();
        try (InputStream is = file.getInputStream(); Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> h = readHeaders(sheet);

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null || isBlankRow(row)) continue;
                resp.setTotalRows(resp.getTotalRows() + 1);
                try {
                    String stkCode = str(row, h, "stk_code");
                    if (blank(stkCode)) { addErr(resp, i, "st01_mast", "stk_code", "", "stk_code is required"); continue; }
                    stkCode = stkCode.trim().toUpperCase();
                    if (stkCode.length() > 16) stkCode = stkCode.substring(0, 16);

                    String codeErr = validationService.validate("stk_code", stkCode, "C", true);
                    if (codeErr != null) { addErr(resp, i, "st01_mast", "stk_code", stkCode, codeErr); continue; }

                    Optional<St01Mast> existingSt = st01Repo.findById(stkCode);
                    boolean isNew = !existingSt.isPresent();
                    St01Mast r = existingSt.orElse(new St01Mast());
                    r.setStkCode(stkCode);

                    // Mandatory for new records: desc_1, stk_grp, uom
                    if (isNew && blank(str(row, h, "desc_1")))   { addErr(resp, i, "st01_mast", "desc_1",   stkCode, "desc_1 is required for new records"); continue; }
                    if (isNew && blank(str(row, h, "stk_grp"))) { addErr(resp, i, "st01_mast", "stk_grp", stkCode, "stk_grp is required for new records"); continue; }
                    if (isNew && blank(str(row, h, "uom")))      { addErr(resp, i, "st01_mast", "uom",      stkCode, "uom is required for new records"); continue; }
                    // Enum: status
                    String stStatusRaw = strDef(row, h, "status", "A").toUpperCase();
                    if (!stStatusRaw.equals("A") && !stStatusRaw.equals("I")) { addErr(resp, i, "st01_mast", "status", stkCode, "status must be A or I, got: " + stStatusRaw); continue; }
                    // Enum: vat_ind — S/Z/E/X/N/L/P/A
                    String vatIndRaw = strDef(row, h, "vat_ind", "S").toUpperCase();
                    if (!Set.of("S","Z","E","X","N","L","P","A").contains(vatIndRaw)) { addErr(resp, i, "st01_mast", "vat_ind", stkCode, "vat_ind must be S/Z/E/X/N/L/P/A, got: " + vatIndRaw); continue; }
                    // Enum: master_acct
                    String stMasterRaw = strDef(row, h, "master_acct", "N").toUpperCase();
                    if (!stMasterRaw.equals("Y") && !stMasterRaw.equals("N")) { addErr(resp, i, "st01_mast", "master_acct", stkCode, "master_acct must be Y or N, got: " + stMasterRaw); continue; }

                    // Real column names: desc_1 through desc_6
                    setStr(r::setDesc1,        str(row, h, "desc_1"),     40);
                    setStr(r::setDesc2,        str(row, h, "desc_2"),     40);
                    setStr(r::setDesc3,        str(row, h, "desc_3"),     40);
                    setStr(r::setDesc4,        str(row, h, "desc_4"),     40);
                    setStr(r::setDesc5,        str(row, h, "desc_5"),     40);
                    setStr(r::setDesc6,        str(row, h, "desc_6"),     40);
                    setStr(r::setBarcode,      str(row, h, "barcode"),    16);
                    setStr(r::setStatus,       stStatusRaw,                       1);
                    setStr(r::setMasterAcct,   stMasterRaw,                       1);
                    setStr(r::setLinkedTo,     str(row, h, "linked_to"),          16);
                    setStr(r::setWebEnabled,   strDef(row, h, "web_enabled","N"),    1);
                    setStr(r::setRetailEnabled,strDef(row, h, "retail_enabled","N"), 1);
                    setStr(r::setTradeInItem,  strDef(row, h, "trade_in_item","N"),  1);
                    setStr(r::setImportItem,   strDef(row, h, "import_item","N"),    1);
                    setStr(r::setKeepBal,      strDef(row, h, "keep_bal","Y"),       1);
                    setStr(r::setStkGrp,       str(row, h, "stk_grp"),            5);
                    setStr(r::setListGpCat,    str(row, h, "list_gp_cat"),        1);
                    setStr(r::setSerialTrack,  strDef(row, h, "serial_track","N"), 1);
                    setStr(r::setUom,          str(row, h, "uom"),         5);
                    setStr(r::setLineType,     str(row, h, "line_type"),   1);
                    setStr(r::setVatInd,       vatIndRaw,                     1);
                    setStr(r::setHsCode,       str(row, h, "hs_code"),    13);
                    setStr(r::setLevyCode,     str(row, h, "levy_code"),   6);

                    // gl_grp is INTEGER in real schema
                    setInt(r::setGlGrp,        str(row, h, "gl_grp"));
                    setInt(r::setReOrder,      str(row, h, "re_order"));
                    setInt(r::setReOrderPerc,  str(row, h, "re_order_perc"));

                    setBd(r::setUnitQty,       str(row, h, "unit_qty"));
                    setBd(r::setMass,          str(row, h, "mass"));
                    setBd(r::setLeadTime,      str(row, h, "lead_time"));

                    if (r.getCreateDate() == null) r.setCreateDate(LocalDate.now());

                    st01Repo.save(r);
                    addOk(resp, i, "st01_mast", stkCode);
                } catch (Exception e) {
                    addErr(resp, i, "st01_mast", "?", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addErr(resp, 0, "st01_mast", "file", "", "Cannot read file: " + e.getMessage());
        }
        return resp;
    }

    // ── Creditors — cl01_mast with real column names ──────────────────────────
    public ImportResponseDTO importCreditors(MultipartFile file) {
        ImportResponseDTO resp = new ImportResponseDTO();
        try (InputStream is = file.getInputStream(); Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> h = readHeaders(sheet);

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null || isBlankRow(row)) continue;
                resp.setTotalRows(resp.getTotalRows() + 1);
                try {
                    String clCode = str(row, h, "cl_code");
                    if (blank(clCode)) { addErr(resp, i, "cl01_mast", "cl_code", "", "cl_code is required"); continue; }
                    clCode = clCode.trim().toUpperCase();
                    if (clCode.length() > 8) clCode = clCode.substring(0, 8);

                    String codeErr = validationService.validate("cl_code", clCode, "C", true);
                    if (codeErr != null) { addErr(resp, i, "cl01_mast", "cl_code", clCode, codeErr); continue; }

                    Optional<Cl01Mast> existingCl = cl01Repo.findById(clCode);
                    boolean isNew = !existingCl.isPresent();
                    Cl01Mast r = existingCl.orElse(new Cl01Mast());
                    r.setClCode(clCode);

                    // Mandatory: cl_name for new records
                    if (isNew && blank(str(row, h, "cl_name"))) { addErr(resp, i, "cl01_mast", "cl_name", clCode, "cl_name is required for new records"); continue; }
                    // Enum: status
                    String clStatusRaw = strDef(row, h, "status", "A").toUpperCase();
                    if (!clStatusRaw.equals("A") && !clStatusRaw.equals("I")) { addErr(resp, i, "cl01_mast", "status", clCode, "status must be A or I, got: " + clStatusRaw); continue; }
                    // Enum: master_acct
                    String clMasterRaw = strDef(row, h, "master_acct", "N").toUpperCase();
                    if (!clMasterRaw.equals("Y") && !clMasterRaw.equals("N")) { addErr(resp, i, "cl01_mast", "master_acct", clCode, "master_acct must be Y or N, got: " + clMasterRaw); continue; }

                    setStr(r::setClName,        str(row, h, "cl_name"),     40);
                    setStr(r::setStatus,         clStatusRaw,                 1);
                    setStr(r::setMasterAcct,     clMasterRaw,                 1);
                    setStr(r::setLinkedAcct,     str(row, h, "linked_acct"),  8);
                    setStr(r::setTel1,           str(row, h, "tel_1"),        22);
                    setStr(r::setTel2,           str(row, h, "tel_2"),        22);
                    setStr(r::setFax1,           str(row, h, "fax_1"),        22);
                    setStr(r::setContact,        str(row, h, "contact"),      29);
                    setStr(r::setControlledBy,   str(row, h, "controlled_by"),10);
                    setStr(r::setSuppAcctCode,   str(row, h, "supp_acct_code"),15);
                    setStr(r::setVatNo,          str(row, h, "vat_no"),       12);
                    setStr(r::setCoReg,          str(row, h, "co_reg"),       17);
                    setStr(r::setPostAdd1,       str(row, h, "post_add_1"),   30);
                    setStr(r::setPostAdd2,       str(row, h, "post_add_2"),   30);
                    setStr(r::setPostAdd3,       str(row, h, "post_add_3"),   30);
                    setStr(r::setPostAdd4,       str(row, h, "post_add_4"),   10);
                    setStr(r::setPostCode,       str(row, h, "post_code"),     4);
                    setStr(r::setPhyAdd1,        str(row, h, "phy_add_1"),    30);
                    setStr(r::setPhyAdd2,        str(row, h, "phy_add_2"),    30);
                    setStr(r::setPhyAdd3,        str(row, h, "phy_add_3"),    30);
                    setStr(r::setClCat,          str(row, h, "cl_cat"),        5);
                    setStr(r::setIcAcct,         strDef(row, h, "ic_acct","N"), 1);
                    setStr(r::setImportAcct,     strDef(row, h, "import_acct","N"), 1);
                    setStr(r::setTrackByForeignCurrency, str(row, h, "track_by_foreign_currency"), 1);
                    // Bank details — real cl01_mast column names
                    setStr(r::setBankName,       str(row, h, "bank_name"),    20);
                    setStr(r::setBankCode,       str(row, h, "bank_code"),    15);
                    setStr(r::setBankBranchName, str(row, h, "bank_branch_name"), 20);
                    setStr(r::setBankBranchCode, str(row, h, "bank_branch_code"), 15);
                    setStr(r::setBankAcctType,   str(row, h, "bank_acct_type"), 2);
                    setStr(r::setBankAcctNo,     str(row, h, "bank_acct_no"), 35);

                    // Email
                    String email = str(row, h, "email");
                    if (!blank(email)) {
                        String emailErr = validationService.validate("email", email, "E", false);
                        if (emailErr != null) { addErr(resp, i, "cl01_mast", "email", clCode, emailErr); continue; }
                        r.setEmail(email.length() > 80 ? email.substring(0, 80) : email);
                    }
                    setStr(r::setPoEmail, str(row, h, "po_email"), 80);
                    setStr(r::setCrEmail, str(row, h, "cr_email"), 80);

                    setInt(r::setTerms,          str(row, h, "terms"));
                    setBd(r::setSettDisc,        str(row, h, "sett_disc"));
                    setBd(r::setCredLimit,       str(row, h, "cred_limit"));
                    setDate(r::setOpenedDate,    str(row, h, "opened_date"));

                    cl01Repo.save(r);
                    addOk(resp, i, "cl01_mast", clCode);
                } catch (Exception e) {
                    addErr(resp, i, "cl01_mast", "?", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addErr(resp, 0, "cl01_mast", "file", "", "Cannot read file: " + e.getMessage());
        }
        return resp;
    }

    // ── GL — gl01_mast with real column names ─────────────────────────────────
    public ImportResponseDTO importGl(MultipartFile file) {
        ImportResponseDTO resp = new ImportResponseDTO();
        try (InputStream is = file.getInputStream(); Workbook wb = new XSSFWorkbook(is)) {
            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> h = readHeaders(sheet);

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null || isBlankRow(row)) continue;
                resp.setTotalRows(resp.getTotalRows() + 1);
                try {
                    String glCode = str(row, h, "gl_code");
                    if (blank(glCode)) { addErr(resp, i, "gl01_mast", "gl_code", "", "gl_code is required"); continue; }
                    glCode = glCode.trim().toUpperCase();
                    if (glCode.length() > 8) glCode = glCode.substring(0, 8);

                    String codeErr = validationService.validate("gl_code", glCode, "C", true);
                    if (codeErr != null) { addErr(resp, i, "gl01_mast", "gl_code", glCode, codeErr); continue; }

                    Optional<Gl01Mast> existingGl = gl01Repo.findById(glCode);
                    boolean isNew = !existingGl.isPresent();
                    Gl01Mast r = existingGl.orElse(new Gl01Mast());
                    r.setGlCode(glCode);

                    // Mandatory: descr for new records
                    if (isNew && blank(str(row, h, "descr"))) { addErr(resp, i, "gl01_mast", "descr", glCode, "descr is required for new records"); continue; }
                    // Enum: status
                    String glStatusRaw = strDef(row, h, "status", "A").toUpperCase();
                    if (!glStatusRaw.equals("A") && !glStatusRaw.equals("I")) { addErr(resp, i, "gl01_mast", "status", glCode, "status must be A or I, got: " + glStatusRaw); continue; }
                    // Enum: acct_type B/P
                    String acctTypeRaw = strDef(row, h, "acct_type", "P").toUpperCase();
                    if (!acctTypeRaw.equals("B") && !acctTypeRaw.equals("P")) { addErr(resp, i, "gl01_mast", "acct_type", glCode, "acct_type must be B or P, got: " + acctTypeRaw); continue; }
                    // Enum: post P/S
                    String postRaw = strDef(row, h, "post", "P").toUpperCase();
                    if (!postRaw.equals("P") && !postRaw.equals("S")) { addErr(resp, i, "gl01_mast", "post", glCode, "post must be P or S, got: " + postRaw); continue; }

                    // Real column name is "descr" not "description"
                    setStr(r::setDescr,         str(row, h, "descr"),         40);
                    setStr(r::setStatus,         glStatusRaw,                   1);
                    setStr(r::setAcctType,       acctTypeRaw,                   1);
                    setStr(r::setPost,           postRaw,                       1);
                    setStr(r::setControl,        str(row, h, "control"),       8);
                    setStr(r::setDetailTrans,    str(row, h, "detail_trans"),  1);
                    setStr(r::setLocAnal,        str(row, h, "loc_anal"),      1);
                    setStr(r::setBudget,         str(row, h, "budget"),        1);
                    setStr(r::setBudgetBasedOn,  strDef(row, h, "budget_based_on","S"), 1);
                    setStr(r::setInterfaceAcct,  str(row, h, "interface_acct"), 1);
                    setStr(r::setBlockPosting,   str(row, h, "block_posting"),  1);

                    gl01Repo.save(r);
                    addOk(resp, i, "gl01_mast", glCode);
                } catch (Exception e) {
                    addErr(resp, i, "gl01_mast", "?", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addErr(resp, 0, "gl01_mast", "file", "", "Cannot read file: " + e.getMessage());
        }
        return resp;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private String str(Row row, Map<String, Integer> h, String col) {
        Integer idx = h.get(col);
        if (idx == null) return null;
        Cell cell = row.getCell(idx, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
        if (cell == null) return null;
        return switch (cell.getCellType()) {
            case STRING  -> cell.getStringCellValue().trim();
            case NUMERIC -> {
                double d = cell.getNumericCellValue();
                yield d == Math.floor(d) ? String.valueOf((long) d) : String.valueOf(d);
            }
            case BOOLEAN -> String.valueOf(cell.getBooleanCellValue());
            default -> null;
        };
    }

    private String strDef(Row row, Map<String, Integer> h, String col, String def) {
        String v = str(row, h, col);
        return (v == null || v.isBlank()) ? def : v;
    }

    private boolean blank(String s) { return s == null || s.isBlank(); }

    private boolean isBlankRow(Row row) {
        for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
            Cell cell = row.getCell(c);
            if (cell != null && cell.getCellType() != CellType.BLANK) return false;
        }
        return true;
    }

    private void setStr(java.util.function.Consumer<String> setter, String val, int maxLen) {
        if (val == null || val.isBlank()) return;
        setter.accept(val.length() > maxLen ? val.substring(0, maxLen) : val);
    }

    private void setBd(java.util.function.Consumer<BigDecimal> setter, String val) {
        if (blank(val)) return;
        try { setter.accept(new BigDecimal(val.replace(",", "."))); } catch (Exception ignored) {}
    }

    private void setInt(java.util.function.Consumer<Integer> setter, String val) {
        if (blank(val)) return;
        try { setter.accept((int) Double.parseDouble(val)); } catch (Exception ignored) {}
    }

    private void setDate(java.util.function.Consumer<LocalDate> setter, String val) {
        if (blank(val)) return;
        try { setter.accept(LocalDate.parse(val)); } catch (Exception ignored) {}
    }

    private void addOk(ImportResponseDTO resp, int row, String tbl, String key) {
        resp.getResults().add(new ImportResultDTO(row + 1, tbl, tbl.split("_")[0] + "_code", key, "Saved", "OK"));
        resp.setImported(resp.getImported() + 1);
    }

    private void addErr(ImportResponseDTO resp, int row, String tbl, String field, String key, String msg) {
        resp.getResults().add(new ImportResultDTO(row + 1, tbl, field, key, msg, "ERROR"));
        resp.setErrors(resp.getErrors() + 1);
    }
}
