package com.xact.sy195.dto;

import com.fasterxml.jackson.annotation.JsonClassDescription;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import lombok.Data;

import java.util.List;

/**
 * Structured output DTO for Claude AI registration form suggestions.
 * Jackson annotations drive the JSON schema sent to the Anthropic API.
 */
@Data
@JsonClassDescription("Suggested values for each step of the XactERP company registration form")
public class RegistrationSuggestionResponse {

    @JsonPropertyDescription("Package type: LITE (1-step XactERP approval, suits most SMEs) or PRO (2-step: Imply then XactERP, for larger enterprises)")
    private String packageType;

    @JsonPropertyDescription("Estimated number of system users (1–500)")
    private Integer numUsers;

    @JsonPropertyDescription("True if standalone company, false if linked to a master company")
    private Boolean standalone;

    @JsonPropertyDescription("Legal company name — letters, digits, common punctuation. NO commas. Max 100 chars.")
    private String companyName;

    @JsonPropertyDescription("CIPC company registration number, e.g. 2020/123456/07 (optional)")
    private String regNumber;

    @JsonPropertyDescription("VAT registration number — digits only, e.g. 4123456789 (optional)")
    private String vatNumber;

    @JsonPropertyDescription("Currency code: ZAR (default for SA), USD, EUR, or GBP")
    private String currencyCode;

    @JsonPropertyDescription("Financial year-end month number: 1=Jan, 2=Feb, 3=Mar … 12=Dec")
    private Integer yearEndMonth;

    @JsonPropertyDescription("Suggested locations / warehouses for this company")
    private List<LocationSuggestion> locations;

    @JsonPropertyDescription("Suggested initial system users for this company")
    private List<UserSuggestion> users;

    @JsonPropertyDescription("Brief, friendly explanation of why these values were chosen — shown to the partner")
    private String reasoning;

    // ── Nested DTOs ──────────────────────────────────────────────────────────

    @Data
    @JsonClassDescription("Suggested location / warehouse")
    public static class LocationSuggestion {

        @JsonPropertyDescription("Location code: uppercase letters and digits only, max 3 chars (e.g. JHB, CPT, 001)")
        private String loc;

        @JsonPropertyDescription("Warehouse code: uppercase letters and digits, max 3 chars. Default: 001")
        private String whs;

        @JsonPropertyDescription("Human-readable location name, max 60 chars (e.g. Johannesburg Warehouse)")
        private String locName;

        @JsonPropertyDescription("SA province code: GP, WC, KZN, EC, LP, MP, NW, FS, NC (max 40 chars)")
        private String region;

        @JsonPropertyDescription("True if this location physically holds stock")
        private Boolean stockLoc;
    }

    @Data
    @JsonClassDescription("Suggested initial user account")
    public static class UserSuggestion {

        @JsonPropertyDescription("Username: lowercase letters, digits, hyphen, underscore, dot only. Max 30 chars.")
        private String username;

        @JsonPropertyDescription("User's full name, max 80 chars")
        private String fullName;

        @JsonPropertyDescription("Access group: Z0=System Admin, A1=Administrator, U1=Standard User, V1=View Only")
        private String accessGrp;
    }
}
