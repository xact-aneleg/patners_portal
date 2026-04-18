package com.xact.sy195.service;

import com.xact.sy195.model.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.*;

@Service
public class ExcelService {

    // ── Column metadata per table: fieldName -> [dataType, defaultValue, headerLabel] ──
    // Matches the REAL xactdev_db schema exactly

    private static final LinkedHashMap<String, String[]> DL01_COLS = new LinkedHashMap<>() {{
        put("dlCode",       new String[]{"C(8)",   "",       "dl_code"});
        put("dlName",       new String[]{"D(40)",  "",       "dl_name"});
        put("status",       new String[]{"C(1)",   "A",      "status"});
        put("masterAcct",   new String[]{"C(1)",   "N",      "master_acct"});
        put("addressOnlyAcct", new String[]{"C(1)","N",      "address_only_acct"});
        put("linkedAcct",   new String[]{"C(8)",   "",       "linked_acct"});
        put("loc",          new String[]{"C(3)",   "",       "loc"});
        put("tel1",         new String[]{"C(22)",  "",       "tel_1"});
        put("tel2",         new String[]{"C(22)",  "",       "tel_2"});
        put("fax1",         new String[]{"C(22)",  "",       "fax_1"});
        put("contact",      new String[]{"D(29)",  "",       "contact"});
        put("controlledBy", new String[]{"C(10)",  "",       "controlled_by"});
        put("coReg",        new String[]{"C(17)",  "",       "co_reg"});
        put("vatNo",        new String[]{"C(12)",  "",       "vat_no"});
        put("postAdd1",     new String[]{"D(30)",  "",       "post_add_1"});
        put("postAdd2",     new String[]{"D(30)",  "",       "post_add_2"});
        put("postAdd3",     new String[]{"D(30)",  "",       "post_add_3"});
        put("postAdd4",     new String[]{"D(10)",  "",       "post_add_4"});
        put("postCode",     new String[]{"C(4)",   "",       "post_code"});
        put("phyAdd1",      new String[]{"D(30)",  "",       "phy_add_1"});
        put("phyAdd2",      new String[]{"D(30)",  "",       "phy_add_2"});
        put("phyAdd3",      new String[]{"D(30)",  "",       "phy_add_3"});
        put("dlCat",        new String[]{"C(5)",   "",       "dl_cat"});
        put("region",       new String[]{"C(5)",   "",       "region"});
        put("repCode",      new String[]{"C(5)",   "",       "rep_code"});
        put("mktRep",       new String[]{"C(5)",   "",       "mkt_rep"});
        put("classCode",    new String[]{"C(3)",   "",       "class"});
        put("crStatus",     new String[]{"C(4)",   "GOOD",   "cr_status"});
        put("terms",        new String[]{"N",      "0",      "terms"});
        put("settDisc",     new String[]{"N(7,2)", "0",      "sett_disc"});
        put("crLimit",      new String[]{"N(13,2)","0",      "cr_limit"});
        put("maxCrLimit",   new String[]{"N(13,2)","0",      "max_cr_limit"});
        put("email",        new String[]{"E(80)",  "",       "email"});
        put("invEmail",     new String[]{"E(80)",  "",       "inv_email"});
        put("stmtEmail",    new String[]{"E(80)",  "",       "stmt_email"});
        put("balance",      new String[]{"N(13,2)","0",      "balance"});
        put("invType",      new String[]{"C(1)",   "",       "inv_type"});
        put("trackByForeignCurrency", new String[]{"C(1)", "N", "track_by_foreign_currency"});
        put("openedDate",   new String[]{"D",      "",       "opened_date"});
        put("customField1", new String[]{"D(20)",  "",       "custom_field_1"});
        put("customField2", new String[]{"D(20)",  "",       "custom_field_2"});
        put("customField3", new String[]{"D(20)",  "",       "custom_field_3"});
        put("customField4", new String[]{"D(20)",  "",       "custom_field_4"});
        put("customField5", new String[]{"D(20)",  "",       "custom_field_5"});
    }};

    private static final LinkedHashMap<String, String[]> ST01_COLS = new LinkedHashMap<>() {{
        put("stkCode",      new String[]{"C(16)", "",    "stk_code"});
        put("desc1",        new String[]{"D(40)", "",    "desc_1"});
        put("desc2",        new String[]{"D(40)", "",    "desc_2"});
        put("desc3",        new String[]{"D(40)", "",    "desc_3"});
        put("barcode",      new String[]{"C(16)", "",    "barcode"});
        put("status",       new String[]{"C(1)",  "A",   "status"});
        put("masterAcct",   new String[]{"C(1)",  "N",   "master_acct"});
        put("linkedTo",     new String[]{"C(16)", "",    "linked_to"});
        put("webEnabled",   new String[]{"C(1)",  "N",   "web_enabled"});
        put("retailEnabled",new String[]{"C(1)",  "N",   "retail_enabled"});
        put("tradeInItem",  new String[]{"C(1)",  "N",   "trade_in_item"});
        put("importItem",   new String[]{"C(1)",  "N",   "import_item"});
        put("keepBal",      new String[]{"C(1)",  "Y",   "keep_bal"});
        put("stkGrp",       new String[]{"C(5)",  "",    "stk_grp"});
        put("glGrp",        new String[]{"N",     "0",   "gl_grp"});
        put("serialTrack",  new String[]{"C(1)",  "N",   "serial_track"});
        put("uom",          new String[]{"C(5)",  "",    "uom"});
        put("unitQty",      new String[]{"N(11,3)","1",  "unit_qty"});
        put("mass",         new String[]{"N(11,3)","0",  "mass"});
        put("leadTime",     new String[]{"N(5,2)", "0",  "lead_time"});
        put("lineType",     new String[]{"C(1)",  "",    "line_type"});
        put("reOrder",      new String[]{"N",     "0",   "re_order"});
        put("vatInd",       new String[]{"C(1)",  "S",   "vat_ind"});
        put("createDate",   new String[]{"D",     "",    "create_date"});
    }};

    private static final LinkedHashMap<String, String[]> CL01_COLS = new LinkedHashMap<>() {{
        put("clCode",       new String[]{"C(8)",   "",     "cl_code"});
        put("clName",       new String[]{"D(40)",  "",     "cl_name"});
        put("status",       new String[]{"C(1)",   "A",    "status"});
        put("masterAcct",   new String[]{"C(1)",   "N",    "master_acct"});
        put("linkedAcct",   new String[]{"C(8)",   "",     "linked_acct"});
        put("tel1",         new String[]{"C(22)",  "",     "tel_1"});
        put("tel2",         new String[]{"C(22)",  "",     "tel_2"});
        put("email",        new String[]{"E(80)",  "",     "email"});
        put("poEmail",      new String[]{"E(80)",  "",     "po_email"});
        put("contact",      new String[]{"D(29)",  "",     "contact"});
        put("vatNo",        new String[]{"C(12)",  "",     "vat_no"});
        put("coReg",        new String[]{"C(17)",  "",     "co_reg"});
        put("postAdd1",     new String[]{"D(30)",  "",     "post_add_1"});
        put("postAdd2",     new String[]{"D(30)",  "",     "post_add_2"});
        put("postAdd3",     new String[]{"D(30)",  "",     "post_add_3"});
        put("postAdd4",     new String[]{"D(10)",  "",     "post_add_4"});
        put("postCode",     new String[]{"C(4)",   "",     "post_code"});
        put("phyAdd1",      new String[]{"D(30)",  "",     "phy_add_1"});
        put("phyAdd2",      new String[]{"D(30)",  "",     "phy_add_2"});
        put("phyAdd3",      new String[]{"D(30)",  "",     "phy_add_3"});
        put("clCat",        new String[]{"C(5)",   "",     "cl_cat"});
        put("terms",        new String[]{"N",      "0",    "terms"});
        put("settDisc",     new String[]{"N(7,2)", "0",    "sett_disc"});
        put("credLimit",    new String[]{"N(13,0)","0",    "cred_limit"});
        put("bankName",     new String[]{"D(20)",  "",     "bank_name"});
        put("bankBranchCode",new String[]{"C(15)", "",     "bank_branch_code"});
        put("bankAcctNo",   new String[]{"C(35)",  "",     "bank_acct_no"});
        put("trackByForeignCurrency",new String[]{"C(1)","N","track_by_foreign_currency"});
        put("importAcct",   new String[]{"C(1)",   "N",    "import_acct"});
        put("icAcct",       new String[]{"C(1)",   "N",    "ic_acct"});
        put("balance",      new String[]{"N(13,2)","0",    "balance"});
        put("openedDate",   new String[]{"D",      "",     "opened_date"});
    }};

    private static final LinkedHashMap<String, String[]> GL01_COLS = new LinkedHashMap<>() {{
        put("glCode",       new String[]{"C(8)",  "",  "gl_code"});
        put("descr",        new String[]{"D(40)", "",  "descr"});
        put("status",       new String[]{"C(1)",  "A", "status"});
        put("acctType",     new String[]{"C(1)",  "P", "acct_type"});
        put("post",         new String[]{"C(1)",  "P", "post"});
        put("control",      new String[]{"C(8)",  "",  "control"});
        put("detailTrans",  new String[]{"C(1)",  "",  "detail_trans"});
        put("locAnal",      new String[]{"C(1)",  "",  "loc_anal"});
        put("budget",       new String[]{"C(1)",  "",  "budget"});
        put("budgetBasedOn",new String[]{"C(1)",  "S", "budget_based_on"});
        put("interfaceAcct",new String[]{"C(1)",  "",  "interface_acct"});
        put("blockPosting", new String[]{"C(1)",  "",  "block_posting"});
    }};

    private LinkedHashMap<String, String[]> metaFor(String module) {
        return switch (module) {
            case "debtors"   -> DL01_COLS;
            case "stock"     -> ST01_COLS;
            case "creditors" -> CL01_COLS;
            case "gl"        -> GL01_COLS;
            default -> throw new IllegalArgumentException("Unknown module: " + module);
        };
    }

    private String tableToModule(String table) {
        return switch (table) {
            case "dl01_mast" -> "debtors";
            case "st01_mast" -> "stock";
            case "cl01_mast" -> "creditors";
            case "gl01_mast" -> "gl";
            default -> throw new IllegalArgumentException("Unknown table: " + table);
        };
    }

    // ── Export ────────────────────────────────────────────────────────────────
    public <T> byte[] exportToXlsx(String tableName, java.util.List<T> rows) {
        String module = tableToModule(tableName);
        LinkedHashMap<String, String[]> meta = metaFor(module);
        String[] fields = meta.keySet().toArray(new String[0]);

        try (XSSFWorkbook wb = new XSSFWorkbook()) {
            XSSFSheet sheet = wb.createSheet(tableName);

            // Styles
            CellStyle defaultStyle = createHeaderStyle(wb, new byte[]{(byte)0x3D,(byte)0x51,(byte)0x66});
            CellStyle typeStyle    = createHeaderStyle(wb, new byte[]{(byte)0x54,(byte)0x6E,(byte)0x7A});
            CellStyle headerStyle  = createHeaderStyle(wb, new byte[]{(byte)0x2E,(byte)0x3D,(byte)0x4D});

            // Row 0: Default values
            Row r0 = sheet.createRow(0);
            createCell(r0, 0, "Default", defaultStyle);
            for (int i = 0; i < fields.length; i++)
                createCell(r0, i+1, meta.get(fields[i])[1], defaultStyle);

            // Row 1: Data Type(size)
            Row r1 = sheet.createRow(1);
            createCell(r1, 0, "Data Type(size)", typeStyle);
            for (int i = 0; i < fields.length; i++)
                createCell(r1, i+1, meta.get(fields[i])[0], typeStyle);

            // Row 2: Column headers (using real DB column names)
            Row r2 = sheet.createRow(2);
            createCell(r2, 0, " ", headerStyle);
            for (int i = 0; i < fields.length; i++)
                createCell(r2, i+1, meta.get(fields[i])[2], headerStyle);

            // Data rows from row 3
            for (int ri = 0; ri < rows.size(); ri++) {
                Row row = sheet.createRow(ri + 3);
                createCell(row, 0, String.valueOf(ri + 1), null);
                T obj = rows.get(ri);
                for (int ci = 0; ci < fields.length; ci++) {
                    Object val = getField(obj, fields[ci]);
                    createCell(row, ci + 1, val != null ? val.toString() : "", null);
                }
            }

            // Auto-size first 5 columns
            for (int i = 0; i <= Math.min(5, fields.length); i++) sheet.autoSizeColumn(i);

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            wb.write(out);
            return out.toByteArray();
        } catch (Exception e) { throw new RuntimeException("Export failed: " + e.getMessage(), e); }
    }

    // ── Template ──────────────────────────────────────────────────────────────
    public byte[] generateTemplate(String module) {
        LinkedHashMap<String, String[]> meta = metaFor(module);
        String[] fields = meta.keySet().toArray(new String[0]);
        String tableName = switch(module) {
            case "debtors"->"dl01_mast"; case "stock"->"st01_mast";
            case "creditors"->"cl01_mast"; case "gl"->"gl01_mast"; default->module;
        };

        try (XSSFWorkbook wb = new XSSFWorkbook()) {
            XSSFSheet sheet = wb.createSheet(tableName);
            CellStyle s0 = createHeaderStyle(wb, new byte[]{(byte)0x3D,(byte)0x51,(byte)0x66});
            CellStyle s1 = createHeaderStyle(wb, new byte[]{(byte)0x54,(byte)0x6E,(byte)0x7A});
            CellStyle s2 = createHeaderStyle(wb, new byte[]{(byte)0x2E,(byte)0x3D,(byte)0x4D});
            Row r0 = sheet.createRow(0); createCell(r0,0,"Default",s0);
            Row r1 = sheet.createRow(1); createCell(r1,0,"Data Type(size)",s1);
            Row r2 = sheet.createRow(2); createCell(r2,0," ",s2);
            for (int i=0;i<fields.length;i++) {
                createCell(r0,i+1,meta.get(fields[i])[1],s0);
                createCell(r1,i+1,meta.get(fields[i])[0],s1);
                createCell(r2,i+1,meta.get(fields[i])[2],s2);
            }
            sheet.createRow(3); // blank data row
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            wb.write(out); return out.toByteArray();
        } catch (Exception e) { throw new RuntimeException("Template failed",e); }
    }

    // ── Helpers ───────────────────────────────────────────────────────────────
    private CellStyle createHeaderStyle(XSSFWorkbook wb, byte[] rgb) {
        XSSFCellStyle style = wb.createCellStyle();
        XSSFColor color = new XSSFColor(rgb, new org.apache.poi.xssf.usermodel.extensions.XSSFCellBorder.BorderSide[0].getClass().cast(null) == null ? null : null);
        color = new XSSFColor(rgb, null);
        style.setFillForegroundColor(color);
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        XSSFFont font = wb.createFont();
        font.setColor(new XSSFColor(new byte[]{(byte)0xFF,(byte)0xFF,(byte)0xFF}, null));
        font.setBold(true); font.setFontName("Arial"); font.setFontHeightInPoints((short)10);
        style.setFont(font);
        return style;
    }

    private void createCell(Row row, int col, String val, CellStyle style) {
        Cell cell = row.createCell(col);
        cell.setCellValue(val != null ? val : "");
        if (style != null) cell.setCellStyle(style);
    }

    private Object getField(Object obj, String fieldName) {
        try {
            String getter = "get" + Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);
            Method m = obj.getClass().getMethod(getter);
            return m.invoke(obj);
        } catch (Exception e) { return null; }
    }

    // Expose meta for import service
    public LinkedHashMap<String, String[]> getMetaFor(String module) { return metaFor(module); }
    public String[] getFields(String module) { return metaFor(module).keySet().toArray(new String[0]); }
}
