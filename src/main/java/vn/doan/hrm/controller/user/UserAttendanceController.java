package vn.doan.hrm.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.doan.hrm.domain.Attendance;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.AttendanceService;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.UserService;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class UserAttendanceController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private AttendanceService attendanceService;

    @GetMapping("/my-attendance")
    public String myAttendancePage(Model model, Principal principal) {
        String email = principal.getName();
        User currentUser = userService.findByEmail(email);
        Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
          if (currentEmployee != null) {
            // Lấy lịch sử chấm công của nhân viên
            List<Attendance> attendances = attendanceService.getAttendanceByEmployee(currentEmployee.getId());
            
            // Kiểm tra đã chấm công hôm nay chưa
            LocalDate today = LocalDate.now();
            Attendance todayAttendance = attendances.stream()
                .filter(a -> a.getDate().equals(today))
                .findFirst()
                .orElse(null);
              // Format dates for JSP display
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            
            // Create formatted attendance list
            java.util.Map<String, Object> formattedAttendances = new java.util.HashMap<>();
            attendances.forEach(att -> {
                formattedAttendances.put("date_" + att.getId(), att.getDate().format(dateFormatter));
            });
            
            model.addAttribute("attendances", attendances);
            model.addAttribute("todayAttendance", todayAttendance);
            model.addAttribute("formattedDates", formattedAttendances);
        }
        
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("currentEmployee", currentEmployee);
        model.addAttribute("currentTime", LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")));
        model.addAttribute("currentDate", LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
        
        return "user/my-attendance";
    }

    @PostMapping("/my-attendance/check-in")
    public String checkIn(Principal principal, RedirectAttributes redirectAttributes) {
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên!");
                return "redirect:/my-attendance";
            }
            
            LocalDate today = LocalDate.now();
            LocalTime now = LocalTime.now();
            
            // Kiểm tra đã check-in hôm nay chưa
            List<Attendance> todayAttendances = attendanceService.getAttendanceByEmployee(currentEmployee.getId())
                .stream()
                .filter(a -> a.getDate().equals(today))
                .toList();
              if (!todayAttendances.isEmpty() && todayAttendances.get(0).getCheckIn() != null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn đã chấm công vào hôm nay rồi!");
                return "redirect:/my-attendance";
            }
            
            // Tạo hoặc cập nhật attendance record
            Attendance attendance;
            if (todayAttendances.isEmpty()) {
                attendance = new Attendance();
                attendance.setEmployee(currentEmployee);
                attendance.setDate(today);
            } else {
                attendance = todayAttendances.get(0);
            }
            
            attendance.setCheckIn(now);
            
            // Xác định status dựa trên giờ vào (8:00 AM là giờ chuẩn)
            LocalTime standardTime = LocalTime.of(8, 0); // 8:00 AM
            if (now.isAfter(standardTime.plusMinutes(15))) { // Trễ hơn 15 phút
                attendance.setStatus(Attendance.Status.late);
            } else {
                attendance.setStatus(Attendance.Status.present);
            }
            
            attendanceService.saveAttendance(attendance);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Chấm công vào thành công lúc " + now.format(DateTimeFormatter.ofPattern("HH:mm:ss")));
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        return "redirect:/my-attendance";
    }

    @PostMapping("/my-attendance/check-out")
    public String checkOut(Principal principal, RedirectAttributes redirectAttributes) {
        try {
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);
            
            if (currentEmployee == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy thông tin nhân viên!");
                return "redirect:/my-attendance";
            }
            
            LocalDate today = LocalDate.now();
            LocalTime now = LocalTime.now();
            
            // Tìm attendance record hôm nay
            List<Attendance> todayAttendances = attendanceService.getAttendanceByEmployee(currentEmployee.getId())
                .stream()
                .filter(a -> a.getDate().equals(today))
                .toList();
              if (todayAttendances.isEmpty() || todayAttendances.get(0).getCheckIn() == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn chưa chấm công vào hôm nay!");
                return "redirect:/my-attendance";
            }
            
            Attendance attendance = todayAttendances.get(0);
              if (attendance.getCheckOut() != null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn đã chấm công ra hôm nay rồi!");
                return "redirect:/my-attendance";
            }
            
            attendance.setCheckOut(now);
            attendanceService.saveAttendance(attendance);
            
            redirectAttributes.addFlashAttribute("successMessage", 
                "Chấm công ra thành công lúc " + now.format(DateTimeFormatter.ofPattern("HH:mm:ss")));
                
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }
        
        return "redirect:/my-attendance";
    }
}