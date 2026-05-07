package com.xact.sy195.controller;

import com.xact.sy195.dto.ApprovalAnalysisResponse;
import com.xact.sy195.dto.FilterSuggestionResponse;
import com.xact.sy195.dto.RegistrationSuggestionResponse;
import com.xact.sy195.service.AiService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
public class AiController {

    private final AiService aiService;

    public AiController(AiService aiService) {
        this.aiService = aiService;
    }

    /**
     * POST /api/portal/ai/suggest   (JWT required — portal use)
     * Natural language → registration form field suggestions (5-step wizard).
     */
    @PostMapping("/api/portal/ai/suggest")
    public ResponseEntity<RegistrationSuggestionResponse> suggest(
            @RequestBody Map<String, String> body) {
        String description = body.get("description");
        if (description == null || description.isBlank()) return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(aiService.suggest(description.substring(0, Math.min(description.length(), 2000)).trim()));
    }

    /**
     * POST /api/ai/filter-suggest   (no auth — sy195 bulk pages are public)
     * Natural language → export filter field values for a given module.
     * Body: { "module": "debtors", "description": "Cape Town debtors on hold" }
     */
    @PostMapping("/api/ai/filter-suggest")
    public ResponseEntity<FilterSuggestionResponse> filterSuggest(
            @RequestBody Map<String, String> body) {
        String module      = body.getOrDefault("module", "debtors");
        String description = body.get("description");
        if (description == null || description.isBlank()) return ResponseEntity.badRequest().build();
        return ResponseEntity.ok(aiService.suggestFilters(module, description.substring(0, Math.min(description.length(), 500)).trim()));
    }

    /**
     * POST /api/portal/ai/analyze   (JWT required — approval queue use)
     * Fetch full registration data and return AI approve/decline recommendation.
     * Body: { "registrationId": 42 }
     */
    @PostMapping("/api/portal/ai/analyze")
    public ResponseEntity<ApprovalAnalysisResponse> analyze(
            @RequestBody Map<String, Object> body) {
        Long regId = Long.valueOf(body.get("registrationId").toString());
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String role = auth.getAuthorities().stream()
                .findFirst().map(a -> a.getAuthority().replace("ROLE_", "")).orElse("UNKNOWN");
        return ResponseEntity.ok(aiService.analyzeRegistration(regId, role));
    }
}
