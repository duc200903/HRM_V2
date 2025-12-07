package vn.doan.hrm.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.Salary;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.SalaryService;
import vn.doan.hrm.service.UserService;

import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class UserSalaryController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private SalaryService salaryService;    @GetMapping("/my-salary")
    public String mySalaryPage(Model model, Principal principal,
                              @RequestParam(required = false) Integer year,
                              @RequestParam(required = false) Integer month) {
        try {
            // Debug logging
            System.out.println("🔍 Filter params - Year: " + year + ", Month: " + month);
            
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);if (currentEmployee != null) {
                // Lấy danh sách lương của nhân viên
                List<Salary> salaries = salaryService.getSalariesByEmployee(currentEmployee.getId());
                
                // Đảm bảo salaries không null
                if (salaries == null) {
                    salaries = new java.util.ArrayList<>();
                }
                
                //  Apply filtering logic
                List<Salary> filteredSalaries = new java.util.ArrayList<>();
                LocalDate now = LocalDate.now();
                System.err.println(now);
                  for (Salary salary : salaries) {
                    if (salary != null && salary.getId() != null && salary.getMonth() != null) {
                        try {
                            // Parse actual month field từ DB (format: "YYYY-MM")
                            java.time.YearMonth salaryPeriod = java.time.YearMonth.parse(salary.getMonth());
                            
                            // Apply year filter
                            boolean matchesYear = (year == null) || (salaryPeriod.getYear() == year);
                            
                            // Apply month filter  
                            boolean matchesMonth = (month == null) || (salaryPeriod.getMonthValue() == month);
                            
                            // Add to filtered list if matches criteria
                            if (matchesYear && matchesMonth) {
                                filteredSalaries.add(salary);
                            }
                        } catch (Exception e) {
                            // Nếu parse lỗi thì bỏ qua filter, vẫn add vào list
                            if (year == null && month == null) {
                                filteredSalaries.add(salary);
                            }
                        }
                    }
                }
                
                // Use filtered salaries for display
                salaries = filteredSalaries;
                  // Format dates for JSP display - lấy từ field month trong DB
                java.util.Map<String, Object> formattedSalaries = new java.util.HashMap<>();
                for (Salary salary : salaries) {
                    if (salary != null && salary.getId() != null && salary.getMonth() != null) {
                        try {
                            // Parse month field (format: "YYYY-MM" -> "MM/YYYY")
                            String monthStr = salary.getMonth();
                            if (monthStr.length() >= 7) { // "2025-10"
                                java.time.YearMonth yearMonth = java.time.YearMonth.parse(monthStr);
                                String formattedPeriod = String.format("%02d/%d", 
                                    yearMonth.getMonthValue(), yearMonth.getYear());
                                formattedSalaries.put("period_" + salary.getId(), formattedPeriod);
                            } else {
                                // Fallback nếu format không đúng
                                formattedSalaries.put("period_" + salary.getId(), monthStr);
                            }
                        } catch (Exception e) {
                            // Fallback nếu parse lỗi
                            formattedSalaries.put("period_" + salary.getId(), salary.getMonth());
                        }
                    }
                }
                  // Thống kê đơn giản
                java.math.BigDecimal totalNetSalary = java.math.BigDecimal.ZERO;
                for (Salary salary : salaries) {
                    if (salary.getNetSalary() != null) {
                        totalNetSalary = totalNetSalary.add(salary.getNetSalary());
                    }
                }
                
                // Tính lương trung bình
                java.math.BigDecimal averageSalary = java.math.BigDecimal.ZERO;
                if (salaries.size() > 0) {
                    averageSalary = totalNetSalary.divide(
                        java.math.BigDecimal.valueOf(salaries.size()), 
                        0, 
                        java.math.RoundingMode.HALF_UP
                    );
                }
                
                model.addAttribute("salaries", salaries);
                model.addAttribute("formattedSalaries", formattedSalaries);
                model.addAttribute("totalNetSalary", totalNetSalary);
                model.addAttribute("averageSalary", averageSalary);
                model.addAttribute("salaryCount", salaries.size());
                
                // Filter parameters                model.addAttribute("selectedYear", year);
                model.addAttribute("selectedMonth", month);
                
                // Add filter status message
                if (year != null || month != null) {
                    StringBuilder filterMessage = new StringBuilder("Đã lọc: ");
                    if (year != null && month != null) {
                        filterMessage.append("Tháng ").append(month).append("/").append(year);
                    } else if (year != null) {
                        filterMessage.append("Năm ").append(year);
                    } else if (month != null) {
                        filterMessage.append("Tháng ").append(month);
                    }
                    filterMessage.append(" (").append(salaries.size()).append(" kết quả)");
                    model.addAttribute("successMessage", filterMessage.toString());
                }
            }
            
            model.addAttribute("currentUser", currentUser);
            model.addAttribute("currentEmployee", currentEmployee);
            model.addAttribute("currentDate", LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
            
            return "user/my-salary";
            
        } catch (Exception e) {
            System.err.println("Error in my-salary page: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/home";
        }
    }
}