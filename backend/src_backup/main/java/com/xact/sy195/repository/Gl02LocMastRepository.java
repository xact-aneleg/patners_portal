package com.xact.sy195.repository;
import com.xact.sy195.model.Gl02LocMast;
import com.xact.sy195.model.Gl02LocMastId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface Gl02LocMastRepository extends JpaRepository<Gl02LocMast, Gl02LocMastId>,
        JpaSpecificationExecutor<Gl02LocMast> {
    List<Gl02LocMast> findByStkLocOrderByLocAscWhsAsc(String stkLoc);
}
