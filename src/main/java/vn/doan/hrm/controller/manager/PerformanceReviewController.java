package vn.doan.hrm.controller.manager;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.doan.hrm.domain.PerformanceReview;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.PerformanceReviewService;
import vn.doan.hrm.service.UserService;

@Controller
@RequestMapping("/admin/performance-review")
public class PerformanceReviewController {

    private final UserService userService;

    private final EmployeeService employeeService;
    // Hiển thị trang quản lý performance-reviews

    @Autowired
    private PerformanceReviewService reviewService;

    PerformanceReviewController(EmployeeService employeeService, UserService userService) {
        this.employeeService = employeeService;
        this.userService = userService;
    }

    @GetMapping
    public String showReviews(Model model) {
        List<PerformanceReview> reviews = reviewService.getAllReviews();

        model.addAttribute("reviews", reviews);
        model.addAttribute("totalReviews", reviews.size());
        return "admin/performance-review/show";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        PerformanceReview review = new PerformanceReview();

        review.setReviewer(new User());

        model.addAttribute("review", review);
        model.addAttribute("employees", employeeService.getAllEmployees());
        return "admin/performance-review/create";
    }

    @PostMapping("/create")
    public String createReview(@ModelAttribute("review") PerformanceReview review,
            RedirectAttributes redirectAttributes,
            Principal principal) {
        try {
            review.setReviewedAt(LocalDateTime.now());

            //  Gán người đánh giá là người đang đăng nhập
            String email = principal.getName();
            review.setReviewer(userService.findByEmail(email));

            reviewService.saveReview(review);
            redirectAttributes.addFlashAttribute("successMessage", "Đã thêm đánh giá hiệu suất thành công!");
            return "redirect:/admin/performance-review";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi lưu đánh giá: " + e.getMessage());
            return "redirect:/admin/performance-review/create";
        }
    }

    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        PerformanceReview review = reviewService.getReviewById(id).orElse(null);

        if (review == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đánh giá hiệu suất!");
            return "redirect:/admin/performance-review";
        }

        //  Chỉ gọi format sau khi đảm bảo review != null
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        String formattedReviewedAt = review.getReviewedAt() != null
                ? review.getReviewedAt().format(formatter)
                : null;

        model.addAttribute("review", review);
        model.addAttribute("formattedReviewedAt", formattedReviewedAt);
        return "admin/performance-review/detail";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        PerformanceReview review = reviewService.getReviewById(id).orElse(null);
        if (review == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đánh giá hiệu suất!");
            return "redirect:/admin/performance-review";
        }
        model.addAttribute("review", review);
        model.addAttribute("employees", employeeService.getAllEmployees());
        model.addAttribute("reviewers", userService.getAllUsers());
        return "admin/performance-review/update";
    }

    @PostMapping("/update")
    public String updateReview(@ModelAttribute("review") PerformanceReview updatedReview,
            RedirectAttributes redirectAttributes) {
        try {
            //  Lấy review gốc từ DB
            PerformanceReview existingReview = reviewService.getReviewById(updatedReview.getId())
                    .orElseThrow(() -> new IllegalArgumentException(
                            "Không tìm thấy đánh giá với ID: " + updatedReview.getId()));

            //  Giữ nguyên các trường cũ
            existingReview.setEmployee(existingReview.getEmployee());
            existingReview.setPeriod(existingReview.getPeriod());

            //  Cập nhật các trường cho phép chỉnh sửa
            existingReview.setScore(updatedReview.getScore());
            existingReview.setComments(updatedReview.getComments());
            existingReview.setReviewer(updatedReview.getReviewer());
            existingReview.setReviewedAt(LocalDateTime.now());

            reviewService.saveReview(existingReview);

            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật đánh giá hiệu suất thành công!");
            return "redirect:/admin/performance-review/detail/" + existingReview.getId();

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật đánh giá: " + e.getMessage());
            return "redirect:/admin/performance-review/update/" + updatedReview.getId();
        }
    }

    @GetMapping("/delete/{id}")
    public String confirmDelete(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        PerformanceReview review = reviewService.getReviewById(id).orElse(null);
        if (review == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đánh giá hiệu suất!");
            return "redirect:/admin/performance-review";
        }
        model.addAttribute("review", review);
        return "admin/performance-review/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteReview(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            reviewService.deleteReview(id);
            redirectAttributes.addFlashAttribute("successMessage", "Đã xóa đánh giá hiệu suất thành công!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa đánh giá: " + e.getMessage());
        }
        return "redirect:/admin/performance-review";
    }
}
