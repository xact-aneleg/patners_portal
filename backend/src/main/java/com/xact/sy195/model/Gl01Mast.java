package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;

@Data @Entity @Table(name = "gl01_mast")
public class Gl01Mast {
    @Id @Column(name = "gl_code", length = 8)       private String glCode;
    @Column(name = "descr", length = 40)             private String descr;
    @Column(name = "status", length = 1)             private String status;
    @Column(name = "acct_type", length = 1)          private String acctType;
    @Column(name = "post", length = 1)               private String post;
    @Column(name = "control", length = 8)            private String control;
    @Column(name = "detail_trans", length = 1)       private String detailTrans;
    @Column(name = "loc_anal", length = 1)           private String locAnal;
    @Column(name = "budget", length = 1)             private String budget;
    @Column(name = "budget_based_on", length = 1)    private String budgetBasedOn;
    @Column(name = "note_no")                        private Integer noteNo = 0;
    @Column(name = "interface_acct", length = 1)     private String interfaceAcct;
    @Column(name = "block_posting", length = 1)      private String blockPosting;
    @Column(name = "last_gl30_row_id")               private Integer lastGl30RowId = 0;
}
