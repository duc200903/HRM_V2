package vn.doan.hrm.domain;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Entity
@Table(name = "employees")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;
    @Column(name = "employee_code", unique = true)
    private String employeeCode;

    @Column(name = "full_name")
    private String fullName;

    private LocalDate dob;
    private String phone;
    private String address;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    private String position;
    @Column(name = "hire_date")
    private LocalDate hireDate;
    @Column(name = "base_salary", precision = 15, scale = 2)
    private BigDecimal baseSalary = BigDecimal.ZERO;

    //  Các phụ cấp
    @Column(name = "allowance_meal", precision = 15, scale = 2) // ăn
    private BigDecimal allowanceMeal = BigDecimal.ZERO;

    @Column(name = "allowance_transport", precision = 15, scale = 2) // xe
    private BigDecimal allowanceTransport = BigDecimal.ZERO;

    @Column(name = "allowance_seniority", precision = 15, scale = 2) // thâm niên
    private BigDecimal allowanceSeniority = BigDecimal.ZERO;

    //  Bảo hiểm
    @Column(name = "insurance_health", precision = 15, scale = 2) // y tế
    private BigDecimal insuranceHealth = BigDecimal.ZERO;

    @Column(name = "insurance_social", precision = 15, scale = 2) // xã hội
    private BigDecimal insuranceSocial = BigDecimal.ZERO;

    //  Số ngày phép còn lại trong năm
    @Column(name = "remaining_leave_days")
    private Integer remainingLeaveDays = 12; // Mặc định 12 ngày/năm

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at")
    private LocalDateTime updatedAt = LocalDateTime.now(); // Quan hệ ngược -  Thêm cascade để tự động xóa related data
    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Attendance> attendances;

    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<Salary> salaries;

    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<EmployeeTraining> trainings;    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<RequestLeave> requestLeaves;

    @OneToMany(mappedBy = "employee", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<PerformanceReview> performanceReviews;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public LocalDate getHireDate() {
        return hireDate;
    }

    public void setHireDate(LocalDate hireDate) {
        this.hireDate = hireDate;
    }

    public BigDecimal getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(BigDecimal baseSalary) {
        this.baseSalary = baseSalary;
    }

    public BigDecimal getAllowanceMeal() {
        return allowanceMeal;
    }

    public void setAllowanceMeal(BigDecimal allowanceMeal) {
        this.allowanceMeal = allowanceMeal;
    }

    public BigDecimal getAllowanceTransport() {
        return allowanceTransport;
    }

    public void setAllowanceTransport(BigDecimal allowanceTransport) {
        this.allowanceTransport = allowanceTransport;
    }

    public BigDecimal getAllowanceSeniority() {
        return allowanceSeniority;
    }

    public void setAllowanceSeniority(BigDecimal allowanceSeniority) {
        this.allowanceSeniority = allowanceSeniority;
    }

    public BigDecimal getInsuranceHealth() {
        return insuranceHealth;
    }

    public void setInsuranceHealth(BigDecimal insuranceHealth) {
        this.insuranceHealth = insuranceHealth;
    }

    public BigDecimal getInsuranceSocial() {
        return insuranceSocial;
    }

    public void setInsuranceSocial(BigDecimal insuranceSocial) {
        this.insuranceSocial = insuranceSocial;
    }

    public Integer getRemainingLeaveDays() {
        return remainingLeaveDays;
    }

    public void setRemainingLeaveDays(Integer remainingLeaveDays) {
        this.remainingLeaveDays = remainingLeaveDays;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    // public void setCreatedAt(LocalDateTime createdAt) {
    // this.createdAt = createdAt;
    // }

    // public LocalDateTime getUpdatedAt() {
    // return updatedAt;
    // }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<Attendance> getAttendances() {
        return attendances;
    }

    public void setAttendances(List<Attendance> attendances) {
        this.attendances = attendances;
    }

    public List<Salary> getSalaries() {
        return salaries;
    }

    public void setSalaries(List<Salary> salaries) {
        this.salaries = salaries;
    }

    public List<EmployeeTraining> getTrainings() {
        return trainings;
    }

    public void setTrainings(List<EmployeeTraining> trainings) {
        this.trainings = trainings;
    }    public List<RequestLeave> getRequestLeaves() {
        return requestLeaves;
    }

    public void setRequestLeaves(List<RequestLeave> requestLeaves) {
        this.requestLeaves = requestLeaves;
    }

    public List<PerformanceReview> getPerformanceReviews() {
        return performanceReviews;
    }

    public void setPerformanceReviews(List<PerformanceReview> performanceReviews) {
        this.performanceReviews = performanceReviews;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
    }

    @PrePersist
    protected void onCreate() {
        if (createdAt == null)
            createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();

        //  Auto-set hire date nếu chưa có
        if (hireDate == null)
            hireDate = LocalDate.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    //  THÊM HELPER METHODS VÀO ĐÂY
    public String getFormattedCreatedAt() {
        if (createdAt == null) {
            return "N/A";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return createdAt.format(formatter);
    }

    public String getFormattedUpdatedAt() {
        if (updatedAt == null) {
            return "N/A";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return updatedAt.format(formatter);
    }

    public String getFormattedHireDate() {
        if (this.hireDate != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return this.hireDate.format(formatter);
        }
        return "";
    }

    public String getFormattedDob() {
        if (this.dob != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            return this.dob.format(formatter);
        }
        return "";
    } //  Computed field: Số năm làm việc (chính xác từ ngày vào làm)

    public Integer getYearsOfService() {
        if (hireDate == null) {
            return 0;
        }
        LocalDate now = LocalDate.now();

        // Tính chính xác số năm, xét cả tháng và ngày
        int years = now.getYear() - hireDate.getYear();

        // Nếu chưa đến "ngày sinh nhật công việc" trong năm hiện tại thì trừ đi 1 năm
        if (now.getMonthValue() < hireDate.getMonthValue() ||
                (now.getMonthValue() == hireDate.getMonthValue() && now.getDayOfMonth() < hireDate.getDayOfMonth())) {
            years--;
        }

        return Math.max(0, years); // Đảm bảo không âm
    }

    //  Thời gian làm việc chi tiết (năm, tháng, ngày)
    public String getDetailedWorkingTime() {
        if (hireDate == null) {
            return "Chưa xác định ngày vào làm";
        }

        LocalDate now = LocalDate.now();
        LocalDate start = hireDate;

        // Nếu ngày vào làm là trong tương lai
        if (start.isAfter(now)) {
            return "Chưa bắt đầu làm việc";
        }

        int years = 0;
        int months = 0;
        int days = 0;

        // Tính năm
        years = now.getYear() - start.getYear();

        // Tính tháng
        months = now.getMonthValue() - start.getMonthValue();
        if (months < 0) {
            years--;
            months += 12;
        }

        // Tính ngày
        days = now.getDayOfMonth() - start.getDayOfMonth();
        if (days < 0) {
            months--;
            if (months < 0) {
                years--;
                months += 12;
            }
            // Lấy số ngày của tháng trước
            LocalDate lastMonth = now.minusMonths(1);
            days += lastMonth.lengthOfMonth();
        }

        // Đảm bảo không âm
        years = Math.max(0, years);
        months = Math.max(0, months);
        days = Math.max(0, days);

        // Format kết quả
        StringBuilder result = new StringBuilder();
        if (years > 0) {
            result.append(years).append(" năm");
        }
        if (months > 0) {
            if (result.length() > 0)
                result.append(", ");
            result.append(months).append(" tháng");
        }
        if (days > 0) {
            if (result.length() > 0)
                result.append(", ");
            result.append(days).append(" ngày");
        }

        return result.length() > 0 ? result.toString() : "Mới vào làm hôm nay";
    }

    //  Tổng số ngày đã làm việc
    public Long getTotalWorkingDays() {
        if (hireDate == null) {
            return 0L;
        }
        LocalDate now = LocalDate.now();
        if (hireDate.isAfter(now)) {
            return 0L;
        }
        return java.time.temporal.ChronoUnit.DAYS.between(hireDate, now);
    }

    //  Số tháng đã làm việc
    public Long getTotalWorkingMonths() {
        if (hireDate == null) {
            return 0L;
        }
        LocalDate now = LocalDate.now();
        if (hireDate.isAfter(now)) {
            return 0L;
        }
        return java.time.temporal.ChronoUnit.MONTHS.between(hireDate, now);
    }

    //  Tính tổng lương (lương cơ bản + phụ cấp)
    public BigDecimal getTotalSalary() {
        BigDecimal total = baseSalary != null ? baseSalary : BigDecimal.ZERO;

        if (allowanceMeal != null) {
            total = total.add(allowanceMeal);
        }
        if (allowanceTransport != null) {
            total = total.add(allowanceTransport);
        }
        if (allowanceSeniority != null) {
            total = total.add(allowanceSeniority);
        }

        return total;
    }

    //  Tính tổng khấu trừ (bảo hiểm)
    public BigDecimal getTotalInsurance() {
        BigDecimal total = BigDecimal.ZERO;

        if (insuranceHealth != null) {
            total = total.add(insuranceHealth);
        }
        if (insuranceSocial != null) {
            total = total.add(insuranceSocial);
        }

        return total;
    }

    //  Tính lương thực lãnh (tổng lương - bảo hiểm)
    public BigDecimal getNetSalary() {
        return getTotalSalary().subtract(getTotalInsurance());
    }

}
