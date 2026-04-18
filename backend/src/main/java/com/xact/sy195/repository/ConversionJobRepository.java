package com.xact.sy195.repository;
import com.xact.sy195.model.ConversionJob;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface ConversionJobRepository extends JpaRepository<ConversionJob, Long> {
    List<ConversionJob> findByRegistrationId(Long registrationId);
    Optional<ConversionJob> findTopByRegistrationIdOrderByCreatedAtDesc(Long registrationId);
}
