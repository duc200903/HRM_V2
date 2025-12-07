package vn.doan.hrm.controller.hr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.doan.hrm.domain.Salary;
import vn.doan.hrm.service.SalaryService;

import java.beans.PropertyEditorSupport;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin/salary-report")
public class SalaryController {

    @Autowired
    private SalaryService salaryService;

    @GetMapping
    public String showSalaries(
            @RequestParam(value = "month", required = false) String monthParam,
            Model model) {

        // Nếu không truyền ?month=..., thì mặc định lấy tháng hiện tại
        String selectedMonth;
        if (monthParam != null && !monthParam.isEmpty()) {
            selectedMonth = monthParam;
        } else {
            LocalDate now = LocalDate.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
            selectedMonth = now.format(formatter);
        }

        // Lấy danh sách lương theo tháng
        List<Salary> salaries = salaryService.getSalariesByMonth(selectedMonth);

        // Tính tổng
        int totalSalaries = salaries.size();
        BigDecimal totalBonus = BigDecimal.ZERO;
        BigDecimal totalDeduction = BigDecimal.ZERO;
        BigDecimal totalNet = BigDecimal.ZERO;

        for (Salary s : salaries) {
            if (s.getBonus() != null) {
                totalBonus = totalBonus.add(s.getBonus());
            }
            if (s.getDeduction() != null) {
                totalDeduction = totalDeduction.add(s.getDeduction());
            }
            if (s.getNetSalary() != null) {
                totalNet = totalNet.add(s.getNetSalary());
            }
        }

        // Đưa dữ liệu ra view
        model.addAttribute("month", selectedMonth);
        model.addAttribute("salaries", salaries);
        model.addAttribute("totalSalaries", totalSalaries);
        model.addAttribute("totalBonus", totalBonus);
        model.addAttribute("totalDeduction", totalDeduction);
        model.addAttribute("totalNet", totalNet);

        return "admin/salary/show";
    }

    @GetMapping("/calculate")
    public String autoCalculate(@RequestParam String month, RedirectAttributes redirectAttributes) {
        try {
            salaryService.autoCalculateSalaries(month);
            redirectAttributes.addFlashAttribute("successMessage", " Đã tính lương tự động cho tháng " + month);
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "❌ " + e.getMessage());
        }
        return "redirect:/admin/salary-report?month=" + month;
    }

    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable Long id, Model model, RedirectAttributes ra) {
        return salaryService.getSalaryById(id)
                .map(sal -> {
                    model.addAttribute("salary", sal);
                    return "admin/salary/detail"; // trỏ tới JSP detail
                })
                .orElseGet(() -> {
                    ra.addFlashAttribute("errorMessage", "Không tìm thấy bản lương ID: " + id);
                    return "redirect:/admin/salary-report";
                });
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        Salary salary = salaryService.getSalaryById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy lương với id: " + id));
        model.addAttribute("salary", salary);
        return "admin/salary/update";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(BigDecimal.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text == null) {
                    setValue(null);
                    return;
                }
                // Bỏ hết ký tự không phải số (., khoảng trắng, ₫,...)
                String cleaned = text.replaceAll("[^0-9-]", "");
                if (cleaned.isEmpty() || cleaned.equals("-")) {
                    setValue(null);
                } else {
                    setValue(new BigDecimal(cleaned));
                }
            }

            @Override
            public String getAsText() {
                Object value = getValue();
                return (value == null) ? "" : value.toString();
            }
        });
    }

    @PostMapping("/update")
    public String updateSalary(@ModelAttribute("salary") Salary updatedSalary,
            RedirectAttributes redirectAttributes) {
        try {
            Salary existingSalary = salaryService.getSalaryById(updatedSalary.getId())
                    .orElseThrow(() -> new IllegalArgumentException(
                            "Không tìm thấy lương với ID: " + updatedSalary.getId()));

            existingSalary.setBonus(updatedSalary.getBonus());
            existingSalary.setDeduction(updatedSalary.getDeduction());
            existingSalary.setNetSalary(updatedSalary.getNetSalary());
            existingSalary.setNote(updatedSalary.getNote());

            salaryService.updateSalary(existingSalary);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Đã cập nhật lương cho nhân viên " + existingSalary.getEmployee().getFullName());

            //  dùng tháng từ existingSalary (chắc chắn có)
            return "redirect:/admin/salary-report?month=" + existingSalary.getMonth();

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi: " + e.getMessage());
            return "redirect:/admin/salary-report";
        }
    }

}
