package vn.doan.hrm.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.doan.hrm.service.DashboardService;

import java.util.Map;


@Controller
public class DashboardController {    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/admin/dashboard")
    public String getAdminDashboard(Model model) {
        // ✅ Lấy thống kê thực tế từ DashboardService
        Map<String, Object> stats = dashboardService.getDashboardStats();
        Map<String, Long> departmentStats = dashboardService.getDepartmentStats();
        
        // Thêm vào model để hiển thị
        model.addAttribute("stats", stats);
        model.addAttribute("departmentStats", departmentStats);

        return "admin/dashboard/show";
    }
    
}
