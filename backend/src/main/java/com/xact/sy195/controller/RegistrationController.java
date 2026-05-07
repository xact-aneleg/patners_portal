package com.xact.sy195.controller;

import com.xact.sy195.dto.PortalDTOs.*;
import com.xact.sy195.model.Partner;
import com.xact.sy195.service.PartnerService;
import com.xact.sy195.service.RegistrationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/portal/registrations")
public class RegistrationController {

    private final RegistrationService regService;
    private final PartnerService      partnerService;

    public RegistrationController(RegistrationService regService, PartnerService partnerService) {
        this.regService     = regService;
        this.partnerService = partnerService;
    }

    // Partner: list their own registrations
    @GetMapping
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<List<RegistrationSummary>> list(Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.listForPartner(p.getId()));
    }

    // Partner: create new registration (saved as DRAFT)
    @PostMapping
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<RegistrationResponse> create(@RequestBody RegistrationRequest req, Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.save(p.getId(), null, req));
    }

    // Partner: update existing DRAFT
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<RegistrationResponse> update(@PathVariable Long id,
                                                       @RequestBody RegistrationRequest req,
                                                       Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.save(p.getId(), id, req));
    }

    // Partner: get single registration (full detail)
    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('PARTNER','XACT_ADMIN','IMPLY')")
    public ResponseEntity<RegistrationResponse> get(@PathVariable Long id) {
        return ResponseEntity.ok(regService.get(id));
    }

    // Partner: delete DRAFT
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<Void> delete(@PathVariable Long id, Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        regService.delete(id, p.getId());
        return ResponseEntity.noContent().build();
    }

    // Partner: submit DRAFT → PENDING
    @PostMapping("/{id}/submit")
    @PreAuthorize("hasRole('PARTNER')")
    public ResponseEntity<RegistrationResponse> submit(@PathVariable Long id, Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.submit(id, p.getId(), p.getContactName()));
    }

    // Imply: approve (Xact Pro only)
    @PostMapping("/{id}/approve-imply")
    @PreAuthorize("hasRole('IMPLY')")
    public ResponseEntity<RegistrationResponse> approveImply(@PathVariable Long id,
                                                              @RequestBody DecisionRequest req,
                                                              Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.approveImply(id, p.getId(), p.getContactName(), req.getComments()));
    }

    // Imply: decline
    @PostMapping("/{id}/decline-imply")
    @PreAuthorize("hasRole('IMPLY')")
    public ResponseEntity<RegistrationResponse> declineImply(@PathVariable Long id,
                                                              @RequestBody DecisionRequest req,
                                                              Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.declineImply(id, p.getId(), p.getContactName(), req.getComments()));
    }

    // XactERP: approve
    @PostMapping("/{id}/approve-xact")
    @PreAuthorize("hasRole('XACT_ADMIN')")
    public ResponseEntity<RegistrationResponse> approveXact(@PathVariable Long id,
                                                             @RequestBody DecisionRequest req,
                                                             Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.approveXact(id, p.getId(), p.getContactName(), req.getComments()));
    }

    // XactERP: decline
    @PostMapping("/{id}/decline-xact")
    @PreAuthorize("hasRole('XACT_ADMIN')")
    public ResponseEntity<RegistrationResponse> declineXact(@PathVariable Long id,
                                                             @RequestBody DecisionRequest req,
                                                             Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.declineXact(id, p.getId(), p.getContactName(), req.getComments()));
    }

    // XactERP: manual conversion trigger
    @PostMapping("/{id}/convert")
    @PreAuthorize("hasRole('XACT_ADMIN')")
    public ResponseEntity<ConversionJobDTO> convert(@PathVariable Long id, Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(regService.triggerConversion(id, p.getId(), p.getContactName()));
    }

    // XactERP: get conversion job status
    @GetMapping("/{id}/conversion-status")
    @PreAuthorize("hasAnyRole('XACT_ADMIN','PARTNER')")
    public ResponseEntity<ConversionJobDTO> conversionStatus(@PathVariable Long id) {
        return ResponseEntity.ok(regService.getLatestJob(id));
    }
}
