package com.xact.sy195.controller;

import com.xact.sy195.dto.PortalDTOs.*;
import com.xact.sy195.service.RegistrationService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/portal/admin")
public class AdminController {

    private final RegistrationService regService;
    public AdminController(RegistrationService regService)
    {
        this.regService = regService;
    }

    // XactERP: all registrations across all partners
    @GetMapping("/registrations")
    @PreAuthorize("hasRole('XACT_ADMIN')")
    public ResponseEntity<List<RegistrationSummary>> allRegistrations() {
        return ResponseEntity.ok(regService.listAll());
    }

    // XactERP: registrations pending their review
    @GetMapping("/pending-xact")
    @PreAuthorize("hasRole('XACT_ADMIN')")
    public ResponseEntity<List<RegistrationSummary>> pendingXact() {
        return ResponseEntity.ok(regService.listByStatus(List.of("PENDING_XACT")));
    }

    // Imply: registrations pending Imply review
    @GetMapping("/pending-imply")
    @PreAuthorize("hasRole('IMPLY')")
    public ResponseEntity<List<RegistrationSummary>> pendingImply() {
        return ResponseEntity.ok(regService.listByStatus(List.of("PENDING_IMPLY")));
    }
}
