package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data @Entity @Table(name = "pp_registrations")
public class Registration {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "partner_id", nullable = false) private Long partnerId;
    // Package
    @Column(name = "package_type", nullable = false) private String packageType; // LITE | PRO
    @Column(name = "num_users")     private Integer numUsers = 1;
    private Boolean standalone = true;
    @Column(name = "master_company") private String masterCompany;
    @Column(name = "sync_modules")   private String syncModules;
    // Company details
    @Column(name = "company_name", nullable = false) private String companyName;
    @Column(name = "master_or_slave") private String masterOrSlave = "MASTER";
    @Column(name = "postal_addr1")   private String postalAddr1;
    @Column(name = "postal_addr2")   private String postalAddr2;
    @Column(name = "postal_addr3")   private String postalAddr3;
    @Column(name = "postal_addr4")   private String postalAddr4;
    @Column(name = "physical_addr1") private String physicalAddr1;
    @Column(name = "physical_addr2") private String physicalAddr2;
    @Column(name = "physical_addr3") private String physicalAddr3;
    @Column(name = "physical_addr4") private String physicalAddr4;
    private String telephone;
    private String fax;
    @Column(name = "company_email")  private String companyEmail;
    @Column(name = "company_domain") private String companyDomain;
    @Column(name = "reg_number")     private String regNumber;
    @Column(name = "vat_number")     private String vatNumber;
    @Column(name = "year_end_month") private Integer yearEndMonth;
    @Column(name = "vat_rate")       private java.math.BigDecimal vatRate = new java.math.BigDecimal("15");
    @Column(name = "bank_name")      private String bankName;
    @Column(name = "bank_branch")    private String bankBranch;
    @Column(name = "bank_branch_code") private String bankBranchCode;
    @Column(name = "bank_account")   private String bankAccount;
    @Column(name = "multi_currency") private Boolean multiCurrency = false;
    @Column(name = "local_currency") private String localCurrency;
    @Column(name = "currency_code")  private String currencyCode;
    // Periods
    @Column(name = "period_gl") private Integer periodGl;
    @Column(name = "period_cb") private Integer periodCb;
    @Column(name = "period_dl") private Integer periodDl;
    @Column(name = "period_sa") private Integer periodSa;
    @Column(name = "period_cl") private Integer periodCl;
    @Column(name = "period_pu") private Integer periodPu;
    @Column(name = "system_year_end") private Integer systemYearEnd;
    // Workflow
    @Column(nullable = false) private String status = "DRAFT";
    @Column(name = "decline_reason", columnDefinition = "TEXT") private String declineReason;
    @Column(name = "submitted_at")  private LocalDateTime submittedAt;
    @Column(name = "created_at")    private LocalDateTime createdAt = LocalDateTime.now();
    @Column(name = "updated_at")    private LocalDateTime updatedAt = LocalDateTime.now();
    @PreUpdate public void onUpdate() { updatedAt = LocalDateTime.now(); }
}
