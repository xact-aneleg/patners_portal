package com.xact.sy195.service;

import com.xact.sy195.dto.PortalDTOs.RegDocumentDTO;
import com.xact.sy195.model.RegDocument;
import com.xact.sy195.model.Registration;
import com.xact.sy195.repository.RegDocumentRepository;
import com.xact.sy195.repository.RegistrationRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class DocumentService {

    private final RegDocumentRepository  docRepo;
    private final RegistrationRepository regRepo;

    public DocumentService(RegDocumentRepository docRepo, RegistrationRepository regRepo) {
        this.docRepo = docRepo;
        this.regRepo = regRepo;
    }

    @Transactional
    public RegDocumentDTO upload(Long regId, Long partnerId, String uploaderEmail, MultipartFile file) throws IOException {
        Registration reg = regRepo.findById(regId)
                .orElseThrow(() -> new NoSuchElementException("Registration not found"));
        if (!reg.getPartnerId().equals(partnerId))
            throw new IllegalStateException("Not your registration");

        RegDocument doc = new RegDocument();
        doc.setRegistrationId(regId);
        doc.setFileName(file.getOriginalFilename());
        doc.setContentType(file.getContentType());
        doc.setFileSize(file.getSize());
        doc.setFileData(file.getBytes());
        doc.setUploadedBy(uploaderEmail);
        doc = docRepo.save(doc);
        return toDto(doc);
    }

    public List<RegDocumentDTO> list(Long regId) {
        return docRepo.findByRegistrationIdOrderByUploadedAtDesc(regId)
                .stream().map(this::toDto).toList();
    }

    public RegDocument download(Long docId) {
        return docRepo.findById(docId)
                .orElseThrow(() -> new NoSuchElementException("Document not found"));
    }

    @Transactional
    public void delete(Long docId, Long partnerId) {
        RegDocument doc = docRepo.findById(docId)
                .orElseThrow(() -> new NoSuchElementException("Document not found"));
        Registration reg = regRepo.findById(doc.getRegistrationId()).orElseThrow();
        if (!reg.getPartnerId().equals(partnerId))
            throw new IllegalStateException("Not your document");
        if (!"DRAFT".equals(reg.getStatus()))
            throw new IllegalStateException("Documents can only be deleted on DRAFT registrations");
        docRepo.deleteById(docId);
    }

    private RegDocumentDTO toDto(RegDocument d) {
        RegDocumentDTO dto = new RegDocumentDTO();
        dto.setId(d.getId());
        dto.setRegistrationId(d.getRegistrationId());
        dto.setFileName(d.getFileName());
        dto.setContentType(d.getContentType());
        dto.setFileSize(d.getFileSize());
        dto.setUploadedBy(d.getUploadedBy());
        dto.setUploadedAt(d.getUploadedAt());
        return dto;
    }
}
