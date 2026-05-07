package com.xact.sy195.dto;

import com.fasterxml.jackson.annotation.JsonClassDescription;
import com.fasterxml.jackson.annotation.JsonPropertyDescription;
import lombok.Data;

import java.util.Map;

/**
 * AI-generated filter suggestions for sy195 bulk export pages.
 * The filters map contains field-name → value pairs matching the
 * frontend filter state for the requested module.
 */
@Data
@JsonClassDescription("Suggested export filter values for an sy195 bulk export page")
public class FilterSuggestionResponse {

    @JsonPropertyDescription(
        "Map of filter field names to their suggested values. " +
        "Only include fields that should be changed from their defaults. " +
        "For Debtors: startAcct, endAcct, masterAcct (A/M/S), delAcct (A/N/D), " +
        "status (ALL/OPEN/CLOSED), crStatus (ALL/GOOD/HOLD/COD), " +
        "balance (ALL/POSITIVE/NEGATIVE/ZERO), foreignTracked (ALL/Y/N). " +
        "For Stock: startCode, endCode, status (ALL/ACTIVE/DISCONTINUED). " +
        "For Creditors: startAcct, endAcct, status (ALL/OPEN/CLOSED). " +
        "For GL: startGl, endGl, accountType (ALL/BS/IS).")
    private Map<String, String> filters;

    @JsonPropertyDescription("Brief explanation of the chosen filter values in one sentence")
    private String reasoning;
}
