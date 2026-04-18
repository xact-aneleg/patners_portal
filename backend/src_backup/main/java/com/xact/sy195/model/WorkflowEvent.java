package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data @Entity @Table(name = "pp_workflow_events")
public class WorkflowEvent {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "registration_id", nullable = false) private Long registrationId;
    @Column(name = "actor_id")   private Long actorId;
    @Column(name = "actor_name") private String actorName;
    @Column(name = "event_type", nullable = false) private String eventType;
    @Column(name = "from_status") private String fromStatus;
    @Column(name = "to_status")   private String toStatus;
    @Column(columnDefinition = "TEXT") private String comments;
    @Column(name = "created_at")  private LocalDateTime createdAt = LocalDateTime.now();
}
