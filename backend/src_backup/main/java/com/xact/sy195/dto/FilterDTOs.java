package com.xact.sy195.dto;
import lombok.Data;

public class FilterDTOs {

    @Data public static class DebtorFilterDTO {
        // Range — real PK is dl_code VARCHAR(8)
        private String startAcct    = "!";
        private String endAcct      = "~";
        // Master account filter
        private String masterAcct   = "A";   // A=all E=excl-masters M=master-only
        private Boolean sortByLoc   = false;
        // Location filter
        private String startLoc     = "";
        private String endLoc       = "~~~";
        // Category filter
        private Boolean filterCat   = false;
        private String startCat     = "";
        private String endCat       = "~~~";
        // Rep filter — real field: rep_code VARCHAR(5)
        private Boolean filterRep   = false;
        private String repType      = "R";   // R=rep_code M=mkt_rep
        private String startRep     = "";
        private String endRep       = "~~~";
        // Status filter — real field: status VARCHAR(1)
        private String status       = "ALL";
        // Credit status — real field: cr_status VARCHAR(4)
        private String crStatus     = "ALL"; // ALL GOOD HOLD COD
        // Balance — real field: balance NUMERIC(13,2)
        private String balance      = "ALL"; // ALL B=non-zero Z=zero
        // Foreign currency — real field: track_by_foreign_currency VARCHAR(1)
        private String foreignTracked = "ALL";
        // Address only — real field: address_only_acct VARCHAR(1)
        private String delAcct      = "A";
    }

    @Data public static class StockFilterDTO {
        // Range — real PK is stk_code VARCHAR(16)
        private String startStkCode = "!";
        private String endStkCode   = "~";
        private String masterAcct   = "A";
        // Group filter — real field: stk_grp VARCHAR(5)
        private String stkSelection = "C";
        private String startStkGrp  = "";
        private String endStkGrp    = "~~~";
        // Status — real field: status VARCHAR(1)
        private String status       = "ALL";
        // Flags — all VARCHAR(1) in real schema
        private String webEnabled   = "ALL";
        private String retailEnabled = "ALL";
        private String tradeInItems  = "ALL";
        private String importItems   = "ALL";
        private String keepBalance   = "ALL";
    }

    @Data public static class CreditorFilterDTO {
        // Range — real PK is cl_code VARCHAR(8)
        private String startAcct    = "!";
        private String endAcct      = "~";
        private String masterAccount = "A";
        private Boolean filterCat   = false;
        private String startCat     = "";
        private String endCat       = "~~~";
        // Status — real field: status VARCHAR(1)
        private String status       = "ALL";
        // real field: track_by_foreign_currency VARCHAR(1)
        private String foreignTracked = "ALL";
        // real field: ic_acct VARCHAR(1)
        private String interCo      = "ALL";
        // real field: import_acct VARCHAR(1)
        private String importAccts  = "ALL";
    }

    @Data public static class GlFilterDTO {
        // Range — real PK is gl_code VARCHAR(8)
        private String startCode    = "!";
        private String endCode      = "~";
        // Status — real field: status VARCHAR(1)
        private String status       = "ALL";
        // real field: acct_type VARCHAR(1) — B=balance sheet P=P&L
        private String acctType     = "A";
        // real field: post VARCHAR(1) — P=posting S=sub-total
        private String postSubTot   = "A";
        // real field: budget_based_on VARCHAR(1)
        private String budgetBasedOn = "ALL";
    }

    @Data public static class ImportResultDTO {
        private int    rowNumber;
        private String tableName;
        private String fieldName;
        private String keyField;
        private String exception;
        private String status;

        public ImportResultDTO() {}
        public ImportResultDTO(int row, String table, String field, String key, String exc, String status) {
            this.rowNumber = row; this.tableName = table; this.fieldName = field;
            this.keyField = key; this.exception = exc; this.status = status;
        }
    }

    @Data public static class ImportResponseDTO {
        private int totalRows;
        private int imported;
        private int errors;
        private java.util.List<ImportResultDTO> results = new java.util.ArrayList<>();
    }
}
