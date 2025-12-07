package vn.doan.hrm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.Salary;

@Repository
public interface SalaryRepository extends JpaRepository<Salary, Long> {
    boolean existsByEmployeeIdAndMonth(Long employeeId, String month);    List<Salary> findByMonth(String month);
    
    //  Lấy lương theo employee
    List<Salary> findByEmployeeId(Long employeeId);
    
    //  Lấy lương theo employee và tháng
    Salary findByEmployeeIdAndMonth(Long employeeId, String month);
}
