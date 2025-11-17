package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.repository.EmployeeRepository;
// import vn.doan.hrm.service.UserService;

import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private UserService userService;

    // Lấy tất cả employees
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    // Lưu employee
    public Employee saveEmployee(Employee employee) {
        return employeeRepository.save(employee);
    }

    // Lấy employee theo ID
    public Optional<Employee> getEmployeeById(Long id) {
        return employeeRepository.findById(id);
    } // Xóa employee

    @Transactional
    public void deleteEmployee(Long id) {
        System.out.println("EmployeeService: Đang xóa employee ID " + id);

        // Kiểm tra employee có tồn tại không
        Optional<Employee> employeeOpt = employeeRepository.findById(id);
        if (!employeeOpt.isPresent()) {
            throw new RuntimeException("Không tìm thấy nhân viên với ID: " + id);
        }
        Employee employee = employeeOpt.get();
        System.out.println("EmployeeService: Tìm thấy employee: " + employee.getFullName());

        // Lưu User ID để xóa sau (nếu có)
        Long userId = null;
        if (employee.getUser() != null) {
            userId = employee.getUser().getId();
            System.out.println("EmployeeService: Employee có User liên quan với ID: " + userId);
        }

        // Thực hiện xóa employee (cascade sẽ tự động xóa các related entities)
        employeeRepository.delete(employee);
        System.out.println("EmployeeService: Đã gọi delete() cho employee ID " + id);

        // Flush để đảm bảo employee được xóa trước
        employeeRepository.flush();
        System.out.println("EmployeeService: Đã flush() sau khi xóa employee");

        // Xóa User nếu có
        if (userId != null) {
            try {
                userService.deleteUser(userId);
                System.out.println("EmployeeService: Đã xóa User ID: " + userId);
            } catch (Exception e) {
                System.out.println("EmployeeService: Lỗi khi xóa User: " + e.getMessage());
                // Không throw exception để không rollback việc xóa employee
            }
        }

        // Flush để đảm bảo SQL được execute ngay lập tức
        employeeRepository.flush();
        System.out.println("EmployeeService: Đã flush() - SQL delete đã được execute");

        // Verify xóa thành công
        boolean stillExists = employeeRepository.existsById(id);
        System.out.println("EmployeeService: Employee vẫn tồn tại sau khi xóa? " + stillExists);

        if (stillExists) {
            throw new RuntimeException("Không thể xóa employee ID " + id + " - có thể do ràng buộc dữ liệu");
        }
    }    // Kiểm tra email đã tồn tại (delegate to UserService)
    public boolean existsByEmail(String email) {
        // Sẽ cần inject UserService sau
        return false; // Placeholder
    }

    // ✅ Lấy Employee từ User
    public Employee getEmployeeByUser(User user) {
        if (user == null) {
            return null;
        }
        return employeeRepository.findByUser(user).orElse(null);
    }
}
