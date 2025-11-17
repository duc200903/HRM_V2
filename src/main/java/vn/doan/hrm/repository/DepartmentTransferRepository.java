package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.DepartmentTransfer;

import java.util.List;

@Repository
public interface DepartmentTransferRepository extends JpaRepository<DepartmentTransfer, Long> {
    
    // Tìm lịch sử chuyển phòng ban của một nhân viên
    List<DepartmentTransfer> findByEmployeeIdOrderByTransferDateDesc(Long employeeId);
    
    // Tìm lịch sử chuyển phòng ban với thông tin chi tiết
    @Query("SELECT dt FROM DepartmentTransfer dt " +
           "JOIN FETCH dt.employee e " +
           "LEFT JOIN FETCH dt.fromDepartment fd " +
           "JOIN FETCH dt.toDepartment td " +
           "WHERE dt.employee.id = :employeeId " +
           "ORDER BY dt.transferDate DESC, dt.createdAt DESC")
    List<DepartmentTransfer> findByEmployeeIdWithDetails(@Param("employeeId") Long employeeId);
    
    // Tìm tất cả lịch sử chuyển phòng ban với thông tin chi tiết
    @Query("SELECT dt FROM DepartmentTransfer dt " +
           "JOIN FETCH dt.employee e " +
           "LEFT JOIN FETCH dt.fromDepartment fd " +
           "JOIN FETCH dt.toDepartment td " +
           "ORDER BY dt.transferDate DESC, dt.createdAt DESC")
    List<DepartmentTransfer> findAllWithDetails();
    
    // Tìm lịch sử chuyển từ hoặc đến một phòng ban cụ thể
    @Query("SELECT dt FROM DepartmentTransfer dt " +
           "WHERE dt.fromDepartment.id = :departmentId OR dt.toDepartment.id = :departmentId " +
           "ORDER BY dt.transferDate DESC")
    List<DepartmentTransfer> findByDepartmentId(@Param("departmentId") Long departmentId);
}