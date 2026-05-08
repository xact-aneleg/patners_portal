package com.xact.sy195.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

public class PortalDTOs {

    // ── Auth ──────────────────────────────────────────────────────────────────
    @Data public static class LoginRequest {
        private String email;
        private String password;
    }

    @Data public static class LoginResponse {
        private String token;
        private String role;
        private String email;
        private String name;
        private Long partnerId;
    }

    @Data public static class RegisterPartnerRequest {
        private String companyName;
        private String contactName;
        private String email;
        private String phone;
        private String password;
    }

    // ── Location / User sub-DTOs ──────────────────────────────────────────────
    @Data public static class LocationDTO {
        private Long id;
        private String loc;
        private String whs;
        private String locName;
        private String region;
        private Boolean stockLoc = false;
        private String physicalAddr1;
        private String physicalAddr2;
        private String physicalAddr3;
        private String physicalAddr4;
    }

    @Data public static class UserDTO {
        private Long id;
        private String username;
        private String fullName;
        private String email;
        private String defaultLoc;
        private String accessGrp;
    }

    @Data public static class WorkflowEventDTO {
        private Long id;
        private String actorName;
        private String eventType;
        private String fromStatus;
        private String toStatus;
        private String comments;
        private LocalDateTime createdAt;
    }

    // ── Registration ─────────────────────────────────────────────────────────
    @Data public static class RegistrationRequest {
        // Package
        private String packageType = "LITE";
        private Integer numUsers = 1;
        private Boolean standalone = true;
        private String masterCompany;
        private String syncModules;
        // Company
        private String companyName;
        private String masterOrSlave = "MASTER";
        private String postalAddr1;
        private String postalAddr2;
        private String postalAddr3;
        private String postalAddr4;
        private String physicalAddr1;
        private String physicalAddr2;
        private String physicalAddr3;
        private String physicalAddr4;
        private String telephone;
        private String fax;
        private String companyEmail;
        private String companyDomain;
        private String regNumber;
        private String vatNumber;
        private Integer yearEndMonth;
        private BigDecimal vatRate = new BigDecimal("15");
        private String bankName;
        private String bankBranch;
        private String bankBranchCode;
        private String bankAccount;
        private Boolean multiCurrency = false;
        private String localCurrency;
        private String currencyCode;
        // Periods
        private Integer periodGl;
        private Integer periodCb;
        private Integer periodDl;
        private Integer periodSa;
        private Integer periodCl;
        private Integer periodPu;
        private Integer systemYearEnd;
        // Locations & Users
        private List<LocationDTO> locations = new ArrayList<>();
        private List<UserDTO> users = new ArrayList<>();
    }

    @Data public static class RegistrationResponse {
        private Long id;
        private Long partnerId;
        private String partnerName;
        private String packageType;
        private Integer numUsers;
        private String companyName;
        private String status;
        private String declineReason;
        private LocalDateTime submittedAt;
        private LocalDateTime createdAt;
        private LocalDateTime updatedAt;
        // nested
        private Boolean standalone;
        private String masterCompany;
        private String syncModules;
        private String masterOrSlave;
        private String postalAddr1;
        private String postalAddr2;
        private String postalAddr3;
        private String postalAddr4;
        private String physicalAddr1;
        private String physicalAddr2;
        private String physicalAddr3;
        private String physicalAddr4;
        private String telephone;
        private String fax;
        private String companyEmail;
        private String companyDomain;
        private String regNumber;
        private String vatNumber;
        private Integer yearEndMonth;
        private BigDecimal vatRate;
        private String bankName;
        private String bankBranch;
        private String bankBranchCode;
        private String bankAccount;
        private Boolean multiCurrency;
        private String localCurrency;
        private String currencyCode;
        private Integer periodGl;
        private Integer periodCb;
        private Integer periodDl;
        private Integer periodSa;
        private Integer periodCl;
        private Integer periodPu;
        private Integer systemYearEnd;
        private List<LocationDTO> locations = new ArrayList<>();
        private List<UserDTO> users = new ArrayList<>();
        private List<WorkflowEventDTO> events = new ArrayList<>();
    }

    @Data public static class DecisionRequest {
        private String comments;
    }

    @Data public static class RegistrationSummary {
        private Long id;
        private String packageType;
        private Integer numUsers;
        private String companyName;
        private String partnerName;
        private String status;
        private LocalDateTime submittedAt;
        private LocalDateTime createdAt;
    }

    @Data public static class ConversionJobDTO {
        private Long id;
        private Long registrationId;
        private String status;
        private LocalDateTime startedAt;
        private LocalDateTime completedAt;
        private String logOutput;
    }

    // ── Documents ─────────────────────────────────────────────────────────────
    @Data public static class RegDocumentDTO {
        private Long id;
        private Long registrationId;
        private String fileName;
        private String contentType;
        private Long fileSize;
        private String uploadedBy;
        private LocalDateTime uploadedAt;
    }

    // ── Notifications ─────────────────────────────────────────────────────────
    @Data public static class NotificationDTO {
        private Long id;
        private Long registrationId;
        private String type;
        private String message;
        private boolean read;
        private LocalDateTime createdAt;
    }
}
