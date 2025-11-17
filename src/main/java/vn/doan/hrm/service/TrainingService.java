package vn.doan.hrm.service;

import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.Training;
import vn.doan.hrm.domain.EmployeeTraining;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.repository.TrainingRepository;
import vn.doan.hrm.repository.EmployeeTrainingRepository;

@Service
public class TrainingService {

    @Autowired
    private TrainingRepository trainingRepository;

    @Autowired
    private EmployeeTrainingRepository employeeTrainingRepository;

    public List<Training> getAllTrainings() {
        return trainingRepository.findAll();
    }

    public Optional<Training> getTrainingById(Long id) {
        return trainingRepository.findById(id);
    }

    public Training saveTraining(Training training) {
        return trainingRepository.save(training);
    }

    public void deleteTraining(Long id) {
        // Xóa tất cả EmployeeTraining liên quan trước
        List<EmployeeTraining> employeeTrainings = employeeTrainingRepository.findByTrainingId(id);
        for (EmployeeTraining et : employeeTrainings) {
            employeeTrainingRepository.delete(et);
        }

        // Sau đó xóa Training
        trainingRepository.deleteById(id);
    }

    public List<EmployeeTraining> getEmployeeTrainingsByTrainingId(Long trainingId) {
        return employeeTrainingRepository.findByTrainingId(trainingId);
    }

    public void addEmployeesToTraining(Long trainingId, List<Long> employeeIds) {
        Training training = trainingRepository.findById(trainingId).orElse(null);
        if (training == null)
            return;

        for (Long employeeId : employeeIds) {
            EmployeeTraining employeeTraining = new EmployeeTraining();

            // Tạo employee object với ID
            Employee employee = new Employee();
            employee.setId(employeeId);
            employeeTraining.setEmployee(employee);
            employeeTraining.setTraining(training);
            employeeTraining.setResult("Pending");

            // ✅ QUAN TRỌNG: Phải save vào database
            employeeTrainingRepository.save(employeeTraining);
        }
    }

    public void updateEmployeeTrainingResult(Long employeeTrainingId, String result) {
        EmployeeTraining employeeTraining = employeeTrainingRepository.findById(employeeTrainingId)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Không tìm thấy bản ghi đào tạo với ID: " + employeeTrainingId));

        employeeTraining.setResult(result);
        employeeTrainingRepository.save(employeeTraining);
    }
}
