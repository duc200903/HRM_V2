package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.EmployeeTraining;

import java.util.List;

@Repository
public interface EmployeeTrainingRepository extends JpaRepository<EmployeeTraining, Long> {
    
    // Tìm tất cả đào tạo của một nhân viên
    List<EmployeeTraining> findByEmployeeId(Long employeeId);
    
    // Tìm đào tạo của nhân viên theo trạng thái
    List<EmployeeTraining> findByEmployeeIdAndResult(Long employeeId, String result);
    
    // Tìm đào tạo của nhân viên với thông tin Training
    @Query("SELECT et FROM EmployeeTraining et " +
           "JOIN FETCH et.training t " +
           "WHERE et.employee.id = :employeeId " +
           "ORDER BY t.startDate DESC")
    List<EmployeeTraining> findByEmployeeIdWithTraining(@Param("employeeId") Long employeeId);
    
    // Đếm số đào tạo theo trạng thái
    long countByEmployeeIdAndResult(Long employeeId, String result);

    List<EmployeeTraining> findByTrainingId(Long trainingId);
}