-- Sample data for development / testing
-- psql -U postgres -d xactdev -f seed.sql

INSERT INTO gl02_loc_mast (loc, whs, description) VALUES
('001','00','Main Warehouse'),
('002','00','Branch Store'),
('003','00','Online Fulfilment')
ON CONFLICT DO NOTHING;

INSERT INTO sy02l_user_loc (user_name, loc, whs) VALUES
('admin','00','00'),
('admin','001','00'),
('admin','002','00'),
('admin','003','00')
ON CONFLICT DO NOTHING;

INSERT INTO dl01_mast (dl_code,name,address_1,loc,rep_code,dl_cat,class,cr_status,inv_type,status,balance,master_acct,linked_to,address_only_acct) VALUES
('ACC001','Acme Corporation','123 Main Street','001','REP01','CAT-A','A','GOOD','TAX','A',15250.00,'N','ACC001','N'),
('ACC002','Beta Supplies Ltd','45 Commerce Drive','001','REP01','CAT-A','B','HOLD','TAX','A',3400.50,'N','ACC002','N'),
('ACC003','Gamma Retail','78 Shop Road','002','REP02','CAT-B','A','GOOD','CASH','A',0.00,'N','ACC003','N'),
('ACC004','Delta Masters','99 Head Office Blvd','001','REP01','CAT-A','A','GOOD','TAX','A',88000.00,'Y','ACC004','N'),
('ACC005','Delta Sub 1','5 Branch Lane','001','REP01','CAT-A','A','GOOD','TAX','A',1200.00,'N','ACC004','N'),
('ACC006','Epsilon Corp','22 Park Ave','003','REP03','CAT-C','C','COD','TAX','B',500.00,'N','ACC006','N')
ON CONFLICT DO NOTHING;

INSERT INTO st01_mast (stk_code,desc_1,stk_grp,gl_grp,uom,unit_qty,keep_bal,status,web_enabled,retail_enabled,vat_ind,line_type) VALUES
('WIDGET-001','Standard Widget Blue','WIDGETS','GL-STOCK','EA',1.0000,'Y','A','Y','Y','S','STK'),
('WIDGET-002','Standard Widget Red','WIDGETS','GL-STOCK','EA',1.0000,'Y','A','Y','Y','S','STK'),
('PACK-001','Widget Pack 10','PACKS','GL-STOCK','PK',10.0000,'Y','A','N','N','S','STK'),
('SVC-001','Installation Service','SERVICES','GL-SVC','HR',1.0000,'N','A','N','N','S','SVC'),
('RAW-001','Raw Material A','RAW','GL-RAW','KG',1.0000,'Y','A','N','N','S','STK'),
('RAW-002','Raw Material B','RAW','GL-RAW','KG',1.0000,'Y','B','N','N','S','STK')
ON CONFLICT DO NOTHING;

INSERT INTO cl01_mast (cl_code,name,address_1,cl_cat,status,master_acct,linked_to,track_by_foreign_currency,inter_co) VALUES
('SUP001','Top Supplier Pty Ltd','100 Supply Street','LOCAL','A','N','SUP001','N','N'),
('SUP002','Global Imports Inc','200 Import Ave','IMPORT','A','N','SUP002','Y','N'),
('SUP003','Group Holdings Ltd','300 Group Blvd','LOCAL','A','Y','SUP003','N','Y'),
('SUP004','Group Sub Entity','301 Group Blvd','LOCAL','A','N','SUP003','N','Y')
ON CONFLICT DO NOTHING;

INSERT INTO gl01_mast (gl_code,description,acct_type,post,status,budget_based_on) VALUES
('1000','Cash and Cash Equivalents','B','P','A','S'),
('1100','Accounts Receivable','B','P','A','S'),
('1200','Inventory','B','P','A','S'),
('2000','Accounts Payable','B','P','A','S'),
('3000','Share Capital','B','S','A','S'),
('4000','Revenue','P','P','A','S'),
('5000','Cost of Sales','P','P','A','C'),
('6000','Operating Expenses','P','S','A','C'),
('6100','Salaries','P','P','A','C'),
('6200','Rent','P','P','A','C')
ON CONFLICT DO NOTHING;
