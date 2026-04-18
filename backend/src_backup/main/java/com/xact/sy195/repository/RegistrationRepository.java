package com.xact.sy195.repository;
import com.xact.sy195.model.Registration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface RegistrationRepository extends JpaRepository<Registration, Long> {
    List<Registration> findByPartnerIdOrderByCreatedAtDesc(Long partnerId);
    List<Registration> findByStatusOrderByCreatedAtDesc(String status);
    List<Registration> findByStatusInOrderByCreatedAtDesc(List<String> statuses);
    List<Registration> findAllByOrderByCreatedAtDesc();
}
