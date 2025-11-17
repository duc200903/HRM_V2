package vn.doan.hrm.controller.hr;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.WebDataBinder;
// import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
// import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.beans.PropertyEditorSupport;
import vn.doan.hrm.domain.Training;
import vn.doan.hrm.domain.EmployeeTraining;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.service.TrainingService;
import vn.doan.hrm.service.EmployeeService;
import jakarta.validation.Valid;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/admin/training")
public class TrainingController {
    @Autowired
    private TrainingService trainingService;
    @Autowired
    private EmployeeService employeeService;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) {
                if (text != null && !text.trim().isEmpty()) {
                    setValue(LocalDate.parse(text, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
                } else {
                    setValue(null);
                }
            }

            @Override
            public String getAsText() {
                LocalDate value = (LocalDate) getValue();
                return (value != null) ? value.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
            }
        });
    }

    @GetMapping
    public String showTrainingPage(Model model) {
        List<Training> trainings = trainingService.getAllTrainings();
        model.addAttribute("trainings", trainings);
        model.addAttribute("totalTrainings", trainings.size());
        return "admin/training/show";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        Training training = new Training();
        List<Employee> employees = employeeService.getAllEmployees();

        model.addAttribute("training", training);
        model.addAttribute("employees", employees);
        return "admin/training/create";
    }

    @PostMapping("/create")
    public String createTraining(@Valid @ModelAttribute("training") Training training,
            BindingResult result,
            @RequestParam(value = "selectedEmployees", required = false) List<Long> selectedEmployees,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            List<Employee> employees = employeeService.getAllEmployees();
            model.addAttribute("employees", employees);
            return "admin/training/create";
        }
        try { // Debug: In ra để kiểm tra giá trị
            System.out.println("Training title: " + training.getTitle());
            System.out.println("Training startDate: " + training.getStartDate());
            System.out.println("Training endDate: " + training.getEndDate());
            System.out.println("Selected employees: " + selectedEmployees);

            // Lưu khóa đào tạo
            Training savedTraining = trainingService.saveTraining(training);

            // Thêm nhân viên vào khóa đào tạo nếu có chọn
            if (selectedEmployees != null && !selectedEmployees.isEmpty()) {
                System.out.println("Adding " + selectedEmployees.size() + " employees to training");
                trainingService.addEmployeesToTraining(savedTraining.getId(), selectedEmployees);
            } else {
                System.out.println("No employees selected");
            }

            redirectAttributes.addFlashAttribute("successMessage", "Thêm khóa đào tạo thành công!");
            return "redirect:/admin/training";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tạo khóa đào tạo: " + e.getMessage());
            return "redirect:/admin/training/create";
        }
    }

    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Training training = trainingService.getTrainingById(id).orElse(null);

        if (training == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy khóa đào tạo!");
            return "redirect:/admin/training";
        } // Lấy danh sách nhân viên tham gia khóa đào tạo
        List<EmployeeTraining> employeeTrainings = trainingService.getEmployeeTrainingsByTrainingId(id);
        model.addAttribute("training", training);
        model.addAttribute("employeeTrainings", employeeTrainings);
        model.addAttribute("totalParticipants", employeeTrainings.size());
        return "admin/training/detail";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Training training = trainingService.getTrainingById(id).orElse(null);

        if (training == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy khóa đào tạo!");
            return "redirect:/admin/training";
        }

        // Lấy danh sách nhân viên tham gia khóa đào tạo
        List<EmployeeTraining> employeeTrainings = trainingService.getEmployeeTrainingsByTrainingId(id);

        model.addAttribute("training", training);
        model.addAttribute("employeeTrainings", employeeTrainings);
        return "admin/training/update";
    }

    @PostMapping("/update")
    public String updateTraining(@Valid @ModelAttribute("training") Training updatedTraining,
            BindingResult result,
            @RequestParam Map<String, String> allParams,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (result.hasErrors()) {
            // Lấy lại danh sách nhân viên tham gia cho trường hợp có lỗi
            List<EmployeeTraining> employeeTrainings = trainingService
                    .getEmployeeTrainingsByTrainingId(updatedTraining.getId());
            model.addAttribute("employeeTrainings", employeeTrainings);
            return "admin/training/update";
        }
        try {
            // Cập nhật thông tin khóa đào tạo
            trainingService.saveTraining(updatedTraining);

            // Cập nhật kết quả đào tạo của nhân viên
            for (Map.Entry<String, String> entry : allParams.entrySet()) {
                if (entry.getKey().startsWith("employeeTrainingResults[")) {
                    // Extract employeeTrainingId from parameter name: employeeTrainingResults[123]
                    String paramName = entry.getKey();
                    String idStr = paramName.substring(paramName.indexOf("[") + 1, paramName.indexOf("]"));
                    Long employeeTrainingId = Long.valueOf(idStr);
                    String newResult = entry.getValue();

                    trainingService.updateEmployeeTrainingResult(employeeTrainingId, newResult);
                }
            }

            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khóa đào tạo và kết quả thành công!");
            return "redirect:/admin/training/detail/" + updatedTraining.getId();

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi cập nhật khóa đào tạo: " + e.getMessage());
            return "redirect:/admin/training/update/" + updatedTraining.getId();
        }
    }

    @PostMapping("/update-result")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateTrainingResult(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            Long employeeTrainingId = Long.valueOf(request.get("employeeTrainingId").toString());
            String result = request.get("result").toString();

            trainingService.updateEmployeeTrainingResult(employeeTrainingId, result);

            response.put("success", true);
            response.put("message", "Cập nhật kết quả thành công!");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Lỗi: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Training training = trainingService.getTrainingById(id).orElse(null);

        if (training == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy khóa đào tạo!");
            return "redirect:/admin/training";
        }

        // Lấy danh sách nhân viên tham gia để hiển thị thông tin
        List<EmployeeTraining> employeeTrainings = trainingService.getEmployeeTrainingsByTrainingId(id);

        model.addAttribute("training", training);
        model.addAttribute("employeeTrainings", employeeTrainings);
        return "admin/training/delete";
    }

    @PostMapping("/delete/{id}")
    public String deleteTraining(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Training training = trainingService.getTrainingById(id).orElse(null);

            if (training == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy khóa đào tạo!");
                return "redirect:/admin/training";
            }

            // Xóa khóa đào tạo (cascade sẽ tự động xóa các EmployeeTraining liên quan)
            trainingService.deleteTraining(id);

            redirectAttributes.addFlashAttribute("successMessage", "Xóa khóa đào tạo thành công!");
            return "redirect:/admin/training";

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi xóa khóa đào tạo: " + e.getMessage());
            return "redirect:/admin/training";
        }
    }
}
