package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.Department;
import vn.doan.hrm.repository.DepartmentRepository;

import java.util.List;
import java.util.Optional;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentRepository departmentRepository;

    // Lấy tất cả departments
    public List<Department> getAllDepartments() {
        return departmentRepository.findAll();
    }

    // Lưu department
    public Department saveDepartment(Department department) {
        return departmentRepository.save(department);
    }

    // Kiểm tra tên phòng ban đã tồn tại
    public boolean existsByName(String name) {
        return departmentRepository.existsByName(name);
    }

    // Lấy department theo ID
    public Optional<Department> getDepartmentById(Long id) {
        return departmentRepository.findById(id);
    }

    // Xóa department
    public void deleteDepartment(Long id) {
        departmentRepository.deleteById(id);
    }
}
