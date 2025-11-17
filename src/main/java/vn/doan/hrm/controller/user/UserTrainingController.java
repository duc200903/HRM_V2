package vn.doan.hrm.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.EmployeeTraining;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.repository.EmployeeTrainingRepository;
import vn.doan.hrm.service.EmployeeService;
import vn.doan.hrm.service.UserService;

import java.security.Principal;
import java.util.List;

@Controller
public class UserTrainingController {

    @Autowired
    private UserService userService;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private EmployeeTrainingRepository employeeTrainingRepository;

    @GetMapping("/my-training")
    public String myTrainingPage(Model model, Principal principal) {
        try {
            // Lấy thông tin user hiện tại
            String email = principal.getName();
            User currentUser = userService.findByEmail(email);
            Employee currentEmployee = employeeService.getEmployeeByUser(currentUser);

            model.addAttribute("currentEmployee", currentEmployee);

            if (currentEmployee != null) {
                // Lấy danh sách đào tạo của nhân viên
                List<EmployeeTraining> employeeTrainings = employeeTrainingRepository
                    .findByEmployeeIdWithTraining(currentEmployee.getId());

                // Thống kê
                long totalTrainings = employeeTrainings.size();
                long completedTrainings = employeeTrainingRepository
                    .countByEmployeeIdAndResult(currentEmployee.getId(), "Completed");
                long pendingTrainings = employeeTrainingRepository
                    .countByEmployeeIdAndResult(currentEmployee.getId(), "Pending");
                long passedTrainings = employeeTrainingRepository
                    .countByEmployeeIdAndResult(currentEmployee.getId(), "Pass");

                model.addAttribute("employeeTrainings", employeeTrainings);
                model.addAttribute("totalTrainings", totalTrainings);
                model.addAttribute("completedTrainings", completedTrainings);
                model.addAttribute("pendingTrainings", pendingTrainings);
                model.addAttribute("passedTrainings", passedTrainings);
            }

            return "user/my-training";

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tải thông tin đào tạo: " + e.getMessage());
            return "user/my-training";
        }
    }
}
