package com.xact.sy195.service;

import org.springframework.stereotype.Service;

/**
 * Port of lf_invalid_chars_in_string / lf_invalid_chars_in_string_no_prompt
 * from sy_lib.4gl (Genero BDL).
 *
 * String types:
 *   C  — Codes / key fields (dl_code, cl_code, stk_code, gl_code …)
 *   B  — Basic (uppercase + digits only)
 *   D  — Descriptions
 *   SP — Stock code specifications
 *   S  — Serial numbers
 *   E  — Email addresses
 *   T  — Telephone numbers
 *   N  — Numeric
 *   DT — Dates (digits and hyphens)
 *   %  — Percentage (0–100)
 */
@Service
public class ValidationService {

    /**
     * Returns true if the string contains invalid characters for the given type.
     * Mirrors the Genero RETURN TRUE = invalid logic.
     */
    public boolean hasInvalidChars(String value, String type) {
        if (value == null || value.isEmpty()) return false;

        if ("%".equals(type)) {
            try {
                double d = Double.parseDouble(value);
                return d > 100; // < 0 is allowed per the Genero code (returns FALSE)
            } catch (NumberFormatException e) {
                return true;
            }
        }

        for (int i = 0; i < value.length(); i++) {
            char c = value.charAt(i);
            if (!isValidChar(c, type)) return true;
        }
        return false;
    }

    /**
     * Validate a field value and return an error message, or null if valid.
     */
    public String validate(String fieldName, String value, String type, boolean required) {
        if (value == null || value.isBlank()) {
            return required ? fieldName + " cannot be blank" : null;
        }
        if (hasInvalidChars(value, type)) {
            return fieldName + " contains invalid characters for type " + type + ": '" + value + "'";
        }
        return null;
    }

    // ── Per-character rules — direct port from Genero CASE statement ──────────

    private boolean isValidChar(char c, String type) {
        return switch (type) {

            case "B" -> // Basic: uppercase + digits
                isUpper(c) || isDigit(c);

            case "C" -> // Codes/key fields
                isUpper(c) || isDigit(c)
                || c == '#' || c == '.' || c == '-' || c == '/'
                || c == '+' || c == '=' || c == '[' || c == ']' || c == ':';

            case "S" -> // Serial numbers
                isUpper(c) || isDigit(c)
                || c == ' ' || c == '#' || c == ':' || c == '-' || c == '/'
                || c == '_' || c == '.' || c == '+' || c == '*' || c == '='
                || c == '!' || c == '$' || c == '%' || c == '@' || c == '&'
                || c == '[' || c == ']' || c == '(' || c == ')';

            case "SP" -> // Stock code specifications
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == ','
                || c == '\'' || c == ':' || c == '+' || c == '=' || c == '!'
                || c == '$' || c == '%' || c == '@' || c == '*' || c == '#'
                || c == '&' || c == '[' || c == ']' || c == '(' || c == ')'
                || c == '\n' || c == '/';

            case "D" -> // Descriptions (no commas — breaks CSV reports)
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == ':'
                || c == '+' || c == '*' || c == '=' || c == '#' || c == '!'
                || c == '$' || c == '%' || c == '@' || c == '&' || c == '['
                || c == ']' || c == '(' || c == ')' || c == '/';

            case "DT" -> // Date
                isDigit(c) || c == '-';

            case "E" -> // Email (comma allows multiple addresses)
                isUpper(c) || isLower(c) || isDigit(c)
                || c == '.' || c == '@' || c == '-' || c == '_' || c == ',';

            case "L" -> // Lookup
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == '+'
                || c == '=' || c == '!' || c == '$' || c == '%' || c == '@'
                || c == '&' || c == '[' || c == ']' || c == '(' || c == ')'
                || c == '*' || c == '#' || c == '/';

            case "N" -> // Numeric
                isDigit(c) || c == '.';

            case "P" -> // Program name
                isLower(c) || isDigit(c) || c == '_' || c == '.';

            case "A" -> // Attachments
                isUpper(c) || isLower(c) || isDigit(c)
                || c == '_' || c == '-' || c == '.';

            case "user" -> // Username
                isLower(c) || isDigit(c) || c == '-' || c == '_' || c == '.';

            case "passwd" -> // Password
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == ':'
                || c == '+' || c == '=' || c == '!' || c == '$' || c == '%'
                || c == '@' || c == '&' || c == '[' || c == ']' || c == '('
                || c == ')' || c == '#' || c == '/';

            case "R" -> // Rich lookup
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == '+'
                || c == '=' || c == '!' || c == '$' || c == '%' || c == '@'
                || c == '&' || c == '[' || c == ']' || c == '(' || c == ')'
                || c == '*' || c == '<' || c == '>' || c == '/';

            case "T" -> // Telephone
                isDigit(c) || c == '(' || c == ')' || c == '/' || c == ' ';

            case "U" -> // URL-like
                isUpper(c) || isLower(c) || isDigit(c)
                || c == '-' || c == '_' || c == '.' || c == '+' || c == '='
                || c == '!' || c == '$' || c == '%' || c == '@' || c == '&'
                || c == '[' || c == ']' || c == '(' || c == ')' || c == '/';

            case "VN" -> // VAT Normal
                isDigit(c) || c == '(' || c == ')' || c == '/' || c == ' ';

            case "VE" -> // VAT Export
                isUpper(c) || isDigit(c) || c == '(' || c == ')' || c == '/' || c == ' ';

            case "Q" -> // Quote Terms
                isUpper(c) || isLower(c) || isDigit(c)
                || c == ' ' || c == '-' || c == '_' || c == '.' || c == ','
                || c == ':' || c == '+' || c == '=' || c == '!' || c == '$'
                || c == '%' || c == '@' || c == '&' || c == '[' || c == ']'
                || c == '(' || c == ')' || c == '"' || c == '\n' || c == '/';

            case "FC" -> // File category
                isUpper(c) || isDigit(c);

            default -> true; // unknown type — allow everything
        };
    }

    private boolean isUpper(char c)  { return c >= 'A' && c <= 'Z'; }
    private boolean isLower(char c)  { return c >= 'a' && c <= 'z'; }
    private boolean isDigit(char c)  { return c >= '0' && c <= '9'; }
}
