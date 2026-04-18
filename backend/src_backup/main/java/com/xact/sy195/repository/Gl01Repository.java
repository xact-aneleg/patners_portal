package com.xact.sy195.repository;
import com.xact.sy195.model.Gl01Mast;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
@Repository
public interface Gl01Repository extends JpaRepository<Gl01Mast, String>, JpaSpecificationExecutor<Gl01Mast> {}
