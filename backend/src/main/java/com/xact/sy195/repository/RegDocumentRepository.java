package com.xact.sy195.repository;

import com.xact.sy195.model.RegDocument;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RegDocumentRepository extends JpaRepository<RegDocument, Long> {
    List<RegDocument> findByRegistrationIdOrderByUploadedAtDesc(Long registrationId);
    void deleteByRegistrationId(Long registrationId);
}
