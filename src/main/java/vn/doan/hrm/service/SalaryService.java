package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.doan.hrm.domain.Attendance;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.Salary;
import vn.doan.hrm.repository.AttendanceRepository;
import vn.doan.hrm.repository.EmployeeRepository;
import vn.doan.hrm.repository.SalaryRepository;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class SalaryService {

    @Autowired
    private SalaryRepository salaryRepository;
    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private AttendanceRepository attendanceRepository;

    public void autoCalculateSalaries(String month) {
        List<Employee> employees = employeeRepository.findAll();
        LocalDate startDate = LocalDate.parse(month + "-01");
        LocalDate endDate = startDate.withDayOfMonth(startDate.lengthOfMonth());
        int totalWorkingDaysInMonth = endDate.getDayOfMonth();

        boolean hasAttendance = false;

        for (Employee emp : employees) {
            // Skip nếu đã có lương tháng này
            if (salaryRepository.existsByEmployeeIdAndMonth(emp.getId(), month)) {
                continue;
            }

            //  1. LẤY DỮ LIỆU CƠ BẢN TỪ EMPLOYEE
            BigDecimal baseSalary = Optional.ofNullable(emp.getBaseSalary()).orElse(BigDecimal.ZERO);
            BigDecimal allowanceMeal = Optional.ofNullable(emp.getAllowanceMeal()).orElse(BigDecimal.ZERO);
            BigDecimal allowanceTransport = Optional.ofNullable(emp.getAllowanceTransport()).orElse(BigDecimal.ZERO);
            BigDecimal allowanceSeniority = Optional.ofNullable(emp.getAllowanceSeniority()).orElse(BigDecimal.ZERO);
            BigDecimal insuranceHealth = Optional.ofNullable(emp.getInsuranceHealth()).orElse(BigDecimal.ZERO);
            BigDecimal insuranceSocial = Optional.ofNullable(emp.getInsuranceSocial()).orElse(BigDecimal.ZERO);

            //  2. TÍNH TOÁN CHẤM CÔNG
            List<Attendance> attendances = attendanceRepository.findByEmployeeIdAndDateBetween(emp.getId(), startDate,
                    endDate);

            if (attendances.isEmpty()) {
                continue; // Skip nhân viên không có chấm công
            }

            hasAttendance = true;
            AttendanceStats stats = calculateAttendanceStats(attendances, totalWorkingDaysInMonth);            //  3. TÍNH LƯƠNG THEO NGÀY LÀM VIỆC THỰC TẾ
            System.out.println("=== DEBUG CALCULATION FOR " + emp.getFullName() + " ===");
            System.out.println("Base Salary from Employee: " + baseSalary);
            System.out.println("Working days: " + stats.workingDays);
            
            BigDecimal actualBaseSalary = calculateProportionalSalary(baseSalary, stats.workingDays,
                    totalWorkingDaysInMonth);
            BigDecimal actualAllowanceMeal = calculateProportionalSalary(allowanceMeal, stats.workingDays,
                    totalWorkingDaysInMonth);
                    
            System.out.println("Calculated Base Salary: " + actualBaseSalary);

            // Phụ cấp xe và thâm niên: full tháng (không tính theo ngày)
            // Bảo hiểm: full tháng (không tính theo ngày)

            //  4. TÍNH THƯỞNG DỰA TRÊN PERFORMANCE
            BigDecimal bonus = calculateAdvancedBonus(emp, stats);

            //  5. TÍNH KHẤU TRỪ CHI TIẾT
            BigDecimal deduction = calculateAdvancedDeduction(stats);

            //  6. TẠO SALARY RECORD
            Salary salary = new Salary();
            salary.setEmployee(emp);
            salary.setMonth(month);
            salary.setBaseSalary(actualBaseSalary);
            salary.setAllowanceMeal(actualAllowanceMeal);
            salary.setAllowanceTransport(allowanceTransport); // Full tháng
            salary.setAllowanceSeniority(allowanceSeniority); // Full tháng
            salary.setInsuranceHealth(insuranceHealth);
            salary.setInsuranceSocial(insuranceSocial);
            salary.setWorkingDays(stats.workingDays);
            salary.setLateDays(stats.lateDays);
            salary.setAbsentDays(stats.absentDays);
            salary.setBonus(bonus);
            salary.setDeduction(deduction);
            // netSalary sẽ được tính tự động trong @PrePersist

            salaryRepository.save(salary);
        }

        if (!hasAttendance) {
            throw new RuntimeException("Không có dữ liệu chấm công nào trong tháng " + month);
        }
    }    //  Tính lương theo tỷ lệ ngày làm việc - Sửa lại để không về 0
    private BigDecimal calculateProportionalSalary(BigDecimal fullSalary, int actualDays, int totalDays) {
        if (fullSalary == null || fullSalary.equals(BigDecimal.ZERO)) {
            return BigDecimal.ZERO;
        }

        // Sử dụng 22 ngày làm việc chuẩn
        int standardWorkingDays = 22;
        
        // Nếu actualDays = 0 thì return 0
        if (actualDays <= 0) {
            return BigDecimal.ZERO;
        }
        
        // Nếu làm việc >= 22 ngày thì full lương
        if (actualDays >= standardWorkingDays) {
            return fullSalary;
        }
        
        // Tính theo tỷ lệ nhưng đảm bảo không về 0
        BigDecimal ratio = BigDecimal.valueOf(actualDays).divide(BigDecimal.valueOf(standardWorkingDays), 4, RoundingMode.HALF_UP);
        BigDecimal proportionalSalary = fullSalary.multiply(ratio);
        
        // Đảm bảo ít nhất có lương cơ bản tối thiểu nếu đã làm việc
        return proportionalSalary.setScale(0, RoundingMode.HALF_UP);
    }//  Tính thống kê chấm công
    private AttendanceStats calculateAttendanceStats(List<Attendance> attendances, int totalDaysInMonth) {
        AttendanceStats stats = new AttendanceStats();        // Đếm các loại attendance từ records thực tế        // Debug: In ra tất cả status để kiểm tra
        System.out.println("=== ATTENDANCE DEBUG ===");
        attendances.forEach(a -> System.out.println("Date: " + a.getDate() + ", Status: '" + a.getStatus() + "', Type: " + a.getStatus().getClass().getName()));
        
        stats.workingDays = (int) attendances.stream()
            .filter(a -> {
                if (a.getStatus() == null) return false;
                String status = a.getStatus().toString().toLowerCase();
                return "present".equals(status) || "late".equals(status);
            })
            .count();
            
        stats.lateDays = (int) attendances.stream()
            .filter(a -> {
                if (a.getStatus() == null) return false;
                return "late".equals(a.getStatus().toString().toLowerCase());
            })
            .count();
            
        // Chỉ đếm absent từ records, không tính theo tổng ngày tháng
        stats.absentDays = (int) attendances.stream()
            .filter(a -> {
                if (a.getStatus() == null) return false;
                return "absent".equals(a.getStatus().toString().toLowerCase());
            })
            .count();
            
        System.out.println("Final stats - Working: " + stats.workingDays + ", Late: " + stats.lateDays + ", Absent: " + stats.absentDays);return stats;
    }    //  Thưởng cải thiện - logic chuẩn HR hơn
    private BigDecimal calculateAdvancedBonus(Employee emp, AttendanceStats stats) {
        BigDecimal bonus = BigDecimal.ZERO;

        // 1. Thưởng chuyên cần (đi làm đủ, không trễ, không nghỉ)
        if (stats.absentDays == 0 && stats.lateDays == 0) {
            bonus = bonus.add(BigDecimal.valueOf(500_000)); // gộp lại cho gọn
        }

        // 2. Thưởng thâm niên (100K/năm, tối đa 800K)
        int yearsOfService = emp.getYearsOfService();
        if (yearsOfService >= 1) {
            BigDecimal seniorityBonus = BigDecimal.valueOf(yearsOfService * 100_000);
            if (seniorityBonus.compareTo(BigDecimal.valueOf(800_000)) > 0) {
                seniorityBonus = BigDecimal.valueOf(800_000);
            }
            bonus = bonus.add(seniorityBonus);
        }

        return bonus;
    }

    //  Khấu trừ cải thiện - Chỉ tính phạt hành vi, không tính bảo hiểm
    private BigDecimal calculateAdvancedDeduction(AttendanceStats stats) {
        BigDecimal deduction = BigDecimal.ZERO;
        
        // 1. Phạt đi trễ: 20K/lần (giảm từ 50K)
        if (stats.lateDays > 0) {
            deduction = deduction.add(BigDecimal.valueOf(stats.lateDays * 20_000));
        }
        
        // 2. Phạt vắng mặt: 50K/ngày (giảm từ 200K)
        if (stats.absentDays > 0) {
            deduction = deduction.add(BigDecimal.valueOf(stats.absentDays * 50_000));
        }
        
        
        return deduction;
    }
    @SuppressWarnings("unused")
    private int calculateAttendanceScore(AttendanceStats stats, int totalDays) {
        if (totalDays == 0)
            return 0;

        // Base score từ tỷ lệ có mặt
        int baseScore = (stats.workingDays * 100) / totalDays;

        // Trừ điểm cho đi trễ
        int lateDeduction = Math.min(stats.lateDays * 5, 30); // Max -30 điểm

        int finalScore = baseScore - lateDeduction;
        return Math.max(0, Math.min(100, finalScore));
    }

    private static class AttendanceStats {
        int workingDays = 0;
        int lateDays = 0;
        int absentDays = 0;
    }public List<Salary> getAllSalaries() {
        return salaryRepository.findAll();
    }

    public List<Salary> getSalariesByMonth(String month) {
        return salaryRepository.findByMonth(month);
    }

    public Optional<Salary> getSalaryById(Long id) {
        return salaryRepository.findById(id);
    }    public void updateSalary(Salary updatedSalary) {
        Salary salary = salaryRepository.findById(updatedSalary.getId()).orElseThrow();

        salary.setBonus(updatedSalary.getBonus());
        salary.setDeduction(updatedSalary.getDeduction());
        salary.setNote(updatedSalary.getNote());

        // Tính lại netSalary với công thức đầy đủ
        // Net = (Base + Allowances + Bonus) - (Insurance + Deduction)
        BigDecimal base = Optional.ofNullable(salary.getBaseSalary()).orElse(BigDecimal.ZERO);
        BigDecimal allowanceMeal = Optional.ofNullable(salary.getAllowanceMeal()).orElse(BigDecimal.ZERO);
        BigDecimal allowanceTransport = Optional.ofNullable(salary.getAllowanceTransport()).orElse(BigDecimal.ZERO);
        BigDecimal allowanceSeniority = Optional.ofNullable(salary.getAllowanceSeniority()).orElse(BigDecimal.ZERO);
        BigDecimal bonus = Optional.ofNullable(salary.getBonus()).orElse(BigDecimal.ZERO);
        
        BigDecimal insuranceHealth = Optional.ofNullable(salary.getInsuranceHealth()).orElse(BigDecimal.ZERO);
        BigDecimal insuranceSocial = Optional.ofNullable(salary.getInsuranceSocial()).orElse(BigDecimal.ZERO);
        BigDecimal deduction = Optional.ofNullable(salary.getDeduction()).orElse(BigDecimal.ZERO);
        
        BigDecimal grossSalary = base.add(allowanceMeal).add(allowanceTransport).add(allowanceSeniority).add(bonus);
        BigDecimal totalDeduction = insuranceHealth.add(insuranceSocial).add(deduction);
        
        salary.setNetSalary(grossSalary.subtract(totalDeduction));        salaryRepository.save(salary);
    }

    //  Lấy lương của employee theo tháng hiện tại
    public Salary getCurrentMonthSalaryByEmployee(Long employeeId) {
        LocalDate now = LocalDate.now();
        String currentMonth = now.getYear() + "-" + String.format("%02d", now.getMonthValue());
        return salaryRepository.findByEmployeeIdAndMonth(employeeId, currentMonth);
    }

    //  Lấy tất cả lương của một employee
    public List<Salary> getSalariesByEmployee(Long employeeId) {
        return salaryRepository.findByEmployeeId(employeeId);
    }

    //  Lấy lương theo employee và tháng cụ thể
    public Salary getSalaryByEmployeeAndMonth(Long employeeId, String month) {
        return salaryRepository.findByEmployeeIdAndMonth(employeeId, month);
    }
}
