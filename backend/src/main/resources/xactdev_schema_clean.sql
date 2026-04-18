--
-- PostgreSQL database dump
--


-- Dumped from database version 16.13 (Ubuntu 16.13-1.pgdg24.04+1)
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: -
--



--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--



--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--



--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--



SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: arb_dl01_pend_accts; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_dl01_pend_accts (
    dl_code character varying(10) NOT NULL,
    dl_name character varying(40),
    first_name character varying(40),
    last_name character varying(40),
    tel_1 character varying(22),
    tel_2 character varying(22),
    email character varying(80),
    loc character varying(3),
    phy_add_1 character varying(30),
    phy_add_2 character varying(30),
    phy_add_3 character varying(30),
    phy_add_4 character varying(30),
    post_code character varying(4),
    vat_no character varying(12),
    co_reg character varying(17),
    status character varying(1)
);



--
-- Name: arb_ib32_pallet_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib32_pallet_hd (
    wt_load_no integer DEFAULT 0 NOT NULL,
    rec_date date,
    ship_date date,
    status character varying(2) DEFAULT 'IT'::character varying,
    ship_loc character varying(3),
    ship_whs character varying(3),
    rec_loc character varying(3),
    rec_whs character varying(3),
    complete_date date,
    times_recounted integer DEFAULT 0
);



--
-- Name: arb_ib32p_pallet_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib32p_pallet_dt (
    wt_load_no integer DEFAULT 0 NOT NULL,
    co_db_name character varying(20) DEFAULT 'arb_db'::character varying NOT NULL,
    pallet_id character varying(20) NOT NULL,
    status character varying(2) DEFAULT 'P'::character varying,
    confirm_by character varying(10),
    confirm_date date,
    confirm_time time(0) without time zone,
    comment character varying(255)
);



--
-- Name: arb_ib33_prod_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib33_prod_dt (
    wt_load_no integer DEFAULT 0 NOT NULL,
    co_db_name character varying(20) DEFAULT 'arb_db'::character varying NOT NULL,
    pallet_id character varying(20) NOT NULL,
    prod_code character varying(16) NOT NULL,
    status character varying(2) DEFAULT 'OS'::character varying,
    shipped_qty numeric(11,3) DEFAULT 0,
    first_rec_qty numeric(11,3) DEFAULT 0,
    rec_qty numeric(11,3) DEFAULT 0,
    damaged_qty numeric(11,3) DEFAULT 0,
    variance_qty numeric(11,3) DEFAULT 0,
    label_qty numeric(11,3) DEFAULT 0,
    updated_by character varying(10),
    comment character varying(255)
);



--
-- Name: arb_ib33s_prod_ser; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib33s_prod_ser (
    wt_load_no integer DEFAULT 0 NOT NULL,
    co_db_name character varying(20) DEFAULT 'arb_db'::character varying NOT NULL,
    pallet_id character varying(20) NOT NULL,
    prod_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    shipped_qty numeric(11,3) DEFAULT 0,
    first_rec_qty numeric(11,3) DEFAULT 0,
    rec_qty numeric(11,3) DEFAULT 0,
    damaged_qty numeric(11,3) DEFAULT 0,
    variance_qty numeric(11,3) DEFAULT 0
);



--
-- Name: arb_ib34_prod_adj_req; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib34_prod_adj_req (
    wt_load_no integer DEFAULT 0 NOT NULL,
    co_db_name character varying(20) DEFAULT 'arb_db'::character varying NOT NULL,
    prod_code character varying(16) NOT NULL,
    send_loc_adj numeric(11,3) DEFAULT 0,
    rec_loc_adj numeric(11,3) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    capture_by character varying(10),
    capture_date date,
    capture_time time(0) without time zone,
    comment character varying(255)
);



--
-- Name: arb_ib34s_serial_adj_req; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ib34s_serial_adj_req (
    wt_load_no integer DEFAULT 0 NOT NULL,
    co_db_name character varying(20) DEFAULT 'arb_db'::character varying NOT NULL,
    prod_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    send_loc_adj numeric(11,3) DEFAULT 0,
    rec_loc_adj numeric(11,3) DEFAULT 0,
    capture_by character varying(10),
    capture_date date,
    capture_time time(0) without time zone,
    comment character varying(255)
);



--
-- Name: arb_ic_xref_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ic_xref_dt (
    sell_co_so character varying(11) NOT NULL,
    sell_co_inv character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    stk_code character varying(16),
    stk_desc character varying(40),
    doc_qty numeric(11,3) DEFAULT 0
);



--
-- Name: arb_ic_xref_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ic_xref_hd (
    sell_db character varying(20) NOT NULL,
    sell_co_so character varying(11) NOT NULL,
    sell_co_inv character varying(11) NOT NULL,
    sell_co_grn character varying(11),
    stk_db character varying(20),
    stk_co_so character varying(11),
    stk_co_inv character varying(11)
);



--
-- Name: arb_ic_xref_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_ic_xref_serial (
    sell_co_so character varying(11) NOT NULL,
    sell_co_inv character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    sell_serial_no character varying(25),
    stk_serial_no character varying(25),
    serial_qty numeric(11,3) DEFAULT 0
);



--
-- Name: arb_pu22a_status; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_pu22a_status (
    doc_no character varying(11) NOT NULL,
    status character varying(1)
);



--
-- Name: arb_sa22_qt_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_sa22_qt_hd (
    struct_no character varying(11) NOT NULL,
    status character varying(1),
    loc character varying(3),
    whs character varying(3),
    dl_code character varying(8),
    dl_name character varying(40),
    struct_date date,
    due_date date,
    valid_date date,
    proj_name character varying(40),
    gen_qt_no character varying(94),
    gen_so_no character varying(94),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    split_del_qty character varying(1),
    disc_level_from character varying(1),
    tot_price numeric(13,2),
    tot_cost numeric(13,2),
    tot_gp_perc numeric(7,2),
    last_sa23_arb_row_id integer
);



--
-- Name: arb_sa23_qt_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_sa23_qt_dt (
    struct_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer DEFAULT 0,
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    qty numeric(11,3) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    disc_lvl character varying(1),
    unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    gross_cost numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,2) DEFAULT 0,
    last_sa23b_arb_row_id integer DEFAULT 0
);



--
-- Name: arb_sa23b_qt_comp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_sa23b_qt_comp (
    struct_no character varying(11) NOT NULL,
    sa23_arb_row_id integer NOT NULL,
    comp_row_id integer NOT NULL,
    comp_sort_pos integer DEFAULT 0,
    comp_code character varying(16),
    comp_desc_1 character varying(40),
    comp_desc_2 character varying(40),
    comp_type character varying(3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_cost numeric(13,2) DEFAULT 0,
    comp_disc_level character varying(5),
    comp_price numeric(13,2) DEFAULT 0,
    comp_tot_cost numeric(13,2) DEFAULT 0,
    comp_tot_price numeric(13,2) DEFAULT 0,
    comp_tot_gp numeric(7,2) DEFAULT 0,
    comp_tot_req_qty numeric(11,3) DEFAULT 0
);



--
-- Name: arb_sa23d_so_split; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_sa23d_so_split (
    struct_no character varying(11) NOT NULL,
    split_row_id integer DEFAULT 0 NOT NULL,
    due_date date,
    perc_qty numeric(3,0)
);



--
-- Name: arb_sa290_sales_anal; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.arb_sa290_sales_anal (
    user_name character varying(10) NOT NULL,
    type character varying(25) NOT NULL,
    section character varying(25) NOT NULL,
    stk_grp character varying(25) NOT NULL,
    loc character varying(3) NOT NULL,
    value numeric(13,2) DEFAULT 0
);



--
-- Name: bm00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm00_sys_opt (
    row_id integer DEFAULT 0 NOT NULL,
    wo_issue_based_on character varying(1),
    mths_to_keep_hist integer DEFAULT 0,
    form_prog_wo character varying(25),
    prt_00_wo character varying(1),
    create_po_on_mrp character varying(1),
    prt_stores_req character varying(1),
    stores_req_prog character varying(25),
    allow_activity_tracking character varying(1),
    input_act_on_recpt character varying(1),
    allow_activate_no_stk character varying(1),
    restrict_zero_qty_recpt character varying(1),
    default_qty_on_first_issue character varying(1),
    update_bom_act_on_recpt character varying(1),
    no_wo_for_ave_bom_calc integer DEFAULT 0,
    update_bom_stk_cost character varying(1),
    last_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0
);



--
-- Name: bm01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm01_doc_no (
    loc character varying(3) NOT NULL,
    first_wo integer DEFAULT 0,
    last_wo integer DEFAULT 0,
    cur_wo integer DEFAULT 0
);



--
-- Name: bm03_act_res; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm03_act_res (
    act_code character varying(16) NOT NULL,
    date date NOT NULL,
    no_resource integer DEFAULT 0,
    aval_min numeric(13,2) DEFAULT 0,
    act_min numeric(13,2) DEFAULT 0
);



--
-- Name: bm04_grp_type; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm04_grp_type (
    bom_type character varying(3) NOT NULL,
    bom_grp character varying(3),
    type_desc character varying(14)
);



--
-- Name: bm06_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm06_grp (
    bom_grp character varying(3) NOT NULL,
    bom_grp_desc character varying(15),
    bom_grp_type character varying(3)
);



--
-- Name: bm08_sub_calc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm08_sub_calc (
    sub_code character varying(16) NOT NULL,
    expl_qty numeric(11,3) DEFAULT 0
);



--
-- Name: bm10_bom_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm10_bom_hd (
    bom_stk_code character varying(16) NOT NULL,
    status character varying(1) DEFAULT 'A'::character varying,
    draw_no character varying(10),
    bom_struct_based_on numeric(11,3) DEFAULT 0,
    create_by character varying(10),
    create_date date,
    amend_by character varying(10),
    amend_date date,
    inst character varying(1500),
    last_bm11_row_id integer DEFAULT 0
);



--
-- Name: bm11_bom_comp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm11_bom_comp (
    bom_stk_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    prt_ind character varying(1),
    stk_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    grp character varying(3),
    type character varying(3),
    qty numeric(11,3) DEFAULT 0
);



--
-- Name: bm11i_bom_inst; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm11i_bom_inst (
    bom_stk_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    instructions character varying(1000)
);



--
-- Name: bm20_rec_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm20_rec_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    wo_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    stk_code character varying(16),
    descr character varying(40),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    reqd_qty numeric(11,3),
    recpt_qty numeric(11,3),
    unit_cost numeric(13,2),
    tot_cost numeric(13,2),
    complete_wo character varying(1),
    new_wo_no character varying(11),
    pro_rata character varying(1)
);



--
-- Name: bm20i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm20i_bin_alloc (
    wo_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3)
);



--
-- Name: bm21_iss_ret_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm21_iss_ret_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3),
    tran_type character varying(4),
    stk_code character varying(16),
    descr character varying(40),
    uom character varying(10),
    qty numeric(11,3) DEFAULT 0,
    cost numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    gl_code character varying(8),
    st30_row_id integer DEFAULT 0,
    last_bm21_row_id integer DEFAULT 0
);



--
-- Name: bm21i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm21i_bin_alloc (
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    bin_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3)
);



--
-- Name: bm21s_iss_ret_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm21s_iss_ret_serial (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    org_serial_no character varying(25),
    pack_code character varying(4),
    serial_qty numeric(11,3) DEFAULT 0
);



--
-- Name: bm22_prod_plan_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm22_prod_plan_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    status character varying(1),
    batch_desc character varying(30),
    started_by character varying(10),
    date_started date,
    target_date date,
    loc character varying(250),
    whs character varying(250),
    stk_grps character varying(100),
    sales_mths integer DEFAULT 0,
    perc_of_ave_sales numeric(7,2) DEFAULT 0,
    sales_freq character varying(1),
    tdh integer DEFAULT 0,
    ltm numeric(3,1) DEFAULT 0,
    gened_by character varying(10),
    gened_date date,
    last_bm23_row_id integer DEFAULT 0
);



--
-- Name: bm23_prod_plan_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm23_prod_plan_dt (
    batch_no integer DEFAULT 0 NOT NULL,
    stk_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    replen_status character varying(1),
    line_type character varying(1),
    stk_desc_1 character varying(40),
    stk_desc_2 character varying(40),
    uom character varying(8),
    phy_bal numeric(11,0) DEFAULT 0,
    out_po numeric(11,0) DEFAULT 0,
    out_so numeric(11,0) DEFAULT 0,
    wip_hold numeric(11,3) DEFAULT 0,
    wip_in_prod numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,0) DEFAULT 0,
    pbt_qty numeric(11,0) DEFAULT 0,
    ams_qty numeric(11,0) DEFAULT 0,
    tdh_qty numeric(11,0) DEFAULT 0,
    lt_mths numeric(3,1) DEFAULT 0,
    lt_qty numeric(11,0) DEFAULT 0,
    short_qty numeric(11,0) DEFAULT 0,
    short_reorder_qty numeric(11,0) DEFAULT 0,
    wo_no character varying(11),
    wo_loc character varying(3),
    wo_whs character varying(3),
    wo_qty numeric(11,0) DEFAULT 0,
    tot_ord_qty numeric(11,0) DEFAULT 0,
    ord_qty numeric(11,0) DEFAULT 0,
    ord_loc character varying(3),
    ord_whs character varying(3),
    po_per_split_date character varying(1),
    po_no character varying(11),
    po_confirm_req_by character varying(10),
    po_confirm_req_date date,
    po_confirm_req_time time(0) without time zone,
    po_confirmed character varying(1),
    po_confirmed_qty numeric(11,3) DEFAULT 0,
    po_confirmed_by character varying(10),
    po_confirmed_date date,
    po_confirmed_time time(0) without time zone,
    cl_code character varying(8),
    cl_name character varying(40),
    import_order character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    unit_price numeric(11,2) DEFAULT 0,
    unit_price_forex numeric(13,5) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_price numeric(11,2) DEFAULT 0,
    net_price_forex numeric(13,5) DEFAULT 0,
    split_date character varying(1),
    del_date_1 date,
    del_qty_1 numeric(11,0) DEFAULT 0,
    del_date_2 date,
    del_qty_2 numeric(11,0) DEFAULT 0,
    del_date_3 date,
    del_qty_3 numeric(11,0) DEFAULT 0,
    del_date_4 date,
    del_qty_4 numeric(13,2) DEFAULT 0,
    del_date_5 date,
    del_qty_5 numeric(13,2) DEFAULT 0,
    del_date_6 date,
    del_qty_6 numeric(13,2) DEFAULT 0
);



--
-- Name: bm23fore_close_bal; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm23fore_close_bal (
    batch_no integer DEFAULT 0 NOT NULL,
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    bm23_row_id integer DEFAULT 0 NOT NULL,
    month date NOT NULL,
    po_due numeric(11,3) DEFAULT 0,
    so_due numeric(11,3) DEFAULT 0,
    ibt_due numeric(11,3) DEFAULT 0
);



--
-- Name: bm23po_shortfall_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm23po_shortfall_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    cl_code character varying(8) NOT NULL,
    po_no character varying(11) NOT NULL,
    cl_name character varying(40),
    po_loc character varying(3),
    del_to_1 character varying(30),
    del_to_2 character varying(30),
    del_to_3 character varying(30),
    del_to_4 character varying(30),
    req_date date,
    date_confirmed character varying(1),
    cred_ref character varying(20),
    delivery_by character varying(15),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    contact character varying(15),
    ord_value numeric(13,2) DEFAULT 0
);



--
-- Name: bm23r_shortfall_dt_raw; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm23r_shortfall_dt_raw (
    batch_no integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    replen_type character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    est_qty numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    req_qty numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_price numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    bm23_row_id integer DEFAULT 0
);



--
-- Name: bm23s_shortfall_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm23s_shortfall_dt (
    batch_no integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    replen_type character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    est_qty numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    req_qty numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_price numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    bm23_row_id integer DEFAULT 0
);



--
-- Name: bm30_wo_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm30_wo_hd (
    wo_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(8),
    source character varying(2),
    js_job_no character varying(11),
    stk_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    wo_type character varying(1),
    principle_wo character varying(11),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    due_date date,
    predict_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    purged_by character varying(10),
    purged_date date,
    purged_time time(0) without time zone,
    dl_code character varying(8),
    dl_name character varying(40),
    bom_struct_based_on numeric(11,3) DEFAULT 0,
    qty_reqd numeric(11,3) DEFAULT 0,
    qty_complete numeric(11,3) DEFAULT 0,
    req_cost_non_stk numeric(13,2) DEFAULT 0,
    req_cost_stk numeric(13,2) DEFAULT 0,
    req_cost_bo numeric(13,2) DEFAULT 0,
    req_cost_tot numeric(13,2) DEFAULT 0,
    iss_cost_non_stk numeric(13,2) DEFAULT 0,
    iss_cost_stk numeric(13,2) DEFAULT 0,
    iss_cost_bo numeric(13,2) DEFAULT 0,
    iss_cost_tot numeric(13,2) DEFAULT 0,
    rec_cost_non_stk numeric(13,2) DEFAULT 0,
    rec_cost_stk numeric(13,2) DEFAULT 0,
    rec_cost_bo numeric(13,2) DEFAULT 0,
    rec_cost_tot numeric(13,2) DEFAULT 0,
    unit_sell numeric(13,2) DEFAULT 0,
    urgent character varying(1),
    last_wo_row_id integer DEFAULT 0,
    last_bm32_del_no integer DEFAULT 0
);



--
-- Name: bm31_wo_comp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm31_wo_comp (
    wo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    stk_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    bom_grp character varying(3),
    bom_type character varying(3),
    uom character varying(15),
    req_cost_non_stk numeric(13,2) DEFAULT 0,
    req_cost_stk numeric(13,2) DEFAULT 0,
    req_cost_bo numeric(13,2) DEFAULT 0,
    iss_cost_non_stk numeric(13,2) DEFAULT 0,
    iss_cost_stk numeric(13,2) DEFAULT 0,
    iss_cost_bo numeric(13,2) DEFAULT 0,
    rec_cost_non_stk numeric(13,2) DEFAULT 0,
    rec_cost_stk numeric(13,2) DEFAULT 0,
    rec_cost_bo numeric(13,2) DEFAULT 0,
    qty_reqd numeric(11,3) DEFAULT 0,
    qty_issued numeric(11,3) DEFAULT 0,
    qty_due numeric(11,3) DEFAULT 0,
    qty_rec numeric(11,3) DEFAULT 0,
    qty_in_stock numeric(11,3) DEFAULT 0,
    qty_short numeric(11,3) DEFAULT 0,
    act_item character varying(1),
    act_current character varying(1),
    act_que_status character varying(2),
    act_que_sort integer DEFAULT 0
);



--
-- Name: bm31i_wo_inst; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm31i_wo_inst (
    wo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    instructions character varying(1000)
);



--
-- Name: bm32_wo_dn_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm32_wo_dn_hd (
    bm30_wo_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3),
    dl_code character varying(8),
    dl_name character varying(33),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    times_printed integer DEFAULT 0,
    last_bm33_row_id integer DEFAULT 0
);



--
-- Name: bm33_wo_dn_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm33_wo_dn_dt (
    bm30_wo_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    item_type character varying(3),
    prod_code character varying(16),
    prt_ind character varying(1),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    req_qty numeric(11,3),
    issued_qty numeric(11,3),
    qty_due numeric(11,3),
    now_del_qty numeric(11,3),
    qty_in_stock numeric(11,3),
    qty_short numeric(11,3),
    ovr_issue_reason character varying(40)
);



--
-- Name: bm35_act_average; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm35_act_average (
    bom_stk_code character varying(16) NOT NULL,
    bm31_row_id integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    wo_no character varying(11) NOT NULL,
    wo_rec_date date,
    act_qty numeric(11,3)
);



--
-- Name: bm38_bottleneck_batch_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm38_bottleneck_batch_hd (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    batch_no integer NOT NULL,
    status character varying(1),
    ave_sales_for_last integer,
    perc_of_ave_sales numeric(11,3),
    phy_bal_outage_in_mths numeric(11,3),
    selection character varying(2) DEFAULT 'N'::character varying,
    start_selection character varying(4),
    end_selection character varying(4),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone
);



--
-- Name: bm39m_bottleneck_material; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm39m_bottleneck_material (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    row_id integer NOT NULL,
    desc_1 character varying(40),
    req_qty numeric(11,3),
    phy_bal numeric(11,3),
    qty_short numeric(11,3),
    po_no character varying(11),
    cl_code character varying(8),
    po_qty_due numeric(11,3),
    next_exp_date date,
    next_exp_qty numeric(11,3),
    ord_qty numeric(11,3),
    supp_code character varying(8)
);



--
-- Name: bm39p_bottleneck_pri_wo; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm39p_bottleneck_pri_wo (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    row_id integer NOT NULL,
    mover_type character varying(1),
    desc_1 character varying(40),
    ave_sales numeric(11,3),
    qty_outage numeric(11,3),
    phy_bal numeric(11,3),
    qty_short numeric(11,3),
    wo_no character varying(11),
    wo_type character varying(3),
    linked_wo character varying(1),
    status character varying(1),
    wo_qty_req numeric(11,3),
    wo_split_qty numeric(11,3),
    add_wo_qty numeric(11,3),
    flag_as_urgent character varying(1)
);



--
-- Name: bm39s_bottleneck_sub_wo; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bm39s_bottleneck_sub_wo (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    row_id integer NOT NULL,
    desc_1 character varying(40),
    req_qty numeric(11,3),
    phy_bal numeric(11,3),
    qty_short numeric(11,3),
    wo_no character varying(11),
    wo_type character varying(3),
    status character varying(1),
    act_queue character varying(3),
    wo_qty_req numeric(11,3),
    wo_split_qty numeric(11,3),
    add_wo_qty numeric(11,3),
    flag_as_urgent character varying(1)
);



--
-- Name: bo00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bo00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer DEFAULT 0,
    list_gp numeric(7,2) DEFAULT 0,
    restrict_cost_viewing character varying(1),
    restrict_replace_viewing character varying(1),
    restrict_value_viewing character varying(1),
    min_margin numeric(7,2) DEFAULT 0,
    force_bo_via_so character varying(1),
    auto_gen_buyout character varying(10),
    form_prog_auto_gen_buyout character varying(25),
    prt_barcode_on_recpt character varying(1),
    rebate_increase numeric(7,2) DEFAULT 0,
    gl_val character varying(8),
    gl_pib character varying(8),
    gl_woff character varying(8),
    gl_ibt_in_transit character varying(8),
    gl_reval character varying(8),
    gl_rebate character varying(8),
    gl_rebate_supp character varying(8),
    gl_sales character varying(8),
    gl_cost character varying(8),
    last_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0
);



--
-- Name: bo01_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bo01_mast (
    bo_code character varying(16) NOT NULL,
    status character varying(1),
    loc character varying(3),
    whs character varying(3),
    bo_sec character varying(25),
    desc_1 character varying(40),
    desc_2 character varying(40),
    stk_code_link character varying(16),
    create_by character varying(10),
    create_date date,
    req_by character varying(10),
    rec_date date,
    uom character varying(4),
    unit_qty numeric(11,3),
    cost numeric(13,2),
    list_price numeric(13,2),
    list_price_incl numeric(13,2),
    open_bal numeric(11,3),
    recpt numeric(11,3),
    sales numeric(11,3),
    adj numeric(11,3),
    phy_bal numeric(11,3),
    so_tot numeric(11,3),
    po_tot numeric(11,3),
    grv_req numeric(11,3),
    res_pick numeric(11,3),
    wt_res numeric(11,3),
    ib_req numeric(11,3),
    ibt numeric(11,3),
    wip numeric(11,3),
    wip_issues numeric(11,3),
    inv_allocated numeric(11,3),
    remarks character varying(35),
    paid_thru_pos character varying(1),
    period_purged date,
    last_bo30_row_id integer
);



--
-- Name: bo10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bo10_ctrl_tot (
    period date NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    sales numeric(13,2) DEFAULT 0,
    cred_note numeric(13,2) DEFAULT 0,
    rec numeric(13,2) DEFAULT 0,
    adj numeric(13,2) DEFAULT 0,
    ibt numeric(13,2) DEFAULT 0,
    woff numeric(13,2) DEFAULT 0,
    stk_adj numeric(13,2) DEFAULT 0,
    reval numeric(13,2) DEFAULT 0,
    reval_mth_end numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0
);



--
-- Name: bo20_adj_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bo20_adj_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    tran_type character varying(3),
    bo_code character varying(16),
    descr character varying(40),
    qty numeric(11,3) DEFAULT 0,
    cost numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    bo30_row_id integer DEFAULT 0
);



--
-- Name: bo30_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.bo30_tran (
    bo_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    create_by character varying(10),
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    period date,
    tran_date date,
    tran_time time(0) without time zone,
    batch_no integer DEFAULT 0,
    tran_type character varying(3),
    ref_1 character varying(20),
    ref_2 character varying(20),
    qty numeric(11,3) DEFAULT 0,
    unit_price numeric(13,2) DEFAULT 0,
    unit_price_incl numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    doc_row_id integer DEFAULT 0
);



--
-- Name: cb00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer,
    restrict_bank_chg character varying(1),
    block_cb_view_untagged character varying(1),
    block_dl_view_untagged character varying(1),
    block_cl_view_untagged character varying(1),
    restrict_cb_tag character varying(1),
    restrict_dl_tag character varying(1),
    restrict_cl_tag character varying(1),
    auto_tag_acct_type_cod character varying(1),
    auto_tag_acct_type_good character varying(1),
    auto_tag_acct_type_hold character varying(1),
    auto_tag_acct_type_pos character varying(1),
    auto_tag_split_batch_by_cat character varying(1),
    cb_restrict_jnl_maint character varying(1),
    cb_restrict_jnl_upd character varying(1),
    cb_restrict_stop_ord_maint character varying(1),
    cb_restrict_stop_ord_upd character varying(1),
    cb_restrict_acct_tran_maint character varying(1),
    cb_restrict_acct_tran_upd character varying(1),
    cb_restrict_frx_reval_maint character varying(1),
    cb_restrict_frx_reval_upd character varying(1),
    cb_restrict_gen_frx_rev_maint character varying(1),
    no_user_to_auth_bank_chg integer,
    multi_bank character varying(1),
    lines_batch_limit integer,
    gl_bank_cost character varying(8),
    gl_interest character varying(8),
    gl_forex_var character varying(8),
    gl_vat_out character varying(8),
    gl_vat_in character varying(8),
    gl_inter_acct character varying(8),
    last_batch_no integer,
    last_cb29_row_id integer,
    last_cb30_row_id integer,
    last_cb40_row_id integer,
    last_sy41_no integer
);



--
-- Name: cb00gl_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb00gl_sys_opt (
    bank_type character varying(1) NOT NULL,
    gl_bank character varying(8) NOT NULL,
    sort_pos integer DEFAULT 0,
    descr character varying(30),
    enable_import character varying(1),
    forex_acct character varying(1) DEFAULT 'N'::character varying,
    foreign_currency character varying(10),
    bank_code character varying(20),
    bank_name character varying(40),
    bank_acct_no character varying(35)
);



--
-- Name: cb01_benef_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb01_benef_mast (
    beneficiary_code character varying(6) NOT NULL,
    supp_ref character varying(20),
    beneficiary_name character varying(40),
    tel_no character varying(22),
    fax_no character varying(22),
    contact character varying(29),
    bank character varying(20),
    bank_code character varying(15),
    branch character varying(20),
    branch_code character varying(15),
    acct_type character varying(2),
    bank_acct character varying(16),
    prev_bank character varying(20),
    prev_bank_code character varying(15),
    prev_branch character varying(20),
    prev_branch_code character varying(15),
    prev_acct_type character varying(2),
    prev_bank_acc character varying(16),
    bank_chg character varying(1),
    bank_chg_app_1 character varying(10),
    bank_chg_app_2 character varying(10)
);



--
-- Name: cb05_bank_stmt_layout; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb05_bank_stmt_layout (
    bank_code character varying(20) NOT NULL,
    bank_name character varying(40),
    file_extension character varying(5),
    process_from_line_x integer DEFAULT 0,
    process_up_till_line_x integer DEFAULT 0,
    date_format character varying(10),
    decimal_points character varying(1),
    field_delimiter character varying(1),
    acct_on_hd character varying(1),
    acct_col_pos integer DEFAULT 0,
    acct_row_pos integer DEFAULT 0,
    acct_cell_pos_from integer DEFAULT 0,
    acct_cell_pos_to integer DEFAULT 0,
    tran_sort_order character varying(1),
    col_1 character varying(20),
    col_2 character varying(20),
    col_3 character varying(20),
    col_4 character varying(20),
    col_5 character varying(20),
    col_6 character varying(20),
    col_7 character varying(20),
    col_8 character varying(20),
    col_9 character varying(20),
    col_10 character varying(20),
    col_11 character varying(20),
    col_12 character varying(20),
    col_13 character varying(20),
    col_14 character varying(20),
    col_15 character varying(20)
);



--
-- Name: cb05s_bank_tran_type; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb05s_bank_tran_type (
    bank_code character varying(20) NOT NULL,
    bank_type character varying(20) NOT NULL,
    cb_tran_type character varying(6),
    dl_tran_type character varying(6),
    cl_tran_type character varying(6)
);



--
-- Name: cb10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb10_ctrl_tot (
    bank_acct character varying(8) NOT NULL,
    period date NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    open_bal_forex numeric(13,2) DEFAULT 0,
    deposit numeric(13,2) DEFAULT 0,
    deposit_forex numeric(13,2) DEFAULT 0,
    payments numeric(13,2) DEFAULT 0,
    payments_forex numeric(13,2) DEFAULT 0,
    stop_order numeric(13,2) DEFAULT 0,
    stop_order_forex numeric(13,2) DEFAULT 0,
    bank_cost numeric(13,2) DEFAULT 0,
    bank_cost_forex numeric(13,2) DEFAULT 0,
    interest numeric(13,2) DEFAULT 0,
    interest_forex numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0,
    close_bal_forex numeric(13,2) DEFAULT 0,
    unpresent numeric(13,2) DEFAULT 0,
    unpresent_forex numeric(13,2) DEFAULT 0,
    import_not_updated numeric(13,2) DEFAULT 0,
    import_not_updated_forex numeric(13,2) DEFAULT 0,
    bank_bal numeric(13,2) DEFAULT 0,
    bank_bal_forex numeric(13,2) DEFAULT 0,
    frx numeric(13,2) DEFAULT 0,
    vat_in numeric(13,2) DEFAULT 0,
    vat_in_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cb20_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb20_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    tran_desc character varying(35),
    tran_date date,
    tran_type character varying(3),
    ref character varying(20),
    inter_acct_tran_type character varying(3),
    inter_acct_ref character varying(20),
    foreign_currency character varying(10),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    vat_val numeric(13,2) DEFAULT 0,
    vat_val_forex numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    gross_forex numeric(13,2) DEFAULT 0,
    reval_cb30_row_id integer DEFAULT 0,
    reval_exchange_rate numeric(13,2) DEFAULT 0,
    reval_outstanding numeric(13,2) DEFAULT 0,
    reval_value numeric(13,2) DEFAULT 0,
    cb40_row_id integer DEFAULT 0,
    last_cb20gl_row_id integer DEFAULT 0
);



--
-- Name: cb20gl_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb20gl_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    cb20_row_id integer DEFAULT 0 NOT NULL,
    gl_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    gl_code character varying(8),
    gl_desc character varying(30),
    loc character varying(3),
    gl_narr character varying(40),
    gl_amount numeric(13,2) DEFAULT 0,
    gl_amount_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cb29_in_tray; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb29_in_tray (
    period date NOT NULL,
    bank_acct character varying(8) NOT NULL,
    source character varying(2) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    batch_no integer DEFAULT 0,
    src_row_id integer DEFAULT 0,
    tran_type character varying(3),
    tran_date date,
    ref character varying(30),
    gl_narr character varying(40),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,2) DEFAULT 0,
    presented character varying(6),
    match_type character varying(1),
    cb40_row_id integer DEFAULT 0
);



--
-- Name: cb30_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb30_tran (
    bank_acct character varying(8) NOT NULL,
    period date NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    source character varying(2),
    batch_no integer DEFAULT 0,
    create_by character varying(10),
    tran_type character varying(3),
    tran_date date,
    ref character varying(30),
    gl_narr character varying(40),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,5) DEFAULT 0,
    vat_value numeric(13,2) DEFAULT 0,
    vat_value_forex numeric(13,5) DEFAULT 0,
    presented character varying(6),
    match_type character varying(1),
    cb40_row_id integer DEFAULT 0
);



--
-- Name: cb40_statement_import; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb40_statement_import (
    bank_code character varying(20) NOT NULL,
    bank_acct character varying(20) NOT NULL,
    period date NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1) NOT NULL,
    page_no integer DEFAULT 0 NOT NULL,
    tran_date date NOT NULL,
    ref_1 character varying(40) NOT NULL,
    ref_2 character varying(40) NOT NULL,
    amount numeric(13,2) DEFAULT 0 NOT NULL,
    balance numeric(13,2) DEFAULT 0 NOT NULL,
    srce_module character varying(2),
    bank_tran_type character varying(8),
    import_by character varying(10),
    import_date date,
    import_time time(0) without time zone,
    tagged character varying(1),
    tagged_tran_type character varying(3),
    tagged_acct_code character varying(8),
    tagged_cb42_row_id integer,
    tagged_score numeric(13,2) DEFAULT 0,
    tagged_test_result integer,
    tagged_by character varying(10),
    tagged_date date,
    tagged_time time(0) without time zone,
    controller character varying(10),
    batch_no integer DEFAULT 0,
    gened_by character varying(10),
    gened_date date,
    gened_time time(0) without time zone,
    reversed_by character varying(10),
    reversed_date date,
    reversed_time time(0) without time zone,
    last_cb41_row_id integer DEFAULT 0
);



--
-- Name: cb40a_arb_statement_import; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb40a_arb_statement_import (
    bank_code character varying(20) NOT NULL,
    bank_acct character varying(20) NOT NULL,
    period date NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1) NOT NULL,
    page_no integer DEFAULT 0 NOT NULL,
    tran_date date NOT NULL,
    ref_1 character varying(40) NOT NULL,
    ref_2 character varying(40) NOT NULL,
    amount numeric(13,2) DEFAULT 0 NOT NULL,
    balance numeric(13,2) DEFAULT 0 NOT NULL,
    srce_module character varying(2),
    bank_tran_type character varying(8),
    import_by character varying(10),
    import_date date,
    import_time time(0) without time zone,
    tagged character varying(1),
    tagged_tran_type character varying(3),
    tagged_acct_code character varying(8),
    tagged_by character varying(10),
    tagged_date date,
    tagged_time time(0) without time zone,
    batch_no integer DEFAULT 0,
    gened_by character varying(10),
    gened_date date,
    gened_time time(0) without time zone,
    reversed_by character varying(10),
    reversed_date date,
    reversed_time time(0) without time zone,
    last_cb41_row_id integer DEFAULT 0
);



--
-- Name: cb41_statement_import_acct; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb41_statement_import_acct (
    bank_acct character varying(20) NOT NULL,
    cb40_row_id integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    tagged_acct_code character varying(8) NOT NULL,
    tagged_acct_value numeric(13,2) DEFAULT 0
);



--
-- Name: cb42_auto_tag_match_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cb42_auto_tag_match_log (
    bank_code character varying(20) NOT NULL,
    bank_acct character varying(20) NOT NULL,
    period date NOT NULL,
    cb40_row_id integer NOT NULL,
    row_id integer NOT NULL,
    status character varying(1) NOT NULL,
    page_no integer NOT NULL,
    tran_date date NOT NULL,
    ref_1 character varying(40) NOT NULL,
    ref_2 character varying(40) NOT NULL,
    amount numeric(13,2) NOT NULL,
    balance numeric(13,2) NOT NULL,
    hist_acct character varying(8),
    hist_source character varying(2),
    hist_tran_type character varying(3),
    cl22_batch_no integer,
    score numeric(13,2),
    test_passed integer
);



--
-- Name: cfs_bo00_auto_code; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cfs_bo00_auto_code (
    last_buyout_no integer DEFAULT 0 NOT NULL
);



--
-- Name: cl00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer DEFAULT 0,
    auth_bank_chg character varying(1),
    no_user_to_auth_bank_chg integer DEFAULT 0,
    email_eft_bank_file_to character varying(255),
    gen_bank_file_program character varying(40),
    restrict_secret_notes character varying(1),
    restrict_terms_chg character varying(1),
    restrict_detailed_enq character varying(1),
    restrict_block_recon character varying(1),
    cl_restrict_jnl_maint character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_jnl_upd character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_pay_maint character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_pay_upd character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_auto_adj_maint character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_auto_adj_upd character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_woff_maint character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_woff_upd character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_frx_reval_maint character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_frx_reval_upd character varying(1) DEFAULT 'N'::character varying,
    cl_restrict_gen_frx_rev_maint character varying(1) DEFAULT 'N'::character varying,
    vat_change_on_batch character varying(1),
    prt_recon_match character varying(1),
    auto_match_grv character varying(1) DEFAULT 'N'::character varying,
    form_prog_remit character varying(35),
    form_prog_recon character varying(35),
    gl_cred character varying(8),
    gl_disc character varying(8),
    gl_bank character varying(8),
    gl_woff character varying(8),
    gl_forex_var character varying(8),
    gl_vat_in character varying(8),
    gl_vat_out character varying(8),
    gl_sus character varying(8),
    remit_date date,
    remit_msg character varying(40),
    recon_note_1 character varying(50),
    recon_note_2 character varying(50),
    recon_note_3 character varying(50),
    last_pay_batch_no integer DEFAULT 0,
    last_jnl_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0,
    last_cl34_deal_no character varying(8)
);



--
-- Name: cl01_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01_mast (
    cl_code character varying(8) NOT NULL,
    cl_name character varying(40),
    status character varying(1),
    master_acct character varying(1),
    linked_acct character varying(8),
    tel_1 character varying(22),
    tel_2 character varying(22),
    fax_1 character varying(22),
    fax_2 character varying(22),
    email character varying(80),
    po_email character varying(80),
    cr_email character varying(80),
    rm_email character varying(80),
    controlled_by character varying(10),
    contact character varying(29),
    supp_acct_code character varying(15),
    vat_no character varying(12),
    co_reg character varying(17),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    post_code character varying(4),
    phy_add_1 character varying(30),
    phy_add_2 character varying(30),
    phy_add_3 character varying(30),
    phy_add_4 character varying(10),
    delivery_by character varying(4),
    del_area character varying(5),
    cl_cat character varying(5),
    bee_rating integer DEFAULT 0,
    bee_expiry_date date,
    opened_date date,
    amend_po_grn_add character varying(1),
    last_inv_date date,
    last_pay_date date,
    terms integer DEFAULT 0,
    terms_from character varying(1),
    sett_disc numeric(7,2) DEFAULT 0,
    cred_limit numeric(13,0) DEFAULT 0,
    block_recons character varying(1),
    block_internal_rebate character varying(1),
    incl_in_cb_auto_tag character varying(1) DEFAULT 'Y'::character varying,
    ic_acct character varying(1) DEFAULT 'N'::character varying,
    block_acct character varying(1),
    import_acct character varying(1),
    track_by_foreign_currency character varying(1),
    foreign_currency character varying(10),
    fx_terms_po_perc numeric(7,2) DEFAULT 0,
    fx_terms_po_days integer DEFAULT 0,
    fx_terms_bol_perc numeric(7,2) DEFAULT 0,
    fx_terms_bol_days integer DEFAULT 0,
    fx_terms_grn_perc numeric(7,2) DEFAULT 0,
    fx_terms_grn_days integer DEFAULT 0,
    bank_name character varying(20),
    bank_code character varying(15),
    bank_branch_name character varying(20),
    bank_branch_code character varying(15),
    bank_acct_type character varying(2),
    bank_acct_no character varying(35),
    prev_bank_name character varying(20),
    prev_bank_code character varying(15),
    prev_bank_branch character varying(20),
    prev_bank_branch_code character varying(15),
    prev_acct_type character varying(2),
    prev_bank_acct_no character varying(35),
    approval_pending character varying(1),
    bank_chg_app_1 character varying(10),
    bank_chg_app_2 character varying(10),
    balance numeric(13,2) DEFAULT 0,
    balance_forex numeric(13,2) DEFAULT 0,
    age_cur numeric(13,2) DEFAULT 0,
    age_cur_forex numeric(13,2) DEFAULT 0,
    age_30 numeric(13,2) DEFAULT 0,
    age_30_forex numeric(13,2) DEFAULT 0,
    age_60 numeric(13,2) DEFAULT 0,
    age_60_forex numeric(13,2) DEFAULT 0,
    age_90 numeric(13,2) DEFAULT 0,
    age_90_forex numeric(13,2) DEFAULT 0,
    age_120 numeric(13,2) DEFAULT 0,
    age_120_forex numeric(13,2) DEFAULT 0,
    age_120_plus numeric(13,2) DEFAULT 0,
    age_120_plus_forex numeric(13,2) DEFAULT 0,
    po_out numeric(13,2) DEFAULT 0,
    po_out_forex numeric(13,2) DEFAULT 0,
    grn_out numeric(13,2) DEFAULT 0,
    grn_out_forex numeric(13,2) DEFAULT 0,
    pay_allocated numeric(13,2) DEFAULT 0,
    pay_allocated_forex numeric(13,2) DEFAULT 0,
    recon_stat_bal numeric(13,2) DEFAULT 0,
    recon_stat_date date,
    recon_pay_date date,
    edi_program character varying(100),
    edi_delivery character varying(1),
    edi_script character varying(255),
    last_cl30_row_id integer DEFAULT 0,
    last_cl33_row_id integer DEFAULT 0
);



--
-- Name: cl01a_actions; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01a_actions (
    cl_code character varying(8) NOT NULL,
    call_date date NOT NULL,
    call_time time(0) without time zone NOT NULL,
    note character varying(200),
    create_by character varying(10),
    chg_by character varying(10),
    chg_date date,
    chg_time time(0) without time zone,
    action_date date
);



--
-- Name: cl01c_contact; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01c_contact (
    cl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    cl_name character varying(18),
    "position" character varying(10),
    cell character varying(10),
    email character varying(80)
);



--
-- Name: cl01n_notes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01n_notes (
    cl_code character varying(8) NOT NULL,
    static character varying(1000),
    secret character varying(1000),
    pu_doc_remarks character varying(255)
);



--
-- Name: cl01p_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01p_per_tot (
    cl_code character varying(8) NOT NULL,
    period date NOT NULL,
    pur_value numeric(13,2) DEFAULT 0,
    pur_value_forex numeric(13,2) DEFAULT 0,
    fore_value numeric(13,2) DEFAULT 0,
    fore_value_forex numeric(13,2) DEFAULT 0,
    pay_value numeric(13,2) DEFAULT 0,
    pay_value_forex numeric(13,2) DEFAULT 0,
    disc_value numeric(13,2) DEFAULT 0,
    disc_value_forex numeric(13,2) DEFAULT 0,
    ic_purchase_value numeric(13,2) DEFAULT 0
);



--
-- Name: cl01r_supp_rebate; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01r_supp_rebate (
    cl_code character varying(8) NOT NULL,
    stk_grp character varying(5) NOT NULL,
    rebate_type character varying(1) NOT NULL,
    rebate_calc character varying(1) NOT NULL,
    supp_rebate_perc numeric(7,2) DEFAULT 0
);



--
-- Name: cl01sc_sub_cat; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl01sc_sub_cat (
    cl_code character varying(8) NOT NULL,
    cl_sub_cat character varying(5) NOT NULL
);



--
-- Name: cl06_cat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl06_cat_mast (
    cl_cat character varying(5) NOT NULL,
    cat_desc character varying(20),
    include_cb_tagging character varying(1) DEFAULT 'Y'::character varying
);



--
-- Name: cl10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl10_ctrl_tot (
    period date NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    inv numeric(13,2) DEFAULT 0,
    cr_note numeric(13,2) DEFAULT 0,
    jnl numeric(13,2) DEFAULT 0,
    frx numeric(13,2) DEFAULT 0,
    vat_in numeric(13,2) DEFAULT 0,
    vat_out numeric(13,2) DEFAULT 0,
    woff numeric(13,2) DEFAULT 0,
    pay numeric(13,2) DEFAULT 0,
    disc_amt numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0
);



--
-- Name: cl20_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl20_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    cl_code character varying(8),
    cl_name character varying(40),
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    foreign_currency character varying(10),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    vat_val numeric(13,2) DEFAULT 0,
    vat_val_forex numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    gross_forex numeric(13,2) DEFAULT 0,
    due_date date,
    sett_disc_amt numeric(13,2) DEFAULT 0,
    sett_disc_amt_forex numeric(13,2) DEFAULT 0,
    reval_cl30_row_id integer DEFAULT 0,
    reval_exchange_rate numeric(13,4) DEFAULT 0,
    reval_outstanding numeric(13,2) DEFAULT 0,
    reval_value numeric(13,2) DEFAULT 0,
    last_cl20gl_row_id integer DEFAULT 0
);



--
-- Name: cl20gl_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl20gl_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    cl20_row_id integer DEFAULT 0 NOT NULL,
    gl_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    gl_code character varying(8),
    gl_desc character varying(30),
    loc character varying(3),
    gl_narr character varying(40),
    gl_amount numeric(17,5) DEFAULT 0,
    gl_amount_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cl22_pay_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl22_pay_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    cl_code character varying(8),
    cl_name character varying(40),
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    foreign_currency character varying(10),
    exchange_rate numeric(13,4) DEFAULT 0,
    value_excl_vat numeric(13,2) DEFAULT 0,
    value_excl_vat_forex numeric(13,2) DEFAULT 0,
    value_incl_vat numeric(13,2) DEFAULT 0,
    value_incl_vat_forex numeric(13,2) DEFAULT 0,
    disc_recieved numeric(13,2) DEFAULT 0,
    disc_recieved_forex numeric(13,2) DEFAULT 0,
    tot_val_plus_disc_to_match numeric(13,2) DEFAULT 0,
    tot_val_disc_to_match_forex numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    vat_val numeric(13,2) DEFAULT 0,
    vat_val_forex numeric(13,2) DEFAULT 0,
    match_disc_allow numeric(13,2) DEFAULT 0,
    match_disc_allow_forex numeric(13,2) DEFAULT 0,
    tot_unmatched numeric(13,2) DEFAULT 0,
    tot_unmatched_forex numeric(13,2) DEFAULT 0,
    profit_or_loss_forex numeric(13,2) DEFAULT 0,
    cb40_row_id integer DEFAULT 0,
    last_cl22m_row_id integer DEFAULT 0
);



--
-- Name: cl22m_tr_match; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl22m_tr_match (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    cl22_row_id integer DEFAULT 0 NOT NULL,
    match_row_id integer DEFAULT 0 NOT NULL,
    cl30_row_id integer DEFAULT 0,
    cl30_due_date date,
    cl30_disc_allowed numeric(13,2) DEFAULT 0,
    cl30_disc_allowed_forex numeric(13,2) DEFAULT 0,
    cl30_exchange_rate numeric(13,4) DEFAULT 0,
    match_amt numeric(13,2) DEFAULT 0,
    match_amt_forex numeric(13,2) DEFAULT 0,
    match_disc_allow numeric(13,2) DEFAULT 0,
    match_disc_allow_forex numeric(13,2) DEFAULT 0,
    match_remarks character varying(41)
);



--
-- Name: cl30_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl30_tran (
    cl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    period date,
    source character varying(2),
    batch_no integer DEFAULT 0,
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    exchange_rate numeric(13,4) DEFAULT 0,
    due_date date,
    org_value numeric(13,2) DEFAULT 0,
    org_value_forex numeric(13,2) DEFAULT 0,
    bfw_value numeric(13,2) DEFAULT 0,
    bfw_value_forex numeric(13,2) DEFAULT 0,
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0,
    disc_allowed_amt numeric(13,2) DEFAULT 0,
    disc_allowed_amt_forex numeric(13,2) DEFAULT 0,
    age integer DEFAULT 0,
    value_matched numeric(13,2) DEFAULT 0,
    value_matched_forex numeric(13,2) DEFAULT 0,
    vat_value numeric(13,2) DEFAULT 0,
    vat_value_forex numeric(13,2) DEFAULT 0,
    hold character varying(1),
    recon_pay numeric(13,2) DEFAULT 0,
    recon_pay_forex numeric(13,2) DEFAULT 0,
    recon_disc_amt numeric(13,2) DEFAULT 0,
    recon_disc_amt_forex numeric(13,2) DEFAULT 0,
    recon_remarks character varying(41),
    last_cl31_row_id integer DEFAULT 0
);



--
-- Name: cl31_matched_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl31_matched_hist (
    cl_code character varying(8) NOT NULL,
    parent_row_id integer DEFAULT 0 NOT NULL,
    match_row_id integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    amt_matched numeric(13,2) DEFAULT 0,
    amt_matched_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cl32_unmatch_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl32_unmatch_hist (
    unmatch_period date NOT NULL,
    unmatch_batch_no integer DEFAULT 0 NOT NULL,
    cl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    batch_no integer DEFAULT 0,
    tran_type character varying(3),
    ref_1 character varying(20),
    ref_2 character varying(20),
    org_value numeric(13,2) DEFAULT 0,
    org_value_forex numeric(13,2) DEFAULT 0,
    bfw_value numeric(13,2) DEFAULT 0,
    bfw_value_forex numeric(13,2) DEFAULT 0,
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0,
    n_status character varying(1),
    n_batch_no integer DEFAULT 0,
    n_tran_type character varying(3),
    n_ref_1 character varying(20),
    n_ref_2 character varying(20),
    n_org_value numeric(13,2) DEFAULT 0,
    n_org_value_forex numeric(13,2) DEFAULT 0,
    n_bfw_value numeric(13,2) DEFAULT 0,
    n_bfw_value_forex numeric(13,2) DEFAULT 0,
    n_outstanding numeric(13,2) DEFAULT 0,
    n_outstanding_forex numeric(13,2) DEFAULT 0,
    unmatch_by character varying(10),
    unmatch_date date,
    unmatch_time time(0) without time zone
);



--
-- Name: cl33_recon_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl33_recon_tran (
    cl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0,
    hold character varying(1),
    remarks character varying(41)
);



--
-- Name: cl34_deal_sheet; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl34_deal_sheet (
    deal_detail_id character varying(40) NOT NULL,
    deal_no character varying(8),
    stk_code character varying(16),
    case_bar_code character varying(20),
    branch character varying(3),
    start_date date,
    end_date date,
    deal_title character varying(60),
    desc_2 character varying(50),
    uom_size integer DEFAULT 0,
    base_uom character varying(15),
    uom_qty numeric(13,2),
    uom_code character varying(14),
    cl_code character varying(8),
    status character varying(1),
    create_by character varying(10),
    create_date date,
    delete_date date,
    last_edit_date date,
    source character varying(8),
    remarks character varying(255),
    list_price_excl numeric(13,2),
    trade_disc numeric(13,2),
    trade_disc_type character varying(1),
    disc_1 numeric(13,2),
    disc_1_type character varying(1),
    disc_2 numeric(13,2),
    disc_2_type character varying(1),
    disc_3 numeric(13,2),
    disc_3_type character varying(1),
    disc_4 numeric(13,2),
    disc_4_type character varying(1),
    disc_5 numeric(13,2),
    disc_5_type character varying(1),
    disc_6 numeric(13,2),
    disc_6_type character varying(1),
    free_goods_qty integer DEFAULT 0,
    free_goods_repeat integer DEFAULT 0,
    swell_perc numeric(13,2),
    nett_price_excl numeric(13,2),
    nett_price_incl numeric(13,2),
    unit_price_excl numeric(13,2),
    unit_price_incl numeric(13,2),
    min_drop_qty numeric(13,2),
    member_tally numeric(13,2),
    tally_per_x_cases integer DEFAULT 0,
    tally_incl_bank character varying(1),
    member_subsidy numeric(13,2),
    subsidy_per_x_cases integer DEFAULT 0,
    subsidy_incl_bank character varying(1),
    member_direct numeric(13,2),
    direct_per_x_cases integer DEFAULT 0,
    direct_subsidy_incl_bank character varying(1),
    nett_cost_excl numeric(13,2),
    unit_cost_excl numeric(13,2),
    deal_header_id character varying(40),
    product_id character varying(40),
    unit_barcode character varying(20),
    price_list_id character varying(40),
    supplier_id character varying(40),
    case_price numeric(13,2),
    integration_key_id character varying(40)
);



--
-- Name: cl34b_branch_loc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl34b_branch_loc (
    deal_detail_id character varying(40) NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3)
);



--
-- Name: cl34l_linked_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl34l_linked_codes (
    deal_detail_id character varying(40) NOT NULL,
    row_id integer NOT NULL,
    linked_code_selection character varying(16)
);



--
-- Name: cl35_supplier_rebates; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl35_supplier_rebates (
    rebate_code character varying(8) NOT NULL,
    source character varying(2),
    status character varying(1),
    rebate_desc character varying(40),
    select_by character varying(2),
    select_range_indiv character varying(1),
    start_select character varying(16),
    end_select character varying(16),
    indiv_select character varying(255),
    remarks character varying(50),
    start_date date,
    end_date date,
    rebate_unit character varying(4),
    threshold_lvl numeric(13,2),
    payout_method character varying(4),
    claim_trigger character varying(4),
    rebate_perc numeric(7,2),
    claim_frequency character varying(1),
    days_from_inv integer,
    rebate_mandatory character varying(1),
    rebate_grp character varying(4),
    rebate_gl_code character varying(8),
    default_recon character varying(4),
    create_by character varying(10),
    create_date date,
    amend_by character varying(10),
    amend_date date,
    delete_by character varying(10),
    delete_date date
);



--
-- Name: cl36_supplier_rebates_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl36_supplier_rebates_dt (
    rebate_code character varying(8) NOT NULL,
    cl_code character varying(8) NOT NULL,
    claim_acct character varying(8)
);



--
-- Name: cl37_rebate_register; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl37_rebate_register (
    rebate_code character varying(8) NOT NULL,
    po_no character varying(11) NOT NULL,
    register_date date NOT NULL,
    register_time time(0) without time zone NOT NULL,
    status character varying(3),
    payout_method character varying(1),
    po_rebate_value numeric(13,2),
    grn_no character varying(11),
    grn_rebate_value numeric(13,2),
    rebate_due_date date,
    cl_debit_note_no character varying(25),
    supplier_crn_no character varying(25),
    supplier_crn_date date,
    supplier_crn_value numeric(13,2)
);



--
-- Name: cl38_deal_register; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl38_deal_register (
    status character varying(1),
    tally_no character varying(7) NOT NULL,
    loc character varying(3),
    cl_code character varying(8),
    cl_name character varying(40),
    po_no character varying(11),
    po_date date,
    po_value numeric(13,2),
    po_tally_value numeric(13,2),
    grn_no character varying(11),
    grn_date date,
    grn_value numeric(13,2),
    grn_tally_value numeric(13,2),
    tally_due_date date,
    supplier_debit_note character varying(25),
    debit_note_date date,
    sup_credit_note character varying(25),
    credit_note_date date,
    paid_value numeric(13,2)
);



--
-- Name: cl40_recon_hist_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl40_recon_hist_hd (
    period date NOT NULL,
    cl_code character varying(8) NOT NULL,
    cl_name character varying(40),
    tel_1 character varying(22),
    fax_1 character varying(22),
    cr_email character varying(80),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    contact character varying(29),
    controlled_by character varying(10),
    terms integer DEFAULT 0,
    sett_disc numeric(13,2) DEFAULT 0,
    exchange_rate numeric(13,4) DEFAULT 0,
    bank_name character varying(20),
    bank_branch_name character varying(20),
    bank_branch_code character varying(15),
    bank_acct_no character varying(35),
    recon_stat_bal numeric(13,2) DEFAULT 0,
    recon_stat_bal_forex numeric(13,2) DEFAULT 0,
    recon_stat_date date,
    recon_pay_date date,
    amt_due numeric(13,2) DEFAULT 0,
    amt_due_forex numeric(13,2) DEFAULT 0,
    disc_taken numeric(13,2) DEFAULT 0,
    disc_taken_forex numeric(13,2) DEFAULT 0,
    net_amt_due numeric(13,2) DEFAULT 0,
    net_amt_due_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cl41_recon_hist_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cl41_recon_hist_dt (
    period date NOT NULL,
    cl_code character varying(8) NOT NULL,
    grp_no integer NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    tran_type character varying(3),
    tran_date date,
    ref_1 character varying(20),
    ref_2 character varying(20),
    remarks character varying(41),
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0
);



--
-- Name: cnt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.cnt (
    count bigint
);



--
-- Name: dc_ibt_distribution_test_20250718144006; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dc_ibt_distribution_test_20250718144006 (
    _mb_row_id bigint NOT NULL,
    location_code character varying(255),
    location_description character varying(255),
    product_code character varying(255),
    description character varying(255),
    division character varying(255),
    volume bigint,
    classification character varying(255),
    velocity character varying(255),
    supplier_code character varying(255),
    supplier_description character varying(255),
    stock_on_hand boolean,
    average_cost_price double precision,
    selling_price boolean,
    stock_on_order boolean,
    backorders boolean,
    stock_on_hand_value boolean,
    model_stock_level boolean,
    model_stock_value boolean,
    lead_time_days bigint,
    safety_stock_days boolean,
    replenishment_cycle_days bigint,
    lead_time_units boolean,
    safety_stock_units boolean,
    replenishment_cycle_units boolean,
    avg_12_month_sales boolean,
    avg_12_month_forecasts boolean,
    avg_3_month_sales boolean,
    avg_3_month_forecasts boolean,
    re_order_point_units boolean,
    order_up_to_units boolean,
    status_description character varying(255),
    status_units boolean,
    status_value boolean,
    recommended_order bigint
);



--
-- Name: dc_ibt_distribution_test_20250718144006__mb_row_id_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE IF NOT EXISTS public.dc_ibt_distribution_test_20250718144006__mb_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: dc_ibt_distribution_test_20250718144006__mb_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public.dc_ibt_distribution_test_20250718144006__mb_row_id_seq OWNED BY public.dc_ibt_distribution_test_20250718144006._mb_row_id;


--
-- Name: dd01_tbl; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dd01_tbl (
    tbl_name character varying(30) NOT NULL,
    tbl_desc character varying(80),
    tbl_notes character varying(200),
    mob_enabled character varying(1) DEFAULT 'N'::character varying,
    arch_enabled character varying(1) DEFAULT 'N'::character varying,
    data_row_no integer,
    perc_growth numeric(7,2),
    estimated_rows integer,
    row_byte_size integer,
    tbl_kb_size integer
);



--
-- Name: dd02_col; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dd02_col (
    tbl_name character varying(30) NOT NULL,
    is_p_key character varying(1),
    col_seq integer NOT NULL,
    col_name character varying(30),
    col_type character varying(30),
    col_size character varying(4),
    col_desc character varying(255),
    col_default character varying(5),
    mob_enabled character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: dd03_idx; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dd03_idx (
    tbl_name character varying(30) NOT NULL,
    idx_name character varying(30) NOT NULL,
    idx_notes character varying(80),
    col_name1 character varying(30),
    col_1_desc character varying(1),
    col_name2 character varying(30),
    col_2_desc character varying(1),
    col_name3 character varying(30),
    col_3_desc character varying(1),
    col_name4 character varying(30),
    col_4_desc character varying(1),
    col_name5 character varying(30),
    col_5_desc character varying(1),
    col_name6 character varying(30),
    col_6_desc character varying(1) DEFAULT 'A'::character varying,
    col_name7 character varying(30),
    col_7_desc character varying(1) DEFAULT 'A'::character varying,
    col_name8 character varying(30),
    col_8_desc character varying(1) DEFAULT 'A'::character varying,
    col_name9 character varying(30),
    col_9_desc character varying(1) DEFAULT 'A'::character varying,
    col_name10 character varying(30),
    col_10_desc character varying(1) DEFAULT 'A'::character varying
);



--
-- Name: dd04_user; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dd04_user (
    user_name character varying(10) NOT NULL,
    user_priv character varying(4)
);



--
-- Name: dev_todos; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dev_todos (
    user_name character varying(10) NOT NULL,
    user_todo character varying(9999),
    in_use smallint
);



--
-- Name: dl00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer DEFAULT 0,
    target_based_on character varying(1),
    interest_rate numeric(7,2) DEFAULT 0,
    min_interest_charge numeric(13,2) DEFAULT 0,
    vat_change_on_batch character varying(1),
    restrict_terms_chg character varying(1),
    reduce_temp_cr_on_upd character varying(1) DEFAULT 'N'::character varying,
    default_temp_cr_valid_until integer DEFAULT 0,
    restrict_temp_cr_valid_until integer DEFAULT 0,
    restrict_temp_cr_limit_chg character varying(1) DEFAULT 'N'::character varying,
    restrict_cr_limit_chg character varying(1),
    restrict_max_cr_limit_chg character varying(1),
    restrict_access_by_loc character varying(1),
    restrict_discounts_by_menu character varying(1) DEFAULT 'N'::character varying,
    restrict_detailed_enq character varying(1),
    restrict_rep_enq character varying(1),
    restrict_opr_enq character varying(1),
    restrict_pos_type_change character varying(1) DEFAULT '0'::character varying,
    dl_restrict_jnl_maint character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_jnl_upd character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_woff_maint character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_woff_upd character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_recp_maint character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_recp_upd character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_auto_adj_maint character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_auto_adj_upd character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_int_charge_maint character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_int_charge_upd character varying(1) DEFAULT 'N'::character varying,
    dl_restrict_frx_reval_maint character varying(1),
    dl_restrict_frx_reval_upd character varying(1),
    dl_restrict_gen_frx_rev_maint character varying(1),
    prt_recon_match character varying(1),
    auto_match_crn character varying(1) DEFAULT 'N'::character varying,
    recon_jnl_limit numeric(13,2) DEFAULT 0,
    restrict_secret_notes character varying(1),
    email_for_stmt character varying(80),
    form_prog_stmt character varying(25),
    form_rep_stmt character varying(25),
    auto_hold_acct character varying(1),
    auto_hold_days integer DEFAULT 0,
    auto_hold_limit numeric(13,2) DEFAULT 0,
    gl_deb character varying(8),
    gl_pos_shortage_control character varying(8),
    gl_interest character varying(8),
    gl_disc character varying(8),
    gl_bank character varying(8),
    gl_bad_deb character varying(8),
    gl_forex_var character varying(8),
    gl_vat_in character varying(8),
    gl_vat_out character varying(8),
    gl_sus character varying(8),
    stmt_date date,
    stmt_msg1 character varying(40),
    stmt_msg2 character varying(40),
    stmt_prt_zero character varying(1),
    last_rec_batch_no integer DEFAULT 0,
    last_jnl_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0,
    custom_field_1_label character varying(24),
    is_custom_field_1_mandatory character varying(1),
    custom_field_2_label character varying(24),
    is_custom_field_2_mandatory character varying(1),
    custom_field_3_label character varying(24),
    is_custom_field_3_mandatory character varying(1),
    custom_field_4_label character varying(24),
    is_custom_field_4_mandatory character varying(1),
    custom_field_5_label character varying(24),
    is_custom_field_5_mandatory character varying(1),
    custom_field_6_label character varying(24),
    is_custom_field_6_mandatory character varying(1),
    custom_field_7_label character varying(24),
    is_custom_field_7_mandatory character varying(1),
    custom_field_8_label character varying(24),
    is_custom_field_8_mandatory character varying(1),
    custom_field_9_label character varying(24),
    is_custom_field_9_mandatory character varying(1),
    custom_field_10_label character varying(24),
    is_custom_field_10_mandatory character varying(1)
);



--
-- Name: dl01_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01_mast (
    dl_code character varying(8) NOT NULL,
    dl_name character varying(40),
    status character varying(1),
    master_acct character varying(1),
    address_only_acct character varying(1),
    linked_acct character varying(8),
    loc character varying(3),
    filing_code character varying(8),
    tel_1 character varying(22),
    tel_2 character varying(22),
    fax_1 character varying(22),
    fax_2 character varying(22),
    contact character varying(29),
    popi_conf character varying(1) DEFAULT 'N'::character varying,
    controlled_by character varying(10),
    cust_acct_code character varying(8),
    co_reg character varying(17),
    vat_no character varying(12),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    post_code character varying(4),
    phy_add_1 character varying(30),
    phy_add_2 character varying(30),
    phy_add_3 character varying(30),
    phy_add_4 character varying(20),
    delivery_by character varying(4),
    del_area character varying(5),
    dl_cat character varying(5),
    sync_dl_cat_disc character varying(1) DEFAULT 'N'::character varying,
    region character varying(5),
    rep_code character varying(5),
    mkt_rep character varying(5),
    class character varying(3),
    target_based_on character varying(1),
    send_stmt character varying(1),
    bee_rating integer DEFAULT 0,
    bee_expiry_date date,
    export_acct character varying(1),
    track_by_foreign_currency character varying(1),
    foreign_currency character varying(10),
    opened_date date,
    so_pick_stk character varying(1),
    inv_type character varying(1),
    inv_incl character varying(1),
    amend_so_inv_add character varying(1),
    auto_cession_of_inv character varying(1),
    auto_email_inv_on_prt character varying(1) DEFAULT 'N'::character varying,
    enable_rounding character varying(1),
    incl_in_cb_auto_tag character varying(1) DEFAULT 'Y'::character varying,
    cr_limit_currency character varying(1) DEFAULT 'L'::character varying,
    cr_status character varying(4),
    terms integer DEFAULT 0,
    terms_from character varying(1),
    sett_disc numeric(7,2) DEFAULT 0,
    max_cr_limit numeric(13,2) DEFAULT 0,
    max_cr_limit_forex numeric(13,2) DEFAULT 0,
    cr_limit numeric(13,2) DEFAULT 0,
    cr_limit_forex numeric(13,2) DEFAULT 0,
    temp_cr_limit character varying(1),
    temp_cr_valid_until date,
    org_cr_limit numeric(13,2) DEFAULT 0,
    org_cr_limit_forex numeric(13,2) DEFAULT 0,
    deposit_held numeric(13,2) DEFAULT 0,
    deposit_held_forex numeric(13,2) DEFAULT 0,
    debtor_insurance numeric(13,2) DEFAULT 0,
    debtor_insurance_forex numeric(13,2) DEFAULT 0,
    enable_auto_hold character varying(1),
    charge_interest character varying(1),
    surety character varying(1),
    legal_action character varying(1),
    comment character varying(400),
    bank_code_1 character varying(1),
    bank_code_date_1 date,
    bank_code_amt_1 numeric(13,2) DEFAULT 0,
    bank_code_2 character varying(1),
    bank_code_amt_2 numeric(13,2) DEFAULT 0,
    bank_code_date_2 date,
    credit_rating character varying(2),
    email character varying(80),
    qt_email character varying(80),
    inv_email character varying(80),
    stmt_email character varying(80),
    pos_acct_pay numeric(13,2) DEFAULT 0,
    recpt_allocated numeric(13,2) DEFAULT 0,
    recpt_allocated_forex numeric(13,2) DEFAULT 0,
    next_mth_receipts numeric(13,2),
    next_mth_receipts_forex numeric(13,2),
    balance numeric(13,2) DEFAULT 0,
    balance_forex numeric(13,2) DEFAULT 0,
    age_cur numeric(13,2) DEFAULT 0,
    age_cur_forex numeric(13,2) DEFAULT 0,
    age_30 numeric(13,2) DEFAULT 0,
    age_30_forex numeric(13,2) DEFAULT 0,
    age_60 numeric(13,2) DEFAULT 0,
    age_60_forex numeric(13,2) DEFAULT 0,
    age_90 numeric(13,2) DEFAULT 0,
    age_90_forex numeric(13,2) DEFAULT 0,
    age_120 numeric(13,2) DEFAULT 0,
    age_120_forex numeric(13,2) DEFAULT 0,
    age_120_plus numeric(13,2) DEFAULT 0,
    age_120_plus_forex numeric(13,2) DEFAULT 0,
    so_bo_out numeric(13,2) DEFAULT 0,
    so_bo_out_forex numeric(13,2) DEFAULT 0,
    so_stk_out numeric(13,2) DEFAULT 0,
    so_stk_out_forex numeric(13,2) DEFAULT 0,
    daybook_inv_tot numeric(13,2) DEFAULT 0,
    daybook_inv_tot_forex numeric(13,2) DEFAULT 0,
    intertest_charged character varying(1),
    ic_acct character varying(1) DEFAULT 'N'::character varying,
    ic_min_gp_perc numeric(7,2) DEFAULT 0,
    auto_hold_active character varying(1),
    max_cr_limit_prev numeric(13,2) DEFAULT 0,
    max_cr_limit_prev_forex numeric(13,2) DEFAULT 0,
    max_cr_limit_chg_by character varying(10),
    max_cr_limit_chg_date date,
    max_cr_limit_chg_time time(0) without time zone,
    cr_limit_prev numeric(13,2) DEFAULT 0,
    cr_limit_prev_forex numeric(13,2) DEFAULT 0,
    cr_limit_chg_by character varying(10),
    cr_limit_chg_date date,
    cr_limit_chg_time time(0) without time zone,
    cr_status_prev character varying(4),
    cr_status_chg_by character varying(10),
    cr_status_chg_date date,
    cr_status_chg_time time(0) without time zone,
    last_inv_date date,
    last_pay_date date,
    last_dl30_row_id integer DEFAULT 0,
    custom_field_1 character varying(20),
    custom_field_2 character varying(20),
    custom_field_3 character varying(20),
    custom_field_4 character varying(20),
    custom_field_5 character varying(20),
    custom_field_6 character varying(20),
    custom_field_7 character varying(20),
    custom_field_8 character varying(20),
    custom_field_9 character varying(20),
    custom_field_10 character varying(20)
);



--
-- Name: dl01a_actions; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01a_actions (
    dl_code character varying(8) NOT NULL,
    call_date date NOT NULL,
    call_time time(0) without time zone NOT NULL,
    module character varying(1),
    note character varying(255),
    create_by character varying(10),
    chg_by character varying(10),
    chg_date date,
    chg_time time(0) without time zone,
    action_date date
);



--
-- Name: dl01c_contact; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01c_contact (
    dl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    type character varying(1),
    name character varying(18),
    "position" character varying(15),
    cell character varying(10),
    email character varying(80),
    id_no character varying(13),
    address character varying(120),
    popi_conf character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: dl01d_deb_stk_grp_disc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01d_deb_stk_grp_disc (
    dl_code character varying(8) NOT NULL,
    disc_type character varying(2) NOT NULL,
    disc_code character varying(25) NOT NULL,
    disc_level integer DEFAULT 0
);



--
-- Name: dl01n_notes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01n_notes (
    dl_code character varying(8) NOT NULL,
    static character varying(1000),
    secret character varying(1000),
    sa_doc_remarks character varying(255)
);



--
-- Name: dl01p_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01p_per_tot (
    dl_code character varying(8) NOT NULL,
    period date NOT NULL,
    sale_value numeric(13,2) DEFAULT 0,
    sale_value_forex numeric(13,2) DEFAULT 0,
    cost_value numeric(13,2) DEFAULT 0,
    cost_value_forex numeric(13,2) DEFAULT 0,
    fore_value numeric(13,2) DEFAULT 0,
    fore_value_forex numeric(13,2) DEFAULT 0,
    rec_value numeric(13,2) DEFAULT 0,
    rec_value_forex numeric(13,2) DEFAULT 0,
    disc_value numeric(13,2) DEFAULT 0,
    disc_value_forex numeric(13,2) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_sale_value_forex numeric(13,2) DEFAULT 0,
    ic_cost_value numeric(13,2) DEFAULT 0,
    ic_cost_value_forex numeric(13,2) DEFAULT 0,
    mth_end_status character varying(1),
    mth_end_legal_action character varying(1),
    mth_end_cr_status character varying(4),
    mth_end_balance numeric(13,2) DEFAULT 0,
    mth_end_balance_forex numeric(13,2) DEFAULT 0,
    mth_end_next_mth_receipts numeric(13,2) DEFAULT 0,
    mth_end_next_mth_recpts_forex numeric(13,2) DEFAULT 0,
    mth_end_age_cur numeric(13,2) DEFAULT 0,
    mth_end_age_cur_forex numeric(13,2) DEFAULT 0,
    mth_end_age_30 numeric(13,2) DEFAULT 0,
    mth_end_age_30_forex numeric(13,2) DEFAULT 0,
    mth_end_age_60 numeric(13,2) DEFAULT 0,
    mth_end_age_60_forex numeric(13,2) DEFAULT 0,
    mth_end_age_90 numeric(13,2) DEFAULT 0,
    mth_end_age_90_forex numeric(13,2) DEFAULT 0,
    mth_end_age_120 numeric(13,2) DEFAULT 0,
    mth_end_age_120_forex numeric(13,2) DEFAULT 0,
    mth_end_age_120_plus numeric(13,2) DEFAULT 0,
    mth_end_age_120_plus_forex numeric(13,2) DEFAULT 0,
    mth_end_ic_acct character varying(1),
    mth_end_sale_value_incl numeric(13,2) DEFAULT 0,
    mth_end_sale_value_incl_forex numeric(13,2) DEFAULT 0
);



--
-- Name: dl01pa_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01pa_per_tot (
    dl_code character varying(8) NOT NULL,
    period date NOT NULL,
    sale_value numeric(13,2) DEFAULT 0,
    cost_value numeric(13,2) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_cost_value numeric(13,2) DEFAULT 0
);



--
-- Name: dl01sc_sub_cat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl01sc_sub_cat_mast (
    dl_code character varying(8) NOT NULL,
    dl_sub_cat character varying(5) NOT NULL
);



--
-- Name: dl02_loyalty_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl02_loyalty_mast (
    cell_no character varying(22) NOT NULL,
    name character varying(50),
    email character varying(80),
    country character varying(2),
    post_code character varying(10),
    suburb character varying(100)
);



--
-- Name: dl03_region_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl03_region_mast (
    region character varying(5),
    region_desc character varying(20)
);



--
-- Name: dl04_cat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl04_cat_mast (
    dl_cat character varying(5) NOT NULL,
    cat_desc character varying(20),
    include_cb_tagging character varying(1) DEFAULT 'Y'::character varying
);



--
-- Name: dl04d_cat_stk_grp_disc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl04d_cat_stk_grp_disc (
    dl_cat character varying(5) NOT NULL,
    disc_type character varying(2) NOT NULL,
    disc_code character varying(25) NOT NULL,
    disc_level integer DEFAULT 0
);



--
-- Name: dl04sc_cat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl04sc_cat_mast (
    dl_sub_cat character varying(5),
    cat_desc character varying(30)
);



--
-- Name: dl05_class_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl05_class_mast (
    class character varying(3) NOT NULL,
    class_desc character varying(20)
);



--
-- Name: dl06_rep_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl06_rep_mast (
    rep_code character varying(5),
    loc character varying(3),
    rep_name character varying(30),
    std_comm numeric(7,2) DEFAULT 0,
    rev_or_profit character varying(1),
    target_based_on character varying(1),
    shared_rep_code character varying(1) DEFAULT 'Y'::character varying,
    email_profile character varying(10)
);



--
-- Name: dl06m_mkt_rep_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl06m_mkt_rep_per_tot (
    mkt_rep character varying(5) NOT NULL,
    period date NOT NULL,
    sale_value numeric(13,2),
    cost_value numeric(13,2),
    fore_value numeric(13,2),
    ic_sale_value numeric(13,2),
    ic_cost_value numeric(13,2)
);



--
-- Name: dl06p_rep_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl06p_rep_per_tot (
    rep_code character varying(5) NOT NULL,
    period date NOT NULL,
    sale_value numeric(13,2) DEFAULT 0,
    cost_value numeric(13,2) DEFAULT 0,
    fore_value numeric(13,2) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_cost_value numeric(13,2) DEFAULT 0
);



--
-- Name: dl07o_opr_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl07o_opr_per_tot (
    user_name character varying(10) NOT NULL,
    period date NOT NULL,
    sale_value numeric(13,2) DEFAULT 0,
    cost_value numeric(13,2) DEFAULT 0,
    fore_value numeric(13,2) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_cost_value numeric(13,2) DEFAULT 0
);



--
-- Name: dl10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl10_ctrl_tot (
    period date NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    inv numeric(13,2) DEFAULT 0,
    cr_note numeric(13,2) DEFAULT 0,
    jnl numeric(13,2) DEFAULT 0,
    interest numeric(13,2) DEFAULT 0,
    frx numeric(13,2) DEFAULT 0,
    vat_out numeric(13,2) DEFAULT 0,
    vat_in numeric(13,2) DEFAULT 0,
    woff numeric(13,2) DEFAULT 0,
    rec numeric(13,2) DEFAULT 0,
    disc_amt numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0
);



--
-- Name: dl20_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl20_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    dl_code character varying(8),
    dl_name character varying(40),
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    rep_code character varying(5),
    foreign_currency character varying(10),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    vat_val numeric(13,2) DEFAULT 0,
    vat_val_forex numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    gross_forex numeric(13,2) DEFAULT 0,
    due_date date,
    sett_disc_amt numeric(13,2) DEFAULT 0,
    sett_disc_amt_forex numeric(13,2) DEFAULT 0,
    reval_dl30_row_id integer,
    reval_exchange_rate numeric(13,4),
    reval_outstanding numeric(13,2),
    reval_value numeric(13,2),
    last_dl20gl_row_id integer DEFAULT 0
);



--
-- Name: dl20gl_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl20gl_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    dl20_row_id integer DEFAULT 0 NOT NULL,
    gl_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    gl_code character varying(8),
    gl_desc character varying(30),
    loc character varying(3),
    gl_narr character varying(40),
    gl_amount numeric(13,2) DEFAULT 0,
    gl_amount_forex numeric(13,2) DEFAULT 0
);



--
-- Name: dl22_rec_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl22_rec_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    dl_code character varying(8),
    dl_name character varying(40),
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    foreign_currency character varying(10),
    exchange_rate numeric(13,4) DEFAULT 0,
    value numeric(13,2) DEFAULT 0,
    value_forex numeric(13,2) DEFAULT 0,
    disc_taken numeric(13,2) DEFAULT 0,
    disc_taken_forex numeric(13,2) DEFAULT 0,
    tot_val_plus_disc_to_match numeric(13,2) DEFAULT 0,
    tot_val_plus_disc_match_forex numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    vat_val numeric(13,2) DEFAULT 0,
    vat_val_forex numeric(12,2) DEFAULT 0,
    match_disc_allow numeric(13,2) DEFAULT 0,
    match_disc_allow_forex numeric(13,2) DEFAULT 0,
    tot_unmatched numeric(13,2) DEFAULT 0,
    tot_unmatched_forex numeric(13,2) DEFAULT 0,
    profit_or_loss_forex numeric(13,2) DEFAULT 0,
    cb40_row_id integer DEFAULT 0,
    last_dl22m_row_id integer DEFAULT 0,
    rec_adj character varying(1),
    rec_adj_date date,
    rec_adj_due_date date,
    rec_adj_type character varying(3),
    rec_adj_ref_1 character varying(20),
    rec_adj_ref_2 character varying(20),
    rec_adj_age integer DEFAULT 0,
    rec_adj_value numeric(13,2) DEFAULT 0,
    rec_adj_value_forex numeric(13,2) DEFAULT 0,
    rec_adj_recon_remarks character varying(41)
);



--
-- Name: dl22m_tr_match; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl22m_tr_match (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    dl22_row_id integer DEFAULT 0 NOT NULL,
    match_row_id integer DEFAULT 0 NOT NULL,
    dl30_row_id integer DEFAULT 0,
    dl30_due_date date,
    dl30_disc_allowed numeric(13,2) DEFAULT 0,
    dl30_disc_allowed_forex numeric(13,2) DEFAULT 0,
    dl30_exchange_rate numeric(13,4),
    sa22_doc_no character varying(14),
    match_amt numeric(13,2) DEFAULT 0,
    match_amt_forex numeric(13,2) DEFAULT 0,
    match_disc_allow numeric(13,2) DEFAULT 0,
    match_disc_allow_forex numeric(13,2) DEFAULT 0,
    match_remarks character varying(41)
);



--
-- Name: dl30_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl30_tran (
    dl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    loc character varying(3),
    period date,
    dl_address_code character varying(8),
    source character varying(2),
    batch_no integer DEFAULT 0,
    tran_type character varying(3),
    deposit_paid numeric(13,2) DEFAULT 0,
    deposit_paid_forex numeric(13,2) DEFAULT 0,
    tran_date date,
    tran_time time(0) without time zone,
    rep_code character varying(5),
    sub_rep_code character varying(5),
    mkt_rep character varying(5),
    sub_mkt_rep character varying(5),
    create_by character varying(10),
    ref_1 character varying(20),
    ref_2 character varying(20),
    query_status character varying(1),
    exchange_rate numeric(13,4),
    due_date date,
    org_value numeric(13,2) DEFAULT 0,
    org_value_forex numeric(13,2) DEFAULT 0,
    bfw_value numeric(13,2) DEFAULT 0,
    bfw_value_forex numeric(13,2) DEFAULT 0,
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0,
    disc_allowed_amt numeric(13,2) DEFAULT 0,
    disc_allowed_amt_forex numeric(13,2) DEFAULT 0,
    age integer DEFAULT 0,
    value_matched numeric(13,2) DEFAULT 0,
    value_matched_forex numeric(13,2) DEFAULT 0,
    cost numeric(13,2) DEFAULT 0,
    cost_forex numeric(13,2) DEFAULT 0,
    vat_value numeric(13,2) DEFAULT 0,
    vat_value_forex numeric(13,2) DEFAULT 0,
    recon_remarks character varying(41),
    last_dl31_row_id integer DEFAULT 0
);



--
-- Name: dl31_matched_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl31_matched_hist (
    dl_code character varying(8) NOT NULL,
    parent_row_id integer DEFAULT 0 NOT NULL,
    match_row_id integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    amt_matched numeric(13,2) DEFAULT 0,
    amt_matched_forex numeric(13,2) DEFAULT 0
);



--
-- Name: dl32_unmatch_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl32_unmatch_hist (
    unmatch_period date NOT NULL,
    unmatch_batch_no integer DEFAULT 0 NOT NULL,
    dl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    batch_no integer DEFAULT 0,
    tran_type character varying(3),
    ref_1 character varying(20),
    ref_2 character varying(20),
    org_value numeric(13,2) DEFAULT 0,
    org_value_forex numeric(13,2) DEFAULT 0,
    bfw_value numeric(13,2) DEFAULT 0,
    bfw_value_forex numeric(13,2) DEFAULT 0,
    outstanding numeric(13,2) DEFAULT 0,
    outstanding_forex numeric(13,2) DEFAULT 0,
    n_status character varying(1),
    n_batch_no integer DEFAULT 0,
    n_tran_type character varying(3),
    n_ref_1 character varying(20),
    n_ref_2 character varying(20),
    n_org_value numeric(13,2) DEFAULT 0,
    n_org_value_forex numeric(13,2) DEFAULT 0,
    n_bfw_value numeric(13,2) DEFAULT 0,
    n_bfw_value_forex numeric(13,2) DEFAULT 0,
    n_outstanding numeric(13,2) DEFAULT 0,
    n_outstanding_forex numeric(13,2) DEFAULT 0,
    unmatch_by character varying(10),
    unmatch_date date,
    unmatch_time time(0) without time zone
);



--
-- Name: dl33_deposits; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl33_deposits (
    dl_code character varying(8) NOT NULL,
    batch_no integer NOT NULL,
    dl30_row_id integer NOT NULL,
    deposit_qt_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    deposit_date date,
    deposit_paid numeric(13,2) DEFAULT 0,
    deposit_paid_forex numeric(13,2) DEFAULT 0,
    outstanding_deposit numeric(13,2) DEFAULT 0,
    outstanding_deposit_forex numeric(13,2) DEFAULT 0,
    deposit_disc_allowed numeric(13,2) DEFAULT 0
);



--
-- Name: dl40_stmt_hist_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl40_stmt_hist_hd (
    period date NOT NULL,
    stmt_status character varying(1) DEFAULT 'M'::character varying NOT NULL,
    dl_code character varying(8) NOT NULL,
    dl_name character varying(40),
    date_last_printed date,
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    post_code character varying(4),
    phy_add_1 character varying(30),
    phy_add_2 character varying(30),
    phy_add_3 character varying(30),
    phy_add_4 character varying(20),
    tel_1 character varying(22),
    tel_2 character varying(22),
    fax_1 character varying(22),
    fax_2 character varying(22),
    terms integer DEFAULT 0,
    balance numeric(13,2) DEFAULT 0,
    age_cur numeric(13,2) DEFAULT 0,
    age_30 numeric(13,2) DEFAULT 0,
    age_60 numeric(13,2) DEFAULT 0,
    age_90 numeric(13,2) DEFAULT 0,
    age_120 numeric(13,2) DEFAULT 0,
    age_120_plus numeric(13,2) DEFAULT 0,
    contact character varying(29),
    email_to character varying(80)
);



--
-- Name: dl41_stmt_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dl41_stmt_dt (
    period date NOT NULL,
    stmt_status character varying(1) DEFAULT 'M'::character varying NOT NULL,
    dl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sb_dl_acct character varying(60),
    tran_date date,
    tran_type character varying(3),
    tran_time time(0) without time zone,
    ref_1 character varying(20),
    ref_2 character varying(20),
    vat_value numeric(13,2) DEFAULT 0,
    bfw_value numeric(13,2) DEFAULT 0,
    outstanding numeric(13,2) DEFAULT 0
);



--
-- Name: dx01d_db_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dx01d_db_mast (
    server character varying(15) NOT NULL,
    db character varying(15) NOT NULL
);



--
-- Name: dx01s_server_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dx01s_server_mast (
    server character varying(15) NOT NULL,
    port integer DEFAULT 0,
    ip character varying(30),
    company_db_name character varying(16),
    description character varying(255),
    filename character varying(255)
);



--
-- Name: dx02_mobile_users; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.dx02_mobile_users (
    user_name character varying(10) NOT NULL,
    status character varying(1),
    company_db_name character varying(20) NOT NULL,
    company_name character varying(45)
);



--
-- Name: gl00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer DEFAULT 0,
    gl_retained_rev character varying(8),
    gl_accrual character varying(8),
    gl_prepay character varying(8),
    gl_sus character varying(8),
    gl_restrict_cur_mth_maint character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_cur_mth_upd character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_pri_mth_maint character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_pri_mth_upd character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_auto_rev_maint character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_auto_rev_upd character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_std_mth_maint character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_std_mth_upd character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_jnl_import_upd character varying(1) DEFAULT 'N'::character varying,
    gl_restrict_gl_import_upd character varying(1) DEFAULT 'N'::character varying,
    last_batch_no integer DEFAULT 0,
    last_gl29_row_id integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0
);



--
-- Name: gl01_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl01_mast (
    gl_code character varying(8) NOT NULL,
    descr character varying(40),
    status character varying(1),
    acct_type character varying(1),
    post character varying(1),
    control character varying(8),
    detail_trans character varying(1),
    loc_anal character varying(1),
    budget character varying(1),
    budget_based_on character varying(1),
    note_no integer DEFAULT 0,
    interface_acct character varying(1),
    block_posting character varying(1),
    last_gl30_row_id integer DEFAULT 0
);



--
-- Name: gl02_loc_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl02_loc_mast (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    default_del_loc character varying(3),
    default_del_whs character varying(3),
    link_to_dc_loc character varying(3),
    link_to_dc_whs character varying(3),
    status character varying(1),
    loc_name character varying(30),
    region character varying(3),
    use_loc_add character varying(1),
    add_1 character varying(35),
    add_2 character varying(35),
    add_3 character varying(35),
    add_4 character varying(35),
    post_add_1 character varying(35),
    post_add_2 character varying(35),
    post_add_3 character varying(35),
    post_add_4 character varying(35),
    area_dialcode_international integer,
    area_dialcode_local integer,
    tel_no character varying(15),
    fax_no character varying(15),
    branch_manager character varying(10),
    stk_loc character varying(1),
    sales_whs character varying(1),
    sales_pick_stk_from character varying(1),
    pur_whs character varying(1),
    replen_whs character varying(1),
    dc_whs character varying(1),
    crossd_whs character varying(1),
    bo_whs character varying(1),
    ibt_whs character varying(1),
    ibt_pick_stk_from character varying(1),
    grv_stk_from character varying(1),
    dispatch_whs character varying(1),
    mrp_whs character varying(1),
    default_del_area character varying(4),
    bin_qty_tracking character varying(1),
    allow_del_loc_chg character varying(1),
    prt_pod_barcodes character varying(1),
    loc_inv_prt integer,
    pod_barcode_prt integer,
    serial_prt integer,
    staging_loc_prt integer,
    stores_dispatch_prt integer,
    stores_receive_prt integer,
    inv_cod_acct_thru_pos character varying(1),
    pos_tender_type character varying(1),
    pos_cashup_type character varying(1),
    pos_dl_cash_sale_acct character varying(8),
    pos_dl_collection_acct character varying(8),
    web_enabled character varying(1),
    click_collect_enabled character varying(1),
    web_sales_acct character varying(8),
    inv_type character varying(1),
    inv_page_1 character varying(1),
    inv_page_2 character varying(1),
    inv_page_3 character varying(1),
    inv_page_4 character varying(1)
);



--
-- Name: gl02wt_module; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl02wt_module (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    dispatch_receiving character varying(1) NOT NULL,
    module character varying(1) NOT NULL,
    enabled character varying(1)
);



--
-- Name: gl03f_fiscal_bal; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl03f_fiscal_bal (
    gl_code character varying(8) NOT NULL,
    loc character varying(3) NOT NULL,
    year integer DEFAULT 0 NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    tot_move numeric(13,2) DEFAULT 0,
    tot_budget numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0
);



--
-- Name: gl03p_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl03p_per_tot (
    gl_code character varying(8) NOT NULL,
    loc character varying(3) NOT NULL,
    period date NOT NULL,
    move_value numeric(13,2) DEFAULT 0,
    budget_value numeric(13,2) DEFAULT 0
);



--
-- Name: gl04_region_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl04_region_mast (
    region character varying(5),
    region_desc character varying(30)
);



--
-- Name: gl05_report_notes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl05_report_notes (
    note_no integer DEFAULT 0 NOT NULL,
    note_line character varying(75)
);



--
-- Name: gl06_report_title; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl06_report_title (
    title_code character varying(6) NOT NULL,
    title_desc character varying(30),
    title_note_no integer DEFAULT 0
);



--
-- Name: gl07_report_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl07_report_hd (
    report_code character varying(6) NOT NULL,
    report_head_1 character varying(40),
    report_head_2 character varying(40),
    pitch character varying(2),
    print_zero character varying(1),
    rev_sign character varying(1),
    print_landscape character varying(1)
);



--
-- Name: gl08_report_col; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl08_report_col (
    report_code character varying(6) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    col_fld_1 character varying(1),
    col_fld_2 character varying(1),
    col_fld_3 character varying(2),
    col_fld_4 character varying(2),
    per_start character varying(3),
    per_end character varying(3),
    format character varying(1),
    tab integer DEFAULT 0,
    head_1 character varying(10),
    head_2 character varying(10)
);



--
-- Name: gl09_report_lines; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl09_report_lines (
    report_code character varying(6) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    line_fld_1 character varying(1),
    line_fld_2 character varying(2),
    line_fld_3 character varying(8),
    line_fld_4 character varying(2),
    line_fld_5 character varying(8),
    line_fld_6 character varying(8),
    line_fld_7 character varying(2),
    line_comment character varying(40)
);



--
-- Name: gl10_import_layout; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl10_import_layout (
    layout_code character varying(20) NOT NULL,
    layout_name character varying(40),
    file_extension character varying(5),
    process_from_line_x integer,
    date_format character varying(10),
    decimal_points character varying(1),
    field_delimiter character varying(1),
    col_1 character varying(20),
    col_2 character varying(20),
    col_3 character varying(20),
    col_4 character varying(20),
    col_5 character varying(20),
    col_6 character varying(20),
    col_7 character varying(20),
    col_8 character varying(20),
    col_9 character varying(20),
    col_10 character varying(20),
    col_11 character varying(20),
    col_12 character varying(20),
    col_13 character varying(20),
    col_14 character varying(20),
    col_15 character varying(20)
);



--
-- Name: gl10c_company_type; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl10c_company_type (
    layout_code character varying(40) NOT NULL,
    import_company character varying(40) NOT NULL,
    xact_company character varying(40)
);



--
-- Name: gl10l_loc_type; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl10l_loc_type (
    layout_code character varying(40) NOT NULL,
    import_loc character varying(40) NOT NULL,
    company character varying(50),
    xact_loc character varying(40)
);



--
-- Name: gl12_map_alloc_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl12_map_alloc_mast (
    type character varying(8) NOT NULL,
    gl_code character varying(8) NOT NULL,
    row_id integer NOT NULL,
    type_desc character varying(40)
);



--
-- Name: gl20_jnl_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl20_jnl_bt (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    gl_code character varying(8),
    loc character varying(3),
    tran_date date,
    ref character varying(20),
    gl_narr character varying(40),
    debit numeric(13,2) DEFAULT 0,
    credit numeric(13,2) DEFAULT 0
);



--
-- Name: gl29_in_tray; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl29_in_tray (
    period date NOT NULL,
    gl_code character varying(8) NOT NULL,
    source character varying(2) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    batch_no integer DEFAULT 0,
    src_row_id integer DEFAULT 0,
    tran_date date,
    loc character varying(3),
    ref character varying(20),
    gl_narr character varying(40),
    debit numeric(13,2) DEFAULT 0,
    credit numeric(13,2) DEFAULT 0
);



--
-- Name: gl30_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.gl30_tran (
    gl_code character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    period date,
    source character varying(2),
    tran_date date,
    batch_no integer DEFAULT 0,
    ref character varying(20),
    gl_narr character varying(40),
    debit numeric(13,2) DEFAULT 0,
    credit numeric(13,2) DEFAULT 0
);



--
-- Name: ha_st01l_label; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ha_st01l_label (
    stk_code character varying(16) NOT NULL,
    pack_qty integer DEFAULT 0,
    descr character varying(30),
    dimension character varying(25),
    material character varying(15),
    finish character varying(15),
    piece_weight numeric(13,4),
    net_weight numeric(13,4),
    del_by character varying(8),
    note_1 character varying(25),
    note_2 character varying(25),
    note_3 character varying(25),
    label_qty_req integer
);



--
-- Name: ib00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib00_sys_opt (
    row_id integer DEFAULT 0 NOT NULL,
    form_prog_ibt_req character varying(25),
    form_prog_ibt_send character varying(25),
    form_prog_ibt_rec character varying(25),
    last_sy41_no integer DEFAULT 0
);



--
-- Name: ib01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib01_doc_no (
    loc character varying(3) NOT NULL,
    first_req_no integer DEFAULT 0,
    last_req_no integer DEFAULT 0,
    cur_req_no integer DEFAULT 0,
    last_ibt_no integer DEFAULT 0,
    first_ibt_no integer DEFAULT 0,
    cur_ibt_no integer DEFAULT 0
);



--
-- Name: ib20_req_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib20_req_hd (
    req_no character varying(11) NOT NULL,
    status character varying(1),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    req_loc character varying(4),
    req_whs character varying(3) DEFAULT '00'::character varying,
    send_loc character varying(4),
    send_whs character varying(3) DEFAULT '00'::character varying,
    request_date date,
    required_date date,
    req_user character varying(10),
    times_printed integer DEFAULT 0,
    last_ib21_row_id integer DEFAULT 0
);



--
-- Name: ib21_req_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib21_req_dt (
    req_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    prt_ind character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom character varying(15),
    req_qty numeric(11,3) DEFAULT 0,
    ibt_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    last_sent_qty numeric(11,3) DEFAULT 0
);



--
-- Name: ib24_ib_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib24_ib_hd (
    ibt_no character varying(11) NOT NULL,
    status character varying(1) NOT NULL,
    auto_source character varying(2),
    auto_doc_no character varying(11),
    ib21_req_no character varying(11),
    multi_stage_ibt character varying(1),
    cur_stage_loc character varying(4),
    send_loc character varying(4),
    send_whs character varying(3),
    stage_1_loc character varying(4),
    stage_1_whs character varying(3),
    stage_2_loc character varying(4),
    stage_2_whs character varying(3),
    rec_loc character varying(4),
    rec_whs character varying(3),
    del_by character varying(4),
    area_code character varying(4),
    ibt_date date,
    ibt_time time(0) without time zone,
    ibt_user character varying(10),
    load_date date,
    times_printed integer DEFAULT 0,
    tot_ibt_kgs_due numeric(11,3) DEFAULT 0,
    last_ib25_row_id integer DEFAULT 0,
    last_ib30_ship_doc_no integer DEFAULT 0
);



--
-- Name: ib25_ib_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib25_ib_dt (
    ibt_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    prt_ind character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    org_req_due_qty numeric(11,3),
    ibt_qty numeric(11,3),
    shipped_qty numeric(11,3),
    ibt_due_to_ship numeric(11,3),
    kgs_due_to_ship numeric(11,3),
    rec_qty numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_ibt_qty numeric(11,3),
    base_shipped_qty numeric(11,3),
    base_ibt_due_to_ship numeric(11,3),
    base_rec_qty numeric(11,3),
    last_ib25s_row_id integer
);



--
-- Name: ib25i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib25i_bin_alloc (
    ibt_no character varying(11) NOT NULL,
    ib25_row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3)
);



--
-- Name: ib25s_ib_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib25s_ib_serial (
    ibt_no character varying(11) NOT NULL,
    ib25_row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    serial_no character varying(25),
    pack_code character varying(4),
    serial_ibt_qty numeric(11,3) DEFAULT 0,
    serial_ship_qty numeric(11,3) DEFAULT 0,
    serial_due_to_ship_qty numeric(11,3) DEFAULT 0,
    serial_rec_qty numeric(11,3) DEFAULT 0
);



--
-- Name: ib30_ship_doc_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib30_ship_doc_hd (
    ibt_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    send_loc character varying(4),
    send_whs character varying(3) DEFAULT '00'::character varying,
    rec_loc character varying(4),
    rec_whs character varying(3) DEFAULT '00'::character varying,
    ship_date date,
    ship_time time(0) without time zone,
    ship_user character varying(10),
    rec_date date,
    rec_time time(0) without time zone,
    rec_user character varying(10),
    ship_kgs numeric(11,3) DEFAULT 0,
    wt_batch_no integer,
    wt_load_no integer,
    last_ib31_row_id integer DEFAULT 0
);



--
-- Name: ib31_ship_doc_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib31_ship_doc_dt (
    ibt_no character varying(11) NOT NULL,
    ship_doc_no integer NOT NULL,
    ib25_row_id integer NOT NULL,
    sort_pos integer,
    prt_ind character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    ship_unit_cost numeric(13,3),
    rec_unit_cost numeric(13,3),
    ibt_due_to_ship numeric(11,3),
    shipped_qty numeric(11,3),
    rec_qty numeric(11,3),
    due_qty numeric(11,3),
    rec_now_qty numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_ship_unit_cost numeric(13,3),
    base_rec_unit_cost numeric(13,3),
    base_ibt_due_to_ship numeric(11,3),
    base_shipped_qty numeric(11,3),
    base_rec_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_rec_now_qty numeric(11,3),
    item_kgs numeric(11,3),
    last_ib31s_row_id integer,
    st30_row_id_ship integer,
    st30_row_id_rec character varying(1000)
);



--
-- Name: ib31i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib31i_bin_alloc (
    ibt_no character varying(11) NOT NULL,
    ship_doc_no integer NOT NULL,
    rec_loc character varying(3) NOT NULL,
    rec_whs character varying(3) NOT NULL,
    ibt_ship_rec character varying(1) NOT NULL,
    row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    stk_code character varying(16),
    serial_no character varying(25),
    bin_no character varying(16),
    bin_type character varying(1),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3)
);



--
-- Name: ib31p_ship_pallet; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib31p_ship_pallet (
    wt_load_no integer DEFAULT 0 NOT NULL,
    ibt_no character varying(11) NOT NULL,
    ship_doc_no integer NOT NULL,
    ib31_row_id integer NOT NULL,
    wt_container_id character varying(20) NOT NULL,
    wt_pallet_id character varying(20) NOT NULL,
    wt_filename character varying(255),
    prod_code character varying(16),
    wt_pallet_qty numeric(11,3)
);



--
-- Name: ib31s_ship_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ib31s_ship_serial (
    ibt_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    ib25_row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    pack_code character varying(4),
    serial_no character varying(25),
    serial_ship_qty numeric(11,3) DEFAULT 0,
    serial_ship_now_flag character varying(1),
    serial_rec_qty numeric(11,3) DEFAULT 0,
    serial_rec_now_flag character varying(1),
    wt_container_id character varying(20),
    wt_pallet_id character varying(20)
);



--
-- Name: it_sa06_mth_inv_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.it_sa06_mth_inv_hd (
    dl_code character varying(8) NOT NULL,
    dl_ref character varying(8) NOT NULL,
    dl_name character varying(40),
    dl_ref_desc character varying(40),
    status character varying(1),
    remarks character varying(40),
    last_sa07_row_id integer DEFAULT 0
);



--
-- Name: it_sa07_mth_inv_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.it_sa07_mth_inv_dt (
    dl_code character varying(8) NOT NULL,
    dl_ref character varying(8) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    service_type character varying(1),
    service_code character varying(16),
    service_desc_1 character varying(40),
    service_desc_2 character varying(40),
    service_qty numeric(11,3) DEFAULT 0
);



--
-- Name: it_sa08_mth_grn; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.it_sa08_mth_grn (
    period date NOT NULL,
    cl_code character varying(8) NOT NULL,
    cl_ref character varying(20) NOT NULL,
    dl_code character varying(8) NOT NULL,
    dl_ref character varying(8) NOT NULL,
    sa07_row_id integer DEFAULT 0 NOT NULL,
    grn_row_id integer DEFAULT 0 NOT NULL,
    grn_no character varying(11),
    grn_qty numeric(11,3) DEFAULT 0,
    grn_cost numeric(13,2) DEFAULT 0
);



--
-- Name: ita01_asset; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ita01_asset (
    asset_no integer DEFAULT 0 NOT NULL,
    status character varying(1),
    asset_type character varying(10),
    make_model character varying(20),
    descpt character varying(30),
    serial_no character varying(30),
    condition_rate smallint,
    loc character varying(3),
    department character varying(30),
    date_install date,
    booked_in_for_repairs character varying(1),
    booked_in_date date,
    booked_in_by character varying(10),
    supp_name character varying(20),
    supp_ref character varying(20),
    supp_notes character varying(100),
    last_service_date date,
    last_inv_no integer DEFAULT 0,
    per_asset_no1 integer DEFAULT 0,
    per_asset_no2 integer DEFAULT 0,
    per_asset_no3 integer DEFAULT 0,
    per_asset_no4 integer DEFAULT 0,
    comp_type character varying(3),
    comp_description character varying(50),
    comp_name character varying(30),
    comp_username character varying(30),
    comp_ip character varying(30),
    comp_is_dhcp smallint,
    comp_apps character varying(800),
    comp_cpu character varying(30),
    comp_key_mouse character varying(20),
    comp_hd character varying(10),
    comp_memory character varying(25),
    comp_os character varying(25),
    comp_card_des character varying(200),
    comp_net_card1 character varying(15),
    comp_card_ip1 character varying(15),
    comp_net_card2 character varying(15),
    comp_card_ip2 character varying(15),
    comp_net_card3 character varying(15),
    comp_card_ip3 character varying(15),
    comp_ds_asset_no integer DEFAULT 0,
    comp_remote_user character varying(15),
    comp_r_passwd character varying(15),
    nw_dev_type character varying(20),
    nw_descrip character varying(30),
    nw_ip character varying(20),
    nw_ext1 character varying(4),
    nw_ext2 character varying(4),
    nw_username character varying(15),
    nw_passwd character varying(15),
    nw_adsl_token character varying(35),
    nw_adsl_passwd character varying(10),
    nw_port_no1 character varying(5),
    nw_asset_no1 integer DEFAULT 0,
    nw_port_no2 character varying(5),
    nw_asset_no2 integer DEFAULT 0,
    nw_port_no3 character varying(5),
    nw_asset_no3 integer DEFAULT 0,
    pr_type character varying(15),
    pr_connect_to character varying(6),
    pr_asset_no integer DEFAULT 0,
    pr_ip character varying(20),
    pr_port_no character varying(20),
    pr_notes character varying(200),
    pr_company character varying(30),
    pr_xact_pr_no character varying(5),
    pr_spool_name character varying(15),
    stock_take character varying(1),
    checked_by character varying(10),
    checked_date date,
    prev_checked_by character varying(10),
    prev_checked_date date
);



--
-- Name: ita02_users; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ita02_users (
    username character varying(10) NOT NULL,
    password character varying(90),
    user_password character varying(1),
    fullname character varying(30),
    user_level character varying(1)
);



--
-- Name: ita03_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ita03_log (
    log_no integer DEFAULT 0 NOT NULL,
    log_date time(0) without time zone,
    username character varying(10),
    asset_no integer DEFAULT 0,
    field_name character varying(30),
    org_val character varying(200),
    new_val character varying(200),
    reason_for_delete character varying(200),
    action character varying(200)
);



--
-- Name: ita04_hdrive; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.ita04_hdrive (
    ser_no character varying(25) NOT NULL,
    make character varying(25),
    size character varying(5),
    controller character varying(5),
    where_from character varying(35),
    used_by character varying(25),
    signed_off character varying(1),
    reason_so character varying(50)
);



--
-- Name: jc00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc00_sys_opt (
    row_id integer,
    keep_job_hist integer DEFAULT 0,
    jc_inv_prog character varying(25),
    jc_rep_code character varying(10),
    default_comp_view character varying(5),
    job_amend_sell_on_del character varying(1),
    update_jc_from_grn character varying(1),
    form_prog_js character varying(25),
    shortfall_auth character varying(1) DEFAULT 'N'::character varying,
    mrp_enabled character varying(1) DEFAULT 'N'::character varying,
    restrict_latest_cost character varying(1) DEFAULT 'N'::character varying,
    shortfall_qty_var_per numeric(8,2) DEFAULT 0,
    shortfall_cost_var_per numeric(8,2) DEFAULT 0,
    shortfall_cost_var_val numeric(11,2) DEFAULT 0,
    auto_rec_itp character varying(1) DEFAULT 'N'::character varying,
    jc26_last_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0
);



--
-- Name: jc00_sys_opt_old; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc00_sys_opt_old (
    row_id integer DEFAULT 0 NOT NULL,
    keep_job_hist integer DEFAULT 0,
    jc_inv_prog character varying(25),
    jc_rep_code character varying(10),
    default_comp_view character varying(5),
    job_amend_sell_on_del character varying(1),
    update_jc_from_grn character varying(1),
    form_prog_js character varying(25),
    shortfall_auth character varying(1) DEFAULT 'N'::character varying,
    mrp_enabled character varying(1) DEFAULT 'N'::character varying,
    restrict_latest_cost character varying(1) DEFAULT 'N'::character varying,
    shortfall_qty_var_per numeric(8,2) DEFAULT 0,
    shortfall_cost_var_per numeric(8,2) DEFAULT 0,
    shortfall_cost_var_val numeric(11,2),
    auto_rec_itp character varying(1) DEFAULT 'N'::character varying,
    layout_tot_value_field_size integer DEFAULT 0,
    layout_tot_value_format character varying(1),
    layout_tot_format_struct character varying(20),
    layout_unit_value_field_size integer DEFAULT 0,
    layout_unit_value_format character varying(1),
    layout_unit_format_struct character varying(20),
    layout_qty_field_size integer DEFAULT 0,
    layout_qty_format character varying(1),
    layout_qty_decimals integer DEFAULT 0,
    layout_qty_format_struct character varying(20),
    jc26_last_batch_no integer DEFAULT 0,
    last_sy41_no integer DEFAULT 0,
    layout_qty_numerics integer
);



--
-- Name: jc01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc01_doc_no (
    loc character varying(3) NOT NULL,
    first_jc_est integer DEFAULT 0,
    last_jc_est integer DEFAULT 0,
    cur_jc_est integer DEFAULT 0,
    first_jc_no integer DEFAULT 0,
    last_jc_no integer DEFAULT 0,
    cur_jc_no integer DEFAULT 0,
    first_jc_del integer DEFAULT 0,
    last_jc_del integer DEFAULT 0,
    cur_jc_del integer DEFAULT 0,
    first_jc_itp integer DEFAULT 0,
    cur_jc_itp integer DEFAULT 0,
    last_jc_itp integer DEFAULT 0
);



--
-- Name: jc20_est_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc20_est_hd (
    est_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    qt_no character varying(11),
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    site_add_1 character varying(30),
    site_add_2 character varying(30),
    site_add_3 character varying(30),
    site_add_4 character varying(10),
    tel_office character varying(13),
    tel_site character varying(13),
    fax_office character varying(13),
    fax_site character varying(13),
    contact_office character varying(13),
    contact_site character varying(13),
    rep_code character varying(5),
    proj_code character varying(8),
    proj_desc character varying(40),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    estimator character varying(10),
    project_man character varying(10),
    buyer character varying(10),
    install_date date,
    comp_date date,
    our_ref character varying(20),
    cust_ref character varying(20),
    guarantee_perc numeric(7,3),
    retention_perc numeric(7,3),
    mat_gp numeric(7,2),
    lab_gp numeric(7,2),
    trans_gp numeric(7,2),
    sundry_gp numeric(7,2),
    rental_gp numeric(7,2),
    tot_mat numeric(13,2) DEFAULT 0,
    tot_lab numeric(13,2) DEFAULT 0,
    tot_trans numeric(13,2) DEFAULT 0,
    tot_sundry numeric(13,2) DEFAULT 0,
    tot_rental numeric(13,2),
    tot_cost numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,2) DEFAULT 0,
    tot_price numeric(13,2) DEFAULT 0,
    tot_vat numeric(13,2) DEFAULT 0,
    tot_contract numeric(13,2) DEFAULT 0,
    allow_js_creation character varying(1),
    tender_import character varying(1),
    last_jc21_row_id integer DEFAULT 0
);



--
-- Name: jc21_est_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc21_est_dt (
    est_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    quote_qty numeric(11,3) DEFAULT 0,
    rev_qty numeric(11,3) DEFAULT 0,
    qty numeric(11,3) DEFAULT 0,
    unit_price numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    gross_cost numeric(13,2) DEFAULT 0,
    gross_price numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,3) DEFAULT 0,
    tender_site_area character varying(40),
    tender_ref_id numeric(11,3) DEFAULT 0,
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    pid character varying(15),
    cid character varying(15),
    expanded boolean,
    last_jc21b_row_id integer DEFAULT 0
);



--
-- Name: jc21b_est_bom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc21b_est_bom (
    est_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    prt_ind character varying(1),
    sort_pos integer DEFAULT 0,
    comp_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    comp_quote_based_on_1_qty numeric(11,3),
    comp_rev_based_on_1_qty numeric(11,3),
    comp_based_on_1_qty numeric(11,3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_unit_cost numeric(13,2) DEFAULT 0,
    comp_gross_cost_based_on_1_qt numeric(13,2) DEFAULT 0,
    comp_gross_cost numeric(13,2) DEFAULT 0,
    comp_cost_ratio numeric(9,2)
);



--
-- Name: jc24_jc_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc24_jc_hd (
    job_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    create_by character varying(10),
    actioned_status character varying(1),
    actioned_by character varying(10),
    actioned_date date,
    actioned_time time(0) without time zone,
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    rep_code character varying(5),
    proj_code character varying(8),
    proj_desc character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    site_add_1 character varying(30),
    site_add_2 character varying(30),
    site_add_3 character varying(30),
    site_add_4 character varying(10),
    tel_office character varying(13),
    tel_site character varying(13),
    fax_office character varying(13),
    fax_site character varying(13),
    contact_office character varying(13),
    contact_site character varying(13),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    estimator character varying(10),
    project_man character varying(10),
    buyer character varying(10),
    install_date date,
    comp_date date,
    our_ref character varying(20),
    cust_ref character varying(20),
    mat_gp numeric(7,2),
    lab_gp numeric(7,2),
    trans_gp numeric(7,2),
    sundry_gp numeric(7,2),
    rental_gp numeric(7,2),
    guarantee_perc numeric(7,2),
    retention_perc numeric(7,2),
    est_tot_mat numeric(13,2) DEFAULT 0,
    est_tot_lab numeric(13,2) DEFAULT 0,
    est_tot_trans numeric(13,2) DEFAULT 0,
    est_tot_sundry numeric(13,2) DEFAULT 0,
    est_tot_rental numeric(13,2),
    est_tot_cost numeric(13,2) DEFAULT 0,
    est_gp_perc numeric(7,2) DEFAULT 0,
    est_tot_price numeric(13,2) DEFAULT 0,
    est_vat_value numeric(13,2) DEFAULT 0,
    est_tot_contract numeric(13,2) DEFAULT 0,
    act_tot_mat numeric(13,2) DEFAULT 0,
    act_tot_lab numeric(13,2) DEFAULT 0,
    act_tot_trans numeric(13,2) DEFAULT 0,
    act_tot_sundry numeric(13,2) DEFAULT 0,
    act_tot_rental numeric(13,2),
    act_tot_cost numeric(13,2) DEFAULT 0,
    act_gp_perc numeric(7,2) DEFAULT 0,
    act_tot_price numeric(13,2) DEFAULT 0,
    act_vat_value numeric(13,2) DEFAULT 0,
    act_tot_contract numeric(13,2) DEFAULT 0,
    inv_value numeric(13,2) DEFAULT 0,
    inv_vat numeric(13,2) DEFAULT 0,
    inv_cost numeric(13,2) DEFAULT 0,
    inv_price numeric(13,2) DEFAULT 0,
    adv_tot_mat numeric(13,2) DEFAULT 0,
    adv_tot_lab numeric(13,2) DEFAULT 0,
    adv_tot_trans numeric(13,2) DEFAULT 0,
    adv_tot_sundry numeric(13,2) DEFAULT 0,
    adv_tot_rental numeric(13,2) DEFAULT 0,
    ret_tot_mat numeric(13,2) DEFAULT 0,
    ret_tot_lab numeric(13,2) DEFAULT 0,
    ret_tot_trans numeric(13,2) DEFAULT 0,
    ret_tot_sundry numeric(13,2) DEFAULT 0,
    ret_tot_rental numeric(13,2) DEFAULT 0,
    tender_import character varying(1),
    last_jc25_row_id integer DEFAULT 0,
    last_jc37_del_no integer DEFAULT 0
);



--
-- Name: jc25_jc_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc25_jc_dt (
    job_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    jc20_est_no character varying(11),
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    vat_ind character varying(1),
    quote_qty numeric(11,3) DEFAULT 0,
    rev_qty numeric(11,3) DEFAULT 0,
    est_qty numeric(11,3) DEFAULT 0,
    est_unit_price numeric(13,2) DEFAULT 0,
    est_unit_cost numeric(13,2) DEFAULT 0,
    est_disc numeric(7,2) DEFAULT 0,
    est_net_unit_price numeric(13,2),
    est_gp_perc numeric(7,2) DEFAULT 0,
    est_gross_cost numeric(13,2) DEFAULT 0,
    est_gross_price numeric(13,2) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    act_unit_price numeric(13,2) DEFAULT 0,
    act_unit_cost numeric(13,2) DEFAULT 0,
    act_gp_perc numeric(7,2) DEFAULT 0,
    act_gross_cost numeric(13,2) DEFAULT 0,
    act_gross_price numeric(13,2) DEFAULT 0,
    inv_qty numeric(11,3) DEFAULT 0,
    inv_gross_cost numeric(13,2),
    inv_gross numeric(13,2) DEFAULT 0,
    po_qty_no numeric(11,3) DEFAULT 0,
    po_qty_tot numeric(11,3) DEFAULT 0,
    wo_qty_no numeric(11,3) DEFAULT 0,
    wo_qty_tot numeric(11,3) DEFAULT 0,
    invoice_retention numeric(13,2) DEFAULT 0,
    advanced_claims numeric(13,2) DEFAULT 0,
    tender_site_area character varying(40),
    tender_ref_id numeric(11,3) DEFAULT 0,
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    last_jc25b_row_id integer DEFAULT 0,
    pid character varying(15),
    cid character varying(15),
    expanded boolean
);



--
-- Name: jc25b_jc_bom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc25b_jc_bom (
    job_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    prt_ind character varying(1),
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    jc20_est_no character varying(11),
    comp_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    comp_quote_based_on_1_qty numeric(11,3),
    comp_rev_based_on_1_qty numeric(11,3),
    comp_based_on_1_qty numeric(11,3),
    comp_est_qty numeric(11,3) DEFAULT 0,
    comp_est_unit_cost numeric(13,2) DEFAULT 0,
    comp_gross_cost_based_on_1_qt numeric(13,2),
    comp_est_gross_cost numeric(13,2) DEFAULT 0,
    comp_act_qty numeric(11,3),
    comp_act_cost numeric(13,2),
    comp_inv_qty numeric(11,3),
    comp_inv_gross_cost numeric(13,2),
    comp_inv_gross_price numeric(13,2),
    comp_cost_ratio numeric(9,2)
);



--
-- Name: jc26_shortfall_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc26_shortfall_hd (
    batch_no integer NOT NULL,
    status character varying(1),
    workflow_status character varying(1),
    job_no character varying(11),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone,
    keep_bal_batch character varying(1),
    misc character varying(20)
);



--
-- Name: jc27_shortfall_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc27_shortfall_dt (
    batch_no integer NOT NULL,
    jc25_row_id integer DEFAULT 0 NOT NULL,
    master_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    comp_row_id integer DEFAULT 0 NOT NULL,
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    comp_based_on_1_qty numeric(11,3) DEFAULT 0,
    est_qty numeric(11,3) DEFAULT 0,
    est_cost numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    stores_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    req_date date,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_cost numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_cost numeric(13,2) DEFAULT 0,
    query character varying(40),
    site_date date,
    site_area character varying(40),
    comments character varying(40),
    cid character varying(15),
    pid character varying(15),
    expanded boolean
);



--
-- Name: jc27r_shortfall_raw; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc27r_shortfall_raw (
    batch_no integer NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    replen_type character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    est_qty numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    req_qty numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_price numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    jc25_row_id integer DEFAULT 0
);



--
-- Name: jc28_itp_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc28_itp_hd (
    itp_no character varying(11) NOT NULL,
    status character varying(1),
    job_no character varying(11),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    send_loc character varying(4),
    send_whs character varying(3),
    proj_code character varying(8),
    site_add_1 character varying(20),
    site_add_2 character varying(20),
    site_add_3 character varying(20),
    del_by character varying(4),
    area_code character varying(4),
    itp_date date,
    itp_time time(0) without time zone,
    itp_user character varying(10),
    times_printed integer DEFAULT 0,
    tot_ibt_kgs_due numeric(11,3) DEFAULT 0,
    last_jc29_row_id integer DEFAULT 0,
    last_jc30_ship_doc_no integer DEFAULT 0
);



--
-- Name: jc29_ipt_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc29_ipt_dt (
    itp_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    prt_ind character varying(1),
    item_type character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom character varying(8),
    org_js_due_qty numeric(11,3) DEFAULT 0,
    itp_qty numeric(11,3) DEFAULT 0,
    over_itp_reason character varying(40),
    shipped_qty numeric(11,3) DEFAULT 0,
    itp_due_to_ship numeric(11,3) DEFAULT 0,
    kgs_due_to_ship numeric(11,3) DEFAULT 0,
    rec_qty numeric(11,3) DEFAULT 0,
    last_jc29s_row_id integer DEFAULT 0
);



--
-- Name: jc29i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc29i_bin_alloc (
    itp_no character varying(11) NOT NULL,
    jc29_row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3)
);



--
-- Name: jc29s_itp_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc29s_itp_serial (
    itp_no character varying(11) NOT NULL,
    jc29_row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    serial_no character varying(25),
    pack_code character varying(4),
    serial_itp_qty numeric(11,3) DEFAULT 0,
    serial_ship_qty numeric(11,3) DEFAULT 0,
    serial_due_to_ship_qty numeric(11,3) DEFAULT 0,
    serial_rec_qty numeric(11,3) DEFAULT 0
);



--
-- Name: jc30_ship_doc_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc30_ship_doc_hd (
    itp_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    send_loc character varying(4),
    send_whs character varying(3),
    ship_date date,
    ship_time time(0) without time zone,
    ship_user character varying(10),
    rec_date date,
    rec_time time(0) without time zone,
    rec_user character varying(10),
    ship_kgs numeric(11,3) DEFAULT 0,
    last_jc31_row_id integer
);



--
-- Name: jc31_ship_doc_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc31_ship_doc_dt (
    itp_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    jc29_row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    prt_ind character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom character varying(8),
    unit_cost numeric(13,3) DEFAULT 0,
    itp_due_to_ship numeric(11,3) DEFAULT 0,
    shipped_qty numeric(11,3) DEFAULT 0,
    rec_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    rec_now_qty numeric(11,3) DEFAULT 0,
    item_kgs numeric(11,3) DEFAULT 0,
    last_jc31s_row_id integer DEFAULT 0,
    st30i_row_id_ship integer DEFAULT 0,
    st30i_row_id_rec character varying(1000)
);



--
-- Name: jc31s_ship_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc31s_ship_serial (
    itp_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    jc29_row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    pack_code character varying(4),
    serial_no character varying(25),
    serial_ship_qty numeric(11,3) DEFAULT 0,
    serial_ship_now_flag character varying(1),
    serial_rec_qty numeric(11,3) DEFAULT 0,
    serial_rec_now_flag character varying(1)
);



--
-- Name: jc32_claims_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc32_claims_hd (
    claim_no integer NOT NULL,
    job_no character varying(11) NOT NULL,
    status character varying(1),
    wf_status character varying(3),
    create_by character varying(25),
    create_date date,
    create_time time(0) without time zone,
    update_by character varying(25),
    update_date date,
    update_time time(0) without time zone,
    claim_stk_code character varying(16),
    claim_stk_desc_1 character varying(40),
    claim_stk_desc_2 character varying(40),
    claim_stk_desc_3 character varying(40),
    total_claimed_amt numeric(13,2),
    total_advance_claimed numeric(13,2),
    total_claimed numeric(13,2),
    total_retention numeric(13,2),
    total_nett_claim numeric(13,2),
    last_jc33_row_id integer
);



--
-- Name: jc33_claims_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.jc33_claims_dt (
    claim_no integer NOT NULL,
    job_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer NOT NULL,
    jc25_row_id integer,
    sort_pos integer DEFAULT 0,
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    uom character varying(5),
    estimate_qty numeric(11,3),
    invoice_qty numeric(11,3),
    wip_qty numeric(11,3),
    installed_qty numeric(11,3),
    claimed_qty numeric(11,3),
    unit_price numeric(13,2),
    claim_amount numeric(13,2),
    advance_claimed numeric(13,2),
    total_claimed numeric(13,2),
    claim_retention numeric(13,2),
    nett_claimed numeric(13,2),
    comment character varying(1000),
    cid character varying(15),
    pid character varying(15)
);



--
-- Name: kf_jc20_est_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc20_est_hd (
    est_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    qt_no character varying(11),
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    site_add_1 character varying(30),
    site_add_2 character varying(30),
    site_add_3 character varying(30),
    site_add_4 character varying(10),
    tel_office character varying(13),
    tel_site character varying(13),
    fax_office character varying(13),
    fax_site character varying(13),
    contact_office character varying(13),
    contact_site character varying(13),
    rep_code character varying(5),
    proj_code character varying(8),
    proj_desc character varying(40),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    install_date date,
    comp_date date,
    our_ref character varying(20),
    cust_ref character varying(20),
    tot_mat numeric(13,2) DEFAULT 0,
    tot_lab numeric(13,2) DEFAULT 0,
    tot_trans numeric(13,2) DEFAULT 0,
    tot_sundry numeric(13,2) DEFAULT 0,
    tot_cost numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,2) DEFAULT 0,
    tot_price numeric(13,2) DEFAULT 0,
    tot_vat numeric(13,2) DEFAULT 0,
    tot_contract numeric(13,1) DEFAULT 0,
    allow_js_creation character varying(1),
    last_jc21_row_id integer DEFAULT 0
);



--
-- Name: kf_jc21_est_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc21_est_dt (
    est_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    js_qty numeric(11,3) DEFAULT 0,
    unit_price numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    gross_cost numeric(13,2) DEFAULT 0,
    gross_price numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,3) DEFAULT 0,
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    last_jc21b_row_id integer DEFAULT 0
);



--
-- Name: kf_jc21b_est_bom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc21b_est_bom (
    est_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    comp_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    comp_grp character varying(3),
    comp_type character varying(3),
    comp_qty numeric(11,2) DEFAULT 0,
    comp_unit_cost numeric(13,2) DEFAULT 0,
    comp_gross_cost numeric(13,2) DEFAULT 0
);



--
-- Name: kf_jc24_jc_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc24_jc_hd (
    job_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    create_by character varying(10),
    actioned_status character varying(1),
    actioned_by character varying(10),
    actioned_date date,
    actioned_time time(0) without time zone,
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    rep_code character varying(5),
    proj_code character varying(8),
    proj_desc character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    site_add_1 character varying(30),
    site_add_2 character varying(30),
    site_add_3 character varying(30),
    site_add_4 character varying(10),
    tel_office character varying(13),
    tel_site character varying(13),
    fax_office character varying(13),
    fax_site character varying(13),
    contact_office character varying(13),
    contact_site character varying(13),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    install_date date,
    comp_date date,
    our_ref character varying(20),
    cust_ref character varying(20),
    est_tot_mat numeric(13,2) DEFAULT 0,
    est_tot_lab numeric(13,2) DEFAULT 0,
    est_tot_trans numeric(13,2) DEFAULT 0,
    est_tot_sundry numeric(13,2) DEFAULT 0,
    est_tot_cost numeric(13,2) DEFAULT 0,
    est_gp_perc numeric(7,2) DEFAULT 0,
    est_tot_price numeric(13,2) DEFAULT 0,
    est_vat_value numeric(13,2) DEFAULT 0,
    est_tot_contract numeric(13,2) DEFAULT 0,
    act_tot_mat numeric(13,2) DEFAULT 0,
    act_tot_lab numeric(13,2) DEFAULT 0,
    act_tot_trans numeric(13,2) DEFAULT 0,
    act_tot_sundry numeric(13,2) DEFAULT 0,
    act_tot_cost numeric(13,2) DEFAULT 0,
    act_gp_perc numeric(7,2) DEFAULT 0,
    act_tot_price numeric(13,2) DEFAULT 0,
    act_vat_value numeric(13,2) DEFAULT 0,
    act_tot_contract numeric(13,2) DEFAULT 0,
    inv_value numeric(13,2) DEFAULT 0,
    inv_vat numeric(13,2) DEFAULT 0,
    inv_cost numeric(13,2) DEFAULT 0,
    inv_price numeric(13,2) DEFAULT 0,
    last_jc25_row_id integer DEFAULT 0,
    last_jc37_del_no integer DEFAULT 0
);



--
-- Name: kf_jc25_jc_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc25_jc_dt (
    job_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    jc20_est_no character varying(11),
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    vat_ind character varying(1),
    est_qty numeric(11,3) DEFAULT 0,
    est_unit_price numeric(13,2) DEFAULT 0,
    est_unit_cost numeric(13,2) DEFAULT 0,
    est_gp_perc numeric(7,2) DEFAULT 0,
    est_gross_cost numeric(13,2) DEFAULT 0,
    est_gross_price numeric(13,2) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    act_unit_price numeric(13,2) DEFAULT 0,
    act_unit_cost numeric(13,2) DEFAULT 0,
    act_gp_perc numeric(7,2) DEFAULT 0,
    act_gross_cost numeric(13,2) DEFAULT 0,
    act_gross_price numeric(13,2) DEFAULT 0,
    inv_qty numeric(11,3) DEFAULT 0,
    inv_unit_price numeric(13,2) DEFAULT 0,
    inv_disc numeric(13,2) DEFAULT 0,
    inv_net_unit_price numeric(13,2) DEFAULT 0,
    inv_gross numeric(13,2) DEFAULT 0,
    po_qty_no numeric(11,3) DEFAULT 0,
    po_qty_tot numeric(11,3) DEFAULT 0,
    wo_qty_no numeric(11,3) DEFAULT 0,
    wo_qty_tot numeric(11,3) DEFAULT 0,
    last_jc25b_row_id integer DEFAULT 0
);



--
-- Name: kf_jc25b_jc_bom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc25b_jc_bom (
    job_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    jc20_est_no character varying(11),
    comp_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    comp_grp character varying(3),
    comp_type character varying(3),
    comp_est_qty numeric(11,3) DEFAULT 0,
    comp_est_unit_cost numeric(13,2) DEFAULT 0,
    comp_est_gross_cost numeric(13,2) DEFAULT 0
);



--
-- Name: kf_jc26_shortfall_po_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc26_shortfall_po_hd (
    job_no character varying(11) NOT NULL,
    cl_code character varying(8) NOT NULL,
    po_no character varying(11) NOT NULL,
    cl_name character varying(40),
    po_loc character varying(3),
    del_to_1 character varying(30),
    del_to_2 character varying(30),
    del_to_3 character varying(30),
    del_to_4 character varying(30),
    req_date date,
    date_confirmed character varying(1),
    cred_ref character varying(20),
    delivery_by character varying(15),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    contact character varying(15),
    ord_value numeric(13,2) DEFAULT 0
);



--
-- Name: kf_jc27_shortfall_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc27_shortfall_dt (
    job_no character varying(11) NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    replen_type character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    est_qty numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    req_qty numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_price numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    jc25_row_id integer DEFAULT 0
);



--
-- Name: kf_jc27r_shortfall_raw; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc27r_shortfall_raw (
    job_no character varying(11) NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    replen_type character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    uom character varying(8),
    est_qty numeric(11,3) DEFAULT 0,
    act_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    stock_bal numeric(11,3) DEFAULT 0,
    proj_bal numeric(11,3) DEFAULT 0,
    req_qty numeric(11,3) DEFAULT 0,
    short_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    po_qty numeric(11,3) DEFAULT 0,
    doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    unit_price numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    jc25_row_id integer DEFAULT 0
);



--
-- Name: kf_jc37_jc_dn_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc37_jc_dn_hd (
    jc24_job_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    del_type character varying(1),
    jc21_est_no character varying(11),
    loc character varying(3),
    whs character varying(3),
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    site_add_1 character varying(30),
    site_add_2 character varying(30),
    site_add_3 character varying(30),
    site_add_4 character varying(10),
    tel_office character varying(13),
    tel_site character varying(13),
    fax_office character varying(13),
    fax_site character varying(13),
    contact_office character varying(13),
    contact_site character varying(13),
    rep_code character varying(5),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    cust_ref character varying(20),
    our_ref character varying(20),
    del_date date,
    del_printed character varying(1),
    times_printed integer DEFAULT 0,
    last_jc38_row_id integer DEFAULT 0
);



--
-- Name: kf_jc38_jc_dn_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.kf_jc38_jc_dn_dt (
    jc24_job_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    item_type character varying(1),
    prod_code character varying(16),
    prt_ind character varying(1),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(15),
    req_qty numeric(11,3) DEFAULT 0.000,
    act_qty numeric(11,3) DEFAULT 0.000,
    act_qty_due numeric(11,3) DEFAULT 0.000,
    now_del_qty numeric(11,3) DEFAULT 0.000,
    unit_cost_now numeric(13,2) DEFAULT 0.000,
    ovr_del_reason character varying(100)
);



--
-- Name: lpf_bm30_wo_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpf_bm30_wo_hd (
    wo_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    period date,
    sa22lpf_qt_no character varying(11),
    sa22_so_no character varying(11),
    dl_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(15),
    cell_no character varying(15),
    email character varying(80),
    contact character varying(20),
    post_add_1 character varying(40),
    post_add_2 character varying(40),
    post_add_3 character varying(40),
    post_add_4 character varying(40),
    del_add_1 character varying(40),
    del_add_2 character varying(40),
    del_add_3 character varying(40),
    del_add_4 character varying(40),
    bo_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    purged_by character varying(10),
    purged_date date,
    purged_time time(0) without time zone,
    our_ref character varying(40),
    cust_ref character varying(40),
    qty_required integer,
    qty_complete integer,
    unit_cost numeric(13,2),
    unit_sell numeric(13,2),
    tot_cost numeric(13,2),
    tot_excl_vat numeric(13,2),
    tot_vat numeric(13,2),
    tot_incl_vat numeric(13,2),
    last_bm31lpf_row_id integer
);



--
-- Name: lpf_bm31_wo_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpf_bm31_wo_dt (
    wo_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    material_code character varying(16),
    mat_desc_1 character varying(40),
    mat_desc_2 character varying(40),
    mat_desc_3 character varying(40),
    mat_desc_4 character varying(40),
    uom character varying(8),
    reqd_qty numeric(13,2) DEFAULT 0,
    reqd_length numeric(13,3) DEFAULT 0,
    reqd_width numeric(13,3) DEFAULT 0,
    reqd_sqm numeric(13,3) DEFAULT 0,
    reqd_cost numeric(13,2) DEFAULT 0,
    iss_qty numeric(13,2) DEFAULT 0,
    iss_length numeric(13,3) DEFAULT 0,
    iss_width numeric(13,3) DEFAULT 0,
    iss_sqm numeric(13,3) DEFAULT 0,
    iss_cost numeric(13,2) DEFAULT 0,
    iss_qty_for_recpt numeric(13,2) DEFAULT 0,
    iss_qty_tot numeric(13,2) DEFAULT 0,
    cert_no character varying(15)
);



--
-- Name: lpf_sa22_qt_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpf_sa22_qt_hd (
    doc_no character varying(11) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    status character varying(1),
    period date,
    sa22_so_no character varying(11),
    lpf_bm30_wo_no character varying(11),
    dl_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(15),
    cell_no character varying(15),
    email character varying(80),
    contact character varying(20),
    rep_code character varying(5),
    post_add_1 character varying(40),
    post_add_2 character varying(40),
    post_add_3 character varying(40),
    post_add_4 character varying(40),
    del_add_1 character varying(40),
    del_add_2 character varying(40),
    del_add_3 character varying(40),
    del_add_4 character varying(40),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    valid_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    convert_by character varying(10),
    convert_date date,
    convert_time time(0) without time zone,
    our_ref character varying(20),
    cust_ref character varying(20),
    notes character varying(255),
    tot_excl_vat numeric(13,2),
    tot_vat numeric(13,2),
    tot_incl_vat numeric(13,2),
    deposit_required numeric(13,2),
    deposit_paid numeric(13,2),
    last_sa23lpf_row_id integer DEFAULT 0
);



--
-- Name: lpf_sa23_qt_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpf_sa23_qt_dt (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    doc_qty numeric(13,2),
    wo_qty numeric(13,2),
    unit_price_excl numeric(13,2),
    gross numeric(13,2),
    material_code character varying(16),
    mat_desc_1 character varying(40),
    mat_desc_2 character varying(40),
    mat_desc_3 character varying(40),
    mat_desc_4 character varying(40),
    qt_prt_desc character varying(20),
    cut_length integer,
    cut_time integer,
    pos_length integer,
    pos_time integer,
    no_pierces integer,
    pierce_time integer,
    tot_time integer,
    rate numeric(13,2),
    cut_price_excl numeric(13,2),
    mat_length numeric(13,3),
    mat_width numeric(13,3),
    mat_thickness numeric(13,2),
    mat_density numeric(13,2),
    mat_rand_kg numeric(13,2),
    mat_price_excl numeric(13,2)
);



--
-- Name: lpf_st01_mat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpf_st01_mat_mast (
    material_code character varying(16) NOT NULL,
    mat_desc_1 character varying(40),
    mat_desc_2 character varying(40),
    mat_desc_3 character varying(40),
    mat_desc_4 character varying(40),
    uom character varying(5),
    length numeric(13,3),
    width numeric(13,3),
    thickness numeric(13,2),
    density numeric(13,2),
    feed_rate numeric(13,2),
    pierce_time numeric(13,2),
    rand_kg numeric(13,2)
);



--
-- Name: lpftest; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.lpftest (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    doc_qty numeric(13,2),
    wo_qty numeric(13,2),
    unit_price_excl numeric(13,2),
    gross numeric(13,2),
    material_code character varying(16),
    mat_desc_1 character varying(40),
    mat_desc_2 character varying(40),
    mat_desc_3 character varying(40),
    mat_desc_4 character varying(40),
    qt_prt_desc character varying(20),
    cut_length integer,
    cut_time integer,
    pos_length integer,
    pos_time integer,
    no_pierces integer,
    pierce_time integer,
    tot_time integer,
    rate numeric(13,2),
    cut_price_excl numeric(13,2),
    mat_length numeric(13,2),
    mat_width numeric(13,2),
    mat_thickness numeric(13,2),
    mat_density numeric(13,2),
    mat_rand_kg numeric(13,2),
    mat_price_excl numeric(13,2)
);



--
-- Name: pos00_till_profile; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos00_till_profile (
    till_user_name character varying(10) NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    cashier_acct character varying(1),
    cash_sale_acct character varying(8),
    restrict_cash_acct_usage character varying(1),
    hold_to_cash character varying(1),
    allow_reprint character varying(1)
);



--
-- Name: pos01_linked_users; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos01_linked_users (
    till_user_name character varying(10) NOT NULL,
    user_name character varying(10) NOT NULL,
    rep_code character varying(5),
    user_pin character varying(6),
    pos_input_type character varying(1),
    cur_batch_no integer DEFAULT 0
);



--
-- Name: pos02_cashup; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos02_cashup (
    till_user_name character varying(10) NOT NULL,
    user_name character varying(10) NOT NULL,
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 1 NOT NULL,
    recon_status character varying(1),
    recon_by character varying(10),
    recon_date date,
    loc character varying(3),
    whs character varying(3),
    date_started date,
    date_cashup_complete date,
    cashup_done character varying(1),
    cents numeric(13,2) DEFAULT 0,
    one_rand numeric(13,2) DEFAULT 0,
    two_rand numeric(13,2) DEFAULT 0,
    five_rand numeric(13,2) DEFAULT 0,
    ten_rand numeric(13,2) DEFAULT 0,
    twenty_rand numeric(13,2) DEFAULT 0,
    fifty_rand numeric(13,2) DEFAULT 0,
    oneh_rand numeric(13,2) DEFAULT 0,
    twoh_rand numeric(13,2) DEFAULT 0,
    tot_drop_safe numeric(13,2) DEFAULT 0,
    tot_expenses numeric(13,2) DEFAULT 0,
    tot_cash numeric(13,2) DEFAULT 0,
    tot_chqs numeric(13,2) DEFAULT 0,
    tot_cr_cards numeric(13,2) DEFAULT 0,
    tot_db_cards numeric(13,2) DEFAULT 0,
    tot_amex_cards numeric(13,2) DEFAULT 0,
    tot_eft numeric(13,2) DEFAULT 0,
    tot_cnote numeric(13,2) DEFAULT 0,
    "float" numeric(13,2) DEFAULT 0,
    total_bank numeric(13,2) DEFAULT 0
);



--
-- Name: pos03_cashup_corrections; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos03_cashup_corrections (
    batch_no integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0 NOT NULL,
    doc_no character varying(11),
    notes character varying(200),
    value numeric(13,2) DEFAULT 0
);



--
-- Name: pos04_cash_drop; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos04_cash_drop (
    till_user_name character varying(10) NOT NULL,
    user_name character varying(10) NOT NULL,
    period date NOT NULL,
    batch_no integer NOT NULL,
    cash_drop_date date NOT NULL,
    cash_drop_time time(0) without time zone NOT NULL,
    cash_drop_value numeric(13,2),
    cash_drop_reason character varying(40)
);



--
-- Name: pos05_cash_drop_maint; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos05_cash_drop_maint (
    reason_code character varying(10) NOT NULL,
    reason_description character varying(40)
);



--
-- Name: pos06_merchant_id; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos06_merchant_id (
    loc character varying(3) NOT NULL,
    merchant_no character varying(20)
);



--
-- Name: pos07_card_maint; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos07_card_maint (
    ip_address character varying(15) NOT NULL,
    terminal_id character varying(10) NOT NULL,
    loc character varying(3)
);



--
-- Name: pos20_pos_expenses; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos20_pos_expenses (
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    recon_status character varying(1),
    loc character varying(3),
    whs character varying(3),
    cl_code character varying(8),
    paid_to character varying(25),
    doc_ref character varying(11),
    comment character varying(20),
    vat_ind character varying(1),
    amt_excl numeric(13,2),
    vat numeric(13,2),
    amt_incl numeric(13,2),
    last_pos20gl_row_id integer
);



--
-- Name: pos20gl_expenses_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos20gl_expenses_bt (
    batch_no integer NOT NULL,
    pos20_row_id integer NOT NULL,
    gl_row_id integer NOT NULL,
    gl_code character varying(8),
    gl_desc character varying(30),
    loc character varying(3),
    gl_narr character varying(40),
    gl_amount numeric(13,2)
);



--
-- Name: pos21_pos_controller_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos21_pos_controller_hd (
    loc character varying(3) NOT NULL,
    cashup_date date NOT NULL,
    recon_by character varying(10),
    branch_status character varying(1) NOT NULL,
    expense_batch_no character varying(11),
    expense_batch_status character varying(1),
    shortage_batch_no character varying(11),
    shortage_batch_status character varying(1),
    short_over_lockdown_ovrd_by character varying(10),
    short_over_batch_gen_ovrd_by character varying(10),
    tot_cash numeric(13,2),
    tot_card numeric(13,2),
    tot_eft numeric(13,2),
    tot_exp numeric(13,2),
    tot_short numeric(13,2),
    tot_col numeric(13,2),
    tot_inv_incl numeric(13,2),
    tot_pay numeric(13,2)
);



--
-- Name: pos22_shortage_ctrl; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos22_shortage_ctrl (
    loc character varying(3) NOT NULL,
    row_id integer NOT NULL,
    cash_up_date date NOT NULL,
    user_name character varying(10) NOT NULL,
    short_over_amt numeric(13,2),
    resolved character varying(1),
    resolved_remarks character varying(30),
    resolved_by character varying(10),
    resolved_date date
);



--
-- Name: pos30_card_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pos30_card_tran (
    doc_no character varying(11) NOT NULL,
    tran_date date NOT NULL,
    tran_time time(0) without time zone NOT NULL,
    tran_type character varying(10),
    status character varying(1),
    terminal_id character varying(10),
    terminal_type character varying(3),
    terminal_country_code character varying(3),
    terminal_verification character varying(10),
    terminal_capabilities character varying(6),
    card_id character varying(15),
    card_tran_id integer,
    card_seq_no character varying(5),
    card_no character varying(20),
    card_type character varying(30),
    card_holder character varying(30),
    card_usage_control character varying(5),
    card_exp_date character varying(4),
    card_track_1 character varying(50),
    card_track_2 character varying(50),
    card_restriction_code character varying(3),
    tran_currency_code character varying(3),
    currency_code character varying(3),
    authorization_code character varying(3),
    auth_ref character varying(20),
    auth_profile character varying(20),
    encrypted_code character varying(20),
    crypto_type character varying(3),
    verification_code character varying(6),
    denial_code character varying(10),
    issuer_app_data character varying(20),
    emv_tran_status character varying(4),
    emv_tran_type character varying(2),
    emv_encryption_no character varying(8),
    emv_aip character varying(10),
    emv_app_label character varying(10),
    emv_amt numeric(13,2),
    emv_amt_other numeric(13,2),
    emv_tran_seq_counter character varying(8),
    emv_iac_default character varying(10),
    emv_iac_online character varying(10),
    emv_app_version character varying(4),
    emv_version character varying(5),
    pos_data_code character varying(20),
    cashback_amt numeric(13,2),
    merchant_no character varying(20),
    reason_code character varying(4),
    entry_mode character varying(2),
    pos_condition character varying(2),
    response_code character varying(2),
    card_start_date character varying(4),
    retrieval_ref character varying(12),
    pos_reversal character varying(5),
    tot_incl_vat numeric(13,2),
    acc_type character varying(2),
    amount numeric(13,2),
    amount_type character varying(2),
    tran_sign character varying(1),
    local_date character varying(4),
    local_time character varying(6)
);



--
-- Name: pu00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer,
    default_cost character varying(1),
    auto_replace_cost_update character varying(1),
    restrict_bo_purchasing character varying(1),
    restrict_stk_purchasing character varying(1),
    restrict_non_stk_purchasing character varying(1),
    restrict_vat_ind_chg character varying(1),
    block_date_chg character varying(1),
    po_force_due_date character varying(1),
    po_retain_back_order character varying(1),
    po_auto_print_ord character varying(1),
    po_auto_print_back_ord character varying(1),
    po_price_greater_last_cost character varying(1),
    po_restrict_po_del character varying(1),
    po_restrict_po_viewing character varying(1),
    po_restrict_po_amending character varying(1),
    po_restrict_po_bo_amend character varying(1),
    po_allow_deal_on_po character varying(1),
    po_restrict_po_unblock character varying(1),
    po_restrict_supp_confirm character varying(1),
    po_restrict_paid_in_advance character varying(1),
    po_restrict_import_purchase character varying(1),
    po_restrict_import_duties_chg character varying(1),
    po_import_duty_based_on character varying(1),
    po_restrict_import_var character varying(1),
    po_import_rand_var numeric(13,2),
    po_import_perc_var numeric(13,2),
    grn_restrict_viewing character varying(1),
    grn_restrict_grn_po_loc_chg character varying(1),
    grn_restrict_grv_create character varying(1),
    grn_restrict_link_grv_loc_chg character varying(1),
    grn_restrict_over_ord_qty character varying(1),
    grn_auto_print character varying(1),
    grn_use_rebate_perc_increase character varying(1),
    prt_retail_barcode_on_recpt character varying(1),
    prt_stock_barcode_on_recpt character varying(1),
    prt_buyout_lbl_on_recpt character varying(1),
    prt_serial_lbl_on_recpt character varying(1),
    mt_prt_before_grn_match_upd character varying(2),
    mt_prt_after_grn_match_upd character varying(2),
    mt_restrict_price_chg_on_match character varying(1),
    prt_put_away_on_grn character varying(1),
    mt_rand_var_grn numeric(13,2),
    mt_perc_var_grn numeric(7,2),
    gl_grn_var character varying(8),
    gl_grn_accrual character varying(8),
    gl_grn_import_var character varying(8),
    form_prog_retail_barcode character varying(25),
    form_prog_stock_barcode character varying(25),
    form_prog_buyout_label character varying(25),
    form_prog_grn_serial_label character varying(25),
    form_prog_inv_serial_label character varying(25),
    form_prog_stage_stock_label character varying(25),
    form_prog_order character varying(25),
    form_rep_po character varying(25),
    form_prog_grn character varying(25),
    form_prog_put_away character varying(25),
    last_batch_no integer,
    last_sy41_no integer,
    dayend_complete character varying(1),
    edi_rev_del_date_script character varying(255),
    last_apn_no integer
);



--
-- Name: pu01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu01_doc_no (
    loc character varying(3) NOT NULL,
    first_req integer,
    last_req integer,
    cur_req integer,
    first_po integer,
    last_po integer,
    cur_po integer,
    first_grv_req integer,
    last_grv_req integer,
    cur_grv_req integer,
    first_grn integer,
    last_grn integer,
    cur_grn integer,
    first_grv integer,
    last_grv integer,
    cur_grv integer
);



--
-- Name: pu10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu10_ctrl_tot (
    period date NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    ord_out numeric(13,2) DEFAULT 0,
    ord_td numeric(13,2) DEFAULT 0,
    ord_tm numeric(13,2) DEFAULT 0,
    ord_grn_td numeric(13,2) DEFAULT 0,
    ord_grn_tm numeric(13,2) DEFAULT 0,
    dir_grn_td numeric(13,2) DEFAULT 0,
    dir_grn_tm numeric(13,2) DEFAULT 0,
    dir_grv_td numeric(13,2) DEFAULT 0,
    dir_grv_tm numeric(13,2) DEFAULT 0,
    ic_grn_tm numeric(13,2) DEFAULT 0
);



--
-- Name: pu22_po_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu22_po_hd (
    doc_type character varying(1) DEFAULT 'P'::character varying NOT NULL,
    doc_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    status character varying(6),
    period date,
    auto_source_db character varying(20),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    cl_code character varying(8),
    cl_name character varying(40),
    bee_rating integer DEFAULT 0,
    bee_expiry_date date,
    tel_no character varying(22),
    fax_no character varying(22),
    contact character varying(15),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_to_1 character varying(30),
    del_to_2 character varying(30),
    del_to_3 character varying(30),
    del_to_4 character varying(30),
    create_by character varying(10),
    req_sent_to character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    req_date date,
    exp_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    split_del_qty character varying(1),
    import_po character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    forex_boe_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    our_ref character varying(20),
    cred_ref character varying(20),
    delivery_by character varying(15),
    del_area character varying(5),
    block_for_grn character varying(1),
    supp_confirm_received character varying(1),
    paid_in_advance character varying(1),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    import_duty_based_on character varying(1),
    linked_to_import_po character varying(11),
    allocated_to_grn character varying(1),
    import_costs_grned numeric(13,2) DEFAULT 0,
    import_costs_not_grned numeric(13,2) DEFAULT 0,
    doc_value numeric(13,2) DEFAULT 0,
    gen_value numeric(13,2) DEFAULT 0,
    doc_value_forex numeric(13,2) DEFAULT 0,
    gen_value_forex numeric(13,2) DEFAULT 0,
    import_agent_value numeric(13,2) DEFAULT 0,
    import_clear_value numeric(13,2) DEFAULT 0,
    import_levies_value numeric(13,2) DEFAULT 0,
    import_agent_variance numeric(13,2) DEFAULT 0,
    import_var_override_by character varying(10),
    import_var_override_type character varying(1),
    import_gl_variance numeric(13,2) DEFAULT 0,
    printed character varying(1),
    purged_by character varying(10),
    purged_date date,
    purged_time time(0) without time zone,
    edi_sent character varying(1),
    last_pu23_row_id integer DEFAULT 0
);



--
-- Name: pu23_po_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23_po_dt (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    comp_row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    doc_qty numeric(11,3),
    gen_qty numeric(11,3),
    due_qty numeric(11,3),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    net_unit_cost numeric(13,2),
    unit_cost_forex numeric(13,5),
    net_unit_cost_forex numeric(13,5),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_doc_qty numeric(11,3),
    base_gen_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_unit_cost numeric(13,2),
    base_net_unit_cost numeric(13,2),
    base_unit_cost_forex numeric(13,5),
    base_net_unit_cost_forex numeric(13,5),
    vat_ind character varying(1),
    gross numeric(13,2),
    gross_forex numeric(13,2),
    last_pu23d_row_id integer
);



--
-- Name: pu23d_po_split; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23d_po_split (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    split_row_id integer NOT NULL,
    sort_pos integer,
    due_date date,
    req_date date,
    exp_date date,
    doc_qty numeric(11,3),
    gen_qty numeric(11,3),
    base_doc_qty numeric(11,3),
    base_gen_qty numeric(11,3)
);



--
-- Name: pu23ds_deals; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23ds_deals (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    deal_detail_id character varying(40) NOT NULL,
    active character varying(1)
);



--
-- Name: pu23i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23i_bin_alloc (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    bin_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    stk_code character varying(16),
    serial_no character varying(25),
    bin_no character varying(16),
    bin_type character varying(1),
    uom_code character varying(5),
    uom_factor numeric(16,3) DEFAULT 0,
    uom character varying(15),
    bin_qty numeric(11,3) DEFAULT 0,
    bin_qty_to_pull_pack numeric(11,3) DEFAULT 0,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3) DEFAULT 0,
    base_uom character varying(15),
    base_bin_qty numeric(11,3) DEFAULT 0
);



--
-- Name: pu23ic_import_costs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23ic_import_costs (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    prod_code character varying(16),
    desc_1 character varying(40),
    org_qty numeric(11,3) DEFAULT 0,
    grn_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    now_qty numeric(11,3) DEFAULT 0,
    unit_forex numeric(13,5) DEFAULT 0,
    gross_forex numeric(13,2) DEFAULT 0,
    unit_local numeric(13,2) DEFAULT 0,
    costings_gross numeric(13,2) DEFAULT 0,
    duties_gross numeric(13,2) DEFAULT 0,
    xact_duty_tariff_code character varying(16),
    xact_duty_perc numeric(7,2) DEFAULT 0,
    unit_duty numeric(13,2) DEFAULT 0,
    unit_var numeric(13,2) DEFAULT 0,
    gross_var numeric(13,2) DEFAULT 0,
    gross_duty numeric(13,2) DEFAULT 0,
    unit_clear numeric(13,2) DEFAULT 0,
    gross_clear numeric(13,2) DEFAULT 0,
    tot_unit_duty_clear numeric(13,2) DEFAULT 0,
    tot_gross_duty_clear numeric(13,2) DEFAULT 0,
    xact_levy_code character varying(6),
    xact_levy_uom character varying(8),
    xact_levy_cost numeric(13,2) DEFAULT 0,
    xact_levy_gross numeric(13,2) DEFAULT 0,
    gross_landed_cost numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    gross_cost numeric(13,2) DEFAULT 0,
    gl_adjust numeric(13,2) DEFAULT 0
);



--
-- Name: pu23r_rebates; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23r_rebates (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    rebate_code character varying(8) NOT NULL,
    active character varying(1)
);



--
-- Name: pu23s_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23s_serial (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    cl_serial_no character varying(20),
    expiry_date date,
    pack character varying(4),
    serial_qty numeric(11,3) DEFAULT 0,
    gen_qty numeric(11,3) DEFAULT 0
);



--
-- Name: pu23t_tally; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu23t_tally (
    tally_no character varying(7) NOT NULL,
    doc_no character varying(11) NOT NULL,
    pu23_row_id integer NOT NULL,
    tally_type character varying(10) NOT NULL,
    stk_code character varying(16),
    descr character varying(40),
    uom character varying(15),
    qty numeric(11,3),
    net_unit_price numeric(13,2),
    gross numeric(13,2),
    deal_no character varying(8),
    tally_amt integer,
    tally_threshold integer,
    bank_incl character varying(10),
    po_tally_amt numeric(13,2)
);



--
-- Name: pu25_grn_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu25_grn_hd (
    doc_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    doc_type character varying(1),
    status character varying(1),
    period date,
    batch_no integer DEFAULT 0,
    pu22_po_no character varying(11),
    cl_code character varying(8),
    cl_code_chged character varying(1),
    org_cl_code character varying(8),
    cl_name character varying(40),
    tel_no character varying(22),
    fax_no character varying(22),
    contact character varying(15),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_to_1 character varying(30),
    del_to_2 character varying(30),
    del_to_3 character varying(30),
    del_to_4 character varying(30),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    ord_date date,
    our_ref character varying(20),
    cred_ref character varying(20),
    cred_inv_no character varying(20),
    delivery_by character varying(15),
    del_area character varying(5),
    import_po character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    forex_boe_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    import_duty_based_on character varying(1),
    linked_import_po_no character varying(11),
    linked_import_grn_no character varying(11),
    remarks character varying(48),
    proj_code character varying(8),
    proj_desc character varying(40),
    tot_excl_vat numeric(13,2) DEFAULT 0,
    vat_std numeric(13,2) DEFAULT 0,
    vat_zero numeric(13,2) DEFAULT 0,
    vat_exempt numeric(13,2) DEFAULT 0,
    tot_vat numeric(13,2) DEFAULT 0,
    tot_incl_vat numeric(13,2) DEFAULT 0,
    tot_excl_vat_forex numeric(13,2) DEFAULT 0,
    vat_std_forex numeric(13,2) DEFAULT 0,
    vat_zero_forex numeric(13,2) DEFAULT 0,
    vat_exempt_forex numeric(13,2) DEFAULT 0,
    tot_vat_forex numeric(13,2) DEFAULT 0,
    tot_incl_vat_forex numeric(13,2) DEFAULT 0,
    match_status character varying(1),
    match_linked character varying(1),
    match_period date,
    match_date date,
    match_by character varying(10),
    match_cred_ref character varying(20),
    match_our_ref character varying(20),
    match_tot_excl_vat numeric(13,2) DEFAULT 0,
    match_tot_vat numeric(13,2) DEFAULT 0,
    match_tot_incl_vat numeric(13,2) DEFAULT 0,
    match_tot_import_vat numeric(13,2) DEFAULT 0,
    match_tot_excl_vat_forex numeric(13,2) DEFAULT 0,
    match_tot_vat_forex numeric(13,2) DEFAULT 0,
    match_tot_incl_vat_forex numeric(13,2) DEFAULT 0,
    recon_hold character varying(1),
    recon_remarks character varying(41),
    org_grn_no_for_grv character varying(11),
    chg_hist character varying(10),
    import_levies_value numeric(13,2) DEFAULT 0,
    import_gl_variance numeric(13,2) DEFAULT 0,
    import_agent_variance numeric(13,2) DEFAULT 0,
    import_var_override_by character varying(10),
    import_var_override_type character varying(1),
    gl_reval numeric(11,3) DEFAULT 0,
    gl_rebate_st numeric(13,2) DEFAULT 0,
    gl_rebate_st_supp numeric(13,2) DEFAULT 0,
    gl_rebate_bo numeric(13,2) DEFAULT 0,
    gl_rebate_bo_supp numeric(13,2) DEFAULT 0,
    wt_batch_no integer,
    last_pu26_row_id integer DEFAULT 0
);



--
-- Name: pu26_grn_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu26_grn_dt (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    comp_row_id integer NOT NULL,
    po_due_date date,
    po_exp_date date,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    org_ord_qty numeric(11,3),
    org_grn_qty numeric(11,3),
    grved_qty numeric(11,3),
    doc_qty numeric(11,3),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    import_tot_unit_cost numeric(13,2),
    import_levy_unit_cost numeric(13,2),
    import_unit_cost_in_loc_curr numeric(13,2),
    net_unit_cost numeric(13,2),
    vat_ind character varying(1),
    gross numeric(13,2),
    import_gross_cost_in_loc_curr numeric(13,2),
    import_tot_gross_cost numeric(13,2),
    unit_cost_forex numeric(13,5),
    net_unit_cost_forex numeric(13,5),
    gross_forex numeric(13,2),
    keep_bal character varying(1),
    gl_code character varying(8),
    gl_reval numeric(13,2),
    gl_rebate_stk_grp character varying(5),
    gl_rebate_cat character varying(1),
    gl_rebate_perc numeric(13,2),
    gl_rebate_value numeric(13,2),
    gl_rebate_perc_supp numeric(13,2),
    gl_rebate_value_supp numeric(13,2),
    match_vat_ind character varying(1),
    match_gross numeric(13,2),
    match_gross_forex numeric(13,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_org_ord_qty numeric(11,3),
    base_org_grn_qty numeric(11,3),
    base_grved_qty numeric(11,3),
    base_doc_qty numeric(11,3),
    base_unit_cost numeric(13,2),
    base_import_tot_unit_cost numeric(13,2),
    base_import_levy_unit_cost numeric(13,2),
    base_import_unit_cost_in_loc numeric(13,2),
    base_net_unit_price numeric(13,2),
    base_gross numeric(13,2),
    base_import_gross_cost_in_loc numeric(13,2),
    base_import_tot_gross_cost numeric(13,2),
    base_unit_cost_forex numeric(13,2),
    base_net_unit_cost_forex numeric(13,2),
    base_gross_forex numeric(13,2),
    base_gl_rebate_value numeric(13,2),
    base_gl_rebate_perc_supp numeric(13,2),
    base_gl_rebate_value_supp numeric(13,2),
    base_match_vat_ind character varying(1),
    base_match_gross numeric(13,2),
    base_match_gross_forex numeric(13,2),
    match_price_chg_ovrd_by character varying(10),
    pu23_row_id integer,
    st30_row_id integer,
    last_pu26s_row_id integer
);



--
-- Name: pu26i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu26i_bin_alloc (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    bin_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3)
);



--
-- Name: pu26ic_import_costs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu26ic_import_costs (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    prod_code character varying(16),
    desc_1 character varying(40),
    org_qty numeric(11,3) DEFAULT 0,
    grn_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    now_qty numeric(11,3) DEFAULT 0,
    unit_forex numeric(13,5) DEFAULT 0,
    gross_forex numeric(13,2) DEFAULT 0,
    unit_local numeric(13,2) DEFAULT 0,
    costings_gross numeric(13,2) DEFAULT 0,
    duties_gross numeric(13,2) DEFAULT 0,
    xact_duty_tariff_code character varying(16),
    xact_duty_perc numeric(7,2),
    unit_duty numeric(13,2) DEFAULT 0,
    unit_var numeric(13,2) DEFAULT 0,
    gross_var numeric(13,2) DEFAULT 0,
    gross_duty numeric(13,2) DEFAULT 0,
    unit_clear numeric(13,2) DEFAULT 0,
    gross_clear numeric(13,2) DEFAULT 0,
    tot_unit_duty_clear numeric(13,2) DEFAULT 0,
    tot_gross_duty_clear numeric(13,2) DEFAULT 0,
    xact_levy_code character varying(6),
    xact_levy_uom character varying(8),
    xact_levy_cost numeric(13,2) DEFAULT 0,
    xact_levy_gross numeric(13,2) DEFAULT 0,
    gross_landed_cost numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    gross_cost numeric(13,2) DEFAULT 0,
    gl_adjust numeric(13,2) DEFAULT 0
);



--
-- Name: pu26s_grn_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu26s_grn_serial (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    serial_row_id integer NOT NULL,
    sort_pos integer,
    serial_no character varying(25),
    cl_serial_no character varying(20),
    expiry_date date,
    pack character varying(4),
    org_ord_qty numeric(11,3),
    org_grn_qty numeric(11,3),
    grved_qty numeric(11,3),
    serial_qty numeric(11,3),
    stk_serial_qty numeric(11,3)
);



--
-- Name: pu26t_tally; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.pu26t_tally (
    tally_no character varying(7) NOT NULL,
    doc_no character varying(11) NOT NULL,
    pu26_row_id integer NOT NULL,
    tally_type character varying(10) NOT NULL,
    stk_code character varying(16),
    descr character varying(40),
    uom character varying(15),
    qty numeric(11,3),
    net_unit_price numeric(13,2),
    gross numeric(13,2),
    deal_no character varying(8),
    tally_amt integer,
    tally_threshold integer,
    bank_incl character varying(10),
    grn_tally_amt numeric(13,2)
);



--
-- Name: px01_report_data; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.px01_report_data (
    recid integer NOT NULL,
    loc character varying(3) NOT NULL,
    org_recid character varying(32),
    ext character varying(15),
    ext_name character varying(45),
    call_date date,
    call_time time(0) without time zone,
    call_type character varying(20),
    dst character varying(15),
    duration integer,
    cost numeric(13,2) DEFAULT 0,
    call_out integer,
    call_in integer,
    call_int integer
);



--
-- Name: px01_report_data_recid_seq; Type: SEQUENCE; Schema: public; Owner: www-data
--

CREATE SEQUENCE IF NOT EXISTS public.px01_report_data_recid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
-- Name: px01_report_data_recid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: www-data
--

ALTER SEQUENCE public.px01_report_data_recid_seq OWNED BY public.px01_report_data.recid;


--
-- Name: px02_sip_buddies; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.px02_sip_buddies (
    loc character varying(3) NOT NULL,
    ext character varying(15) NOT NULL,
    ext_name character varying(45)
);



--
-- Name: px03_rates; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.px03_rates (
    call_type character varying(13) NOT NULL,
    rate numeric(6,2) DEFAULT 0
);



--
-- Name: sa00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa00_sys_opt (
    period date NOT NULL,
    mths_to_keep_hist integer,
    default_cost character varying(1),
    allow_price_amend character varying(1),
    restrict_cost_ovrd character varying(1),
    restrict_sell_below_cost character varying(1),
    restrict_sell_below_min_gp character varying(1),
    restrict_sell_below_req_gp character varying(1),
    restrict_vat_ind_chg character varying(1),
    restrict_cost_only_items character varying(1),
    restrict_rep_code_chg character varying(1),
    restrict_mkt_rep_chg character varying(1),
    restrict_acct_pay_thru_pos character varying(1),
    restrict_acct_rev_thru_pos character varying(1),
    restrict_pos_reversals character varying(1),
    restrict_pos_cashbacks character varying(1),
    in_pos_cashback_threshold numeric(13,2),
    in_pos_cashback_limit numeric(13,2),
    in_restrict_pos_pin_to_open character varying(1),
    restrict_acct_tender_type character varying(10),
    pos_cash_denomination character varying(1),
    restrict_bom_on_fly_prt character varying(1),
    block_date_chg character varying(1),
    cust_ref_mandatory character varying(1),
    force_due_date character varying(1),
    force_delivery_address character varying(1),
    round_cents character varying(1),
    rounding_value numeric(7,2),
    credit_limit_based_on character varying(1),
    price_disc_option character varying(1),
    consolidate_overrides character varying(1),
    dayend_backup_attempts integer,
    dayend_backup_wait_time integer,
    qt_restrict_qt_del character varying(1),
    qt_restrict_qt_viewing character varying(1),
    qt_restrict_qt_amending character varying(1),
    qt_restrict_auth character varying(1),
    qt_auth_level numeric(13,2),
    qt_track_deposit character varying(1),
    qt_restrict_chg_without_dep character varying(1),
    qt_restrict_deposit_transfer character varying(1),
    qt_auto_update_cost character varying(1),
    qt_purge_after_converted character varying(1),
    qt_default_valid_days integer,
    so_restrict_on_hold_accts character varying(1),
    so_restrict_over_cr_limit_acct character varying(1),
    so_out_bal_warn_perc numeric(7,2),
    so_restrict_so_del character varying(1),
    so_restrict_b2b_order_chg character varying(1),
    so_restrict_bo_so_del character varying(1),
    so_restrict_res_stk character varying(1),
    so_restrict_so_viewing character varying(1),
    so_restrict_so_amending character varying(1),
    so_restrict_replen_so_del character varying(1),
    so_keep_back_orders character varying(1),
    so_auto_print_ord character varying(1),
    so_auto_print_back_ord character varying(1),
    restrict_export_sale character varying(1),
    in_restrict_over_cr_limit_acct character varying(1),
    in_restrict_inv_viewing character varying(1),
    in_restrict_inv_amending character varying(1),
    in_restrict_inv_cod_acct character varying(1),
    in_restrict_inv_so_loc_chg character varying(1),
    in_restrict_cnote_create character varying(1),
    in_restrict_link_crn_loc_chg character varying(1),
    in_restrict_inv_cession character varying(1),
    in_force_cnote_reason character varying(1),
    in_force_cnote_reason_notes character varying(1),
    in_restrict_war_approval character varying(1),
    in_warranty_dl_code character varying(8),
    in_restrict_pos_cnote_tender character varying(1),
    in_restrict_pos_cnote_on_acct character varying(1),
    in_restrict_pos_eft_tender character varying(1),
    in_pos_voucher_valid_days integer,
    in_restrict_kill_pos_voucher character varying(1),
    in_pos_qs_auto_adjust_stk character varying(1),
    in_pos_qs_force_rep_code character varying(1),
    in_pos_loyalty_prompt character varying(1),
    in_restrict_pos_void character varying(1),
    in_restrict_pos_expenses character varying(1),
    in_restrict_pos_expense_void character varying(1),
    in_restrict_short_over_limit character varying(1),
    in_restrict_inv_query character varying(1),
    in_pos_cnote_refund_limit numeric(13,2),
    force_pos_cashup_per_day character varying(1),
    conditions_for_incl_inv character varying(1),
    in_pos_standard_float numeric(13,2),
    in_restrict_pos_cash_drop character varying(1),
    in_pos_force_cash_drop character varying(1),
    in_pos_cash_drop_value numeric(13,2),
    in_pos_short_over_limit numeric(13,2),
    in_dl_short_over_limit numeric(13,2),
    in_pos_email_for_eft_refund character varying(80),
    in_cr_limit_warning_email character varying(80),
    in_auto_print character varying(1),
    auto_print_zero_inv_at_dayend character varying(1),
    auto_email_invoices_at_dayend character varying(1),
    in_prt_header_on_inv character varying(1),
    in_rec_bom_on_inv character varying(1),
    in_update_statement_acct character varying(1),
    inv_prt_costed_item character varying(1),
    inv_api_link character varying(55),
    inv_prt_comp_item character varying(1),
    form_prog_quote character varying(25),
    form_rep_quote character varying(25),
    form_prog_pslip character varying(25),
    form_prog_del_note character varying(25),
    form_prog_pid_del_note character varying(25),
    form_prog_inv character varying(25),
    prt_forex_inv character varying(1),
    form_rep_inv character varying(25),
    form_rep_inv_type character varying(1),
    form_rep_inv_page1 character varying(1),
    form_rep_inv_page2 character varying(1),
    form_rep_inv_page3 character varying(1),
    form_rep_inv_page4 character varying(1),
    form_prog_pos_slip character varying(25),
    form_online_inv_conf character varying(25),
    prt_pull_with_inv character varying(1),
    form_prog_pull_slip character varying(25),
    dayend_complete character varying(1),
    dayend_bu_script character varying(50),
    last_batch_no integer,
    last_sy41_no integer,
    last_apn_no integer,
    custom_field_1_label character varying(24),
    is_custom_field_1_mandatory character varying(1),
    custom_field_1_applies_to character varying(15),
    custom_field_2_label character varying(24),
    is_custom_field_2_mandatory character varying(1),
    custom_field_2_applies_to character varying(15),
    custom_field_3_label character varying(24),
    is_custom_field_3_mandatory character varying(1),
    custom_field_3_applies_to character varying(15),
    custom_field_4_label character varying(24),
    is_custom_field_4_mandatory character varying(1),
    custom_field_4_applies_to character varying(15),
    custom_field_5_label character varying(24),
    is_custom_field_5_mandatory character varying(1),
    custom_field_5_applies_to character varying(15),
    custom_field_6_label character varying(24),
    is_custom_field_6_mandatory character varying(1),
    custom_field_6_applies_to character varying(15),
    custom_field_7_label character varying(24),
    is_custom_field_7_mandatory character varying(1),
    custom_field_7_applies_to character varying(15),
    custom_field_8_label character varying(24),
    is_custom_field_8_mandatory character varying(1),
    custom_field_8_applies_to character varying(15),
    custom_field_9_label character varying(24),
    is_custom_field_9_mandatory character varying(1),
    custom_field_9_applies_to character varying(15),
    custom_field_10_label character varying(24),
    is_custom_field_10_mandatory character varying(1),
    custom_field_10_applies_to character varying(15)
);



--
-- Name: sa01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa01_doc_no (
    loc character varying(3) NOT NULL,
    first_qt integer DEFAULT 0,
    last_qt integer DEFAULT 0,
    cur_qt integer DEFAULT 0,
    first_so integer DEFAULT 0,
    last_so integer DEFAULT 0,
    cur_so integer DEFAULT 0,
    first_pf integer DEFAULT 0,
    last_pf integer DEFAULT 0,
    cur_pf integer DEFAULT 0,
    first_inv integer DEFAULT 0,
    last_inv integer DEFAULT 0,
    cur_inv integer DEFAULT 0,
    first_crn integer DEFAULT 0,
    last_crn integer DEFAULT 0,
    cur_crn integer DEFAULT 0
);



--
-- Name: sa02_quote_terms; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa02_quote_terms (
    terms_code character varying(16) NOT NULL,
    sort_pos integer DEFAULT 0,
    std_term character varying(1),
    wr_term character varying(1) DEFAULT 'N'::character varying,
    ex_term character varying(1) DEFAULT 'N'::character varying,
    terms_desc character varying(40),
    terms character varying(1000)
);



--
-- Name: sa03_qt_reasons; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa03_qt_reasons (
    reason_code character varying(8) NOT NULL,
    sort_pos integer DEFAULT 0,
    reason_lost character varying(40),
    std_reason character varying(1) DEFAULT 'N'::character varying,
    wr_reason character varying(1) DEFAULT 'N'::character varying,
    ex_reason character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: sa04_qt_availability; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa04_qt_availability (
    avail_code character varying(16) NOT NULL,
    sort_pos integer DEFAULT 0,
    avail_desc character varying(80)
);



--
-- Name: sa05_cnote_reasons; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa05_cnote_reasons (
    reason_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    reason_code character varying(8),
    sort_pos integer DEFAULT 0,
    reason_desc character varying(40)
);



--
-- Name: sa10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa10_ctrl_tot (
    period date NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    ord_out numeric(13,2) DEFAULT 0,
    ord_td numeric(13,2) DEFAULT 0,
    ord_tm numeric(13,2) DEFAULT 0,
    inv_ord_td numeric(13,2) DEFAULT 0,
    inv_ord_cost_td numeric(13,2) DEFAULT 0,
    inv_ord_tm numeric(13,2) DEFAULT 0,
    inv_ord_cost_tm numeric(13,2) DEFAULT 0,
    lcrn_inv_ord_td numeric(13,2) DEFAULT 0,
    lcrn_inv_ord_cost_td numeric(13,2) DEFAULT 0,
    lcrn_inv_ord_tm numeric(13,2) DEFAULT 0,
    lcrn_inv_ord_cost_tm numeric(13,2) DEFAULT 0,
    dir_inv_td numeric(13,2) DEFAULT 0,
    dir_inv_cost_td numeric(13,2) DEFAULT 0,
    dir_inv_tm numeric(13,2) DEFAULT 0,
    dir_inv_cost_tm numeric(13,2) DEFAULT 0,
    dir_cr_td numeric(13,2) DEFAULT 0,
    dir_cr_cost_td numeric(13,2) DEFAULT 0,
    dir_cr_tm numeric(13,2) DEFAULT 0,
    dir_cr_cost_tm numeric(13,2) DEFAULT 0,
    ic_sale_tm numeric(13,2) DEFAULT 0,
    ic_cost_tm numeric(13,2) DEFAULT 0
);



--
-- Name: sa20_ic_sales_links; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa20_ic_sales_links (
    stk_co_db character varying(20) NOT NULL,
    sell_co_db character varying(20) NOT NULL,
    sell_co_cl_code character varying(8),
    stk_co_dl_code character varying(8)
);



--
-- Name: sa22_qt_so_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa22_qt_so_hd (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer NOT NULL,
    qt_so_type character varying(1),
    loc character varying(3),
    whs character varying(3),
    del_loc character varying(3),
    del_whs character varying(3),
    status character varying(1),
    period date,
    master_qt_no character varying(11),
    b2b_so character varying(1),
    qt_no_if_so character varying(15),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    dl_code character varying(8),
    dl_address_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    fax_no character varying(22),
    contact character varying(15),
    so_pick_stk character varying(1),
    rep_code character varying(3),
    sub_rep_code character varying(5),
    mkt_rep character varying(3),
    sub_mkt_rep character varying(5),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(30),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    valid_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    proforma_sent_by character varying(10),
    proforma_sent_date date,
    proforma_sent_time time(0) without time zone,
    split_del_qty character varying(1),
    our_ref character varying(20),
    cust_ref character varying(20),
    delivery_by character varying(15),
    del_area character varying(4),
    deposit_req character varying(1),
    deposit_req_perc numeric(3,0),
    deposit_req_amt numeric(13,2),
    deposit_req_amt_forex numeric(13,2),
    deposit_paid_amt numeric(13,2),
    deposit_paid_amt_forex numeric(13,2),
    export_doc character varying(1),
    multi_currency character varying(1),
    export_charge_vat character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4),
    input_currency character varying(1),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    inv_incl character varying(1),
    doc_value numeric(13,2),
    doc_cost numeric(13,2),
    doc_gp_perc numeric(13,2),
    doc_vat numeric(13,2),
    doc_incl_vat numeric(13,2),
    doc_value_forex numeric(13,2),
    doc_cost_forex numeric(13,2),
    doc_vat_forex numeric(13,2),
    doc_incl_vat_forex numeric(13,2),
    gen_value numeric(13,2),
    gen_cost numeric(13,2),
    gen_gp_perc numeric(13,2),
    gen_vat numeric(13,2),
    gen_incl_vat numeric(13,2),
    gen_value_forex numeric(13,2),
    gen_cost_forex numeric(13,2),
    gen_vat_forex numeric(13,2),
    gen_incl_vat_forex numeric(13,2),
    tot_kgs numeric(11,3),
    cr_limit_dl01_curr numeric(13,2),
    credit_available numeric(13,2),
    cr_limit_ovrd_by character varying(10),
    cr_limit_ovrd_value numeric(13,2),
    rep_code_ovrd_by character varying(10),
    mkt_rep_ovrd_by character varying(10),
    reason_code character varying(10),
    qt_auth_by character varying(10),
    qt_auth_date date,
    qt_auth_time time(0) without time zone,
    purged_by character varying(10),
    purged_date date,
    purged_time time(0) without time zone,
    ic_so_no character varying(11),
    stk_co_db character varying(20),
    sell_co_db character varying(20),
    ict_rec_loc character varying(3),
    ict_rec_whs character varying(3),
    web_doc_no character varying(50),
    first_pu23_no integer,
    last_sa23_row_id integer
);



--
-- Name: sa22_qt_so_hd_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa22_qt_so_hd_arch (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer NOT NULL,
    qt_so_type character varying(1),
    loc character varying(3),
    whs character varying(3),
    del_loc character varying(3),
    del_whs character varying(3),
    status character varying(1),
    period date,
    master_qt_no character varying(11),
    b2b_so character varying(1),
    qt_no_if_so character varying(15),
    auto_source character varying(2),
    auto_doc_no character varying(11),
    dl_code character varying(8),
    dl_address_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    fax_no character varying(22),
    contact character varying(15),
    so_pick_stk character varying(1),
    rep_code character varying(3),
    sub_rep_code character varying(5),
    mkt_rep character varying(3),
    sub_mkt_rep character varying(5),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(30),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    valid_date date,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    proforma_sent_by character varying(10),
    proforma_sent_date date,
    proforma_sent_time time(0) without time zone,
    split_del_qty character varying(1),
    our_ref character varying(20),
    cust_ref character varying(20),
    delivery_by character varying(15),
    del_area character varying(4),
    deposit_req character varying(1),
    deposit_req_perc numeric(3,0),
    deposit_req_amt numeric(13,2),
    deposit_req_amt_forex numeric(13,2),
    deposit_paid_amt numeric(13,2),
    deposit_paid_amt_forex numeric(13,2),
    export_doc character varying(1),
    multi_currency character varying(1),
    export_charge_vat character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4),
    input_currency character varying(1),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    inv_incl character varying(1),
    doc_value numeric(13,2),
    doc_cost numeric(13,2),
    doc_gp_perc numeric(13,2),
    doc_vat numeric(13,2),
    doc_incl_vat numeric(13,2),
    doc_value_forex numeric(13,2),
    doc_cost_forex numeric(13,2),
    doc_vat_forex numeric(13,2),
    doc_incl_vat_forex numeric(13,2),
    gen_value numeric(13,2),
    gen_cost numeric(13,2),
    gen_gp_perc numeric(13,2),
    gen_vat numeric(13,2),
    gen_incl_vat numeric(13,2),
    gen_value_forex numeric(13,2),
    gen_cost_forex numeric(13,2),
    gen_vat_forex numeric(13,2),
    gen_incl_vat_forex numeric(13,2),
    tot_kgs numeric(11,3),
    cr_limit_dl01_curr numeric(13,2),
    credit_available numeric(13,2),
    cr_limit_ovrd_by character varying(10),
    cr_limit_ovrd_value numeric(13,2),
    rep_code_ovrd_by character varying(10),
    mkt_rep_ovrd_by character varying(10),
    reason_code character varying(10),
    qt_auth_by character varying(10),
    qt_auth_date date,
    qt_auth_time time(0) without time zone,
    purged_by character varying(10),
    purged_date date,
    purged_time time(0) without time zone,
    ic_so_no character varying(11),
    stk_co_db character varying(20),
    sell_co_db character varying(20),
    ict_rec_loc character varying(3),
    ict_rec_whs character varying(3),
    web_doc_no character varying(50),
    first_pu23_no integer,
    last_sa23_row_id integer
);



--
-- Name: sa22a_qt_action; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa22a_qt_action (
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    call_date date NOT NULL,
    call_time time(0) without time zone NOT NULL,
    note character varying(1000),
    create_by character varying(10),
    action_date date
);



--
-- Name: sa22a_qt_action_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa22a_qt_action_arch (
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    call_date date NOT NULL,
    call_time time(0) without time zone NOT NULL,
    note character varying(1000),
    create_by character varying(10),
    action_date date
);



--
-- Name: sa23_qt_so_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23_qt_so_dt (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    unit_kgs numeric(11,3),
    doc_qty numeric(11,3),
    qt_gen_qty numeric(11,3),
    so_gen_qty numeric(11,3),
    res_qty numeric(11,3),
    due_qty numeric(11,3),
    unit_price numeric(13,2),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    sub_total numeric(13,2),
    disc_2 numeric(7,2),
    net_unit_price numeric(13,2),
    vat_ind character varying(1),
    gross_kgs numeric(11,3),
    gross_cost numeric(13,2),
    gross numeric(13,2),
    unit_price_incl numeric(13,2),
    sub_total_incl numeric(13,2),
    net_unit_price_incl numeric(13,2),
    gross_incl numeric(13,2),
    unit_price_forex numeric(13,5),
    unit_cost_forex numeric(13,2),
    sub_total_forex numeric(13,5),
    net_unit_price_forex numeric(13,5),
    gross_cost_forex numeric(13,2),
    gross_forex numeric(13,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_doc_qty numeric(11,3),
    base_qt_gen_qty numeric(11,3),
    base_so_gen_qty numeric(11,3),
    base_res_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_unit_price numeric(13,2),
    base_unit_cost numeric(13,2),
    base_sub_total numeric(13,2),
    base_net_unit_price numeric(13,2),
    base_gross_cost numeric(13,2),
    base_gross numeric(13,2),
    base_unit_price_incl numeric(13,2),
    base_sub_total_incl numeric(13,2),
    base_net_unit_price_incl numeric(13,2),
    base_gross_incl numeric(13,2),
    base_unit_price_forex numeric(13,5),
    base_unit_cost_forex numeric(13,2),
    base_sub_total_forex numeric(13,5),
    base_net_unit_price_forex numeric(13,5),
    base_gross_cost_forex numeric(13,2),
    base_gross_forex numeric(13,2),
    qt_availability character varying(80),
    po_supp character varying(8),
    po_due_date date,
    po_supp_ref character varying(20),
    po_cost numeric(13,2),
    po_no character varying(11),
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    special_price numeric(13,2),
    combo_no character varying(11),
    combo_ind integer,
    last_sa23s_row_id integer,
    last_sa23d_row_id integer,
    last_sa23m_row_id integer,
    custom_field_1 character varying(24),
    custom_field_2 character varying(24),
    custom_field_3 character varying(24),
    custom_field_4 character varying(24),
    custom_field_5 character varying(24),
    custom_field_6 character varying(24),
    custom_field_7 character varying(24),
    custom_field_8 character varying(24),
    custom_field_9 character varying(24),
    custom_field_10 character varying(24)
);



--
-- Name: sa23_qt_so_dt_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23_qt_so_dt_arch (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    unit_kgs numeric(11,3),
    doc_qty numeric(11,3),
    qt_gen_qty numeric(11,3),
    so_gen_qty numeric(11,3),
    res_qty numeric(11,3),
    due_qty numeric(11,3),
    unit_price numeric(13,2),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    sub_total numeric(13,2),
    disc_2 numeric(7,2),
    net_unit_price numeric(13,2),
    vat_ind character varying(1),
    gross_kgs numeric(11,3),
    gross_cost numeric(13,2),
    gross numeric(13,2),
    unit_price_incl numeric(13,2),
    sub_total_incl numeric(13,2),
    net_unit_price_incl numeric(13,2),
    gross_incl numeric(13,2),
    unit_price_forex numeric(13,5),
    unit_cost_forex numeric(13,2),
    sub_total_forex numeric(13,5),
    net_unit_price_forex numeric(13,5),
    gross_cost_forex numeric(13,2),
    gross_forex numeric(13,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_doc_qty numeric(11,3),
    base_qt_gen_qty numeric(11,3),
    base_so_gen_qty numeric(11,3),
    base_res_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_unit_price numeric(13,2),
    base_unit_cost numeric(13,2),
    base_sub_total numeric(13,2),
    base_net_unit_price numeric(13,2),
    base_gross_cost numeric(13,2),
    base_gross numeric(13,2),
    base_unit_price_incl numeric(13,2),
    base_sub_total_incl numeric(13,2),
    base_net_unit_price_incl numeric(13,2),
    base_gross_incl numeric(13,2),
    base_unit_price_forex numeric(13,5),
    base_unit_cost_forex numeric(13,2),
    base_sub_total_forex numeric(13,5),
    base_net_unit_price_forex numeric(13,5),
    base_gross_cost_forex numeric(13,2),
    base_gross_forex numeric(13,2),
    qt_availability character varying(80),
    po_supp character varying(8),
    po_due_date date,
    po_supp_ref character varying(20),
    po_cost numeric(13,2),
    po_no character varying(11),
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    special_price numeric(13,2),
    combo_no character varying(11),
    combo_ind integer,
    last_sa23s_row_id integer,
    last_sa23d_row_id integer,
    last_sa23m_row_id integer,
    custom_field_1 character varying(24),
    custom_field_2 character varying(24),
    custom_field_3 character varying(24),
    custom_field_4 character varying(24),
    custom_field_5 character varying(24),
    custom_field_6 character varying(24),
    custom_field_7 character varying(24),
    custom_field_8 character varying(24),
    custom_field_9 character varying(24),
    custom_field_10 character varying(24)
);



--
-- Name: sa23a_reason_code; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23a_reason_code (
    doc_no character varying(11) NOT NULL,
    doc_type character varying(1) NOT NULL,
    qt_revision_no integer NOT NULL,
    sa23_row_id integer NOT NULL,
    row_id integer NOT NULL,
    over_type character varying(1),
    over_value numeric(13,2),
    action_type character varying(1),
    request_reason_id integer,
    request_motivation character varying(1000),
    reject_reason_id integer,
    reject_motivation character varying(1000)
);



--
-- Name: sa23d_so_split; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23d_so_split (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    split_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    due_date date,
    ord_qty numeric(11,3) DEFAULT 0,
    inv_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23d_so_split_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23d_so_split_arch (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    split_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    due_date date,
    ord_qty numeric(11,3) DEFAULT 0,
    inv_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23m_qt_comp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23m_qt_comp (
    struct_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    sa23_row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    comp_sort_pos integer DEFAULT 0,
    comp_code character varying(16),
    comp_desc_1 character varying(40),
    comp_desc_2 character varying(40),
    comp_type character varying(3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_cost numeric(13,2) DEFAULT 0,
    comp_price numeric(13,2) DEFAULT 0,
    comp_tot_cost numeric(13,2) DEFAULT 0,
    comp_tot_price numeric(13,2) DEFAULT 0,
    comp_tot_gp numeric(7,2) DEFAULT 0,
    comp_tot_req_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23m_qt_comp_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23m_qt_comp_arch (
    struct_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    sa23_row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    comp_sort_pos integer DEFAULT 0,
    comp_code character varying(16),
    comp_desc_1 character varying(40),
    comp_desc_2 character varying(40),
    comp_type character varying(3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_cost numeric(13,2) DEFAULT 0,
    comp_price numeric(13,2) DEFAULT 0,
    comp_tot_cost numeric(13,2) DEFAULT 0,
    comp_tot_price numeric(13,2) DEFAULT 0,
    comp_tot_gp numeric(7,2) DEFAULT 0,
    comp_tot_req_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23q_quote_req; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23q_quote_req (
    doc_no character varying(11) NOT NULL,
    qt_revision_no integer NOT NULL,
    sa23_row_id integer NOT NULL,
    system_price numeric(13,2),
    chg_price numeric(13,2),
    chg_reason character varying(255),
    start_date date,
    end_date date
);



--
-- Name: sa23s_so_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23s_so_serial (
    so_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    serial_res_qty numeric(11,3) DEFAULT 0,
    stk_serial_res_qty numeric(11,3) DEFAULT 0,
    serial_inv_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23s_so_serial_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23s_so_serial_arch (
    so_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    serial_res_qty numeric(11,3) DEFAULT 0,
    stk_serial_res_qty numeric(11,3) DEFAULT 0,
    serial_inv_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa23t_qt_terms; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23t_qt_terms (
    qt_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    term_code character varying(16),
    terms character varying(1000)
);



--
-- Name: sa23t_qt_terms_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa23t_qt_terms_arch (
    qt_no character varying(11) NOT NULL,
    qt_revision_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    term_code character varying(16),
    terms character varying(1000)
);



--
-- Name: sa25_inv_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa25_inv_hd (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    inv_type character varying(1),
    loc character varying(3),
    whs character varying(3),
    del_loc character varying(3),
    del_whs character varying(3),
    status character varying(1),
    period date,
    sa22_so_no character varying(11),
    jc24_job_no character varying(11),
    dl_code character varying(8),
    dl_address_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(20),
    doc_date date,
    doc_time time(0) without time zone,
    ord_date date,
    credit_req_by character varying(10),
    create_by character varying(10),
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    cust_ref character varying(20),
    our_ref character varying(20),
    rep_code character varying(5),
    sub_rep_code character varying(5),
    mkt_rep character varying(5),
    sub_mkt_rep character varying(5),
    rep_loc character varying(4),
    cession_yn character varying(1),
    delivery_by character varying(15),
    del_area character varying(5),
    export_doc character varying(1),
    export_charge_vat character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    remarks character varying(50),
    proj_code character varying(8),
    proj_desc character varying(40),
    inv_incl character varying(1) DEFAULT 'N'::character varying,
    vat_rate numeric(13,2),
    tot_excl_vat numeric(13,2) DEFAULT 0,
    tot_std_goods_val numeric(13,2) DEFAULT 0,
    tot_zero_goods_val numeric(13,2) DEFAULT 0,
    tot_exempt_goods_val numeric(13,2) DEFAULT 0,
    tot_capex_goods_val numeric(13,2) DEFAULT 0,
    tot_vat numeric(17,5) DEFAULT 0,
    tot_incl_vat numeric(13,2) DEFAULT 0,
    tot_cost numeric(13,2) DEFAULT 0,
    tot_excl_trade_in numeric(13,2) DEFAULT 0,
    tot_excl_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_vat_trade_in numeric(13,2) DEFAULT 0,
    tot_vat_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_incl_trade_in numeric(13,2) DEFAULT 0,
    tot_incl_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_excl_vat_forex numeric(13,2) DEFAULT 0,
    tot_vat_forex numeric(13,2) DEFAULT 0,
    tot_incl_vat_forex numeric(13,2) DEFAULT 0,
    tot_cost_forex numeric(13,2) DEFAULT 0,
    tot_std_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_zero_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_exempt_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_capex_goods_val_forex numeric(13,2) DEFAULT 0,
    gp_perc numeric(13,2) DEFAULT 0,
    tot_kgs numeric(11,3) DEFAULT 0,
    cr_limit_dl01_curr numeric(13,2) DEFAULT 0,
    cr_limit_available numeric(13,2) DEFAULT 0,
    cr_limit_ovrd_by character varying(10),
    cr_limit_ovrd_value numeric(13,2) DEFAULT 0,
    rep_code_ovrd_by character varying(10),
    mkt_rep_ovrd_by character varying(10),
    query_status character varying(1),
    query_by character varying(10),
    pod_scan_status character varying(1),
    pod_sog_status character varying(1) DEFAULT 'N'::character varying,
    pod_captured_by character varying(15),
    pod_date date,
    pod_time time(0) without time zone,
    printed character varying(1),
    times_printed integer DEFAULT 0,
    inv_email character varying(80),
    org_inv_no_for_cnote character varying(48),
    chg_hist character varying(30),
    pid_created character varying(1),
    pos_batch_no integer DEFAULT 0,
    pos_inv character varying(1),
    pos_acct_or_cash character varying(1),
    pos_bo_paid_tot numeric(13,2) DEFAULT 0,
    pos_cash_tendered numeric(13,2) DEFAULT 0,
    pos_cr_card_tendered numeric(13,2) DEFAULT 0,
    pos_db_card_tendered numeric(13,2) DEFAULT 0,
    pos_amex_tendered numeric(13,2) DEFAULT 0,
    pos_chq_tendered numeric(13,2) DEFAULT 0,
    pos_eft_refund numeric(13,2) DEFAULT 0,
    pos_cnote_no_tendered character varying(56),
    pos_cnote_amt_tendered character varying(56),
    pos_tot_tendered numeric(13,2) DEFAULT 0,
    pos_change_tendered numeric(13,2) DEFAULT 0,
    pos_cash_aval numeric(13,2) DEFAULT 0,
    pos_cr_card_aval numeric(13,2) DEFAULT 0,
    pos_db_card_aval numeric(13,2) DEFAULT 0,
    pos_amex_aval numeric(13,2) DEFAULT 0,
    pos_chq_aval numeric(13,2) DEFAULT 0,
    pos_cnote_tender_ovrd_by character varying(10),
    pos_cod_acct_ovrd_by character varying(10),
    pos_cnote_ovrd_by character varying(10),
    pos_aval_for_refund numeric(13,2) DEFAULT 0,
    ic_inv_no character varying(11),
    ic_grn_no character varying(11),
    web_doc_no character varying(50),
    web_doc_confirmed character varying(1),
    wt_batch_no integer,
    last_sa26_row_id integer DEFAULT 0
);



--
-- Name: sa25_inv_hd_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa25_inv_hd_arch (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    inv_type character varying(1),
    loc character varying(3),
    whs character varying(3),
    del_loc character varying(3),
    del_whs character varying(3),
    status character varying(1),
    period date,
    sa22_so_no character varying(11),
    jc24_job_no character varying(11),
    dl_code character varying(8),
    dl_address_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(20),
    doc_date date,
    doc_time time(0) without time zone,
    ord_date date,
    credit_req_by character varying(10),
    create_by character varying(10),
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    cust_ref character varying(20),
    our_ref character varying(20),
    rep_code character varying(5),
    sub_rep_code character varying(5),
    mkt_rep character varying(5),
    sub_mkt_rep character varying(5),
    rep_loc character varying(4),
    cession_yn character varying(1),
    delivery_by character varying(15),
    del_area character varying(5),
    export_doc character varying(1),
    proj_code character varying(8),
    proj_desc character varying(40),
    export_charge_vat character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    remarks character varying(50),
    inv_incl character varying(1) DEFAULT 'N'::character varying,
    vat_rate numeric(13,2),
    tot_excl_vat numeric(13,2) DEFAULT 0,
    tot_std_goods_val numeric(13,2) DEFAULT 0,
    tot_zero_goods_val numeric(13,2) DEFAULT 0,
    tot_exempt_goods_val numeric(13,2) DEFAULT 0,
    tot_capex_goods_val numeric(13,2) DEFAULT 0,
    tot_vat numeric(17,5) DEFAULT 0,
    tot_incl_vat numeric(13,2) DEFAULT 0,
    tot_cost numeric(13,2) DEFAULT 0,
    tot_excl_trade_in numeric(13,2) DEFAULT 0,
    tot_excl_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_vat_trade_in numeric(13,2) DEFAULT 0,
    tot_vat_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_incl_trade_in numeric(13,2) DEFAULT 0,
    tot_incl_trade_in_forex numeric(13,2) DEFAULT 0,
    tot_excl_vat_forex numeric(13,2) DEFAULT 0,
    tot_vat_forex numeric(13,2) DEFAULT 0,
    tot_incl_vat_forex numeric(13,2) DEFAULT 0,
    tot_cost_forex numeric(13,2) DEFAULT 0,
    tot_std_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_zero_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_exempt_goods_val_forex numeric(13,2) DEFAULT 0,
    tot_capex_goods_val_forex numeric(13,2) DEFAULT 0,
    gp_perc numeric(13,2) DEFAULT 0,
    tot_kgs numeric(11,3) DEFAULT 0,
    cr_limit_dl01_curr numeric(13,2) DEFAULT 0,
    cr_limit_available numeric(13,2) DEFAULT 0,
    cr_limit_ovrd_by character varying(10),
    cr_limit_ovrd_value numeric(13,2) DEFAULT 0,
    rep_code_ovrd_by character varying(10),
    mkt_rep_ovrd_by character varying(10),
    query_status character varying(1),
    query_by character varying(10),
    pod_scan_status character varying(1),
    pod_sog_status character varying(1) DEFAULT 'N'::character varying,
    pod_captured_by character varying(15),
    pod_date date,
    pod_time time(0) without time zone,
    printed character varying(1),
    times_printed integer DEFAULT 0,
    inv_email character varying(80),
    org_inv_no_for_cnote character varying(48),
    chg_hist character varying(30),
    pid_created character varying(1),
    pos_batch_no integer DEFAULT 0,
    pos_inv character varying(1),
    pos_acct_or_cash character varying(1),
    pos_bo_paid_tot numeric(13,2) DEFAULT 0,
    pos_cash_tendered numeric(13,2) DEFAULT 0,
    pos_cr_card_tendered numeric(13,2) DEFAULT 0,
    pos_db_card_tendered numeric(13,2) DEFAULT 0,
    pos_amex_tendered numeric(13,2) DEFAULT 0,
    pos_chq_tendered numeric(13,2) DEFAULT 0,
    pos_eft_refund numeric(13,2) DEFAULT 0,
    pos_cnote_no_tendered character varying(56),
    pos_cnote_amt_tendered character varying(56),
    pos_tot_tendered numeric(13,2) DEFAULT 0,
    pos_change_tendered numeric(13,2) DEFAULT 0,
    pos_cash_aval numeric(13,2) DEFAULT 0,
    pos_cr_card_aval numeric(13,2) DEFAULT 0,
    pos_db_card_aval numeric(13,2) DEFAULT 0,
    pos_amex_aval numeric(13,2) DEFAULT 0 NOT NULL,
    pos_chq_aval numeric(13,2) DEFAULT 0,
    pos_cnote_tender_ovrd_by character varying(10),
    pos_cod_acct_ovrd_by character varying(10),
    pos_cnote_ovrd_by character varying(10),
    pos_aval_for_refund numeric(13,2) DEFAULT 0,
    ic_inv_no character varying(11),
    ic_grn_no character varying(11),
    web_doc_no character varying(50),
    web_doc_confirmed character varying(1),
    wt_batch_no integer,
    last_sa26_row_id integer DEFAULT 0
);



--
-- Name: sa26_inv_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26_inv_dt (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    war_prod_code character varying(16),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    unit_kgs numeric(11,3),
    org_ord_qty numeric(11,3),
    org_ord_res_qty numeric(11,3),
    org_inv_qty numeric(11,3),
    doc_qty numeric(11,3),
    credited_qty numeric(11,3),
    unit_price numeric(13,2),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    sub_total numeric(13,2),
    disc_2 numeric(7,2),
    net_unit_price numeric(13,2),
    vat_ind character varying(1),
    gross_kgs numeric(11,3),
    gross numeric(13,2),
    gross_cost numeric(13,2),
    unit_price_incl numeric(13,2),
    sub_total_incl numeric(13,2),
    net_unit_price_incl numeric(13,2),
    gross_incl numeric(17,5),
    unit_price_forex numeric(13,5),
    unit_cost_forex numeric(13,2),
    sub_total_forex numeric(13,5),
    net_unit_price_forex numeric(13,5),
    gross_forex numeric(13,2),
    gross_cost_forex numeric(13,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_doc_qty numeric(11,3),
    base_unit_price numeric(13,2),
    base_unit_cost numeric(13,2),
    base_sub_total numeric(13,2),
    base_net_unit_price numeric(13,2),
    base_gross numeric(13,2),
    base_gross_cost numeric(13,2),
    base_unit_price_incl numeric(13,2),
    base_sub_total_incl numeric(13,2),
    base_net_unit_price_incl numeric(13,2),
    base_gross_incl numeric(13,2),
    base_unit_price_forex numeric(13,2),
    base_unit_cost_forex numeric(13,5),
    base_sub_total_forex numeric(13,2),
    base_net_unit_price_forex numeric(13,2),
    base_gross_forex numeric(13,2),
    base_gross_cost_forex numeric(13,2),
    user_auth_min_gp character varying(10),
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    special_price numeric(13,2),
    retail_sale character varying(1),
    del_qty numeric(11,3),
    notes character varying(1000),
    sa23_row_id integer,
    st30_row_id integer,
    last_sa26s_row_id integer,
    last_sa26m_row_id integer,
    custom_field_1 character varying(24),
    custom_field_2 character varying(24),
    custom_field_3 character varying(24),
    custom_field_4 character varying(24),
    custom_field_5 character varying(24),
    custom_field_6 character varying(24),
    custom_field_7 character varying(24),
    custom_field_8 character varying(24),
    custom_field_9 character varying(24),
    custom_field_10 character varying(24)
);



--
-- Name: sa26_inv_dt_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26_inv_dt_arch (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sort_pos integer,
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    war_prod_code character varying(16),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    unit_kgs numeric(11,3),
    org_ord_qty numeric(11,3),
    org_ord_res_qty numeric(11,3),
    org_inv_qty numeric(11,3),
    doc_qty numeric(11,3),
    credited_qty numeric(11,3),
    unit_price numeric(13,2),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    sub_total numeric(13,2),
    disc_2 numeric(7,2),
    net_unit_price numeric(13,2),
    vat_ind character varying(1),
    gross_kgs numeric(11,3),
    gross numeric(13,2),
    gross_cost numeric(13,2),
    unit_price_incl numeric(13,2),
    sub_total_incl numeric(13,2),
    net_unit_price_incl numeric(13,2),
    gross_incl numeric(17,5),
    unit_price_forex numeric(13,5),
    unit_cost_forex numeric(13,2),
    sub_total_forex numeric(13,5),
    net_unit_price_forex numeric(13,5),
    gross_forex numeric(13,2),
    gross_cost_forex numeric(13,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_doc_qty numeric(11,3),
    base_unit_price numeric(13,2),
    base_unit_cost numeric(13,2),
    base_sub_total numeric(13,2),
    base_net_unit_price numeric(13,2),
    base_gross numeric(13,2),
    base_gross_cost numeric(13,2),
    base_unit_price_incl numeric(13,2),
    base_sub_total_incl numeric(13,2),
    base_net_unit_price_incl numeric(13,2),
    base_gross_incl numeric(13,2),
    base_unit_price_forex numeric(13,2),
    base_unit_cost_forex numeric(13,5),
    base_sub_total_forex numeric(13,2),
    base_net_unit_price_forex numeric(13,2),
    base_gross_forex numeric(13,2),
    base_gross_cost_forex numeric(13,2),
    user_auth_min_gp character varying(10),
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10),
    special_price numeric(13,2),
    retail_sale character varying(1),
    del_qty numeric(11,3),
    notes character varying(1000),
    sa23_row_id integer,
    st30_row_id integer,
    last_sa26s_row_id integer,
    last_sa26m_row_id integer,
    custom_field_1 character varying(24),
    custom_field_2 character varying(24),
    custom_field_3 character varying(24),
    custom_field_4 character varying(24),
    custom_field_5 character varying(24),
    custom_field_6 character varying(24),
    custom_field_7 character varying(24),
    custom_field_8 character varying(24),
    custom_field_9 character varying(24),
    custom_field_10 character varying(24)
);



--
-- Name: sa26a_reason_code; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26a_reason_code (
    doc_no character varying(11) NOT NULL,
    doc_type character varying(1) NOT NULL,
    sa26_row_id integer NOT NULL,
    row_id integer NOT NULL,
    over_type character varying(1),
    over_value numeric(13,2),
    action_type character varying(1),
    request_reason_id integer,
    request_motivation character varying(1000),
    reject_reason_id integer,
    reject_motivation character varying(1000)
);



--
-- Name: sa26e_api_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26e_api_tran (
    doc_no character varying(11) NOT NULL,
    sess_id character varying(36) NOT NULL,
    tran_date date NOT NULL,
    tran_time time(0) without time zone NOT NULL,
    api_prod_code character varying(13),
    our_ref character varying(64),
    gross_incl numeric(13,2),
    acct_no character varying(10),
    resp_code character varying(5),
    tran_ref character varying(10),
    resp_msg character varying(150),
    pin character varying(15),
    serial_no character varying(10),
    tran_amt_incl numeric(13,2)
);



--
-- Name: sa26i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26i_bin_alloc (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    stk_code character varying(16),
    serial_no character varying(25),
    bin_no character varying(16),
    bin_type character varying(1),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3)
);



--
-- Name: sa26i_bin_alloc_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26i_bin_alloc_arch (
    doc_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    stk_code character varying(16),
    serial_no character varying(25),
    bin_no character varying(16),
    bin_type character varying(1),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3)
);



--
-- Name: sa26m_inv_comp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26m_inv_comp (
    doc_no character varying(11) NOT NULL,
    sa26_row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    comp_sort_pos integer DEFAULT 0,
    bom_prod_code character varying(16),
    comp_code character varying(16),
    comp_desc_1 character varying(40),
    comp_desc_2 character varying(40),
    comp_type character varying(3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_cost numeric(13,2) DEFAULT 0,
    comp_price numeric(13,2) DEFAULT 0,
    comp_tot_cost numeric(13,2) DEFAULT 0,
    comp_tot_price numeric(13,2) DEFAULT 0,
    comp_tot_gp numeric(7,2) DEFAULT 0,
    comp_tot_req_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa26m_inv_comp_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26m_inv_comp_arch (
    doc_no character varying(11) NOT NULL,
    sa26_row_id integer DEFAULT 0 NOT NULL,
    comp_row_id integer DEFAULT 0 NOT NULL,
    comp_sort_pos integer DEFAULT 0,
    bom_prod_code character varying(16),
    comp_code character varying(16),
    comp_desc_1 character varying(40),
    comp_desc_2 character varying(40),
    comp_type character varying(3),
    comp_qty numeric(11,3) DEFAULT 0,
    comp_cost numeric(13,2) DEFAULT 0,
    comp_price numeric(13,2) DEFAULT 0,
    comp_tot_cost numeric(13,2) DEFAULT 0,
    comp_tot_price numeric(13,2) DEFAULT 0,
    comp_tot_gp numeric(7,2) DEFAULT 0,
    comp_tot_req_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa26r_cnote_reason; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26r_cnote_reason (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    reason_id integer,
    reason_notes character varying(255)
);



--
-- Name: sa26r_cnote_reason_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26r_cnote_reason_arch (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    reason_id integer,
    reason_notes character varying(255)
);



--
-- Name: sa26s_inv_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26s_inv_serial (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    pack character varying(4),
    org_inv_qty numeric(11,3) DEFAULT 0,
    org_ord_res_qty numeric(11,3) DEFAULT 0,
    credited_qty numeric(11,3) DEFAULT 0,
    doc_qty numeric(11,3) DEFAULT 0,
    stk_doc_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa26s_inv_serial_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa26s_inv_serial_arch (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    pack character varying(4),
    org_inv_qty numeric(11,3) DEFAULT 0,
    org_ord_res_qty numeric(11,3) DEFAULT 0,
    credited_qty numeric(11,3) DEFAULT 0,
    doc_qty numeric(11,3) DEFAULT 0,
    stk_doc_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa290_sales_anal; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa290_sales_anal (
    user_name character varying(10) NOT NULL,
    type character varying(25) NOT NULL,
    section character varying(25) NOT NULL,
    stk_grp character varying(25) NOT NULL,
    loc character varying(3) NOT NULL,
    value numeric(13,2) DEFAULT 0
);



--
-- Name: sa291_arb_sales_by_opr; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa291_arb_sales_by_opr (
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    create_by character varying(10) NOT NULL,
    prev_sales numeric(13,2) DEFAULT 0,
    prev_profit numeric(13,2) DEFAULT 0,
    prev_gp numeric(13,2) DEFAULT 0,
    prev_docs numeric(11,3) DEFAULT 0,
    last_sales numeric(13,2) DEFAULT 0,
    last_profit numeric(13,2) DEFAULT 0,
    last_gp numeric(13,2) DEFAULT 0,
    last_docs numeric(11,3) DEFAULT 0,
    curr_sales numeric(13,2) DEFAULT 0,
    curr_profit numeric(13,2) DEFAULT 0,
    curr_gp numeric(13,2) DEFAULT 0,
    curr_docs numeric(11,3) DEFAULT 0
);



--
-- Name: sa30_pi_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa30_pi_hd (
    doc_type character varying(3) NOT NULL,
    doc_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    status character varying(1),
    sa22_so_no character varying(11),
    dl_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(20),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    cust_ref character varying(20),
    our_ref character varying(20),
    rep_code character varying(5),
    delivery_by character varying(15),
    remarks character varying(50),
    tot_kgs numeric(11,3) DEFAULT 0,
    last_sa32_del_no integer DEFAULT 0
);



--
-- Name: sa30t_tax_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa30t_tax_tran (
    doc_no character varying(11) NOT NULL,
    tran_id character varying(35),
    response_code integer,
    response_msg character varying(150)
);



--
-- Name: sa31_pi_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa31_pi_dt (
    doc_type character varying(3) NOT NULL,
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    unit_kgs numeric(11,3) DEFAULT 0,
    doc_qty numeric(11,3) DEFAULT 0,
    del_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    last_del_qty numeric(11,3) DEFAULT 0,
    gross_kgs numeric(11,3) DEFAULT 0
);



--
-- Name: sa31s_pi_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa31s_pi_serial (
    doc_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    pack character varying(4),
    doc_qty numeric(11,3) DEFAULT 0,
    del_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    last_del_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa32_pi_dn_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa32_pi_dn_hd (
    doc_type character varying(3) NOT NULL,
    doc_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    dl_code character varying(8),
    dl_name character varying(40),
    vat_no character varying(12),
    tel_no character varying(22),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(30),
    del_add_1 character varying(30),
    del_add_2 character varying(30),
    del_add_3 character varying(30),
    del_add_4 character varying(30),
    create_by character varying(10),
    doc_date date,
    doc_time time(0) without time zone,
    due_date date,
    cust_ref character varying(20),
    our_ref character varying(20),
    rep_code character varying(5),
    delivery_by character varying(15),
    remarks character varying(50),
    tot_kgs numeric(11,3) DEFAULT 0,
    times_prted integer DEFAULT 0,
    del_printed character varying(1),
    last_sa33_del_row_id integer DEFAULT 0
);



--
-- Name: sa33_pi_dn_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa33_pi_dn_dt (
    doc_type character varying(3) NOT NULL,
    doc_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    del_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    uom character varying(8),
    unit_kgs numeric(11,3) DEFAULT 0,
    inv_qty numeric(11,3) DEFAULT 0,
    del_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    now_del_qty numeric(11,3) DEFAULT 0,
    gross_kgs numeric(11,3) DEFAULT 0,
    last_sa33s_del_row_id integer DEFAULT 0
);



--
-- Name: sa33s_pi_dn_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa33s_pi_dn_serial (
    doc_no character varying(11) NOT NULL,
    del_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    del_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    serial_no character varying(25),
    pack character varying(4),
    inv_qty numeric(11,3) DEFAULT 0,
    del_qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    now_del_qty numeric(11,3) DEFAULT 0
);



--
-- Name: sa40_email_inv; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sa40_email_inv (
    user_name character varying(10) NOT NULL,
    doc_type character varying(1) NOT NULL,
    doc_no character varying(12) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    filename character varying(80)
);



--
-- Name: sc30_batch_status_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sc30_batch_status_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    batch_type character varying(1) NOT NULL,
    status character varying(10)
);



--
-- Name: sc31_batch_status_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sc31_batch_status_dt (
    batch_no integer DEFAULT 0 NOT NULL,
    batch_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_row_id integer NOT NULL,
    status character varying(50)
);



--
-- Name: sc35_file_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sc35_file_log (
    row_id integer NOT NULL,
    date date,
    "time" time(0) without time zone,
    file_name character varying(255)
);



--
-- Name: st00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st00_sys_opt (
    period date NOT NULL,
    tran_hist integer,
    min_tran_items integer,
    use_barcode character varying(1),
    gen_barcode character varying(1),
    last_barcode_no character varying(16),
    gen_bar_prog character varying(10),
    auto_gen_serial_no character varying(1),
    last_serial_no integer,
    prt_serial_label character varying(1),
    prt_serial_in_loc character varying(1),
    valuation_method character varying(1),
    force_special_auth character varying(1),
    allow_qty_from_special_amend character varying(1),
    auto_gen_bin_transfers character varying(1),
    enter_supp character varying(1),
    price_calc_method character varying(3),
    cost_for_gp_display character varying(1),
    diff_pricing_in_all_locs character varying(1),
    pricing_input_excl_incl character varying(1),
    pricing_calc_based_on character varying(1),
    pricing_by_multi_uom character varying(1),
    restrict_cost_viewing character varying(1),
    restrict_replace_viewing character varying(1),
    restrict_value_viewing character varying(1),
    restrict_rebate_viewing character varying(1),
    restrict_discount_viewing character varying(1),
    restrict_ser_excp_reports character varying(1),
    restrict_bin_not_scan character varying(1),
    restrict_stk_items_not_scan character varying(1),
    restrict_auth_var character varying(1),
    restrict_stocktake_process character varying(1),
    include_ibt_on_random_stk_cnt character varying(1),
    enq_display_bal_with character varying(1),
    enq_display_move_as character varying(1),
    unique_ref_on_batches character varying(1),
    repeat_detail_on_create character varying(1),
    prt_barcode_on_recpt character varying(1),
    prt_adj_batch_rep character varying(1),
    form_package_prnt character varying(25),
    form_randm_stk_prnt character varying(25),
    ic_auto_inv character varying(1),
    ic_auto_grn character varying(1),
    ic_auto_crn character varying(1),
    wt_dispatch_type character varying(1),
    restrict_wt_variance_view character varying(1),
    claim_prod_code character varying(16),
    gl_rec character varying(8),
    gl_adj character varying(8),
    gl_reval character varying(8),
    gl_levies character varying(8),
    gl_woff character varying(8),
    gl_rebate character varying(8),
    gl_rebate_supp character varying(8),
    gl_ibt_in_transit character varying(8),
    gl_scrap character varying(8),
    gl_tally_to_claim character varying(8),
    gl_tally_to_match character varying(8),
    last_batch_no integer,
    last_replen_batch_no integer,
    last_st35_batch_no integer,
    last_st37_batch_no integer,
    last_sy41_no integer,
    last_price_batch_no integer,
    last_apn_no integer,
    last_st44_batch_no integer,
    last_st06t_row_id integer
);



--
-- Name: st00gl_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st00gl_sys_opt (
    gl_grp integer DEFAULT 0 NOT NULL,
    active character varying(1),
    link_desc character varying(25),
    keep_bal character varying(1) DEFAULT 'Y'::character varying,
    gl_val character varying(8),
    gl_sales character varying(8),
    gl_cost character varying(8),
    gl_adjust character varying(8),
    ic_gl_sales character varying(8),
    ic_gl_cost character varying(8)
);



--
-- Name: st01_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01_mast (
    stk_code character varying(16) NOT NULL,
    status character varying(1),
    replen_status character varying(1),
    master_acct character varying(1),
    linked_to character varying(16),
    web_enabled character varying(1),
    retail_enabled character varying(1),
    trade_in_item character varying(1),
    import_item character varying(1),
    track_expiry_date character varying(1) DEFAULT 'N'::character varying,
    api_enabled character varying(1) DEFAULT 'N'::character varying,
    api_prod_code character varying(13),
    reverse_qty_sign character varying(1) DEFAULT 'N'::character varying,
    reverse_type character varying(1),
    qty_decimal_input character varying(1),
    scale_item character varying(1),
    scale_type character varying(1),
    scale_shelf_life integer,
    create_date date,
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    barcode character varying(16),
    keep_bal character varying(1),
    import_duty_item character varying(1),
    stk_grp character varying(5),
    list_gp_cat character varying(1),
    serial_track character varying(1),
    auto_gen_serial character varying(1),
    serial_pack character varying(4),
    track_sfd character varying(1) DEFAULT 'N'::character varying,
    price_list_item character varying(1),
    keep_tran character varying(1),
    default_bom_type character varying(3),
    gl_grp integer DEFAULT 0,
    uom character varying(5),
    unit_qty numeric(11,3) DEFAULT 0,
    mass numeric(11,3) DEFAULT 0,
    warn_lvl_1 integer DEFAULT 0,
    warn_lvl_2 integer DEFAULT 0,
    lead_time numeric(5,2) DEFAULT 0,
    line_type character varying(1),
    re_order integer DEFAULT 0,
    re_order_perc integer DEFAULT 0,
    qc_enabled character varying(1),
    qc_based_on character varying(1),
    qc_qty numeric(11,3) DEFAULT 0,
    qc_perc numeric(7,2) DEFAULT 0,
    qc_instructions character varying(255),
    hs_code character varying(13),
    duty_tariff_code character varying(16),
    clearing_agent_code character varying(8),
    import_currency character varying(10),
    levy_code character varying(6),
    vat_ind character varying(1),
    enter_cost character varying(1),
    ovrd_desc character varying(4),
    auto_price character varying(1),
    last_st30_row_id integer DEFAULT 0,
    last_st30i_row_id integer DEFAULT 0,
    last_st33_row_id integer DEFAULT 0
);



--
-- Name: st01cpa_factor; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01cpa_factor (
    stk_code character varying(16) NOT NULL,
    material character varying(20) NOT NULL,
    factor numeric(8,5) DEFAULT 0
);



--
-- Name: st01i_image; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01i_image (
    row_id integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    filename character varying(255)
);



--
-- Name: st01l_lot_cuts; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01l_lot_cuts (
    serial_no character varying(25) NOT NULL,
    status character varying(1),
    cut_allocated integer DEFAULT 0,
    org_serial_no character varying(25),
    doc_no character varying(11),
    batch_no integer
);



--
-- Name: st01n_notes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01n_notes (
    stk_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    note_date date,
    note character varying(65),
    status character varying(6)
);



--
-- Name: st01p_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01p_per_tot (
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    period date NOT NULL,
    sale_qty numeric(11,3) DEFAULT 0,
    del_sale_qty numeric(11,3) DEFAULT 0,
    sale_value numeric(13,2) DEFAULT 0,
    sale_cost numeric(13,2) DEFAULT 0,
    bom_sale_qty numeric(11,3) DEFAULT 0,
    pur_qty numeric(11,3) DEFAULT 0,
    pur_value numeric(13,2) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    wo_comp_qty numeric(11,3) DEFAULT 0,
    ibt_qty_out numeric(11,3) DEFAULT 0,
    ibt_qty_in numeric(11,3) DEFAULT 0,
    adj_qty numeric(11,3) DEFAULT 0,
    adj_value numeric(13,2) DEFAULT 0,
    open_bal numeric(11,3) DEFAULT 0,
    close_bal numeric(11,3) DEFAULT 0,
    cost numeric(11,3) DEFAULT 0,
    ic_sale_qty numeric(11,3) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_sale_cost numeric(13,2) DEFAULT 0,
    ic_bom_sale_qty numeric(11,3) DEFAULT 0,
    ic_pur_qty numeric(11,3) DEFAULT 0,
    ic_pur_value numeric(13,2) DEFAULT 0
);



--
-- Name: st01pd_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01pd_per_tot (
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    dl_code character varying(8) NOT NULL,
    period date NOT NULL,
    sale_qty numeric(11,3) DEFAULT 0,
    sale_value numeric(13,2) DEFAULT 0,
    sale_cost numeric(13,2) DEFAULT 0,
    bom_sale_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    wo_comp_qty numeric(11,3) DEFAULT 0,
    ic_sale_qty numeric(11,3) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_sale_cost numeric(13,2) DEFAULT 0,
    ic_bom_sale_qty numeric(11,3) DEFAULT 0
);



--
-- Name: st01pr_per_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01pr_per_tot (
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    rep_code character varying(5) NOT NULL,
    period date NOT NULL,
    sale_qty numeric(11,3) DEFAULT 0,
    sale_value numeric(13,2) DEFAULT 0,
    sale_cost numeric(13,2) DEFAULT 0,
    bom_sale_qty numeric(11,3) DEFAULT 0,
    wo_qty numeric(11,3) DEFAULT 0,
    wo_comp_qty numeric(11,3) DEFAULT 0,
    ic_sale_qty numeric(11,3) DEFAULT 0,
    ic_sale_value numeric(13,2) DEFAULT 0,
    ic_sale_cost numeric(13,2) DEFAULT 0,
    ic_bom_sale_qty numeric(11,3) DEFAULT 0
);



--
-- Name: st01r_related_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01r_related_codes (
    stk_code character varying(16) NOT NULL,
    type character varying(1) NOT NULL,
    related_code character varying(16) NOT NULL,
    notes character varying(100)
);



--
-- Name: st01s_serial_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01s_serial_no (
    serial_no character varying(25) NOT NULL,
    stk_code character varying(16),
    pack_code character varying(4),
    loc character varying(3),
    whs character varying(3),
    expiry_date date,
    cl_code character varying(8),
    cl_serial_no character varying(20),
    open_bal numeric(11,3),
    recpt numeric(11,3),
    sales numeric(11,3),
    adj numeric(11,3),
    phy_bal numeric(11,3),
    allocated numeric(11,3),
    res_qty numeric(11,3),
    res_pick numeric(11,3),
    wt_res numeric(11,3),
    ibt_allocated numeric(11,3),
    ibt_due_to_ship numeric(11,3),
    stk_take_open_bal numeric(11,3),
    stk_take_close_bal numeric(11,3),
    stk_take_scanned character varying(1),
    last_st30s_row_id integer
);



--
-- Name: st01sg_sub_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01sg_sub_grp (
    stk_code character varying(16) NOT NULL,
    stk_sub_grp character varying(5) NOT NULL
);



--
-- Name: st01td_long_desc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01td_long_desc (
    stk_code character varying(16) NOT NULL,
    long_desc character varying(1000)
);



--
-- Name: st01ts_tech_spec; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01ts_tech_spec (
    stk_code character varying(16) NOT NULL,
    spec_type character varying(100),
    spec_desc character varying(1000)
);



--
-- Name: st01u_uom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01u_uom (
    stk_code character varying(16) NOT NULL,
    level integer NOT NULL,
    level_desc character varying(20),
    modules character varying(25),
    uom character varying(5),
    level_1_factor numeric(16,3),
    disc numeric(13,2),
    uom_barcode character varying(16),
    uom_barcode_prev character varying(16),
    re_order integer,
    re_order_perc integer,
    length numeric(16,3),
    width numeric(16,3),
    height numeric(16,3),
    volume numeric(16,3),
    gross_mass numeric(16,5),
    pack_code character varying(20)
);



--
-- Name: st01u_uom_helper; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st01u_uom_helper (
    stk_code character varying(16),
    level integer NOT NULL,
    level_desc character varying(20),
    modules character varying(25),
    uom character varying(5),
    level_1_factor numeric(16,3) DEFAULT 0,
    disc numeric(13,2) DEFAULT 0,
    uom_barcode character varying(16),
    uom_barcode_prev character varying(16),
    length numeric(16,3) DEFAULT 0,
    width numeric(16,3) DEFAULT 0,
    height numeric(16,3) DEFAULT 0,
    volume numeric(16,3) DEFAULT 0,
    gross_mass numeric(16,5) DEFAULT 0,
    pack_code character varying(20),
    helper_desc_2 character varying(40)
);



--
-- Name: st02_stk_loc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st02_stk_loc (
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    min_level integer,
    max_level integer,
    bin_qty_tracking character varying(1),
    cost numeric(13,2),
    last_cost numeric(13,2),
    last_po_cost numeric(13,2),
    last_po_no character varying(14),
    replace_cost numeric(13,2),
    wo_ave_cost numeric(13,2),
    std_cost numeric(13,2),
    open_bal numeric(11,3),
    recpt numeric(11,3),
    sales numeric(11,3),
    adj numeric(11,3),
    stk_take_adj numeric(11,3),
    mrp_adj numeric(11,3),
    phy_bal numeric(11,3),
    so_tot numeric(11,3),
    po_tot numeric(11,3),
    grv_req numeric(11,3),
    res_stk numeric(11,3),
    res_pick numeric(11,3),
    wt_res numeric(11,3),
    ibt_allocated numeric(11,3),
    ibt_due_to_ship_in numeric(11,3),
    ibt_due_to_ship_out numeric(11,3),
    ibt_to_rec numeric(11,3),
    ib_req numeric(11,3),
    wip_issues numeric(11,3),
    wip numeric(11,3),
    in_prod numeric(11,3),
    inv_allocated numeric(11,3),
    last_inv_date date,
    last_grn_date date,
    stk_take_open_bal numeric(11,3),
    stk_take_close_bal numeric(11,3),
    stk_take_updated character varying(1),
    stk_take_scanned character varying(1)
);



--
-- Name: st02b_loc_bins; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st02b_loc_bins (
    stk_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    level integer NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    bin_type character varying(1),
    bin_no character varying(16) NOT NULL,
    uom_code character varying(5),
    uom_factor numeric(13,2),
    uom character varying(15),
    bin_qty numeric(13,2),
    bin_qty_to_pull_pack numeric(11,3),
    bin_allocated numeric(11,3),
    bin_min_qty integer,
    bin_max_qty integer,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3),
    base_bin_allocated numeric(11,3),
    stk_take_open_bal numeric(11,3),
    stk_take_close_bal numeric(11,3),
    stk_take_scanned character varying(1)
);



--
-- Name: st02r_adj_reasons; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st02r_adj_reasons (
    reason_code character varying(8) NOT NULL,
    sort_pos integer DEFAULT 0,
    reason_desc character varying(35)
);



--
-- Name: st03_bin_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st03_bin_mast (
    bin_no character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    bin_desc character varying(40),
    bin_type character varying(1),
    uom character varying(10),
    width numeric(16,3),
    height numeric(16,3),
    depth numeric(16,3)
);



--
-- Name: st04_stk_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st04_stk_grp (
    section character varying(25) NOT NULL,
    stk_grp character varying(5) NOT NULL,
    loc character varying(3) NOT NULL,
    grp_desc character varying(30),
    gl_grp integer,
    auto_price_a character varying(1),
    auto_price_b character varying(1),
    auto_price_c character varying(1),
    amend_replace_cost_a character varying(1),
    amend_replace_cost_b character varying(1),
    amend_replace_cost_c character varying(1),
    amend_replace_cost_m character varying(1),
    amend_list_gp_a character varying(1),
    amend_list_gp_b character varying(1),
    amend_list_gp_c character varying(1),
    amend_list_gp_m character varying(1),
    amend_list_price_a character varying(1),
    amend_list_price_b character varying(1),
    amend_list_price_c character varying(1),
    amend_list_price_m character varying(1),
    amend_disc_perc_gp_a character varying(1),
    amend_disc_perc_gp_b character varying(1),
    amend_disc_perc_gp_c character varying(1),
    amend_disc_perc_gp_m character varying(1),
    amend_disc_perc_a character varying(1),
    amend_disc_perc_b character varying(1),
    amend_disc_perc_c character varying(1),
    amend_disc_perc_m character varying(1),
    amend_disc_price_a character varying(1),
    amend_disc_price_b character varying(1),
    amend_disc_price_c character varying(1),
    amend_disc_price_m character varying(1),
    list_gp_a numeric(7,2),
    list_gp_b numeric(7,2),
    list_gp_c numeric(7,2),
    disc_price_based_on_a character varying(1),
    disc_price_based_on_b character varying(1),
    disc_price_based_on_c character varying(1),
    level_1_a numeric(7,2),
    level_2_a numeric(7,2),
    level_3_a numeric(7,2),
    level_4_a numeric(7,2),
    level_5_a numeric(7,2),
    level_6_a numeric(7,2),
    level_7_a numeric(7,2),
    level_8_a numeric(7,2),
    level_1_b numeric(7,2),
    level_2_b numeric(7,2),
    level_3_b numeric(7,2),
    level_4_b numeric(7,2),
    level_5_b numeric(7,2),
    level_6_b numeric(7,2),
    level_7_b numeric(7,2),
    level_8_b numeric(7,2),
    level_1_c numeric(7,2),
    level_2_c numeric(7,2),
    level_3_c numeric(7,2),
    level_4_c numeric(7,2),
    level_5_c numeric(7,2),
    level_6_c numeric(7,2),
    level_7_c numeric(7,2),
    level_8_c numeric(7,2),
    min_gp_perc_a numeric(7,2),
    min_gp_perc_b numeric(7,2),
    min_gp_perc_c numeric(7,2),
    req_gp_perc_a numeric(7,2),
    req_gp_perc_b numeric(7,2),
    req_gp_perc_c numeric(7,2),
    restrict_access character varying(1),
    restrict_cost_view character varying(1),
    restrict_replace_view character varying(1),
    restrict_value_view character varying(1),
    restrict_pu character varying(1),
    restrict_sa character varying(1),
    rebate_increase_a numeric(7,2),
    rebate_increase_b numeric(7,2),
    rebate_increase_c numeric(7,2),
    perc_buffer_replace_cost_a numeric(7,2),
    perc_buffer_replace_cost_b numeric(7,2),
    perc_buffer_replace_cost_c numeric(7,2)
);



--
-- Name: st04d_grp_div; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st04d_grp_div (
    div_code character varying(5) NOT NULL,
    div_desc character varying(30),
    restrict_stk_grp_division character varying(1)
);



--
-- Name: st04s_grp_sec; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st04s_grp_sec (
    grp_section character varying(25) NOT NULL,
    descr character varying(25),
    div_code character varying(8)
);



--
-- Name: st04sg_sub_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st04sg_sub_grp (
    stk_grp character varying(5) NOT NULL,
    grp_desc character varying(30)
);



--
-- Name: st05_pack_code; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st05_pack_code (
    pack_code character varying(4) NOT NULL
);



--
-- Name: st06_stk_prices; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06_stk_prices (
    stk_code character varying(16) NOT NULL,
    uom_code character varying(5) NOT NULL,
    uom_factor numeric(16,3) NOT NULL,
    uom character varying(15),
    loc character varying(3) NOT NULL,
    cur_gp_class character varying(1),
    cur_date date,
    cur_duty_tariff_code character varying(16),
    cur_clearing_agent_code character varying(8),
    cur_levy_code character varying(6),
    cur_import_currency character varying(10),
    cur_exchange_rate numeric(14,4),
    cur_supplier_cost_forex numeric(15,5),
    cur_cost_excl_duty_local numeric(13,2),
    cur_duty_perc numeric(7,2),
    cur_duty_cost_local numeric(13,2),
    cur_clearing_cost_perc numeric(7,2),
    cur_clearing_cost_local numeric(13,2),
    cur_levy_cost_local numeric(13,2),
    cur_std_cost numeric(13,2),
    cur_supplier_cost numeric(13,2),
    cur_incl_rebate numeric(13,2),
    cur_replace_cost numeric(13,2),
    cur_list_excl numeric(13,2),
    cur_list_incl numeric(13,2),
    cur_price_calc character varying(1),
    cur_list_gp_perc numeric(7,2),
    cur_list_1_excl numeric(13,2),
    cur_list_1_incl numeric(13,2),
    cur_disc_perc_1 numeric(7,2),
    cur_disc_gp_perc_1 numeric(7,2),
    cur_list_2_excl numeric(13,2),
    cur_list_2_incl numeric(13,2),
    cur_disc_perc_2 numeric(7,2),
    cur_disc_gp_perc_2 numeric(7,2),
    cur_list_3_excl numeric(13,2),
    cur_list_3_incl numeric(13,2),
    cur_disc_perc_3 numeric(7,2),
    cur_disc_gp_perc_3 numeric(7,2),
    cur_list_4_excl numeric(13,2),
    cur_list_4_incl numeric(13,2),
    cur_disc_perc_4 numeric(7,2),
    cur_disc_gp_perc_4 numeric(7,2),
    cur_list_5_excl numeric(13,2),
    cur_list_5_incl numeric(13,2),
    cur_disc_perc_5 numeric(7,2),
    cur_disc_gp_perc_5 numeric(7,2),
    cur_list_6_excl numeric(13,2),
    cur_list_6_incl numeric(13,2),
    cur_disc_perc_6 numeric(7,2),
    cur_disc_gp_perc_6 numeric(7,2),
    cur_list_7_excl numeric(13,2),
    cur_list_7_incl numeric(13,2),
    cur_disc_perc_7 numeric(7,2),
    cur_disc_gp_perc_7 numeric(7,2),
    cur_list_8_excl numeric(13,2),
    cur_list_8_incl numeric(13,2),
    cur_disc_perc_8 numeric(7,2),
    cur_disc_gp_perc_8 numeric(7,2),
    fut_date date,
    fut_user character varying(10),
    fut_duty_tariff_code character varying(16),
    fut_clearing_agent_code character varying(8),
    fut_levy_code character varying(6),
    fut_import_currency character varying(10),
    fut_exchange_rate numeric(14,4),
    fut_supplier_cost_forex numeric(15,5),
    fut_cost_excl_duty_local numeric(13,2),
    fut_duty_perc numeric(7,2),
    fut_duty_cost_local numeric(13,2),
    fut_clearing_cost_perc numeric(7,2),
    fut_clearing_cost_local numeric(13,2),
    fut_levy_cost_local numeric(13,2),
    fut_std_cost numeric(13,2),
    fut_supplier_cost numeric(13,2),
    fut_incl_rebate numeric(13,2),
    fut_replace_cost numeric(13,2),
    fut_list_excl numeric(13,2),
    fut_list_incl numeric(13,2),
    fut_price_calc character varying(1),
    fut_list_gp_perc numeric(7,2),
    fut_list_1_excl numeric(13,2),
    fut_list_1_incl numeric(13,2),
    fut_disc_perc_1 numeric(7,2),
    fut_disc_gp_perc_1 numeric(7,2),
    fut_list_2_excl numeric(13,2),
    fut_list_2_incl numeric(13,2),
    fut_disc_perc_2 numeric(7,2),
    fut_disc_gp_perc_2 numeric(7,2),
    fut_list_3_excl numeric(13,2),
    fut_list_3_incl numeric(13,2),
    fut_disc_perc_3 numeric(7,2),
    fut_disc_gp_perc_3 numeric(7,2),
    fut_list_4_excl numeric(13,2),
    fut_list_4_incl numeric(13,2),
    fut_disc_perc_4 numeric(7,2),
    fut_disc_gp_perc_4 numeric(7,2),
    fut_list_5_excl numeric(13,2),
    fut_list_5_incl numeric(13,2),
    fut_disc_perc_5 numeric(7,2),
    fut_disc_gp_perc_5 numeric(7,2),
    fut_list_6_excl numeric(13,2),
    fut_list_6_incl numeric(13,2),
    fut_disc_perc_6 numeric(7,2),
    fut_disc_gp_perc_6 numeric(7,2),
    fut_list_7_excl numeric(13,2),
    fut_list_7_incl numeric(13,2),
    fut_disc_perc_7 numeric(7,2),
    fut_disc_gp_perc_7 numeric(7,2),
    fut_list_8_excl numeric(13,2),
    fut_list_8_incl numeric(13,2),
    fut_disc_perc_8 numeric(7,2),
    fut_disc_gp_perc_8 numeric(7,2)
);



--
-- Name: st06c_default_cl; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06c_default_cl (
    stk_code character varying(16) NOT NULL,
    cl_code character varying(8),
    cl_stk_code character varying(20),
    cl_stk_desc character varying(100),
    cl_stk_barcode character varying(20),
    manuf_name character varying(20),
    manuf_stk_code character varying(20),
    manuf_stk_desc character varying(100),
    manuf_barcode character varying(20)
);



--
-- Name: st06cp_comp_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06cp_comp_dt (
    row_id integer DEFAULT 0 NOT NULL,
    comp_code character varying(8) NOT NULL,
    prod_code character varying(16),
    prod_name character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    comp_price numeric(13,2) DEFAULT 0,
    comp_price_ref character varying(50)
);



--
-- Name: st06cp_comp_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06cp_comp_hd (
    comp_code character varying(8) NOT NULL,
    comp_name character varying(40),
    status character varying(1),
    loc character varying(3),
    address_1 character varying(30),
    address_2 character varying(30),
    create_date date,
    create_time time(0) without time zone,
    create_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    amend_by character varying(10)
);



--
-- Name: st06f_price_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06f_price_hd (
    batch_no integer NOT NULL,
    status character varying(1),
    batch_desc character varying(30),
    st06t_row_id integer,
    indiv_code character varying(1),
    import_items character varying(1),
    loc_selection character varying(500),
    select_by character varying(2),
    select_range_indiv character varying(1),
    start_select character varying(16),
    end_select character varying(16),
    indiv_select character varying(255),
    auto_price character varying(1),
    class_a_fil character varying(1),
    class_b_fil character varying(1),
    class_c_fil character varying(1),
    class_m_fil character varying(1),
    update_type character varying(1),
    dayend_update_date date,
    create_by character varying(11),
    create_time time(0) without time zone,
    create_date date,
    update_by character varying(11),
    update_time time(0) without time zone,
    update_date date,
    last_st06fd_row_id integer
);



--
-- Name: st06fd_price_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06fd_price_dt (
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    stk_code character varying(16),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    loc character varying(3),
    fut_gp_class character varying(1),
    fut_duty_tariff_code character varying(16),
    fut_clearing_agent_code character varying(8),
    fut_levy_code character varying(6),
    fut_import_currency character varying(10),
    fut_exchange_rate numeric(14,4),
    fut_supplier_cost_forex numeric(15,5),
    fut_cost_excl_duty_local numeric(13,2),
    fut_duty_perc numeric(7,2),
    fut_duty_cost_local numeric(13,2),
    fut_clearing_cost_perc numeric(7,2),
    fut_clearing_cost_local numeric(13,2),
    fut_levy_cost_local numeric(13,2),
    fut_std_cost numeric(13,2),
    fut_supplier_cost numeric(13,2),
    fut_incl_rebate numeric(13,2),
    fut_replace_cost numeric(13,2),
    fut_list_excl numeric(13,2),
    fut_list_incl numeric(13,2),
    fut_price_calc character varying(1),
    fut_list_gp_perc numeric(7,2),
    fut_list_1_excl numeric(13,2),
    fut_list_1_incl numeric(13,2),
    fut_disc_perc_1 numeric(7,2),
    fut_disc_gp_perc_1 numeric(7,2),
    fut_list_2_excl numeric(13,2),
    fut_list_2_incl numeric(13,2),
    fut_disc_perc_2 numeric(7,2),
    fut_disc_gp_perc_2 numeric(7,2),
    fut_list_3_excl numeric(13,2),
    fut_list_3_incl numeric(13,2),
    fut_disc_perc_3 numeric(7,2),
    fut_disc_gp_perc_3 numeric(7,2),
    fut_list_4_excl numeric(13,2),
    fut_list_4_incl numeric(13,2),
    fut_disc_perc_4 numeric(7,2),
    fut_disc_gp_perc_4 numeric(7,2),
    fut_list_5_excl numeric(13,2),
    fut_list_5_incl numeric(13,2),
    fut_disc_perc_5 numeric(7,2),
    fut_disc_gp_perc_5 numeric(7,2),
    fut_list_6_excl numeric(13,2),
    fut_list_6_incl numeric(13,2),
    fut_disc_perc_6 numeric(7,2),
    fut_disc_gp_perc_6 numeric(7,2),
    fut_list_7_excl numeric(13,2),
    fut_list_7_incl numeric(13,2),
    fut_disc_perc_7 numeric(7,2),
    fut_disc_gp_perc_7 numeric(7,2),
    fut_list_8_excl numeric(13,2),
    fut_list_8_incl numeric(13,2),
    fut_disc_perc_8 numeric(7,2),
    fut_disc_gp_perc_8 numeric(7,2),
    comment character varying(255),
    approved_by character varying(10),
    approved_value numeric(13,2)
);



--
-- Name: st06s_alternate_cl; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06s_alternate_cl (
    stk_code character varying(16) NOT NULL,
    cl_code character varying(8) NOT NULL,
    cl_name character varying(100),
    cl_tel_no character varying(22),
    cl_stk_code character varying(20),
    cl_stk_desc character varying(100),
    cl_stk_barcode character varying(20)
);



--
-- Name: st06t_price_templates; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st06t_price_templates (
    row_id integer NOT NULL,
    status character varying(1),
    temp_desc character varying(30),
    indiv_code character varying(1),
    import_items character varying(1),
    loc_selection character varying(500),
    select_by character varying(2),
    select_range_indiv character varying(1),
    start_select character varying(16),
    end_select character varying(16),
    indiv_select character varying(255),
    auto_price character varying(1),
    class_a_fil character varying(1),
    class_b_fil character varying(1),
    class_c_fil character varying(1),
    class_m_fil character varying(1),
    update_type character varying(1),
    stk_desc character varying(1),
    stk_det character varying(1),
    cur_import_det character varying(1),
    cur_supp_cost character varying(1),
    cur_rebate_incl character varying(1),
    cur_replace_cost character varying(1),
    cur_list_excl character varying(1),
    cur_list_incl character varying(1),
    cur_list_gp character varying(1),
    cur_level_excl character varying(1),
    cur_level_incl character varying(1),
    cur_level_per character varying(1),
    cur_level_gp_per character varying(1),
    fut_import_det character varying(1),
    fut_supp_cost character varying(1),
    fut_rebate_incl character varying(1),
    fut_replace_cost character varying(1),
    fut_list_excl character varying(1),
    fut_list_incl character varying(1),
    fut_list_gp character varying(1),
    fut_level_excl character varying(1),
    fut_level_incl character varying(1),
    fut_level_per character varying(1),
    fut_level_gp_per character varying(1)
);



--
-- Name: st07_special_prices_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st07_special_prices_hd (
    special_no character varying(11) NOT NULL,
    special_name character varying(40),
    status character varying(1),
    sort_by_loc character varying(1),
    special_start_date date,
    special_end_date date,
    create_date date,
    create_time time(0) without time zone,
    create_by character varying(10),
    auth_date date,
    auth_time time(0) without time zone,
    auth_by character varying(10),
    by_customer character varying(1),
    multi_ind_customer character varying(1),
    by_product character varying(1),
    price_type character varying(1),
    price_disc_type character varying(12),
    disc_lvl_sel character varying(30),
    disc_lvl_default_perc numeric(11,3),
    last_st08_row_id integer
);



--
-- Name: st07c_cust_selection; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st07c_cust_selection (
    special_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    cust_cat_selection character varying(8)
);



--
-- Name: st07l_stk_locs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st07l_stk_locs (
    special_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3)
);



--
-- Name: st07p_prod_selection; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st07p_prod_selection (
    special_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    grp_selection character varying(5)
);



--
-- Name: st08_special_prices_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st08_special_prices_dt (
    special_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    stk_grp character varying(8),
    stk_code character varying(16),
    uom character varying(15),
    status character varying(1),
    stk_sell_limit numeric(11,3),
    stk_qty_sold numeric(11,3),
    special_price_excl numeric(13,2),
    special_price_incl numeric(13,2),
    special_price_disc numeric(7,2)
);



--
-- Name: st08a_special_price_qty_list; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st08a_special_price_qty_list (
    special_no character varying(11) NOT NULL,
    st08_row_id integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    stk_sell_from numeric(11,3) DEFAULT 0,
    stk_sell_to numeric(11,3) DEFAULT 0,
    special_price_excl numeric(13,2),
    special_price_incl numeric(13,2),
    special_price_disc numeric(7,2)
);



--
-- Name: st09_cpa_idx; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st09_cpa_idx (
    month date NOT NULL,
    copper numeric(13,2) DEFAULT 0,
    lead numeric(13,2) DEFAULT 0,
    alum numeric(13,2) DEFAULT 0,
    pvc numeric(13,2) DEFAULT 0,
    non_hel numeric(13,2) DEFAULT 0,
    xlpe numeric(13,2) DEFAULT 0,
    simag numeric(13,2) DEFAULT 0,
    poly numeric(13,2) DEFAULT 0,
    stape numeric(13,2) DEFAULT 0,
    acsr numeric(13,2) DEFAULT 0,
    swire_090 numeric(13,2) DEFAULT 0,
    swire_125 numeric(13,2) DEFAULT 0,
    swire_160 numeric(13,2) DEFAULT 0,
    swire_200 numeric(13,2) DEFAULT 0,
    swire_250 numeric(13,2) DEFAULT 0,
    swire_315 numeric(13,2) DEFAULT 0,
    swire_355 numeric(13,2) DEFAULT 0,
    labour_cpi numeric(13,2) DEFAULT 0
);



--
-- Name: st10_ctrl_tot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st10_ctrl_tot (
    period date NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    open_bal numeric(13,2) DEFAULT 0,
    sales numeric(13,2) DEFAULT 0,
    cred_note numeric(13,2) DEFAULT 0,
    rec numeric(13,2) DEFAULT 0,
    adj numeric(13,2) DEFAULT 0,
    ibt numeric(13,2) DEFAULT 0,
    woff numeric(13,2) DEFAULT 0,
    stk_adj numeric(13,2) DEFAULT 0,
    reval numeric(13,2) DEFAULT 0,
    reval_mth_end numeric(13,2) DEFAULT 0,
    close_bal numeric(13,2) DEFAULT 0
);



--
-- Name: st12_import_duty_tariff; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st12_import_duty_tariff (
    duty_tariff_code character varying(16) NOT NULL,
    duty_tariff_desc character varying(40),
    duty_perc numeric(7,2) DEFAULT 0
);



--
-- Name: st13_clearing_agent; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st13_clearing_agent (
    clearing_agent_code character varying(8) NOT NULL,
    clearing_cost_perc numeric(7,2) DEFAULT 0
);



--
-- Name: st14_import_levies; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st14_import_levies (
    levy_code character varying(6) NOT NULL,
    levy_desc character varying(40),
    uom character varying(8),
    unit_qty integer,
    levy_cost numeric(13,2) DEFAULT 0
);



--
-- Name: st15_uom_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st15_uom_mast (
    uom character varying(5) NOT NULL,
    treat_as_loose character varying(1)
);



--
-- Name: st17_promo_combo_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st17_promo_combo_hd (
    combo_no character varying(11) NOT NULL,
    combo_name character varying(40),
    status character varying(1),
    stk_sell_limit integer DEFAULT 0,
    sort_by_loc character varying(1),
    combo_start_date date,
    combo_end_date date,
    create_date date,
    create_time time(0) without time zone,
    create_by character varying(10),
    auth_date date,
    auth_time time(0) without time zone,
    auth_by character varying(10),
    by_customer character varying(1),
    multi_ind_customer character varying(1),
    by_product character varying(1),
    price_type character varying(1),
    price_disc_type character varying(12),
    combo_price_excl numeric(13,2),
    combo_price_incl numeric(13,2),
    disc_lvl_sel character varying(30),
    disc_lvl_default_perc character varying(11),
    last_st18_row_id integer DEFAULT 0
);



--
-- Name: st17c_cust_selection; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st17c_cust_selection (
    promo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    cust_cat_selection character varying(8)
);



--
-- Name: st17l_stk_locs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st17l_stk_locs (
    promo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3)
);



--
-- Name: st17p_prod_selection; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st17p_prod_selection (
    promo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0,
    grp_selection character varying(5)
);



--
-- Name: st18_promo_triggers; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st18_promo_triggers (
    combo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    stk_code character varying(16) NOT NULL,
    uom character varying(15),
    qty_to_buy integer DEFAULT 0,
    combo_price_excl numeric(13,2),
    combo_price_incl numeric(13,2),
    combo_price_disc numeric(7,2)
);



--
-- Name: st19_promo_rewards; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st19_promo_rewards (
    combo_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    stk_code character varying(16),
    uom character varying(15),
    qty_free integer DEFAULT 0
);



--
-- Name: st20_adj_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st20_adj_bt (
    period date NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3),
    whs character varying(3),
    tran_type character varying(4),
    prt_ind character varying(1) DEFAULT 'N'::character varying,
    stk_code character varying(16),
    descr character varying(40),
    ref_1 character varying(40),
    ref_2 character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    qty numeric(11,3) DEFAULT 0,
    cost numeric(13,2) DEFAULT 0,
    gross numeric(13,2) DEFAULT 0,
    new_cost numeric(13,2) DEFAULT 0,
    new_gross numeric(13,2) DEFAULT 0,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_qty numeric(11,3),
    base_cost numeric(13,2),
    base_gross numeric(13,2),
    reason_code character varying(8),
    gl12_type character varying(8),
    gl_code character varying(8),
    st30_row_id integer DEFAULT 0,
    last_st20s_row_id integer DEFAULT 0,
    last_st20b_row_id integer DEFAULT 0
);



--
-- Name: st20b_adj_bom; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st20b_adj_bom (
    period date NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    bom_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    stk_code character varying(16),
    bom_qty numeric(11,3) DEFAULT 0,
    cost numeric(13,2) DEFAULT 0
);



--
-- Name: st20i_bin_alloc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st20i_bin_alloc (
    period date NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    stk_code character varying(16),
    serial_no character varying(25),
    pack_code character varying(4),
    expiry_date date,
    bin_no character varying(16),
    bin_type character varying(1),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    bin_qty numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3)
);



--
-- Name: st20s_adj_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st20s_adj_serial (
    period date NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    serial_row_id integer NOT NULL,
    sort_pos integer,
    serial_no character varying(25),
    org_serial_no character varying(25),
    pack_code character varying(4),
    serial_qty numeric(11,3),
    expiry_date date,
    is_new_code character varying(1)
);



--
-- Name: st21_bin_transfer_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st21_bin_transfer_bt (
    period date NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3),
    whs character varying(3),
    tran_type character varying(4),
    stk_code character varying(16),
    serial_no character varying(25) DEFAULT '0'::character varying,
    descr character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    qty numeric(11,3) DEFAULT 0,
    scanned_out_qty numeric(11,3) DEFAULT 0,
    scanned_in_qty numeric(11,3) DEFAULT 0,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_qty numeric(11,3),
    from_bin character varying(16),
    to_bin character varying(16),
    st30i_row_id integer
);



--
-- Name: st21b_uom_break_build; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st21b_uom_break_build (
    batch_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3),
    type character varying(2),
    stk_code character varying(16),
    bin_no character varying(16),
    bin_type character varying(1),
    serial_no character varying(25),
    expiry_date date,
    descr character varying(40),
    ref_1 character varying(40),
    ref_2 character varying(40),
    from_uom_code character varying(5),
    from_uom_factor numeric(16,3) DEFAULT 0,
    from_uom character varying(15),
    from_qty numeric(13,2) DEFAULT 0,
    to_uom_code character varying(5),
    to_uom_factor numeric(16,3) DEFAULT 0,
    to_uom character varying(15),
    to_qty numeric(13,2)
);



--
-- Name: st22_replen_bt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st22_replen_bt (
    batch_no integer NOT NULL,
    status character varying(1),
    batch_desc character varying(30),
    st22t_row_id integer,
    started_by character varying(10),
    date_started date,
    target_date date,
    multi_co_batch character varying(1),
    grn_no character varying(11),
    dc_batch character varying(1),
    loc_select_by character varying(2) DEFAULT 'I'::character varying,
    start_loc character varying(3),
    end_loc character varying(3),
    loc character varying(500),
    whs character varying(500),
    grp_select_by character varying(2),
    select_grp_range_indiv character varying(1),
    stk_grps character varying(100),
    start_grp character varying(5),
    end_grp character varying(5),
    weeks_warn integer DEFAULT 0,
    sales_term character varying(1) DEFAULT 'P'::character varying,
    sales_duration character varying(1) DEFAULT 'M'::character varying,
    sales_mths integer DEFAULT 0,
    sales_start_date date,
    sales_end_date date,
    perc_of_ave_sales numeric(7,2) DEFAULT 0,
    drop_high_low character varying(1) DEFAULT 'N'::character varying,
    sales_freq character varying(25),
    tdh integer DEFAULT 0,
    lead_duration character varying(1) DEFAULT 'W'::character varying,
    ltm numeric(5,2) DEFAULT 0,
    orders_within_ltm character varying(1),
    osbm numeric(2,1) DEFAULT 0,
    incl_proj_so character varying(1) DEFAULT 'A'::character varying,
    incl_proj_wo character varying(1) DEFAULT 'A'::character varying,
    gened_by character varying(10),
    gened_date date,
    last_st23_row_id integer DEFAULT 0
);



--
-- Name: st22g_grps; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st22g_grps (
    batch_no integer NOT NULL,
    stk_grp character varying(5) NOT NULL
);



--
-- Name: st22m_companies; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st22m_companies (
    batch_no integer NOT NULL,
    company character varying(20) NOT NULL,
    company_name character varying(40)
);



--
-- Name: st22s_supplier; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st22s_supplier (
    batch_no character varying(10) NOT NULL,
    cl_code character varying(8) NOT NULL
);



--
-- Name: st23_replen_items; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23_replen_items (
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    row_id integer NOT NULL,
    company character varying(20),
    master_row_id integer,
    loc_db character varying(20),
    dc_loc character varying(1),
    loc_name character varying(30),
    replen_status character varying(1),
    below_min_lvl character varying(1),
    line_type character varying(1),
    stk_desc_1 character varying(40),
    stk_desc_2 character varying(40),
    ibt_uom_code character varying(5),
    ibt_uom_factor numeric(16,3),
    ibt_uom character varying(15),
    po_uom_code character varying(5),
    po_uom_factor numeric(16,3),
    po_uom character varying(15),
    phy_bal numeric(11,0),
    out_po numeric(11,0),
    out_so numeric(11,0),
    out_req numeric(11,0),
    proj_bal numeric(11,0),
    pbt_qty numeric(11,0),
    ams_qty numeric(11,0),
    tdh_qty numeric(11,0),
    lt_mths numeric(3,1),
    lt_qty numeric(11,0),
    short_qty numeric(11,0),
    short_reorder_qty numeric(11,0),
    reorder_type character varying(1),
    min_qty integer,
    max_qty integer,
    osb_qty numeric(11,0),
    grn_qty numeric(11,0),
    ibt_qty numeric(11,0),
    ibt_send_loc character varying(3),
    ibt_loc_db character varying(20),
    ibt_no character varying(11),
    tot_ord_qty numeric(11,0),
    ord_qty numeric(11,0),
    ord_loc character varying(3),
    ord_loc_db character varying(20),
    ic_type character varying(3),
    ic_ord_qty numeric(11,0),
    dc_bal numeric(11,0),
    ic_po_no character varying(11),
    ic_so_no character varying(11),
    po_per_split_date character varying(1),
    po_no character varying(11),
    po_confirm_req_by character varying(10),
    po_confirm_req_date date,
    po_confirm_req_time time(0) without time zone,
    po_confirmed character varying(1),
    po_confirmed_qty numeric(11,3),
    po_confirmed_by character varying(10),
    po_confirmed_date date,
    po_confirmed_time time(0) without time zone,
    cl_code character varying(8),
    import_order character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4),
    input_currency character varying(1),
    unit_price numeric(11,2),
    unit_price_forex numeric(13,5),
    disc numeric(7,2),
    net_price numeric(11,2),
    net_price_forex numeric(13,5),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_ibt_qty numeric(11,3),
    base_tot_ord_qty numeric(11,3),
    base_ord_qty numeric(11,3),
    base_ic_ord_qty numeric(11,3),
    base_unit_price numeric(13,2),
    base_unit_price_forex numeric(13,5),
    base_net_price numeric(13,2),
    base_net_price_forex numeric(13,5),
    split_date character varying(1),
    del_date_1 date,
    del_qty_1 numeric(11,0),
    del_date_2 date,
    del_qty_2 numeric(11,0),
    del_date_3 date,
    del_qty_3 numeric(11,0),
    del_date_4 date,
    del_qty_4 numeric(13,2),
    del_date_5 date,
    del_qty_5 numeric(13,2),
    del_date_6 date,
    del_qty_6 numeric(13,2)
);



--
-- Name: st23fore_close_bal; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23fore_close_bal (
    batch_no integer DEFAULT 0 NOT NULL,
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    st23_row_id integer DEFAULT 0 NOT NULL,
    month date NOT NULL,
    po_due numeric(11,3) DEFAULT 0,
    so_due numeric(11,3) DEFAULT 0,
    ibt_due numeric(11,3) DEFAULT 0
);



--
-- Name: st23grn_replen_grn_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23grn_replen_grn_hd (
    batch_no integer NOT NULL,
    grn_db character varying(20) NOT NULL,
    grn_no character varying(11) NOT NULL
);



--
-- Name: st23ib_replen_req_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23ib_replen_req_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    req_loc character varying(3) NOT NULL,
    send_loc character varying(3) NOT NULL,
    ibt_db character varying(20),
    ibt_no character varying(11)
);



--
-- Name: st23in_replen_inv_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23in_replen_inv_hd (
    batch_no integer NOT NULL,
    inv_db character varying(20) NOT NULL,
    inv_no character varying(11) NOT NULL
);



--
-- Name: st23inter_po_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23inter_po_hd (
    batch_no integer NOT NULL,
    po_db character varying(20) NOT NULL,
    po_no character varying(11) NOT NULL,
    primary_po_no character varying(11)
);



--
-- Name: st23l_replen_co_links; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23l_replen_co_links (
    slave_db character varying(20) NOT NULL,
    master_db character varying(20),
    master_dl_code character varying(8),
    slave_cl_code character varying(8)
);



--
-- Name: st23po_replen_po_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23po_replen_po_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    cl_code character varying(8) NOT NULL,
    cl_name character varying(40),
    po_db character varying(20),
    po_per_split_date character varying(1),
    po_loc character varying(3),
    po_no character varying(11),
    import_order character varying(1),
    multi_currency character varying(1),
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    input_currency character varying(1),
    del_to_1 character varying(30),
    del_to_2 character varying(30),
    del_to_3 character varying(30),
    del_to_4 character varying(30),
    cred_ref character varying(20),
    split_del_qty character varying(1),
    due_date date,
    remarks character varying(50),
    notes character varying(490),
    ord_value numeric(13,2) DEFAULT 0,
    ord_value_forex numeric(13,5) DEFAULT 0
);



--
-- Name: st23posub_replen_split; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23posub_replen_split (
    batch_no integer DEFAULT 0 NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    cl_code character varying(8) NOT NULL,
    po_no character varying(11) NOT NULL,
    ord_value numeric(13,2) DEFAULT 0,
    ord_value_forex numeric(13,5) DEFAULT 0
);



--
-- Name: st23s_serial_allocation; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23s_serial_allocation (
    batch_no integer DEFAULT 0 NOT NULL,
    st23_row_id integer DEFAULT 0 NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    serial_no character varying(25),
    allocated_qty integer DEFAULT 0
);



--
-- Name: st23so_replen_so_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23so_replen_so_hd (
    batch_no integer NOT NULL,
    so_db character varying(20) NOT NULL,
    so_no character varying(11) NOT NULL,
    po_no character varying(11)
);



--
-- Name: st23sub_replen_split; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st23sub_replen_split (
    batch_no integer DEFAULT 0 NOT NULL,
    stk_code character varying(16) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    po_no character varying(11) NOT NULL,
    ic_po_no character varying(11),
    ic_so_no character varying(11),
    ord_qty numeric(11,0) DEFAULT 0
);



--
-- Name: st24_orders; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st24_orders (
    batch_no integer DEFAULT 0 NOT NULL,
    status character varying(1) NOT NULL,
    so_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    batch_source character varying(20),
    sa23_row_id integer DEFAULT 0,
    stk_code character varying(16),
    due_qty numeric(11,3)
);



--
-- Name: st25_stk_take_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st25_stk_take_hd (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    status character varying(1) NOT NULL,
    stk_take_type character varying(1),
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    set_by character varying(10),
    start_bin character varying(10),
    end_bin character varying(10),
    update_bins character varying(1),
    set_to_phy character varying(1),
    excl_ibt character varying(1),
    excl_serial character varying(1),
    freeze_phy_bal character varying(1),
    max_var_allowed numeric(13,2) DEFAULT 0,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone,
    last_st26_and_st26s_row_id integer DEFAULT 0
);



--
-- Name: st25f_filters; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st25f_filters (
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT ''::character varying NOT NULL,
    status character varying(1) NOT NULL,
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    item_code character varying(25) NOT NULL
);



--
-- Name: st25g_grp_exclusions; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st25g_grp_exclusions (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    status character varying(1) NOT NULL,
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    stk_grp character varying(5) NOT NULL
);



--
-- Name: st26_stk_take_imp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st26_stk_take_imp (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    stk_code character varying(16) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    status character varying(1) NOT NULL,
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    batch_no integer DEFAULT 0,
    import_by character varying(10),
    ref character varying(20),
    imported_date date,
    imported_time time(0) without time zone,
    replace_add character varying(1),
    qty numeric(11,3) DEFAULT 0,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone,
    stk_take_open_bal numeric(11,3) DEFAULT 0,
    stk_take_close_bal numeric(11,3) DEFAULT 0
);



--
-- Name: st26i_stk_take_imp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st26i_stk_take_imp (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    st26_row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    status character varying(1) NOT NULL,
    stk_code character varying(16) NOT NULL,
    descr character varying(30),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_cnt numeric(11,3),
    capture_type character varying(1),
    import_by character varying(10),
    import_date date,
    import_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone
);



--
-- Name: st26s_stk_take_imp_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st26s_stk_take_imp_serial (
    loc character varying(4) NOT NULL,
    whs character varying(3) NOT NULL,
    anal_type integer DEFAULT 0 NOT NULL,
    serial_no character varying(25) NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    status character varying(1) NOT NULL,
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    batch_no integer DEFAULT 0,
    pack character varying(4),
    loc_serial_in character varying(4),
    stk_code character varying(16),
    descr character varying(35),
    qty_scanned numeric(11,3) DEFAULT 0,
    capture_type character varying(1),
    import_by character varying(10),
    imported_date date,
    imported_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone,
    stk_take_open_bal numeric(11,3) DEFAULT 0,
    stk_take_close_bal numeric(11,3) DEFAULT 0
);



--
-- Name: st27_random_batch_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st27_random_batch_hd (
    batch_no integer DEFAULT 0 NOT NULL,
    batch_desc character varying(40),
    batch_type character varying(1),
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    period date,
    status character varying(1),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    updated_by character varying(10),
    updated_date date,
    updated_time time(0) without time zone
);



--
-- Name: st27d_random_batch_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st27d_random_batch_dt (
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    uom_code character varying(5) NOT NULL,
    uom_factor numeric(16,3) NOT NULL,
    uom character varying(15),
    sort_pos integer DEFAULT 0,
    multiple_item_count character varying(1) DEFAULT 'N'::character varying,
    stk_grp character varying(5),
    computer_qty numeric(11,3) DEFAULT 0,
    count_qty numeric(11,3) DEFAULT 0,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3) DEFAULT 0,
    base_uom character varying(15),
    base_computer_qty numeric(11,3) DEFAULT 0,
    base_count_qty numeric(11,3) DEFAULT 0,
    recount character varying(1),
    completed character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: st27i_random_bins; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st27i_random_bins (
    batch_no integer NOT NULL,
    bin_type character varying(1),
    stk_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    bin_no character varying(16) NOT NULL,
    uom_code character varying(5) NOT NULL,
    uom_factor numeric(16,3) NOT NULL,
    uom character varying(15),
    bin_qty numeric(11,3),
    bin_cnt numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3),
    base_bin_cnt numeric(11,3)
);



--
-- Name: st27s_random_batch_serials; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st27s_random_batch_serials (
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    uom_code character varying(5) NOT NULL,
    uom_factor numeric(16,3) NOT NULL,
    computer_qty numeric(11,3),
    count_qty numeric(11,3)
);



--
-- Name: st28_stk_take_process; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st28_stk_take_process (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    div_code character varying(5) NOT NULL,
    status character varying(1) NOT NULL,
    set_date date NOT NULL,
    set_time time(0) without time zone NOT NULL,
    excp_by character varying(10),
    excp_date date,
    excp_time time(0) without time zone,
    excp_rating integer DEFAULT 0,
    excp_report_no integer DEFAULT 0,
    serial_convert_by character varying(10),
    serial_convert_date date,
    serial_convert_time time(0) without time zone,
    serial_convert_rating integer DEFAULT 0,
    bin_by character varying(10),
    bin_date date,
    bin_time time(0) without time zone,
    bin_rating integer,
    bin_report_no integer,
    ins_by character varying(10),
    ins_date date,
    ins_time time(0) without time zone,
    ins_rating integer DEFAULT 0,
    ins_report_no integer DEFAULT 0,
    first_var_by character varying(10),
    first_var_date date,
    first_var_time time(0) without time zone,
    first_var_rating integer DEFAULT 0,
    first_var_report_no integer DEFAULT 0,
    auth_by character varying(10),
    auth_date date,
    auth_time time(0) without time zone,
    final_var_by character varying(20),
    final_var_date date,
    final_var_time time(0) without time zone,
    final_var_rating integer DEFAULT 0,
    final_var_report_no integer DEFAULT 0,
    comment text
);



--
-- Name: st29_man_pull_pack_bin; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st29_man_pull_pack_bin (
    period date NOT NULL,
    batch_no integer NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3),
    whs character varying(3),
    doc_no character varying(11),
    source character varying(4),
    stk_code character varying(16),
    descr character varying(40),
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3)
);



--
-- Name: st30_stk_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st30_stk_tran (
    stk_code character varying(16) NOT NULL,
    row_id integer NOT NULL,
    loc character varying(3),
    whs character varying(3),
    period date,
    gl_code character varying(8),
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    create_by character varying(10),
    batch_no integer,
    ref_1 character varying(20),
    ref_2 character varying(20),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    qty numeric(11,3),
    unit_price numeric(13,2),
    unit_price_incl numeric(13,2),
    unit_cost numeric(13,2),
    wo_cost numeric(13,2),
    unit_cost_forex numeric(13,5),
    base_uom_code character varying(15),
    base_uom_factor character varying(15),
    base_uom character varying(15),
    base_qty numeric(11,3) DEFAULT 0,
    base_unit_price numeric(13,2) DEFAULT 0,
    base_unit_price_incl numeric(13,2) DEFAULT 0,
    base_unit_cost numeric(13,2) DEFAULT 0,
    base_unit_cost_forex numeric(13,5) DEFAULT 0,
    forex_currency character varying(10),
    forex_exch_rate numeric(13,4) DEFAULT 0,
    phy_bal numeric(13,2) DEFAULT 0,
    special_price numeric(13,2) DEFAULT 0,
    retail_sale character varying(1)
);



--
-- Name: st30i_internal_trans; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st30i_internal_trans (
    stk_code character varying(16) NOT NULL,
    st30_row_id integer NOT NULL,
    row_id integer NOT NULL,
    bin_no character varying(16),
    serial_no character varying(25),
    loc character varying(3),
    whs character varying(3),
    period date,
    tran_type character varying(3),
    tran_date date,
    tran_time time(0) without time zone,
    create_by character varying(10),
    batch_no integer,
    ref_1 character varying(20),
    ref_2 character varying(20),
    uom_code character varying(5),
    uom_factor numeric(16,3) DEFAULT 0,
    uom character varying(10),
    qty numeric(11,3) DEFAULT 0,
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3) DEFAULT 0,
    base_uom character varying(15),
    base_qty numeric(11,3) DEFAULT 0,
    phy_bal numeric(13,2) DEFAULT 0
);



--
-- Name: st30s_serial_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st30s_serial_tran (
    stk_code character varying(16) NOT NULL,
    st30_row_id integer DEFAULT 0 NOT NULL,
    serial_no character varying(25) NOT NULL,
    serial_row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3),
    whs character varying(3) DEFAULT '00'::character varying,
    qty numeric(11,3) DEFAULT 0
);



--
-- Name: st33_price_chg; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st33_price_chg (
    stk_code character varying(16) NOT NULL,
    price_chg_row_id integer NOT NULL,
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    loc character varying(3),
    chg_by character varying(10),
    chg_date date,
    chg_time time(0) without time zone,
    printed character varying(1),
    method character varying(15),
    batch_no integer,
    old_class character varying(1),
    last_po_cost numeric(13,2),
    old_price numeric(13,2),
    old_price_incl numeric(13,2),
    old_cost numeric(13,2),
    old_replace numeric(13,2),
    old_disc_1_excl numeric(13,2),
    old_disc_1_incl numeric(13,2),
    old_disc_2_excl numeric(13,2),
    old_disc_2_incl numeric(13,2),
    old_disc_3_excl numeric(13,2),
    old_disc_3_incl numeric(13,2),
    old_disc_4_excl numeric(13,2),
    old_disc_4_incl numeric(13,2),
    old_disc_5_excl numeric(13,2),
    old_disc_5_incl numeric(13,2),
    old_disc_6_excl numeric(13,2),
    old_disc_6_incl numeric(13,2),
    old_disc_7_excl numeric(13,2),
    old_disc_7_incl numeric(13,2),
    old_disc_8_excl numeric(13,2),
    old_disc_8_incl numeric(13,2),
    new_class character varying(1),
    new_price numeric(13,2),
    new_price_incl numeric(13,2),
    new_cost numeric(13,2),
    new_replace numeric(13,2),
    new_disc_1_excl numeric(13,2),
    new_disc_1_incl numeric(13,2),
    new_disc_2_excl numeric(13,2),
    new_disc_2_incl numeric(13,2),
    new_disc_3_excl numeric(13,2),
    new_disc_3_incl numeric(13,2),
    new_disc_4_excl numeric(13,2),
    new_disc_4_incl numeric(13,2),
    new_disc_5_excl numeric(13,2),
    new_disc_5_incl numeric(13,2),
    new_disc_6_excl numeric(13,2),
    new_disc_6_incl numeric(13,2),
    new_disc_7_excl numeric(13,2),
    new_disc_7_incl numeric(13,2),
    new_disc_8_excl numeric(13,2),
    new_disc_8_incl numeric(13,2)
);



--
-- Name: st33p_price_chg_labels; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st33p_price_chg_labels (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    stk_code character varying(16) NOT NULL,
    price_chg_row_id integer NOT NULL,
    printed character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: st34_arb_wms_fail_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st34_arb_wms_fail_log (
    log_id integer DEFAULT 0 NOT NULL,
    status character varying(1),
    log_date date,
    log_time time(0) without time zone,
    interface_source character varying(1),
    batch_no integer,
    batch_type character varying(1),
    doc_type character varying(4),
    fail_point character varying(25),
    doc_no character varying(11),
    issue_subject character varying(100),
    issue_desc character varying(255),
    assigned_to character varying(10),
    notes character varying(1275),
    complete_by character varying(10),
    complete_date date,
    complete_time time(0) without time zone,
    file_url character varying(255)
);



--
-- Name: st35_whs_dis_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st35_whs_dis_hd (
    batch_no integer NOT NULL,
    status character varying(1),
    doc_type character varying(4),
    doc_selection character varying(1),
    loc character varying(3),
    whs character varying(3),
    send_loc character varying(3),
    rec_loc character varying(3),
    acct_code character varying(8),
    acct_name character varying(40),
    del_date date,
    del_time time(0) without time zone,
    del_by character varying(15),
    po_no character varying(11),
    supplier_del_no character varying(20),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    gen_by character varying(10),
    gen_date date,
    gen_time time(0) without time zone,
    ic_batch character varying(1),
    linked_to_ic_batch_no integer,
    stk_co_db character varying(20),
    sell_co_db character varying(20),
    notes character varying(255)
);



--
-- Name: st36_whs_dis_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st36_whs_dis_dt (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_no_gen character varying(11),
    stage_ship_doc integer NOT NULL,
    doc_row_id integer NOT NULL,
    sort_pos integer,
    prt_ind character varying(1),
    prod_code character varying(16),
    descr character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    due_qty numeric(11,3),
    dis_qty numeric(11,3),
    dis_qty_now numeric(11,3),
    dis_qty_gen numeric(11,3),
    dis_qty_gen_now numeric(11,3),
    dir_grv_unit_cost numeric(13,2),
    dir_grv_disc numeric(7,2),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_due_qty numeric(11,3),
    base_dis_qty numeric(11,3),
    base_dis_qty_now numeric(11,3),
    base_dis_qty_gen numeric(11,3),
    base_dis_qty_gen_now numeric(11,3)
);



--
-- Name: st36i_whs_dis_bin; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st36i_whs_dis_bin (
    batch_no integer DEFAULT 0 NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_no_gen character varying(11),
    stage_ship_doc integer DEFAULT 0 NOT NULL,
    doc_row_id integer DEFAULT 0 NOT NULL,
    bin_row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3),
    serial_no character varying(25),
    stk_code character varying(16),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    due_qty numeric(11,3),
    dis_qty_gen_now numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_dis_qty_gen_now numeric(11,3)
);



--
-- Name: st36p_whs_dis_pallets; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st36p_whs_dis_pallets (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    ship_doc_no integer DEFAULT 0 NOT NULL,
    doc_row_id integer NOT NULL,
    wt_container_id character varying(20) NOT NULL,
    wt_pallet_id character varying(20) NOT NULL,
    wt_pallet_qty numeric(11,3)
);



--
-- Name: st36s_whs_dis_serials; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st36s_whs_dis_serials (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_row_id integer NOT NULL,
    serial_row_id integer NOT NULL,
    serial_no character varying(25),
    pack character varying(4),
    due_qty numeric(11,3),
    dis_qty numeric(11,3),
    dis_qty_now numeric(11,3),
    dis_qty_gen numeric(11,3),
    dis_qty_gen_now numeric(11,3),
    container_id character varying(20),
    pallet_id character varying(20)
);



--
-- Name: st37_whs_rec_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st37_whs_rec_hd (
    batch_no integer NOT NULL,
    status character varying(1),
    doc_type character varying(4),
    loc character varying(3),
    whs character varying(3),
    acct_code character varying(8),
    acct_name character varying(40),
    del_date date,
    del_time time(0) without time zone,
    del_by character varying(15),
    del_area character varying(5),
    create_by character varying(11),
    create_date date,
    create_time time(0) without time zone,
    confirmed_by character varying(11),
    confirm_date date,
    confirm_time time(0) without time zone,
    cust_ref character varying(20),
    notes character varying(255)
);



--
-- Name: st38_whs_rec_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st38_whs_rec_dt (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_no_gen character varying(11),
    ship_doc_no integer NOT NULL,
    doc_row_id integer NOT NULL,
    cred_ref character varying(20),
    sort_pos integer,
    prt_ind character varying(1),
    prod_code character varying(16),
    status character varying(1),
    descr character varying(40),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    due_qty numeric(11,3),
    exp_qty numeric(11,3),
    rec_qty_now numeric(11,3),
    res_qty numeric(11,3),
    rec_qty_gen numeric(11,3),
    unit_price numeric(13,2),
    unit_cost numeric(13,2),
    disc numeric(7,2),
    vat_ind character varying(1),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_due_qty numeric(11,3),
    base_exp_qty numeric(11,3),
    base_rec_qty_now numeric(11,3),
    base_res_qty numeric(11,3),
    base_rec_qty_gen numeric(11,3),
    reason_id integer,
    reason_notes character varying(255)
);



--
-- Name: st38d_driver_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st38d_driver_dt (
    batch_no integer NOT NULL,
    doc_no character varying(20) NOT NULL,
    driver_id_no character varying(13) NOT NULL,
    driver_name character varying(20),
    vehicle_reg character varying(10),
    driver_company character varying(20),
    received_by character varying(20),
    received_date date,
    comments character varying(255)
);



--
-- Name: st38i_whs_rec_bin; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st38i_whs_rec_bin (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_no_gen character varying(11),
    stage_ship_doc integer NOT NULL,
    doc_row_id integer NOT NULL,
    bin_row_id integer NOT NULL,
    sort_pos integer,
    bin_no character varying(16),
    bin_type character varying(1),
    bin_qty numeric(11,3),
    bin_qty_to_pull_pack numeric(11,3),
    serial_no character varying(25),
    stk_code character varying(16),
    uom_code character varying(5),
    uom_factor numeric(16,3),
    uom character varying(15),
    due_qty numeric(11,3),
    rec_qty_now numeric(11,3),
    base_uom_code character varying(5),
    base_uom_factor numeric(16,3),
    base_uom character varying(15),
    base_bin_qty numeric(11,3),
    base_due_qty numeric(11,3),
    base_rec_qty_now numeric(13,2)
);



--
-- Name: st38s_whs_rec_serials; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st38s_whs_rec_serials (
    batch_no integer NOT NULL,
    doc_no character varying(11) NOT NULL,
    doc_row_id integer NOT NULL,
    serial_row_id integer NOT NULL,
    serial_no character varying(25),
    cl_serial_no character varying(20),
    expiry_date date,
    pack character varying(4),
    due_qty numeric(11,3),
    exp_qty numeric(11,3),
    rec_qty_now numeric(11,3),
    res_qty numeric(11,3),
    rec_qty_gen numeric(11,3)
);



--
-- Name: st40_track_store_pulling; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st40_track_store_pulling (
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    doc_type character varying(3) NOT NULL,
    doc_no character varying(14) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    dest_name character varying(40),
    dest_add_1 character varying(30),
    dest_add_2 character varying(30),
    dest_add_3 character varying(30),
    dest_add_4 character varying(30),
    instructions character varying(40),
    collect_req_by character varying(10),
    prt_package_labels character varying(1),
    exported character varying(1) DEFAULT 'N'::character varying,
    exported_date date,
    exported_time time(0) without time zone,
    no_of_parcels integer DEFAULT 0,
    priority_lvl integer DEFAULT 0,
    whs_phase_sort integer,
    status character varying(4),
    start_date date,
    start_time time(0) without time zone,
    end_date date,
    end_time time(0) without time zone,
    controller character varying(10),
    action_by character varying(10),
    no_of_items integer DEFAULT 0,
    cut_cbl integer DEFAULT 0,
    trip_sheet integer DEFAULT 0,
    area_code character varying(4),
    route_no character varying(8),
    del_order integer DEFAULT 0
);



--
-- Name: st40p_package_dimensions; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st40p_package_dimensions (
    row_id integer DEFAULT 0 NOT NULL,
    doc_type character varying(3) NOT NULL,
    doc_no character varying(12) NOT NULL,
    package_no integer NOT NULL,
    length_of_package_mm numeric(13,2),
    width_of_package_mm numeric(13,2),
    depth_of_package_mm numeric(13,2),
    weight_of_package_kg numeric(13,2)
);



--
-- Name: st40u_warehouse_user; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st40u_warehouse_user (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    user_name character varying(10) NOT NULL,
    full_name character varying(25),
    whs_phase_user character varying(1),
    type character varying(1),
    user_pin character varying(6),
    force_assign_user character varying(1),
    whs_status character varying(4),
    whs_phase_sort integer,
    functions character varying(100),
    whs_color character varying(50),
    po_hold character varying(1),
    rec_hold character varying(1),
    cd_hold character varying(1),
    putaway character varying(1),
    chg_put_bin character varying(1),
    chg_pick_bin character varying(1),
    ibt_cons character varying(1),
    auto_ship_ibt character varying(1),
    allow_label_prt character varying(1),
    force_dispatch_scan character varying(1),
    serial_allocation character varying(1),
    cross_dock character varying(1),
    cross_dock_only character varying(1),
    trip_plan character varying(1),
    trip_return character varying(1),
    final_phase character varying(1),
    priority_level character varying(16),
    web_confirmation_status character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: st41_area_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st41_area_mast (
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    area_code character varying(3) NOT NULL,
    area_desc character varying(40),
    route_no character varying(8),
    is_loc character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: st42_route_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st42_route_no (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    route_no character varying(8) NOT NULL,
    route_name character varying(25),
    is_loc character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: st43_prt_stk_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st43_prt_stk_hd (
    batch_no integer NOT NULL,
    status character varying(1),
    loc character varying(3),
    whs character varying(3),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone
);



--
-- Name: st44_prt_stk_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.st44_prt_stk_dt (
    batch_no integer NOT NULL,
    stk_code character varying(16) NOT NULL,
    uom character varying(15) NOT NULL,
    qty_to_print integer DEFAULT 0,
    printed character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: sy00_co_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy00_co_mast (
    co_name character varying(45) NOT NULL,
    co_short_name character varying(10),
    co_db_name character varying(20),
    master_or_slave character varying(1),
    master_co_db character varying(20),
    xact_lite character varying(1) DEFAULT 'N'::character varying,
    post_add_1 character varying(25),
    post_add_2 character varying(25),
    post_add_3 character varying(25),
    post_add_4 character varying(25),
    post_add_5 character varying(25),
    phy_add_1 character varying(25),
    phy_add_2 character varying(25),
    phy_add_3 character varying(25),
    phy_add_4 character varying(25),
    area_dialcode_international integer DEFAULT 0,
    area_dialcode_local integer DEFAULT 0,
    tel_no character varying(15),
    fax_no character varying(15),
    system_admin character varying(255),
    days_to_force_pwd_chg integer DEFAULT 0,
    pwd_login_attempts integer DEFAULT 0,
    pwd_history_limit integer DEFAULT 0,
    pwd_alphanum_chk character varying(1),
    pwd_uppercase_chk character varying(1),
    pwd_special_chk character varying(1),
    pwd_min_length integer DEFAULT 0,
    co_email character varying(80),
    co_domain character varying(30),
    co_reg_no character varying(17),
    co_vat_no character varying(12),
    co_bank_eft_code character varying(4),
    year_end_mth integer DEFAULT 0,
    vat_rate numeric(7,2) DEFAULT 0,
    vat_period date,
    new_vat_rate numeric(7,2),
    new_vat_rate_from date,
    new_vat_rate_price_calc character varying(1),
    vat_rate_prior numeric(7,2) DEFAULT 0,
    vat_rate_prior_valid_until date,
    bank_name character varying(20),
    bank_branch_name character varying(20),
    bank_branch_code character varying(20),
    bank_acct_no character varying(35),
    support_server_name character varying(50),
    support_db_name character varying(20),
    support_email character varying(255),
    unique_doc_no character varying(1),
    idle_time integer DEFAULT 0,
    logout_time integer DEFAULT 0,
    force_dayend_toolboxes character varying(1) DEFAULT 'Y'::character varying,
    front_end_printing character varying(1) DEFAULT 'N'::character varying,
    restrict_prt_dest_chg character varying(1),
    administrator_access_only character varying(1),
    allow_multi_currency character varying(1),
    local_currency character varying(10),
    csv_to_xls_converter character varying(50),
    last_prt_queue integer DEFAULT 0,
    last_sy26_row_id integer DEFAULT 0,
    last_sy40_no integer DEFAULT 0,
    last_wf25_no integer DEFAULT 0,
    last_sy06_row_id integer DEFAULT 0,
    last_sy35_log_no integer DEFAULT 0,
    last_sy33_row_id integer DEFAULT 0
);



--
-- Name: sy01_master_co_links; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy01_master_co_links (
    master_db character varying(10) NOT NULL,
    slave_db character varying(10) NOT NULL,
    modules_to_sync character varying(30)
);



--
-- Name: sy01w_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy01w_mast (
    widget_name character varying(40) NOT NULL,
    widget_desc character varying(40),
    access_group character varying(105),
    refresh_time integer DEFAULT 0
);



--
-- Name: sy02_user; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02_user (
    user_name character varying(10) NOT NULL,
    password character varying(90),
    pwd_status character varying(1),
    pwd_attempts integer DEFAULT 0,
    temp_pwd_expiry_date date,
    temp_pwd_expiry_time time(0) without time zone,
    pwd_last_chged_date date,
    full_name character varying(25),
    disable_user character varying(1),
    template_user character varying(1),
    login_type character varying(1),
    xact_mob_user character varying(1),
    ic_user character varying(1),
    position_held character varying(40),
    access_grp character varying(2),
    tm_grp character varying(25),
    employed_date date,
    employee_code character varying(20),
    email character varying(80),
    reports_to character varying(10),
    rep_code character varying(5),
    target_based_on character varying(1),
    default_loc character varying(4),
    default_whs character varying(3),
    allow_loc_chg character varying(1),
    allow_ovrd_pwd character varying(1),
    ovrd_pwd character varying(90),
    font_scaling character varying(1) DEFAULT 'Y'::character varying,
    menu_style character varying(1),
    auto_update_period character varying(1),
    admin_user character varying(1),
    sy_allow_prt_dest_chg character varying(1),
    gl_allow_cur_mth_maint character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_cur_mth_upd character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_pri_mth_maint character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_pri_mth_upd character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_auto_rev_maint character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_auto_rev_upd character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_std_mth_maint character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_std_mth_upd character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_jnl_import character varying(1) DEFAULT 'Y'::character varying,
    gl_allow_gl_import character varying(1) DEFAULT 'Y'::character varying,
    cb_authorise_bank_chg character varying(1),
    cb_allow_cb_tag character varying(1),
    cb_allow_dl_tag character varying(1),
    cb_allow_cl_tag character varying(1),
    cb_allow_jnl_maint character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_jnl_upd character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_stop_ord_maint character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_stop_ord_upd character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_acct_tran_maint character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_acct_tran_upd character varying(1) DEFAULT 'Y'::character varying,
    cb_allow_frx_reval_maint character varying(1) DEFAULT 'N'::character varying,
    cb_allow_frx_reval_upd character varying(1) DEFAULT 'N'::character varying,
    cb_allow_gen_frx_rev_maint character varying(1) DEFAULT 'N'::character varying,
    cl_authorise_bank_chg character varying(1),
    cl_allow_secret_notes character varying(1),
    cl_allow_terms_chg character varying(1),
    cl_allow_detailed_enq character varying(1),
    cl_allow_block_recon character varying(1),
    cl_allow_auto_tag_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_jnl_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_jnl_upd character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_pay_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_pay_upd character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_auto_adj_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_auto_adj_upd character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_woff_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_woff_upd character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_frx_reval_maint character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_frx_reval_upd character varying(1) DEFAULT 'Y'::character varying,
    cl_allow_gen_frx_rev_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_secret_notes character varying(1),
    dl_allow_terms_chg character varying(1),
    dl_allow_temp_cr_limit_chg character varying(1),
    dl_allow_cr_limit_chg character varying(1),
    dl_allow_max_cr_limit_chg character varying(1),
    dl_allow_detailed_enq character varying(1),
    dl_allow_rep_enq character varying(1),
    dl_allow_opr_enq character varying(1),
    dl_allow_auto_tag_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_pos_type_change character varying(1),
    dl_allow_jnl_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_jnl_upd character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_woff_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_woff_upd character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_frx_reval_maint character varying(1),
    dl_allow_frx_reval_upd character varying(1),
    dl_allow_gen_frx_rev_maint character varying(1),
    dl_allow_recp_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_recp_upd character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_auto_adj_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_auto_adj_upd character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_int_charge_maint character varying(1) DEFAULT 'Y'::character varying,
    dl_allow_int_charge_upd character varying(1) DEFAULT 'Y'::character varying,
    jc_allow_latest_cost_upd character varying(1) DEFAULT 'Y'::character varying,
    jc_allow_shortfall character varying(1) DEFAULT 'Y'::character varying,
    jc_allow_view_je character varying(1) DEFAULT 'A'::character varying,
    jc_allow_view_js character varying(1) DEFAULT 'A'::character varying,
    jc_allow_view_short character varying(1) DEFAULT 'A'::character varying,
    sa_allow_price_amend character varying(1),
    sa_allow_cost_ovrd character varying(1) DEFAULT 'N'::character varying,
    sa_allow_below_cost character varying(1),
    sa_allow_below_min_gp character varying(1),
    sa_allow_below_req_gp character varying(1),
    sa_allow_vat_ind_chg character varying(1),
    sa_allow_cost_only_items character varying(1),
    sa_allow_rep_code_chg character varying(1),
    sa_allow_mkt_rep_chg character varying(1),
    sa_allow_export_sale character varying(1),
    sa_allow_bom_on_fly_prt character varying(1) DEFAULT 'N'::character varying,
    sa_qt_allow_del character varying(1),
    sa_qt_allow_view character varying(1),
    sa_qt_allow_amend character varying(1),
    sa_qt_allow_auth character varying(1),
    sa_qt_allow_chg_without_dep character varying(1),
    sa_qt_allow_deposit_transfer character varying(1),
    sa_so_allow_on_hold_ovrd character varying(1),
    sa_so_allow_crlimit_ovrd character varying(1),
    sa_so_allow_res_stk character varying(1),
    sa_so_allow_ord_del character varying(1),
    sa_so_allow_b2b_ord_chg character varying(1),
    sa_so_allow_bo_ord_del character varying(1),
    sa_so_allow_replen_ord_del character varying(1),
    sa_so_allow_view character varying(1),
    sa_so_allow_amend character varying(1),
    sa_inv_allow_crlimit_ovrd character varying(1),
    sa_inv_allow_cod_acct_ovrd character varying(1),
    sa_inv_allow_view character varying(1),
    sa_inv_allow_amend character varying(1),
    sa_inv_allow_inv_so_loc_chg character varying(1),
    sa_inv_allow_cnote_create character varying(1),
    sa_inv_allow_link_crn_loc_chg character varying(1),
    sa_inv_allow_war_approval character varying(1),
    sa_inv_allow_cession character varying(1),
    sa_inv_allow_pos_cnote_tender character varying(1),
    sa_inv_allow_pos_eft_tender character varying(1),
    sa_inv_allow_pos_cash_drop character varying(1),
    sa_inv_allow_kill_pos_voucher character varying(1),
    sa_inv_allow_pos_void character varying(1),
    sa_inv_allow_expense_void character varying(1),
    sa_inv_allow_pos_acct_pay character varying(1),
    sa_inv_allow_pos_acct_rev character varying(1),
    sa_allow_pos_reversals character varying(1) DEFAULT 'N'::character varying,
    sa_allow_pos_cashbacks character varying(1) DEFAULT 'N'::character varying,
    sa_inv_allow_pos_expenses character varying(1),
    sa_inv_allow_short_over_ovrd character varying(1),
    sa_inv_allow_inv_query character varying(1),
    pu_allow_bo_pur character varying(1),
    pu_allow_stk_pur character varying(1),
    pu_allow_non_stk_pur character varying(1),
    pu_allow_vat_ind_chg character varying(1),
    pu_allow_import_purchase character varying(1),
    pu_allow_import_duties_chg character varying(1),
    pu_allow_import_var_override character varying(1),
    pu_allow_price_chg_on_match character varying(1),
    pu_po_allow_del character varying(1),
    pu_po_allow_view character varying(1),
    pu_po_allow_amend character varying(1),
    pu_po_allow_bo_amend character varying(1),
    pu_po_allow_unblock character varying(1),
    pu_po_allow_supp_confirm character varying(1),
    pu_po_allow_paid_in_advance character varying(1),
    pu_grn_allow_view character varying(1),
    pu_grn_allow_grn_po_loc_chg character varying(1),
    pu_grn_allow_grv_create character varying(1),
    pu_grn_allow_link_grv_loc_chg character varying(1),
    pu_allow_deal_on_po character varying(1),
    st_allow_cost_viewing character varying(1),
    st_allow_replace_viewing character varying(1),
    st_allow_value_viewing character varying(1),
    st_allow_rebate_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_1_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_2_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_3_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_4_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_5_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_6_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_7_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_disc_8_viewing character varying(1) DEFAULT 'Y'::character varying,
    st_allow_ser_excp_reports character varying(1),
    st_allow_bin_not_scan character varying(1),
    st_allow_stk_items_not_scan character varying(1),
    st_auth_var_rep character varying(1),
    st_allow_stocktake_process character varying(1),
    st_allow_wt_variance_view character varying(1) DEFAULT 'Y'::character varying,
    bo_allow_cost_viewing character varying(1),
    bo_allow_replace_viewing character varying(1),
    bo_allow_value_viewing character varying(1),
    bm_allow_zero_wo_recpt character varying(1),
    prt_report integer DEFAULT 0,
    prt_inv integer DEFAULT 0,
    prt_pos_slip integer DEFAULT 0,
    prt_pos_display integer DEFAULT 0,
    prt_pull integer DEFAULT 0,
    prt_del_note integer DEFAULT 0,
    prt_slip integer DEFAULT 0,
    prt_qt integer DEFAULT 0,
    prt_po integer DEFAULT 0,
    prt_grn integer DEFAULT 0,
    prt_works_ord integer DEFAULT 0,
    prt_store_req integer DEFAULT 0,
    prt_barcode integer DEFAULT 0,
    prt_serial_no integer DEFAULT 0,
    prt_dest character varying(1),
    last_date_used date,
    last_screen_res_used integer DEFAULT 0,
    last_prt_screen_length integer DEFAULT 0,
    sort_pos integer DEFAULT 0,
    pid character varying(15),
    cid character varying(15),
    expanded boolean,
    xact_mob_token character varying(250)
);



--
-- Name: sy02bi_widget; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02bi_widget (
    user_name character varying(10) NOT NULL,
    widget1 character varying(40),
    widget2 character varying(40),
    widget3 character varying(40),
    widget4 character varying(40),
    widget5 character varying(40),
    widget6 character varying(40),
    widget7 character varying(40),
    widget8 character varying(40),
    widget9 character varying(40)
);



--
-- Name: sy02d_grp_div; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02d_grp_div (
    user_name character varying(10) NOT NULL,
    div_code character varying(5) NOT NULL,
    allow_stk_grp_division character varying(1)
);



--
-- Name: sy02f_user_favs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02f_user_favs (
    user_name character varying(10) NOT NULL,
    f1 integer DEFAULT 0,
    f1_modal character varying(1) DEFAULT 'N'::character varying,
    f2 integer DEFAULT 0,
    f2_modal character varying(1) DEFAULT 'N'::character varying,
    f3 integer DEFAULT 0,
    f3_modal character varying(1) DEFAULT 'N'::character varying,
    f4 integer DEFAULT 0,
    f4_modal character varying(1) DEFAULT 'N'::character varying,
    f5 integer DEFAULT 0,
    f5_modal character varying(1) DEFAULT 'N'::character varying,
    f6 integer DEFAULT 0,
    f6_modal character varying(1) DEFAULT 'N'::character varying,
    f7 integer DEFAULT 0,
    f7_modal character varying(1) DEFAULT 'N'::character varying,
    f8 integer DEFAULT 0,
    f8_modal character varying(1) DEFAULT 'N'::character varying,
    f9 integer DEFAULT 0,
    f9_modal character varying(1) DEFAULT 'N'::character varying,
    f10 integer DEFAULT 0,
    f10_modal character varying(1) DEFAULT 'N'::character varying,
    f11 integer DEFAULT 0,
    f11_modal character varying(1) DEFAULT 'N'::character varying,
    f12 integer DEFAULT 0,
    f12_modal character varying(1) DEFAULT 'N'::character varying,
    r1 integer DEFAULT 0,
    r2 integer DEFAULT 0,
    r3 integer DEFAULT 0,
    r4 integer DEFAULT 0,
    r5 integer DEFAULT 0,
    r6 integer DEFAULT 0,
    def_img_size integer DEFAULT 4,
    def_img_type integer DEFAULT 1
);



--
-- Name: sy02g_user_stk_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02g_user_stk_grp (
    user_name character varying(10) NOT NULL,
    div_code character varying(5) NOT NULL,
    section_code character varying(25) NOT NULL,
    stk_grp character varying(5) NOT NULL,
    allow_access character varying(1),
    allow_cost_viewing character varying(1),
    allow_replace_viewing character varying(1),
    allow_value_viewing character varying(1),
    allow_pu character varying(1),
    allow_sa character varying(1),
    allow_price character varying(1)
);



--
-- Name: sy02h_pwd_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02h_pwd_hist (
    user_name character varying(10) NOT NULL,
    chg_id integer DEFAULT 0 NOT NULL,
    chg_date date,
    chg_time time(0) without time zone,
    pwd_type character varying(1),
    password character varying(90)
);



--
-- Name: sy02l_user_loc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02l_user_loc (
    user_name character varying(10) NOT NULL,
    loc character varying(3) NOT NULL,
    whs character varying(3) DEFAULT '00'::character varying NOT NULL,
    allow_ctrl_tot_view character varying(1),
    allow_dl_rep_enq character varying(1),
    allow_dl_opr_enq character varying(1),
    allow_qt_maint character varying(1),
    allow_qt_enq character varying(1),
    allow_so_maint character varying(1),
    allow_so_enq character varying(1),
    allow_del_maint character varying(1),
    allow_inv_maint character varying(1),
    allow_inv_enq character varying(1),
    allow_po_maint character varying(1),
    allow_po_enq character varying(1),
    allow_grn_maint character varying(1),
    allow_grn_enq character varying(1),
    allow_ibr_maint character varying(1),
    allow_ib_maint character varying(1),
    allow_stk_adjustments_whs character varying(1),
    allow_stk_detailed_enq character varying(1),
    allow_stk_warehouse_view character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: sy02p_user_positions; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02p_user_positions (
    position_held character varying(40) NOT NULL
);



--
-- Name: sy02s_startup; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02s_startup (
    user_name character varying(10) NOT NULL,
    startup_1 integer,
    startup_2 integer,
    startup_3 integer
);



--
-- Name: sy02w_user_widget; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02w_user_widget (
    user_name character varying(10) NOT NULL,
    widget1 character varying(40),
    widget2 character varying(40),
    widget3 character varying(40),
    widget4 character varying(40),
    widget5 character varying(40),
    widget6 character varying(40),
    widget7 character varying(40),
    widget8 character varying(40),
    widget9 character varying(40)
);



--
-- Name: sy02wp_dash_param; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy02wp_dash_param (
    user_name character varying(10) NOT NULL,
    widget_no integer DEFAULT 0 NOT NULL,
    param character varying(50),
    sync character varying(1) DEFAULT 'Y'::character varying
);



--
-- Name: sy04_access_grps; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy04_access_grps (
    grp character varying(2) NOT NULL,
    active character varying(1),
    grp_desc character varying(30)
);



--
-- Name: sy05_tm_grps; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy05_tm_grps (
    tm_grp character varying(25) NOT NULL,
    tm_sort integer DEFAULT 0,
    tm_user character varying(10)
);



--
-- Name: sy06a_access; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy06a_access (
    row_id integer DEFAULT 0 NOT NULL,
    access_grp character varying(160)
);



--
-- Name: sy06c_custom_menu; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy06c_custom_menu (
    row_id integer DEFAULT 0 NOT NULL,
    custom_db_name character varying(30) NOT NULL
);



--
-- Name: sy06s_structure; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy06s_structure (
    row_id integer NOT NULL,
    sort_seq integer,
    parent_id character varying(10),
    child_id character varying(10),
    level_no integer,
    descr character varying(30),
    type character varying(1),
    prog_name character varying(60),
    xact_lite character varying(1),
    custom_menu_option character varying(1),
    image character varying(40),
    help_file_link character varying(255)
);



--
-- Name: sy07_prt_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy07_prt_mast (
    prt_no integer DEFAULT 0 NOT NULL,
    active character varying(1),
    prt_name character varying(30),
    prt_type character varying(15),
    is_laser character varying(1),
    spool_dev character varying(80),
    cmd_prt_name character varying(30),
    cmd_destination character varying(60)
);



--
-- Name: sy08_prt_types; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy08_prt_types (
    prt_type character varying(30) NOT NULL,
    descr character varying(30),
    tf character varying(120),
    su character varying(120),
    eu character varying(120),
    dw character varying(120),
    sw character varying(120),
    oc character varying(120),
    ec character varying(120),
    u1 character varying(120),
    u2 character varying(120),
    u3 character varying(120),
    u4 character varying(120),
    cp character varying(120),
    rp character varying(120),
    p5 character varying(120),
    p10 character varying(120),
    p12 character varying(120),
    p15 character varying(120),
    p17 character varying(120),
    p20 character varying(120),
    pl integer DEFAULT 0
);



--
-- Name: sy09_prt_esc_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy09_prt_esc_codes (
    prt_type character varying(15) NOT NULL,
    sort_seq_no integer DEFAULT 0 NOT NULL,
    format character varying(25) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    descr character varying(30),
    dec_val integer DEFAULT 0,
    binary_val character varying(3)
);



--
-- Name: sy10_lic_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy10_lic_mast (
    co_name character varying(45) NOT NULL,
    co_serial_no integer DEFAULT 0,
    gl_mod character varying(1),
    cb_mod character varying(1),
    dl_mod character varying(1),
    sa_mod character varying(1),
    cl_mod character varying(1),
    pu_mod character varying(1),
    st_mod character varying(1),
    st_ml_mod character varying(1),
    st_se_mod character varying(1),
    tf_mod character varying(1),
    bo_mod character varying(1),
    bm_mod character varying(1),
    jc_mod character varying(1),
    pc_mod character varying(1),
    mb_mod character varying(1),
    em_mod character varying(1),
    gr_mod character varying(1)
);



--
-- Name: sy12_forex_currency; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy12_forex_currency (
    base_currency character varying(10),
    forex_currency character varying(10),
    forex_currency_name character varying(35),
    country character varying(35),
    exchange_rate numeric(13,4),
    update_rate_by character varying(1),
    update_freq integer,
    last_update_by character varying(10),
    last_update_date date,
    last_update_time time(0) without time zone
);



--
-- Name: sy13_fiscal_device; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy13_fiscal_device (
    device_id integer NOT NULL,
    api_key character varying(50) NOT NULL,
    api_secret character varying(100),
    api_url character varying(100),
    api_signature character varying(55),
    app_name character varying(20),
    app_station character varying(15)
);



--
-- Name: sy14_dashboard_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy14_dashboard_mast (
    dashboard_type character varying(1) DEFAULT 'S'::character varying NOT NULL,
    name character varying(100) NOT NULL,
    link character varying(150),
    access_grp character varying(160)
);



--
-- Name: sy15_phone_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy15_phone_codes (
    country character varying(2) NOT NULL,
    phone_code character varying(4)
);



--
-- Name: sy16_post_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy16_post_codes (
    country character varying(2) NOT NULL,
    post_code character varying(10) NOT NULL,
    suburb character varying(100)
);



--
-- Name: sy20_batch_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy20_batch_log (
    period date NOT NULL,
    source character varying(2) NOT NULL,
    batch_no integer DEFAULT 0 NOT NULL,
    status character varying(3),
    descr character varying(30),
    prog_used character varying(20),
    menu_arg character varying(6),
    batch_type character varying(6),
    foreign_batch character varying(1),
    foreign_currency character varying(10),
    batch_total numeric(13,2) DEFAULT 0,
    post_total numeric(13,2) DEFAULT 0,
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    update_by character varying(10),
    update_date date,
    update_time time(0) without time zone,
    std_move_bt character varying(1),
    misc_hd_data character varying(200),
    last_row_id integer DEFAULT 0
);



--
-- Name: sy21_del_by; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy21_del_by (
    module character varying(2) NOT NULL,
    del_by_code character varying(4) NOT NULL,
    sort_pos integer,
    del_by_desc character varying(30),
    default_del_by character varying(1),
    force_del_area_on_docs character varying(1),
    force_double_chk_on_del_add character varying(1),
    prt_package_labels character varying(1),
    whs_track_priority integer,
    disc_level integer,
    del_code character varying(16)
);



--
-- Name: sy220_user_productivity; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy220_user_productivity (
    user_name character varying(10) NOT NULL,
    loc character varying(4) NOT NULL,
    create_by character varying(10) NOT NULL,
    doc_type character varying(3) NOT NULL,
    period date NOT NULL,
    value numeric(13,2) DEFAULT 0,
    ord_qty numeric(13,2) DEFAULT 0
);



--
-- Name: sy22_prt_que; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy22_prt_que (
    report_no integer DEFAULT 0 NOT NULL,
    system_report character varying(1),
    file_type character varying(10),
    prt_to_laser character varying(1),
    source character varying(2),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    prog_name character varying(30),
    report_desc character varying(35),
    status character varying(1),
    comment character varying(20)
);



--
-- Name: sy23_proj_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy23_proj_mast (
    proj_code character varying(8) NOT NULL,
    status character varying(1),
    proj_desc character varying(40)
);



--
-- Name: sy25_vat_201; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy25_vat_201 (
    period date NOT NULL,
    v1_out_std_goods numeric(13,2) DEFAULT 0,
    v4_out_std_vat numeric(13,2) DEFAULT 0,
    v1a_out_std_capex numeric(13,2) DEFAULT 0,
    v4a_out_std_capex_vat numeric(13,2) DEFAULT 0,
    v2_out_zero_goods numeric(13,2) DEFAULT 0,
    v2a_out_zero_export_goods numeric(13,2) DEFAULT 0,
    v3_out_exempt_goods numeric(13,2) DEFAULT 0,
    v10_out_chg_in_use numeric(13,2) DEFAULT 0,
    v11_out_chg_in_use_vat numeric(13,2) DEFAULT 0,
    v12_out_other_goods numeric(13,2) DEFAULT 0,
    v12_out_other_vat numeric(13,2) DEFAULT 0,
    v13_out_tot_vat numeric(13,2) DEFAULT 0,
    v14_in_capex_goods numeric(13,2) DEFAULT 0,
    v14_in_capex_vat numeric(13,2) DEFAULT 0,
    v14a_in_capex_import_goods numeric(13,2) DEFAULT 0,
    v14a_in_capex_import_vat numeric(13,2) DEFAULT 0,
    v15_in_other_goods numeric(13,2) DEFAULT 0,
    v15_in_other_goods_vat numeric(13,2) DEFAULT 0,
    v15a_in_other_import_goods numeric(13,2) DEFAULT 0,
    v15a_in_other_import_vat numeric(13,2) DEFAULT 0,
    v16_in_chg_in_use numeric(13,2) DEFAULT 0,
    v16_in_chg_in_use_vat numeric(13,2) DEFAULT 0,
    v17_in_bad_debt numeric(13,2) DEFAULT 0,
    v17_in_bad_debt_vat numeric(13,2) DEFAULT 0,
    v18_in_other numeric(13,2) DEFAULT 0,
    v18_in_other_vat numeric(13,2) DEFAULT 0,
    v19_in_tot_vat numeric(13,2) DEFAULT 0,
    v20_vat_due numeric(13,2) DEFAULT 0
);



--
-- Name: sy26_vat_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy26_vat_dt (
    period date NOT NULL,
    vat_201_no character varying(3) NOT NULL,
    in_out character varying(1) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    source character varying(2) NOT NULL,
    batch_no integer DEFAULT 0,
    account character varying(8),
    acct_name character varying(30),
    tran_type character varying(3),
    tran_date date,
    ref character varying(20),
    std_amt numeric(13,2) DEFAULT 0,
    cap_amt numeric(13,2) DEFAULT 0,
    cap_imp_amt numeric(13,2) DEFAULT 0,
    goods_imp_amt numeric(13,2) DEFAULT 0,
    zero_amt numeric(13,2) DEFAULT 0,
    exe_amt numeric(13,2) DEFAULT 0,
    goods_amt numeric(13,2) DEFAULT 0,
    vat_amt numeric(13,2) DEFAULT 0
);



--
-- Name: sy27_supercession; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy27_supercession (
    row_id integer NOT NULL,
    source character varying(2) NOT NULL,
    type character varying(1) NOT NULL,
    old_code character varying(16),
    new_code character varying(16),
    user_name character varying(10),
    amend_by character varying(10),
    ready_for_update character varying(1)
);



--
-- Name: sy27h_code_history; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy27h_code_history (
    first_code character varying(16) NOT NULL,
    row_id integer NOT NULL,
    module character varying(2) NOT NULL,
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    org_code character varying(16),
    new_code character varying(16),
    type character varying(1)
);



--
-- Name: sy290_eb_daily_snapshot; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy290_eb_daily_snapshot (
    row_id integer NOT NULL,
    snap_month character varying(20),
    pzone_tot_days integer DEFAULT 0,
    enertec_tot_days integer DEFAULT 0,
    inter_co_sales_budget numeric(13,2) DEFAULT 0,
    inter_co_gp_budget numeric(13,2) DEFAULT 0
);



--
-- Name: sy29_reval; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy29_reval (
    source_no character varying(11) NOT NULL,
    source character varying(2) NOT NULL,
    source_row_id integer NOT NULL,
    source_comp_row_id integer DEFAULT 0 NOT NULL,
    loc character varying(3) NOT NULL,
    source_loc character varying(3),
    gl_code character varying(8),
    org_cost numeric(13,2),
    org_value numeric(13,2),
    new_cost numeric(13,2),
    new_value numeric(13,2),
    reval numeric(13,2)
);



--
-- Name: sy30_approval_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy30_approval_hd (
    approval_no character varying(11) NOT NULL,
    source character varying(2),
    doc_type character varying(4),
    status character varying(1),
    descr character varying(40),
    filter_on character varying(3),
    filter_code character varying(255),
    based_on character varying(3),
    forex_tracking character varying(1),
    foreign_currency character varying(3),
    wf_type character varying(1),
    expiry_time numeric(6,2),
    threshold_lvl numeric(13,2),
    create_date date,
    create_by character varying(10),
    amend_date date,
    amend_by character varying(10)
);



--
-- Name: sy31_approval_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy31_approval_dt (
    approval_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    approver_type character varying(3),
    approver_code character varying(10),
    approval_based_on_loc_region character varying(1),
    approval_loc_region character varying(3),
    approval_value numeric(13,2)
);



--
-- Name: sy31a_access_grp; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy31a_access_grp (
    approval_no character varying(11) NOT NULL,
    row_id integer NOT NULL,
    sy31_row_id integer NOT NULL,
    access_grp character varying(2),
    approver_code character varying(10),
    approval_based_on_loc_region character varying(1),
    approval_loc_region character varying(3)
);



--
-- Name: sy33_program_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy33_program_log (
    date date NOT NULL,
    "time" time(0) without time zone NOT NULL,
    user_name character varying(10) NOT NULL,
    row_id integer NOT NULL,
    pid integer DEFAULT 0 NOT NULL,
    access_group character varying(2),
    prog_name character varying(30)
);



--
-- Name: sy35_chg_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy35_chg_log (
    log_no integer DEFAULT 0 NOT NULL,
    session_id integer DEFAULT 0 NOT NULL,
    prog_name character varying(30) NOT NULL,
    user_name character varying(10),
    chg_date date NOT NULL,
    chg_time time(0) without time zone NOT NULL,
    tbl_name character varying(30),
    parent_key character varying(30),
    child_key character varying(30),
    chged_field character varying(50),
    org_val character varying(200),
    new_val character varying(200),
    action character varying(15)
);



--
-- Name: sy35_chg_log_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy35_chg_log_arch (
    log_no integer DEFAULT 0 NOT NULL,
    session_id integer DEFAULT 0,
    prog_name character varying(30),
    user_name character varying(10),
    chg_date date,
    chg_time time(0) without time zone,
    tbl_name character varying(30),
    parent_key character varying(30),
    child_key character varying(30),
    chged_field character varying(50),
    org_val character varying(200),
    new_val character varying(200),
    action character varying(15)
);



--
-- Name: sy36_running_progs; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy36_running_progs (
    pid integer DEFAULT 0 NOT NULL,
    user_name character varying(10) NOT NULL,
    prog_name character varying(30),
    date_opened date,
    time_opened time(0) without time zone
);



--
-- Name: sy37_in_use_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy37_in_use_log (
    user_name character varying(10) NOT NULL,
    pid integer DEFAULT 0 NOT NULL,
    prog_name character varying(30) NOT NULL,
    tbl_name character varying(30) NOT NULL,
    key_value character varying(50) NOT NULL,
    date_locked date,
    time_locked time(0) without time zone,
    row_hidden character varying(1)
);



--
-- Name: sy38_auth_out_req; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy38_auth_out_req (
    pid character varying(15) NOT NULL,
    prog_name character varying(30) NOT NULL,
    req_by character varying(15) NOT NULL,
    req_date date NOT NULL,
    req_time time(0) without time zone NOT NULL,
    motivation character varying(1000),
    status character varying(5),
    viewed_status character varying(5),
    doc_no character varying(35),
    prod_code character varying(16),
    doc_row_id integer,
    wf26_reason_id integer,
    key_field character varying(30),
    key_description character varying(50),
    limit_value character varying(18),
    current_value character varying(18),
    prt_ind character varying(1),
    doc_qty numeric(13,2),
    unit_cost numeric(13,2),
    unit_price numeric(13,2),
    disc_1 numeric(13,2),
    disc_2 numeric(13,2),
    vat_ind character varying(1),
    gross numeric(13,2),
    gross_incl numeric(13,2),
    tot_excl numeric(13,2),
    tot_incl numeric(13,2),
    auth_by character varying(20),
    auth_date date,
    auth_time time(0) without time zone
);



--
-- Name: sy40_support_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy40_support_log (
    call_no integer DEFAULT 0 NOT NULL,
    logged_date date,
    report_by character varying(15),
    priority character varying(2),
    program character varying(40),
    query character varying(200),
    completed character varying(1),
    solution character varying(200),
    solved_by character varying(20),
    solved_date date
);



--
-- Name: sy41_doc_attachement; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy41_doc_attachement (
    source_no integer NOT NULL,
    source_doc character varying(11),
    status character varying(1),
    file_size numeric(3,2),
    created_by character varying(10),
    created_date date,
    deleted_by character varying(10),
    deleted_date date,
    file_name character varying(255),
    folder_path character varying(255),
    module character varying(3) NOT NULL,
    prog_name character varying(60),
    file_cat character varying(40),
    user_desc character varying(50)
);



--
-- Name: sy42_file_cat_mast; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy42_file_cat_mast (
    module character varying(3) NOT NULL,
    file_cat character varying(20) NOT NULL,
    file_desc character varying(40)
);



--
-- Name: sy50_reports; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.sy50_reports (
    report_no integer DEFAULT 0 NOT NULL,
    report_desc character varying(30),
    line_type character varying(1),
    active character varying(1),
    frequency character varying(1),
    before_or_after character varying(1),
    module character varying(2),
    cmd character varying(1000)
);



--
-- Name: tb25_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tb25_hd (
    key_field_chg character varying(40) NOT NULL,
    name_field_chg character varying(40),
    name_desc_chg character varying(40),
    last_field_chg character varying(40),
    balance_chg numeric(13,2) DEFAULT 0,
    last_row_id integer DEFAULT 0
);



--
-- Name: tb26_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tb26_dt (
    key_field_chg character varying(40) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_seq integer DEFAULT 0,
    first_field_chg character varying(10),
    first_desc_chg character varying(20),
    second_desc_chg character varying(20),
    bal_field numeric(13,2) DEFAULT 0,
    tbl_last_chg character varying(40),
    last_sub_row_id integer DEFAULT 0
);



--
-- Name: tb26s_dts; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tb26s_dts (
    sub_key_field_chg character varying(40) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sub_row_id integer DEFAULT 0 NOT NULL,
    sort_seq integer DEFAULT 0,
    first_sub_field_chg character varying(10),
    sub_bal_field numeric(13,2) DEFAULT 0,
    tbl_sub_last_chg character varying(40)
);



--
-- Name: test_db; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.test_db (
    test_id integer DEFAULT 0 NOT NULL,
    test_name character varying(16)
);



--
-- Name: tm00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm00_sys_opt (
    last_task_no integer DEFAULT 0 NOT NULL,
    task_label character varying(10),
    task_default_priority character varying(25),
    task_default_folder character varying(10),
    task_default_email character varying(80),
    task_default_travel_code character varying(16),
    sla_tracked character varying(1) DEFAULT 'N'::character varying
);



--
-- Name: tm02_user; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm02_user (
    dl_code character varying(8) NOT NULL,
    user_email character varying(80) NOT NULL,
    dl_name character varying(40),
    loc character varying(3),
    user_name character varying(10),
    full_name character varying(25),
    superuser character varying(1) DEFAULT 'N'::character varying,
    password character varying(90),
    pwd_status character varying(1),
    pwd_attempts integer DEFAULT 0,
    temp_pwd_expiry_date date,
    temp_pwd_expiry_time time(0) without time zone,
    pwd_last_chged_date date,
    stk_code character varying(16),
    cell_no character varying(20)
);



--
-- Name: tm02d_dl_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm02d_dl_codes (
    user_name character varying(10) NOT NULL,
    dl_code character varying(8) NOT NULL,
    dl_name character varying(40),
    superuser character varying(1)
);



--
-- Name: tm02h_pwd_hist; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm02h_pwd_hist (
    user_name character varying(10) NOT NULL,
    chg_id integer DEFAULT 0 NOT NULL,
    chg_date date,
    chg_time time(0) without time zone,
    password character varying(90)
);



--
-- Name: tm03_priority; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm03_priority (
    priority character varying(1) NOT NULL,
    priority_tm_grp character varying(25) NOT NULL,
    priority_sort integer DEFAULT 0,
    priority_summ character varying(15),
    priority_desc text,
    priority_response_time numeric(6,2) DEFAULT 0,
    priority_exp_time numeric(6,2) DEFAULT 0,
    priority_highlight character varying(20)
);



--
-- Name: tm04_task_type; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm04_task_type (
    task_type character varying(1) NOT NULL,
    task_type_sort integer DEFAULT 0,
    task_type_desc character varying(25),
    sla_valid character varying(1)
);



--
-- Name: tm04s_sub_task; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm04s_sub_task (
    sub_task character varying(2) NOT NULL,
    sub_task_sort integer DEFAULT 0,
    sub_task_desc character varying(25)
);



--
-- Name: tm06_folder; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm06_folder (
    folder_code character varying(25) NOT NULL,
    folder_tm_grp character varying(25) NOT NULL,
    folder_sort integer DEFAULT 0
);



--
-- Name: tm07_task_tags; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm07_task_tags (
    tag_code character varying(25) NOT NULL,
    tm_grp character varying(25) NOT NULL,
    tag_sort_pos integer,
    tag_desc character varying(50)
);



--
-- Name: tm08_report_tags; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm08_report_tags (
    report_tag character varying(3) NOT NULL,
    report_tag_sort_pos integer DEFAULT 0,
    report_tag_desc character varying(25),
    estimate_tracked character varying(1),
    chargeable character varying(1)
);



--
-- Name: tm20_task_freeze_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm20_task_freeze_log (
    task_no integer NOT NULL,
    task_freeze_date date NOT NULL,
    task_freeze_time time(0) without time zone NOT NULL,
    task_is_frozen character varying(1),
    task_freeze_by character varying(10)
);



--
-- Name: tm20_task_freeze_log_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm20_task_freeze_log_arch (
    task_no integer NOT NULL,
    task_freeze_date date NOT NULL,
    task_freeze_time time(0) without time zone NOT NULL,
    task_is_frozen character varying(1),
    task_freeze_by character varying(10)
);



--
-- Name: tm22_comms_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm22_comms_hd (
    task_no integer DEFAULT 0 NOT NULL,
    task_type character varying(1),
    task_priority character varying(1),
    task_priority_order integer DEFAULT 0,
    task_sub_type character varying(2),
    task_subject character varying(100),
    task_log_by_email character varying(80),
    task_log_by character varying(10),
    task_log_date date,
    task_log_time time(0) without time zone,
    tm23_last_row_id integer DEFAULT 0
);



--
-- Name: tm22_comms_hd_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm22_comms_hd_arch (
    task_no integer DEFAULT 0 NOT NULL,
    task_type character varying(1),
    task_priority character varying(1),
    task_priority_order integer DEFAULT 0,
    task_sub_type character varying(2),
    task_subject character varying(100),
    task_log_by_email character varying(80),
    task_log_by character varying(10),
    task_log_date date,
    task_log_time time(0) without time zone,
    tm23_last_row_id integer DEFAULT 0
);



--
-- Name: tm22_comms_hd_mob; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm22_comms_hd_mob (
    task_no integer DEFAULT 0 NOT NULL,
    task_type character varying(1),
    task_priority character varying(1),
    task_priority_order integer DEFAULT 0,
    task_sub_type character varying(2),
    task_subject character varying(100),
    task_log_by_email character varying(80),
    task_log_by character varying(10),
    task_log_date date,
    task_log_time time(0) without time zone,
    tm23_last_row_id integer DEFAULT 0
);



--
-- Name: tm22c_comms_cc; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm22c_comms_cc (
    task_no integer NOT NULL,
    user_name character varying(10) NOT NULL,
    email character varying(80) NOT NULL,
    dl_code character varying(8),
    agent character varying(10),
    send_type character varying(1)
);



--
-- Name: tm22c_comms_cc_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm22c_comms_cc_arch (
    task_no integer NOT NULL,
    user_name character varying(10) NOT NULL,
    email character varying(80) NOT NULL,
    dl_code character varying(8),
    agent character varying(10),
    send_type character varying(1)
);



--
-- Name: tm23_comms_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm23_comms_dt (
    task_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    task_details text,
    task_send_from character varying(10),
    task_send_to character varying(80),
    task_respond_date date,
    task_respond_time time(0) without time zone,
    task_has_attachments character varying(1),
    tm23a_last_row_id integer DEFAULT 0
);



--
-- Name: tm23a_comms_attach; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm23a_comms_attach (
    task_no integer DEFAULT 0 NOT NULL,
    tm23_row_id integer DEFAULT 0 NOT NULL,
    attach_row_id integer DEFAULT 0 NOT NULL,
    attach_name character varying(255),
    attach_file bytea
);



--
-- Name: tm25_task_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25_task_hd (
    task_no integer DEFAULT 0 NOT NULL,
    task_status character varying(1),
    task_logged_by character varying(10),
    task_logged_date date,
    task_logged_time time(0) without time zone,
    task_dl_code character varying(8),
    task_dl_name character varying(40),
    task_owner character varying(25),
    task_agent character varying(10),
    task_proj_code character varying(8),
    pid character varying(30),
    cid character varying(30),
    expanded boolean,
    task_folder character varying(25),
    task_shared character varying(1),
    task_shared_with character varying(25),
    task_shared_folder character varying(25),
    task_shared_agent character varying(255),
    task_type character varying(1),
    task_cust_priority character varying(1),
    task_our_priority character varying(1),
    task_sub_type character varying(2),
    task_subject character varying(100),
    task_description text,
    task_needs_feedback character varying(1),
    task_last_actioned_date date,
    task_last_actioned_time time(0) without time zone,
    task_req_start_date date,
    task_req_start_time time(0) without time zone,
    task_start_date date,
    task_req_end_date date,
    task_req_end_time time(0) without time zone,
    task_release_date date,
    task_complete_by character varying(10),
    task_complete_date date,
    task_complete_time time(0) without time zone,
    task_tot_est numeric(6,2),
    task_assigned_to character varying(225),
    task_order_status character varying(1),
    task_quote_no character varying(11),
    task_order_ref character varying(20),
    task_rating integer,
    task_rating_reason character varying(1000),
    task_rated_by character varying(40),
    program_name character varying(60),
    doc_no character varying(15),
    tm26_last_row_id integer DEFAULT 0
);



--
-- Name: tm25_task_hd_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25_task_hd_arch (
    task_no integer DEFAULT 0 NOT NULL,
    task_status character varying(1),
    task_logged_by character varying(10),
    task_logged_date date,
    task_logged_time time(0) without time zone,
    task_dl_code character varying(8),
    task_dl_name character varying(40),
    task_owner character varying(25),
    task_agent character varying(10),
    task_proj_code character varying(8),
    pid character varying(30),
    cid character varying(30),
    expanded boolean,
    task_folder character varying(25),
    task_shared character varying(1),
    task_shared_with character varying(25),
    task_shared_folder character varying(25),
    task_shared_agent character varying(255),
    task_type character varying(1),
    task_cust_priority character varying(1),
    task_our_priority character varying(1),
    task_sub_type character varying(2),
    task_subject character varying(100),
    task_description text,
    task_needs_feedback character varying(1),
    task_last_actioned_date date,
    task_last_actioned_time time(0) without time zone,
    task_req_start_date date,
    task_req_start_time time(0) without time zone,
    task_start_date date,
    task_req_end_date date,
    task_req_end_time time(0) without time zone,
    task_release_date date,
    task_complete_by character varying(10),
    task_complete_date date,
    task_complete_time time(0) without time zone,
    task_tot_est numeric(6,2),
    task_assigned_to character varying(225),
    task_order_status character varying(1),
    task_quote_no character varying(11),
    task_order_ref character varying(20),
    task_rating integer,
    task_rating_reason character varying(1000),
    task_rated_by character varying(40),
    program_name character varying(60),
    doc_no character varying(15),
    tm26_last_row_id integer DEFAULT 0
);



--
-- Name: tm25a_assigned; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25a_assigned (
    task_no integer DEFAULT 0 NOT NULL,
    task_assigned_to character varying(225) NOT NULL,
    row_id integer NOT NULL,
    task_action_by character varying(10) NOT NULL,
    task_assigned_folder character varying(225),
    start_date date,
    exp_end_date date,
    complete_date date,
    est_hrs numeric(6,2) DEFAULT 0,
    tot_hrs numeric(6,2) DEFAULT 0
);



--
-- Name: tm25r_task_reminders; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25r_task_reminders (
    reminder_id integer NOT NULL,
    task_no integer NOT NULL,
    user_name character varying(10) NOT NULL,
    reminder_date date NOT NULL,
    reminder_time time(0) without time zone NOT NULL,
    message character varying(1000),
    prompt_or_email character varying(1)
);



--
-- Name: tm25r_task_reminders_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25r_task_reminders_arch (
    reminder_id integer DEFAULT 0 NOT NULL,
    task_no integer DEFAULT 0,
    user_name character varying(10),
    reminder_date date,
    reminder_time time(0) without time zone,
    message character varying(1000),
    prompt_or_email character varying(1)
);



--
-- Name: tm25t_task_tags; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25t_task_tags (
    task_no integer NOT NULL,
    task_tag character varying(25) NOT NULL
);



--
-- Name: tm25t_task_tags_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm25t_task_tags_arch (
    task_no integer NOT NULL,
    task_tag character varying(25) NOT NULL
);



--
-- Name: tm26_task_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm26_task_dt (
    task_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    tm25a_row_id integer,
    task_action_is_billable character varying(1),
    task_action_hours numeric(6,2) DEFAULT 0,
    task_action_report_tag character varying(255),
    task_action_details text,
    task_action_folder character varying(25),
    task_action_by character varying(10),
    task_action_date date,
    task_action_time time(0) without time zone,
    task_so_no character varying(11),
    tm26a_last_row_id integer DEFAULT 0
);



--
-- Name: tm26_task_dt_arch; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm26_task_dt_arch (
    task_no integer DEFAULT 0 NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    tm25a_row_id integer,
    task_action_is_billable character varying(1),
    task_action_hours numeric(6,2) DEFAULT 0,
    task_action_report_tag character varying(255),
    task_action_details text,
    task_action_folder character varying(25),
    task_action_by character varying(10),
    task_action_date date,
    task_action_time time(0) without time zone,
    task_so_no character varying(11),
    tm26a_last_row_id integer DEFAULT 0
);



--
-- Name: tm26a_task_attach; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm26a_task_attach (
    task_no integer DEFAULT 0 NOT NULL,
    tm26_row_id integer DEFAULT 0 NOT NULL,
    attach_row_id integer DEFAULT 0 NOT NULL,
    attach_name character varying(255),
    attach_file bytea
);



--
-- Name: tm38_request_log; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.tm38_request_log (
    task_no integer NOT NULL,
    review_id integer NOT NULL,
    status character varying(1),
    review_for character varying(10),
    request_date date,
    request_time time(0) without time zone,
    request_notes text,
    review_by character varying(10),
    review_date date,
    review_time time(0) without time zone,
    review_score integer,
    review_notes text
);



--
-- Name: wf25_workflows; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wf25_workflows (
    wf_no integer NOT NULL,
    status character varying(1),
    type character varying(1),
    subject character varying(100),
    comment character varying(255),
    action character varying(25),
    approval_no character varying(11) DEFAULT '0'::character varying,
    source_doc_type character varying(1),
    source_doc_no character varying(11),
    source_qt_revision_no integer DEFAULT 0,
    source_status character varying(1),
    prog_name character varying(30),
    assigned_to character varying(10),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    req_end_date date,
    req_end_time time(0) without time zone,
    complete_date date,
    complete_time time(0) without time zone
);



--
-- Name: wf26_app_reason; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wf26_app_reason (
    reason_id integer NOT NULL,
    module character varying(2) NOT NULL,
    status character varying(1),
    action_type character varying(1),
    reason_code character varying(8),
    sort_pos integer,
    reason_desc character varying(40)
);



--
-- Name: wr00_sys_opt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr00_sys_opt (
    row_id integer DEFAULT 0 NOT NULL,
    mths_to_keep_war_hist integer DEFAULT 0,
    block_date_chg character varying(1),
    allow_price_amend character varying(1),
    force_comm_method character varying(1),
    default_comm_method character varying(1),
    default_comm_message character varying(255),
    allow_comm_message_chg character varying(1),
    book_in_rec character varying(25),
    form_prog_book_in_label character varying(25)
);



--
-- Name: wr01_doc_no; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr01_doc_no (
    loc character varying(3) NOT NULL,
    first_war_no integer,
    last_war_no integer,
    cur_war_no integer
);



--
-- Name: wr03_wr_reasons; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr03_wr_reasons (
    reason_code character varying(8) NOT NULL,
    sort_pos integer NOT NULL,
    reason_lost character varying(4)
);



--
-- Name: wr20_war_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr20_war_hd (
    book_in_no character varying(11) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    status character varying(1),
    warranty_or_repair character varying(1),
    internal_or_external character varying(1),
    progress_status character varying(1),
    qt_no character varying(11),
    principle_book_in character varying(11),
    dl_code character varying(8),
    dl_name character varying(33),
    vat_no character varying(12),
    contract_name character varying(40),
    post_add_1 character varying(30),
    post_add_2 character varying(30),
    post_add_3 character varying(30),
    post_add_4 character varying(10),
    add_1 character varying(30),
    add_2 character varying(30),
    add_3 character varying(30),
    add_4 character varying(10),
    tel character varying(13),
    cell character varying(13),
    contact character varying(13),
    email character varying(80),
    preferred_comm_method character varying(1),
    create_by character varying(10),
    create_date date,
    create_time time(0) without time zone,
    amend_by character varying(10),
    amend_date date,
    amend_time time(0) without time zone,
    our_ref character varying(20),
    cust_ref character varying(20),
    delivery_by character varying(15),
    del_area character varying(5),
    tot_mat numeric(13,2) DEFAULT 0,
    tot_lab numeric(13,2) DEFAULT 0,
    tot_trans numeric(13,2) DEFAULT 0,
    tot_sundry numeric(13,2) DEFAULT 0,
    tot_cost numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,2) DEFAULT 0,
    tot_price numeric(13,2) DEFAULT 0,
    tot_vat numeric(13,2) DEFAULT 0,
    tot_contract numeric(13,2) DEFAULT 0,
    allow_js_creation character varying(1),
    last_inspection_by character varying(10),
    last_repair_by character varying(10),
    reason_code character varying(10),
    last_wr21_row_id integer DEFAULT 0
);



--
-- Name: wr20n_book_in_notes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr20n_book_in_notes (
    book_in_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    progress_status character varying(30),
    status_chg_date date,
    status_chg_time time(0) without time zone,
    status_chg_note character varying(255),
    status_chg_by character varying(10)
);



--
-- Name: wr21_war_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wr21_war_dt (
    book_in_no character varying(11) NOT NULL,
    row_id integer DEFAULT 0 NOT NULL,
    sort_pos integer DEFAULT 0,
    loc character varying(3),
    whs character varying(3),
    item_type character varying(1),
    prt_ind character varying(1),
    prod_code character varying(16),
    desc_1 character varying(40),
    desc_2 character varying(40),
    desc_3 character varying(40),
    desc_4 character varying(40),
    desc_5 character varying(40),
    desc_6 character varying(40),
    stk_code_link character varying(16),
    uom character varying(8),
    qty numeric(11,3) DEFAULT 0,
    due_qty numeric(11,3) DEFAULT 0,
    js_qty numeric(11,3) DEFAULT 0,
    unit_price numeric(13,2) DEFAULT 0,
    unit_cost numeric(13,2) DEFAULT 0,
    disc numeric(7,2) DEFAULT 0,
    net_unit_price numeric(13,2) DEFAULT 0,
    vat_ind character varying(1),
    gross_cost numeric(13,2) DEFAULT 0,
    gross_price numeric(13,2) DEFAULT 0,
    gp_perc numeric(7,3) DEFAULT 0,
    cl_code character varying(8),
    cl_name character varying(40),
    below_cost_ovrd_by character varying(10),
    below_min_gp_ovrd_by character varying(10),
    below_req_gp_ovrd_by character varying(10)
);



--
-- Name: wt20_doc_hd; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt20_doc_hd (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    doc_type character varying(3) NOT NULL,
    doc_no character varying(14) NOT NULL,
    status character varying(1),
    priority_lvl integer,
    current_status character varying(4),
    current_start_date date,
    current_start_time time(0) without time zone,
    instructions character varying(40),
    collect_req_by character varying(10),
    prt_package_labels character varying(1),
    no_of_parcels integer,
    current_whs_phase_sort integer,
    current_controller character varying(10),
    current_action_by character varying(55),
    no_of_items integer,
    cut_cbl integer,
    trip_sheet integer,
    area_code character varying(4),
    route_no character varying(8),
    del_order integer
);



--
-- Name: wt20c_collection_req; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt20c_collection_req (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    doc_type character varying(3) NOT NULL,
    doc_no character varying(14) NOT NULL,
    dest_name character varying(40),
    dest_add_1 character varying(30),
    dest_add_2 character varying(30),
    dest_add_3 character varying(30),
    dest_add_4 character varying(30),
    instructions character varying(40),
    collect_req_by character varying(10)
);



--
-- Name: wt21_disp_dt; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt21_disp_dt (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    prod_code character varying(16) NOT NULL,
    desc_1 character varying(40),
    loc character varying(3),
    whs character varying(3),
    prt_ind character varying(1),
    due_qty numeric(11,3) DEFAULT 0,
    first_scan_qty numeric(11,3) DEFAULT 0,
    scan_qty numeric(11,3) DEFAULT 0,
    variance_qty numeric(11,3) DEFAULT 0,
    notes character varying(255)
);



--
-- Name: wt21s_disp_serial; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt21s_disp_serial (
    doc_type character varying(1) NOT NULL,
    doc_no character varying(11) NOT NULL,
    prod_code character varying(16) NOT NULL,
    serial_no character varying(25) NOT NULL,
    loc character varying(3),
    whs character varying(3),
    due_qty numeric(11,3) DEFAULT 0,
    first_scan_qty numeric(11,3) DEFAULT 0,
    scan_qty numeric(11,3) DEFAULT 0,
    variance_qty numeric(11,3) DEFAULT 0
);



--
-- Name: wt22_trip_sheet; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt22_trip_sheet (
    trip_sheet integer NOT NULL,
    driver_mass numeric(13,2),
    misc_mass numeric(13,2)
);



--
-- Name: wt30_phase_tran; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.wt30_phase_tran (
    loc character varying(3) NOT NULL,
    whs character varying(3) NOT NULL,
    doc_type character varying(3) NOT NULL,
    doc_no character varying(14) NOT NULL,
    row_id integer NOT NULL,
    status character varying(4),
    whs_phase_sort integer,
    start_date date,
    start_time time(0) without time zone,
    end_date date,
    end_time time without time zone,
    controller character varying(10),
    action_by character varying(10)
);



--
-- Name: xserver_info; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.xserver_info (
    server_attribute character(254) NOT NULL,
    attribute_value character(254)
);



--
-- Name: xsql_languages; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.xsql_languages (
    source character(254) NOT NULL,
    source_year character(254),
    conformance character(254),
    integrity character(254),
    implementation character(254),
    binding_style character(254),
    programming_lang character(254)
);



--
-- Name: z_conv_ev_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.z_conv_ev_codes (
    ev_code character varying(8) NOT NULL,
    ev_desc character varying(30),
    ics_code character varying(8),
    ev_loc character varying(3),
    ics_desc character varying(30),
    cr character varying(1)
);



--
-- Name: z_conv_vrm_codes; Type: TABLE; Schema: public; Owner: www-data
--

CREATE TABLE IF NOT EXISTS public.z_conv_vrm_codes (
    vrm_code character varying(16) NOT NULL,
    vrm_stk_grp character varying(18),
    vrm_desc character varying(35),
    vrm_uom character varying(5),
    vrm_cost numeric(13,2) DEFAULT 0,
    arb_code character varying(16),
    arb_desc character varying(35),
    arb_uom character varying(10),
    cr integer DEFAULT 0
);



--
-- Name: dc_ibt_distribution_test_20250718144006 _mb_row_id; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dc_ibt_distribution_test_20250718144006 ALTER COLUMN _mb_row_id SET DEFAULT nextval('public.dc_ibt_distribution_test_20250718144006__mb_row_id_seq'::regclass);


--
-- Name: px01_report_data recid; Type: DEFAULT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.px01_report_data ALTER COLUMN recid SET DEFAULT nextval('public.px01_report_data_recid_seq'::regclass);


--
-- Name: arb_dl01_pend_accts arb_dl01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_dl01_pend_accts
    ADD CONSTRAINT arb_dl01_pk PRIMARY KEY (dl_code);


--
-- Name: arb_ib32_pallet_hd arb_ib32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib32_pallet_hd
    ADD CONSTRAINT arb_ib32_pk PRIMARY KEY (wt_load_no);


--
-- Name: arb_ib32p_pallet_dt arb_ib32p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib32p_pallet_dt
    ADD CONSTRAINT arb_ib32p_pk PRIMARY KEY (wt_load_no, co_db_name, pallet_id);


--
-- Name: arb_ib33_prod_dt arb_ib33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib33_prod_dt
    ADD CONSTRAINT arb_ib33_pk PRIMARY KEY (wt_load_no, co_db_name, pallet_id, prod_code);


--
-- Name: arb_ib33s_prod_ser arb_ib33s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib33s_prod_ser
    ADD CONSTRAINT arb_ib33s_pk PRIMARY KEY (wt_load_no, co_db_name, pallet_id, prod_code, serial_no);


--
-- Name: arb_ib34_prod_adj_req arb_ib34_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib34_prod_adj_req
    ADD CONSTRAINT arb_ib34_pk PRIMARY KEY (wt_load_no, co_db_name, prod_code);


--
-- Name: arb_ib34s_serial_adj_req arb_ib34s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ib34s_serial_adj_req
    ADD CONSTRAINT arb_ib34s_pk PRIMARY KEY (wt_load_no, co_db_name, prod_code, serial_no);


--
-- Name: arb_ic_xref_dt arb_ic_xref_dt_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ic_xref_dt
    ADD CONSTRAINT arb_ic_xref_dt_pk PRIMARY KEY (sell_co_so, sell_co_inv, row_id);


--
-- Name: arb_ic_xref_hd arb_ic_xref_hd_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ic_xref_hd
    ADD CONSTRAINT arb_ic_xref_hd_pk PRIMARY KEY (sell_db, sell_co_so, sell_co_inv);


--
-- Name: arb_ic_xref_serial arb_ic_xref_serial_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_ic_xref_serial
    ADD CONSTRAINT arb_ic_xref_serial_pk PRIMARY KEY (sell_co_so, sell_co_inv, row_id, serial_row_id);


--
-- Name: arb_pu22a_status arb_pu22a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_pu22a_status
    ADD CONSTRAINT arb_pu22a_pk PRIMARY KEY (doc_no);


--
-- Name: arb_sa22_qt_hd arb_sa22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_sa22_qt_hd
    ADD CONSTRAINT arb_sa22_pk PRIMARY KEY (struct_no);


--
-- Name: arb_sa23_qt_dt arb_sa23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_sa23_qt_dt
    ADD CONSTRAINT arb_sa23_pk PRIMARY KEY (struct_no, row_id);


--
-- Name: arb_sa23b_qt_comp arb_sa23b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_sa23b_qt_comp
    ADD CONSTRAINT arb_sa23b_pk PRIMARY KEY (struct_no, sa23_arb_row_id, comp_row_id);


--
-- Name: arb_sa23d_so_split arb_sa23d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_sa23d_so_split
    ADD CONSTRAINT arb_sa23d_pk PRIMARY KEY (struct_no, split_row_id);


--
-- Name: arb_sa290_sales_anal arb_sa290_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.arb_sa290_sales_anal
    ADD CONSTRAINT arb_sa290_pk PRIMARY KEY (user_name, type, section, stk_grp, loc);


--
-- Name: bm00_sys_opt bm00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm00_sys_opt
    ADD CONSTRAINT bm00_pk PRIMARY KEY (row_id);


--
-- Name: bm01_doc_no bm01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm01_doc_no
    ADD CONSTRAINT bm01_pk PRIMARY KEY (loc);


--
-- Name: bm03_act_res bm03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm03_act_res
    ADD CONSTRAINT bm03_pk PRIMARY KEY (act_code, date);


--
-- Name: bm04_grp_type bm04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm04_grp_type
    ADD CONSTRAINT bm04_pk PRIMARY KEY (bom_type);


--
-- Name: bm06_grp bm06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm06_grp
    ADD CONSTRAINT bm06_pk PRIMARY KEY (bom_grp);


--
-- Name: bm08_sub_calc bm08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm08_sub_calc
    ADD CONSTRAINT bm08_pk PRIMARY KEY (sub_code);


--
-- Name: bm10_bom_hd bm10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm10_bom_hd
    ADD CONSTRAINT bm10_pk PRIMARY KEY (bom_stk_code);


--
-- Name: bm11_bom_comp bm11_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm11_bom_comp
    ADD CONSTRAINT bm11_pk PRIMARY KEY (bom_stk_code, row_id);


--
-- Name: bm11i_bom_inst bm11i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm11i_bom_inst
    ADD CONSTRAINT bm11i_pk PRIMARY KEY (bom_stk_code, row_id);


--
-- Name: bm20_rec_bt bm20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm20_rec_bt
    ADD CONSTRAINT bm20_pk PRIMARY KEY (period, batch_no, row_id, wo_no);


--
-- Name: bm20i_bin_alloc bm20i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm20i_bin_alloc
    ADD CONSTRAINT bm20i_pk PRIMARY KEY (wo_no, row_id, bin_row_id);


--
-- Name: bm21_iss_ret_bt bm21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm21_iss_ret_bt
    ADD CONSTRAINT bm21_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: bm21i_bin_alloc bm21i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm21i_bin_alloc
    ADD CONSTRAINT bm21i_pk PRIMARY KEY (batch_no, row_id, bin_row_id);


--
-- Name: bm21s_iss_ret_serial bm21s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm21s_iss_ret_serial
    ADD CONSTRAINT bm21s_pk PRIMARY KEY (period, batch_no, row_id, serial_row_id);


--
-- Name: bm22_prod_plan_hd bm22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm22_prod_plan_hd
    ADD CONSTRAINT bm22_pk PRIMARY KEY (batch_no);


--
-- Name: bm23_prod_plan_dt bm23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm23_prod_plan_dt
    ADD CONSTRAINT bm23_pk PRIMARY KEY (batch_no, stk_code, row_id);


--
-- Name: bm23fore_close_bal bm23fore_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm23fore_close_bal
    ADD CONSTRAINT bm23fore_pk PRIMARY KEY (batch_no, stk_code, loc, whs, bm23_row_id, month);


--
-- Name: bm23po_shortfall_hd bm23po_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm23po_shortfall_hd
    ADD CONSTRAINT bm23po_pk PRIMARY KEY (batch_no, cl_code, po_no);


--
-- Name: bm23r_shortfall_dt_raw bm23r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm23r_shortfall_dt_raw
    ADD CONSTRAINT bm23r_pk PRIMARY KEY (batch_no, sort_pos);


--
-- Name: bm23s_shortfall_dt bm23s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm23s_shortfall_dt
    ADD CONSTRAINT bm23s_pk PRIMARY KEY (batch_no, sort_pos);


--
-- Name: bm30_wo_hd bm30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm30_wo_hd
    ADD CONSTRAINT bm30_pk PRIMARY KEY (wo_no);


--
-- Name: bm31_wo_comp bm31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm31_wo_comp
    ADD CONSTRAINT bm31_pk PRIMARY KEY (wo_no, row_id);


--
-- Name: bm31i_wo_inst bm31i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm31i_wo_inst
    ADD CONSTRAINT bm31i_pk PRIMARY KEY (wo_no, row_id);


--
-- Name: bm32_wo_dn_hd bm32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm32_wo_dn_hd
    ADD CONSTRAINT bm32_pk PRIMARY KEY (bm30_wo_no, del_no);


--
-- Name: bm33_wo_dn_dt bm33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm33_wo_dn_dt
    ADD CONSTRAINT bm33_pk PRIMARY KEY (bm30_wo_no, del_no, row_id);


--
-- Name: bm35_act_average bm35_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm35_act_average
    ADD CONSTRAINT bm35_pk PRIMARY KEY (bom_stk_code, bm31_row_id, stk_code, wo_no);


--
-- Name: bm38_bottleneck_batch_hd bm38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm38_bottleneck_batch_hd
    ADD CONSTRAINT bm38_pk PRIMARY KEY (loc, whs, batch_no);


--
-- Name: bm39m_bottleneck_material bm39m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm39m_bottleneck_material
    ADD CONSTRAINT bm39m_pk PRIMARY KEY (loc, whs, batch_no, stk_code, row_id);


--
-- Name: bm39p_bottleneck_pri_wo bm39p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm39p_bottleneck_pri_wo
    ADD CONSTRAINT bm39p_pk PRIMARY KEY (loc, whs, batch_no, stk_code, row_id);


--
-- Name: bm39s_bottleneck_sub_wo bm39s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bm39s_bottleneck_sub_wo
    ADD CONSTRAINT bm39s_pk PRIMARY KEY (loc, whs, batch_no, stk_code, row_id);


--
-- Name: bo00_sys_opt bo00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bo00_sys_opt
    ADD CONSTRAINT bo00_pk PRIMARY KEY (period);


--
-- Name: bo01_mast bo01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bo01_mast
    ADD CONSTRAINT bo01_pk PRIMARY KEY (bo_code);


--
-- Name: bo10_ctrl_tot bo10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bo10_ctrl_tot
    ADD CONSTRAINT bo10_pk PRIMARY KEY (period, loc, whs);


--
-- Name: bo20_adj_bt bo20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bo20_adj_bt
    ADD CONSTRAINT bo20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: bo30_tran bo30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.bo30_tran
    ADD CONSTRAINT bo30_pk PRIMARY KEY (bo_code, row_id);


--
-- Name: cb00_sys_opt cb00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb00_sys_opt
    ADD CONSTRAINT cb00_pk PRIMARY KEY (period);


--
-- Name: cb00gl_sys_opt cb00gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb00gl_sys_opt
    ADD CONSTRAINT cb00gl_pk PRIMARY KEY (bank_type, gl_bank);


--
-- Name: cb01_benef_mast cb01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb01_benef_mast
    ADD CONSTRAINT cb01_pk PRIMARY KEY (beneficiary_code);


--
-- Name: cb05_bank_stmt_layout cb05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb05_bank_stmt_layout
    ADD CONSTRAINT cb05_pk PRIMARY KEY (bank_code);


--
-- Name: cb05s_bank_tran_type cb05s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb05s_bank_tran_type
    ADD CONSTRAINT cb05s_pk PRIMARY KEY (bank_code, bank_type);


--
-- Name: cb10_ctrl_tot cb10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb10_ctrl_tot
    ADD CONSTRAINT cb10_pk PRIMARY KEY (bank_acct, period);


--
-- Name: cb20_jnl_bt cb20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb20_jnl_bt
    ADD CONSTRAINT cb20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: cb20gl_jnl_bt cb20gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb20gl_jnl_bt
    ADD CONSTRAINT cb20gl_pk PRIMARY KEY (period, batch_no, cb20_row_id, gl_row_id);


--
-- Name: cb29_in_tray cb29_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb29_in_tray
    ADD CONSTRAINT cb29_pk PRIMARY KEY (period, bank_acct, source, row_id);


--
-- Name: cb30_tran cb30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb30_tran
    ADD CONSTRAINT cb30_pk PRIMARY KEY (bank_acct, period, row_id);


--
-- Name: cb40_statement_import cb40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb40_statement_import
    ADD CONSTRAINT cb40_pk PRIMARY KEY (bank_code, bank_acct, period, row_id, status, page_no, tran_date, ref_1, ref_2, amount, balance);


--
-- Name: cb40a_arb_statement_import cb40a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb40a_arb_statement_import
    ADD CONSTRAINT cb40a_pk PRIMARY KEY (bank_code, bank_acct, period, row_id, status, page_no, tran_date, ref_1, ref_2, amount, balance);


--
-- Name: cb41_statement_import_acct cb41_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb41_statement_import_acct
    ADD CONSTRAINT cb41_pk PRIMARY KEY (bank_acct, cb40_row_id, row_id, tagged_acct_code);


--
-- Name: cb42_auto_tag_match_log cb42_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cb42_auto_tag_match_log
    ADD CONSTRAINT cb42_pk PRIMARY KEY (bank_code, bank_acct, period, cb40_row_id, row_id, status, page_no, tran_date, ref_1, ref_2, amount, balance);


--
-- Name: cfs_bo00_auto_code cfs_bo00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cfs_bo00_auto_code
    ADD CONSTRAINT cfs_bo00_pk PRIMARY KEY (last_buyout_no);


--
-- Name: cl00_sys_opt cl00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl00_sys_opt
    ADD CONSTRAINT cl00_pk PRIMARY KEY (period);


--
-- Name: cl01_mast cl01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01_mast
    ADD CONSTRAINT cl01_pk PRIMARY KEY (cl_code);


--
-- Name: cl01a_actions cl01a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01a_actions
    ADD CONSTRAINT cl01a_pk PRIMARY KEY (cl_code, call_date, call_time);


--
-- Name: cl01c_contact cl01c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01c_contact
    ADD CONSTRAINT cl01c_pk PRIMARY KEY (cl_code, row_id);


--
-- Name: cl01n_notes cl01n_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01n_notes
    ADD CONSTRAINT cl01n_pk PRIMARY KEY (cl_code);


--
-- Name: cl01p_per_tot cl01p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01p_per_tot
    ADD CONSTRAINT cl01p_pk PRIMARY KEY (cl_code, period);


--
-- Name: cl01r_supp_rebate cl01r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01r_supp_rebate
    ADD CONSTRAINT cl01r_pk PRIMARY KEY (cl_code, stk_grp, rebate_type, rebate_calc);


--
-- Name: cl01sc_sub_cat cl01sc_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl01sc_sub_cat
    ADD CONSTRAINT cl01sc_pk PRIMARY KEY (cl_code, cl_sub_cat);


--
-- Name: cl06_cat_mast cl06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl06_cat_mast
    ADD CONSTRAINT cl06_pk PRIMARY KEY (cl_cat);


--
-- Name: cl10_ctrl_tot cl10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl10_ctrl_tot
    ADD CONSTRAINT cl10_pk PRIMARY KEY (period);


--
-- Name: cl20_jnl_bt cl20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl20_jnl_bt
    ADD CONSTRAINT cl20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: cl20gl_jnl_bt cl20gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl20gl_jnl_bt
    ADD CONSTRAINT cl20gl_pk PRIMARY KEY (period, batch_no, cl20_row_id, gl_row_id);


--
-- Name: cl22_pay_bt cl22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl22_pay_bt
    ADD CONSTRAINT cl22_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: cl22m_tr_match cl22m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl22m_tr_match
    ADD CONSTRAINT cl22m_pk PRIMARY KEY (period, batch_no, cl22_row_id, match_row_id);


--
-- Name: cl30_tran cl30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl30_tran
    ADD CONSTRAINT cl30_pk PRIMARY KEY (cl_code, row_id);


--
-- Name: cl31_matched_hist cl31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl31_matched_hist
    ADD CONSTRAINT cl31_pk PRIMARY KEY (cl_code, parent_row_id, match_row_id, row_id);


--
-- Name: cl32_unmatch_hist cl32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl32_unmatch_hist
    ADD CONSTRAINT cl32_pk PRIMARY KEY (unmatch_period, unmatch_batch_no, cl_code, row_id);


--
-- Name: cl33_recon_tran cl33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl33_recon_tran
    ADD CONSTRAINT cl33_pk PRIMARY KEY (cl_code, row_id);


--
-- Name: cl34_deal_sheet cl34_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl34_deal_sheet
    ADD CONSTRAINT cl34_pk PRIMARY KEY (deal_detail_id);


--
-- Name: cl34b_branch_loc cl34b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl34b_branch_loc
    ADD CONSTRAINT cl34b_pk PRIMARY KEY (deal_detail_id, row_id);


--
-- Name: cl34l_linked_codes cl34l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl34l_linked_codes
    ADD CONSTRAINT cl34l_pk PRIMARY KEY (deal_detail_id, row_id);


--
-- Name: cl35_supplier_rebates cl35_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl35_supplier_rebates
    ADD CONSTRAINT cl35_pk PRIMARY KEY (rebate_code);


--
-- Name: cl36_supplier_rebates_dt cl36_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl36_supplier_rebates_dt
    ADD CONSTRAINT cl36_pk PRIMARY KEY (rebate_code, cl_code);


--
-- Name: cl37_rebate_register cl37_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl37_rebate_register
    ADD CONSTRAINT cl37_pk PRIMARY KEY (rebate_code, po_no, register_date, register_time);


--
-- Name: cl38_deal_register cl38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl38_deal_register
    ADD CONSTRAINT cl38_pk PRIMARY KEY (tally_no);


--
-- Name: cl40_recon_hist_hd cl40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl40_recon_hist_hd
    ADD CONSTRAINT cl40_pk PRIMARY KEY (period, cl_code);


--
-- Name: cl41_recon_hist_dt cl41_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.cl41_recon_hist_dt
    ADD CONSTRAINT cl41_pk PRIMARY KEY (period, cl_code, grp_no, row_id);


--
-- Name: dc_ibt_distribution_test_20250718144006 dc_ibt_distribution_test_20250718144006_pkey; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dc_ibt_distribution_test_20250718144006
    ADD CONSTRAINT dc_ibt_distribution_test_20250718144006_pkey PRIMARY KEY (_mb_row_id);


--
-- Name: dd01_tbl dd01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dd01_tbl
    ADD CONSTRAINT dd01_pk PRIMARY KEY (tbl_name);


--
-- Name: dd02_col dd02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dd02_col
    ADD CONSTRAINT dd02_pk PRIMARY KEY (tbl_name, col_seq);


--
-- Name: dd03_idx dd03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dd03_idx
    ADD CONSTRAINT dd03_pk PRIMARY KEY (tbl_name, idx_name);


--
-- Name: dd04_user dd04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dd04_user
    ADD CONSTRAINT dd04_pk PRIMARY KEY (user_name);


--
-- Name: dev_todos dev_todos_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dev_todos
    ADD CONSTRAINT dev_todos_pk PRIMARY KEY (user_name);


--
-- Name: dl00_sys_opt dl00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl00_sys_opt
    ADD CONSTRAINT dl00_pk PRIMARY KEY (period);


--
-- Name: dl01_mast dl01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01_mast
    ADD CONSTRAINT dl01_pk PRIMARY KEY (dl_code);


--
-- Name: dl01a_actions dl01a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01a_actions
    ADD CONSTRAINT dl01a_pk PRIMARY KEY (dl_code, call_date, call_time);


--
-- Name: dl01c_contact dl01c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01c_contact
    ADD CONSTRAINT dl01c_pk PRIMARY KEY (dl_code, row_id);


--
-- Name: dl01d_deb_stk_grp_disc dl01d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01d_deb_stk_grp_disc
    ADD CONSTRAINT dl01d_pk PRIMARY KEY (dl_code, disc_type, disc_code);


--
-- Name: dl01n_notes dl01n_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01n_notes
    ADD CONSTRAINT dl01n_pk PRIMARY KEY (dl_code);


--
-- Name: dl01p_per_tot dl01p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01p_per_tot
    ADD CONSTRAINT dl01p_pk PRIMARY KEY (dl_code, period);


--
-- Name: dl01pa_per_tot dl01pa_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01pa_per_tot
    ADD CONSTRAINT dl01pa_pk PRIMARY KEY (dl_code, period);


--
-- Name: dl01sc_sub_cat_mast dl01sc_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl01sc_sub_cat_mast
    ADD CONSTRAINT dl01sc_pk PRIMARY KEY (dl_code, dl_sub_cat);


--
-- Name: dl02_loyalty_mast dl02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl02_loyalty_mast
    ADD CONSTRAINT dl02_pk PRIMARY KEY (cell_no);


--
-- Name: dl04_cat_mast dl04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl04_cat_mast
    ADD CONSTRAINT dl04_pk PRIMARY KEY (dl_cat);


--
-- Name: dl04d_cat_stk_grp_disc dl04d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl04d_cat_stk_grp_disc
    ADD CONSTRAINT dl04d_pk PRIMARY KEY (dl_cat, disc_type, disc_code);


--
-- Name: dl05_class_mast dl05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl05_class_mast
    ADD CONSTRAINT dl05_pk PRIMARY KEY (class);


--
-- Name: dl06m_mkt_rep_per_tot dl06m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl06m_mkt_rep_per_tot
    ADD CONSTRAINT dl06m_pk PRIMARY KEY (mkt_rep, period);


--
-- Name: dl06p_rep_per_tot dl06p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl06p_rep_per_tot
    ADD CONSTRAINT dl06p_pk PRIMARY KEY (rep_code, period);


--
-- Name: dl07o_opr_per_tot dl07o_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl07o_opr_per_tot
    ADD CONSTRAINT dl07o_pk PRIMARY KEY (user_name, period);


--
-- Name: dl10_ctrl_tot dl10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl10_ctrl_tot
    ADD CONSTRAINT dl10_pk PRIMARY KEY (period);


--
-- Name: dl20_jnl_bt dl20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl20_jnl_bt
    ADD CONSTRAINT dl20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: dl20gl_jnl_bt dl20gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl20gl_jnl_bt
    ADD CONSTRAINT dl20gl_pk PRIMARY KEY (period, batch_no, dl20_row_id, gl_row_id);


--
-- Name: dl22_rec_bt dl22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl22_rec_bt
    ADD CONSTRAINT dl22_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: dl22m_tr_match dl22m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl22m_tr_match
    ADD CONSTRAINT dl22m_pk PRIMARY KEY (period, batch_no, dl22_row_id, match_row_id);


--
-- Name: dl30_tran dl30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl30_tran
    ADD CONSTRAINT dl30_pk PRIMARY KEY (dl_code, row_id);


--
-- Name: dl31_matched_hist dl31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl31_matched_hist
    ADD CONSTRAINT dl31_pk PRIMARY KEY (dl_code, parent_row_id, match_row_id, row_id);


--
-- Name: dl32_unmatch_hist dl32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl32_unmatch_hist
    ADD CONSTRAINT dl32_pk PRIMARY KEY (unmatch_period, unmatch_batch_no, dl_code, row_id);


--
-- Name: dl33_deposits dl33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl33_deposits
    ADD CONSTRAINT dl33_pk PRIMARY KEY (dl_code, batch_no, dl30_row_id, deposit_qt_no, qt_revision_no);


--
-- Name: dl40_stmt_hist_hd dl40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl40_stmt_hist_hd
    ADD CONSTRAINT dl40_pk PRIMARY KEY (period, stmt_status, dl_code);


--
-- Name: dl41_stmt_dt dl41_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dl41_stmt_dt
    ADD CONSTRAINT dl41_pk PRIMARY KEY (period, stmt_status, dl_code, row_id);


--
-- Name: dx01d_db_mast dx01d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dx01d_db_mast
    ADD CONSTRAINT dx01d_pk PRIMARY KEY (server, db);


--
-- Name: dx01s_server_mast dx01s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dx01s_server_mast
    ADD CONSTRAINT dx01s_pk PRIMARY KEY (server);


--
-- Name: dx02_mobile_users dx02_mob_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.dx02_mobile_users
    ADD CONSTRAINT dx02_mob_pk PRIMARY KEY (user_name, company_db_name);


--
-- Name: gl00_sys_opt gl00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl00_sys_opt
    ADD CONSTRAINT gl00_pk PRIMARY KEY (period);


--
-- Name: gl01_mast gl01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl01_mast
    ADD CONSTRAINT gl01_pk PRIMARY KEY (gl_code);


--
-- Name: gl02_loc_mast gl02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl02_loc_mast
    ADD CONSTRAINT gl02_pk PRIMARY KEY (loc, whs);


--
-- Name: gl02wt_module gl02wt_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl02wt_module
    ADD CONSTRAINT gl02wt_pk PRIMARY KEY (loc, whs, dispatch_receiving, module);


--
-- Name: gl03f_fiscal_bal gl03f_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl03f_fiscal_bal
    ADD CONSTRAINT gl03f_pk PRIMARY KEY (gl_code, loc, year);


--
-- Name: gl03p_per_tot gl03p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl03p_per_tot
    ADD CONSTRAINT gl03p_pk PRIMARY KEY (gl_code, loc, period);


--
-- Name: gl05_report_notes gl05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl05_report_notes
    ADD CONSTRAINT gl05_pk PRIMARY KEY (note_no);


--
-- Name: gl06_report_title gl06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl06_report_title
    ADD CONSTRAINT gl06_pk PRIMARY KEY (title_code);


--
-- Name: gl07_report_hd gl07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl07_report_hd
    ADD CONSTRAINT gl07_pk PRIMARY KEY (report_code);


--
-- Name: gl08_report_col gl08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl08_report_col
    ADD CONSTRAINT gl08_pk PRIMARY KEY (report_code, row_id);


--
-- Name: gl09_report_lines gl09_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl09_report_lines
    ADD CONSTRAINT gl09_pk PRIMARY KEY (report_code, row_id);


--
-- Name: gl10_import_layout gl10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl10_import_layout
    ADD CONSTRAINT gl10_pk PRIMARY KEY (layout_code);


--
-- Name: gl10c_company_type gl10c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl10c_company_type
    ADD CONSTRAINT gl10c_pk PRIMARY KEY (layout_code, import_company);


--
-- Name: gl10l_loc_type gl10l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl10l_loc_type
    ADD CONSTRAINT gl10l_pk PRIMARY KEY (layout_code, import_loc);


--
-- Name: gl12_map_alloc_mast gl12_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl12_map_alloc_mast
    ADD CONSTRAINT gl12_pk PRIMARY KEY (type, gl_code, row_id);


--
-- Name: gl20_jnl_bt gl20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl20_jnl_bt
    ADD CONSTRAINT gl20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: gl29_in_tray gl29_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl29_in_tray
    ADD CONSTRAINT gl29_pk PRIMARY KEY (period, gl_code, source, row_id);


--
-- Name: gl30_tran gl30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.gl30_tran
    ADD CONSTRAINT gl30_pk PRIMARY KEY (gl_code, row_id);


--
-- Name: ha_st01l_label ha_st01l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ha_st01l_label
    ADD CONSTRAINT ha_st01l_pk PRIMARY KEY (stk_code);


--
-- Name: ib00_sys_opt ib00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib00_sys_opt
    ADD CONSTRAINT ib00_pk PRIMARY KEY (row_id);


--
-- Name: ib01_doc_no ib01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib01_doc_no
    ADD CONSTRAINT ib01_pk PRIMARY KEY (loc);


--
-- Name: ib20_req_hd ib20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib20_req_hd
    ADD CONSTRAINT ib20_pk PRIMARY KEY (req_no);


--
-- Name: ib21_req_dt ib21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib21_req_dt
    ADD CONSTRAINT ib21_pk PRIMARY KEY (req_no, row_id);


--
-- Name: ib24_ib_hd ib24_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib24_ib_hd
    ADD CONSTRAINT ib24_pk PRIMARY KEY (ibt_no);


--
-- Name: ib25_ib_dt ib25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib25_ib_dt
    ADD CONSTRAINT ib25_pk PRIMARY KEY (ibt_no, row_id);


--
-- Name: ib25i_bin_alloc ib25i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib25i_bin_alloc
    ADD CONSTRAINT ib25i_pk PRIMARY KEY (ibt_no, ib25_row_id, bin_row_id);


--
-- Name: ib25s_ib_serial ib25s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib25s_ib_serial
    ADD CONSTRAINT ib25s_pk PRIMARY KEY (ibt_no, ib25_row_id, serial_row_id);


--
-- Name: ib30_ship_doc_hd ib30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib30_ship_doc_hd
    ADD CONSTRAINT ib30_pk PRIMARY KEY (ibt_no, ship_doc_no);


--
-- Name: ib31_ship_doc_dt ib31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib31_ship_doc_dt
    ADD CONSTRAINT ib31_pk PRIMARY KEY (ibt_no, ship_doc_no, ib25_row_id);


--
-- Name: ib31i_bin_alloc ib31i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib31i_bin_alloc
    ADD CONSTRAINT ib31i_pk PRIMARY KEY (ibt_no, ship_doc_no, rec_loc, rec_whs, ibt_ship_rec, row_id, bin_row_id);


--
-- Name: ib31p_ship_pallet ib31p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib31p_ship_pallet
    ADD CONSTRAINT ib31p_pk PRIMARY KEY (wt_load_no, ibt_no, ship_doc_no, ib31_row_id, wt_pallet_id, wt_container_id);


--
-- Name: ib31s_ship_serial ib31s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ib31s_ship_serial
    ADD CONSTRAINT ib31s_pk PRIMARY KEY (ibt_no, ship_doc_no, ib25_row_id, serial_row_id);


--
-- Name: it_sa06_mth_inv_hd it_sa06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.it_sa06_mth_inv_hd
    ADD CONSTRAINT it_sa06_pk PRIMARY KEY (dl_code, dl_ref);


--
-- Name: it_sa07_mth_inv_dt it_sa07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.it_sa07_mth_inv_dt
    ADD CONSTRAINT it_sa07_pk PRIMARY KEY (dl_code, dl_ref, row_id);


--
-- Name: it_sa08_mth_grn it_sa08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.it_sa08_mth_grn
    ADD CONSTRAINT it_sa08_pk PRIMARY KEY (period, cl_code, cl_ref, dl_code, dl_ref, sa07_row_id, grn_row_id);


--
-- Name: ita01_asset ita01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ita01_asset
    ADD CONSTRAINT ita01_pk PRIMARY KEY (asset_no);


--
-- Name: ita02_users ita02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ita02_users
    ADD CONSTRAINT ita02_pk PRIMARY KEY (username);


--
-- Name: ita03_log ita03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ita03_log
    ADD CONSTRAINT ita03_pk PRIMARY KEY (log_no);


--
-- Name: ita04_hdrive ita04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.ita04_hdrive
    ADD CONSTRAINT ita04_pk PRIMARY KEY (ser_no);


--
-- Name: jc00_sys_opt_old jc00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc00_sys_opt_old
    ADD CONSTRAINT jc00_pk PRIMARY KEY (row_id);


--
-- Name: jc01_doc_no jc01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc01_doc_no
    ADD CONSTRAINT jc01_pk PRIMARY KEY (loc);


--
-- Name: jc20_est_hd jc20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc20_est_hd
    ADD CONSTRAINT jc20_pk PRIMARY KEY (est_no);


--
-- Name: jc21_est_dt jc21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc21_est_dt
    ADD CONSTRAINT jc21_pk PRIMARY KEY (est_no, row_id);


--
-- Name: jc21b_est_bom jc21b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc21b_est_bom
    ADD CONSTRAINT jc21b_pk PRIMARY KEY (est_no, row_id, comp_row_id);


--
-- Name: jc24_jc_hd jc24_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc24_jc_hd
    ADD CONSTRAINT jc24_pk PRIMARY KEY (job_no);


--
-- Name: jc25_jc_dt jc25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc25_jc_dt
    ADD CONSTRAINT jc25_pk PRIMARY KEY (job_no, row_id);


--
-- Name: jc25b_jc_bom jc25b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc25b_jc_bom
    ADD CONSTRAINT jc25b_pk PRIMARY KEY (job_no, row_id, comp_row_id);


--
-- Name: jc26_shortfall_hd jc26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc26_shortfall_hd
    ADD CONSTRAINT jc26_pk PRIMARY KEY (batch_no);


--
-- Name: jc27_shortfall_dt jc27_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc27_shortfall_dt
    ADD CONSTRAINT jc27_pk PRIMARY KEY (batch_no, jc25_row_id, master_row_id, comp_row_id);


--
-- Name: jc27r_shortfall_raw jc27r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc27r_shortfall_raw
    ADD CONSTRAINT jc27r_pk PRIMARY KEY (batch_no, sort_pos);


--
-- Name: jc28_itp_hd jc28_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc28_itp_hd
    ADD CONSTRAINT jc28_pk PRIMARY KEY (itp_no);


--
-- Name: jc29_ipt_dt jc29_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc29_ipt_dt
    ADD CONSTRAINT jc29_pk PRIMARY KEY (itp_no, row_id, comp_row_id);


--
-- Name: jc29i_bin_alloc jc29i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc29i_bin_alloc
    ADD CONSTRAINT jc29i_pk PRIMARY KEY (itp_no, jc29_row_id, bin_row_id);


--
-- Name: jc29s_itp_serial jc29s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc29s_itp_serial
    ADD CONSTRAINT jc29s_pk PRIMARY KEY (itp_no, jc29_row_id, serial_row_id);


--
-- Name: jc30_ship_doc_hd jc30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc30_ship_doc_hd
    ADD CONSTRAINT jc30_pk PRIMARY KEY (itp_no, ship_doc_no);


--
-- Name: jc31_ship_doc_dt jc31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc31_ship_doc_dt
    ADD CONSTRAINT jc31_pk PRIMARY KEY (itp_no, ship_doc_no, jc29_row_id, comp_row_id);


--
-- Name: jc31s_ship_serial jc31s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc31s_ship_serial
    ADD CONSTRAINT jc31s_pk PRIMARY KEY (itp_no, ship_doc_no, jc29_row_id, serial_row_id);


--
-- Name: jc32_claims_hd jc32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc32_claims_hd
    ADD CONSTRAINT jc32_pk PRIMARY KEY (claim_no, job_no);


--
-- Name: jc33_claims_dt jc33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.jc33_claims_dt
    ADD CONSTRAINT jc33_pk PRIMARY KEY (claim_no, job_no, row_id, comp_row_id);


--
-- Name: kf_jc20_est_hd kf_jc20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc20_est_hd
    ADD CONSTRAINT kf_jc20_pk PRIMARY KEY (est_no);


--
-- Name: kf_jc21_est_dt kf_jc21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc21_est_dt
    ADD CONSTRAINT kf_jc21_pk PRIMARY KEY (est_no, row_id);


--
-- Name: kf_jc21b_est_bom kf_jc21b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc21b_est_bom
    ADD CONSTRAINT kf_jc21b_pk PRIMARY KEY (est_no, row_id, comp_row_id);


--
-- Name: kf_jc24_jc_hd kf_jc24_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc24_jc_hd
    ADD CONSTRAINT kf_jc24_pk PRIMARY KEY (job_no);


--
-- Name: kf_jc25_jc_dt kf_jc25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc25_jc_dt
    ADD CONSTRAINT kf_jc25_pk PRIMARY KEY (job_no, row_id);


--
-- Name: kf_jc25b_jc_bom kf_jc25b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc25b_jc_bom
    ADD CONSTRAINT kf_jc25b_pk PRIMARY KEY (job_no, row_id, comp_row_id);


--
-- Name: kf_jc26_shortfall_po_hd kf_jc26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc26_shortfall_po_hd
    ADD CONSTRAINT kf_jc26_pk PRIMARY KEY (job_no, cl_code, po_no);


--
-- Name: kf_jc27_shortfall_dt kf_jc27_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc27_shortfall_dt
    ADD CONSTRAINT kf_jc27_pk PRIMARY KEY (job_no, sort_pos);


--
-- Name: kf_jc27r_shortfall_raw kf_jc27r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc27r_shortfall_raw
    ADD CONSTRAINT kf_jc27r_pk PRIMARY KEY (job_no, sort_pos);


--
-- Name: kf_jc37_jc_dn_hd kf_jc37_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc37_jc_dn_hd
    ADD CONSTRAINT kf_jc37_pk PRIMARY KEY (jc24_job_no, del_no);


--
-- Name: kf_jc38_jc_dn_dt kf_jc38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.kf_jc38_jc_dn_dt
    ADD CONSTRAINT kf_jc38_pk PRIMARY KEY (jc24_job_no, del_no, row_id);


--
-- Name: lpf_bm30_wo_hd lpf_bm30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.lpf_bm30_wo_hd
    ADD CONSTRAINT lpf_bm30_pk PRIMARY KEY (wo_no);


--
-- Name: lpf_bm31_wo_dt lpf_bm31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.lpf_bm31_wo_dt
    ADD CONSTRAINT lpf_bm31_pk PRIMARY KEY (wo_no, row_id);


--
-- Name: lpf_sa22_qt_hd lpf_sa22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.lpf_sa22_qt_hd
    ADD CONSTRAINT lpf_sa22_pk PRIMARY KEY (doc_no, loc, whs);


--
-- Name: lpf_sa23_qt_dt lpf_sa23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.lpf_sa23_qt_dt
    ADD CONSTRAINT lpf_sa23_pk PRIMARY KEY (doc_no, row_id);


--
-- Name: lpf_st01_mat_mast lpf_st01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.lpf_st01_mat_mast
    ADD CONSTRAINT lpf_st01_pk PRIMARY KEY (material_code);


--
-- Name: pos00_till_profile pos00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos00_till_profile
    ADD CONSTRAINT pos00_pk PRIMARY KEY (till_user_name);


--
-- Name: pos01_linked_users pos01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos01_linked_users
    ADD CONSTRAINT pos01_pk PRIMARY KEY (till_user_name, user_name);


--
-- Name: pos02_cashup pos02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos02_cashup
    ADD CONSTRAINT pos02_pk PRIMARY KEY (till_user_name, user_name, period, batch_no, row_id);


--
-- Name: pos03_cashup_corrections pos03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos03_cashup_corrections
    ADD CONSTRAINT pos03_pk PRIMARY KEY (batch_no, sort_pos);


--
-- Name: pos04_cash_drop pos04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos04_cash_drop
    ADD CONSTRAINT pos04_pk PRIMARY KEY (till_user_name, user_name, period, batch_no, cash_drop_date, cash_drop_time);


--
-- Name: pos05_cash_drop_maint pos05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos05_cash_drop_maint
    ADD CONSTRAINT pos05_pk PRIMARY KEY (reason_code);


--
-- Name: pos06_merchant_id pos06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos06_merchant_id
    ADD CONSTRAINT pos06_pk PRIMARY KEY (loc);


--
-- Name: pos07_card_maint pos07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos07_card_maint
    ADD CONSTRAINT pos07_pk PRIMARY KEY (ip_address, terminal_id);


--
-- Name: pos20_pos_expenses pos20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos20_pos_expenses
    ADD CONSTRAINT pos20_pk PRIMARY KEY (batch_no, row_id);


--
-- Name: pos20gl_expenses_bt pos20gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos20gl_expenses_bt
    ADD CONSTRAINT pos20gl_pk PRIMARY KEY (batch_no, pos20_row_id, gl_row_id);


--
-- Name: pos21_pos_controller_hd pos21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos21_pos_controller_hd
    ADD CONSTRAINT pos21_pk PRIMARY KEY (loc, cashup_date, branch_status);


--
-- Name: pos22_shortage_ctrl pos22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos22_shortage_ctrl
    ADD CONSTRAINT pos22_pk PRIMARY KEY (loc, row_id, cash_up_date, user_name);


--
-- Name: pos30_card_tran pos30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pos30_card_tran
    ADD CONSTRAINT pos30_pk PRIMARY KEY (doc_no, tran_date, tran_time);


--
-- Name: pu00_sys_opt pu00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu00_sys_opt
    ADD CONSTRAINT pu00_pk PRIMARY KEY (period);


--
-- Name: pu01_doc_no pu01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu01_doc_no
    ADD CONSTRAINT pu01_pk PRIMARY KEY (loc);


--
-- Name: pu10_ctrl_tot pu10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu10_ctrl_tot
    ADD CONSTRAINT pu10_pk PRIMARY KEY (period, loc, whs);


--
-- Name: pu22_po_hd pu22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu22_po_hd
    ADD CONSTRAINT pu22_pk PRIMARY KEY (doc_type, doc_no);


--
-- Name: pu23_po_dt pu23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23_po_dt
    ADD CONSTRAINT pu23_pk PRIMARY KEY (doc_type, doc_no, row_id, comp_row_id);


--
-- Name: pu23d_po_split pu23d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23d_po_split
    ADD CONSTRAINT pu23d_pk PRIMARY KEY (doc_type, doc_no, row_id, split_row_id);


--
-- Name: pu23ds_deals pu23ds_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23ds_deals
    ADD CONSTRAINT pu23ds_pk PRIMARY KEY (doc_type, doc_no, row_id, deal_detail_id);


--
-- Name: pu23i_bin_alloc pu23i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23i_bin_alloc
    ADD CONSTRAINT pu23i_pk PRIMARY KEY (doc_no, row_id, bin_row_id);


--
-- Name: pu23ic_import_costs pu23ic_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23ic_import_costs
    ADD CONSTRAINT pu23ic_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: pu23r_rebates pu23r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23r_rebates
    ADD CONSTRAINT pu23r_pk PRIMARY KEY (doc_type, doc_no, row_id, rebate_code);


--
-- Name: pu23s_serial pu23s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23s_serial
    ADD CONSTRAINT pu23s_pk PRIMARY KEY (doc_no, row_id, serial_row_id);


--
-- Name: pu23t_tally pu23t_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu23t_tally
    ADD CONSTRAINT pu23t_pk PRIMARY KEY (tally_no, doc_no, pu23_row_id, tally_type);


--
-- Name: pu25_grn_hd pu25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu25_grn_hd
    ADD CONSTRAINT pu25_pk PRIMARY KEY (doc_no);


--
-- Name: pu26_grn_dt pu26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu26_grn_dt
    ADD CONSTRAINT pu26_pk PRIMARY KEY (doc_no, row_id, comp_row_id);


--
-- Name: pu26i_bin_alloc pu26i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu26i_bin_alloc
    ADD CONSTRAINT pu26i_pk PRIMARY KEY (doc_no, row_id, bin_row_id);


--
-- Name: pu26ic_import_costs pu26ic_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu26ic_import_costs
    ADD CONSTRAINT pu26ic_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: pu26s_grn_serial pu26s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu26s_grn_serial
    ADD CONSTRAINT pu26s_pk PRIMARY KEY (doc_no, row_id, serial_row_id);


--
-- Name: pu26t_tally pu26t_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.pu26t_tally
    ADD CONSTRAINT pu26t_pk PRIMARY KEY (tally_no, doc_no, pu26_row_id, tally_type);


--
-- Name: px01_report_data px01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.px01_report_data
    ADD CONSTRAINT px01_pk PRIMARY KEY (recid, loc);


--
-- Name: px02_sip_buddies px02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.px02_sip_buddies
    ADD CONSTRAINT px02_pk PRIMARY KEY (loc, ext);


--
-- Name: px03_rates px03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.px03_rates
    ADD CONSTRAINT px03_pk PRIMARY KEY (call_type);


--
-- Name: sa00_sys_opt sa00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa00_sys_opt
    ADD CONSTRAINT sa00_pk PRIMARY KEY (period);


--
-- Name: sa01_doc_no sa01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa01_doc_no
    ADD CONSTRAINT sa01_pk PRIMARY KEY (loc);


--
-- Name: sa02_quote_terms sa02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa02_quote_terms
    ADD CONSTRAINT sa02_pk PRIMARY KEY (terms_code);


--
-- Name: sa03_qt_reasons sa03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa03_qt_reasons
    ADD CONSTRAINT sa03_pk PRIMARY KEY (reason_code);


--
-- Name: sa04_qt_availability sa04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa04_qt_availability
    ADD CONSTRAINT sa04_pk PRIMARY KEY (avail_code);


--
-- Name: sa05_cnote_reasons sa05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa05_cnote_reasons
    ADD CONSTRAINT sa05_pk PRIMARY KEY (reason_id);


--
-- Name: sa10_ctrl_tot sa10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa10_ctrl_tot
    ADD CONSTRAINT sa10_pk PRIMARY KEY (period, loc, whs);


--
-- Name: sa20_ic_sales_links sa20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa20_ic_sales_links
    ADD CONSTRAINT sa20_pk PRIMARY KEY (stk_co_db, sell_co_db);


--
-- Name: sa22_qt_so_hd_arch sa22_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa22_qt_so_hd_arch
    ADD CONSTRAINT sa22_arch_pk PRIMARY KEY (doc_type, doc_no, qt_revision_no);


--
-- Name: sa22_qt_so_hd sa22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa22_qt_so_hd
    ADD CONSTRAINT sa22_pk PRIMARY KEY (doc_type, doc_no, qt_revision_no);


--
-- Name: sa22a_qt_action_arch sa22a_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa22a_qt_action_arch
    ADD CONSTRAINT sa22a_arch_pk PRIMARY KEY (doc_no, qt_revision_no, call_date, call_time);


--
-- Name: sa22a_qt_action sa22a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa22a_qt_action
    ADD CONSTRAINT sa22a_pk PRIMARY KEY (doc_no, qt_revision_no, call_date, call_time);


--
-- Name: sa23_qt_so_dt_arch sa23_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23_qt_so_dt_arch
    ADD CONSTRAINT sa23_arch_pk PRIMARY KEY (doc_type, doc_no, qt_revision_no, row_id);


--
-- Name: sa23_qt_so_dt sa23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23_qt_so_dt
    ADD CONSTRAINT sa23_pk PRIMARY KEY (doc_type, doc_no, qt_revision_no, row_id);


--
-- Name: sa23a_reason_code sa23a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23a_reason_code
    ADD CONSTRAINT sa23a_pk PRIMARY KEY (doc_no, doc_type, qt_revision_no, sa23_row_id, row_id);


--
-- Name: sa23d_so_split_arch sa23d_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23d_so_split_arch
    ADD CONSTRAINT sa23d_arch_pk PRIMARY KEY (doc_no, row_id, split_row_id);


--
-- Name: sa23d_so_split sa23d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23d_so_split
    ADD CONSTRAINT sa23d_pk PRIMARY KEY (doc_no, row_id, split_row_id);


--
-- Name: sa23m_qt_comp_arch sa23m_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23m_qt_comp_arch
    ADD CONSTRAINT sa23m_arch_pk PRIMARY KEY (struct_no, qt_revision_no, sa23_row_id, comp_row_id);


--
-- Name: sa23m_qt_comp sa23m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23m_qt_comp
    ADD CONSTRAINT sa23m_pk PRIMARY KEY (struct_no, qt_revision_no, sa23_row_id, comp_row_id);


--
-- Name: sa23q_quote_req sa23q_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23q_quote_req
    ADD CONSTRAINT sa23q_pk PRIMARY KEY (doc_no, qt_revision_no, sa23_row_id);


--
-- Name: sa23s_so_serial_arch sa23s_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23s_so_serial_arch
    ADD CONSTRAINT sa23s_arch_pk PRIMARY KEY (so_no, row_id, serial_row_id);


--
-- Name: sa23s_so_serial sa23s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa23s_so_serial
    ADD CONSTRAINT sa23s_pk PRIMARY KEY (so_no, row_id, serial_row_id);


--
-- Name: sa25_inv_hd_arch sa25_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa25_inv_hd_arch
    ADD CONSTRAINT sa25_arch_pk PRIMARY KEY (doc_type, doc_no);


--
-- Name: sa25_inv_hd sa25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa25_inv_hd
    ADD CONSTRAINT sa25_pk PRIMARY KEY (doc_type, doc_no);


--
-- Name: sa26_inv_dt_arch sa26_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26_inv_dt_arch
    ADD CONSTRAINT sa26_arch_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: sa26_inv_dt sa26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26_inv_dt
    ADD CONSTRAINT sa26_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: sa26a_reason_code sa26a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26a_reason_code
    ADD CONSTRAINT sa26a_pk PRIMARY KEY (doc_no, doc_type, sa26_row_id, row_id);


--
-- Name: sa26e_api_tran sa26e_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26e_api_tran
    ADD CONSTRAINT sa26e_pk PRIMARY KEY (doc_no, sess_id, tran_date, tran_time);


--
-- Name: sa26i_bin_alloc_arch sa26i_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26i_bin_alloc_arch
    ADD CONSTRAINT sa26i_arch_pk PRIMARY KEY (doc_no, row_id, bin_row_id);


--
-- Name: sa26i_bin_alloc sa26i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26i_bin_alloc
    ADD CONSTRAINT sa26i_pk PRIMARY KEY (doc_no, row_id, bin_row_id);


--
-- Name: sa26m_inv_comp_arch sa26m_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26m_inv_comp_arch
    ADD CONSTRAINT sa26m_arch_pk PRIMARY KEY (doc_no, sa26_row_id, comp_row_id);


--
-- Name: sa26m_inv_comp sa26m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26m_inv_comp
    ADD CONSTRAINT sa26m_pk PRIMARY KEY (doc_no, sa26_row_id, comp_row_id);


--
-- Name: sa26r_cnote_reason_arch sa26r_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26r_cnote_reason_arch
    ADD CONSTRAINT sa26r_arch_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: sa26r_cnote_reason sa26r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26r_cnote_reason
    ADD CONSTRAINT sa26r_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: sa26s_inv_serial_arch sa26s_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26s_inv_serial_arch
    ADD CONSTRAINT sa26s_arch_pk PRIMARY KEY (doc_no, row_id, serial_row_id);


--
-- Name: sa26s_inv_serial sa26s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa26s_inv_serial
    ADD CONSTRAINT sa26s_pk PRIMARY KEY (doc_no, row_id, serial_row_id);


--
-- Name: sa290_sales_anal sa290_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa290_sales_anal
    ADD CONSTRAINT sa290_pk PRIMARY KEY (user_name, type, section, stk_grp, loc);


--
-- Name: sa291_arb_sales_by_opr sa291_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa291_arb_sales_by_opr
    ADD CONSTRAINT sa291_pk PRIMARY KEY (loc, whs, create_by);


--
-- Name: sa30_pi_hd sa30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa30_pi_hd
    ADD CONSTRAINT sa30_pk PRIMARY KEY (doc_type, doc_no);


--
-- Name: sa30t_tax_tran sa30t_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa30t_tax_tran
    ADD CONSTRAINT sa30t_pk PRIMARY KEY (doc_no);


--
-- Name: sa31_pi_dt sa31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa31_pi_dt
    ADD CONSTRAINT sa31_pk PRIMARY KEY (doc_type, doc_no, row_id);


--
-- Name: sa31s_pi_serial sa31s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa31s_pi_serial
    ADD CONSTRAINT sa31s_pk PRIMARY KEY (doc_no, row_id, serial_row_id);


--
-- Name: sa32_pi_dn_hd sa32_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa32_pi_dn_hd
    ADD CONSTRAINT sa32_pk PRIMARY KEY (doc_type, doc_no, del_no);


--
-- Name: sa33_pi_dn_dt sa33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa33_pi_dn_dt
    ADD CONSTRAINT sa33_pk PRIMARY KEY (doc_type, doc_no, del_no, row_id, del_row_id);


--
-- Name: sa33s_pi_dn_serial sa33s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa33s_pi_dn_serial
    ADD CONSTRAINT sa33s_pk PRIMARY KEY (doc_no, del_no, row_id, serial_row_id, del_row_id);


--
-- Name: sa40_email_inv sa40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sa40_email_inv
    ADD CONSTRAINT sa40_pk PRIMARY KEY (user_name, doc_type, doc_no);


--
-- Name: sc30_batch_status_hd sc30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sc30_batch_status_hd
    ADD CONSTRAINT sc30_pk PRIMARY KEY (batch_no, batch_type);


--
-- Name: sc31_batch_status_dt sc31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sc31_batch_status_dt
    ADD CONSTRAINT sc31_pk PRIMARY KEY (batch_no, batch_type, doc_no, doc_row_id);


--
-- Name: sc35_file_log sc35_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sc35_file_log
    ADD CONSTRAINT sc35_pk PRIMARY KEY (row_id);


--
-- Name: st00_sys_opt st00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st00_sys_opt
    ADD CONSTRAINT st00_pk PRIMARY KEY (period);


--
-- Name: st00gl_sys_opt st00gl_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st00gl_sys_opt
    ADD CONSTRAINT st00gl_pk PRIMARY KEY (gl_grp);


--
-- Name: st01_mast st01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01_mast
    ADD CONSTRAINT st01_pk PRIMARY KEY (stk_code);


--
-- Name: st01cpa_factor st01cpa_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01cpa_factor
    ADD CONSTRAINT st01cpa_pk PRIMARY KEY (stk_code, material);


--
-- Name: st01i_image st01i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01i_image
    ADD CONSTRAINT st01i_pk PRIMARY KEY (row_id, stk_code);


--
-- Name: st01l_lot_cuts st01l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01l_lot_cuts
    ADD CONSTRAINT st01l_pk PRIMARY KEY (serial_no);


--
-- Name: st01n_notes st01n_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01n_notes
    ADD CONSTRAINT st01n_pk PRIMARY KEY (stk_code, row_id);


--
-- Name: st01p_per_tot st01p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01p_per_tot
    ADD CONSTRAINT st01p_pk PRIMARY KEY (stk_code, loc, whs, period);


--
-- Name: st01pd_per_tot st01pd_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01pd_per_tot
    ADD CONSTRAINT st01pd_pk PRIMARY KEY (stk_code, loc, whs, dl_code, period);


--
-- Name: st01pr_per_tot st01pr_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01pr_per_tot
    ADD CONSTRAINT st01pr_pk PRIMARY KEY (stk_code, loc, whs, rep_code, period);


--
-- Name: st01r_related_codes st01r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01r_related_codes
    ADD CONSTRAINT st01r_pk PRIMARY KEY (stk_code, type, related_code);


--
-- Name: st01s_serial_no st01s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01s_serial_no
    ADD CONSTRAINT st01s_pk PRIMARY KEY (serial_no);


--
-- Name: st01sg_sub_grp st01sg_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01sg_sub_grp
    ADD CONSTRAINT st01sg_pk PRIMARY KEY (stk_code, stk_sub_grp);


--
-- Name: st01td_long_desc st01td_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01td_long_desc
    ADD CONSTRAINT st01td_pk PRIMARY KEY (stk_code);


--
-- Name: st01ts_tech_spec st01ts_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01ts_tech_spec
    ADD CONSTRAINT st01ts_pk PRIMARY KEY (stk_code);


--
-- Name: st01u_uom st01u_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st01u_uom
    ADD CONSTRAINT st01u_pk PRIMARY KEY (stk_code, level);


--
-- Name: st02_stk_loc st02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st02_stk_loc
    ADD CONSTRAINT st02_pk PRIMARY KEY (stk_code, loc, whs);


--
-- Name: st02b_loc_bins st02b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st02b_loc_bins
    ADD CONSTRAINT st02b_pk PRIMARY KEY (stk_code, serial_no, level, row_id, loc, whs, bin_no);


--
-- Name: st02r_adj_reasons st02r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st02r_adj_reasons
    ADD CONSTRAINT st02r_pk PRIMARY KEY (reason_code);


--
-- Name: st03_bin_mast st03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st03_bin_mast
    ADD CONSTRAINT st03_pk PRIMARY KEY (bin_no, loc, whs);


--
-- Name: st04_stk_grp st04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st04_stk_grp
    ADD CONSTRAINT st04_pk PRIMARY KEY (section, stk_grp, loc);


--
-- Name: st04d_grp_div st04d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st04d_grp_div
    ADD CONSTRAINT st04d_pk PRIMARY KEY (div_code);


--
-- Name: st04s_grp_sec st04s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st04s_grp_sec
    ADD CONSTRAINT st04s_pk PRIMARY KEY (grp_section);


--
-- Name: st04sg_sub_grp st04sg_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st04sg_sub_grp
    ADD CONSTRAINT st04sg_pk PRIMARY KEY (stk_grp);


--
-- Name: st05_pack_code st05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st05_pack_code
    ADD CONSTRAINT st05_pk PRIMARY KEY (pack_code);


--
-- Name: st06_stk_prices st06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06_stk_prices
    ADD CONSTRAINT st06_pk PRIMARY KEY (stk_code, uom_code, uom_factor, loc);


--
-- Name: st06c_default_cl st06c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06c_default_cl
    ADD CONSTRAINT st06c_pk PRIMARY KEY (stk_code);


--
-- Name: st06cp_comp_hd st06cp_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06cp_comp_hd
    ADD CONSTRAINT st06cp_pk PRIMARY KEY (comp_code);


--
-- Name: st06cp_comp_dt st06cpd_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06cp_comp_dt
    ADD CONSTRAINT st06cpd_pk PRIMARY KEY (row_id, comp_code);


--
-- Name: st06f_price_hd st06f_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06f_price_hd
    ADD CONSTRAINT st06f_pk PRIMARY KEY (batch_no);


--
-- Name: st06fd_price_dt st06fd_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06fd_price_dt
    ADD CONSTRAINT st06fd_pk PRIMARY KEY (batch_no, row_id);


--
-- Name: st06s_alternate_cl st06s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06s_alternate_cl
    ADD CONSTRAINT st06s_pk PRIMARY KEY (stk_code, cl_code);


--
-- Name: st06t_price_templates st06t_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st06t_price_templates
    ADD CONSTRAINT st06t_pk PRIMARY KEY (row_id);


--
-- Name: st07_special_prices_hd st07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st07_special_prices_hd
    ADD CONSTRAINT st07_pk PRIMARY KEY (special_no);


--
-- Name: st07c_cust_selection st07c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st07c_cust_selection
    ADD CONSTRAINT st07c_pk PRIMARY KEY (special_no, row_id);


--
-- Name: st07l_stk_locs st07l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st07l_stk_locs
    ADD CONSTRAINT st07l_pk PRIMARY KEY (special_no, row_id);


--
-- Name: st07p_prod_selection st07p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st07p_prod_selection
    ADD CONSTRAINT st07p_pk PRIMARY KEY (special_no, row_id);


--
-- Name: st08_special_prices_dt st08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st08_special_prices_dt
    ADD CONSTRAINT st08_pk PRIMARY KEY (special_no, row_id);


--
-- Name: st08a_special_price_qty_list st08a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st08a_special_price_qty_list
    ADD CONSTRAINT st08a_pk PRIMARY KEY (special_no, st08_row_id, row_id);


--
-- Name: st09_cpa_idx st09_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st09_cpa_idx
    ADD CONSTRAINT st09_pk PRIMARY KEY (month);


--
-- Name: st10_ctrl_tot st10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st10_ctrl_tot
    ADD CONSTRAINT st10_pk PRIMARY KEY (period, loc, whs);


--
-- Name: st12_import_duty_tariff st12_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st12_import_duty_tariff
    ADD CONSTRAINT st12_pk PRIMARY KEY (duty_tariff_code);


--
-- Name: st13_clearing_agent st13_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st13_clearing_agent
    ADD CONSTRAINT st13_pk PRIMARY KEY (clearing_agent_code);


--
-- Name: st14_import_levies st14_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st14_import_levies
    ADD CONSTRAINT st14_pk PRIMARY KEY (levy_code);


--
-- Name: st15_uom_mast st15_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st15_uom_mast
    ADD CONSTRAINT st15_pk PRIMARY KEY (uom);


--
-- Name: st17_promo_combo_hd st17_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st17_promo_combo_hd
    ADD CONSTRAINT st17_pk PRIMARY KEY (combo_no);


--
-- Name: st17c_cust_selection st17c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st17c_cust_selection
    ADD CONSTRAINT st17c_pk PRIMARY KEY (promo_no, row_id);


--
-- Name: st17l_stk_locs st17l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st17l_stk_locs
    ADD CONSTRAINT st17l_pk PRIMARY KEY (promo_no, row_id);


--
-- Name: st17p_prod_selection st17p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st17p_prod_selection
    ADD CONSTRAINT st17p_pk PRIMARY KEY (promo_no);


--
-- Name: st18_promo_triggers st18_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st18_promo_triggers
    ADD CONSTRAINT st18_pk PRIMARY KEY (combo_no, row_id, stk_code);


--
-- Name: st19_promo_rewards st19_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st19_promo_rewards
    ADD CONSTRAINT st19_pk PRIMARY KEY (combo_no, row_id);


--
-- Name: st20_adj_bt st20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st20_adj_bt
    ADD CONSTRAINT st20_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: st20b_adj_bom st20b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st20b_adj_bom
    ADD CONSTRAINT st20b_pk PRIMARY KEY (period, batch_no, row_id, bom_row_id);


--
-- Name: st20i_bin_alloc st20i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st20i_bin_alloc
    ADD CONSTRAINT st20i_pk PRIMARY KEY (period, batch_no, row_id, bin_row_id);


--
-- Name: st20s_adj_serial st20s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st20s_adj_serial
    ADD CONSTRAINT st20s_pk PRIMARY KEY (period, batch_no, row_id, serial_row_id);


--
-- Name: st21_bin_transfer_bt st21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st21_bin_transfer_bt
    ADD CONSTRAINT st21_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: st21b_uom_break_build st21b_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st21b_uom_break_build
    ADD CONSTRAINT st21b_pk PRIMARY KEY (batch_no, row_id);


--
-- Name: st22_replen_bt st22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st22_replen_bt
    ADD CONSTRAINT st22_pk PRIMARY KEY (batch_no);


--
-- Name: st22g_grps st22g_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st22g_grps
    ADD CONSTRAINT st22g_pk PRIMARY KEY (batch_no, stk_grp);


--
-- Name: st22m_companies st22m_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st22m_companies
    ADD CONSTRAINT st22m_pk PRIMARY KEY (batch_no, company);


--
-- Name: st22s_supplier st22s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st22s_supplier
    ADD CONSTRAINT st22s_pk PRIMARY KEY (batch_no, cl_code);


--
-- Name: st23_replen_items st23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23_replen_items
    ADD CONSTRAINT st23_pk PRIMARY KEY (batch_no, stk_code, loc, whs, row_id);


--
-- Name: st23fore_close_bal st23fore_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23fore_close_bal
    ADD CONSTRAINT st23fore_pk PRIMARY KEY (batch_no, stk_code, loc, whs, st23_row_id, month);


--
-- Name: st23grn_replen_grn_hd st23grn_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23grn_replen_grn_hd
    ADD CONSTRAINT st23grn_pk PRIMARY KEY (batch_no, grn_db, grn_no);


--
-- Name: st23ib_replen_req_hd st23ib_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23ib_replen_req_hd
    ADD CONSTRAINT st23ib_pk PRIMARY KEY (batch_no, req_loc, send_loc);


--
-- Name: st23in_replen_inv_hd st23in_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23in_replen_inv_hd
    ADD CONSTRAINT st23in_pk PRIMARY KEY (batch_no, inv_db, inv_no);


--
-- Name: st23inter_po_hd st23inter_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23inter_po_hd
    ADD CONSTRAINT st23inter_pk PRIMARY KEY (batch_no, po_db, po_no);


--
-- Name: st23l_replen_co_links st23l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23l_replen_co_links
    ADD CONSTRAINT st23l_pk PRIMARY KEY (slave_db);


--
-- Name: st23po_replen_po_hd st23po_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23po_replen_po_hd
    ADD CONSTRAINT st23po_pk PRIMARY KEY (batch_no, loc, whs, cl_code);


--
-- Name: st23posub_replen_split st23posub_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23posub_replen_split
    ADD CONSTRAINT st23posub_pk PRIMARY KEY (batch_no, loc, whs, cl_code, po_no);


--
-- Name: st23s_serial_allocation st23s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23s_serial_allocation
    ADD CONSTRAINT st23s_pk PRIMARY KEY (batch_no, st23_row_id, serial_row_id);


--
-- Name: st23so_replen_so_hd st23so_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23so_replen_so_hd
    ADD CONSTRAINT st23so_pk PRIMARY KEY (batch_no, so_db, so_no);


--
-- Name: st23sub_replen_split st23sub_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st23sub_replen_split
    ADD CONSTRAINT st23sub_pk PRIMARY KEY (batch_no, stk_code, loc, whs, row_id, po_no);


--
-- Name: st24_orders st24_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st24_orders
    ADD CONSTRAINT st24_pk PRIMARY KEY (batch_no, status, so_no, row_id);


--
-- Name: st25_stk_take_hd st25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st25_stk_take_hd
    ADD CONSTRAINT st25_pk PRIMARY KEY (loc, whs, status, set_date, set_time);


--
-- Name: st25f_filters st25f_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st25f_filters
    ADD CONSTRAINT st25f_pk PRIMARY KEY (loc, whs, status, set_date, set_time, item_code);


--
-- Name: st25g_grp_exclusions st25g_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st25g_grp_exclusions
    ADD CONSTRAINT st25g_pk PRIMARY KEY (loc, whs, status, set_date, set_time, stk_grp);


--
-- Name: st26_stk_take_imp st26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st26_stk_take_imp
    ADD CONSTRAINT st26_pk PRIMARY KEY (loc, whs, stk_code, row_id, status, set_date, set_time);


--
-- Name: st26i_stk_take_imp st26i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st26i_stk_take_imp
    ADD CONSTRAINT st26i_pk PRIMARY KEY (loc, whs, batch_no, row_id, st26_row_id, bin_row_id, status, stk_code);


--
-- Name: st26s_stk_take_imp_serial st26s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st26s_stk_take_imp_serial
    ADD CONSTRAINT st26s_pk PRIMARY KEY (loc, whs, anal_type, serial_no, serial_row_id, status, set_date, set_time);


--
-- Name: st27_random_batch_hd st27_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st27_random_batch_hd
    ADD CONSTRAINT st27_pk PRIMARY KEY (batch_no);


--
-- Name: st27d_random_batch_dt st27d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st27d_random_batch_dt
    ADD CONSTRAINT st27d_pk PRIMARY KEY (batch_no, stk_code, uom_code, uom_factor);


--
-- Name: st27i_random_bins st27i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st27i_random_bins
    ADD CONSTRAINT st27i_pk PRIMARY KEY (batch_no, stk_code, serial_no, bin_no, uom_code, uom_factor);


--
-- Name: st27s_random_batch_serials st27s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st27s_random_batch_serials
    ADD CONSTRAINT st27s_pk PRIMARY KEY (batch_no, stk_code, serial_no, uom_code, uom_factor);


--
-- Name: st28_stk_take_process st28_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st28_stk_take_process
    ADD CONSTRAINT st28_pk PRIMARY KEY (loc, whs, div_code, status, set_date, set_time);


--
-- Name: st29_man_pull_pack_bin st29_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st29_man_pull_pack_bin
    ADD CONSTRAINT st29_pk PRIMARY KEY (period, batch_no, row_id);


--
-- Name: st30_stk_tran st30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st30_stk_tran
    ADD CONSTRAINT st30_pk PRIMARY KEY (stk_code, row_id);


--
-- Name: st30i_internal_trans st30i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st30i_internal_trans
    ADD CONSTRAINT st30i_pk PRIMARY KEY (stk_code, st30_row_id, row_id);


--
-- Name: st30s_serial_tran st30s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st30s_serial_tran
    ADD CONSTRAINT st30s_pk PRIMARY KEY (stk_code, st30_row_id, serial_no, serial_row_id);


--
-- Name: st33_price_chg st33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st33_price_chg
    ADD CONSTRAINT st33_pk PRIMARY KEY (stk_code, price_chg_row_id);


--
-- Name: st33p_price_chg_labels st33p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st33p_price_chg_labels
    ADD CONSTRAINT st33p_pk PRIMARY KEY (loc, whs, stk_code, price_chg_row_id);


--
-- Name: st34_arb_wms_fail_log st34_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st34_arb_wms_fail_log
    ADD CONSTRAINT st34_pk PRIMARY KEY (log_id);


--
-- Name: st35_whs_dis_hd st35_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st35_whs_dis_hd
    ADD CONSTRAINT st35_pk PRIMARY KEY (batch_no);


--
-- Name: st36_whs_dis_dt st36_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st36_whs_dis_dt
    ADD CONSTRAINT st36_pk PRIMARY KEY (batch_no, doc_no, stage_ship_doc, doc_row_id);


--
-- Name: st36i_whs_dis_bin st36i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st36i_whs_dis_bin
    ADD CONSTRAINT st36i_pk PRIMARY KEY (batch_no, doc_no, stage_ship_doc, doc_row_id, bin_row_id);


--
-- Name: st36p_whs_dis_pallets st36p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st36p_whs_dis_pallets
    ADD CONSTRAINT st36p_pk PRIMARY KEY (batch_no, doc_no, ship_doc_no, doc_row_id, wt_container_id, wt_pallet_id);


--
-- Name: st36s_whs_dis_serials st36s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st36s_whs_dis_serials
    ADD CONSTRAINT st36s_pk PRIMARY KEY (batch_no, doc_no, doc_row_id, serial_row_id);


--
-- Name: st37_whs_rec_hd st37_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st37_whs_rec_hd
    ADD CONSTRAINT st37_pk PRIMARY KEY (batch_no);


--
-- Name: st38_whs_rec_dt st38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st38_whs_rec_dt
    ADD CONSTRAINT st38_pk PRIMARY KEY (batch_no, doc_no, ship_doc_no, doc_row_id);


--
-- Name: st38d_driver_dt st38d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st38d_driver_dt
    ADD CONSTRAINT st38d_pk PRIMARY KEY (batch_no, doc_no, driver_id_no);


--
-- Name: st38i_whs_rec_bin st38i_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st38i_whs_rec_bin
    ADD CONSTRAINT st38i_pk PRIMARY KEY (batch_no, doc_no, stage_ship_doc, doc_row_id, bin_row_id);


--
-- Name: st38s_whs_rec_serials st38s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st38s_whs_rec_serials
    ADD CONSTRAINT st38s_pk PRIMARY KEY (batch_no, doc_no, doc_row_id, serial_row_id);


--
-- Name: st40_track_store_pulling st40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st40_track_store_pulling
    ADD CONSTRAINT st40_pk PRIMARY KEY (loc, whs, doc_type, doc_no, row_id);


--
-- Name: st40p_package_dimensions st40p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st40p_package_dimensions
    ADD CONSTRAINT st40p_pk PRIMARY KEY (row_id, doc_type, doc_no, package_no);


--
-- Name: st40u_warehouse_user st40u_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st40u_warehouse_user
    ADD CONSTRAINT st40u_pk PRIMARY KEY (loc, whs, user_name);


--
-- Name: st41_area_mast st41_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st41_area_mast
    ADD CONSTRAINT st41_pk PRIMARY KEY (loc, whs, area_code);


--
-- Name: st42_route_no st42_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st42_route_no
    ADD CONSTRAINT st42_pk PRIMARY KEY (loc, whs, route_no);


--
-- Name: st43_prt_stk_hd st43_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st43_prt_stk_hd
    ADD CONSTRAINT st43_pk PRIMARY KEY (batch_no);


--
-- Name: st44_prt_stk_dt st44_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.st44_prt_stk_dt
    ADD CONSTRAINT st44_pk PRIMARY KEY (batch_no, stk_code, uom);


--
-- Name: sy00_co_mast sy00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy00_co_mast
    ADD CONSTRAINT sy00_pk PRIMARY KEY (co_name);


--
-- Name: sy01_master_co_links sy01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy01_master_co_links
    ADD CONSTRAINT sy01_pk PRIMARY KEY (master_db, slave_db);


--
-- Name: sy01w_mast sy01w_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy01w_mast
    ADD CONSTRAINT sy01w_pk PRIMARY KEY (widget_name);


--
-- Name: sy02_user sy02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02_user
    ADD CONSTRAINT sy02_pk PRIMARY KEY (user_name);


--
-- Name: sy02bi_widget sy02bi_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02bi_widget
    ADD CONSTRAINT sy02bi_pk PRIMARY KEY (user_name);


--
-- Name: sy02d_grp_div sy02d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02d_grp_div
    ADD CONSTRAINT sy02d_pk PRIMARY KEY (user_name, div_code);


--
-- Name: sy02f_user_favs sy02f_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02f_user_favs
    ADD CONSTRAINT sy02f_pk PRIMARY KEY (user_name);


--
-- Name: sy02g_user_stk_grp sy02g_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02g_user_stk_grp
    ADD CONSTRAINT sy02g_pk PRIMARY KEY (user_name, div_code, section_code, stk_grp);


--
-- Name: sy02h_pwd_hist sy02h_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02h_pwd_hist
    ADD CONSTRAINT sy02h_pk PRIMARY KEY (user_name, chg_id);


--
-- Name: sy02l_user_loc sy02l_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02l_user_loc
    ADD CONSTRAINT sy02l_pk PRIMARY KEY (user_name, loc, whs);


--
-- Name: sy02p_user_positions sy02p_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02p_user_positions
    ADD CONSTRAINT sy02p_pk PRIMARY KEY (position_held);


--
-- Name: sy02s_startup sy02s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02s_startup
    ADD CONSTRAINT sy02s_pk PRIMARY KEY (user_name);


--
-- Name: sy02w_user_widget sy02w_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02w_user_widget
    ADD CONSTRAINT sy02w_pk PRIMARY KEY (user_name);


--
-- Name: sy02wp_dash_param sy02wp_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy02wp_dash_param
    ADD CONSTRAINT sy02wp_pk PRIMARY KEY (widget_no, user_name);


--
-- Name: sy04_access_grps sy04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy04_access_grps
    ADD CONSTRAINT sy04_pk PRIMARY KEY (grp);


--
-- Name: sy05_tm_grps sy05_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy05_tm_grps
    ADD CONSTRAINT sy05_pk PRIMARY KEY (tm_grp);


--
-- Name: sy06a_access sy06a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy06a_access
    ADD CONSTRAINT sy06a_pk PRIMARY KEY (row_id);


--
-- Name: sy06c_custom_menu sy06c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy06c_custom_menu
    ADD CONSTRAINT sy06c_pk PRIMARY KEY (row_id, custom_db_name);


--
-- Name: sy06s_structure sy06s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy06s_structure
    ADD CONSTRAINT sy06s_pk PRIMARY KEY (row_id);


--
-- Name: sy07_prt_mast sy07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy07_prt_mast
    ADD CONSTRAINT sy07_pk PRIMARY KEY (prt_no);


--
-- Name: sy08_prt_types sy08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy08_prt_types
    ADD CONSTRAINT sy08_pk PRIMARY KEY (prt_type);


--
-- Name: sy09_prt_esc_codes sy09_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy09_prt_esc_codes
    ADD CONSTRAINT sy09_pk PRIMARY KEY (prt_type, sort_seq_no, format, row_id);


--
-- Name: sy10_lic_mast sy10_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy10_lic_mast
    ADD CONSTRAINT sy10_pk PRIMARY KEY (co_name);


--
-- Name: sy13_fiscal_device sy13_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy13_fiscal_device
    ADD CONSTRAINT sy13_pk PRIMARY KEY (device_id, api_key);


--
-- Name: sy14_dashboard_mast sy14_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy14_dashboard_mast
    ADD CONSTRAINT sy14_pk PRIMARY KEY (dashboard_type, name);


--
-- Name: sy15_phone_codes sy15_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy15_phone_codes
    ADD CONSTRAINT sy15_pk PRIMARY KEY (country);


--
-- Name: sy16_post_codes sy16_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy16_post_codes
    ADD CONSTRAINT sy16_pk PRIMARY KEY (country, post_code);


--
-- Name: sy20_batch_log sy20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy20_batch_log
    ADD CONSTRAINT sy20_pk PRIMARY KEY (period, source, batch_no);


--
-- Name: sy21_del_by sy21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy21_del_by
    ADD CONSTRAINT sy21_pk PRIMARY KEY (module, del_by_code);


--
-- Name: sy220_user_productivity sy220_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy220_user_productivity
    ADD CONSTRAINT sy220_pk PRIMARY KEY (user_name, loc, create_by, doc_type, period);


--
-- Name: sy22_prt_que sy22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy22_prt_que
    ADD CONSTRAINT sy22_pk PRIMARY KEY (report_no);


--
-- Name: sy23_proj_mast sy23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy23_proj_mast
    ADD CONSTRAINT sy23_pk PRIMARY KEY (proj_code);


--
-- Name: sy25_vat_201 sy25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy25_vat_201
    ADD CONSTRAINT sy25_pk PRIMARY KEY (period);


--
-- Name: sy26_vat_dt sy26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy26_vat_dt
    ADD CONSTRAINT sy26_pk PRIMARY KEY (period, vat_201_no, in_out, row_id, source);


--
-- Name: sy27_supercession sy27_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy27_supercession
    ADD CONSTRAINT sy27_pk PRIMARY KEY (row_id, source, type);


--
-- Name: sy27h_code_history sy27h_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy27h_code_history
    ADD CONSTRAINT sy27h_pk PRIMARY KEY (first_code, row_id, module);


--
-- Name: sy290_eb_daily_snapshot sy290_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy290_eb_daily_snapshot
    ADD CONSTRAINT sy290_pk PRIMARY KEY (row_id);


--
-- Name: sy29_reval sy29_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy29_reval
    ADD CONSTRAINT sy29_pk PRIMARY KEY (source_no, source, source_row_id, source_comp_row_id, loc);


--
-- Name: sy30_approval_hd sy30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy30_approval_hd
    ADD CONSTRAINT sy30_pk PRIMARY KEY (approval_no);


--
-- Name: sy31_approval_dt sy31_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy31_approval_dt
    ADD CONSTRAINT sy31_pk PRIMARY KEY (approval_no, row_id);


--
-- Name: sy31a_access_grp sy31a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy31a_access_grp
    ADD CONSTRAINT sy31a_pk PRIMARY KEY (approval_no, row_id, sy31_row_id);


--
-- Name: sy33_program_log sy33_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy33_program_log
    ADD CONSTRAINT sy33_pk PRIMARY KEY (date, "time", user_name, row_id, pid);


--
-- Name: sy35_chg_log_arch sy35_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy35_chg_log_arch
    ADD CONSTRAINT sy35_arch_pk PRIMARY KEY (log_no);


--
-- Name: sy35_chg_log sy35_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy35_chg_log
    ADD CONSTRAINT sy35_pk PRIMARY KEY (log_no, session_id, prog_name, chg_date, chg_time);


--
-- Name: sy36_running_progs sy36_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy36_running_progs
    ADD CONSTRAINT sy36_pk PRIMARY KEY (pid, user_name);


--
-- Name: sy37_in_use_log sy37_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy37_in_use_log
    ADD CONSTRAINT sy37_pk PRIMARY KEY (user_name, pid, prog_name, tbl_name, key_value);


--
-- Name: sy38_auth_out_req sy38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy38_auth_out_req
    ADD CONSTRAINT sy38_pk PRIMARY KEY (pid, prog_name, req_by, req_date, req_time);


--
-- Name: sy40_support_log sy40_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy40_support_log
    ADD CONSTRAINT sy40_pk PRIMARY KEY (call_no);


--
-- Name: sy41_doc_attachement sy41_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy41_doc_attachement
    ADD CONSTRAINT sy41_pk PRIMARY KEY (source_no, module);


--
-- Name: sy42_file_cat_mast sy42_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy42_file_cat_mast
    ADD CONSTRAINT sy42_pk PRIMARY KEY (module, file_cat);


--
-- Name: sy50_reports sy50_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.sy50_reports
    ADD CONSTRAINT sy50_pk PRIMARY KEY (report_no);


--
-- Name: tb25_hd tb25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tb25_hd
    ADD CONSTRAINT tb25_pk PRIMARY KEY (key_field_chg);


--
-- Name: tb26_dt tb26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tb26_dt
    ADD CONSTRAINT tb26_pk PRIMARY KEY (key_field_chg, row_id);


--
-- Name: tb26s_dts tb26s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tb26s_dts
    ADD CONSTRAINT tb26s_pk PRIMARY KEY (sub_key_field_chg, row_id, sub_row_id);


--
-- Name: test_db test_db_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.test_db
    ADD CONSTRAINT test_db_pk PRIMARY KEY (test_id);


--
-- Name: tm00_sys_opt tm00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm00_sys_opt
    ADD CONSTRAINT tm00_pk PRIMARY KEY (last_task_no);


--
-- Name: tm02_user tm02_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm02_user
    ADD CONSTRAINT tm02_pk PRIMARY KEY (dl_code, user_email);


--
-- Name: tm02d_dl_codes tm02d_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm02d_dl_codes
    ADD CONSTRAINT tm02d_pk PRIMARY KEY (user_name, dl_code);


--
-- Name: tm02h_pwd_hist tm02h_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm02h_pwd_hist
    ADD CONSTRAINT tm02h_pk PRIMARY KEY (user_name, chg_id);


--
-- Name: tm03_priority tm03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm03_priority
    ADD CONSTRAINT tm03_pk PRIMARY KEY (priority, priority_tm_grp);


--
-- Name: tm04_task_type tm04_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm04_task_type
    ADD CONSTRAINT tm04_pk PRIMARY KEY (task_type);


--
-- Name: tm04s_sub_task tm04s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm04s_sub_task
    ADD CONSTRAINT tm04s_pk PRIMARY KEY (sub_task);


--
-- Name: tm06_folder tm06_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm06_folder
    ADD CONSTRAINT tm06_pk PRIMARY KEY (folder_code, folder_tm_grp);


--
-- Name: tm07_task_tags tm07_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm07_task_tags
    ADD CONSTRAINT tm07_pk PRIMARY KEY (tag_code, tm_grp);


--
-- Name: tm08_report_tags tm08_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm08_report_tags
    ADD CONSTRAINT tm08_pk PRIMARY KEY (report_tag);


--
-- Name: tm20_task_freeze_log_arch tm20_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm20_task_freeze_log_arch
    ADD CONSTRAINT tm20_arch_pk PRIMARY KEY (task_no, task_freeze_date, task_freeze_time);


--
-- Name: tm20_task_freeze_log tm20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm20_task_freeze_log
    ADD CONSTRAINT tm20_pk PRIMARY KEY (task_no, task_freeze_date, task_freeze_time);


--
-- Name: tm22_comms_hd_arch tm22_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm22_comms_hd_arch
    ADD CONSTRAINT tm22_arch_pk PRIMARY KEY (task_no);


--
-- Name: tm22_comms_hd_mob tm22_mob_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm22_comms_hd_mob
    ADD CONSTRAINT tm22_mob_pk PRIMARY KEY (task_no);


--
-- Name: tm22_comms_hd tm22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm22_comms_hd
    ADD CONSTRAINT tm22_pk PRIMARY KEY (task_no);


--
-- Name: tm22c_comms_cc_arch tm22c_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm22c_comms_cc_arch
    ADD CONSTRAINT tm22c_arch_pk PRIMARY KEY (task_no, user_name, email);


--
-- Name: tm22c_comms_cc tm22c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm22c_comms_cc
    ADD CONSTRAINT tm22c_pk PRIMARY KEY (task_no, user_name, email);


--
-- Name: tm23_comms_dt tm23_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm23_comms_dt
    ADD CONSTRAINT tm23_pk PRIMARY KEY (task_no, row_id);


--
-- Name: tm23a_comms_attach tm23a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm23a_comms_attach
    ADD CONSTRAINT tm23a_pk PRIMARY KEY (task_no, tm23_row_id, attach_row_id);


--
-- Name: tm25_task_hd_arch tm25_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25_task_hd_arch
    ADD CONSTRAINT tm25_arch_pk PRIMARY KEY (task_no);


--
-- Name: tm25_task_hd tm25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25_task_hd
    ADD CONSTRAINT tm25_pk PRIMARY KEY (task_no);


--
-- Name: tm25a_assigned tm25a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25a_assigned
    ADD CONSTRAINT tm25a_pk PRIMARY KEY (task_no, task_assigned_to, row_id, task_action_by);


--
-- Name: tm25r_task_reminders_arch tm25r_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25r_task_reminders_arch
    ADD CONSTRAINT tm25r_arch_pk PRIMARY KEY (reminder_id);


--
-- Name: tm25r_task_reminders tm25r_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25r_task_reminders
    ADD CONSTRAINT tm25r_pk PRIMARY KEY (reminder_id);


--
-- Name: tm25t_task_tags_arch tm25t_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25t_task_tags_arch
    ADD CONSTRAINT tm25t_arch_pk PRIMARY KEY (task_no, task_tag);


--
-- Name: tm25t_task_tags tm25t_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm25t_task_tags
    ADD CONSTRAINT tm25t_pk PRIMARY KEY (task_no, task_tag);


--
-- Name: tm26_task_dt_arch tm26_arch_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm26_task_dt_arch
    ADD CONSTRAINT tm26_arch_pk PRIMARY KEY (task_no, row_id);


--
-- Name: tm26_task_dt tm26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm26_task_dt
    ADD CONSTRAINT tm26_pk PRIMARY KEY (task_no, row_id);


--
-- Name: tm26a_task_attach tm26a_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm26a_task_attach
    ADD CONSTRAINT tm26a_pk PRIMARY KEY (task_no, tm26_row_id, attach_row_id);


--
-- Name: tm38_request_log tm38_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.tm38_request_log
    ADD CONSTRAINT tm38_pk PRIMARY KEY (task_no, review_id);


--
-- Name: wf25_workflows wf25_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wf25_workflows
    ADD CONSTRAINT wf25_pk PRIMARY KEY (wf_no);


--
-- Name: wf26_app_reason wf26_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wf26_app_reason
    ADD CONSTRAINT wf26_pk PRIMARY KEY (reason_id, module);


--
-- Name: wr00_sys_opt wr00_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr00_sys_opt
    ADD CONSTRAINT wr00_pk PRIMARY KEY (row_id);


--
-- Name: wr01_doc_no wr01_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr01_doc_no
    ADD CONSTRAINT wr01_pk PRIMARY KEY (loc);


--
-- Name: wr03_wr_reasons wr03_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr03_wr_reasons
    ADD CONSTRAINT wr03_pk PRIMARY KEY (reason_code, sort_pos);


--
-- Name: wr20_war_hd wr20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr20_war_hd
    ADD CONSTRAINT wr20_pk PRIMARY KEY (book_in_no);


--
-- Name: wr20n_book_in_notes wr20n_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr20n_book_in_notes
    ADD CONSTRAINT wr20n_pk PRIMARY KEY (book_in_no, row_id);


--
-- Name: wr21_war_dt wr21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wr21_war_dt
    ADD CONSTRAINT wr21_pk PRIMARY KEY (book_in_no, row_id);


--
-- Name: wt20_doc_hd wt20_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt20_doc_hd
    ADD CONSTRAINT wt20_pk PRIMARY KEY (loc, whs, doc_type, doc_no);


--
-- Name: wt20c_collection_req wt20c_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt20c_collection_req
    ADD CONSTRAINT wt20c_pk PRIMARY KEY (loc, whs, doc_type, doc_no);


--
-- Name: wt21_disp_dt wt21_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt21_disp_dt
    ADD CONSTRAINT wt21_pk PRIMARY KEY (doc_type, doc_no, prod_code);


--
-- Name: wt21s_disp_serial wt21s_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt21s_disp_serial
    ADD CONSTRAINT wt21s_pk PRIMARY KEY (doc_type, doc_no, prod_code, serial_no);


--
-- Name: wt22_trip_sheet wt22_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt22_trip_sheet
    ADD CONSTRAINT wt22_pk PRIMARY KEY (trip_sheet);


--
-- Name: wt30_phase_tran wt30_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.wt30_phase_tran
    ADD CONSTRAINT wt30_pk PRIMARY KEY (loc, whs, doc_type, doc_no, row_id);


--
-- Name: z_conv_ev_codes z_conv_ev_codes_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.z_conv_ev_codes
    ADD CONSTRAINT z_conv_ev_codes_pk PRIMARY KEY (ev_code);


--
-- Name: z_conv_vrm_codes z_conv_vrm_codes_pk; Type: CONSTRAINT; Schema: public; Owner: www-data
--

ALTER TABLE ONLY public.z_conv_vrm_codes
    ADD CONSTRAINT z_conv_vrm_codes_pk PRIMARY KEY (vrm_code);


--
-- Name: bm01_test; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bm01_test ON public.bm01_doc_no USING btree (first_wo, last_wo, cur_wo);


--
-- Name: bm30_status_loc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bm30_status_loc ON public.bm30_wo_hd USING btree (status, principle_wo, loc, whs, stk_code);


--
-- Name: bm31_stk_code_loc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bm31_stk_code_loc ON public.bm31_wo_comp USING btree (stk_code, loc, whs);


--
-- Name: bo01_paid_thru_pos; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bo01_paid_thru_pos ON public.bo01_mast USING btree (paid_thru_pos);


--
-- Name: bo01_sec_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bo01_sec_code ON public.bo01_mast USING btree (bo_sec, bo_code);


--
-- Name: bo30_code_period_tran; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS bo30_code_period_tran ON public.bo30_tran USING btree (bo_code, period, tran_type);


--
-- Name: cb30_auto_allocation; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cb30_auto_allocation ON public.cb30_tran USING btree (period, source, presented, ref, gl_narr);


--
-- Name: cb42_cb_mgr; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cb42_cb_mgr ON public.cb42_auto_tag_match_log USING btree (bank_code DESC, bank_acct DESC, cb40_row_id DESC, ref_1 DESC);


--
-- Name: cl22_auto_allocation; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cl22_auto_allocation ON public.cl22_pay_bt USING btree (period DESC, batch_no DESC, ref_1 DESC);


--
-- Name: cl30_code_ref; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cl30_code_ref ON public.cl30_tran USING btree (cl_code, ref_2);


--
-- Name: cl30_date; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cl30_date ON public.cl30_tran USING btree (cl_code, row_id, tran_date);


--
-- Name: cl30_status; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS cl30_status ON public.cl30_tran USING btree (cl_code, status, tran_date);


--
-- Name: dl01_linked_code_dl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl01_linked_code_dl_code ON public.dl01_mast USING btree (linked_acct DESC, dl_code DESC);


--
-- Name: dl01_rep_dl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl01_rep_dl_code ON public.dl01_mast USING btree (rep_code DESC, dl_code DESC);


--
-- Name: dl30_code_ref; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_code_ref ON public.dl30_tran USING btree (dl_code, ref_1);


--
-- Name: dl30_date; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_date ON public.dl30_tran USING btree (tran_date);


--
-- Name: dl30_query; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_query ON public.dl30_tran USING btree (loc, period, ref_1);


--
-- Name: dl30_rep_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_rep_code ON public.dl30_tran USING btree (rep_code, status);


--
-- Name: dl30_status; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_status ON public.dl30_tran USING btree (dl_code, status, tran_date);


--
-- Name: dl30_status_code_age; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_status_code_age ON public.dl30_tran USING btree (status, dl_code, age);


--
-- Name: dl30_tran_type; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS dl30_tran_type ON public.dl30_tran USING btree (tran_date, tran_type, dl_code);


--
-- Name: gl02_stk_loc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl02_stk_loc ON public.gl02_loc_mast USING btree (stk_loc);


--
-- Name: gl03f_loc_year_gl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl03f_loc_year_gl_code ON public.gl03f_fiscal_bal USING btree (loc, year, gl_code);


--
-- Name: gl29_loc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl29_loc ON public.gl29_in_tray USING btree (loc);


--
-- Name: gl29_per_src_batch; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl29_per_src_batch ON public.gl29_in_tray USING btree (period, source, batch_no);


--
-- Name: gl30_batch_index; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl30_batch_index ON public.gl30_tran USING btree (batch_no, source, period, gl_code);


--
-- Name: gl30_code_loc_row; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl30_code_loc_row ON public.gl30_tran USING btree (gl_code DESC, loc DESC, row_id DESC);


--
-- Name: gl30_enq_ind; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl30_enq_ind ON public.gl30_tran USING btree (gl_code, period);


--
-- Name: gl30_loc_gl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl30_loc_gl_code ON public.gl30_tran USING btree (loc, gl_code, row_id);


--
-- Name: gl30_report_ind; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS gl30_report_ind ON public.gl30_tran USING btree (gl_code, source, period);


--
-- Name: ib24_ibt_no_status; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS ib24_ibt_no_status ON public.ib24_ib_hd USING btree (ibt_no, status);


--
-- Name: pu22_auto_source; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_auto_source ON public.pu22_po_hd USING btree (auto_doc_no, auto_source);


--
-- Name: pu22_exp_status; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_exp_status ON public.pu22_po_hd USING btree (exp_date, status, doc_no);


--
-- Name: pu22_import_ord; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_import_ord ON public.pu22_po_hd USING btree (linked_to_import_po, doc_no, status);


--
-- Name: pu22_loc_doc_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_loc_doc_no ON public.pu22_po_hd USING btree (loc, doc_no);


--
-- Name: pu22_prod_due_doc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_prod_due_doc ON public.pu23_po_dt USING btree (prod_code, due_qty, doc_no);


--
-- Name: pu22_proj_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_proj_code ON public.pu22_po_hd USING btree (proj_code);


--
-- Name: pu22_replen; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu22_replen ON public.pu22_po_hd USING btree (status, exp_date, split_del_qty);


--
-- Name: pu23_doc_no_prod_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu23_doc_no_prod_code ON public.pu23_po_dt USING btree (doc_no DESC, prod_code);


--
-- Name: pu23d_age_anal_due; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu23d_age_anal_due ON public.pu23d_po_split USING btree (doc_no, row_id, due_date);


--
-- Name: pu23d_age_anal_exp; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu23d_age_anal_exp ON public.pu23d_po_split USING btree (doc_no, row_id, exp_date);


--
-- Name: pu25_loc__doc_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_loc__doc_no ON public.pu25_grn_hd USING btree (loc, doc_no);


--
-- Name: pu25_loc_per_type; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_loc_per_type ON public.pu25_grn_hd USING btree (loc, period, doc_type);


--
-- Name: pu25_match; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_match ON public.pu25_grn_hd USING btree (match_status, match_period, match_by);


--
-- Name: pu25_next_prev; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_next_prev ON public.pu25_grn_hd USING btree (linked_import_grn_no, loc, whs, doc_type);


--
-- Name: pu25_proj_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_proj_code ON public.pu25_grn_hd USING btree (proj_code);


--
-- Name: pu25_supp_hist; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu25_supp_hist ON public.pu25_grn_hd USING btree (cl_code, doc_date DESC);


--
-- Name: pu26_prod_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu26_prod_code ON public.pu26_grn_dt USING btree (doc_no, prod_code);


--
-- Name: pu26_prt_qty; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS pu26_prt_qty ON public.pu26_grn_dt USING btree (prt_ind, doc_qty, grved_qty);


--
-- Name: px01_loc_org_recid; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS px01_loc_org_recid ON public.px01_report_data USING btree (loc, org_recid);


--
-- Name: px02_ext_name; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS px02_ext_name ON public.px02_sip_buddies USING btree (loc, ext, ext_name);


--
-- Name: sa22_cust_hist; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_cust_hist ON public.sa22_qt_so_hd USING btree (dl_code, doc_type, status, doc_no, doc_date DESC);


--
-- Name: sa22_dl_code_name; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_dl_code_name ON public.sa22_qt_so_hd USING btree (dl_code, cust_ref);


--
-- Name: sa22_doc_no_type_loc_status; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_doc_no_type_loc_status ON public.sa22_qt_so_hd USING btree (doc_no, doc_type, loc, status, period DESC);


--
-- Name: sa22_loc_doc_type; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_loc_doc_type ON public.sa22_qt_so_hd USING btree (loc, doc_type, status);


--
-- Name: sa22_loc_type_doc_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_loc_type_doc_no ON public.sa22_qt_so_hd USING btree (loc, doc_type, doc_no);


--
-- Name: sa22_replen; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_replen ON public.sa22_qt_so_hd USING btree (doc_type, loc, status, due_date, split_del_qty);


--
-- Name: sa22_stk_enq; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_stk_enq ON public.sa22_qt_so_hd USING btree (doc_type, doc_no, loc, status, due_date DESC);


--
-- Name: sa22_toolbox; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_toolbox ON public.sa22_qt_so_hd USING btree (status, doc_type, doc_no, period);


--
-- Name: sa22_type_per_qt; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa22_type_per_qt ON public.sa22_qt_so_hd USING btree (doc_type, period, qt_no_if_so);


--
-- Name: sa23_prod_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa23_prod_code ON public.sa23_qt_so_dt USING btree (prod_code);


--
-- Name: sa23_replen; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa23_replen ON public.sa23_qt_so_dt USING btree (doc_type, prod_code);


--
-- Name: sa23_stk_in_so; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa23_stk_in_so ON public.sa23_qt_so_dt USING btree (doc_no, prod_code, due_qty);


--
-- Name: sa23t_qt_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa23t_qt_no ON public.sa23t_qt_terms USING btree (qt_no, qt_revision_no, row_id);


--
-- Name: sa25_cust_hist; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_cust_hist ON public.sa25_inv_hd USING btree (doc_type, dl_code, doc_date DESC, doc_no DESC);


--
-- Name: sa25_dl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_dl_code ON public.sa25_inv_hd USING btree (dl_code, cust_ref);


--
-- Name: sa25_lookup; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_lookup ON public.sa25_inv_hd USING btree (doc_type, doc_date DESC, doc_no DESC);


--
-- Name: sa25_per_loc_doc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_per_loc_doc ON public.sa25_inv_hd USING btree (doc_type, period, loc, doc_no);


--
-- Name: sa25_pos_batch_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_pos_batch_no ON public.sa25_inv_hd USING btree (pos_batch_no);


--
-- Name: sa25_rep_dl_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_rep_dl_code ON public.sa25_inv_hd USING btree (doc_type, period DESC, rep_code, dl_code, doc_no);


--
-- Name: sa25_so_no; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_so_no ON public.sa25_inv_hd USING btree (doc_type, sa22_so_no, jc24_job_no, doc_no);


--
-- Name: sa25_web_store; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa25_web_store ON public.sa25_inv_hd USING btree (doc_type, inv_type, web_doc_no);


--
-- Name: sa26_prod_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa26_prod_code ON public.sa26_inv_dt USING btree (prod_code);


--
-- Name: sa26_type_no_ind; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sa26_type_no_ind ON public.sa26_inv_dt USING btree (doc_type, doc_no, prt_ind, prod_code);


--
-- Name: st01_grp_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st01_grp_code ON public.st01_mast USING btree (stk_grp, stk_code);


--
-- Name: st01l_status_ind; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st01l_status_ind ON public.st01l_lot_cuts USING btree (status DESC);


--
-- Name: st01pd_prod_anal; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st01pd_prod_anal ON public.st01pd_per_tot USING btree (stk_code, loc, dl_code, period);


--
-- Name: st01s_code_serial; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st01s_code_serial ON public.st01s_serial_no USING btree (stk_code, serial_no);


--
-- Name: st02_loc_code; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st02_loc_code ON public.st02_stk_loc USING btree (loc, whs, stk_code);


--
-- Name: st07_header_dt; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st07_header_dt ON public.st07_special_prices_hd USING btree (status, special_start_date, special_end_date, special_no);


--
-- Name: st08_line_dt; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st08_line_dt ON public.st08_special_prices_dt USING btree (stk_code, status, special_no);


--
-- Name: st23_po_sort; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st23_po_sort ON public.st23_replen_items USING btree (batch_no, ord_loc, cl_code);


--
-- Name: st23_req_sort; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st23_req_sort ON public.st23_replen_items USING btree (batch_no, loc);


--
-- Name: st24_sa22_chk; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st24_sa22_chk ON public.st24_orders USING btree (so_no, stk_code, sa23_row_id);


--
-- Name: st30_code_loc_whs; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_code_loc_whs ON public.st30_stk_tran USING btree (stk_code, loc, whs);


--
-- Name: st30_code_row_ref; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_code_row_ref ON public.st30_stk_tran USING btree (stk_code, row_id, ref_1);


--
-- Name: st30_move; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_move ON public.st30_stk_tran USING btree (stk_code, tran_date DESC, tran_time DESC, loc DESC, tran_type DESC);


--
-- Name: st30_stk_bom; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_stk_bom ON public.st30_stk_tran USING btree (stk_code, period, ref_1, tran_type);


--
-- Name: st30_stk_row_loc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_stk_row_loc ON public.st30_stk_tran USING btree (stk_code, row_id, loc);


--
-- Name: st30_tran_stk_period; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st30_tran_stk_period ON public.st30_stk_tran USING btree (tran_type, stk_code, period);


--
-- Name: st40_enq_build; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_enq_build ON public.st40_track_store_pulling USING btree (loc, whs, start_date, end_date, action_by);


--
-- Name: st40_gen_build; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_gen_build ON public.st40_track_store_pulling USING btree (loc, whs, end_date);


--
-- Name: st40_gen_build_doc; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_gen_build_doc ON public.st40_track_store_pulling USING btree (loc, whs, end_date, doc_type);


--
-- Name: st40_gen_build_ph; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_gen_build_ph ON public.st40_track_store_pulling USING btree (loc, whs, end_date, status);


--
-- Name: st40_gen_build_rt; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_gen_build_rt ON public.st40_track_store_pulling USING btree (loc, whs, end_date, route_no);


--
-- Name: st40_inv_find; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_inv_find ON public.st40_track_store_pulling USING btree (loc, whs, doc_type, doc_no);


--
-- Name: st40_tra_build; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS st40_tra_build ON public.st40_track_store_pulling USING btree (loc, whs, end_date, action_by);


--
-- Name: sy02_ovr_pwd; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy02_ovr_pwd ON public.sy02_user USING btree (disable_user, ic_user, allow_ovrd_pwd, ovrd_pwd);


--
-- Name: sy02h_ovr_pwd; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy02h_ovr_pwd ON public.sy02h_pwd_hist USING btree (user_name, chg_id, password);


--
-- Name: sy06s_prog; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy06s_prog ON public.sy06s_structure USING btree (prog_name);


--
-- Name: sy06s_sort; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy06s_sort ON public.sy06s_structure USING btree (sort_seq);


--
-- Name: sy20_auto_allocation; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy20_auto_allocation ON public.sy20_batch_log USING btree (period DESC, batch_no DESC, menu_arg DESC, descr DESC);


--
-- Name: sy20_batch_nav; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy20_batch_nav ON public.sy20_batch_log USING btree (source, menu_arg, status, batch_no);


--
-- Name: sy22_filter_by_date; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy22_filter_by_date ON public.sy22_prt_que USING btree (create_date, create_time);


--
-- Name: sy22_prog_name; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy22_prog_name ON public.sy22_prt_que USING btree (prog_name);


--
-- Name: sy35_dayend_prt; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy35_dayend_prt ON public.sy35_chg_log USING btree (prog_name, tbl_name, chg_date, parent_key, action);


--
-- Name: sy35_delete_log; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy35_delete_log ON public.sy35_chg_log USING btree (session_id, prog_name, tbl_name, parent_key);


--
-- Name: sy35_view_log; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy35_view_log ON public.sy35_chg_log USING btree (prog_name, chg_date, chg_time, parent_key);


--
-- Name: sy36_menu_timer; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS sy36_menu_timer ON public.sy36_running_progs USING btree (user_name, prog_name);


--
-- Name: tm23_respond; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS tm23_respond ON public.tm23_comms_dt USING btree (task_respond_date, task_respond_time);


--
-- Name: wf25_out; Type: INDEX; Schema: public; Owner: www-data
--

CREATE INDEX IF NOT EXISTS wf25_out ON public.wf25_workflows USING btree (assigned_to, status);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO xact_bi;


--
-- Name: TABLE arb_dl01_pend_accts; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_dl01_pend_accts TO PUBLIC;
GRANT SELECT ON TABLE public.arb_dl01_pend_accts TO xact_bi;
GRANT SELECT ON TABLE public.arb_dl01_pend_accts TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_dl01_pend_accts TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib32_pallet_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib32_pallet_hd TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib32_pallet_hd TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib32_pallet_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib32_pallet_hd TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib32p_pallet_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib32p_pallet_dt TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib32p_pallet_dt TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib32p_pallet_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib32p_pallet_dt TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib33_prod_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib33_prod_dt TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib33_prod_dt TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib33_prod_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib33_prod_dt TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib33s_prod_ser; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib33s_prod_ser TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib33s_prod_ser TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib33s_prod_ser TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib33s_prod_ser TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib34_prod_adj_req; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib34_prod_adj_req TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib34_prod_adj_req TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib34_prod_adj_req TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib34_prod_adj_req TO role_write_xactdev_db;


--
-- Name: TABLE arb_ib34s_serial_adj_req; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib34s_serial_adj_req TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ib34s_serial_adj_req TO xact_bi;
GRANT SELECT ON TABLE public.arb_ib34s_serial_adj_req TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ib34s_serial_adj_req TO role_write_xactdev_db;


--
-- Name: TABLE arb_ic_xref_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_dt TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ic_xref_dt TO xact_bi;
GRANT SELECT ON TABLE public.arb_ic_xref_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_dt TO role_write_xactdev_db;


--
-- Name: TABLE arb_ic_xref_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_hd TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ic_xref_hd TO xact_bi;
GRANT SELECT ON TABLE public.arb_ic_xref_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_hd TO role_write_xactdev_db;


--
-- Name: TABLE arb_ic_xref_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_serial TO PUBLIC;
GRANT SELECT ON TABLE public.arb_ic_xref_serial TO xact_bi;
GRANT SELECT ON TABLE public.arb_ic_xref_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_ic_xref_serial TO role_write_xactdev_db;


--
-- Name: TABLE arb_pu22a_status; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_pu22a_status TO PUBLIC;
GRANT SELECT ON TABLE public.arb_pu22a_status TO xact_bi;
GRANT SELECT ON TABLE public.arb_pu22a_status TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_pu22a_status TO role_write_xactdev_db;


--
-- Name: TABLE arb_sa22_qt_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa22_qt_hd TO PUBLIC;
GRANT SELECT ON TABLE public.arb_sa22_qt_hd TO xact_bi;
GRANT SELECT ON TABLE public.arb_sa22_qt_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa22_qt_hd TO role_write_xactdev_db;


--
-- Name: TABLE arb_sa23_qt_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23_qt_dt TO PUBLIC;
GRANT SELECT ON TABLE public.arb_sa23_qt_dt TO xact_bi;
GRANT SELECT ON TABLE public.arb_sa23_qt_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23_qt_dt TO role_write_xactdev_db;


--
-- Name: TABLE arb_sa23b_qt_comp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23b_qt_comp TO PUBLIC;
GRANT SELECT ON TABLE public.arb_sa23b_qt_comp TO xact_bi;
GRANT SELECT ON TABLE public.arb_sa23b_qt_comp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23b_qt_comp TO role_write_xactdev_db;


--
-- Name: TABLE arb_sa23d_so_split; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23d_so_split TO PUBLIC;
GRANT SELECT ON TABLE public.arb_sa23d_so_split TO xact_bi;
GRANT SELECT ON TABLE public.arb_sa23d_so_split TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa23d_so_split TO role_write_xactdev_db;


--
-- Name: TABLE arb_sa290_sales_anal; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa290_sales_anal TO PUBLIC;
GRANT SELECT ON TABLE public.arb_sa290_sales_anal TO xact_bi;
GRANT SELECT ON TABLE public.arb_sa290_sales_anal TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.arb_sa290_sales_anal TO role_write_xactdev_db;


--
-- Name: TABLE bm00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.bm00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.bm00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE bm01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.bm01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.bm01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE bm03_act_res; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm03_act_res TO PUBLIC;
GRANT SELECT ON TABLE public.bm03_act_res TO xact_bi;
GRANT SELECT ON TABLE public.bm03_act_res TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm03_act_res TO role_write_xactdev_db;


--
-- Name: TABLE bm04_grp_type; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm04_grp_type TO PUBLIC;
GRANT SELECT ON TABLE public.bm04_grp_type TO xact_bi;
GRANT SELECT ON TABLE public.bm04_grp_type TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm04_grp_type TO role_write_xactdev_db;


--
-- Name: TABLE bm06_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm06_grp TO PUBLIC;
GRANT SELECT ON TABLE public.bm06_grp TO xact_bi;
GRANT SELECT ON TABLE public.bm06_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm06_grp TO role_write_xactdev_db;


--
-- Name: TABLE bm08_sub_calc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm08_sub_calc TO PUBLIC;
GRANT SELECT ON TABLE public.bm08_sub_calc TO xact_bi;
GRANT SELECT ON TABLE public.bm08_sub_calc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm08_sub_calc TO role_write_xactdev_db;


--
-- Name: TABLE bm10_bom_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm10_bom_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm10_bom_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm10_bom_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm10_bom_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm11_bom_comp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm11_bom_comp TO PUBLIC;
GRANT SELECT ON TABLE public.bm11_bom_comp TO xact_bi;
GRANT SELECT ON TABLE public.bm11_bom_comp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm11_bom_comp TO role_write_xactdev_db;


--
-- Name: TABLE bm11i_bom_inst; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm11i_bom_inst TO PUBLIC;
GRANT SELECT ON TABLE public.bm11i_bom_inst TO xact_bi;
GRANT SELECT ON TABLE public.bm11i_bom_inst TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm11i_bom_inst TO role_write_xactdev_db;


--
-- Name: TABLE bm20_rec_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm20_rec_bt TO PUBLIC;
GRANT SELECT ON TABLE public.bm20_rec_bt TO xact_bi;
GRANT SELECT ON TABLE public.bm20_rec_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm20_rec_bt TO role_write_xactdev_db;


--
-- Name: TABLE bm20i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm20i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.bm20i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.bm20i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm20i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE bm21_iss_ret_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21_iss_ret_bt TO PUBLIC;
GRANT SELECT ON TABLE public.bm21_iss_ret_bt TO xact_bi;
GRANT SELECT ON TABLE public.bm21_iss_ret_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21_iss_ret_bt TO role_write_xactdev_db;


--
-- Name: TABLE bm21i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.bm21i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.bm21i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE bm21s_iss_ret_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21s_iss_ret_serial TO PUBLIC;
GRANT SELECT ON TABLE public.bm21s_iss_ret_serial TO xact_bi;
GRANT SELECT ON TABLE public.bm21s_iss_ret_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm21s_iss_ret_serial TO role_write_xactdev_db;


--
-- Name: TABLE bm22_prod_plan_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm22_prod_plan_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm22_prod_plan_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm22_prod_plan_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm22_prod_plan_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm23_prod_plan_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23_prod_plan_dt TO PUBLIC;
GRANT SELECT ON TABLE public.bm23_prod_plan_dt TO xact_bi;
GRANT SELECT ON TABLE public.bm23_prod_plan_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23_prod_plan_dt TO role_write_xactdev_db;


--
-- Name: TABLE bm23fore_close_bal; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23fore_close_bal TO PUBLIC;
GRANT SELECT ON TABLE public.bm23fore_close_bal TO xact_bi;
GRANT SELECT ON TABLE public.bm23fore_close_bal TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23fore_close_bal TO role_write_xactdev_db;


--
-- Name: TABLE bm23po_shortfall_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23po_shortfall_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm23po_shortfall_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm23po_shortfall_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23po_shortfall_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm23r_shortfall_dt_raw; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23r_shortfall_dt_raw TO PUBLIC;
GRANT SELECT ON TABLE public.bm23r_shortfall_dt_raw TO xact_bi;
GRANT SELECT ON TABLE public.bm23r_shortfall_dt_raw TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23r_shortfall_dt_raw TO role_write_xactdev_db;


--
-- Name: TABLE bm23s_shortfall_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23s_shortfall_dt TO PUBLIC;
GRANT SELECT ON TABLE public.bm23s_shortfall_dt TO xact_bi;
GRANT SELECT ON TABLE public.bm23s_shortfall_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm23s_shortfall_dt TO role_write_xactdev_db;


--
-- Name: TABLE bm30_wo_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm30_wo_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm30_wo_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm30_wo_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm30_wo_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm31_wo_comp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm31_wo_comp TO PUBLIC;
GRANT SELECT ON TABLE public.bm31_wo_comp TO xact_bi;
GRANT SELECT ON TABLE public.bm31_wo_comp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm31_wo_comp TO role_write_xactdev_db;


--
-- Name: TABLE bm31i_wo_inst; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm31i_wo_inst TO PUBLIC;
GRANT SELECT ON TABLE public.bm31i_wo_inst TO xact_bi;
GRANT SELECT ON TABLE public.bm31i_wo_inst TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm31i_wo_inst TO role_write_xactdev_db;


--
-- Name: TABLE bm32_wo_dn_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm32_wo_dn_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm32_wo_dn_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm32_wo_dn_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm32_wo_dn_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm33_wo_dn_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm33_wo_dn_dt TO PUBLIC;
GRANT SELECT ON TABLE public.bm33_wo_dn_dt TO xact_bi;
GRANT SELECT ON TABLE public.bm33_wo_dn_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm33_wo_dn_dt TO role_write_xactdev_db;


--
-- Name: TABLE bm35_act_average; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm35_act_average TO PUBLIC;
GRANT SELECT ON TABLE public.bm35_act_average TO xact_bi;
GRANT SELECT ON TABLE public.bm35_act_average TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm35_act_average TO role_write_xactdev_db;


--
-- Name: TABLE bm38_bottleneck_batch_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm38_bottleneck_batch_hd TO PUBLIC;
GRANT SELECT ON TABLE public.bm38_bottleneck_batch_hd TO xact_bi;
GRANT SELECT ON TABLE public.bm38_bottleneck_batch_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm38_bottleneck_batch_hd TO role_write_xactdev_db;


--
-- Name: TABLE bm39m_bottleneck_material; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39m_bottleneck_material TO PUBLIC;
GRANT SELECT ON TABLE public.bm39m_bottleneck_material TO xact_bi;
GRANT SELECT ON TABLE public.bm39m_bottleneck_material TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39m_bottleneck_material TO role_write_xactdev_db;


--
-- Name: TABLE bm39p_bottleneck_pri_wo; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39p_bottleneck_pri_wo TO PUBLIC;
GRANT SELECT ON TABLE public.bm39p_bottleneck_pri_wo TO xact_bi;
GRANT SELECT ON TABLE public.bm39p_bottleneck_pri_wo TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39p_bottleneck_pri_wo TO role_write_xactdev_db;


--
-- Name: TABLE bm39s_bottleneck_sub_wo; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39s_bottleneck_sub_wo TO PUBLIC;
GRANT SELECT ON TABLE public.bm39s_bottleneck_sub_wo TO xact_bi;
GRANT SELECT ON TABLE public.bm39s_bottleneck_sub_wo TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bm39s_bottleneck_sub_wo TO role_write_xactdev_db;


--
-- Name: TABLE bo00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.bo00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.bo00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE bo01_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo01_mast TO PUBLIC;
GRANT SELECT ON TABLE public.bo01_mast TO xact_bi;
GRANT SELECT ON TABLE public.bo01_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo01_mast TO role_write_xactdev_db;


--
-- Name: TABLE bo10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.bo10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.bo10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE bo20_adj_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo20_adj_bt TO PUBLIC;
GRANT SELECT ON TABLE public.bo20_adj_bt TO xact_bi;
GRANT SELECT ON TABLE public.bo20_adj_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo20_adj_bt TO role_write_xactdev_db;


--
-- Name: TABLE bo30_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo30_tran TO PUBLIC;
GRANT SELECT ON TABLE public.bo30_tran TO xact_bi;
GRANT SELECT ON TABLE public.bo30_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bo30_tran TO role_write_xactdev_db;


--
-- Name: TABLE cb00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.cb00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.cb00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE cb00gl_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb00gl_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.cb00gl_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.cb00gl_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb00gl_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE cb01_benef_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb01_benef_mast TO PUBLIC;
GRANT SELECT ON TABLE public.cb01_benef_mast TO xact_bi;
GRANT SELECT ON TABLE public.cb01_benef_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb01_benef_mast TO role_write_xactdev_db;


--
-- Name: TABLE cb05_bank_stmt_layout; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb05_bank_stmt_layout TO PUBLIC;
GRANT SELECT ON TABLE public.cb05_bank_stmt_layout TO xact_bi;
GRANT SELECT ON TABLE public.cb05_bank_stmt_layout TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb05_bank_stmt_layout TO role_write_xactdev_db;


--
-- Name: TABLE cb05s_bank_tran_type; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb05s_bank_tran_type TO PUBLIC;
GRANT SELECT ON TABLE public.cb05s_bank_tran_type TO xact_bi;
GRANT SELECT ON TABLE public.cb05s_bank_tran_type TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb05s_bank_tran_type TO role_write_xactdev_db;


--
-- Name: TABLE cb10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.cb10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.cb10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE cb20_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb20_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.cb20_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.cb20_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb20_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE cb20gl_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb20gl_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.cb20gl_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.cb20gl_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb20gl_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE cb29_in_tray; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb29_in_tray TO PUBLIC;
GRANT SELECT ON TABLE public.cb29_in_tray TO xact_bi;
GRANT SELECT ON TABLE public.cb29_in_tray TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb29_in_tray TO role_write_xactdev_db;


--
-- Name: TABLE cb30_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb30_tran TO PUBLIC;
GRANT SELECT ON TABLE public.cb30_tran TO xact_bi;
GRANT SELECT ON TABLE public.cb30_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb30_tran TO role_write_xactdev_db;


--
-- Name: TABLE cb40_statement_import; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb40_statement_import TO PUBLIC;
GRANT SELECT ON TABLE public.cb40_statement_import TO xact_bi;
GRANT SELECT ON TABLE public.cb40_statement_import TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb40_statement_import TO role_write_xactdev_db;


--
-- Name: TABLE cb40a_arb_statement_import; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb40a_arb_statement_import TO PUBLIC;
GRANT SELECT ON TABLE public.cb40a_arb_statement_import TO xact_bi;
GRANT SELECT ON TABLE public.cb40a_arb_statement_import TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb40a_arb_statement_import TO role_write_xactdev_db;


--
-- Name: TABLE cb41_statement_import_acct; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb41_statement_import_acct TO PUBLIC;
GRANT SELECT ON TABLE public.cb41_statement_import_acct TO xact_bi;
GRANT SELECT ON TABLE public.cb41_statement_import_acct TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb41_statement_import_acct TO role_write_xactdev_db;


--
-- Name: TABLE cb42_auto_tag_match_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb42_auto_tag_match_log TO PUBLIC;
GRANT SELECT ON TABLE public.cb42_auto_tag_match_log TO xact_bi;
GRANT SELECT ON TABLE public.cb42_auto_tag_match_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cb42_auto_tag_match_log TO role_write_xactdev_db;


--
-- Name: TABLE cfs_bo00_auto_code; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cfs_bo00_auto_code TO PUBLIC;
GRANT SELECT ON TABLE public.cfs_bo00_auto_code TO xact_bi;
GRANT SELECT ON TABLE public.cfs_bo00_auto_code TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cfs_bo00_auto_code TO role_write_xactdev_db;


--
-- Name: TABLE cl00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.cl00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.cl00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE cl01_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.cl01_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01_mast TO role_write_xactdev_db;


--
-- Name: TABLE cl01a_actions; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01a_actions TO PUBLIC;
GRANT SELECT ON TABLE public.cl01a_actions TO xact_bi;
GRANT SELECT ON TABLE public.cl01a_actions TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01a_actions TO role_write_xactdev_db;


--
-- Name: TABLE cl01c_contact; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01c_contact TO PUBLIC;
GRANT SELECT ON TABLE public.cl01c_contact TO xact_bi;
GRANT SELECT ON TABLE public.cl01c_contact TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01c_contact TO role_write_xactdev_db;


--
-- Name: TABLE cl01n_notes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01n_notes TO PUBLIC;
GRANT SELECT ON TABLE public.cl01n_notes TO xact_bi;
GRANT SELECT ON TABLE public.cl01n_notes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01n_notes TO role_write_xactdev_db;


--
-- Name: TABLE cl01p_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01p_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.cl01p_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.cl01p_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01p_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE cl01r_supp_rebate; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01r_supp_rebate TO PUBLIC;
GRANT SELECT ON TABLE public.cl01r_supp_rebate TO xact_bi;
GRANT SELECT ON TABLE public.cl01r_supp_rebate TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01r_supp_rebate TO role_write_xactdev_db;


--
-- Name: TABLE cl01sc_sub_cat; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01sc_sub_cat TO PUBLIC;
GRANT SELECT ON TABLE public.cl01sc_sub_cat TO xact_bi;
GRANT SELECT ON TABLE public.cl01sc_sub_cat TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl01sc_sub_cat TO role_write_xactdev_db;


--
-- Name: TABLE cl06_cat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl06_cat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.cl06_cat_mast TO xact_bi;
GRANT SELECT ON TABLE public.cl06_cat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl06_cat_mast TO role_write_xactdev_db;


--
-- Name: TABLE cl10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.cl10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.cl10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE cl20_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl20_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.cl20_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.cl20_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl20_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE cl20gl_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl20gl_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.cl20gl_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.cl20gl_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl20gl_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE cl22_pay_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl22_pay_bt TO PUBLIC;
GRANT SELECT ON TABLE public.cl22_pay_bt TO xact_bi;
GRANT SELECT ON TABLE public.cl22_pay_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl22_pay_bt TO role_write_xactdev_db;


--
-- Name: TABLE cl22m_tr_match; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl22m_tr_match TO PUBLIC;
GRANT SELECT ON TABLE public.cl22m_tr_match TO xact_bi;
GRANT SELECT ON TABLE public.cl22m_tr_match TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl22m_tr_match TO role_write_xactdev_db;


--
-- Name: TABLE cl30_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl30_tran TO PUBLIC;
GRANT SELECT ON TABLE public.cl30_tran TO xact_bi;
GRANT SELECT ON TABLE public.cl30_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl30_tran TO role_write_xactdev_db;


--
-- Name: TABLE cl31_matched_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl31_matched_hist TO PUBLIC;
GRANT SELECT ON TABLE public.cl31_matched_hist TO xact_bi;
GRANT SELECT ON TABLE public.cl31_matched_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl31_matched_hist TO role_write_xactdev_db;


--
-- Name: TABLE cl32_unmatch_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl32_unmatch_hist TO PUBLIC;
GRANT SELECT ON TABLE public.cl32_unmatch_hist TO xact_bi;
GRANT SELECT ON TABLE public.cl32_unmatch_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl32_unmatch_hist TO role_write_xactdev_db;


--
-- Name: TABLE cl33_recon_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl33_recon_tran TO PUBLIC;
GRANT SELECT ON TABLE public.cl33_recon_tran TO xact_bi;
GRANT SELECT ON TABLE public.cl33_recon_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl33_recon_tran TO role_write_xactdev_db;


--
-- Name: TABLE cl34_deal_sheet; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34_deal_sheet TO PUBLIC;
GRANT SELECT ON TABLE public.cl34_deal_sheet TO xact_bi;
GRANT SELECT ON TABLE public.cl34_deal_sheet TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34_deal_sheet TO role_write_xactdev_db;


--
-- Name: TABLE cl34b_branch_loc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34b_branch_loc TO PUBLIC;
GRANT SELECT ON TABLE public.cl34b_branch_loc TO xact_bi;
GRANT SELECT ON TABLE public.cl34b_branch_loc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34b_branch_loc TO role_write_xactdev_db;


--
-- Name: TABLE cl34l_linked_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34l_linked_codes TO PUBLIC;
GRANT SELECT ON TABLE public.cl34l_linked_codes TO xact_bi;
GRANT SELECT ON TABLE public.cl34l_linked_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl34l_linked_codes TO role_write_xactdev_db;


--
-- Name: TABLE cl35_supplier_rebates; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl35_supplier_rebates TO PUBLIC;
GRANT SELECT ON TABLE public.cl35_supplier_rebates TO xact_bi;
GRANT SELECT ON TABLE public.cl35_supplier_rebates TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl35_supplier_rebates TO role_write_xactdev_db;


--
-- Name: TABLE cl36_supplier_rebates_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl36_supplier_rebates_dt TO PUBLIC;
GRANT SELECT ON TABLE public.cl36_supplier_rebates_dt TO xact_bi;
GRANT SELECT ON TABLE public.cl36_supplier_rebates_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl36_supplier_rebates_dt TO role_write_xactdev_db;


--
-- Name: TABLE cl37_rebate_register; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl37_rebate_register TO PUBLIC;
GRANT SELECT ON TABLE public.cl37_rebate_register TO xact_bi;
GRANT SELECT ON TABLE public.cl37_rebate_register TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl37_rebate_register TO role_write_xactdev_db;


--
-- Name: TABLE cl38_deal_register; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl38_deal_register TO PUBLIC;
GRANT SELECT ON TABLE public.cl38_deal_register TO xact_bi;
GRANT SELECT ON TABLE public.cl38_deal_register TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl38_deal_register TO role_write_xactdev_db;


--
-- Name: TABLE cl40_recon_hist_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl40_recon_hist_hd TO PUBLIC;
GRANT SELECT ON TABLE public.cl40_recon_hist_hd TO xact_bi;
GRANT SELECT ON TABLE public.cl40_recon_hist_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl40_recon_hist_hd TO role_write_xactdev_db;


--
-- Name: TABLE cl41_recon_hist_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl41_recon_hist_dt TO PUBLIC;
GRANT SELECT ON TABLE public.cl41_recon_hist_dt TO xact_bi;
GRANT SELECT ON TABLE public.cl41_recon_hist_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cl41_recon_hist_dt TO role_write_xactdev_db;


--
-- Name: TABLE cnt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cnt TO PUBLIC;
GRANT SELECT ON TABLE public.cnt TO xact_bi;
GRANT SELECT ON TABLE public.cnt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.cnt TO role_write_xactdev_db;


--
-- Name: TABLE dc_ibt_distribution_test_20250718144006; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dc_ibt_distribution_test_20250718144006 TO PUBLIC;
GRANT SELECT ON TABLE public.dc_ibt_distribution_test_20250718144006 TO xact_bi;
GRANT SELECT ON TABLE public.dc_ibt_distribution_test_20250718144006 TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dc_ibt_distribution_test_20250718144006 TO role_write_xactdev_db;


--
-- Name: TABLE dd01_tbl; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd01_tbl TO PUBLIC;
GRANT SELECT ON TABLE public.dd01_tbl TO xact_bi;
GRANT SELECT ON TABLE public.dd01_tbl TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd01_tbl TO role_write_xactdev_db;


--
-- Name: TABLE dd02_col; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd02_col TO PUBLIC;
GRANT SELECT ON TABLE public.dd02_col TO xact_bi;
GRANT SELECT ON TABLE public.dd02_col TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd02_col TO role_write_xactdev_db;


--
-- Name: TABLE dd03_idx; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd03_idx TO PUBLIC;
GRANT SELECT ON TABLE public.dd03_idx TO xact_bi;
GRANT SELECT ON TABLE public.dd03_idx TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd03_idx TO role_write_xactdev_db;


--
-- Name: TABLE dd04_user; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd04_user TO PUBLIC;
GRANT SELECT ON TABLE public.dd04_user TO xact_bi;
GRANT SELECT ON TABLE public.dd04_user TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dd04_user TO role_write_xactdev_db;


--
-- Name: TABLE dev_todos; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dev_todos TO PUBLIC;
GRANT SELECT ON TABLE public.dev_todos TO xact_bi;
GRANT SELECT ON TABLE public.dev_todos TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dev_todos TO role_write_xactdev_db;


--
-- Name: TABLE dl00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.dl00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.dl00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE dl01_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.dl01_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl01a_actions; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01a_actions TO PUBLIC;
GRANT SELECT ON TABLE public.dl01a_actions TO xact_bi;
GRANT SELECT ON TABLE public.dl01a_actions TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01a_actions TO role_write_xactdev_db;


--
-- Name: TABLE dl01c_contact; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01c_contact TO PUBLIC;
GRANT SELECT ON TABLE public.dl01c_contact TO xact_bi;
GRANT SELECT ON TABLE public.dl01c_contact TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01c_contact TO role_write_xactdev_db;


--
-- Name: TABLE dl01d_deb_stk_grp_disc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01d_deb_stk_grp_disc TO PUBLIC;
GRANT SELECT ON TABLE public.dl01d_deb_stk_grp_disc TO xact_bi;
GRANT SELECT ON TABLE public.dl01d_deb_stk_grp_disc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01d_deb_stk_grp_disc TO role_write_xactdev_db;


--
-- Name: TABLE dl01n_notes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01n_notes TO PUBLIC;
GRANT SELECT ON TABLE public.dl01n_notes TO xact_bi;
GRANT SELECT ON TABLE public.dl01n_notes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01n_notes TO role_write_xactdev_db;


--
-- Name: TABLE dl01p_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01p_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl01p_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl01p_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01p_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl01pa_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01pa_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl01pa_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl01pa_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01pa_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl01sc_sub_cat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01sc_sub_cat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl01sc_sub_cat_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl01sc_sub_cat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl01sc_sub_cat_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl02_loyalty_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl02_loyalty_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl02_loyalty_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl02_loyalty_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl02_loyalty_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl03_region_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl03_region_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl03_region_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl03_region_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl03_region_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl04_cat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04_cat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl04_cat_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl04_cat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04_cat_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl04d_cat_stk_grp_disc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04d_cat_stk_grp_disc TO PUBLIC;
GRANT SELECT ON TABLE public.dl04d_cat_stk_grp_disc TO xact_bi;
GRANT SELECT ON TABLE public.dl04d_cat_stk_grp_disc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04d_cat_stk_grp_disc TO role_write_xactdev_db;


--
-- Name: TABLE dl04sc_cat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04sc_cat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl04sc_cat_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl04sc_cat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl04sc_cat_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl05_class_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl05_class_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl05_class_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl05_class_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl05_class_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl06_rep_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06_rep_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dl06_rep_mast TO xact_bi;
GRANT SELECT ON TABLE public.dl06_rep_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06_rep_mast TO role_write_xactdev_db;


--
-- Name: TABLE dl06m_mkt_rep_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06m_mkt_rep_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl06m_mkt_rep_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl06m_mkt_rep_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06m_mkt_rep_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl06p_rep_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06p_rep_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl06p_rep_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl06p_rep_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl06p_rep_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl07o_opr_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl07o_opr_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl07o_opr_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl07o_opr_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl07o_opr_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.dl10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.dl10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE dl20_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl20_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.dl20_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.dl20_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl20_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE dl20gl_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl20gl_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.dl20gl_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.dl20gl_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl20gl_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE dl22_rec_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl22_rec_bt TO PUBLIC;
GRANT SELECT ON TABLE public.dl22_rec_bt TO xact_bi;
GRANT SELECT ON TABLE public.dl22_rec_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl22_rec_bt TO role_write_xactdev_db;


--
-- Name: TABLE dl22m_tr_match; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl22m_tr_match TO PUBLIC;
GRANT SELECT ON TABLE public.dl22m_tr_match TO xact_bi;
GRANT SELECT ON TABLE public.dl22m_tr_match TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl22m_tr_match TO role_write_xactdev_db;


--
-- Name: TABLE dl30_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl30_tran TO PUBLIC;
GRANT SELECT ON TABLE public.dl30_tran TO xact_bi;
GRANT SELECT ON TABLE public.dl30_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl30_tran TO role_write_xactdev_db;


--
-- Name: TABLE dl31_matched_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl31_matched_hist TO PUBLIC;
GRANT SELECT ON TABLE public.dl31_matched_hist TO xact_bi;
GRANT SELECT ON TABLE public.dl31_matched_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl31_matched_hist TO role_write_xactdev_db;


--
-- Name: TABLE dl32_unmatch_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl32_unmatch_hist TO PUBLIC;
GRANT SELECT ON TABLE public.dl32_unmatch_hist TO xact_bi;
GRANT SELECT ON TABLE public.dl32_unmatch_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl32_unmatch_hist TO role_write_xactdev_db;


--
-- Name: TABLE dl33_deposits; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl33_deposits TO PUBLIC;
GRANT SELECT ON TABLE public.dl33_deposits TO xact_bi;
GRANT SELECT ON TABLE public.dl33_deposits TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl33_deposits TO role_write_xactdev_db;


--
-- Name: TABLE dl40_stmt_hist_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl40_stmt_hist_hd TO PUBLIC;
GRANT SELECT ON TABLE public.dl40_stmt_hist_hd TO xact_bi;
GRANT SELECT ON TABLE public.dl40_stmt_hist_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl40_stmt_hist_hd TO role_write_xactdev_db;


--
-- Name: TABLE dl41_stmt_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl41_stmt_dt TO PUBLIC;
GRANT SELECT ON TABLE public.dl41_stmt_dt TO xact_bi;
GRANT SELECT ON TABLE public.dl41_stmt_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dl41_stmt_dt TO role_write_xactdev_db;


--
-- Name: TABLE dx01d_db_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx01d_db_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dx01d_db_mast TO xact_bi;
GRANT SELECT ON TABLE public.dx01d_db_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx01d_db_mast TO role_write_xactdev_db;


--
-- Name: TABLE dx01s_server_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx01s_server_mast TO PUBLIC;
GRANT SELECT ON TABLE public.dx01s_server_mast TO xact_bi;
GRANT SELECT ON TABLE public.dx01s_server_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx01s_server_mast TO role_write_xactdev_db;


--
-- Name: TABLE dx02_mobile_users; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx02_mobile_users TO PUBLIC;
GRANT SELECT ON TABLE public.dx02_mobile_users TO xact_bi;
GRANT SELECT ON TABLE public.dx02_mobile_users TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.dx02_mobile_users TO role_write_xactdev_db;


--
-- Name: TABLE gl00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.gl00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.gl00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE gl01_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl01_mast TO PUBLIC;
GRANT SELECT ON TABLE public.gl01_mast TO xact_bi;
GRANT SELECT ON TABLE public.gl01_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl01_mast TO role_write_xactdev_db;


--
-- Name: TABLE gl02_loc_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl02_loc_mast TO PUBLIC;
GRANT SELECT ON TABLE public.gl02_loc_mast TO xact_bi;
GRANT SELECT ON TABLE public.gl02_loc_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl02_loc_mast TO role_write_xactdev_db;


--
-- Name: TABLE gl02wt_module; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl02wt_module TO PUBLIC;
GRANT SELECT ON TABLE public.gl02wt_module TO xact_bi;
GRANT SELECT ON TABLE public.gl02wt_module TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl02wt_module TO role_write_xactdev_db;


--
-- Name: TABLE gl03f_fiscal_bal; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl03f_fiscal_bal TO PUBLIC;
GRANT SELECT ON TABLE public.gl03f_fiscal_bal TO xact_bi;
GRANT SELECT ON TABLE public.gl03f_fiscal_bal TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl03f_fiscal_bal TO role_write_xactdev_db;


--
-- Name: TABLE gl03p_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl03p_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.gl03p_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.gl03p_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl03p_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE gl04_region_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl04_region_mast TO PUBLIC;
GRANT SELECT ON TABLE public.gl04_region_mast TO xact_bi;
GRANT SELECT ON TABLE public.gl04_region_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl04_region_mast TO role_write_xactdev_db;


--
-- Name: TABLE gl05_report_notes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl05_report_notes TO PUBLIC;
GRANT SELECT ON TABLE public.gl05_report_notes TO xact_bi;
GRANT SELECT ON TABLE public.gl05_report_notes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl05_report_notes TO role_write_xactdev_db;


--
-- Name: TABLE gl06_report_title; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl06_report_title TO PUBLIC;
GRANT SELECT ON TABLE public.gl06_report_title TO xact_bi;
GRANT SELECT ON TABLE public.gl06_report_title TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl06_report_title TO role_write_xactdev_db;


--
-- Name: TABLE gl07_report_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl07_report_hd TO PUBLIC;
GRANT SELECT ON TABLE public.gl07_report_hd TO xact_bi;
GRANT SELECT ON TABLE public.gl07_report_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl07_report_hd TO role_write_xactdev_db;


--
-- Name: TABLE gl08_report_col; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl08_report_col TO PUBLIC;
GRANT SELECT ON TABLE public.gl08_report_col TO xact_bi;
GRANT SELECT ON TABLE public.gl08_report_col TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl08_report_col TO role_write_xactdev_db;


--
-- Name: TABLE gl09_report_lines; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl09_report_lines TO PUBLIC;
GRANT SELECT ON TABLE public.gl09_report_lines TO xact_bi;
GRANT SELECT ON TABLE public.gl09_report_lines TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl09_report_lines TO role_write_xactdev_db;


--
-- Name: TABLE gl10_import_layout; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10_import_layout TO PUBLIC;
GRANT SELECT ON TABLE public.gl10_import_layout TO xact_bi;
GRANT SELECT ON TABLE public.gl10_import_layout TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10_import_layout TO role_write_xactdev_db;


--
-- Name: TABLE gl10c_company_type; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10c_company_type TO PUBLIC;
GRANT SELECT ON TABLE public.gl10c_company_type TO xact_bi;
GRANT SELECT ON TABLE public.gl10c_company_type TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10c_company_type TO role_write_xactdev_db;


--
-- Name: TABLE gl10l_loc_type; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10l_loc_type TO PUBLIC;
GRANT SELECT ON TABLE public.gl10l_loc_type TO xact_bi;
GRANT SELECT ON TABLE public.gl10l_loc_type TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl10l_loc_type TO role_write_xactdev_db;


--
-- Name: TABLE gl12_map_alloc_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl12_map_alloc_mast TO PUBLIC;
GRANT SELECT ON TABLE public.gl12_map_alloc_mast TO xact_bi;
GRANT SELECT ON TABLE public.gl12_map_alloc_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl12_map_alloc_mast TO role_write_xactdev_db;


--
-- Name: TABLE gl20_jnl_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl20_jnl_bt TO PUBLIC;
GRANT SELECT ON TABLE public.gl20_jnl_bt TO xact_bi;
GRANT SELECT ON TABLE public.gl20_jnl_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl20_jnl_bt TO role_write_xactdev_db;


--
-- Name: TABLE gl29_in_tray; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl29_in_tray TO PUBLIC;
GRANT SELECT ON TABLE public.gl29_in_tray TO xact_bi;
GRANT SELECT ON TABLE public.gl29_in_tray TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl29_in_tray TO role_write_xactdev_db;


--
-- Name: TABLE gl30_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl30_tran TO PUBLIC;
GRANT SELECT ON TABLE public.gl30_tran TO xact_bi;
GRANT SELECT ON TABLE public.gl30_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.gl30_tran TO role_write_xactdev_db;


--
-- Name: TABLE ha_st01l_label; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ha_st01l_label TO PUBLIC;
GRANT SELECT ON TABLE public.ha_st01l_label TO xact_bi;
GRANT SELECT ON TABLE public.ha_st01l_label TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ha_st01l_label TO role_write_xactdev_db;


--
-- Name: TABLE ib00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.ib00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.ib00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE ib01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.ib01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.ib01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE ib20_req_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib20_req_hd TO PUBLIC;
GRANT SELECT ON TABLE public.ib20_req_hd TO xact_bi;
GRANT SELECT ON TABLE public.ib20_req_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib20_req_hd TO role_write_xactdev_db;


--
-- Name: TABLE ib21_req_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib21_req_dt TO PUBLIC;
GRANT SELECT ON TABLE public.ib21_req_dt TO xact_bi;
GRANT SELECT ON TABLE public.ib21_req_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib21_req_dt TO role_write_xactdev_db;


--
-- Name: TABLE ib24_ib_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib24_ib_hd TO PUBLIC;
GRANT SELECT ON TABLE public.ib24_ib_hd TO xact_bi;
GRANT SELECT ON TABLE public.ib24_ib_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib24_ib_hd TO role_write_xactdev_db;


--
-- Name: TABLE ib25_ib_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25_ib_dt TO PUBLIC;
GRANT SELECT ON TABLE public.ib25_ib_dt TO xact_bi;
GRANT SELECT ON TABLE public.ib25_ib_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25_ib_dt TO role_write_xactdev_db;


--
-- Name: TABLE ib25i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.ib25i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.ib25i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE ib25s_ib_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25s_ib_serial TO PUBLIC;
GRANT SELECT ON TABLE public.ib25s_ib_serial TO xact_bi;
GRANT SELECT ON TABLE public.ib25s_ib_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib25s_ib_serial TO role_write_xactdev_db;


--
-- Name: TABLE ib30_ship_doc_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib30_ship_doc_hd TO PUBLIC;
GRANT SELECT ON TABLE public.ib30_ship_doc_hd TO xact_bi;
GRANT SELECT ON TABLE public.ib30_ship_doc_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib30_ship_doc_hd TO role_write_xactdev_db;


--
-- Name: TABLE ib31_ship_doc_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31_ship_doc_dt TO PUBLIC;
GRANT SELECT ON TABLE public.ib31_ship_doc_dt TO xact_bi;
GRANT SELECT ON TABLE public.ib31_ship_doc_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31_ship_doc_dt TO role_write_xactdev_db;


--
-- Name: TABLE ib31i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.ib31i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.ib31i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE ib31p_ship_pallet; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31p_ship_pallet TO PUBLIC;
GRANT SELECT ON TABLE public.ib31p_ship_pallet TO xact_bi;
GRANT SELECT ON TABLE public.ib31p_ship_pallet TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31p_ship_pallet TO role_write_xactdev_db;


--
-- Name: TABLE ib31s_ship_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31s_ship_serial TO PUBLIC;
GRANT SELECT ON TABLE public.ib31s_ship_serial TO xact_bi;
GRANT SELECT ON TABLE public.ib31s_ship_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ib31s_ship_serial TO role_write_xactdev_db;


--
-- Name: TABLE it_sa06_mth_inv_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa06_mth_inv_hd TO PUBLIC;
GRANT SELECT ON TABLE public.it_sa06_mth_inv_hd TO xact_bi;
GRANT SELECT ON TABLE public.it_sa06_mth_inv_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa06_mth_inv_hd TO role_write_xactdev_db;


--
-- Name: TABLE it_sa07_mth_inv_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa07_mth_inv_dt TO PUBLIC;
GRANT SELECT ON TABLE public.it_sa07_mth_inv_dt TO xact_bi;
GRANT SELECT ON TABLE public.it_sa07_mth_inv_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa07_mth_inv_dt TO role_write_xactdev_db;


--
-- Name: TABLE it_sa08_mth_grn; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa08_mth_grn TO PUBLIC;
GRANT SELECT ON TABLE public.it_sa08_mth_grn TO xact_bi;
GRANT SELECT ON TABLE public.it_sa08_mth_grn TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.it_sa08_mth_grn TO role_write_xactdev_db;


--
-- Name: TABLE ita01_asset; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita01_asset TO PUBLIC;
GRANT SELECT ON TABLE public.ita01_asset TO xact_bi;
GRANT SELECT ON TABLE public.ita01_asset TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita01_asset TO role_write_xactdev_db;


--
-- Name: TABLE ita02_users; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita02_users TO PUBLIC;
GRANT SELECT ON TABLE public.ita02_users TO xact_bi;
GRANT SELECT ON TABLE public.ita02_users TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita02_users TO role_write_xactdev_db;


--
-- Name: TABLE ita03_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita03_log TO PUBLIC;
GRANT SELECT ON TABLE public.ita03_log TO xact_bi;
GRANT SELECT ON TABLE public.ita03_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita03_log TO role_write_xactdev_db;


--
-- Name: TABLE ita04_hdrive; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita04_hdrive TO PUBLIC;
GRANT SELECT ON TABLE public.ita04_hdrive TO xact_bi;
GRANT SELECT ON TABLE public.ita04_hdrive TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.ita04_hdrive TO role_write_xactdev_db;


--
-- Name: TABLE jc00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.jc00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.jc00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE jc00_sys_opt_old; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc00_sys_opt_old TO PUBLIC;
GRANT SELECT ON TABLE public.jc00_sys_opt_old TO xact_bi;
GRANT SELECT ON TABLE public.jc00_sys_opt_old TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc00_sys_opt_old TO role_write_xactdev_db;


--
-- Name: TABLE jc01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.jc01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.jc01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE jc20_est_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc20_est_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc20_est_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc20_est_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc20_est_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc21_est_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc21_est_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc21_est_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc21_est_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc21_est_dt TO role_write_xactdev_db;


--
-- Name: TABLE jc21b_est_bom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc21b_est_bom TO PUBLIC;
GRANT SELECT ON TABLE public.jc21b_est_bom TO xact_bi;
GRANT SELECT ON TABLE public.jc21b_est_bom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc21b_est_bom TO role_write_xactdev_db;


--
-- Name: TABLE jc24_jc_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc24_jc_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc24_jc_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc24_jc_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc24_jc_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc25_jc_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc25_jc_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc25_jc_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc25_jc_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc25_jc_dt TO role_write_xactdev_db;


--
-- Name: TABLE jc25b_jc_bom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc25b_jc_bom TO PUBLIC;
GRANT SELECT ON TABLE public.jc25b_jc_bom TO xact_bi;
GRANT SELECT ON TABLE public.jc25b_jc_bom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc25b_jc_bom TO role_write_xactdev_db;


--
-- Name: TABLE jc26_shortfall_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc26_shortfall_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc26_shortfall_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc26_shortfall_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc26_shortfall_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc27_shortfall_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc27_shortfall_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc27_shortfall_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc27_shortfall_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc27_shortfall_dt TO role_write_xactdev_db;


--
-- Name: TABLE jc27r_shortfall_raw; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc27r_shortfall_raw TO PUBLIC;
GRANT SELECT ON TABLE public.jc27r_shortfall_raw TO xact_bi;
GRANT SELECT ON TABLE public.jc27r_shortfall_raw TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc27r_shortfall_raw TO role_write_xactdev_db;


--
-- Name: TABLE jc28_itp_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc28_itp_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc28_itp_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc28_itp_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc28_itp_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc29_ipt_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29_ipt_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc29_ipt_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc29_ipt_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29_ipt_dt TO role_write_xactdev_db;


--
-- Name: TABLE jc29i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.jc29i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.jc29i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE jc29s_itp_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29s_itp_serial TO PUBLIC;
GRANT SELECT ON TABLE public.jc29s_itp_serial TO xact_bi;
GRANT SELECT ON TABLE public.jc29s_itp_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc29s_itp_serial TO role_write_xactdev_db;


--
-- Name: TABLE jc30_ship_doc_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc30_ship_doc_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc30_ship_doc_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc30_ship_doc_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc30_ship_doc_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc31_ship_doc_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc31_ship_doc_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc31_ship_doc_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc31_ship_doc_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc31_ship_doc_dt TO role_write_xactdev_db;


--
-- Name: TABLE jc31s_ship_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc31s_ship_serial TO PUBLIC;
GRANT SELECT ON TABLE public.jc31s_ship_serial TO xact_bi;
GRANT SELECT ON TABLE public.jc31s_ship_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc31s_ship_serial TO role_write_xactdev_db;


--
-- Name: TABLE jc32_claims_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc32_claims_hd TO PUBLIC;
GRANT SELECT ON TABLE public.jc32_claims_hd TO xact_bi;
GRANT SELECT ON TABLE public.jc32_claims_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc32_claims_hd TO role_write_xactdev_db;


--
-- Name: TABLE jc33_claims_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc33_claims_dt TO PUBLIC;
GRANT SELECT ON TABLE public.jc33_claims_dt TO xact_bi;
GRANT SELECT ON TABLE public.jc33_claims_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.jc33_claims_dt TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc20_est_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc20_est_hd TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc20_est_hd TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc20_est_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc20_est_hd TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc21_est_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc21_est_dt TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc21_est_dt TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc21_est_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc21_est_dt TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc21b_est_bom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc21b_est_bom TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc21b_est_bom TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc21b_est_bom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc21b_est_bom TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc24_jc_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc24_jc_hd TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc24_jc_hd TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc24_jc_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc24_jc_hd TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc25_jc_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc25_jc_dt TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc25_jc_dt TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc25_jc_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc25_jc_dt TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc25b_jc_bom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc25b_jc_bom TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc25b_jc_bom TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc25b_jc_bom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc25b_jc_bom TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc26_shortfall_po_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc26_shortfall_po_hd TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc26_shortfall_po_hd TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc26_shortfall_po_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc26_shortfall_po_hd TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc27_shortfall_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc27_shortfall_dt TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc27_shortfall_dt TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc27_shortfall_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc27_shortfall_dt TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc27r_shortfall_raw; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc27r_shortfall_raw TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc27r_shortfall_raw TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc27r_shortfall_raw TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc27r_shortfall_raw TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc37_jc_dn_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc37_jc_dn_hd TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc37_jc_dn_hd TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc37_jc_dn_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc37_jc_dn_hd TO role_write_xactdev_db;


--
-- Name: TABLE kf_jc38_jc_dn_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc38_jc_dn_dt TO PUBLIC;
GRANT SELECT ON TABLE public.kf_jc38_jc_dn_dt TO xact_bi;
GRANT SELECT ON TABLE public.kf_jc38_jc_dn_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.kf_jc38_jc_dn_dt TO role_write_xactdev_db;


--
-- Name: TABLE lpf_bm30_wo_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_bm30_wo_hd TO PUBLIC;
GRANT SELECT ON TABLE public.lpf_bm30_wo_hd TO xact_bi;
GRANT SELECT ON TABLE public.lpf_bm30_wo_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_bm30_wo_hd TO role_write_xactdev_db;


--
-- Name: TABLE lpf_bm31_wo_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_bm31_wo_dt TO PUBLIC;
GRANT SELECT ON TABLE public.lpf_bm31_wo_dt TO xact_bi;
GRANT SELECT ON TABLE public.lpf_bm31_wo_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_bm31_wo_dt TO role_write_xactdev_db;


--
-- Name: TABLE lpf_sa22_qt_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_sa22_qt_hd TO PUBLIC;
GRANT SELECT ON TABLE public.lpf_sa22_qt_hd TO xact_bi;
GRANT SELECT ON TABLE public.lpf_sa22_qt_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_sa22_qt_hd TO role_write_xactdev_db;


--
-- Name: TABLE lpf_sa23_qt_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_sa23_qt_dt TO PUBLIC;
GRANT SELECT ON TABLE public.lpf_sa23_qt_dt TO xact_bi;
GRANT SELECT ON TABLE public.lpf_sa23_qt_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_sa23_qt_dt TO role_write_xactdev_db;


--
-- Name: TABLE lpf_st01_mat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_st01_mat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.lpf_st01_mat_mast TO xact_bi;
GRANT SELECT ON TABLE public.lpf_st01_mat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpf_st01_mat_mast TO role_write_xactdev_db;


--
-- Name: TABLE lpftest; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpftest TO PUBLIC;
GRANT SELECT ON TABLE public.lpftest TO xact_bi;
GRANT SELECT ON TABLE public.lpftest TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.lpftest TO role_write_xactdev_db;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: public; Owner: postgres
--

REVOKE SELECT ON TABLE public.pg_stat_statements FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO PUBLIC;
GRANT SELECT ON TABLE public.pg_stat_statements TO xact_bi;
GRANT SELECT ON TABLE public.pg_stat_statements TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements TO role_write_xactdev_db;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: public; Owner: postgres
--

REVOKE SELECT ON TABLE public.pg_stat_statements_info FROM PUBLIC;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements_info TO PUBLIC;
GRANT SELECT ON TABLE public.pg_stat_statements_info TO xact_bi;
GRANT SELECT ON TABLE public.pg_stat_statements_info TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pg_stat_statements_info TO role_write_xactdev_db;


--
-- Name: TABLE pos00_till_profile; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos00_till_profile TO PUBLIC;
GRANT SELECT ON TABLE public.pos00_till_profile TO xact_bi;
GRANT SELECT ON TABLE public.pos00_till_profile TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos00_till_profile TO role_write_xactdev_db;


--
-- Name: TABLE pos01_linked_users; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos01_linked_users TO PUBLIC;
GRANT SELECT ON TABLE public.pos01_linked_users TO xact_bi;
GRANT SELECT ON TABLE public.pos01_linked_users TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos01_linked_users TO role_write_xactdev_db;


--
-- Name: TABLE pos02_cashup; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos02_cashup TO PUBLIC;
GRANT SELECT ON TABLE public.pos02_cashup TO xact_bi;
GRANT SELECT ON TABLE public.pos02_cashup TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos02_cashup TO role_write_xactdev_db;


--
-- Name: TABLE pos03_cashup_corrections; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos03_cashup_corrections TO PUBLIC;
GRANT SELECT ON TABLE public.pos03_cashup_corrections TO xact_bi;
GRANT SELECT ON TABLE public.pos03_cashup_corrections TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos03_cashup_corrections TO role_write_xactdev_db;


--
-- Name: TABLE pos04_cash_drop; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos04_cash_drop TO PUBLIC;
GRANT SELECT ON TABLE public.pos04_cash_drop TO xact_bi;
GRANT SELECT ON TABLE public.pos04_cash_drop TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos04_cash_drop TO role_write_xactdev_db;


--
-- Name: TABLE pos05_cash_drop_maint; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos05_cash_drop_maint TO PUBLIC;
GRANT SELECT ON TABLE public.pos05_cash_drop_maint TO xact_bi;
GRANT SELECT ON TABLE public.pos05_cash_drop_maint TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos05_cash_drop_maint TO role_write_xactdev_db;


--
-- Name: TABLE pos06_merchant_id; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos06_merchant_id TO PUBLIC;
GRANT SELECT ON TABLE public.pos06_merchant_id TO xact_bi;
GRANT SELECT ON TABLE public.pos06_merchant_id TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos06_merchant_id TO role_write_xactdev_db;


--
-- Name: TABLE pos07_card_maint; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos07_card_maint TO PUBLIC;
GRANT SELECT ON TABLE public.pos07_card_maint TO xact_bi;
GRANT SELECT ON TABLE public.pos07_card_maint TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos07_card_maint TO role_write_xactdev_db;


--
-- Name: TABLE pos20_pos_expenses; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos20_pos_expenses TO PUBLIC;
GRANT SELECT ON TABLE public.pos20_pos_expenses TO xact_bi;
GRANT SELECT ON TABLE public.pos20_pos_expenses TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos20_pos_expenses TO role_write_xactdev_db;


--
-- Name: TABLE pos20gl_expenses_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos20gl_expenses_bt TO PUBLIC;
GRANT SELECT ON TABLE public.pos20gl_expenses_bt TO xact_bi;
GRANT SELECT ON TABLE public.pos20gl_expenses_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos20gl_expenses_bt TO role_write_xactdev_db;


--
-- Name: TABLE pos21_pos_controller_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos21_pos_controller_hd TO PUBLIC;
GRANT SELECT ON TABLE public.pos21_pos_controller_hd TO xact_bi;
GRANT SELECT ON TABLE public.pos21_pos_controller_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos21_pos_controller_hd TO role_write_xactdev_db;


--
-- Name: TABLE pos22_shortage_ctrl; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos22_shortage_ctrl TO PUBLIC;
GRANT SELECT ON TABLE public.pos22_shortage_ctrl TO xact_bi;
GRANT SELECT ON TABLE public.pos22_shortage_ctrl TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos22_shortage_ctrl TO role_write_xactdev_db;


--
-- Name: TABLE pos30_card_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos30_card_tran TO PUBLIC;
GRANT SELECT ON TABLE public.pos30_card_tran TO xact_bi;
GRANT SELECT ON TABLE public.pos30_card_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pos30_card_tran TO role_write_xactdev_db;


--
-- Name: TABLE pu00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.pu00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE pu01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.pu01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.pu01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE pu10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.pu10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.pu10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE pu22_po_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu22_po_hd TO PUBLIC;
GRANT SELECT ON TABLE public.pu22_po_hd TO xact_bi;
GRANT SELECT ON TABLE public.pu22_po_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu22_po_hd TO role_write_xactdev_db;


--
-- Name: TABLE pu23_po_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23_po_dt TO PUBLIC;
GRANT SELECT ON TABLE public.pu23_po_dt TO xact_bi;
GRANT SELECT ON TABLE public.pu23_po_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23_po_dt TO role_write_xactdev_db;


--
-- Name: TABLE pu23d_po_split; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23d_po_split TO PUBLIC;
GRANT SELECT ON TABLE public.pu23d_po_split TO xact_bi;
GRANT SELECT ON TABLE public.pu23d_po_split TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23d_po_split TO role_write_xactdev_db;


--
-- Name: TABLE pu23ds_deals; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23ds_deals TO PUBLIC;
GRANT SELECT ON TABLE public.pu23ds_deals TO xact_bi;
GRANT SELECT ON TABLE public.pu23ds_deals TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23ds_deals TO role_write_xactdev_db;


--
-- Name: TABLE pu23i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.pu23i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE pu23ic_import_costs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23ic_import_costs TO PUBLIC;
GRANT SELECT ON TABLE public.pu23ic_import_costs TO xact_bi;
GRANT SELECT ON TABLE public.pu23ic_import_costs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23ic_import_costs TO role_write_xactdev_db;


--
-- Name: TABLE pu23r_rebates; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23r_rebates TO PUBLIC;
GRANT SELECT ON TABLE public.pu23r_rebates TO xact_bi;
GRANT SELECT ON TABLE public.pu23r_rebates TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23r_rebates TO role_write_xactdev_db;


--
-- Name: TABLE pu23s_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.pu23s_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23s_serial TO role_write_xactdev_db;


--
-- Name: TABLE pu23t_tally; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.pu23t_tally TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu23t_tally TO role_write_xactdev_db;


--
-- Name: TABLE pu25_grn_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu25_grn_hd TO PUBLIC;
GRANT SELECT ON TABLE public.pu25_grn_hd TO xact_bi;
GRANT SELECT ON TABLE public.pu25_grn_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu25_grn_hd TO role_write_xactdev_db;


--
-- Name: TABLE pu26_grn_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26_grn_dt TO PUBLIC;
GRANT SELECT ON TABLE public.pu26_grn_dt TO xact_bi;
GRANT SELECT ON TABLE public.pu26_grn_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26_grn_dt TO role_write_xactdev_db;


--
-- Name: TABLE pu26i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.pu26i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.pu26i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE pu26ic_import_costs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26ic_import_costs TO PUBLIC;
GRANT SELECT ON TABLE public.pu26ic_import_costs TO xact_bi;
GRANT SELECT ON TABLE public.pu26ic_import_costs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26ic_import_costs TO role_write_xactdev_db;


--
-- Name: TABLE pu26s_grn_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26s_grn_serial TO PUBLIC;
GRANT SELECT ON TABLE public.pu26s_grn_serial TO xact_bi;
GRANT SELECT ON TABLE public.pu26s_grn_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26s_grn_serial TO role_write_xactdev_db;


--
-- Name: TABLE pu26t_tally; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.pu26t_tally TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.pu26t_tally TO role_write_xactdev_db;


--
-- Name: TABLE px01_report_data; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px01_report_data TO PUBLIC;
GRANT SELECT ON TABLE public.px01_report_data TO xact_bi;
GRANT SELECT ON TABLE public.px01_report_data TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px01_report_data TO role_write_xactdev_db;


--
-- Name: TABLE px02_sip_buddies; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px02_sip_buddies TO PUBLIC;
GRANT SELECT ON TABLE public.px02_sip_buddies TO xact_bi;
GRANT SELECT ON TABLE public.px02_sip_buddies TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px02_sip_buddies TO role_write_xactdev_db;


--
-- Name: TABLE px03_rates; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px03_rates TO PUBLIC;
GRANT SELECT ON TABLE public.px03_rates TO xact_bi;
GRANT SELECT ON TABLE public.px03_rates TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.px03_rates TO role_write_xactdev_db;


--
-- Name: TABLE sa00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.sa00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.sa00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE sa01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.sa01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.sa01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE sa02_quote_terms; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa02_quote_terms TO PUBLIC;
GRANT SELECT ON TABLE public.sa02_quote_terms TO xact_bi;
GRANT SELECT ON TABLE public.sa02_quote_terms TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa02_quote_terms TO role_write_xactdev_db;


--
-- Name: TABLE sa03_qt_reasons; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa03_qt_reasons TO PUBLIC;
GRANT SELECT ON TABLE public.sa03_qt_reasons TO xact_bi;
GRANT SELECT ON TABLE public.sa03_qt_reasons TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa03_qt_reasons TO role_write_xactdev_db;


--
-- Name: TABLE sa04_qt_availability; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa04_qt_availability TO PUBLIC;
GRANT SELECT ON TABLE public.sa04_qt_availability TO xact_bi;
GRANT SELECT ON TABLE public.sa04_qt_availability TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa04_qt_availability TO role_write_xactdev_db;


--
-- Name: TABLE sa05_cnote_reasons; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa05_cnote_reasons TO PUBLIC;
GRANT SELECT ON TABLE public.sa05_cnote_reasons TO xact_bi;
GRANT SELECT ON TABLE public.sa05_cnote_reasons TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa05_cnote_reasons TO role_write_xactdev_db;


--
-- Name: TABLE sa10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.sa10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.sa10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE sa20_ic_sales_links; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa20_ic_sales_links TO PUBLIC;
GRANT SELECT ON TABLE public.sa20_ic_sales_links TO xact_bi;
GRANT SELECT ON TABLE public.sa20_ic_sales_links TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa20_ic_sales_links TO role_write_xactdev_db;


--
-- Name: TABLE sa22_qt_so_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22_qt_so_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sa22_qt_so_hd TO xact_bi;
GRANT SELECT ON TABLE public.sa22_qt_so_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22_qt_so_hd TO role_write_xactdev_db;


--
-- Name: TABLE sa22_qt_so_hd_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22_qt_so_hd_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa22_qt_so_hd_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa22_qt_so_hd_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22_qt_so_hd_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa22a_qt_action; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22a_qt_action TO PUBLIC;
GRANT SELECT ON TABLE public.sa22a_qt_action TO xact_bi;
GRANT SELECT ON TABLE public.sa22a_qt_action TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22a_qt_action TO role_write_xactdev_db;


--
-- Name: TABLE sa22a_qt_action_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22a_qt_action_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa22a_qt_action_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa22a_qt_action_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa22a_qt_action_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa23_qt_so_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23_qt_so_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sa23_qt_so_dt TO xact_bi;
GRANT SELECT ON TABLE public.sa23_qt_so_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23_qt_so_dt TO role_write_xactdev_db;


--
-- Name: TABLE sa23_qt_so_dt_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23_qt_so_dt_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa23_qt_so_dt_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa23_qt_so_dt_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23_qt_so_dt_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa23a_reason_code; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23a_reason_code TO PUBLIC;
GRANT SELECT ON TABLE public.sa23a_reason_code TO xact_bi;
GRANT SELECT ON TABLE public.sa23a_reason_code TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23a_reason_code TO role_write_xactdev_db;


--
-- Name: TABLE sa23d_so_split; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23d_so_split TO PUBLIC;
GRANT SELECT ON TABLE public.sa23d_so_split TO xact_bi;
GRANT SELECT ON TABLE public.sa23d_so_split TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23d_so_split TO role_write_xactdev_db;


--
-- Name: TABLE sa23d_so_split_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23d_so_split_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa23d_so_split_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa23d_so_split_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23d_so_split_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa23m_qt_comp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23m_qt_comp TO PUBLIC;
GRANT SELECT ON TABLE public.sa23m_qt_comp TO xact_bi;
GRANT SELECT ON TABLE public.sa23m_qt_comp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23m_qt_comp TO role_write_xactdev_db;


--
-- Name: TABLE sa23m_qt_comp_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23m_qt_comp_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa23m_qt_comp_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa23m_qt_comp_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23m_qt_comp_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa23q_quote_req; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23q_quote_req TO PUBLIC;
GRANT SELECT ON TABLE public.sa23q_quote_req TO xact_bi;
GRANT SELECT ON TABLE public.sa23q_quote_req TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23q_quote_req TO role_write_xactdev_db;


--
-- Name: TABLE sa23s_so_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23s_so_serial TO PUBLIC;
GRANT SELECT ON TABLE public.sa23s_so_serial TO xact_bi;
GRANT SELECT ON TABLE public.sa23s_so_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23s_so_serial TO role_write_xactdev_db;


--
-- Name: TABLE sa23s_so_serial_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23s_so_serial_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa23s_so_serial_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa23s_so_serial_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23s_so_serial_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa23t_qt_terms; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23t_qt_terms TO PUBLIC;
GRANT SELECT ON TABLE public.sa23t_qt_terms TO xact_bi;
GRANT SELECT ON TABLE public.sa23t_qt_terms TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23t_qt_terms TO role_write_xactdev_db;


--
-- Name: TABLE sa23t_qt_terms_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23t_qt_terms_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa23t_qt_terms_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa23t_qt_terms_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa23t_qt_terms_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa25_inv_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa25_inv_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sa25_inv_hd TO xact_bi;
GRANT SELECT ON TABLE public.sa25_inv_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa25_inv_hd TO role_write_xactdev_db;


--
-- Name: TABLE sa25_inv_hd_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa25_inv_hd_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa25_inv_hd_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa25_inv_hd_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa25_inv_hd_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa26_inv_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26_inv_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sa26_inv_dt TO xact_bi;
GRANT SELECT ON TABLE public.sa26_inv_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26_inv_dt TO role_write_xactdev_db;


--
-- Name: TABLE sa26_inv_dt_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26_inv_dt_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa26_inv_dt_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa26_inv_dt_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26_inv_dt_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa26a_reason_code; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26a_reason_code TO PUBLIC;
GRANT SELECT ON TABLE public.sa26a_reason_code TO xact_bi;
GRANT SELECT ON TABLE public.sa26a_reason_code TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26a_reason_code TO role_write_xactdev_db;


--
-- Name: TABLE sa26e_api_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26e_api_tran TO PUBLIC;
GRANT SELECT ON TABLE public.sa26e_api_tran TO xact_bi;
GRANT SELECT ON TABLE public.sa26e_api_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26e_api_tran TO role_write_xactdev_db;


--
-- Name: TABLE sa26i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.sa26i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.sa26i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE sa26i_bin_alloc_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26i_bin_alloc_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa26i_bin_alloc_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa26i_bin_alloc_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26i_bin_alloc_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa26m_inv_comp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26m_inv_comp TO PUBLIC;
GRANT SELECT ON TABLE public.sa26m_inv_comp TO xact_bi;
GRANT SELECT ON TABLE public.sa26m_inv_comp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26m_inv_comp TO role_write_xactdev_db;


--
-- Name: TABLE sa26m_inv_comp_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26m_inv_comp_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa26m_inv_comp_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa26m_inv_comp_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26m_inv_comp_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa26r_cnote_reason; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26r_cnote_reason TO PUBLIC;
GRANT SELECT ON TABLE public.sa26r_cnote_reason TO xact_bi;
GRANT SELECT ON TABLE public.sa26r_cnote_reason TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26r_cnote_reason TO role_write_xactdev_db;


--
-- Name: TABLE sa26r_cnote_reason_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26r_cnote_reason_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa26r_cnote_reason_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa26r_cnote_reason_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26r_cnote_reason_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa26s_inv_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26s_inv_serial TO PUBLIC;
GRANT SELECT ON TABLE public.sa26s_inv_serial TO xact_bi;
GRANT SELECT ON TABLE public.sa26s_inv_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26s_inv_serial TO role_write_xactdev_db;


--
-- Name: TABLE sa26s_inv_serial_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26s_inv_serial_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sa26s_inv_serial_arch TO xact_bi;
GRANT SELECT ON TABLE public.sa26s_inv_serial_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa26s_inv_serial_arch TO role_write_xactdev_db;


--
-- Name: TABLE sa290_sales_anal; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa290_sales_anal TO PUBLIC;
GRANT SELECT ON TABLE public.sa290_sales_anal TO xact_bi;
GRANT SELECT ON TABLE public.sa290_sales_anal TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa290_sales_anal TO role_write_xactdev_db;


--
-- Name: TABLE sa291_arb_sales_by_opr; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa291_arb_sales_by_opr TO PUBLIC;
GRANT SELECT ON TABLE public.sa291_arb_sales_by_opr TO xact_bi;
GRANT SELECT ON TABLE public.sa291_arb_sales_by_opr TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa291_arb_sales_by_opr TO role_write_xactdev_db;


--
-- Name: TABLE sa30_pi_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa30_pi_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sa30_pi_hd TO xact_bi;
GRANT SELECT ON TABLE public.sa30_pi_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa30_pi_hd TO role_write_xactdev_db;


--
-- Name: TABLE sa30t_tax_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa30t_tax_tran TO PUBLIC;
GRANT SELECT ON TABLE public.sa30t_tax_tran TO xact_bi;
GRANT SELECT ON TABLE public.sa30t_tax_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa30t_tax_tran TO role_write_xactdev_db;


--
-- Name: TABLE sa31_pi_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa31_pi_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sa31_pi_dt TO xact_bi;
GRANT SELECT ON TABLE public.sa31_pi_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa31_pi_dt TO role_write_xactdev_db;


--
-- Name: TABLE sa31s_pi_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa31s_pi_serial TO PUBLIC;
GRANT SELECT ON TABLE public.sa31s_pi_serial TO xact_bi;
GRANT SELECT ON TABLE public.sa31s_pi_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa31s_pi_serial TO role_write_xactdev_db;


--
-- Name: TABLE sa32_pi_dn_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa32_pi_dn_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sa32_pi_dn_hd TO xact_bi;
GRANT SELECT ON TABLE public.sa32_pi_dn_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa32_pi_dn_hd TO role_write_xactdev_db;


--
-- Name: TABLE sa33_pi_dn_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa33_pi_dn_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sa33_pi_dn_dt TO xact_bi;
GRANT SELECT ON TABLE public.sa33_pi_dn_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa33_pi_dn_dt TO role_write_xactdev_db;


--
-- Name: TABLE sa33s_pi_dn_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa33s_pi_dn_serial TO PUBLIC;
GRANT SELECT ON TABLE public.sa33s_pi_dn_serial TO xact_bi;
GRANT SELECT ON TABLE public.sa33s_pi_dn_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa33s_pi_dn_serial TO role_write_xactdev_db;


--
-- Name: TABLE sa40_email_inv; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa40_email_inv TO PUBLIC;
GRANT SELECT ON TABLE public.sa40_email_inv TO xact_bi;
GRANT SELECT ON TABLE public.sa40_email_inv TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sa40_email_inv TO role_write_xactdev_db;


--
-- Name: TABLE sc30_batch_status_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc30_batch_status_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sc30_batch_status_hd TO xact_bi;
GRANT SELECT ON TABLE public.sc30_batch_status_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc30_batch_status_hd TO role_write_xactdev_db;


--
-- Name: TABLE sc31_batch_status_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc31_batch_status_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sc31_batch_status_dt TO xact_bi;
GRANT SELECT ON TABLE public.sc31_batch_status_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc31_batch_status_dt TO role_write_xactdev_db;


--
-- Name: TABLE sc35_file_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc35_file_log TO PUBLIC;
GRANT SELECT ON TABLE public.sc35_file_log TO xact_bi;
GRANT SELECT ON TABLE public.sc35_file_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sc35_file_log TO role_write_xactdev_db;


--
-- Name: TABLE st00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.st00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE st00gl_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st00gl_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.st00gl_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.st00gl_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st00gl_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE st01_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01_mast TO PUBLIC;
GRANT SELECT ON TABLE public.st01_mast TO xact_bi;
GRANT SELECT ON TABLE public.st01_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01_mast TO role_write_xactdev_db;


--
-- Name: TABLE st01cpa_factor; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01cpa_factor TO PUBLIC;
GRANT SELECT ON TABLE public.st01cpa_factor TO xact_bi;
GRANT SELECT ON TABLE public.st01cpa_factor TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01cpa_factor TO role_write_xactdev_db;


--
-- Name: TABLE st01i_image; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01i_image TO PUBLIC;
GRANT SELECT ON TABLE public.st01i_image TO xact_bi;
GRANT SELECT ON TABLE public.st01i_image TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01i_image TO role_write_xactdev_db;


--
-- Name: TABLE st01l_lot_cuts; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01l_lot_cuts TO PUBLIC;
GRANT SELECT ON TABLE public.st01l_lot_cuts TO xact_bi;
GRANT SELECT ON TABLE public.st01l_lot_cuts TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01l_lot_cuts TO role_write_xactdev_db;


--
-- Name: TABLE st01n_notes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01n_notes TO PUBLIC;
GRANT SELECT ON TABLE public.st01n_notes TO xact_bi;
GRANT SELECT ON TABLE public.st01n_notes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01n_notes TO role_write_xactdev_db;


--
-- Name: TABLE st01p_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01p_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.st01p_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.st01p_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01p_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE st01pd_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01pd_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.st01pd_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.st01pd_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01pd_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE st01pr_per_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01pr_per_tot TO PUBLIC;
GRANT SELECT ON TABLE public.st01pr_per_tot TO xact_bi;
GRANT SELECT ON TABLE public.st01pr_per_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01pr_per_tot TO role_write_xactdev_db;


--
-- Name: TABLE st01r_related_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01r_related_codes TO PUBLIC;
GRANT SELECT ON TABLE public.st01r_related_codes TO xact_bi;
GRANT SELECT ON TABLE public.st01r_related_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01r_related_codes TO role_write_xactdev_db;


--
-- Name: TABLE st01s_serial_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01s_serial_no TO PUBLIC;
GRANT SELECT ON TABLE public.st01s_serial_no TO xact_bi;
GRANT SELECT ON TABLE public.st01s_serial_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01s_serial_no TO role_write_xactdev_db;


--
-- Name: TABLE st01sg_sub_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01sg_sub_grp TO PUBLIC;
GRANT SELECT ON TABLE public.st01sg_sub_grp TO xact_bi;
GRANT SELECT ON TABLE public.st01sg_sub_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01sg_sub_grp TO role_write_xactdev_db;


--
-- Name: TABLE st01td_long_desc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01td_long_desc TO PUBLIC;
GRANT SELECT ON TABLE public.st01td_long_desc TO xact_bi;
GRANT SELECT ON TABLE public.st01td_long_desc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01td_long_desc TO role_write_xactdev_db;


--
-- Name: TABLE st01ts_tech_spec; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01ts_tech_spec TO PUBLIC;
GRANT SELECT ON TABLE public.st01ts_tech_spec TO xact_bi;
GRANT SELECT ON TABLE public.st01ts_tech_spec TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01ts_tech_spec TO role_write_xactdev_db;


--
-- Name: TABLE st01u_uom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01u_uom TO PUBLIC;
GRANT SELECT ON TABLE public.st01u_uom TO xact_bi;
GRANT SELECT ON TABLE public.st01u_uom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01u_uom TO role_write_xactdev_db;


--
-- Name: TABLE st01u_uom_helper; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01u_uom_helper TO PUBLIC;
GRANT SELECT ON TABLE public.st01u_uom_helper TO xact_bi;
GRANT SELECT ON TABLE public.st01u_uom_helper TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st01u_uom_helper TO role_write_xactdev_db;


--
-- Name: TABLE st02_stk_loc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02_stk_loc TO PUBLIC;
GRANT SELECT ON TABLE public.st02_stk_loc TO xact_bi;
GRANT SELECT ON TABLE public.st02_stk_loc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02_stk_loc TO role_write_xactdev_db;


--
-- Name: TABLE st02b_loc_bins; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02b_loc_bins TO PUBLIC;
GRANT SELECT ON TABLE public.st02b_loc_bins TO xact_bi;
GRANT SELECT ON TABLE public.st02b_loc_bins TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02b_loc_bins TO role_write_xactdev_db;


--
-- Name: TABLE st02r_adj_reasons; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02r_adj_reasons TO PUBLIC;
GRANT SELECT ON TABLE public.st02r_adj_reasons TO xact_bi;
GRANT SELECT ON TABLE public.st02r_adj_reasons TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st02r_adj_reasons TO role_write_xactdev_db;


--
-- Name: TABLE st03_bin_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st03_bin_mast TO PUBLIC;
GRANT SELECT ON TABLE public.st03_bin_mast TO xact_bi;
GRANT SELECT ON TABLE public.st03_bin_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st03_bin_mast TO role_write_xactdev_db;


--
-- Name: TABLE st04_stk_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04_stk_grp TO PUBLIC;
GRANT SELECT ON TABLE public.st04_stk_grp TO xact_bi;
GRANT SELECT ON TABLE public.st04_stk_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04_stk_grp TO role_write_xactdev_db;


--
-- Name: TABLE st04d_grp_div; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04d_grp_div TO PUBLIC;
GRANT SELECT ON TABLE public.st04d_grp_div TO xact_bi;
GRANT SELECT ON TABLE public.st04d_grp_div TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04d_grp_div TO role_write_xactdev_db;


--
-- Name: TABLE st04s_grp_sec; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04s_grp_sec TO PUBLIC;
GRANT SELECT ON TABLE public.st04s_grp_sec TO xact_bi;
GRANT SELECT ON TABLE public.st04s_grp_sec TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04s_grp_sec TO role_write_xactdev_db;


--
-- Name: TABLE st04sg_sub_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04sg_sub_grp TO PUBLIC;
GRANT SELECT ON TABLE public.st04sg_sub_grp TO xact_bi;
GRANT SELECT ON TABLE public.st04sg_sub_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st04sg_sub_grp TO role_write_xactdev_db;


--
-- Name: TABLE st05_pack_code; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st05_pack_code TO PUBLIC;
GRANT SELECT ON TABLE public.st05_pack_code TO xact_bi;
GRANT SELECT ON TABLE public.st05_pack_code TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st05_pack_code TO role_write_xactdev_db;


--
-- Name: TABLE st06_stk_prices; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06_stk_prices TO PUBLIC;
GRANT SELECT ON TABLE public.st06_stk_prices TO xact_bi;
GRANT SELECT ON TABLE public.st06_stk_prices TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06_stk_prices TO role_write_xactdev_db;


--
-- Name: TABLE st06c_default_cl; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06c_default_cl TO PUBLIC;
GRANT SELECT ON TABLE public.st06c_default_cl TO xact_bi;
GRANT SELECT ON TABLE public.st06c_default_cl TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06c_default_cl TO role_write_xactdev_db;


--
-- Name: TABLE st06cp_comp_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06cp_comp_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st06cp_comp_dt TO xact_bi;
GRANT SELECT ON TABLE public.st06cp_comp_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06cp_comp_dt TO role_write_xactdev_db;


--
-- Name: TABLE st06cp_comp_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06cp_comp_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st06cp_comp_hd TO xact_bi;
GRANT SELECT ON TABLE public.st06cp_comp_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06cp_comp_hd TO role_write_xactdev_db;


--
-- Name: TABLE st06f_price_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06f_price_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st06f_price_hd TO xact_bi;
GRANT SELECT ON TABLE public.st06f_price_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06f_price_hd TO role_write_xactdev_db;


--
-- Name: TABLE st06fd_price_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06fd_price_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st06fd_price_dt TO xact_bi;
GRANT SELECT ON TABLE public.st06fd_price_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06fd_price_dt TO role_write_xactdev_db;


--
-- Name: TABLE st06s_alternate_cl; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06s_alternate_cl TO PUBLIC;
GRANT SELECT ON TABLE public.st06s_alternate_cl TO xact_bi;
GRANT SELECT ON TABLE public.st06s_alternate_cl TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06s_alternate_cl TO role_write_xactdev_db;


--
-- Name: TABLE st06t_price_templates; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06t_price_templates TO PUBLIC;
GRANT SELECT ON TABLE public.st06t_price_templates TO xact_bi;
GRANT SELECT ON TABLE public.st06t_price_templates TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st06t_price_templates TO role_write_xactdev_db;


--
-- Name: TABLE st07_special_prices_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07_special_prices_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st07_special_prices_hd TO xact_bi;
GRANT SELECT ON TABLE public.st07_special_prices_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07_special_prices_hd TO role_write_xactdev_db;


--
-- Name: TABLE st07c_cust_selection; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07c_cust_selection TO PUBLIC;
GRANT SELECT ON TABLE public.st07c_cust_selection TO xact_bi;
GRANT SELECT ON TABLE public.st07c_cust_selection TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07c_cust_selection TO role_write_xactdev_db;


--
-- Name: TABLE st07l_stk_locs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07l_stk_locs TO PUBLIC;
GRANT SELECT ON TABLE public.st07l_stk_locs TO xact_bi;
GRANT SELECT ON TABLE public.st07l_stk_locs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07l_stk_locs TO role_write_xactdev_db;


--
-- Name: TABLE st07p_prod_selection; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07p_prod_selection TO PUBLIC;
GRANT SELECT ON TABLE public.st07p_prod_selection TO xact_bi;
GRANT SELECT ON TABLE public.st07p_prod_selection TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st07p_prod_selection TO role_write_xactdev_db;


--
-- Name: TABLE st08_special_prices_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st08_special_prices_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st08_special_prices_dt TO xact_bi;
GRANT SELECT ON TABLE public.st08_special_prices_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st08_special_prices_dt TO role_write_xactdev_db;


--
-- Name: TABLE st08a_special_price_qty_list; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st08a_special_price_qty_list TO PUBLIC;
GRANT SELECT ON TABLE public.st08a_special_price_qty_list TO xact_bi;
GRANT SELECT ON TABLE public.st08a_special_price_qty_list TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st08a_special_price_qty_list TO role_write_xactdev_db;


--
-- Name: TABLE st09_cpa_idx; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st09_cpa_idx TO PUBLIC;
GRANT SELECT ON TABLE public.st09_cpa_idx TO xact_bi;
GRANT SELECT ON TABLE public.st09_cpa_idx TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st09_cpa_idx TO role_write_xactdev_db;


--
-- Name: TABLE st10_ctrl_tot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st10_ctrl_tot TO PUBLIC;
GRANT SELECT ON TABLE public.st10_ctrl_tot TO xact_bi;
GRANT SELECT ON TABLE public.st10_ctrl_tot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st10_ctrl_tot TO role_write_xactdev_db;


--
-- Name: TABLE st12_import_duty_tariff; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st12_import_duty_tariff TO PUBLIC;
GRANT SELECT ON TABLE public.st12_import_duty_tariff TO xact_bi;
GRANT SELECT ON TABLE public.st12_import_duty_tariff TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st12_import_duty_tariff TO role_write_xactdev_db;


--
-- Name: TABLE st13_clearing_agent; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st13_clearing_agent TO PUBLIC;
GRANT SELECT ON TABLE public.st13_clearing_agent TO xact_bi;
GRANT SELECT ON TABLE public.st13_clearing_agent TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st13_clearing_agent TO role_write_xactdev_db;


--
-- Name: TABLE st14_import_levies; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st14_import_levies TO PUBLIC;
GRANT SELECT ON TABLE public.st14_import_levies TO xact_bi;
GRANT SELECT ON TABLE public.st14_import_levies TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st14_import_levies TO role_write_xactdev_db;


--
-- Name: TABLE st15_uom_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st15_uom_mast TO PUBLIC;
GRANT SELECT ON TABLE public.st15_uom_mast TO xact_bi;
GRANT SELECT ON TABLE public.st15_uom_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st15_uom_mast TO role_write_xactdev_db;


--
-- Name: TABLE st17_promo_combo_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17_promo_combo_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st17_promo_combo_hd TO xact_bi;
GRANT SELECT ON TABLE public.st17_promo_combo_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17_promo_combo_hd TO role_write_xactdev_db;


--
-- Name: TABLE st17c_cust_selection; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17c_cust_selection TO PUBLIC;
GRANT SELECT ON TABLE public.st17c_cust_selection TO xact_bi;
GRANT SELECT ON TABLE public.st17c_cust_selection TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17c_cust_selection TO role_write_xactdev_db;


--
-- Name: TABLE st17l_stk_locs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17l_stk_locs TO PUBLIC;
GRANT SELECT ON TABLE public.st17l_stk_locs TO xact_bi;
GRANT SELECT ON TABLE public.st17l_stk_locs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17l_stk_locs TO role_write_xactdev_db;


--
-- Name: TABLE st17p_prod_selection; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17p_prod_selection TO PUBLIC;
GRANT SELECT ON TABLE public.st17p_prod_selection TO xact_bi;
GRANT SELECT ON TABLE public.st17p_prod_selection TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st17p_prod_selection TO role_write_xactdev_db;


--
-- Name: TABLE st18_promo_triggers; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st18_promo_triggers TO PUBLIC;
GRANT SELECT ON TABLE public.st18_promo_triggers TO xact_bi;
GRANT SELECT ON TABLE public.st18_promo_triggers TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st18_promo_triggers TO role_write_xactdev_db;


--
-- Name: TABLE st19_promo_rewards; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st19_promo_rewards TO PUBLIC;
GRANT SELECT ON TABLE public.st19_promo_rewards TO xact_bi;
GRANT SELECT ON TABLE public.st19_promo_rewards TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st19_promo_rewards TO role_write_xactdev_db;


--
-- Name: TABLE st20_adj_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20_adj_bt TO PUBLIC;
GRANT SELECT ON TABLE public.st20_adj_bt TO xact_bi;
GRANT SELECT ON TABLE public.st20_adj_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20_adj_bt TO role_write_xactdev_db;


--
-- Name: TABLE st20b_adj_bom; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20b_adj_bom TO PUBLIC;
GRANT SELECT ON TABLE public.st20b_adj_bom TO xact_bi;
GRANT SELECT ON TABLE public.st20b_adj_bom TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20b_adj_bom TO role_write_xactdev_db;


--
-- Name: TABLE st20i_bin_alloc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20i_bin_alloc TO PUBLIC;
GRANT SELECT ON TABLE public.st20i_bin_alloc TO xact_bi;
GRANT SELECT ON TABLE public.st20i_bin_alloc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20i_bin_alloc TO role_write_xactdev_db;


--
-- Name: TABLE st20s_adj_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20s_adj_serial TO PUBLIC;
GRANT SELECT ON TABLE public.st20s_adj_serial TO xact_bi;
GRANT SELECT ON TABLE public.st20s_adj_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st20s_adj_serial TO role_write_xactdev_db;


--
-- Name: TABLE st21_bin_transfer_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st21_bin_transfer_bt TO PUBLIC;
GRANT SELECT ON TABLE public.st21_bin_transfer_bt TO xact_bi;
GRANT SELECT ON TABLE public.st21_bin_transfer_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st21_bin_transfer_bt TO role_write_xactdev_db;


--
-- Name: TABLE st21b_uom_break_build; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st21b_uom_break_build TO PUBLIC;
GRANT SELECT ON TABLE public.st21b_uom_break_build TO xact_bi;
GRANT SELECT ON TABLE public.st21b_uom_break_build TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st21b_uom_break_build TO role_write_xactdev_db;


--
-- Name: TABLE st22_replen_bt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22_replen_bt TO PUBLIC;
GRANT SELECT ON TABLE public.st22_replen_bt TO xact_bi;
GRANT SELECT ON TABLE public.st22_replen_bt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22_replen_bt TO role_write_xactdev_db;


--
-- Name: TABLE st22g_grps; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22g_grps TO PUBLIC;
GRANT SELECT ON TABLE public.st22g_grps TO xact_bi;
GRANT SELECT ON TABLE public.st22g_grps TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22g_grps TO role_write_xactdev_db;


--
-- Name: TABLE st22m_companies; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22m_companies TO PUBLIC;
GRANT SELECT ON TABLE public.st22m_companies TO xact_bi;
GRANT SELECT ON TABLE public.st22m_companies TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22m_companies TO role_write_xactdev_db;


--
-- Name: TABLE st22s_supplier; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22s_supplier TO PUBLIC;
GRANT SELECT ON TABLE public.st22s_supplier TO xact_bi;
GRANT SELECT ON TABLE public.st22s_supplier TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st22s_supplier TO role_write_xactdev_db;


--
-- Name: TABLE st23_replen_items; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23_replen_items TO PUBLIC;
GRANT SELECT ON TABLE public.st23_replen_items TO xact_bi;
GRANT SELECT ON TABLE public.st23_replen_items TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23_replen_items TO role_write_xactdev_db;


--
-- Name: TABLE st23fore_close_bal; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23fore_close_bal TO PUBLIC;
GRANT SELECT ON TABLE public.st23fore_close_bal TO xact_bi;
GRANT SELECT ON TABLE public.st23fore_close_bal TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23fore_close_bal TO role_write_xactdev_db;


--
-- Name: TABLE st23grn_replen_grn_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23grn_replen_grn_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23grn_replen_grn_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23grn_replen_grn_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23grn_replen_grn_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23ib_replen_req_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23ib_replen_req_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23ib_replen_req_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23ib_replen_req_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23ib_replen_req_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23in_replen_inv_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23in_replen_inv_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23in_replen_inv_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23in_replen_inv_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23in_replen_inv_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23inter_po_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23inter_po_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23inter_po_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23inter_po_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23inter_po_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23l_replen_co_links; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23l_replen_co_links TO PUBLIC;
GRANT SELECT ON TABLE public.st23l_replen_co_links TO xact_bi;
GRANT SELECT ON TABLE public.st23l_replen_co_links TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23l_replen_co_links TO role_write_xactdev_db;


--
-- Name: TABLE st23po_replen_po_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23po_replen_po_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23po_replen_po_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23po_replen_po_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23po_replen_po_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23posub_replen_split; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23posub_replen_split TO PUBLIC;
GRANT SELECT ON TABLE public.st23posub_replen_split TO xact_bi;
GRANT SELECT ON TABLE public.st23posub_replen_split TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23posub_replen_split TO role_write_xactdev_db;


--
-- Name: TABLE st23s_serial_allocation; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23s_serial_allocation TO PUBLIC;
GRANT SELECT ON TABLE public.st23s_serial_allocation TO xact_bi;
GRANT SELECT ON TABLE public.st23s_serial_allocation TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23s_serial_allocation TO role_write_xactdev_db;


--
-- Name: TABLE st23so_replen_so_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23so_replen_so_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st23so_replen_so_hd TO xact_bi;
GRANT SELECT ON TABLE public.st23so_replen_so_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23so_replen_so_hd TO role_write_xactdev_db;


--
-- Name: TABLE st23sub_replen_split; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23sub_replen_split TO PUBLIC;
GRANT SELECT ON TABLE public.st23sub_replen_split TO xact_bi;
GRANT SELECT ON TABLE public.st23sub_replen_split TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st23sub_replen_split TO role_write_xactdev_db;


--
-- Name: TABLE st24_orders; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st24_orders TO PUBLIC;
GRANT SELECT ON TABLE public.st24_orders TO xact_bi;
GRANT SELECT ON TABLE public.st24_orders TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st24_orders TO role_write_xactdev_db;


--
-- Name: TABLE st25_stk_take_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25_stk_take_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st25_stk_take_hd TO xact_bi;
GRANT SELECT ON TABLE public.st25_stk_take_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25_stk_take_hd TO role_write_xactdev_db;


--
-- Name: TABLE st25f_filters; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25f_filters TO PUBLIC;
GRANT SELECT ON TABLE public.st25f_filters TO xact_bi;
GRANT SELECT ON TABLE public.st25f_filters TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25f_filters TO role_write_xactdev_db;


--
-- Name: TABLE st25g_grp_exclusions; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25g_grp_exclusions TO PUBLIC;
GRANT SELECT ON TABLE public.st25g_grp_exclusions TO xact_bi;
GRANT SELECT ON TABLE public.st25g_grp_exclusions TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st25g_grp_exclusions TO role_write_xactdev_db;


--
-- Name: TABLE st26_stk_take_imp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26_stk_take_imp TO PUBLIC;
GRANT SELECT ON TABLE public.st26_stk_take_imp TO xact_bi;
GRANT SELECT ON TABLE public.st26_stk_take_imp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26_stk_take_imp TO role_write_xactdev_db;


--
-- Name: TABLE st26i_stk_take_imp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26i_stk_take_imp TO PUBLIC;
GRANT SELECT ON TABLE public.st26i_stk_take_imp TO xact_bi;
GRANT SELECT ON TABLE public.st26i_stk_take_imp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26i_stk_take_imp TO role_write_xactdev_db;


--
-- Name: TABLE st26s_stk_take_imp_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26s_stk_take_imp_serial TO PUBLIC;
GRANT SELECT ON TABLE public.st26s_stk_take_imp_serial TO xact_bi;
GRANT SELECT ON TABLE public.st26s_stk_take_imp_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st26s_stk_take_imp_serial TO role_write_xactdev_db;


--
-- Name: TABLE st27_random_batch_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27_random_batch_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st27_random_batch_hd TO xact_bi;
GRANT SELECT ON TABLE public.st27_random_batch_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27_random_batch_hd TO role_write_xactdev_db;


--
-- Name: TABLE st27d_random_batch_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27d_random_batch_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st27d_random_batch_dt TO xact_bi;
GRANT SELECT ON TABLE public.st27d_random_batch_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27d_random_batch_dt TO role_write_xactdev_db;


--
-- Name: TABLE st27i_random_bins; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27i_random_bins TO PUBLIC;
GRANT SELECT ON TABLE public.st27i_random_bins TO xact_bi;
GRANT SELECT ON TABLE public.st27i_random_bins TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27i_random_bins TO role_write_xactdev_db;


--
-- Name: TABLE st27s_random_batch_serials; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27s_random_batch_serials TO PUBLIC;
GRANT SELECT ON TABLE public.st27s_random_batch_serials TO xact_bi;
GRANT SELECT ON TABLE public.st27s_random_batch_serials TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st27s_random_batch_serials TO role_write_xactdev_db;


--
-- Name: TABLE st28_stk_take_process; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st28_stk_take_process TO PUBLIC;
GRANT SELECT ON TABLE public.st28_stk_take_process TO xact_bi;
GRANT SELECT ON TABLE public.st28_stk_take_process TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st28_stk_take_process TO role_write_xactdev_db;


--
-- Name: TABLE st29_man_pull_pack_bin; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st29_man_pull_pack_bin TO PUBLIC;
GRANT SELECT ON TABLE public.st29_man_pull_pack_bin TO xact_bi;
GRANT SELECT ON TABLE public.st29_man_pull_pack_bin TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st29_man_pull_pack_bin TO role_write_xactdev_db;


--
-- Name: TABLE st30_stk_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30_stk_tran TO PUBLIC;
GRANT SELECT ON TABLE public.st30_stk_tran TO xact_bi;
GRANT SELECT ON TABLE public.st30_stk_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30_stk_tran TO role_write_xactdev_db;


--
-- Name: TABLE st30i_internal_trans; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30i_internal_trans TO PUBLIC;
GRANT SELECT ON TABLE public.st30i_internal_trans TO xact_bi;
GRANT SELECT ON TABLE public.st30i_internal_trans TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30i_internal_trans TO role_write_xactdev_db;


--
-- Name: TABLE st30s_serial_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30s_serial_tran TO PUBLIC;
GRANT SELECT ON TABLE public.st30s_serial_tran TO xact_bi;
GRANT SELECT ON TABLE public.st30s_serial_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st30s_serial_tran TO role_write_xactdev_db;


--
-- Name: TABLE st33_price_chg; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st33_price_chg TO PUBLIC;
GRANT SELECT ON TABLE public.st33_price_chg TO xact_bi;
GRANT SELECT ON TABLE public.st33_price_chg TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st33_price_chg TO role_write_xactdev_db;


--
-- Name: TABLE st33p_price_chg_labels; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st33p_price_chg_labels TO PUBLIC;
GRANT SELECT ON TABLE public.st33p_price_chg_labels TO xact_bi;
GRANT SELECT ON TABLE public.st33p_price_chg_labels TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st33p_price_chg_labels TO role_write_xactdev_db;


--
-- Name: TABLE st34_arb_wms_fail_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st34_arb_wms_fail_log TO PUBLIC;
GRANT SELECT ON TABLE public.st34_arb_wms_fail_log TO xact_bi;
GRANT SELECT ON TABLE public.st34_arb_wms_fail_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st34_arb_wms_fail_log TO role_write_xactdev_db;


--
-- Name: TABLE st35_whs_dis_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st35_whs_dis_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st35_whs_dis_hd TO xact_bi;
GRANT SELECT ON TABLE public.st35_whs_dis_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st35_whs_dis_hd TO role_write_xactdev_db;


--
-- Name: TABLE st36_whs_dis_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36_whs_dis_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st36_whs_dis_dt TO xact_bi;
GRANT SELECT ON TABLE public.st36_whs_dis_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36_whs_dis_dt TO role_write_xactdev_db;


--
-- Name: TABLE st36i_whs_dis_bin; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36i_whs_dis_bin TO PUBLIC;
GRANT SELECT ON TABLE public.st36i_whs_dis_bin TO xact_bi;
GRANT SELECT ON TABLE public.st36i_whs_dis_bin TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36i_whs_dis_bin TO role_write_xactdev_db;


--
-- Name: TABLE st36p_whs_dis_pallets; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36p_whs_dis_pallets TO PUBLIC;
GRANT SELECT ON TABLE public.st36p_whs_dis_pallets TO xact_bi;
GRANT SELECT ON TABLE public.st36p_whs_dis_pallets TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36p_whs_dis_pallets TO role_write_xactdev_db;


--
-- Name: TABLE st36s_whs_dis_serials; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36s_whs_dis_serials TO PUBLIC;
GRANT SELECT ON TABLE public.st36s_whs_dis_serials TO xact_bi;
GRANT SELECT ON TABLE public.st36s_whs_dis_serials TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st36s_whs_dis_serials TO role_write_xactdev_db;


--
-- Name: TABLE st37_whs_rec_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st37_whs_rec_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st37_whs_rec_hd TO xact_bi;
GRANT SELECT ON TABLE public.st37_whs_rec_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st37_whs_rec_hd TO role_write_xactdev_db;


--
-- Name: TABLE st38_whs_rec_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38_whs_rec_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st38_whs_rec_dt TO xact_bi;
GRANT SELECT ON TABLE public.st38_whs_rec_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38_whs_rec_dt TO role_write_xactdev_db;


--
-- Name: TABLE st38d_driver_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38d_driver_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st38d_driver_dt TO xact_bi;
GRANT SELECT ON TABLE public.st38d_driver_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38d_driver_dt TO role_write_xactdev_db;


--
-- Name: TABLE st38i_whs_rec_bin; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38i_whs_rec_bin TO PUBLIC;
GRANT SELECT ON TABLE public.st38i_whs_rec_bin TO xact_bi;
GRANT SELECT ON TABLE public.st38i_whs_rec_bin TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38i_whs_rec_bin TO role_write_xactdev_db;


--
-- Name: TABLE st38s_whs_rec_serials; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38s_whs_rec_serials TO PUBLIC;
GRANT SELECT ON TABLE public.st38s_whs_rec_serials TO xact_bi;
GRANT SELECT ON TABLE public.st38s_whs_rec_serials TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st38s_whs_rec_serials TO role_write_xactdev_db;


--
-- Name: TABLE st40_track_store_pulling; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40_track_store_pulling TO PUBLIC;
GRANT SELECT ON TABLE public.st40_track_store_pulling TO xact_bi;
GRANT SELECT ON TABLE public.st40_track_store_pulling TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40_track_store_pulling TO role_write_xactdev_db;


--
-- Name: TABLE st40p_package_dimensions; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40p_package_dimensions TO PUBLIC;
GRANT SELECT ON TABLE public.st40p_package_dimensions TO xact_bi;
GRANT SELECT ON TABLE public.st40p_package_dimensions TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40p_package_dimensions TO role_write_xactdev_db;


--
-- Name: TABLE st40u_warehouse_user; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40u_warehouse_user TO PUBLIC;
GRANT SELECT ON TABLE public.st40u_warehouse_user TO xact_bi;
GRANT SELECT ON TABLE public.st40u_warehouse_user TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st40u_warehouse_user TO role_write_xactdev_db;


--
-- Name: TABLE st41_area_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st41_area_mast TO PUBLIC;
GRANT SELECT ON TABLE public.st41_area_mast TO xact_bi;
GRANT SELECT ON TABLE public.st41_area_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st41_area_mast TO role_write_xactdev_db;


--
-- Name: TABLE st42_route_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st42_route_no TO PUBLIC;
GRANT SELECT ON TABLE public.st42_route_no TO xact_bi;
GRANT SELECT ON TABLE public.st42_route_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st42_route_no TO role_write_xactdev_db;


--
-- Name: TABLE st43_prt_stk_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st43_prt_stk_hd TO PUBLIC;
GRANT SELECT ON TABLE public.st43_prt_stk_hd TO xact_bi;
GRANT SELECT ON TABLE public.st43_prt_stk_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st43_prt_stk_hd TO role_write_xactdev_db;


--
-- Name: TABLE st44_prt_stk_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st44_prt_stk_dt TO PUBLIC;
GRANT SELECT ON TABLE public.st44_prt_stk_dt TO xact_bi;
GRANT SELECT ON TABLE public.st44_prt_stk_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.st44_prt_stk_dt TO role_write_xactdev_db;


--
-- Name: TABLE sy00_co_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy00_co_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy00_co_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy00_co_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy00_co_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy01_master_co_links; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy01_master_co_links TO PUBLIC;
GRANT SELECT ON TABLE public.sy01_master_co_links TO xact_bi;
GRANT SELECT ON TABLE public.sy01_master_co_links TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy01_master_co_links TO role_write_xactdev_db;


--
-- Name: TABLE sy01w_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy01w_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy01w_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy01w_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy01w_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy02_user; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.sy02_user TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02_user TO role_write_xactdev_db;


--
-- Name: TABLE sy02bi_widget; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02bi_widget TO PUBLIC;
GRANT SELECT ON TABLE public.sy02bi_widget TO xact_bi;
GRANT SELECT ON TABLE public.sy02bi_widget TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02bi_widget TO role_write_xactdev_db;


--
-- Name: TABLE sy02d_grp_div; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02d_grp_div TO PUBLIC;
GRANT SELECT ON TABLE public.sy02d_grp_div TO xact_bi;
GRANT SELECT ON TABLE public.sy02d_grp_div TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02d_grp_div TO role_write_xactdev_db;


--
-- Name: TABLE sy02f_user_favs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02f_user_favs TO PUBLIC;
GRANT SELECT ON TABLE public.sy02f_user_favs TO xact_bi;
GRANT SELECT ON TABLE public.sy02f_user_favs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02f_user_favs TO role_write_xactdev_db;


--
-- Name: TABLE sy02g_user_stk_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02g_user_stk_grp TO PUBLIC;
GRANT SELECT ON TABLE public.sy02g_user_stk_grp TO xact_bi;
GRANT SELECT ON TABLE public.sy02g_user_stk_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02g_user_stk_grp TO role_write_xactdev_db;


--
-- Name: TABLE sy02h_pwd_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02h_pwd_hist TO PUBLIC;
GRANT SELECT ON TABLE public.sy02h_pwd_hist TO xact_bi;
GRANT SELECT ON TABLE public.sy02h_pwd_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02h_pwd_hist TO role_write_xactdev_db;


--
-- Name: TABLE sy02l_user_loc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02l_user_loc TO PUBLIC;
GRANT SELECT ON TABLE public.sy02l_user_loc TO xact_bi;
GRANT SELECT ON TABLE public.sy02l_user_loc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02l_user_loc TO role_write_xactdev_db;


--
-- Name: TABLE sy02p_user_positions; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02p_user_positions TO PUBLIC;
GRANT SELECT ON TABLE public.sy02p_user_positions TO xact_bi;
GRANT SELECT ON TABLE public.sy02p_user_positions TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02p_user_positions TO role_write_xactdev_db;


--
-- Name: TABLE sy02s_startup; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02s_startup TO PUBLIC;
GRANT SELECT ON TABLE public.sy02s_startup TO xact_bi;
GRANT SELECT ON TABLE public.sy02s_startup TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02s_startup TO role_write_xactdev_db;


--
-- Name: TABLE sy02w_user_widget; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02w_user_widget TO PUBLIC;
GRANT SELECT ON TABLE public.sy02w_user_widget TO xact_bi;
GRANT SELECT ON TABLE public.sy02w_user_widget TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02w_user_widget TO role_write_xactdev_db;


--
-- Name: TABLE sy02wp_dash_param; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02wp_dash_param TO PUBLIC;
GRANT SELECT ON TABLE public.sy02wp_dash_param TO xact_bi;
GRANT SELECT ON TABLE public.sy02wp_dash_param TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy02wp_dash_param TO role_write_xactdev_db;


--
-- Name: TABLE sy04_access_grps; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy04_access_grps TO PUBLIC;
GRANT SELECT ON TABLE public.sy04_access_grps TO xact_bi;
GRANT SELECT ON TABLE public.sy04_access_grps TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy04_access_grps TO role_write_xactdev_db;


--
-- Name: TABLE sy05_tm_grps; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy05_tm_grps TO PUBLIC;
GRANT SELECT ON TABLE public.sy05_tm_grps TO xact_bi;
GRANT SELECT ON TABLE public.sy05_tm_grps TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy05_tm_grps TO role_write_xactdev_db;


--
-- Name: TABLE sy06a_access; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06a_access TO PUBLIC;
GRANT SELECT ON TABLE public.sy06a_access TO xact_bi;
GRANT SELECT ON TABLE public.sy06a_access TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06a_access TO role_write_xactdev_db;


--
-- Name: TABLE sy06c_custom_menu; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06c_custom_menu TO PUBLIC;
GRANT SELECT ON TABLE public.sy06c_custom_menu TO xact_bi;
GRANT SELECT ON TABLE public.sy06c_custom_menu TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06c_custom_menu TO role_write_xactdev_db;


--
-- Name: TABLE sy06s_structure; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06s_structure TO PUBLIC;
GRANT SELECT ON TABLE public.sy06s_structure TO xact_bi;
GRANT SELECT ON TABLE public.sy06s_structure TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy06s_structure TO role_write_xactdev_db;


--
-- Name: TABLE sy07_prt_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy07_prt_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy07_prt_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy07_prt_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy07_prt_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy08_prt_types; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy08_prt_types TO PUBLIC;
GRANT SELECT ON TABLE public.sy08_prt_types TO xact_bi;
GRANT SELECT ON TABLE public.sy08_prt_types TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy08_prt_types TO role_write_xactdev_db;


--
-- Name: TABLE sy09_prt_esc_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy09_prt_esc_codes TO PUBLIC;
GRANT SELECT ON TABLE public.sy09_prt_esc_codes TO xact_bi;
GRANT SELECT ON TABLE public.sy09_prt_esc_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy09_prt_esc_codes TO role_write_xactdev_db;


--
-- Name: TABLE sy10_lic_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy10_lic_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy10_lic_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy10_lic_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy10_lic_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy12_forex_currency; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy12_forex_currency TO PUBLIC;
GRANT SELECT ON TABLE public.sy12_forex_currency TO xact_bi;
GRANT SELECT ON TABLE public.sy12_forex_currency TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy12_forex_currency TO role_write_xactdev_db;


--
-- Name: TABLE sy13_fiscal_device; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy13_fiscal_device TO PUBLIC;
GRANT SELECT ON TABLE public.sy13_fiscal_device TO xact_bi;
GRANT SELECT ON TABLE public.sy13_fiscal_device TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy13_fiscal_device TO role_write_xactdev_db;


--
-- Name: TABLE sy14_dashboard_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy14_dashboard_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy14_dashboard_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy14_dashboard_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy14_dashboard_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy15_phone_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy15_phone_codes TO PUBLIC;
GRANT SELECT ON TABLE public.sy15_phone_codes TO xact_bi;
GRANT SELECT ON TABLE public.sy15_phone_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy15_phone_codes TO role_write_xactdev_db;


--
-- Name: TABLE sy16_post_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy16_post_codes TO PUBLIC;
GRANT SELECT ON TABLE public.sy16_post_codes TO xact_bi;
GRANT SELECT ON TABLE public.sy16_post_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy16_post_codes TO role_write_xactdev_db;


--
-- Name: TABLE sy20_batch_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy20_batch_log TO PUBLIC;
GRANT SELECT ON TABLE public.sy20_batch_log TO xact_bi;
GRANT SELECT ON TABLE public.sy20_batch_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy20_batch_log TO role_write_xactdev_db;


--
-- Name: TABLE sy21_del_by; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy21_del_by TO PUBLIC;
GRANT SELECT ON TABLE public.sy21_del_by TO xact_bi;
GRANT SELECT ON TABLE public.sy21_del_by TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy21_del_by TO role_write_xactdev_db;


--
-- Name: TABLE sy220_user_productivity; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy220_user_productivity TO PUBLIC;
GRANT SELECT ON TABLE public.sy220_user_productivity TO xact_bi;
GRANT SELECT ON TABLE public.sy220_user_productivity TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy220_user_productivity TO role_write_xactdev_db;


--
-- Name: TABLE sy22_prt_que; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy22_prt_que TO PUBLIC;
GRANT SELECT ON TABLE public.sy22_prt_que TO xact_bi;
GRANT SELECT ON TABLE public.sy22_prt_que TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy22_prt_que TO role_write_xactdev_db;


--
-- Name: TABLE sy23_proj_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy23_proj_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy23_proj_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy23_proj_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy23_proj_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy25_vat_201; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy25_vat_201 TO PUBLIC;
GRANT SELECT ON TABLE public.sy25_vat_201 TO xact_bi;
GRANT SELECT ON TABLE public.sy25_vat_201 TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy25_vat_201 TO role_write_xactdev_db;


--
-- Name: TABLE sy26_vat_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy26_vat_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sy26_vat_dt TO xact_bi;
GRANT SELECT ON TABLE public.sy26_vat_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy26_vat_dt TO role_write_xactdev_db;


--
-- Name: TABLE sy27_supercession; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy27_supercession TO PUBLIC;
GRANT SELECT ON TABLE public.sy27_supercession TO xact_bi;
GRANT SELECT ON TABLE public.sy27_supercession TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy27_supercession TO role_write_xactdev_db;


--
-- Name: TABLE sy27h_code_history; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy27h_code_history TO PUBLIC;
GRANT SELECT ON TABLE public.sy27h_code_history TO xact_bi;
GRANT SELECT ON TABLE public.sy27h_code_history TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy27h_code_history TO role_write_xactdev_db;


--
-- Name: TABLE sy290_eb_daily_snapshot; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy290_eb_daily_snapshot TO PUBLIC;
GRANT SELECT ON TABLE public.sy290_eb_daily_snapshot TO xact_bi;
GRANT SELECT ON TABLE public.sy290_eb_daily_snapshot TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy290_eb_daily_snapshot TO role_write_xactdev_db;


--
-- Name: TABLE sy29_reval; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy29_reval TO PUBLIC;
GRANT SELECT ON TABLE public.sy29_reval TO xact_bi;
GRANT SELECT ON TABLE public.sy29_reval TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy29_reval TO role_write_xactdev_db;


--
-- Name: TABLE sy30_approval_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy30_approval_hd TO PUBLIC;
GRANT SELECT ON TABLE public.sy30_approval_hd TO xact_bi;
GRANT SELECT ON TABLE public.sy30_approval_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy30_approval_hd TO role_write_xactdev_db;


--
-- Name: TABLE sy31_approval_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy31_approval_dt TO PUBLIC;
GRANT SELECT ON TABLE public.sy31_approval_dt TO xact_bi;
GRANT SELECT ON TABLE public.sy31_approval_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy31_approval_dt TO role_write_xactdev_db;


--
-- Name: TABLE sy31a_access_grp; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy31a_access_grp TO PUBLIC;
GRANT SELECT ON TABLE public.sy31a_access_grp TO xact_bi;
GRANT SELECT ON TABLE public.sy31a_access_grp TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy31a_access_grp TO role_write_xactdev_db;


--
-- Name: TABLE sy33_program_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy33_program_log TO PUBLIC;
GRANT SELECT ON TABLE public.sy33_program_log TO xact_bi;
GRANT SELECT ON TABLE public.sy33_program_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy33_program_log TO role_write_xactdev_db;


--
-- Name: TABLE sy35_chg_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy35_chg_log TO PUBLIC;
GRANT SELECT ON TABLE public.sy35_chg_log TO xact_bi;
GRANT SELECT ON TABLE public.sy35_chg_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy35_chg_log TO role_write_xactdev_db;


--
-- Name: TABLE sy35_chg_log_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy35_chg_log_arch TO PUBLIC;
GRANT SELECT ON TABLE public.sy35_chg_log_arch TO xact_bi;
GRANT SELECT ON TABLE public.sy35_chg_log_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy35_chg_log_arch TO role_write_xactdev_db;


--
-- Name: TABLE sy36_running_progs; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy36_running_progs TO PUBLIC;
GRANT SELECT ON TABLE public.sy36_running_progs TO xact_bi;
GRANT SELECT ON TABLE public.sy36_running_progs TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy36_running_progs TO role_write_xactdev_db;


--
-- Name: TABLE sy37_in_use_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy37_in_use_log TO PUBLIC;
GRANT SELECT ON TABLE public.sy37_in_use_log TO xact_bi;
GRANT SELECT ON TABLE public.sy37_in_use_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy37_in_use_log TO role_write_xactdev_db;


--
-- Name: TABLE sy38_auth_out_req; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy38_auth_out_req TO PUBLIC;
GRANT SELECT ON TABLE public.sy38_auth_out_req TO xact_bi;
GRANT SELECT ON TABLE public.sy38_auth_out_req TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy38_auth_out_req TO role_write_xactdev_db;


--
-- Name: TABLE sy40_support_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy40_support_log TO PUBLIC;
GRANT SELECT ON TABLE public.sy40_support_log TO xact_bi;
GRANT SELECT ON TABLE public.sy40_support_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy40_support_log TO role_write_xactdev_db;


--
-- Name: TABLE sy41_doc_attachement; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy41_doc_attachement TO PUBLIC;
GRANT SELECT ON TABLE public.sy41_doc_attachement TO xact_bi;
GRANT SELECT ON TABLE public.sy41_doc_attachement TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy41_doc_attachement TO role_write_xactdev_db;


--
-- Name: TABLE sy42_file_cat_mast; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy42_file_cat_mast TO PUBLIC;
GRANT SELECT ON TABLE public.sy42_file_cat_mast TO xact_bi;
GRANT SELECT ON TABLE public.sy42_file_cat_mast TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy42_file_cat_mast TO role_write_xactdev_db;


--
-- Name: TABLE sy50_reports; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy50_reports TO PUBLIC;
GRANT SELECT ON TABLE public.sy50_reports TO xact_bi;
GRANT SELECT ON TABLE public.sy50_reports TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.sy50_reports TO role_write_xactdev_db;


--
-- Name: TABLE tb25_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb25_hd TO PUBLIC;
GRANT SELECT ON TABLE public.tb25_hd TO xact_bi;
GRANT SELECT ON TABLE public.tb25_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb25_hd TO role_write_xactdev_db;


--
-- Name: TABLE tb26_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb26_dt TO PUBLIC;
GRANT SELECT ON TABLE public.tb26_dt TO xact_bi;
GRANT SELECT ON TABLE public.tb26_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb26_dt TO role_write_xactdev_db;


--
-- Name: TABLE tb26s_dts; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb26s_dts TO PUBLIC;
GRANT SELECT ON TABLE public.tb26s_dts TO xact_bi;
GRANT SELECT ON TABLE public.tb26s_dts TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tb26s_dts TO role_write_xactdev_db;


--
-- Name: TABLE test_db; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT ON TABLE public.test_db TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.test_db TO role_write_xactdev_db;


--
-- Name: TABLE tm00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.tm00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.tm00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE tm02_user; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02_user TO PUBLIC;
GRANT SELECT ON TABLE public.tm02_user TO xact_bi;
GRANT SELECT ON TABLE public.tm02_user TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02_user TO role_write_xactdev_db;


--
-- Name: TABLE tm02d_dl_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02d_dl_codes TO PUBLIC;
GRANT SELECT ON TABLE public.tm02d_dl_codes TO xact_bi;
GRANT SELECT ON TABLE public.tm02d_dl_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02d_dl_codes TO role_write_xactdev_db;


--
-- Name: TABLE tm02h_pwd_hist; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02h_pwd_hist TO PUBLIC;
GRANT SELECT ON TABLE public.tm02h_pwd_hist TO xact_bi;
GRANT SELECT ON TABLE public.tm02h_pwd_hist TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm02h_pwd_hist TO role_write_xactdev_db;


--
-- Name: TABLE tm03_priority; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm03_priority TO PUBLIC;
GRANT SELECT ON TABLE public.tm03_priority TO xact_bi;
GRANT SELECT ON TABLE public.tm03_priority TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm03_priority TO role_write_xactdev_db;


--
-- Name: TABLE tm04_task_type; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm04_task_type TO PUBLIC;
GRANT SELECT ON TABLE public.tm04_task_type TO xact_bi;
GRANT SELECT ON TABLE public.tm04_task_type TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm04_task_type TO role_write_xactdev_db;


--
-- Name: TABLE tm04s_sub_task; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm04s_sub_task TO PUBLIC;
GRANT SELECT ON TABLE public.tm04s_sub_task TO xact_bi;
GRANT SELECT ON TABLE public.tm04s_sub_task TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm04s_sub_task TO role_write_xactdev_db;


--
-- Name: TABLE tm06_folder; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm06_folder TO PUBLIC;
GRANT SELECT ON TABLE public.tm06_folder TO xact_bi;
GRANT SELECT ON TABLE public.tm06_folder TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm06_folder TO role_write_xactdev_db;


--
-- Name: TABLE tm07_task_tags; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm07_task_tags TO PUBLIC;
GRANT SELECT ON TABLE public.tm07_task_tags TO xact_bi;
GRANT SELECT ON TABLE public.tm07_task_tags TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm07_task_tags TO role_write_xactdev_db;


--
-- Name: TABLE tm08_report_tags; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm08_report_tags TO PUBLIC;
GRANT SELECT ON TABLE public.tm08_report_tags TO xact_bi;
GRANT SELECT ON TABLE public.tm08_report_tags TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm08_report_tags TO role_write_xactdev_db;


--
-- Name: TABLE tm20_task_freeze_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm20_task_freeze_log TO PUBLIC;
GRANT SELECT ON TABLE public.tm20_task_freeze_log TO xact_bi;
GRANT SELECT ON TABLE public.tm20_task_freeze_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm20_task_freeze_log TO role_write_xactdev_db;


--
-- Name: TABLE tm20_task_freeze_log_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm20_task_freeze_log_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm20_task_freeze_log_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm20_task_freeze_log_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm20_task_freeze_log_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm22_comms_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd TO PUBLIC;
GRANT SELECT ON TABLE public.tm22_comms_hd TO xact_bi;
GRANT SELECT ON TABLE public.tm22_comms_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd TO role_write_xactdev_db;


--
-- Name: TABLE tm22_comms_hd_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm22_comms_hd_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm22_comms_hd_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm22_comms_hd_mob; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd_mob TO PUBLIC;
GRANT SELECT ON TABLE public.tm22_comms_hd_mob TO xact_bi;
GRANT SELECT ON TABLE public.tm22_comms_hd_mob TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22_comms_hd_mob TO role_write_xactdev_db;


--
-- Name: TABLE tm22c_comms_cc; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22c_comms_cc TO PUBLIC;
GRANT SELECT ON TABLE public.tm22c_comms_cc TO xact_bi;
GRANT SELECT ON TABLE public.tm22c_comms_cc TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22c_comms_cc TO role_write_xactdev_db;


--
-- Name: TABLE tm22c_comms_cc_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22c_comms_cc_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm22c_comms_cc_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm22c_comms_cc_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm22c_comms_cc_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm23_comms_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm23_comms_dt TO PUBLIC;
GRANT SELECT ON TABLE public.tm23_comms_dt TO xact_bi;
GRANT SELECT ON TABLE public.tm23_comms_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm23_comms_dt TO role_write_xactdev_db;


--
-- Name: TABLE tm23a_comms_attach; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm23a_comms_attach TO PUBLIC;
GRANT SELECT ON TABLE public.tm23a_comms_attach TO xact_bi;
GRANT SELECT ON TABLE public.tm23a_comms_attach TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm23a_comms_attach TO role_write_xactdev_db;


--
-- Name: TABLE tm25_task_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25_task_hd TO PUBLIC;
GRANT SELECT ON TABLE public.tm25_task_hd TO xact_bi;
GRANT SELECT ON TABLE public.tm25_task_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25_task_hd TO role_write_xactdev_db;


--
-- Name: TABLE tm25_task_hd_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25_task_hd_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm25_task_hd_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm25_task_hd_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25_task_hd_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm25a_assigned; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25a_assigned TO PUBLIC;
GRANT SELECT ON TABLE public.tm25a_assigned TO xact_bi;
GRANT SELECT ON TABLE public.tm25a_assigned TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25a_assigned TO role_write_xactdev_db;


--
-- Name: TABLE tm25r_task_reminders; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25r_task_reminders TO PUBLIC;
GRANT SELECT ON TABLE public.tm25r_task_reminders TO xact_bi;
GRANT SELECT ON TABLE public.tm25r_task_reminders TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25r_task_reminders TO role_write_xactdev_db;


--
-- Name: TABLE tm25r_task_reminders_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25r_task_reminders_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm25r_task_reminders_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm25r_task_reminders_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25r_task_reminders_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm25t_task_tags; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25t_task_tags TO PUBLIC;
GRANT SELECT ON TABLE public.tm25t_task_tags TO xact_bi;
GRANT SELECT ON TABLE public.tm25t_task_tags TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25t_task_tags TO role_write_xactdev_db;


--
-- Name: TABLE tm25t_task_tags_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25t_task_tags_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm25t_task_tags_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm25t_task_tags_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm25t_task_tags_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm26_task_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26_task_dt TO PUBLIC;
GRANT SELECT ON TABLE public.tm26_task_dt TO xact_bi;
GRANT SELECT ON TABLE public.tm26_task_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26_task_dt TO role_write_xactdev_db;


--
-- Name: TABLE tm26_task_dt_arch; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26_task_dt_arch TO PUBLIC;
GRANT SELECT ON TABLE public.tm26_task_dt_arch TO xact_bi;
GRANT SELECT ON TABLE public.tm26_task_dt_arch TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26_task_dt_arch TO role_write_xactdev_db;


--
-- Name: TABLE tm26a_task_attach; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26a_task_attach TO PUBLIC;
GRANT SELECT ON TABLE public.tm26a_task_attach TO xact_bi;
GRANT SELECT ON TABLE public.tm26a_task_attach TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm26a_task_attach TO role_write_xactdev_db;


--
-- Name: TABLE tm38_request_log; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm38_request_log TO PUBLIC;
GRANT SELECT ON TABLE public.tm38_request_log TO xact_bi;
GRANT SELECT ON TABLE public.tm38_request_log TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tm38_request_log TO role_write_xactdev_db;


--
-- Name: TABLE wf25_workflows; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wf25_workflows TO PUBLIC;
GRANT SELECT ON TABLE public.wf25_workflows TO xact_bi;
GRANT SELECT ON TABLE public.wf25_workflows TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wf25_workflows TO role_write_xactdev_db;


--
-- Name: TABLE wf26_app_reason; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wf26_app_reason TO PUBLIC;
GRANT SELECT ON TABLE public.wf26_app_reason TO xact_bi;
GRANT SELECT ON TABLE public.wf26_app_reason TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wf26_app_reason TO role_write_xactdev_db;


--
-- Name: TABLE wr00_sys_opt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr00_sys_opt TO PUBLIC;
GRANT SELECT ON TABLE public.wr00_sys_opt TO xact_bi;
GRANT SELECT ON TABLE public.wr00_sys_opt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr00_sys_opt TO role_write_xactdev_db;


--
-- Name: TABLE wr01_doc_no; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr01_doc_no TO PUBLIC;
GRANT SELECT ON TABLE public.wr01_doc_no TO xact_bi;
GRANT SELECT ON TABLE public.wr01_doc_no TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr01_doc_no TO role_write_xactdev_db;


--
-- Name: TABLE wr03_wr_reasons; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr03_wr_reasons TO PUBLIC;
GRANT SELECT ON TABLE public.wr03_wr_reasons TO xact_bi;
GRANT SELECT ON TABLE public.wr03_wr_reasons TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr03_wr_reasons TO role_write_xactdev_db;


--
-- Name: TABLE wr20_war_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr20_war_hd TO PUBLIC;
GRANT SELECT ON TABLE public.wr20_war_hd TO xact_bi;
GRANT SELECT ON TABLE public.wr20_war_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr20_war_hd TO role_write_xactdev_db;


--
-- Name: TABLE wr20n_book_in_notes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr20n_book_in_notes TO PUBLIC;
GRANT SELECT ON TABLE public.wr20n_book_in_notes TO xact_bi;
GRANT SELECT ON TABLE public.wr20n_book_in_notes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr20n_book_in_notes TO role_write_xactdev_db;


--
-- Name: TABLE wr21_war_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr21_war_dt TO PUBLIC;
GRANT SELECT ON TABLE public.wr21_war_dt TO xact_bi;
GRANT SELECT ON TABLE public.wr21_war_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wr21_war_dt TO role_write_xactdev_db;


--
-- Name: TABLE wt20_doc_hd; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt20_doc_hd TO PUBLIC;
GRANT SELECT ON TABLE public.wt20_doc_hd TO xact_bi;
GRANT SELECT ON TABLE public.wt20_doc_hd TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt20_doc_hd TO role_write_xactdev_db;


--
-- Name: TABLE wt20c_collection_req; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt20c_collection_req TO PUBLIC;
GRANT SELECT ON TABLE public.wt20c_collection_req TO xact_bi;
GRANT SELECT ON TABLE public.wt20c_collection_req TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt20c_collection_req TO role_write_xactdev_db;


--
-- Name: TABLE wt21_disp_dt; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt21_disp_dt TO PUBLIC;
GRANT SELECT ON TABLE public.wt21_disp_dt TO xact_bi;
GRANT SELECT ON TABLE public.wt21_disp_dt TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt21_disp_dt TO role_write_xactdev_db;


--
-- Name: TABLE wt21s_disp_serial; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt21s_disp_serial TO PUBLIC;
GRANT SELECT ON TABLE public.wt21s_disp_serial TO xact_bi;
GRANT SELECT ON TABLE public.wt21s_disp_serial TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt21s_disp_serial TO role_write_xactdev_db;


--
-- Name: TABLE wt22_trip_sheet; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt22_trip_sheet TO PUBLIC;
GRANT SELECT ON TABLE public.wt22_trip_sheet TO xact_bi;
GRANT SELECT ON TABLE public.wt22_trip_sheet TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt22_trip_sheet TO role_write_xactdev_db;


--
-- Name: TABLE wt30_phase_tran; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt30_phase_tran TO PUBLIC;
GRANT SELECT ON TABLE public.wt30_phase_tran TO xact_bi;
GRANT SELECT ON TABLE public.wt30_phase_tran TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.wt30_phase_tran TO role_write_xactdev_db;


--
-- Name: TABLE xserver_info; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.xserver_info TO PUBLIC;
GRANT SELECT ON TABLE public.xserver_info TO xact_bi;
GRANT SELECT ON TABLE public.xserver_info TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.xserver_info TO role_write_xactdev_db;


--
-- Name: TABLE xsql_languages; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.xsql_languages TO PUBLIC;
GRANT SELECT ON TABLE public.xsql_languages TO xact_bi;
GRANT SELECT ON TABLE public.xsql_languages TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.xsql_languages TO role_write_xactdev_db;


--
-- Name: TABLE z_conv_ev_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.z_conv_ev_codes TO PUBLIC;
GRANT SELECT ON TABLE public.z_conv_ev_codes TO xact_bi;
GRANT SELECT ON TABLE public.z_conv_ev_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.z_conv_ev_codes TO role_write_xactdev_db;


--
-- Name: TABLE z_conv_vrm_codes; Type: ACL; Schema: public; Owner: www-data
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.z_conv_vrm_codes TO PUBLIC;
GRANT SELECT ON TABLE public.z_conv_vrm_codes TO xact_bi;
GRANT SELECT ON TABLE public.z_conv_vrm_codes TO role_read_xactdev_db;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.z_conv_vrm_codes TO role_write_xactdev_db;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO PUBLIC;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT ON TABLES TO xact_bi;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: www-data
--

ALTER DEFAULT PRIVILEGES FOR ROLE "www-data" IN SCHEMA public GRANT SELECT ON TABLES TO role_read_xactdev_db;
ALTER DEFAULT PRIVILEGES FOR ROLE "www-data" IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO role_write_xactdev_db;


--
-- PostgreSQL database dump complete
--

\unrestrict tmBfqxm8dhKahmcL7s1b1D6h7Of8VQ9TRmUxowQtCaW7AL49YSQ0dYAzyUBcxzi

