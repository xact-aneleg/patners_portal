package com.xact.sy195.dto;

import com.fasterxml.jackson.annotation.JsonClassDescription;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import lombok.Data;

import java.util.List;

@Data
@JsonClassDescription("AI analysis of a partner registration for approval queue review")
public class ApprovalAnalysisResponse {

    @JsonPropertyDescription("Recommended decision: APPROVE or DECLINE")
    private String suggestedDecision;

    @JsonPropertyDescription("Risk level: LOW, MEDIUM, or HIGH")
    private String riskLevel;

    @JsonPropertyDescription("2-3 sentence explanation of the recommendation")
    private String reasoning;

    @JsonPropertyDescription("3-5 bullet points highlighting key factors that influenced the recommendation")
    private List<String> keyFactors;

    @JsonPropertyDescription("A ready-to-use professional comment the approver can post as-is or edit — 1-2 sentences")
    private String draftComment;
}
