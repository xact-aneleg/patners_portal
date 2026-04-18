package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;

@Data @Entity @Table(name = "pp_reg_locations")
public class RegLocation {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "registration_id", nullable = false) private Long registrationId;
    private String loc;
    private String whs;
    @Column(name = "loc_name")       private String locName;
    private String region;
    @Column(name = "stock_loc")      private Boolean stockLoc = false;
    @Column(name = "physical_addr1") private String physicalAddr1;
    @Column(name = "physical_addr2") private String physicalAddr2;
    @Column(name = "physical_addr3") private String physicalAddr3;
    @Column(name = "physical_addr4") private String physicalAddr4;
}
