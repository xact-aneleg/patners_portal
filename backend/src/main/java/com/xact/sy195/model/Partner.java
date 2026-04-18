package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data @Entity @Table(name = "pp_partners")
public class Partner {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "company_name", nullable = false) private String companyName;
    @Column(name = "contact_name", nullable = false) private String contactName;
    @Column(nullable = false, unique = true)          private String email;
    private String phone;
    @Column(name = "password_hash", nullable = false) private String passwordHash;
    @Column(nullable = false)                          private String role; // PARTNER | XACT_ADMIN | IMPLY
    private Boolean active = true;
    @Column(name = "created_at")                       private LocalDateTime createdAt = LocalDateTime.now();
}
