package vn.doan.hrm.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.RequestLeave;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.RequestLeaveService;
import vn.doan.hrm.service.UserService;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class UserLeaveController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private RequestLeaveService requestLeaveService;

    @GetMapping("/my-leave")
    public String myLeavePage(Model model, Principal principal) {
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee != null) {
                // Lấy danh sách đơn nghỉ phép của nhân viên
                List<RequestLeave> leaveRequests = requestLeaveService.getRequestLeavesByEmployee(currentEmployee.getId());
                
                // Format dates for JSP display
                DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");                // Create formatted leave request dates and calculate days
                java.util.Map<String, Object> formattedDates = new java.util.HashMap<>();
                java.util.Map<String, Object> leaveDays = new java.util.HashMap<>();
                leaveRequests.forEach(leave -> {
                    formattedDates.put("start_" + leave.getId(), leave.getStartDate().format(dateFormatter));
                    formattedDates.put("end_" + leave.getId(), leave.getEndDate().format(dateFormatter));
                    
                    // Calculate number of days
                    long days = java.time.temporal.ChronoUnit.DAYS.between(leave.getStartDate(), leave.getEndDate()) + 1;
                    leaveDays.put("days_" + leave.getId(), days);
                });
                
                // Thống kê nghỉ phép
                long pendingCount = leaveRequests.stream()
                    .filter(r -> "pending".equalsIgnoreCase(r.getStatus().toString()))
                    .count();
                long approvedCount = leaveRequests.stream()
                    .filter(r -> "approved".equalsIgnoreCase(r.getStatus().toString()))
                    .count();
                long rejectedCount = leaveRequests.stream()
                    .filter(r -> "rejected".equalsIgnoreCase(r.getStatus().toString()))
                    .count();
                  model.addAttribute("leaveRequests", leaveRequests);
                model.addAttribute("formattedDates", formattedDates);
                model.addAttribute("leaveDays", leaveDays);
                model.addAttribute("pendingCount", pendingCount);
                model.addAttribute("approvedCount", approvedCount);
                model.addAttribute("rejectedCount", rejectedCount);
                model.addAttribute("totalCount", leaveRequests.size());
            }
            
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("currentEmployee", currentEmployee);
            model.addAttribute("currentDate", LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            
            return "user/my-leave";
            
        } catch (Exception e) {
            System.err.println("Error in my-leave page: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/home";
        }
    }

    @PostMapping("/my-leave/create")
    public String createLeaveRequest(
            @RequestParam("startDate") String startDateStr,
            @RequestParam("endDate") String endDateStr,
            @RequestParam("reason") String reason,
            @RequestParam("leaveType") String leaveType,
            Principal principal,
            RedirectAttributes redirectAttributes) {
        
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên!");
                return "redirect:/my-leave";
            }
            
            // Parse dates
            LocalDate startDate = LocalDate.parse(startDateStr);
            LocalDate endDate = LocalDate.parse(endDateStr);
            
            // Validate dates
            if (startDate.isAfter(endDate)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Ngày bắt đầu không thể sau ngày kết thúc!");
                return "redirect:/my-leave";
            }
            
            if (startDate.isBefore(LocalDate.now())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể tạo đơn nghỉ phép cho ngày trong quá khứ!");
                return "redirect:/my-leave";
            }
              // Create leave request
            RequestLeave leaveRequest = new RequestLeave();
            leaveRequest.setEmployee(currentEmployee);
            leaveRequest.setStartDate(startDate);
            leaveRequest.setEndDate(endDate);
            leaveRequest.setReason(reason);
            leaveRequest.setStatus(RequestLeave.Status.pending);
            
            requestLeaveService.saveRequestLeave(leaveRequest);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Đơn nghỉ phép đã được tạo thành công! Đang chờ phê duyệt.");
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }        return "redirect:/my-leave";
    }

    @GetMapping("/my-leave-delete/{id}")
    public String showDeleteConfirmation(@PathVariable Long id, Model model, Principal principal, RedirectAttributes redirectAttributes) {
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên!");
                return "redirect:/my-leave";
            }
            
            // Lấy đơn nghỉ phép
            RequestLeave leaveRequest = requestLeaveService.getRequestLeaveById(id)
                .orElse(null);
                
            if (leaveRequest == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn nghỉ phép!");
                return "redirect:/my-leave";
            }
            
            // Kiểm tra xem đơn có thuộc về nhân viên hiện tại không
            if (!leaveRequest.getEmployee().getId().equals(currentEmployee.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền hủy đơn này!");
                return "redirect:/my-leave";
            }
            
            // Chỉ cho phép hủy đơn đang chờ duyệt
            if (!leaveRequest.getStatus().equals(RequestLeave.Status.pending)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Chỉ có thể hủy đơn đang chờ duyệt!");
                return "redirect:/my-leave";
            }
            
            // Format dates for display
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String formattedStartDate = leaveRequest.getStartDate().format(dateFormatter);
            String formattedEndDate = leaveRequest.getEndDate().format(dateFormatter);
            long daysDiff = java.time.temporal.ChronoUnit.DAYS.between(leaveRequest.getStartDate(), leaveRequest.getEndDate()) + 1;
            
            model.addAttribute("leaveRequest", leaveRequest);
            model.addAttribute("formattedStartDate", formattedStartDate);
            model.addAttribute("formattedEndDate", formattedEndDate);
            model.addAttribute("daysDiff", daysDiff);
            model.addAttribute("currentEmployee", currentEmployee);
            
            return "user/my-leave-delete";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/my-leave";
        }
    }

    @PostMapping("/my-leave/cancel/{id}")
    public String cancelLeaveRequest(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes) {
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên!");
                return "redirect:/my-leave";
            }
            
            // Lấy đơn nghỉ phép
            RequestLeave leaveRequest = requestLeaveService.getRequestLeaveById(id)
                .orElse(null);
                
            if (leaveRequest == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn nghỉ phép!");
                return "redirect:/my-leave";
            }
            
            // Kiểm tra xem đơn có thuộc về nhân viên hiện tại không
            if (!leaveRequest.getEmployee().getId().equals(currentEmployee.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền hủy đơn này!");
                return "redirect:/my-leave";
            }
            
            // Chỉ cho phép hủy đơn đang chờ duyệt
            if (!leaveRequest.getStatus().equals(RequestLeave.Status.pending)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Chỉ có thể hủy đơn đang chờ duyệt!");
                return "redirect:/my-leave";
            }
            
            // Kiểm tra xem đã đến ngày nghỉ chưa
            if (leaveRequest.getStartDate().isBefore(java.time.LocalDate.now()) || 
                leaveRequest.getStartDate().equals(java.time.LocalDate.now())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể hủy đơn đã đến ngày nghỉ!");
                return "redirect:/my-leave";
            }
            
            // Hủy đơn (xóa khỏi database)
            requestLeaveService.deleteRequestLeave(id);
            
            redirectAttributes.addFlashAttribute("successMessage", "Đơn nghỉ phép đã được hủy thành công!");
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        return "redirect:/my-leave";
    }
}