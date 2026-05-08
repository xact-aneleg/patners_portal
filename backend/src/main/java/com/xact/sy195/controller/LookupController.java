package com.xact.sy195.controller;

import com.xact.sy195.repository.*;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/lookup")
public class LookupController {

    private final Dl01Repository dl01Repo;
    private final St01Repository st01Repo;
    private final Cl01Repository cl01Repo;
    private final Gl01Repository gl01Repo;

    public LookupController(Dl01Repository dl01Repo, St01Repository st01Repo,
                            Cl01Repository cl01Repo, Gl01Repository gl01Repo) {
        this.dl01Repo = dl01Repo; this.st01Repo = st01Repo;
        this.cl01Repo = cl01Repo; this.gl01Repo = gl01Repo;
    }

    // ── Lookup (autocomplete + modal) ─────────────────────────────────────────

    @GetMapping("/debtors")
    public ResponseEntity<List<Map<String, String>>> lookupDebtors(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "200") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("dlCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = dl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("dlCode")), patt),
                        cb.like(cb.upper(root.get("dlName")), patt)), page)
            .stream().map(r -> {
                Map<String, String> m = new LinkedHashMap<>();
                m.put("code",     r.getDlCode());
                m.put("fileCode", nvl(r.getFilingCode()));
                m.put("name",     nvl(r.getDlName()));
                m.put("loc",      nvl(r.getLoc()));
                return m;
            }).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/stock")
    public ResponseEntity<List<Map<String, String>>> lookupStock(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "200") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("stkCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = st01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("stkCode")), patt),
                        cb.like(cb.upper(root.get("desc1")), patt)), page)
            .stream().map(r -> {
                Map<String, String> m = new LinkedHashMap<>();
                String uomQty = nvl(r.getUom()) + "/" +
                    (r.getUnitQty() != null ? r.getUnitQty().toPlainString() : "");
                m.put("code",   r.getStkCode());
                m.put("name",   nvl(r.getDesc1()));
                m.put("uomQty", uomQty);
                m.put("status", nvl(r.getStatus()));
                return m;
            }).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/creditors")
    public ResponseEntity<List<Map<String, String>>> lookupCreditors(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "200") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("clCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = cl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("clCode")), patt),
                        cb.like(cb.upper(root.get("clName")), patt)), page)
            .stream().map(r -> {
                Map<String, String> m = new LinkedHashMap<>();
                m.put("code",     r.getClCode());
                m.put("prevCode", nvl(r.getSuppAcctCode()));
                m.put("name",     nvl(r.getClName()));
                m.put("bee",      r.getBeeRating() != null ? String.valueOf(r.getBeeRating()) : "");
                return m;
            }).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/gl")
    public ResponseEntity<List<Map<String, String>>> lookupGl(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "200") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("glCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = gl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("glCode")), patt),
                        cb.like(cb.upper(root.get("descr")), patt)), page)
            .stream().map(r -> {
                Map<String, String> m = new LinkedHashMap<>();
                m.put("code",   r.getGlCode());
                m.put("name",   nvl(r.getDescr()));
                m.put("type",   nvl(r.getAcctType()));
                m.put("status", nvl(r.getStatus()));
                return m;
            }).toList();
        return ResponseEntity.ok(results);
    }

    // ── Code range defaults ───────────────────────────────────────────────────

    @GetMapping("/range/debtors")
    public ResponseEntity<Map<String, String>> rangeDebtors() {
        var first = dl01Repo.findAll(PageRequest.of(0, 1, Sort.by("dlCode").ascending()))
                .stream().map(r -> r.getDlCode()).findFirst().orElse("!");
        var last  = dl01Repo.findAll(PageRequest.of(0, 1, Sort.by("dlCode").descending()))
                .stream().map(r -> r.getDlCode()).findFirst().orElse("~");
        return ResponseEntity.ok(Map.of("first", first, "last", last));
    }

    @GetMapping("/range/stock")
    public ResponseEntity<Map<String, String>> rangeStock() {
        var first = st01Repo.findAll(PageRequest.of(0, 1, Sort.by("stkCode").ascending()))
                .stream().map(r -> r.getStkCode()).findFirst().orElse("!");
        var last  = st01Repo.findAll(PageRequest.of(0, 1, Sort.by("stkCode").descending()))
                .stream().map(r -> r.getStkCode()).findFirst().orElse("~");
        return ResponseEntity.ok(Map.of("first", first, "last", last));
    }

    @GetMapping("/range/creditors")
    public ResponseEntity<Map<String, String>> rangeCreditors() {
        var first = cl01Repo.findAll(PageRequest.of(0, 1, Sort.by("clCode").ascending()))
                .stream().map(r -> r.getClCode()).findFirst().orElse("!");
        var last  = cl01Repo.findAll(PageRequest.of(0, 1, Sort.by("clCode").descending()))
                .stream().map(r -> r.getClCode()).findFirst().orElse("~");
        return ResponseEntity.ok(Map.of("first", first, "last", last));
    }

    @GetMapping("/range/gl")
    public ResponseEntity<Map<String, String>> rangeGl() {
        var first = gl01Repo.findAll(PageRequest.of(0, 1, Sort.by("glCode").ascending()))
                .stream().map(r -> r.getGlCode()).findFirst().orElse("!");
        var last  = gl01Repo.findAll(PageRequest.of(0, 1, Sort.by("glCode").descending()))
                .stream().map(r -> r.getGlCode()).findFirst().orElse("~");
        return ResponseEntity.ok(Map.of("first", first, "last", last));
    }

    private String nvl(String s) { return s != null ? s : ""; }
}
