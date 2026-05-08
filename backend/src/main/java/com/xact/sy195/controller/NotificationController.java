package com.xact.sy195.controller;

import com.xact.sy195.dto.PortalDTOs.NotificationDTO;
import com.xact.sy195.model.Notification;
import com.xact.sy195.model.Partner;
import com.xact.sy195.service.NotificationService;
import com.xact.sy195.service.PartnerService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/portal/notifications")
public class NotificationController {

    private final NotificationService notifService;
    private final PartnerService      partnerService;

    public NotificationController(NotificationService notifService, PartnerService partnerService) {
        this.notifService  = notifService;
        this.partnerService = partnerService;
    }

    @GetMapping
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<NotificationDTO>> list(Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        List<NotificationDTO> dtos = notifService.getForPartner(p.getId())
                .stream().map(this::toDto).toList();
        return ResponseEntity.ok(dtos);
    }

    @GetMapping("/unread-count")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Map<String, Long>> unreadCount(Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        return ResponseEntity.ok(Map.of("count", notifService.countUnread(p.getId())));
    }

    @PutMapping("/read-all")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> readAll(Authentication auth) {
        Partner p = partnerService.getByEmail(auth.getName());
        notifService.markAllRead(p.getId());
        return ResponseEntity.noContent().build();
    }

    private NotificationDTO toDto(Notification n) {
        NotificationDTO dto = new NotificationDTO();
        dto.setId(n.getId());
        dto.setRegistrationId(n.getRegistrationId());
        dto.setType(n.getType());
        dto.setMessage(n.getMessage());
        dto.setRead(n.isRead());
        dto.setCreatedAt(n.getCreatedAt());
        return dto;
    }
}
