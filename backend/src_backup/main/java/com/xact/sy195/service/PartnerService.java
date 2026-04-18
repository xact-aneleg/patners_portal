package com.xact.sy195.service;

import com.xact.sy195.dto.PortalDTOs.*;
import com.xact.sy195.model.Partner;
import com.xact.sy195.repository.PartnerRepository;
import com.xact.sy195.security.JwtUtil;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class PartnerService {

    private final PartnerRepository partnerRepo;
    private final PasswordEncoder   encoder;
    private final JwtUtil           jwtUtil;

    public PartnerService(PartnerRepository partnerRepo, PasswordEncoder encoder, JwtUtil jwtUtil) {
        this.partnerRepo = partnerRepo;
        this.encoder     = encoder;
        this.jwtUtil     = jwtUtil;
    }

    public LoginResponse login(LoginRequest req) {
        Partner p = partnerRepo.findByEmail(req.getEmail())
                .orElseThrow(() -> new IllegalArgumentException("Invalid email or password"));
        if (!encoder.matches(req.getPassword(), p.getPasswordHash()))
            throw new IllegalArgumentException("Invalid email or password");
        if (!Boolean.TRUE.equals(p.getActive()))
            throw new IllegalStateException("Account is disabled");

        LoginResponse resp = new LoginResponse();
        resp.setToken(jwtUtil.generateToken(p.getEmail(), p.getRole(), p.getId()));
        resp.setRole(p.getRole());
        resp.setEmail(p.getEmail());
        resp.setName(p.getContactName() + " — " + p.getCompanyName());
        resp.setPartnerId(p.getId());
        return resp;
    }

    public LoginResponse register(RegisterPartnerRequest req) {
        if (partnerRepo.findByEmail(req.getEmail()).isPresent())
            throw new IllegalArgumentException("Email already registered");

        Partner p = new Partner();
        p.setCompanyName(req.getCompanyName());
        p.setContactName(req.getContactName());
        p.setEmail(req.getEmail());
        p.setPhone(req.getPhone());
        p.setPasswordHash(encoder.encode(req.getPassword()));
        p.setRole("PARTNER");
        p = partnerRepo.save(p);

        LoginResponse resp = new LoginResponse();
        resp.setToken(jwtUtil.generateToken(p.getEmail(), p.getRole(), p.getId()));
        resp.setRole(p.getRole()); resp.setEmail(p.getEmail());
        resp.setName(p.getContactName() + " — " + p.getCompanyName());
        resp.setPartnerId(p.getId());
        return resp;
    }

    public Partner getByEmail(String email) {
        return partnerRepo.findByEmail(email).orElseThrow();
    }
}
