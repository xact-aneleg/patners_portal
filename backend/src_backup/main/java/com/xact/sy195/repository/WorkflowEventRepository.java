package com.xact.sy195.repository;
import com.xact.sy195.model.WorkflowEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface WorkflowEventRepository extends JpaRepository<WorkflowEvent, Long> {
    List<WorkflowEvent> findByRegistrationIdOrderByCreatedAtAsc(Long registrationId);
}
