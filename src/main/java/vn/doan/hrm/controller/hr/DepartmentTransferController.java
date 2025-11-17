package vn.doan.hrm.controller.hr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.doan.hrm.domain.DepartmentTransfer;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.service.DepartmentTransferService;
import vn.doan.hrm.service.EmployeeService;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/department-transfer")
public class DepartmentTransferController {

    @Autowired
    private DepartmentTransferService departmentTransferService;

    @Autowired
    private EmployeeService employeeService;

    // Hiển thị tất cả lịch sử chuyển phòng ban
    @GetMapping
    public String showDepartmentTransfers(Model model) {
        List<DepartmentTransfer> transfers = departmentTransferService.getAllTransferHistory();
        model.addAttribute("transfers", transfers);
        model.addAttribute("totalTransfers", transfers.size());
        return "admin/department-transfer/show";
    }

    // Hiển thị lịch sử chuyển phòng ban của một nhân viên cụ thể
    @GetMapping("/employee/{employeeId}")
    public String showEmployeeTransferHistory(@PathVariable Long employeeId, Model model, RedirectAttributes redirectAttributes) {
        Optional<Employee> employeeOpt = employeeService.getEmployeeById(employeeId);
        if (!employeeOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy nhân viên với ID: " + employeeId);
            return "redirect:/admin/employee";
        }

        Employee employee = employeeOpt.get();
        List<DepartmentTransfer> transfers = departmentTransferService.getTransferHistoryByEmployee(employeeId);
        
        model.addAttribute("employee", employee);
        model.addAttribute("transfers", transfers);
        model.addAttribute("totalTransfers", transfers.size());
        
        return "admin/department-transfer/employee-history";
    }

    // Hiển thị chi tiết một lần chuyển phòng ban
    @GetMapping("/detail/{id}")
    public String showTransferDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<DepartmentTransfer> transferOpt = departmentTransferService.getDepartmentTransferById(id);
        if (!transferOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy lịch sử chuyển phòng ban với ID: " + id);
            return "redirect:/admin/department-transfer";
        }

        model.addAttribute("transfer", transferOpt.get());
        return "admin/department-transfer/detail";
    }
}