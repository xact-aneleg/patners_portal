package com.xact.sy195.repository;
import com.xact.sy195.model.RegLocation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Repository
public interface RegLocationRepository extends JpaRepository<RegLocation, Long> {
    List<RegLocation> findByRegistrationId(Long registrationId);
    @Modifying @Transactional
    void deleteByRegistrationId(Long registrationId);
}
