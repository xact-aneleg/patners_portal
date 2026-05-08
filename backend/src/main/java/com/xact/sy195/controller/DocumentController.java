package com.xact.sy195.controller;

import com.xact.sy195.dto.PortalDTOs.RegDocumentDTO;
import com.xact.sy195.model.Partner;
import com.xact.sy195.model.RegDocument;
import com.xact.sy195.service.DocumentService;
import com.xact.sy195.service.PartnerService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/portal/registrations/{regId}/documents")
public class DocumentController {

    private final DocumentService docService;
    private final PartnerService  partnerService;

    public DocumentController(DocumentService docService, PartnerService partnerService) {
        this.docService    = docService;
        this.partnerService = partnerService;
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<RegDocumentDTO> upload(@PathVariable Long regId,
                                                 @RequestParam("file") MultipartFile file,
                                                 Authentication auth) throws IOException {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(docService.upload(regId, p.getId(), auth.getName(), file));
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('PARTNER','XACT_ADMIN','IMPLY')")
    public ResponseEntity<List<RegDocumentDTO>> list(@PathVariable Long regId) {
        return ResponseEntity.ok(docService.list(regId));
    }

    @GetMapping("/{docId}/download")
    @PreAuthorize("hasAnyRole('PARTNER','XACT_ADMIN','IMPLY')")
    public ResponseEntity<byte[]> download(@PathVariable Long regId, @PathVariable Long docId) {
        RegDocument doc = docService.download(docId);
        String contentType = doc.getContentType() != null ? doc.getContentType() : "application/octet-stream";
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + doc.getFileName() + "\"")
                .contentType(MediaType.parseMediaType(contentType))
                .body(doc.getFileData());
    }

    @DeleteMapping("/{docId}")
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<Void> delete(@PathVariable Long regId,
                                       @PathVariable Long docId,
                                       Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        docService.delete(docId, p.getId());
        return ResponseEntity.noContent().build();
    }
}
