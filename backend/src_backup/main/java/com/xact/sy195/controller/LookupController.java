package com.xact.sy195.controller;

import com.xact.sy195.repository.*;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    // ── Autocomplete — uses real field names ───────────────────────────────────

    @GetMapping("/debtors")
    public ResponseEntity<List<Map<String, String>>> lookupDebtors(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "15") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("dlCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = dl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("dlCode")), patt),
                        cb.like(cb.upper(root.get("dlName")), patt)), page)   // real field: dl_name
            .stream().map(r -> Map.of("code", r.getDlCode(), "name", nvl(r.getDlName()))).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/stock")
    public ResponseEntity<List<Map<String, String>>> lookupStock(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "15") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("stkCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = st01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("stkCode")), patt),
                        cb.like(cb.upper(root.get("desc1")), patt)), page)   // real field: desc_1
            .stream().map(r -> Map.of("code", r.getStkCode(), "name", nvl(r.getDesc1()))).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/creditors")
    public ResponseEntity<List<Map<String, String>>> lookupCreditors(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "15") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("clCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = cl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("clCode")), patt),
                        cb.like(cb.upper(root.get("clName")), patt)), page)   // real field: cl_name
            .stream().map(r -> Map.of("code", r.getClCode(), "name", nvl(r.getClName()))).toList();
        return ResponseEntity.ok(results);
    }

    @GetMapping("/gl")
    public ResponseEntity<List<Map<String, String>>> lookupGl(
            @RequestParam(defaultValue = "") String q,
            @RequestParam(defaultValue = "15") int limit) {
        var page = PageRequest.of(0, limit, Sort.by("glCode"));
        String patt = "%" + q.toUpperCase() + "%";
        var results = gl01Repo.findAll(
            (root, query, cb) -> q.isBlank() ? cb.conjunction()
                : cb.or(cb.like(cb.upper(root.get("glCode")), patt),
                        cb.like(cb.upper(root.get("descr")), patt)), page)   // real field: descr
            .stream().map(r -> Map.of("code", r.getGlCode(), "name", nvl(r.getDescr()))).toList();
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
