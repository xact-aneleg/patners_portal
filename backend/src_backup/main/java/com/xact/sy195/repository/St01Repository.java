package com.xact.sy195.repository;
import com.xact.sy195.model.St01Mast;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
@Repository
public interface St01Repository extends JpaRepository<St01Mast, String>, JpaSpecificationExecutor<St01Mast> {}
