package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;

@Data @Entity @Table(name = "gl02_loc_mast")
@IdClass(Gl02LocMastId.class)
public class Gl02LocMast {
    @Id @Column(name = "loc", length = 3)            private String loc;
    @Id @Column(name = "whs", length = 3)            private String whs;
    @Column(name = "default_del_loc", length = 3)    private String defaultDelLoc;
    @Column(name = "default_del_whs", length = 3)    private String defaultDelWhs;
    @Column(name = "status", length = 1)             private String status;
    @Column(name = "loc_name", length = 30)          private String locName;
    @Column(name = "region", length = 3)             private String region;
    @Column(name = "use_loc_add", length = 1)        private String useLocAdd;
    @Column(name = "add_1", length = 35)             private String add1;
    @Column(name = "add_2", length = 35)             private String add2;
    @Column(name = "add_3", length = 35)             private String add3;
    @Column(name = "add_4", length = 35)             private String add4;
    @Column(name = "post_add_1", length = 35)        private String postAdd1;
    @Column(name = "post_add_2", length = 35)        private String postAdd2;
    @Column(name = "post_add_3", length = 35)        private String postAdd3;
    @Column(name = "post_add_4", length = 35)        private String postAdd4;
    @Column(name = "tel_no", length = 15)            private String telNo;
    @Column(name = "fax_no", length = 15)            private String faxNo;
    @Column(name = "branch_manager", length = 10)    private String branchManager;
    @Column(name = "stk_loc", length = 1)            private String stkLoc;
    @Column(name = "sales_whs", length = 1)          private String salesWhs;
    @Column(name = "pur_whs", length = 1)            private String purWhs;
    @Column(name = "replen_whs", length = 1)         private String replenWhs;
    @Column(name = "dc_whs", length = 1)             private String dcWhs;
    @Column(name = "bo_whs", length = 1)             private String boWhs;
    @Column(name = "ibt_whs", length = 1)            private String ibtWhs;
    @Column(name = "dispatch_whs", length = 1)       private String dispatchWhs;
    @Column(name = "bin_qty_tracking", length = 1)   private String binQtyTracking;
    @Column(name = "allow_del_loc_chg", length = 1)  private String allowDelLocChg;
    @Column(name = "default_del_area", length = 4)   private String defaultDelArea;
    @Column(name = "web_enabled", length = 1)        private String webEnabled;
    @Column(name = "inv_type", length = 1)           private String invType;
    @Column(name = "pos_tender_type", length = 1)    private String posTenderType;
    @Column(name = "pos_cashup_type", length = 1)    private String posCashupType;
    @Column(name = "loc_inv_prt")                    private Integer locInvPrt;
    @Column(name = "serial_prt")                     private Integer serialPrt;
}
