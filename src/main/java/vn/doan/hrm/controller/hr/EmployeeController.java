package vn.doan.hrm.controller.hr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.domain.Department;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.UserService;
import vn.doan.hrm.service.DepartmentService;
import vn.doan.hrm.service.DepartmentTransferService;
import vn.doan.hrm.dto.EmployeeCreateRequest;
import vn.doan.hrm.dto.EmployeeUpdateRequest;
import org.springframework.security.crypto.password.PasswordEncoder;

import jakarta.validation.Valid;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/employee")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private UserService userService;

    @Autowired
    private DepartmentService departmentService;    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private DepartmentTransferService departmentTransferService;

    // Hiển thị trang quản lý employees
    @GetMapping
    public String showEmployees(Model model) {
        List<Employee> employees = employeeService.getAllEmployees();
        model.addAttribute("employees", employees);
        model.addAttribute("totalEmployees", employees.size());
        return "admin/employee/show";
    }

    //  Hiển thị form tạo employee mới (tích hợp User + Employee)
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("employeeCreateRequest", new EmployeeCreateRequest());

        // Load departments cho dropdown
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);

        return "admin/employee/create";
    }

    //  Xử lý tạo employee mới (tích hợp User + Employee)
    @PostMapping("/create")
    public String createEmployee(@Valid @ModelAttribute("employeeCreateRequest") EmployeeCreateRequest request,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Load departments lại nếu có lỗi
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            return "admin/employee/create";
        }

        // Kiểm tra email đã tồn tại
        if (userService.existsByEmail(request.getEmail())) {
            bindingResult.rejectValue("email", "error.employee", "Email đã tồn tại trong hệ thống!");
            return "admin/employee/create";
        }

        try {
            // 1. Tạo User account trước
            User newUser = new User();
            newUser.setUsername(request.getUsername());
            newUser.setEmail(request.getEmail());
            newUser.setPasswordHash(passwordEncoder.encode(request.getPassword()));
            newUser.setRole(User.Role.valueOf(request.getRole().toLowerCase()));
            User savedUser = userService.saveUser(newUser);

            // 2. Tạo Employee record với đầy đủ thông tin
            Employee newEmployee = new Employee();
            newEmployee.setUser(savedUser); //  Link User → Employee
            newEmployee.setFullName(request.getFullName());
            newEmployee.setPhone(request.getPhone());
            newEmployee.setAddress(request.getAddress());
            newEmployee.setPosition(request.getPosition());
            newEmployee.setDob(request.getDob());

            //  Tự động tạo mã nhân viên nếu không có
            if (request.getEmployeeCode() == null || request.getEmployeeCode().trim().isEmpty()) {
                newEmployee.setEmployeeCode(generateEmployeeCode());
            } else {
                newEmployee.setEmployeeCode(request.getEmployeeCode());
            }

            //  Set ngày vào làm - nếu không điền thì lấy ngày hiện tại
            if (request.getHireDate() != null) {
                newEmployee.setHireDate(request.getHireDate());
            } else {
                newEmployee.setHireDate(java.time.LocalDate.now());
            }

            //  Set thông tin lương và phụ cấp
            newEmployee.setBaseSalary(request.getBaseSalary() != null ? request.getBaseSalary() : BigDecimal.ZERO);
            newEmployee.setAllowanceMeal(
                    request.getAllowanceMeal() != null ? request.getAllowanceMeal() : BigDecimal.ZERO);
            newEmployee.setAllowanceTransport(
                    request.getAllowanceTransport() != null ? request.getAllowanceTransport() : BigDecimal.ZERO);
            newEmployee.setAllowanceSeniority(
                    request.getAllowanceSeniority() != null ? request.getAllowanceSeniority() : BigDecimal.ZERO);

            //  Set thông tin bảo hiểm
            newEmployee.setInsuranceHealth(
                    request.getInsuranceHealth() != null ? request.getInsuranceHealth() : BigDecimal.ZERO);
            newEmployee.setInsuranceSocial(
                    request.getInsuranceSocial() != null ? request.getInsuranceSocial() : BigDecimal.ZERO);

            //  Set số ngày phép
            newEmployee.setRemainingLeaveDays(
                    request.getRemainingLeaveDays() != null ? request.getRemainingLeaveDays() : 12);

            // Set department nếu có
            if (request.getDepartmentId() != null) {
                Department dept = departmentService.getDepartmentById(request.getDepartmentId()).orElse(null);
                newEmployee.setDepartment(dept);
            }

            employeeService.saveEmployee(newEmployee);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Tạo nhân viên '" + request.getFullName() + "' thành công! Tài khoản: " + request.getEmail());

            return "redirect:/admin/employee";

        } catch (Exception e) {
            bindingResult.rejectValue("username", "error.employee", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/employee/create";
        }
    }

    //  Hiển thị chi tiết employee
    @GetMapping("/detail/{id}")
    public String showEmployeeDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
        if (!employeeOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
            return "redirect:/admin/employee";
        }

        model.addAttribute("employee", employeeOpt.get());
        model.addAttribute("id", id);
        return "admin/employee/detail";
    }

    //  Hiển thị form cập nhật employee
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
        if (!employeeOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
            return "redirect:/admin/employee";
        }

        Employee employee = employeeOpt.get();

        // Tạo EmployeeUpdateRequest từ Employee hiện tại
        EmployeeUpdateRequest updateRequest = new EmployeeUpdateRequest();
        updateRequest.setId(employee.getId());
        updateRequest.setFullName(employee.getFullName());
        updateRequest.setPhone(employee.getPhone());
        updateRequest.setAddress(employee.getAddress());
        updateRequest.setPosition(employee.getPosition());
        updateRequest.setHireDate(employee.getHireDate());
        updateRequest.setDob(employee.getDob());

        // Set department ID
        if (employee.getDepartment() != null) {
            updateRequest.setDepartmentId(employee.getDepartment().getId());
        } // Set User info nếu có
        if (employee.getUser() != null) {
            updateRequest.setUsername(employee.getUser().getUsername());
            updateRequest.setEmail(employee.getUser().getEmail());
            updateRequest.setRole(employee.getUser().getRole().name());
        }

        //  Set thông tin lương và phụ cấp
        updateRequest.setEmployeeCode(employee.getEmployeeCode());
        updateRequest.setBaseSalary(employee.getBaseSalary() != null ? employee.getBaseSalary() : BigDecimal.ZERO);
        updateRequest
                .setAllowanceMeal(employee.getAllowanceMeal() != null ? employee.getAllowanceMeal() : BigDecimal.ZERO);
        updateRequest.setAllowanceTransport(
                employee.getAllowanceTransport() != null ? employee.getAllowanceTransport() : BigDecimal.ZERO);
        updateRequest.setAllowanceSeniority(
                employee.getAllowanceSeniority() != null ? employee.getAllowanceSeniority() : BigDecimal.ZERO);
        updateRequest.setInsuranceHealth(
                employee.getInsuranceHealth() != null ? employee.getInsuranceHealth() : BigDecimal.ZERO);
        updateRequest.setInsuranceSocial(
                employee.getInsuranceSocial() != null ? employee.getInsuranceSocial() : BigDecimal.ZERO);
        updateRequest.setRemainingLeaveDays(
                employee.getRemainingLeaveDays() != null ? employee.getRemainingLeaveDays() : 12);

        model.addAttribute("employeeUpdateRequest", updateRequest);

        // Load departments cho dropdown
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);

        return "admin/employee/update";
    }

    //  Xử lý cập nhật employee
    @PostMapping("/update")
    public String updateEmployee(@Valid @ModelAttribute("employeeUpdateRequest") EmployeeUpdateRequest request,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        // Load departments lại nếu có lỗi
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);

        // Tìm employee hiện tại
        Optional<Employee> existingEmpOpt = employeeService.getEmployeeById(request.getId());
        if (!existingEmpOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên!");
            return "redirect:/admin/employee";
        }

        Employee existingEmployee = existingEmpOpt.get();

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            return "admin/employee/update";
        }

        // Kiểm tra email trùng lặp (nếu email thay đổi)
        if (existingEmployee.getUser() != null &&
                !existingEmployee.getUser().getEmail().equals(request.getEmail()) &&
                userService.existsByEmail(request.getEmail())) {
            bindingResult.rejectValue("email", "error.employee", "Email đã được sử dụng bởi người dùng khác!");
            return "admin/employee/update";
        }

        try {
            // Cập nhật User info nếu có
            if (existingEmployee.getUser() != null) {
                User existingUser = existingEmployee.getUser();
                existingUser.setUsername(request.getUsername());
                existingUser.setEmail(request.getEmail());
                existingUser.setRole(User.Role.valueOf(request.getRole().toLowerCase()));
                userService.saveUser(existingUser);
            } // Cập nhật Employee info
            existingEmployee.setFullName(request.getFullName());
            existingEmployee.setPhone(request.getPhone());
            existingEmployee.setAddress(request.getAddress());
            existingEmployee.setPosition(request.getPosition());
            existingEmployee.setHireDate(request.getHireDate());
            existingEmployee.setDob(request.getDob());

            //  Cập nhật thông tin lương và phụ cấp
            existingEmployee.setEmployeeCode(request.getEmployeeCode());
            existingEmployee.setBaseSalary(request.getBaseSalary() != null ? request.getBaseSalary() : BigDecimal.ZERO);
            existingEmployee.setAllowanceMeal(
                    request.getAllowanceMeal() != null ? request.getAllowanceMeal() : BigDecimal.ZERO);
            existingEmployee.setAllowanceTransport(
                    request.getAllowanceTransport() != null ? request.getAllowanceTransport() : BigDecimal.ZERO);
            existingEmployee.setAllowanceSeniority(
                    request.getAllowanceSeniority() != null ? request.getAllowanceSeniority() : BigDecimal.ZERO);
            existingEmployee.setInsuranceHealth(
                    request.getInsuranceHealth() != null ? request.getInsuranceHealth() : BigDecimal.ZERO);
            existingEmployee.setInsuranceSocial(
                    request.getInsuranceSocial() != null ? request.getInsuranceSocial() : BigDecimal.ZERO);
            existingEmployee.setRemainingLeaveDays(
                    request.getRemainingLeaveDays() != null ? request.getRemainingLeaveDays() : 12);            //  Xử lý chuyển phòng ban và lưu lịch sử
            Department currentDepartment = existingEmployee.getDepartment();
            Department newDepartment = null;
            
            if (request.getDepartmentId() != null) {
                newDepartment = departmentService.getDepartmentById(request.getDepartmentId()).orElse(null);
            }
            
            // Kiểm tra xem có thay đổi phòng ban không
            boolean isDepartmentChanged = false;
            if (currentDepartment == null && newDepartment != null) {
                // Trường hợp: từ không có phòng ban → có phòng ban
                isDepartmentChanged = true;
            } else if (currentDepartment != null && newDepartment == null) {
                // Trường hợp: từ có phòng ban → không có phòng ban
                isDepartmentChanged = true;
            } else if (currentDepartment != null && newDepartment != null && 
                       !currentDepartment.getId().equals(newDepartment.getId())) {
                // Trường hợp: chuyển từ phòng ban này sang phòng ban khác
                isDepartmentChanged = true;
            }
            
            // Cập nhật phòng ban
            existingEmployee.setDepartment(newDepartment);
            
            // Lưu lịch sử chuyển phòng ban nếu có thay đổi
            if (isDepartmentChanged) {
                String reason = "Cập nhật thông tin nhân viên";
                if (currentDepartment == null && newDepartment != null) {
                    reason = "Phân công vào phòng ban: " + newDepartment.getName();
                } else if (currentDepartment != null && newDepartment == null) {
                    reason = "Rời khỏi phòng ban: " + currentDepartment.getName();
                } else if (currentDepartment != null && newDepartment != null) {
                    reason = "Chuyển từ " + currentDepartment.getName() + " sang " + newDepartment.getName();
                }
                
                departmentTransferService.createDepartmentTransfer(
                    existingEmployee, 
                    currentDepartment, 
                    newDepartment, 
                    reason
                );
            }

            employeeService.saveEmployee(existingEmployee);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật nhân viên '" + existingEmployee.getFullName() + "' thành công!");
            return "redirect:/admin/employee";

        } catch (Exception e) {
            bindingResult.rejectValue("username", "error.employee", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/employee/update";
        }
    }

    //  Hiển thị form xác nhận xóa
    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        System.out.println("=== GET /admin/employee/delete/" + id + " - HIỂN THỊ FORM XÁC NHẬN XÓA ===");
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
        if (!employeeOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + id);
            return "redirect:/admin/employee";
        }

        Employee employee = employeeOpt.get();
        model.addAttribute("newEmployee", employee);
        model.addAttribute("id", id);
        model.addAttribute("name", employee.getFullName());

        return "admin/employee/delete";
    }

    //  Xử lý xóa employee
    @PostMapping("/delete/{id}")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        System.out.println("=== POST /admin/employee/delete/" + id + " - BẮT ĐẦU XỬ LÝ XÓA ===");
        try {
            Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
            if (!employeeOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên!");
                return "redirect:/admin/employee";
            }

            Employee employee = employeeOpt.get();
            String employeeName = employee.getFullName();

            //  Thêm logging để debug
            System.out.println("Đang xóa nhân viên ID: " + id + ", Tên: " + employeeName);

            // Thực hiện xóa
            employeeService.deleteEmployee(id);

            //  Không cần verify, nếu không có exception thì coi như thành công
            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa nhân viên '" + employeeName + "' thành công!");

            return "redirect:/admin/employee";

        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            System.out.println("DataIntegrityViolationException: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Không thể xóa nhân viên này vì có dữ liệu liên quan (training, performance review, v.v.). Vui lòng xóa dữ liệu liên quan trước!");
            return "redirect:/admin/employee";
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa nhân viên: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa: " + e.getMessage());
            return "redirect:/admin/employee";
        }
    }

    //  Alternative delete method using GET to avoid CSRF issues
    @GetMapping("/delete/{id}/confirm")
    public String confirmDeleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        System.out.println("=== GET /admin/employee/delete/" + id + "/confirm - XÁC NHẬN XÓA BẰNG GET ===");
        try {
            Optional<Employee> employeeOpt = employeeService.getEmployeeById(id);
            if (!employeeOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên!");
                return "redirect:/admin/employee";
            }

            Employee employee = employeeOpt.get();
            String employeeName = employee.getFullName();

            System.out.println("Đang xóa nhân viên ID: " + id + ", Tên: " + employeeName); // Thực hiện xóa
            employeeService.deleteEmployee(id);
            System.out.println("Controller: deleteEmployee() hoàn thành không có exception");

            // Verify xóa thành công bằng cách check lại
            Optional<Employee> checkDeleted = employeeService.getEmployeeById(id);
            if (checkDeleted.isPresent()) {
                System.out.println("Controller: WARNING - Employee vẫn tồn tại sau khi delete!");
                redirectAttributes.addFlashAttribute("errorMessage",
                        "Có lỗi xảy ra: Employee vẫn tồn tại sau khi xóa");
                return "redirect:/admin/employee";
            }

            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa nhân viên '" + employeeName + "' thành công!");

            return "redirect:/admin/employee";

        } catch (org.springframework.dao.DataIntegrityViolationException e) {
            System.out.println("DataIntegrityViolationException: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Không thể xóa nhân viên này vì có dữ liệu liên quan (training, performance review, v.v.). Vui lòng xóa dữ liệu liên quan trước!");
            return "redirect:/admin/employee";
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa nhân viên: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa: " + e.getMessage());
            return "redirect:/admin/employee";
        }
    }

    //  Method tự động tạo mã nhân viên
    private String generateEmployeeCode() {
        // Tạo mã theo format EMP + timestamp (6 số cuối)
        long timestamp = System.currentTimeMillis();
        return "EMP" + String.format("%06d", timestamp % 1000000);
    }
}
