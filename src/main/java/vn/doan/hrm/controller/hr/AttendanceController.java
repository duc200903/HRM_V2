package vn.doan.hrm.controller.hr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.doan.hrm.domain.Attendance;
import vn.doan.hrm.service.AttendanceService;
import vn.doan.hrm.service.EmployeeService;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/admin/attendance")
public class AttendanceController {

    @Autowired
    private AttendanceService attendanceService;

    @Autowired
    private EmployeeService employeeService;

    // Hiển thị danh sách chấm công
    @GetMapping
    public String showAttendance(Model model,
            @RequestParam(defaultValue = "today") String filter) {
        LocalDate date;
        if ("today".equals(filter)) {
            // Mặc định load sample date từ data.sql (2025-09-01) thay vì hôm nay
            date = LocalDate.of(2025, 9, 1);
        } else {
            date = LocalDate.parse(filter);
        }

        List<Attendance> attendances = attendanceService.getAttendanceByDate(date); // Lấy danh sách chấm công theo ngày
        long totalEmployees = employeeService.getAllEmployees().size(); // Tổng số nhân viên

        // Basic statistics
        long presentCount = attendances.size(); // số người đã chấm công
        long lateCount = attendances.stream()
                .mapToLong(a -> "late".equals(a.getStatus().name()) ? 1 : 0)
                .sum(); // số người đi trễ
        long absentCount = totalEmployees - presentCount; // số người vắng mặt

        model.addAttribute("attendances", attendances);
        model.addAttribute("selectedDate", date);
        model.addAttribute("selectedDateFormatted", date.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")));
        model.addAttribute("totalEmployees", totalEmployees);
        model.addAttribute("presentCount", presentCount);
        model.addAttribute("lateCount", lateCount);
        model.addAttribute("absentCount", absentCount);

        return "admin/attendance/show";
    }

    // Hiển thị chi tiết attendance
    @GetMapping("/detail/{id}")
    public String showAttendanceDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Attendance> attendanceOpt = attendanceService.getAttendanceById(id);
        if (!attendanceOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy bản ghi chấm công với ID: " + id);
            return "redirect:/admin/attendance";
        }

        Attendance attendance = attendanceOpt.get();

        model.addAttribute("attendance", attendance);
        model.addAttribute("id", id);

        return "admin/attendance/detail";
    }
}
