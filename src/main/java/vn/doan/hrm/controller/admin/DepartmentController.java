package vn.doan.hrm.controller.admin;

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
import vn.doan.hrm.domain.Department;
import vn.doan.hrm.service.DepartmentService;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/department")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    // Hiển thị trang quản lý departments
    @GetMapping
    public String showDepartments(Model model) {
        List<Department> departments = departmentService.getAllDepartments();
        model.addAttribute("departments", departments);

        // Statistics
        model.addAttribute("totalDepartments", departments.size());

        return "admin/department/show";
    }

    // ✅ Hiển thị form tạo department mới
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("newDepartment", new Department());
        return "admin/department/create";
    }

    // ✅ Xử lý tạo department mới
    @PostMapping("/create")
    public String createDepartment(@Valid @ModelAttribute("newDepartment") Department department,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            return "admin/department/create";
        }

        // Kiểm tra tên phòng ban đã tồn tại
        if (departmentService.existsByName(department.getName())) {
            bindingResult.rejectValue("name", "error.department", "Tên phòng ban đã tồn tại trong hệ thống!");
            return "admin/department/create";
        }

        try {
            departmentService.saveDepartment(department);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Thêm phòng ban '" + department.getName() + "' thành công!");
            return "redirect:/admin/department";
        } catch (Exception e) {
            bindingResult.rejectValue("name", "error.department", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/department/create";
        }
    }

    // ✅ Hiển thị chi tiết department
    @GetMapping("/detail/{id}")
    public String showDepartmentDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Department> departmentOpt = departmentService.getDepartmentById(id);
        if (!departmentOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phòng ban với ID: " + id);
            return "redirect:/admin/department";
        }

        model.addAttribute("department", departmentOpt.get());
        model.addAttribute("id", id);
        return "admin/department/detail";
    }

    // ✅ Hiển thị form cập nhật department
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Department> departmentOpt = departmentService.getDepartmentById(id);
        if (!departmentOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phòng ban với ID: " + id);
            return "redirect:/admin/department";
        }

        model.addAttribute("newDepartment", departmentOpt.get());
        return "admin/department/update";
    }

    // ✅ Xử lý cập nhật department
    @PostMapping("/update")
    public String updateDepartment(@Valid @ModelAttribute("newDepartment") Department department,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        // Tìm department hiện tại
        Optional<Department> existingDeptOpt = departmentService.getDepartmentById(department.getId());
        if (!existingDeptOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phòng ban!");
            return "redirect:/admin/department";
        }

        Department existingDept = existingDeptOpt.get();

        // Kiểm tra tên phòng ban trùng lặp (nếu tên thay đổi)
        if (!existingDept.getName().equals(department.getName())
                && departmentService.existsByName(department.getName())) {
            bindingResult.rejectValue("name", "error.department", "Tên phòng ban đã được sử dụng bởi phòng ban khác!");
            return "admin/department/update";
        }

        try {
            // Cập nhật thông tin
            existingDept.setName(department.getName());
            existingDept.setDescription(department.getDescription());

            departmentService.saveDepartment(existingDept);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật phòng ban '" + existingDept.getName() + "' thành công!");
            return "redirect:/admin/department";
        } catch (Exception e) {
            bindingResult.rejectValue("name", "error.department", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/department/update";
        }
    }

    // ✅ Hiển thị form xác nhận xóa
    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Department> departmentOpt = departmentService.getDepartmentById(id);
        if (!departmentOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phòng ban với ID: " + id);
            return "redirect:/admin/department";
        }

        Department department = departmentOpt.get();
        
        model.addAttribute("newDepartment", department);
        model.addAttribute("id", id);
        model.addAttribute("name", department.getName());
        return "admin/department/delete";
    }

    // ✅ Xử lý xóa department
    @PostMapping("/delete/{id}")
    public String deleteDepartment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Department> departmentOpt = departmentService.getDepartmentById(id);
            if (!departmentOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy phòng ban!");
                return "redirect:/admin/department";
            }

            Department department = departmentOpt.get();

            departmentService.deleteDepartment(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa phòng ban '" + department.getName() + "' thành công!");
            return "redirect:/admin/department";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa: " + e.getMessage());
            return "redirect:/admin/department";
        }
    }
}