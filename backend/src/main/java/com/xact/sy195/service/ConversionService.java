package com.xact.sy195.service;

import com.xact.sy195.dto.ConversionConfigDTO;
import com.xact.sy195.dto.FilterDTOs.ImportResponseDTO;
import com.xact.sy195.dto.FilterDTOs.ImportResultDTO;
import com.xact.sy195.model.*;
import com.xact.sy195.repository.*;
import jakarta.persistence.EntityManager;
import jakarta.transaction.Transactional;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.time.LocalDate;
import java.util.*;

@Service
public class ConversionService {

    private final Dl01Repository dl01Repo;
    private final St01Repository st01Repo;
    private final Cl01Repository cl01Repo;
    private final Gl01Repository gl01Repo;
    private final ExcelService excelService;
    private final EntityManager em;
    private final ValidationService validationService;

    public ConversionService(Dl01Repository dl01Repo, St01Repository st01Repo,
                             Cl01Repository cl01Repo, Gl01Repository gl01Repo,
                             ExcelService excelService, EntityManager em,
                             ValidationService validationService) {
        this.dl01Repo          = dl01Repo;
        this.st01Repo          = st01Repo;
        this.cl01Repo          = cl01Repo;
        this.gl01Repo          = gl01Repo;
        this.excelService      = excelService;
        this.em                = em;
        this.validationService = validationService;
    }

    // ── Row count ─────────────────────────────────────────────────────────────

    public long getCount(String module) {
        return switch (module) {
            case "debtors"   -> dl01Repo.count();
            case "stock"     -> st01Repo.count();
            case "creditors" -> cl01Repo.count();
            case "gl"        -> gl01Repo.count();
            default -> 0L;
        };
    }

    // ── Full export (no filters) ──────────────────────────────────────────────

    public byte[] exportFull(String module) {
        return switch (module) {
            case "debtors"   -> excelService.exportToXlsx("dl01_mast",
                    dl01Repo.findAll(org.springframework.data.domain.Sort.by("dlCode")));
            case "stock"     -> excelService.exportToXlsx("st01_mast",
                    st01Repo.findAll(org.springframework.data.domain.Sort.by("stkCode")));
            case "creditors" -> excelService.exportToXlsx("cl01_mast",
                    cl01Repo.findAll(org.springframework.data.domain.Sort.by("clCode")));
            case "gl"        -> excelService.exportToXlsx("gl01_mast",
                    gl01Repo.findAll(org.springframework.data.domain.Sort.by("glCode")));
            default -> throw new IllegalArgumentException("Unknown module: " + module);
        };
    }

    // ── Conversion import (optionally empty table first) ─────────────────────

    @Transactional
    public ImportResponseDTO conversionImport(ConversionConfigDTO config, MultipartFile file) {
        if (config.isEmptyTable()) {
            truncateTable(config.getModule());
        }
        return switch (config.getModule()) {
            case "debtors"   -> importDebtorsFull(file);
            case "stock"     -> importStockFull(file);
            case "creditors" -> importCreditorsFull(file);
            case "gl"        -> importGlFull(file);
            default -> throw new IllegalArgumentException("Unknown module: " + config.getModule());
        };
    }

    // ── Truncate ──────────────────────────────────────────────────────────────

    private void truncateTable(String module) {
        String table = switch (module) {
            case "debtors"   -> "dl01_mast";
            case "stock"     -> "st01_mast";
            case "creditors" -> "cl01_mast";
            case "gl"        -> "gl01_mast";
            default -> throw new IllegalArgumentException("Unknown module: " + module);
        };
        em.createNativeQuery("TRUNCATE TABLE " + table).executeUpdate();
    }

    // ── Debtor full import ────────────────────────────────────────────────────

    private ImportResponseDTO importDebtorsFull(MultipartFile file) {
        ImportResponseDTO response = new ImportResponseDTO();
        try (InputStream is = file.getInputStream();
             Workbook wb = new XSSFWorkbook(is)) {

            Sheet sheet = wb.getSheetAt(0);
            // Row 0=defaults, Row 1=types, Row 2=column names, Row 3+=data (matches ExcelService 3-row header)
            Map<String, Integer> headers = readHeaders(sheet.getRow(2));

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (isBlankRow(row)) continue;
                response.setTotalRows(response.getTotalRows() + 1);
                try {
                    String dlCode = getCellString(row, headers.get("dl_code"));
                    if (dlCode == null || dlCode.isBlank()) {
                        addError(response, i + 1, "dl01_mast", "dl_code", "", "dl_code cannot be blank");
                        continue;
                    }
                    String dlErr = validationService.validate("dl_code", dlCode, "C", true);
                    if (dlErr != null) { addError(response, i + 1, "dl01_mast", "dl_code", dlCode, dlErr); continue; }
                    Dl01Mast rec = dl01Repo.findById(dlCode).orElse(new Dl01Mast());
                    rec.setDlCode(dlCode);
                    mapString(rec::setDlName, row, headers, "dl_name");
                    mapString(rec::setPostAdd1, row, headers, "post_add_1");
                    mapString(rec::setPostAdd2, row, headers, "post_add_2");
                    mapString(rec::setPostAdd3, row, headers, "post_add_3");
                    mapString(rec::setPostAdd4, row, headers, "post_add_4");
                    mapString(rec::setPostCode, row, headers, "post_code");
                    mapString(rec::setLoc,                   row, headers, "loc");
                    mapString(rec::setTel1, row, headers, "tel_1");
                    mapString(rec::setFax1, row, headers, "fax_1");
                    mapString(rec::setEmail,                 row, headers, "email");
                    mapString(rec::setContact,               row, headers, "contact");
                    mapString(rec::setRepCode,               row, headers, "rep_code");
                    mapString(rec::setMktRep,                row, headers, "mkt_rep");
                    mapString(rec::setDlCat,                 row, headers, "dl_cat");
                    mapString(rec::setClassCode, row, headers, "class");
                    mapString(rec::setControlledBy,          row, headers, "controlled_by");
                    mapString(rec::setMasterAcct,            row, headers, "master_acct");
                    mapString(rec::setLinkedAcct, row, headers, "linked_acct");
                    mapString(rec::setAddressOnlyAcct,       row, headers, "address_only_acct");
                    mapString(rec::setCrStatus,              row, headers, "cr_status");
                    mapString(rec::setInvType,               row, headers, "inv_type");
                    mapString(rec::setStatus,                row, headers, "status");
                    mapString(rec::setTrackByForeignCurrency,row, headers, "track_by_foreign_currency");
                    
                    dl01Repo.save(rec);
                    addOk(response, i + 1, "dl01_mast", "dl_code", dlCode);
                } catch (Exception e) {
                    addError(response, i + 1, "dl01_mast", "unknown", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addError(response, 0, "dl01_mast", "file", "", "Failed to read file: " + e.getMessage());
        }
        return response;
    }

    // ── Stock full import ─────────────────────────────────────────────────────

    private ImportResponseDTO importStockFull(MultipartFile file) {
        ImportResponseDTO response = new ImportResponseDTO();
        try (InputStream is = file.getInputStream();
             Workbook wb = new XSSFWorkbook(is)) {

            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> headers = readHeaders(sheet.getRow(2));

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (isBlankRow(row)) continue;
                response.setTotalRows(response.getTotalRows() + 1);
                try {
                    String stkCode = getCellString(row, headers.get("stk_code"));
                    if (stkCode == null || stkCode.isBlank()) {
                        addError(response, i + 1, "st01_mast", "stk_code", "", "stk_code cannot be blank");
                        continue;
                    }
                    String stkErr = validationService.validate("stk_code", stkCode, "C", true);
                    if (stkErr != null) { addError(response, i + 1, "st01_mast", "stk_code", stkCode, stkErr); continue; }
                    St01Mast rec = st01Repo.findById(stkCode).orElse(new St01Mast());
                    rec.setStkCode(stkCode);
                    mapString(rec::setDesc1,         row, headers, "desc_1");
                    mapString(rec::setDesc2,         row, headers, "desc_2");
                    mapString(rec::setStkGrp,        row, headers, "stk_grp");
                    String glGrpVal = getCellString(row, headers.get("gl_grp")); if (glGrpVal != null && !glGrpVal.isBlank()) { try { rec.setGlGrp((int)Double.parseDouble(glGrpVal)); } catch (Exception ignored) {} }
                    mapString(rec::setUom,           row, headers, "uom");
                    mapString(rec::setKeepBal,       row, headers, "keep_bal");
                    mapString(rec::setSerialTrack,   row, headers, "serial_track");
                    mapString(rec::setStatus,        row, headers, "status");
                    mapString(rec::setWebEnabled,    row, headers, "web_enabled");
                    mapString(rec::setRetailEnabled, row, headers, "retail_enabled");
                    mapString(rec::setTradeInItem,   row, headers, "trade_in_item");
                    mapString(rec::setImportItem,    row, headers, "import_item");
                    mapString(rec::setVatInd,        row, headers, "vat_ind");
                    mapString(rec::setListGpCat,     row, headers, "list_gp_cat");
                    mapString(rec::setLineType,      row, headers, "line_type");
                    mapString(rec::setMasterAcct,    row, headers, "master_acct");
                    mapString(rec::setLinkedTo,   row, headers, "linked_to");
                    
                    st01Repo.save(rec);
                    addOk(response, i + 1, "st01_mast", "stk_code", stkCode);
                } catch (Exception e) {
                    addError(response, i + 1, "st01_mast", "unknown", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addError(response, 0, "st01_mast", "file", "", "Failed to read file: " + e.getMessage());
        }
        return response;
    }

    // ── Creditor full import ──────────────────────────────────────────────────

    private ImportResponseDTO importCreditorsFull(MultipartFile file) {
        ImportResponseDTO response = new ImportResponseDTO();
        try (InputStream is = file.getInputStream();
             Workbook wb = new XSSFWorkbook(is)) {

            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> headers = readHeaders(sheet.getRow(2));

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (isBlankRow(row)) continue;
                response.setTotalRows(response.getTotalRows() + 1);
                try {
                    String clCode = getCellString(row, headers.get("cl_code"));
                    if (clCode == null || clCode.isBlank()) {
                        addError(response, i + 1, "cl01_mast", "cl_code", "", "cl_code cannot be blank");
                        continue;
                    }
                    String clErr = validationService.validate("cl_code", clCode, "C", true);
                    if (clErr != null) { addError(response, i + 1, "cl01_mast", "cl_code", clCode, clErr); continue; }
                    Cl01Mast rec = cl01Repo.findById(clCode).orElse(new Cl01Mast());
                    rec.setClCode(clCode);
                    mapString(rec::setClName, row, headers, "cl_name");
                    mapString(rec::setPostAdd1, row, headers, "post_add_1");
                    mapString(rec::setPostAdd2, row, headers, "post_add_2");
                    mapString(rec::setPostAdd3, row, headers, "post_add_3");
                    mapString(rec::setPostCode, row, headers, "post_code");
                    mapString(rec::setTel1, row, headers, "tel_1");
                    mapString(rec::setEmail,                  row, headers, "email");
                    mapString(rec::setContact,                row, headers, "contact");
                    mapString(rec::setClCat,                  row, headers, "cl_cat");
                    mapString(rec::setControlledBy,           row, headers, "controlled_by");
                    mapString(rec::setMasterAcct,             row, headers, "master_acct");
                    mapString(rec::setLinkedAcct, row, headers, "linked_acct");
                    mapString(rec::setStatus,                 row, headers, "status");
                    mapString(rec::setTrackByForeignCurrency, row, headers, "track_by_foreign_currency");
                    mapString(rec::setIcAcct, row, headers, "ic_acct");
                    mapString(rec::setImportAcct,             row, headers, "import_acct");
                    
                    cl01Repo.save(rec);
                    addOk(response, i + 1, "cl01_mast", "cl_code", clCode);
                } catch (Exception e) {
                    addError(response, i + 1, "cl01_mast", "unknown", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addError(response, 0, "cl01_mast", "file", "", "Failed to read file: " + e.getMessage());
        }
        return response;
    }

    // ── GL full import ────────────────────────────────────────────────────────

    private ImportResponseDTO importGlFull(MultipartFile file) {
        ImportResponseDTO response = new ImportResponseDTO();
        try (InputStream is = file.getInputStream();
             Workbook wb = new XSSFWorkbook(is)) {

            Sheet sheet = wb.getSheetAt(0);
            Map<String, Integer> headers = readHeaders(sheet.getRow(2));

            for (int i = 3; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (isBlankRow(row)) continue;
                response.setTotalRows(response.getTotalRows() + 1);
                try {
                    String glCode = getCellString(row, headers.get("gl_code"));
                    if (glCode == null || glCode.isBlank()) {
                        addError(response, i + 1, "gl01_mast", "gl_code", "", "gl_code cannot be blank");
                        continue;
                    }
                    String glErr = validationService.validate("gl_code", glCode, "C", true);
                    if (glErr != null) { addError(response, i + 1, "gl01_mast", "gl_code", glCode, glErr); continue; }
                    Gl01Mast rec = gl01Repo.findById(glCode).orElse(new Gl01Mast());
                    rec.setGlCode(glCode);
                    mapString(rec::setDescr, row, headers, "descr");
                    mapString(rec::setAcctType,     row, headers, "acct_type");
                    mapString(rec::setPost,         row, headers, "post");
                    mapString(rec::setStatus,       row, headers, "status");
                    mapString(rec::setBudgetBasedOn,row, headers, "budget_based_on");
                    
                    gl01Repo.save(rec);
                    addOk(response, i + 1, "gl01_mast", "gl_code", glCode);
                } catch (Exception e) {
                    addError(response, i + 1, "gl01_mast", "unknown", "", e.getMessage());
                }
            }
        } catch (Exception e) {
            addError(response, 0, "gl01_mast", "file", "", "Failed to read file: " + e.getMessage());
        }
        return response;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private Map<String, Integer> readHeaders(Row headerRow) {
        Map<String, Integer> map = new LinkedHashMap<>();
        if (headerRow == null) return map;
        for (Cell cell : headerRow) {
            map.put(cell.getStringCellValue().trim().toLowerCase(), cell.getColumnIndex());
        }
        return map;
    }

    private void mapString(java.util.function.Consumer<String> setter,
                           Row row, Map<String, Integer> headers, String col) {
        if (headers.containsKey(col)) {
            String val = getCellString(row, headers.get(col));
            if (val != null) setter.accept(val);
        }
    }

    private String getCellString(Row row, Integer colIdx) {
        if (colIdx == null) return null;
        Cell cell = row.getCell(colIdx, Row.MissingCellPolicy.RETURN_BLANK_AS_NULL);
        if (cell == null) return null;
        return switch (cell.getCellType()) {
            case STRING  -> cell.getStringCellValue().trim();
            case NUMERIC -> {
                double d = cell.getNumericCellValue();
                yield d == Math.floor(d) ? String.valueOf((long) d) : String.valueOf(d);
            }
            case BOOLEAN -> String.valueOf(cell.getBooleanCellValue());
            default      -> null;
        };
    }

    private boolean isBlankRow(Row row) {
        if (row == null) return true;
        for (Cell cell : row) {
            if (cell != null && cell.getCellType() != CellType.BLANK) return false;
        }
        return true;
    }

    private void addOk(ImportResponseDTO r, int row, String tbl, String field, String key) {
        r.getResults().add(new ImportResultDTO(row, tbl, field, key, "Record saved successfully", "OK"));
        r.setImported(r.getImported() + 1);
    }

    private void addError(ImportResponseDTO r, int row, String tbl, String field, String key, String msg) {
        r.getResults().add(new ImportResultDTO(row, tbl, field, key, msg, "ERROR"));
        r.setErrors(r.getErrors() + 1);
    }
}
