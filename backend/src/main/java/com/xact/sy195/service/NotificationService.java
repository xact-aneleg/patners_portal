package com.xact.sy195.service;

import com.xact.sy195.model.Notification;
import com.xact.sy195.repository.NotificationRepository;
import com.xact.sy195.repository.PartnerRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class NotificationService {

    private final NotificationRepository notifRepo;
    private final PartnerRepository      partnerRepo;
    private final EmailService           emailService;

    public NotificationService(NotificationRepository notifRepo,
                               PartnerRepository partnerRepo,
                               EmailService emailService) {
        this.notifRepo   = notifRepo;
        this.partnerRepo = partnerRepo;
        this.emailService = emailService;
    }

    /** Notify the owning partner of a registration event. */
    @Transactional
    public void notifyPartner(Long partnerId, Long regId, String type, String message, String emailSubject) {
        save(partnerId, regId, type, message);
        emailService.send(emailSubject, message);
    }

    /** Notify all partners with the given role (e.g. XACT_ADMIN, IMPLY). */
    @Transactional
    public void notifyByRole(String role, Long regId, String type, String message, String emailSubject) {
        partnerRepo.findByRole(role).forEach(p -> save(p.getId(), regId, type, message));
        emailService.send(emailSubject, message);
    }

    public List<Notification> getForPartner(Long partnerId) {
        return notifRepo.findByRecipientIdOrderByCreatedAtDesc(partnerId);
    }

    public long countUnread(Long partnerId) {
        return notifRepo.countByRecipientIdAndReadFalse(partnerId);
    }

    @Transactional
    public void markAllRead(Long partnerId) {
        notifRepo.markAllReadByRecipientId(partnerId);
    }

    private void save(Long recipientId, Long regId, String type, String message) {
        Notification n = new Notification();
        n.setRecipientId(recipientId);
        n.setRegistrationId(regId);
        n.setType(type);
        n.setMessage(message);
        notifRepo.save(n);
    }
}
