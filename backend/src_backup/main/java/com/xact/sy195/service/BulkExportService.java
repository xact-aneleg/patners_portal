package com.xact.sy195.service;

import com.xact.sy195.repository.*;
import com.xact.sy195.dto.FilterDTOs.*;
import com.xact.sy195.model.*;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BulkExportService {

    private final Dl01Repository dl01Repo;
    private final St01Repository st01Repo;
    private final Cl01Repository cl01Repo;
    private final Gl01Repository gl01Repo;
    private final ExcelService   excelService;

    public BulkExportService(Dl01Repository dl01Repo, St01Repository st01Repo,
                             Cl01Repository cl01Repo, Gl01Repository gl01Repo,
                             ExcelService excelService) {
        this.dl01Repo    = dl01Repo; this.st01Repo = st01Repo;
        this.cl01Repo    = cl01Repo; this.gl01Repo = gl01Repo;
        this.excelService = excelService;
    }

    // ── Debtors ───────────────────────────────────────────────────────────────
    public byte[] exportDebtors(DebtorFilterDTO f) {
        List<Dl01Mast> rows = dl01Repo.findAll(debtorSpec(f), Sort.by("dlCode"));
        return excelService.exportToXlsx("dl01_mast", rows);
    }

    private Specification<Dl01Mast> debtorSpec(DebtorFilterDTO f) {
        return (root, query, cb) -> {
            List<Predicate> p = new ArrayList<>();
            // PK range filter — real field: dl_code
            p.add(cb.between(root.get("dlCode"), f.getStartAcct(), f.getEndAcct()));
            // master_acct VARCHAR(1)
            switch (f.getMasterAcct()) {
                case "E" -> p.add(cb.equal(root.get("masterAcct"), "N"));
                case "M" -> p.add(cb.equal(root.get("masterAcct"), "Y"));
                case "S" -> { p.add(cb.equal(root.get("masterAcct"), "N"));
                              p.add(cb.notEqual(root.get("linkedAcct"), root.get("dlCode"))); }
            }
            // address_only_acct VARCHAR(1) — real field name
            switch (f.getDelAcct()) {
                case "D" -> p.add(cb.equal(root.get("addressOnlyAcct"), "Y"));
                case "E" -> p.add(cb.equal(root.get("addressOnlyAcct"), "N"));
            }
            // status VARCHAR(1)
            if (!"ALL".equals(f.getStatus())) p.add(cb.equal(root.get("status"), f.getStatus()));
            // cr_status VARCHAR(4) — real values are GOOD, HOLD, COD (not single char)
            if (!"ALL".equals(f.getCrStatus())) p.add(cb.equal(root.get("crStatus"), f.getCrStatus()));
            // balance NUMERIC(13,2)
            switch (f.getBalance()) {
                case "B" -> p.add(cb.notEqual(root.get("balance"), 0));
                case "Z" -> p.add(cb.equal(root.get("balance"), 0));
            }
            // track_by_foreign_currency VARCHAR(1)
            switch (f.getForeignTracked()) {
                case "E" -> p.add(cb.equal(root.get("trackByForeignCurrency"), "N"));
                case "F" -> p.add(cb.equal(root.get("trackByForeignCurrency"), "Y"));
            }
            // dl_cat VARCHAR(5)
            if (Boolean.TRUE.equals(f.getFilterCat()) && f.getStartCat() != null)
                p.add(cb.between(root.get("dlCat"), f.getStartCat(), f.getEndCat()));
            // rep_code/mkt_rep VARCHAR(5)
            if (Boolean.TRUE.equals(f.getFilterRep())) {
                String repField = "R".equals(f.getRepType()) ? "repCode" : "mktRep";
                p.add(cb.between(root.get(repField), f.getStartRep(), f.getEndRep()));
            }
            return cb.and(p.toArray(new Predicate[0]));
        };
    }

    // ── Stock ─────────────────────────────────────────────────────────────────
    public byte[] exportStock(StockFilterDTO f) {
        List<St01Mast> rows = st01Repo.findAll(stockSpec(f), Sort.by("stkCode"));
        return excelService.exportToXlsx("st01_mast", rows);
    }

    private Specification<St01Mast> stockSpec(StockFilterDTO f) {
        return (root, query, cb) -> {
            List<Predicate> p = new ArrayList<>();
            // stk_code VARCHAR(16)
            p.add(cb.between(root.get("stkCode"), f.getStartStkCode(), f.getEndStkCode()));
            // stk_grp VARCHAR(5)
            if ("G".equals(f.getStkSelection()) && f.getStartStkGrp() != null)
                p.add(cb.between(root.get("stkGrp"), f.getStartStkGrp(), f.getEndStkGrp()));
            // status VARCHAR(1)
            if (!"ALL".equals(f.getStatus())) p.add(cb.equal(root.get("status"), f.getStatus()));
            else p.add(cb.notEqual(root.get("status"), "D"));
            // web_enabled, retail_enabled, trade_in_item, import_item, keep_bal — all VARCHAR(1)
            switch (f.getWebEnabled()) {
                case "W" -> p.add(cb.equal(root.get("webEnabled"), "Y"));
                case "E" -> p.add(cb.equal(root.get("webEnabled"), "N"));
            }
            switch (f.getRetailEnabled()) {
                case "R" -> p.add(cb.equal(root.get("retailEnabled"), "Y"));
                case "E" -> p.add(cb.equal(root.get("retailEnabled"), "N"));
            }
            switch (f.getTradeInItems()) {
                case "T" -> p.add(cb.equal(root.get("tradeInItem"), "Y"));
                case "E" -> p.add(cb.equal(root.get("tradeInItem"), "N"));
            }
            switch (f.getImportItems()) {
                case "IM" -> p.add(cb.equal(root.get("importItem"), "Y"));
                case "E"  -> p.add(cb.equal(root.get("importItem"), "N"));
            }
            switch (f.getKeepBalance()) {
                case "K" -> p.add(cb.equal(root.get("keepBal"), "Y"));
                case "E" -> p.add(cb.equal(root.get("keepBal"), "N"));
            }
            return cb.and(p.toArray(new Predicate[0]));
        };
    }

    // ── Creditors ─────────────────────────────────────────────────────────────
    public byte[] exportCreditors(CreditorFilterDTO f) {
        List<Cl01Mast> rows = cl01Repo.findAll(creditorSpec(f), Sort.by("clCode"));
        return excelService.exportToXlsx("cl01_mast", rows);
    }

    private Specification<Cl01Mast> creditorSpec(CreditorFilterDTO f) {
        return (root, query, cb) -> {
            List<Predicate> p = new ArrayList<>();
            p.add(cb.between(root.get("clCode"), f.getStartAcct(), f.getEndAcct()));
            switch (f.getMasterAccount()) {
                case "E" -> p.add(cb.equal(root.get("masterAcct"), "N"));
                case "M" -> p.add(cb.equal(root.get("masterAcct"), "Y"));
                case "S" -> { p.add(cb.equal(root.get("masterAcct"), "N"));
                              p.add(cb.notEqual(root.get("linkedAcct"), root.get("clCode"))); }
            }
            if (!"ALL".equals(f.getStatus())) p.add(cb.equal(root.get("status"), f.getStatus()));
            switch (f.getForeignTracked()) {
                case "E" -> p.add(cb.equal(root.get("trackByForeignCurrency"), "N"));
                case "F" -> p.add(cb.equal(root.get("trackByForeignCurrency"), "Y"));
            }
            switch (f.getInterCo()) {
                case "Y" -> p.add(cb.equal(root.get("icAcct"), "Y"));
                case "N" -> p.add(cb.equal(root.get("icAcct"), "N"));
            }
            switch (f.getImportAccts()) {
                case "Y" -> p.add(cb.equal(root.get("importAcct"), "Y"));
                case "N" -> p.add(cb.equal(root.get("importAcct"), "N"));
            }
            return cb.and(p.toArray(new Predicate[0]));
        };
    }

    // ── General Ledger ────────────────────────────────────────────────────────
    public byte[] exportGl(GlFilterDTO f) {
        List<Gl01Mast> rows = gl01Repo.findAll(glSpec(f), Sort.by("glCode"));
        return excelService.exportToXlsx("gl01_mast", rows);
    }

    private Specification<Gl01Mast> glSpec(GlFilterDTO f) {
        return (root, query, cb) -> {
            List<Predicate> p = new ArrayList<>();
            p.add(cb.between(root.get("glCode"), f.getStartCode(), f.getEndCode()));
            if (!"ALL".equals(f.getStatus()))      p.add(cb.equal(root.get("status"), f.getStatus()));
            if (!"A".equals(f.getAcctType()))      p.add(cb.equal(root.get("acctType"), f.getAcctType()));
            if (!"A".equals(f.getPostSubTot()))    p.add(cb.equal(root.get("post"), f.getPostSubTot()));
            if (!"ALL".equals(f.getBudgetBasedOn())) p.add(cb.equal(root.get("budgetBasedOn"), f.getBudgetBasedOn()));
            return cb.and(p.toArray(new Predicate[0]));
        };
    }
}
