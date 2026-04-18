package com.xact.sy195.service;

import com.xact.sy195.dto.PortalDTOs.*;
import com.xact.sy195.model.*;
import com.xact.sy195.repository.*;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class RegistrationService {

    private final RegistrationRepository  regRepo;
    private final RegLocationRepository   locRepo;
    private final RegUserRepository       userRepo;
    private final WorkflowEventRepository eventRepo;
    private final PartnerRepository       partnerRepo;
    private final ConversionJobRepository jobRepo;
    private final CompanyProvisioningService provisioningService;

    public RegistrationService(RegistrationRepository regRepo,
                               RegLocationRepository locRepo,
                               RegUserRepository userRepo,
                               WorkflowEventRepository eventRepo,
                               PartnerRepository partnerRepo,
                               ConversionJobRepository jobRepo,
                               @Lazy CompanyProvisioningService provisioningService) {
        this.regRepo             = regRepo;
        this.locRepo             = locRepo;
        this.userRepo            = userRepo;
        this.eventRepo           = eventRepo;
        this.partnerRepo         = partnerRepo;
        this.jobRepo             = jobRepo;
        this.provisioningService = provisioningService;
    }

    // ── Save / update draft ───────────────────────────────────────────────────
    @Transactional
    public RegistrationResponse save(Long partnerId, Long existingId, RegistrationRequest req) {
        Registration reg = existingId != null
                ? regRepo.findById(existingId).orElseThrow()
                : new Registration();
        if (existingId == null) reg.setPartnerId(partnerId);

        reg.setPackageType(req.getPackageType()); reg.setNumUsers(req.getNumUsers());
        reg.setStandalone(req.getStandalone());   reg.setMasterCompany(req.getMasterCompany());
        reg.setSyncModules(req.getSyncModules()); reg.setCompanyName(req.getCompanyName());
        reg.setMasterOrSlave(req.getMasterOrSlave());
        reg.setPostalAddr1(req.getPostalAddr1()); reg.setPostalAddr2(req.getPostalAddr2());
        reg.setPostalAddr3(req.getPostalAddr3()); reg.setPostalAddr4(req.getPostalAddr4());
        reg.setPhysicalAddr1(req.getPhysicalAddr1()); reg.setPhysicalAddr2(req.getPhysicalAddr2());
        reg.setPhysicalAddr3(req.getPhysicalAddr3()); reg.setPhysicalAddr4(req.getPhysicalAddr4());
        reg.setTelephone(req.getTelephone()); reg.setFax(req.getFax());
        reg.setCompanyEmail(req.getCompanyEmail()); reg.setCompanyDomain(req.getCompanyDomain());
        reg.setRegNumber(req.getRegNumber()); reg.setVatNumber(req.getVatNumber());
        reg.setYearEndMonth(req.getYearEndMonth()); reg.setVatRate(req.getVatRate());
        reg.setBankName(req.getBankName()); reg.setBankBranch(req.getBankBranch());
        reg.setBankBranchCode(req.getBankBranchCode()); reg.setBankAccount(req.getBankAccount());
        reg.setMultiCurrency(req.getMultiCurrency());
        reg.setLocalCurrency(req.getLocalCurrency()); reg.setCurrencyCode(req.getCurrencyCode());
        reg.setPeriodGl(req.getPeriodGl()); reg.setPeriodCb(req.getPeriodCb());
        reg.setPeriodDl(req.getPeriodDl()); reg.setPeriodSa(req.getPeriodSa());
        reg.setPeriodCl(req.getPeriodCl()); reg.setPeriodPu(req.getPeriodPu());
        reg.setSystemYearEnd(req.getSystemYearEnd());
        reg = regRepo.save(reg);

        final Long regId = reg.getId();
        locRepo.deleteByRegistrationId(regId);
        userRepo.deleteByRegistrationId(regId);

        for (LocationDTO loc : req.getLocations()) {
            RegLocation rl = new RegLocation();
            rl.setRegistrationId(regId); rl.setLoc(loc.getLoc()); rl.setWhs(loc.getWhs());
            rl.setLocName(loc.getLocName()); rl.setRegion(loc.getRegion());
            rl.setStockLoc(loc.getStockLoc());
            rl.setPhysicalAddr1(loc.getPhysicalAddr1()); rl.setPhysicalAddr2(loc.getPhysicalAddr2());
            rl.setPhysicalAddr3(loc.getPhysicalAddr3()); rl.setPhysicalAddr4(loc.getPhysicalAddr4());
            locRepo.save(rl);
        }
        for (UserDTO u : req.getUsers()) {
            RegUser ru = new RegUser();
            ru.setRegistrationId(regId); ru.setUsername(u.getUsername());
            ru.setFullName(u.getFullName()); ru.setEmail(u.getEmail());
            ru.setDefaultLoc(u.getDefaultLoc()); ru.setAccessGrp(u.getAccessGrp());
            userRepo.save(ru);
        }
        return toResponse(reg);
    }

    // ── Submit ────────────────────────────────────────────────────────────────
    @Transactional
    public RegistrationResponse submit(Long id, Long actorId, String actorName) {
        Registration reg = regRepo.findById(id).orElseThrow();
        if (!"DRAFT".equals(reg.getStatus()) && !"DECLINED_IMPLY".equals(reg.getStatus())
                && !"DECLINED_XACT".equals(reg.getStatus()))
            throw new IllegalStateException("Can only submit DRAFT or DECLINED registrations");
        String prev = reg.getStatus();
        String next = "PRO".equals(reg.getPackageType()) ? "PENDING_IMPLY" : "PENDING_XACT";
        reg.setStatus(next); reg.setSubmittedAt(LocalDateTime.now()); reg.setDeclineReason(null);
        regRepo.save(reg);
        logEvent(id, actorId, actorName, "SUBMITTED", prev, next, null);
        return toResponse(reg);
    }

    // ── Imply approve ─────────────────────────────────────────────────────────
    @Transactional
    public RegistrationResponse approveImply(Long id, Long actorId, String actorName, String comments) {
        Registration reg = regRepo.findById(id).orElseThrow();
        if (!"PENDING_IMPLY".equals(reg.getStatus()))
            throw new IllegalStateException("Registration is not pending Imply approval");
        reg.setStatus("PENDING_XACT"); regRepo.save(reg);
        logEvent(id, actorId, actorName, "APPROVED_IMPLY", "PENDING_IMPLY", "PENDING_XACT", comments);
        return toResponse(reg);
    }

    // ── Imply decline ─────────────────────────────────────────────────────────
    @Transactional
    public RegistrationResponse declineImply(Long id, Long actorId, String actorName, String reason) {
        Registration reg = regRepo.findById(id).orElseThrow();
        if (!"PENDING_IMPLY".equals(reg.getStatus()))
            throw new IllegalStateException("Registration is not pending Imply approval");
        reg.setStatus("DECLINED_IMPLY"); reg.setDeclineReason(reason); regRepo.save(reg);
        logEvent(id, actorId, actorName, "DECLINED_IMPLY", "PENDING_IMPLY", "DECLINED_IMPLY", reason);
        return toResponse(reg);
    }

    // ── XactERP approve → triggers real provisioning ──────────────────────────
    @Transactional
    public RegistrationResponse approveXact(Long id, Long actorId, String actorName, String comments) {
        Registration reg = regRepo.findById(id).orElseThrow();
        if (!"PENDING_XACT".equals(reg.getStatus()))
            throw new IllegalStateException("Registration is not pending XactERP approval");
        reg.setStatus("APPROVED"); regRepo.save(reg);
        logEvent(id, actorId, actorName, "APPROVED_XACT", "PENDING_XACT", "APPROVED", comments);
        // Start conversion job record
        ConversionJob job = new ConversionJob();
        job.setRegistrationId(id); job.setStatus("RUNNING");
        job.setStartedAt(LocalDateTime.now()); jobRepo.save(job);
        // Update status to CONVERTING
        reg.setStatus("CONVERTING"); regRepo.save(reg);
        logEvent(id, actorId, actorName, "CONVERSION_STARTED", "APPROVED", "CONVERTING", null);
        // Run real provisioning — creates DB, schema, seeds data
        try {
            provisioningService.provision(id);
            reg.setStatus("LIVE"); regRepo.save(reg);
            logEvent(id, null, "System", "LIVE", "CONVERTING", "LIVE",
                "Company database provisioned successfully");
        } catch (Exception e) {
            reg.setStatus("CONVERTING"); regRepo.save(reg);
            logEvent(id, null, "System", "CONVERSION_STARTED", "CONVERTING", "CONVERTING",
                "Provisioning error: " + e.getMessage());
        }
        return toResponse(reg);
    }

    // ── XactERP decline ───────────────────────────────────────────────────────
    @Transactional
    public RegistrationResponse declineXact(Long id, Long actorId, String actorName, String reason) {
        Registration reg = regRepo.findById(id).orElseThrow();
        if (!"PENDING_XACT".equals(reg.getStatus()))
            throw new IllegalStateException("Registration is not pending XactERP approval");
        reg.setStatus("DECLINED_XACT"); reg.setDeclineReason(reason); regRepo.save(reg);
        logEvent(id, actorId, actorName, "DECLINED_XACT", "PENDING_XACT", "DECLINED_XACT", reason);
        return toResponse(reg);
    }

    // ── Manual conversion trigger ─────────────────────────────────────────────
    @Transactional
    public ConversionJobDTO triggerConversion(Long id, Long actorId, String actorName) {
        Registration reg = regRepo.findById(id).orElseThrow();
        ConversionJob job = new ConversionJob();
        job.setRegistrationId(id); job.setStatus("RUNNING");
        job.setStartedAt(LocalDateTime.now()); job = jobRepo.save(job);
        reg.setStatus("CONVERTING"); regRepo.save(reg);
        logEvent(id, actorId, actorName, "CONVERSION_STARTED",
                reg.getStatus(), "CONVERTING", "Manual trigger");
        try {
            provisioningService.provision(id);
            reg.setStatus("LIVE"); regRepo.save(reg);
            logEvent(id, null, "System", "LIVE", "CONVERTING", "LIVE", null);
        } catch (Exception e) {
            logEvent(id, null, "System", "CONVERSION_STARTED", "CONVERTING", "CONVERTING",
                    "Error: " + e.getMessage());
        }
        return toJobDto(jobRepo.findTopByRegistrationIdOrderByCreatedAtDesc(id).orElse(job));
    }

    // ── Query helpers ─────────────────────────────────────────────────────────
    public List<RegistrationSummary> listForPartner(Long partnerId) {
        return regRepo.findByPartnerIdOrderByCreatedAtDesc(partnerId).stream().map(this::toSummary).toList();
    }
    public List<RegistrationSummary> listByStatus(List<String> statuses) {
        return regRepo.findByStatusInOrderByCreatedAtDesc(statuses).stream().map(this::toSummary).toList();
    }
    public List<RegistrationSummary> listAll() {
        return regRepo.findAllByOrderByCreatedAtDesc().stream().map(this::toSummary).toList();
    }
    public RegistrationResponse get(Long id) {
        return toResponse(regRepo.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Registration not found: " + id)));
    }
    public ConversionJobDTO getLatestJob(Long registrationId) {
        return jobRepo.findTopByRegistrationIdOrderByCreatedAtDesc(registrationId)
                .map(this::toJobDto)
                .orElseThrow(() -> new NoSuchElementException("No job found"));
    }

    // ── Mappers ───────────────────────────────────────────────────────────────
    private RegistrationResponse toResponse(Registration r) {
        RegistrationResponse dto = new RegistrationResponse();
        dto.setId(r.getId()); dto.setPartnerId(r.getPartnerId());
        partnerRepo.findById(r.getPartnerId()).ifPresent(p -> dto.setPartnerName(p.getCompanyName()));
        dto.setPackageType(r.getPackageType()); dto.setNumUsers(r.getNumUsers());
        dto.setCompanyName(r.getCompanyName()); dto.setStatus(r.getStatus());
        dto.setDeclineReason(r.getDeclineReason());
        dto.setSubmittedAt(r.getSubmittedAt()); dto.setCreatedAt(r.getCreatedAt());
        dto.setUpdatedAt(r.getUpdatedAt()); dto.setStandalone(r.getStandalone());
        dto.setMasterCompany(r.getMasterCompany()); dto.setSyncModules(r.getSyncModules());
        dto.setMasterOrSlave(r.getMasterOrSlave());
        dto.setPostalAddr1(r.getPostalAddr1()); dto.setPostalAddr2(r.getPostalAddr2());
        dto.setPostalAddr3(r.getPostalAddr3()); dto.setPostalAddr4(r.getPostalAddr4());
        dto.setPhysicalAddr1(r.getPhysicalAddr1()); dto.setPhysicalAddr2(r.getPhysicalAddr2());
        dto.setPhysicalAddr3(r.getPhysicalAddr3()); dto.setPhysicalAddr4(r.getPhysicalAddr4());
        dto.setTelephone(r.getTelephone()); dto.setFax(r.getFax());
        dto.setCompanyEmail(r.getCompanyEmail()); dto.setCompanyDomain(r.getCompanyDomain());
        dto.setRegNumber(r.getRegNumber()); dto.setVatNumber(r.getVatNumber());
        dto.setYearEndMonth(r.getYearEndMonth()); dto.setVatRate(r.getVatRate());
        dto.setBankName(r.getBankName()); dto.setBankBranch(r.getBankBranch());
        dto.setBankBranchCode(r.getBankBranchCode()); dto.setBankAccount(r.getBankAccount());
        dto.setMultiCurrency(r.getMultiCurrency());
        dto.setLocalCurrency(r.getLocalCurrency()); dto.setCurrencyCode(r.getCurrencyCode());
        dto.setPeriodGl(r.getPeriodGl()); dto.setPeriodCb(r.getPeriodCb());
        dto.setPeriodDl(r.getPeriodDl()); dto.setPeriodSa(r.getPeriodSa());
        dto.setPeriodCl(r.getPeriodCl()); dto.setPeriodPu(r.getPeriodPu());
        dto.setSystemYearEnd(r.getSystemYearEnd());
        dto.setLocations(locRepo.findByRegistrationId(r.getId()).stream().map(l -> {
            var ld = new LocationDTO(); ld.setId(l.getId()); ld.setLoc(l.getLoc());
            ld.setWhs(l.getWhs()); ld.setLocName(l.getLocName()); ld.setRegion(l.getRegion());
            ld.setStockLoc(l.getStockLoc()); ld.setPhysicalAddr1(l.getPhysicalAddr1());
            ld.setPhysicalAddr2(l.getPhysicalAddr2()); ld.setPhysicalAddr3(l.getPhysicalAddr3());
            ld.setPhysicalAddr4(l.getPhysicalAddr4()); return ld;
        }).toList());
        dto.setUsers(userRepo.findByRegistrationId(r.getId()).stream().map(u -> {
            var ud = new UserDTO(); ud.setId(u.getId()); ud.setUsername(u.getUsername());
            ud.setFullName(u.getFullName()); ud.setEmail(u.getEmail());
            ud.setDefaultLoc(u.getDefaultLoc()); ud.setAccessGrp(u.getAccessGrp()); return ud;
        }).toList());
        dto.setEvents(eventRepo.findByRegistrationIdOrderByCreatedAtAsc(r.getId()).stream().map(e -> {
            var ed = new WorkflowEventDTO(); ed.setId(e.getId()); ed.setActorName(e.getActorName());
            ed.setEventType(e.getEventType()); ed.setFromStatus(e.getFromStatus());
            ed.setToStatus(e.getToStatus()); ed.setComments(e.getComments());
            ed.setCreatedAt(e.getCreatedAt()); return ed;
        }).toList());
        return dto;
    }

    private RegistrationSummary toSummary(Registration r) {
        RegistrationSummary s = new RegistrationSummary();
        s.setId(r.getId()); s.setPackageType(r.getPackageType()); s.setNumUsers(r.getNumUsers());
        s.setCompanyName(r.getCompanyName()); s.setStatus(r.getStatus());
        s.setSubmittedAt(r.getSubmittedAt()); s.setCreatedAt(r.getCreatedAt());
        partnerRepo.findById(r.getPartnerId()).ifPresent(p -> s.setPartnerName(p.getCompanyName()));
        return s;
    }

    private ConversionJobDTO toJobDto(ConversionJob j) {
        ConversionJobDTO d = new ConversionJobDTO(); d.setId(j.getId());
        d.setRegistrationId(j.getRegistrationId()); d.setStatus(j.getStatus());
        d.setStartedAt(j.getStartedAt()); d.setCompletedAt(j.getCompletedAt());
        d.setLogOutput(j.getLogOutput()); return d;
    }

    private void logEvent(Long regId, Long actorId, String actorName, String eventType,
                          String from, String to, String comments) {
        WorkflowEvent ev = new WorkflowEvent();
        ev.setRegistrationId(regId); ev.setActorId(actorId); ev.setActorName(actorName);
        ev.setEventType(eventType); ev.setFromStatus(from); ev.setToStatus(to);
        ev.setComments(comments); eventRepo.save(ev);
    }
}
