package com.xact.sy195.service;

import com.anthropic.client.AnthropicClient;
import com.anthropic.client.okhttp.AnthropicOkHttpClient;
import com.anthropic.models.messages.CacheControlEphemeral;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.TextBlockParam;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xact.sy195.dto.ApprovalAnalysisResponse;
import com.xact.sy195.dto.FilterSuggestionResponse;
import com.xact.sy195.dto.RegistrationSuggestionResponse;
import com.xact.sy195.repository.RegLocationRepository;
import com.xact.sy195.repository.RegUserRepository;
import com.xact.sy195.repository.RegistrationRepository;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Calls the Anthropic Claude API to generate registration form suggestions.
 *
 * Design decisions:
 * - Model: claude-opus-4-7 (most capable, best context understanding)
 * - Prompt caching: system prompt is stable → cached with CacheControlEphemeral,
 *   cutting cost ~90% after the first call per 5-minute window.
 * - Structured outputs: Jackson annotations on RegistrationSuggestionResponse drive
 *   the JSON schema, guaranteeing parseable output every time.
 */
@Service
public class AiService {

    private static final Logger log = LoggerFactory.getLogger(AiService.class);

    @Value("${anthropic.api-key}")
    private String apiKey;

    private final RegistrationRepository regRepo;
    private final RegLocationRepository  locRepo;
    private final RegUserRepository      userRepo;
    private final ObjectMapper           objectMapper;

    public AiService(RegistrationRepository regRepo,
                     RegLocationRepository locRepo,
                     RegUserRepository userRepo,
                     ObjectMapper objectMapper) {
        this.regRepo      = regRepo;
        this.locRepo      = locRepo;
        this.userRepo     = userRepo;
        this.objectMapper = objectMapper;
    }

    private AnthropicClient client;

    // ── System prompt — cached after first request ────────────────────────────
    // Keep this stable (no timestamps, no per-user data) so caching stays warm.
    private static final String SYSTEM_PROMPT = """
        You are an intelligent assistant helping channel partners complete company registration forms for XactERP — a South African ERP system.

        When a partner describes a company, suggest practical, accurate values for the registration form fields.

        ## Form fields you must fill

        **Package (Step 1)**
        - packageType: "LITE" for SMEs (1-step XactERP approval) or "PRO" for enterprises (Imply → XactERP two-step workflow)
        - numUsers: estimated system users (1–500). Typical SME: 5–20. Enterprise: 50+.
        - standalone: true unless partner says it's linked to another company

        **Company details (Step 2)**
        - companyName: legal name — letters, digits, spaces, common punctuation. NO commas (they break CSV exports). Max 100 chars.
        - regNumber: CIPC registration number format 20YY/NNNNNN/07 (optional)
        - vatNumber: digits only, e.g. 4123456789 (optional, leave null if not mentioned)
        - currencyCode: ZAR for South Africa (default), USD, EUR, GBP
        - yearEndMonth: 1–12. Common SA year-ends: Feb(2), Jun(6), Dec(12). Default Feb if unclear.

        **Locations (Step 4)**
        Suggest at least one location. Code rules:
        - loc: uppercase letters/digits, max 3 chars. Use city codes: JHB, CPT, DBN, PRE, PE, EL, BFN
        - whs: same rules, default "001"
        - locName: descriptive name max 60 chars, e.g. "Johannesburg Head Office"
        - region: SA province code: GP(Gauteng), WC(Western Cape), KZN(KwaZulu-Natal), EC(Eastern Cape), LP(Limpopo), MP(Mpumalanga), NW(North West), FS(Free State), NC(Northern Cape)
        - stockLoc: true for warehouses/retailers, false for service-only offices

        **Users (Step 5)**
        Suggest 1 admin user minimum:
        - username: lowercase, digits, hyphen, underscore, dot only. Max 30 chars. Example: "admin", "john.smith"
        - fullName: full name max 80 chars
        - accessGrp: Z0=System Admin, A1=Administrator (recommend this for first user), U1=Standard, V1=View Only

        ## South African context
        - Default currency: ZAR
        - Most common year-end: February (month 2)
        - Retail/wholesale companies usually need stock locations
        - Service companies (consulting, professional services) usually don't hold stock

        ## Output rules
        - Return ONLY valid JSON matching the schema. No markdown, no explanations outside the JSON.
        - The "reasoning" field should be a short, friendly sentence explaining your main choices (1–2 sentences).
        - Leave optional fields null if not enough information — don't guess company registration or VAT numbers.
        - All location/warehouse codes must be uppercase.
        - All usernames must be lowercase.
        """;

    @PostConstruct
    public void init() {
        this.client = AnthropicOkHttpClient.builder()
                .apiKey(apiKey)
                .build();
        log.info("Anthropic AI client initialised (model: claude-opus-4-7)");
    }

    private static final String FILTER_SYSTEM_PROMPT = """
        You are an expert at translating plain-language export requests into filter parameters for XactERP's sy195 bulk data export tool.

        The system manages South African ERP master table data. You must convert a natural-language description into specific filter field values.

        ## Module: Debtors (dl01_mast)
        Fields and allowed values:
        - startAcct / endAcct: account code range (! = first, ~ = last, or specific code like "ABC001")
        - masterAcct: A=All accounts, M=Master accounts only, S=Slave/child accounts only
        - delAcct: A=All, N=Active only (not deleted), D=Deleted only
        - status: ALL, OPEN, CLOSED
        - crStatus: ALL, GOOD, HOLD, COD
        - balance: ALL, POSITIVE (amounts owing), NEGATIVE (credit balances), ZERO
        - foreignTracked: ALL, Y=Foreign currency tracked, N=Local currency only

        ## Module: Stock (st01_mast)
        Fields:
        - startCode / endCode: stock code range
        - status: ALL, ACTIVE, DISCONTINUED

        ## Module: Creditors (cl01_mast)
        Fields:
        - startAcct / endAcct: account code range
        - status: ALL, OPEN, CLOSED

        ## Module: GL / General Ledger (gl01_mast)
        Fields:
        - startGl / endGl: GL account code range
        - accountType: ALL, BS=Balance Sheet, IS=Income Statement

        ## Rules
        - Only include fields that differ from defaults (defaults: startAcct=!, endAcct=~, all others=ALL)
        - Return ONLY fields relevant to the requested module
        - For account code ranges, use exact codes when mentioned
        - Keep reasoning to one concise sentence

        ## Output format
        Return ONLY a valid JSON object — no markdown, no code fences, no explanation outside the JSON:
        {"filters": {"fieldName": "value"}, "reasoning": "one sentence"}
        """;

    /**
     * Translate a natural-language export request into filter field values.
     * Uses plain text response + Jackson parsing (Map<String,String> filters cannot
     * be expressed as a named-property JSON schema for structured outputs).
     * System prompt cached — repeated calls within 5 minutes cost ~10%.
     */
    public FilterSuggestionResponse suggestFilters(String module, String description) {
        log.debug("AI filter suggest — module={}, description='{}'", module, description);

        String userMessage = "Module: " + module + "\nRequest: " + description;

        var params = MessageCreateParams.builder()
                .model("claude-opus-4-7")
                .maxTokens(500L)
                .systemOfTextBlockParams(List.of(
                        TextBlockParam.builder()
                                .text(FILTER_SYSTEM_PROMPT)
                                .cacheControl(CacheControlEphemeral.builder().build())
                                .build()))
                .addUserMessage(userMessage)
                .build();

        var response = client.messages().create(params);
        String jsonText = response.content().stream()
                .flatMap(block -> block.text().stream())
                .findFirst()
                .map(tb -> tb.text())
                .orElseThrow(() -> new IllegalStateException("Claude returned no content"));

        try {
            return objectMapper.readValue(jsonText, FilterSuggestionResponse.class);
        } catch (Exception e) {
            log.error("Failed to parse filter suggestion JSON: {}", jsonText, e);
            throw new IllegalStateException("AI returned invalid response: " + e.getMessage());
        }
    }

    /**
     * Analyse a pending registration and suggest an approve/decline decision.
     * Fetches full registration data from DB to give Claude complete context.
     */
    public ApprovalAnalysisResponse analyzeRegistration(Long registrationId, String approverRole) {
        log.debug("AI approval analysis — registrationId={}, role={}", registrationId, approverRole);

        var reg   = regRepo.findById(registrationId).orElseThrow();
        var locs  = locRepo.findByRegistrationId(registrationId);
        var users = userRepo.findByRegistrationId(registrationId);

        String context = """
            Registration ID: %d
            Company: %s
            Package: %s (%s)
            Users requested: %d
            Email: %s
            Telephone: %s
            VAT: %s
            Reg number: %s
            Currency: %s
            Year end month: %d
            Bank: %s (%s)
            Locations (%d): %s
            Users (%d): %s
            Approver role: %s
            """.formatted(
                reg.getId(),
                reg.getCompanyName(),
                reg.getPackageType(), reg.getMasterOrSlave(),
                reg.getNumUsers() != null ? reg.getNumUsers() : 0,
                reg.getCompanyEmail(),
                reg.getTelephone(),
                reg.getVatNumber(),
                reg.getRegNumber(),
                reg.getCurrencyCode(),
                reg.getYearEndMonth() != null ? reg.getYearEndMonth() : 0,
                reg.getBankName(), reg.getBankBranchCode(),
                locs.size(),
                locs.stream().map(l -> l.getLoc() + "=" + l.getLocName()).toList(),
                users.size(),
                users.stream().map(u -> u.getUsername() + " (" + u.getAccessGrp() + ")").toList(),
                approverRole
        );

        String systemPrompt = """
            You are an expert XactERP partner portal approver assistant.
            Analyse a pending company registration and give a clear recommendation.

            Consider:
            - Is the information complete and consistent?
            - Does the package type match the company size?
            - Are location codes and user access groups correctly set up?
            - Any red flags (missing VAT for larger companies, mismatched info)?

            IMPLY approvers check if the company meets Xact Pro criteria (size, complexity).
            XACT_ADMIN approvers check completeness and readiness for provisioning.

            Return a concise, professional analysis. draftComment must be ready to paste as-is.
            """;

        var params = MessageCreateParams.builder()
                .model("claude-opus-4-7")
                .maxTokens(800L)
                .outputConfig(ApprovalAnalysisResponse.class)
                .systemOfTextBlockParams(List.of(
                        TextBlockParam.builder()
                                .text(systemPrompt)
                                .cacheControl(CacheControlEphemeral.builder().build())
                                .build()))
                .addUserMessage(context)
                .build();

        var response = client.messages().create(params);
        return response.content().stream()
                .flatMap(block -> block.text().stream())
                .findFirst()
                .map(typed -> (ApprovalAnalysisResponse) typed.text())
                .orElseThrow(() -> new IllegalStateException("Claude returned no content"));
    }

    /**
     * Generate registration form suggestions from a plain-language company description.
     * The system prompt is cached — subsequent calls within 5 minutes cost ~10% of the first.
     */
    public RegistrationSuggestionResponse suggest(String description) {
        log.debug("AI suggest called: '{}'", description);

        // Build params with prompt caching on the stable system prompt
        var params = MessageCreateParams.builder()
                .model("claude-opus-4-7")
                .maxTokens(1500L)
                // outputConfig drives the JSON schema from RegistrationSuggestionResponse annotations
                // and guarantees the response is valid parseable JSON
                .outputConfig(RegistrationSuggestionResponse.class)
                // System prompt is large and stable → cache it
                .systemOfTextBlockParams(List.of(
                        TextBlockParam.builder()
                                .text(SYSTEM_PROMPT)
                                .cacheControl(CacheControlEphemeral.builder().build())
                                .build()))
                .addUserMessage(description)
                .build();

        var response = client.messages().create(params);

        // With structured outputs, typed.text() returns RegistrationSuggestionResponse directly
        return response.content().stream()
                .flatMap(block -> block.text().stream())
                .findFirst()
                .map(typed -> (RegistrationSuggestionResponse) typed.text())
                .orElseThrow(() -> new IllegalStateException("Claude returned no content"));
    }
}
