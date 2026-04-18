package com.xact.sy195.model;
import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Data @Entity @Table(name = "pp_conversion_jobs")
public class ConversionJob {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private Long id;
    @Column(name = "registration_id", nullable = false) private Long registrationId;
    private String status = "PENDING"; // PENDING | RUNNING | COMPLETE | FAILED
    @Column(name = "started_at")    private LocalDateTime startedAt;
    @Column(name = "completed_at")  private LocalDateTime completedAt;
    @Column(name = "log_output", columnDefinition = "TEXT") private String logOutput;
    @Column(name = "created_at")    private LocalDateTime createdAt = LocalDateTime.now();
}
