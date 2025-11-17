package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.User;

import java.util.Optional;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    
    // ✅ Tìm Employee theo User
    Optional<Employee> findByUser(User user);
}
