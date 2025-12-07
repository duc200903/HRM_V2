package vn.doan.hrm.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.UserService;
import vn.doan.hrm.service.AttendanceService;
import vn.doan.hrm.service.SalaryService;
import vn.doan.hrm.service.RequestLeaveService;
// import vn.doan.hrm.service.TrainingService;
// import vn.doan.hrm.service.PerformanceReviewService;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserHomeController {    
    @Autowired
    private UserService userService;
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private AttendanceService attendanceService;
    
    @Autowired
    private SalaryService salaryService;
    
    @Autowired
    private RequestLeaveService requestLeaveService;
    
    // @Autowired
    // private TrainingService trainingService;
    
    // @Autowired
    // private PerformanceReviewService performanceReviewService;    
    @GetMapping({"/home", "/me"})
    public String homePage(Model model, Principal principal) {
        String email = principal.getName();
        User currentUser = userService.findByEmail(email);
        
        // Lấy thông tin Employee từ User
        Employee currentEmployee = null;
        if (currentUser != null) {
            currentEmployee = employeeService.getEmployeeByUser(currentUser);
        }
        
        if (currentEmployee != null) {
            //  Lấy thống kê cá nhân
            Map<String, Object> personalStats = getPersonalStats(currentEmployee);
            model.addAttribute("personalStats", personalStats);
              //  Lấy dữ liệu chi tiết cho dashboard  
            try {
                var recentAttendances = attendanceService.getAttendanceByEmployee(currentEmployee.getId());
                var currentMonthSalary = salaryService.getCurrentMonthSalaryByEmployee(currentEmployee.getId());
                var recentLeaveRequests = requestLeaveService.getRequestLeavesByEmployee(currentEmployee.getId());
                
                model.addAttribute("recentAttendances", recentAttendances);
                model.addAttribute("currentMonthSalary", currentMonthSalary);
                model.addAttribute("recentLeaveRequests", recentLeaveRequests);
            } catch (Exception e) {
                // Nếu có lỗi, set empty lists
                model.addAttribute("recentAttendances", java.util.Collections.emptyList());
                model.addAttribute("currentMonthSalary", null);
                model.addAttribute("recentLeaveRequests", java.util.Collections.emptyList());
            }
        }
        
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("currentEmployee", currentEmployee);
        
        return "user/home";
    }
    
    //  Helper method để tính thống kê cá nhân
    private Map<String, Object> getPersonalStats(Employee employee) {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            // Đơn nghỉ phép
            var allLeaveRequests = requestLeaveService.getRequestLeavesByEmployee(employee.getId());
            stats.put("totalLeaveRequests", allLeaveRequests.size());
            
            long pendingLeaves = allLeaveRequests.stream()
                .filter(r -> "pending".equalsIgnoreCase(r.getStatus().toString()))
                .count();
            stats.put("pendingLeaves", pendingLeaves);
              // Chấm công tháng này
            var attendances = attendanceService.getCurrentMonthAttendancesByEmployee(employee.getId());
            stats.put("thisMonthAttendances", attendances.size());
            
            // Lương tháng hiện tại
            var currentSalary = salaryService.getCurrentMonthSalaryByEmployee(employee.getId());
            stats.put("hasCurrentSalary", currentSalary != null);
            if (currentSalary != null) {
                stats.put("currentSalaryAmount", currentSalary.getNetSalary());
            }
            
        } catch (Exception e) {
            // Set default values nếu có lỗi
            stats.put("totalLeaveRequests", 0);
            stats.put("pendingLeaves", 0);
            stats.put("thisMonthAttendances", 0);
            stats.put("hasCurrentSalary", false);
        }
        
        return stats;
    }
}