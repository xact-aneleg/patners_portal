package com.xact.sy195.repository;
import com.xact.sy195.model.Dl01Mast;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
@Repository
public interface Dl01Repository extends JpaRepository<Dl01Mast, String>, JpaSpecificationExecutor<Dl01Mast> {}
