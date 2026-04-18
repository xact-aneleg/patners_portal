package com.xact.sy195.controller;

import com.xact.sy195.dto.PortalDTOs.*;
import com.xact.sy195.model.Partner;
import com.xact.sy195.repository.PartnerRepository;
import com.xact.sy195.service.PartnerService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/portal/auth")
public class PortalAuthController {

    private final PartnerService   partnerService;
    private final PartnerRepository partnerRepo;
    private final PasswordEncoder  encoder;

    public PortalAuthController(PartnerService partnerService,
                                PartnerRepository partnerRepo,
                                PasswordEncoder encoder) {
        this.partnerService = partnerService;
        this.partnerRepo    = partnerRepo;
        this.encoder        = encoder;
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponse> login(@RequestBody LoginRequest req) {
        return ResponseEntity.ok(partnerService.login(req));
    }

    @PostMapping("/register")
    public ResponseEntity<LoginResponse> register(@RequestBody RegisterPartnerRequest req) {
        return ResponseEntity.ok(partnerService.register(req));
    }

    /**
     * DEV ONLY — resets all demo account passwords to password123.
     * Call once after first setup: GET /api/portal/auth/reset-demo-passwords
     */
    @GetMapping("/reset-demo-passwords")
    public ResponseEntity<Map<String, String>> resetDemoPasswords() {
        String hash = encoder.encode("password123");
        List<String> emails = List.of(
            "partner@acme.co.za",
            "admin@xacterp.co.za",
            "approver@imply.co.za"
        );
        int updated = 0;
        for (String email : emails) {
            var opt = partnerRepo.findByEmail(email);
            if (opt.isPresent()) {
                Partner p = opt.get();
                p.setPasswordHash(hash);
                partnerRepo.save(p);
                updated++;
            }
        }
        return ResponseEntity.ok(Map.of(
            "status", "done",
            "updated", updated + " accounts",
            "password", "password123"
        ));
    }
}
