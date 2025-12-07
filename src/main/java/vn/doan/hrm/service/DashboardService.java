package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.RequestLeave;
import vn.doan.hrm.domain.User;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.HashMap;
import java.util.Map;

@Service
public class DashboardService {

    @Autowired
    private UserService userService;
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @Autowired
    private RequestLeaveService requestLeaveService;
    
    @Autowired
    private SalaryService salaryService;
    
    @Autowired
    private AttendanceService attendanceService;

    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        
        //  1. THỐNG KÊ CƠ BẢN
        stats.put("totalUsers", userService.countUsers());
        stats.put("totalEmployees", employeeService.getAllEmployees().size());
        stats.put("totalDepartments", departmentService.getAllDepartments().size());
          //  2. THỐNG KÊ THEO VAI TRÒ
        stats.put("adminUsers", userService.countUsersByRole(User.Role.admin));
        stats.put("hrUsers", userService.countUsersByRole(User.Role.hr));
        stats.put("managerUsers", userService.countUsersByRole(User.Role.manager));
        stats.put("employeeUsers", userService.countUsersByRole(User.Role.employee));
        
        //  3. THỐNG KÊ ĐơN NGHỈ PHÉP
        var allLeaveRequests = requestLeaveService.getAllRequestLeaves();
        stats.put("totalLeaveRequests", allLeaveRequests.size());
        
        long pendingLeaves = allLeaveRequests.stream()
            .filter(r -> r.getStatus() == RequestLeave.Status.pending)
            .count();
        stats.put("pendingLeaveRequests", pendingLeaves);
        
        long approvedLeaves = allLeaveRequests.stream()
            .filter(r -> r.getStatus() == RequestLeave.Status.approved)
            .count();
        stats.put("approvedLeaveRequests", approvedLeaves);
        
        //  4. THỐNG KÊ THÁNG HIỆN TẠI
        LocalDate now = LocalDate.now();
        String currentMonth = now.getYear() + "-" + String.format("%02d", now.getMonthValue());
        
        var currentMonthSalaries = salaryService.getSalariesByMonth(currentMonth);
        stats.put("currentMonthSalaries", currentMonthSalaries.size());
        
        // Tính tổng lương tháng này
        BigDecimal totalSalaryAmount = currentMonthSalaries.stream()
            .map(s -> s.getNetSalary() != null ? s.getNetSalary() : BigDecimal.ZERO)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.put("totalSalaryAmount", totalSalaryAmount);
        
        //  5. THỐNG KÊ CHẤM CÔNG HÔM NAY
        var todayAttendances = attendanceService.getAttendanceByDate(now);
        stats.put("todayAttendances", todayAttendances.size());
        
        long todayPresent = todayAttendances.stream()
            .filter(a -> "present".equals(a.getStatus().toString().toLowerCase()))
            .count();
        stats.put("todayPresent", todayPresent);
        
        long todayLate = todayAttendances.stream()
            .filter(a -> "late".equals(a.getStatus().toString().toLowerCase()))
            .count();
        stats.put("todayLate", todayLate);
        
        long todayAbsent = todayAttendances.stream()
            .filter(a -> "absent".equals(a.getStatus().toString().toLowerCase()))
            .count();
        stats.put("todayAbsent", todayAbsent);
        
        //  6. THỐNG KÊ TREND (SO VỚI THÁNG TRƯỚC)
        YearMonth currentYearMonth = YearMonth.now();
        YearMonth lastYearMonth = currentYearMonth.minusMonths(1);
        String lastMonth = lastYearMonth.getYear() + "-" + String.format("%02d", lastYearMonth.getMonthValue());
        
        var lastMonthSalaries = salaryService.getSalariesByMonth(lastMonth);
        int salaryTrend = currentMonthSalaries.size() - lastMonthSalaries.size();
        stats.put("salaryTrend", salaryTrend);
        
        return stats;
    }
    
    //  Lấy thống kê theo tháng cụ thể
    public Map<String, Object> getMonthlyStats(int year, int month) {
        Map<String, Object> stats = new HashMap<>();
        String monthStr = year + "-" + String.format("%02d", month);
        
        var monthSalaries = salaryService.getSalariesByMonth(monthStr);
        stats.put("monthlySalariesCount", monthSalaries.size());
        
        BigDecimal monthlyTotal = monthSalaries.stream()
            .map(s -> s.getNetSalary() != null ? s.getNetSalary() : BigDecimal.ZERO)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        stats.put("monthlyTotalAmount", monthlyTotal);
        
        return stats;
    }
    
    //  Lấy top departments theo số nhân viên
    public Map<String, Long> getDepartmentStats() {
        Map<String, Long> deptStats = new HashMap<>();
        
        departmentService.getAllDepartments().forEach(dept -> {
            long employeeCount = employeeService.getAllEmployees().stream()
                .filter(emp -> emp.getDepartment() != null && 
                              emp.getDepartment().getId().equals(dept.getId()))
                .count();
            deptStats.put(dept.getName(), employeeCount);
        });
        
        return deptStats;
    }
}