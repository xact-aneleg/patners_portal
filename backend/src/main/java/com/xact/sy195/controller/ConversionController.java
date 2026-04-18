package com.xact.sy195.controller;

import com.xact.sy195.dto.ConversionConfigDTO;
import com.xact.sy195.dto.FilterDTOs.ImportResponseDTO;
import com.xact.sy195.service.ConversionService;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/conversion")
public class ConversionController {

    private final ConversionService conversionService;

    public ConversionController(ConversionService conversionService) {
        this.conversionService = conversionService;
    }

    // Full export — no filters, entire table
    @GetMapping("/export/{module}")
    public ResponseEntity<byte[]> exportFull(@PathVariable String module) {
        byte[] bytes = conversionService.exportFull(module);
        String filename = moduleToTable(module) + "_conversion.xlsx";
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
                .header(HttpHeaders.ACCESS_CONTROL_EXPOSE_HEADERS, HttpHeaders.CONTENT_DISPOSITION)
                .contentType(MediaType.parseMediaType(
                        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .contentLength(bytes.length)
                .body(bytes);
    }

    // Conversion import — with optional empty-table-first
    @PostMapping("/import")
    public ResponseEntity<ImportResponseDTO> conversionImport(
            @RequestParam("file") MultipartFile file,
            @RequestParam("module") String module,
            @RequestParam(value = "emptyTable", defaultValue = "false") boolean emptyTable,
            @RequestParam(value = "delimiter",  defaultValue = ",")     String delimiter,
            @RequestParam(value = "headerLineNo", defaultValue = "1")   int headerLineNo) {

        ConversionConfigDTO config = new ConversionConfigDTO();
        config.setModule(module);
        config.setEmptyTable(emptyTable);
        config.setDelimiter(delimiter);
        config.setHeaderLineNo(headerLineNo);

        return ResponseEntity.ok(conversionService.conversionImport(config, file));
    }

    // Row count — so the UI can show how many records are in the table
    @GetMapping("/count/{module}")
    public ResponseEntity<Long> getCount(@PathVariable String module) {
        long count = conversionService.getCount(module);
        return ResponseEntity.ok(count);
    }

    private String moduleToTable(String module) {
        return switch (module) {
            case "debtors"   -> "dl01_mast";
            case "stock"     -> "st01_mast";
            case "creditors" -> "cl01_mast";
            case "gl"        -> "gl01_mast";
            default -> module;
        };
    }
}
