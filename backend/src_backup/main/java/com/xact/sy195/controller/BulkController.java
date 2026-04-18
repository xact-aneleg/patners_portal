package com.xact.sy195.controller;

import com.xact.sy195.dto.FilterDTOs.*;
import com.xact.sy195.service.*;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api")
public class BulkController {

    private final BulkExportService exportService;
    private final BulkImportService importService;
    private final ExcelService excelService;

    public BulkController(BulkExportService exportService,
                          BulkImportService importService,
                          ExcelService excelService) {
        this.exportService = exportService;
        this.importService = importService;
        this.excelService  = excelService;
    }

    // ── Export endpoints ──────────────────────────────────────────────────────

    @PostMapping("/export/debtors")
    public ResponseEntity<byte[]> exportDebtors(@RequestBody DebtorFilterDTO filter) {
        return xlsxResponse(exportService.exportDebtors(filter), "dl01_mast.xlsx");
    }

    @PostMapping("/export/stock")
    public ResponseEntity<byte[]> exportStock(@RequestBody StockFilterDTO filter) {
        return xlsxResponse(exportService.exportStock(filter), "st01_mast.xlsx");
    }

    @PostMapping("/export/creditors")
    public ResponseEntity<byte[]> exportCreditors(@RequestBody CreditorFilterDTO filter) {
        return xlsxResponse(exportService.exportCreditors(filter), "cl01_mast.xlsx");
    }

    @PostMapping("/export/gl")
    public ResponseEntity<byte[]> exportGl(@RequestBody GlFilterDTO filter) {
        return xlsxResponse(exportService.exportGl(filter), "gl01_mast.xlsx");
    }

    // ── Template endpoints ────────────────────────────────────────────────────

    @GetMapping("/export/{module}/template")
    public ResponseEntity<byte[]> downloadTemplate(@PathVariable String module) {
        byte[] bytes = excelService.generateTemplate(module);
        return xlsxResponse(bytes, module + "_import_template.xlsx");
    }

    // ── Import endpoints ──────────────────────────────────────────────────────

    @PostMapping("/import/debtors")
    public ResponseEntity<ImportResponseDTO> importDebtors(@RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(importService.importDebtors(file));
    }

    @PostMapping("/import/stock")
    public ResponseEntity<ImportResponseDTO> importStock(@RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(importService.importStock(file));
    }

    @PostMapping("/import/creditors")
    public ResponseEntity<ImportResponseDTO> importCreditors(@RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(importService.importCreditors(file));
    }

    @PostMapping("/import/gl")
    public ResponseEntity<ImportResponseDTO> importGl(@RequestParam("file") MultipartFile file) {
        return ResponseEntity.ok(importService.importGl(file));
    }

    // ── Health check ──────────────────────────────────────────────────────────

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("{\"status\":\"UP\"}");
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private ResponseEntity<byte[]> xlsxResponse(byte[] bytes, String filename) {
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .header(HttpHeaders.ACCESS_CONTROL_EXPOSE_HEADERS, HttpHeaders.CONTENT_DISPOSITION)
                .contentType(MediaType.parseMediaType(
                    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .contentLength(bytes.length)
                .body(bytes);
    }
}
