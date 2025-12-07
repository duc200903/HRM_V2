package vn.doan.hrm.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.RequestLeave;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.RequestLeaveService;

@Controller
@RequestMapping("/admin/request-leave")
public class RequestLeaveController {
      @Autowired
    private RequestLeaveService requestLeaveService;
    
    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    public String showRequestLeavePage(Model model,
                                      @RequestParam(required = false) Integer year,
                                      @RequestParam(required = false) Integer month,
                                      @RequestParam(required = false) String status) {
        
        // Get filtered data
        List<RequestLeave> requestLeaves;
        if (year != null || month != null || (status != null && !status.isEmpty())) {
            requestLeaves = requestLeaveService.getRequestLeavesWithFilters(year, month, status);
        } else {
            requestLeaves = requestLeaveService.getAllRequestLeaves();
        }
        
        // Add data to model
        model.addAttribute("requestLeaves", requestLeaves);
        model.addAttribute("totalRequestLeaves", requestLeaves.size());
        
        // Add filter options
        model.addAttribute("availableYears", requestLeaveService.getAvailableYears());
        model.addAttribute("currentYear", year);
        model.addAttribute("currentMonth", month);
        model.addAttribute("currentStatus", status);
        
        return "admin/request-leave/show";
    }

    @PostMapping("/approve/{id}")
    @ResponseBody
    public ResponseEntity<String> approveRequest(@PathVariable Long id) {
        try {
            requestLeaveService.approveRequest(id);
            return ResponseEntity.ok(" Đã duyệt đơn nghỉ phép");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }

    @PostMapping("/reject/{id}")
    @ResponseBody
    public ResponseEntity<String> rejectRequest(@PathVariable Long id) {
        try {
            requestLeaveService.rejectRequest(id);
            return ResponseEntity.ok("❌ Đã từ chối đơn nghỉ phép");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Lỗi: " + e.getMessage());
        }
    }    @GetMapping("/detail/{id}")
    public String detailRequestLeave(@PathVariable Long id, Model model) {
        RequestLeave requestLeave = requestLeaveService.getRequestLeaveById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn nghỉ phép"));
        model.addAttribute("requestLeave", requestLeave);
        return "admin/request-leave/detail";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        RequestLeave requestLeave = requestLeaveService.getRequestLeaveById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn nghỉ phép"));
        model.addAttribute("requestLeave", requestLeave);
        return "admin/request-leave/update";
    }    @PostMapping("/update/{id}")
    public String updateRequestLeave(@PathVariable Long id,
                                   @RequestParam String status,
                                   @RequestParam(required = false) String note,
                                   RedirectAttributes redirectAttributes,
                                   Principal principal) {
        try {
            RequestLeave requestLeave = requestLeaveService.getRequestLeaveById(id)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn nghỉ phép"));
              // Lưu trạng thái cũ để so sánh
            RequestLeave.Status oldStatus = requestLeave.getStatus();
            RequestLeave.Status newStatus = RequestLeave.Status.valueOf(status);
            
            // Update status
            requestLeave.setStatus(newStatus);
            requestLeave.setNote(note);
            
            //  Tự động lấy email của người đang đăng nhập làm approvedBy
            if ("approved".equals(status) || "rejected".equals(status)) {
                String approverEmail = principal.getName(); // Email của người đăng nhập
                requestLeave.setApprovedBy(approverEmail);
                requestLeave.setApprovedAt(java.time.LocalDate.now());
            } else {
                // Nếu chuyển về pending thì xóa thông tin duyệt
                requestLeave.setApprovedBy(null);
                requestLeave.setApprovedAt(null);
            }
              //  Xử lý ngày phép còn lại khi thay đổi trạng thái
            Employee employee = requestLeave.getEmployee();
            int leaveDays = (int) java.time.temporal.ChronoUnit.DAYS.between(
                requestLeave.getStartDate(), requestLeave.getEndDate()) + 1;

            // Nếu từ trạng thái khác sang approved: trừ ngày phép
            if (oldStatus != RequestLeave.Status.approved && newStatus == RequestLeave.Status.approved) {
                int currentRemaining = employee.getRemainingLeaveDays() != null ? employee.getRemainingLeaveDays() : 12;
                int newRemaining = Math.max(0, currentRemaining - leaveDays);
                employee.setRemainingLeaveDays(newRemaining);
                employeeService.saveEmployee(employee); // Save employee
                
                redirectAttributes.addFlashAttribute("message", 
                    " Duyệt đơn thành công! Đã trừ " + leaveDays + " ngày phép. Còn lại: " + newRemaining + " ngày.");
            }
            // Nếu từ approved sang trạng thái khác: hoàn lại ngày phép
            else if (oldStatus == RequestLeave.Status.approved && newStatus != RequestLeave.Status.approved) {
                int currentRemaining = employee.getRemainingLeaveDays() != null ? employee.getRemainingLeaveDays() : 0;
                int newRemaining = currentRemaining + leaveDays;
                employee.setRemainingLeaveDays(newRemaining);
                employeeService.saveEmployee(employee); // Save employee
                
                String statusText = "rejected".equals(status) ? "từ chối" : "chuyển về chờ duyệt";
                redirectAttributes.addFlashAttribute("message", 
                    "Đã " + statusText + "! Hoàn lại " + leaveDays + " ngày phép. Tổng cộng: " + newRemaining + " ngày.");
            }
            else {
                String message = "approved".equals(status) ? " Đã duyệt đơn nghỉ phép" : 
                               "rejected".equals(status) ? "❌ Đã từ chối đơn nghỉ phép" : 
                               "⏰ Đã chuyển về trạng thái chờ duyệt";
                redirectAttributes.addFlashAttribute("message", message);
            }
            
            requestLeaveService.saveRequestLeave(requestLeave);
            
            String message = "approved".equals(status) ? " Đã duyệt đơn nghỉ phép" : 
                           "rejected".equals(status) ? "❌ Đã từ chối đơn nghỉ phép" : 
                           "⏰ Đã chuyển về trạng thái chờ duyệt";
            redirectAttributes.addFlashAttribute("message", message);
            redirectAttributes.addFlashAttribute("messageType", "success");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Có lỗi xảy ra: " + e.getMessage());
            redirectAttributes.addFlashAttribute("messageType", "error");
        }
        
        return "redirect:/admin/request-leave";
    }
}
