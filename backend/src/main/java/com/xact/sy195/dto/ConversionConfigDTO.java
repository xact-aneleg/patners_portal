package com.xact.sy195.dto;

import lombok.Data;

@Data
public class ConversionConfigDTO {
    private String module;          // debtors, stock, creditors, gl
    private String delimiter = ","; // field delimiter
    private int headerLineNo  = 1;  // which row is the header
    private boolean emptyTable = false; // truncate before import (admin only)
}
