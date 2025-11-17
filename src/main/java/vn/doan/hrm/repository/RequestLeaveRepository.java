package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.RequestLeave;

import java.util.List;

@Repository
public interface RequestLeaveRepository extends JpaRepository<RequestLeave, Long> {
    
    // Filter by year
    List<RequestLeave> findByLeaveYear(Integer year);
    
    // Filter by month and year
    List<RequestLeave> findByLeaveMonthAndLeaveYear(Integer month, Integer year);
    
    // Filter by status
    List<RequestLeave> findByStatus(RequestLeave.Status status);
    
    // Filter by employee
    List<RequestLeave> findByEmployeeId(Long employeeId);
    
    // Complex filter query
    @Query("SELECT r FROM RequestLeave r WHERE " +
           "(:year IS NULL OR r.leaveYear = :year) AND " +
           "(:month IS NULL OR r.leaveMonth = :month) AND " +
           "(:status IS NULL OR r.status = :status) " +
           "ORDER BY r.createdAt DESC")
    List<RequestLeave> findWithFilters(@Param("year") Integer year, 
                                      @Param("month") Integer month, 
                                      @Param("status") RequestLeave.Status status);
    
    // Get distinct years
    @Query("SELECT DISTINCT r.leaveYear FROM RequestLeave r WHERE r.leaveYear IS NOT NULL ORDER BY r.leaveYear DESC")
    List<Integer> findDistinctYears();
}
