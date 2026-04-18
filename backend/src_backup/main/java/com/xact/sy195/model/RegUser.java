package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;

@Data @Entity @Table(name = "pp_reg_users")
public class RegUser {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "registration_id", nullable = false) private Long registrationId;
    private String username;
    @Column(name = "full_name")   private String fullName;
    private String email;
    @Column(name = "default_loc") private String defaultLoc;
    @Column(name = "access_grp") private String accessGrp;
}
