package vn.doan.hrm.controller.hr;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.doan.hrm.domain.Recruitment;
import vn.doan.hrm.service.DepartmentService;
import vn.doan.hrm.service.RecruitmentService;

@Controller
@RequestMapping("/admin/recruitment")
public class RecruitmentController {

    private final DepartmentService departmentService;
    @Autowired
    private RecruitmentService recruitmentService;

    RecruitmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    @GetMapping
    public String showRecruitments(Model model) {
        var recruitments = recruitmentService.getAllRecruitments();
        model.addAttribute("recruitments", recruitments);
        model.addAttribute("totalRecruitments", recruitments.size());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        recruitments.forEach(r -> {
            if (r.getCreatedAt() != null) {
                r.setFormattedCreatedAt(r.getCreatedAt().format(formatter));
            }
        });
        return "admin/recruitment/show";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("recruitment", new Recruitment());
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "admin/recruitment/create";
    }

    // POST /admin/recruitment/create
    @PostMapping("/create")
    public String createRecruitment(@ModelAttribute("recruitment") Recruitment recruitment,
            RedirectAttributes redirectAttributes) {
        try {
            recruitment.setCreatedAt(LocalDateTime.now());
            recruitmentService.saveRecruitment(recruitment);
            redirectAttributes.addFlashAttribute("successMessage", "Đã tạo tin tuyển dụng thành công!");
            return "redirect:/admin/recruitment";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo tin tuyển dụng: " + e.getMessage());
            return "redirect:/admin/recruitment/create";
        }
    }

    @GetMapping("/detail/{id}")
    public String showRecruitmentDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Recruitment recruitment = recruitmentService.getRecruitmentById(id).orElse(null);
        if (recruitment == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy tin tuyển dụng!");
            return "redirect:/admin/recruitment";
        }

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        // Format appliedAt cho từng applicant
        recruitment.getApplicants().forEach(app -> {
            if (app.getAppliedAt() != null)
                app.setFormattedAppliedAt(app.getAppliedAt().format(dateFormatter));
        });

        model.addAttribute("recruitment", recruitment);
        return "admin/recruitment/detail";
    }

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text != null && !text.isEmpty()) {
                    setValue(LocalDate.parse(text));
                } else {
                    setValue(null);
                }
            }

            @Override
            public String getAsText() {
                LocalDate date = (LocalDate) getValue();
                return (date != null) ? date.toString() : "";
            }
        });
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Recruitment recruitment = recruitmentService.getRecruitmentById(id).orElse(null);
        if (recruitment == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy tin tuyển dụng!");
            return "redirect:/admin/recruitment";
        }
        System.out.println("StartDate: " + recruitment.getStartDate()); // cần là: 2025-10-01
        System.out.println("EndDate: " + recruitment.getEndDate());
        model.addAttribute("recruitment", recruitment);
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "admin/recruitment/update";
    }

    @PostMapping("/update")
    public String updateRecruitment(@ModelAttribute("recruitment") Recruitment recruitment,
            RedirectAttributes redirectAttributes) {
        try {
            Recruitment existing = recruitmentService.getRecruitmentById(recruitment.getId())
                    .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy tin tuyển dụng!"));

            // Cập nhật các trường được phép
            existing.setTitle(recruitment.getTitle());
            existing.setDepartment(recruitment.getDepartment());
            existing.setDescription(recruitment.getDescription());
            existing.setStatus(recruitment.getStatus());
            existing.setStartDate(recruitment.getStartDate());
            existing.setEndDate(recruitment.getEndDate());

            recruitmentService.saveRecruitment(existing);

            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thành công!");
            return "redirect:/admin/recruitment";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật: " + e.getMessage());
            return "redirect:/admin/recruitment/update/" + recruitment.getId();
        }
    }

    @GetMapping("/delete/{id}")
    public String showDeleteConfirmation(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Recruitment recruitment = recruitmentService.getRecruitmentById(id).orElse(null);
        if (recruitment == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy tin tuyển dụng!");
            return "redirect:/admin/recruitment";
        }
        model.addAttribute("recruitment", recruitment);
        return "admin/recruitment/delete"; // đường dẫn JSP
    }

    @PostMapping("/delete/{id}")
    public String deleteRecruitment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            recruitmentService.deleteRecruitment(id);
            redirectAttributes.addFlashAttribute("successMessage", "Đã xóa tin tuyển dụng thành công.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa tin tuyển dụng: " + e.getMessage());
        }
        return "redirect:/admin/recruitment";
    }
}
