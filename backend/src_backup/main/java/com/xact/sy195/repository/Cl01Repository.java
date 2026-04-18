package com.xact.sy195.repository;
import com.xact.sy195.model.Cl01Mast;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
@Repository
public interface Cl01Repository extends JpaRepository<Cl01Mast, String>, JpaSpecificationExecutor<Cl01Mast> {}
