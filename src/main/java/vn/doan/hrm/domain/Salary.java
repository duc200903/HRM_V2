package vn.doan.hrm.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.PositiveOrZero;
import java.math.BigDecimal;

@Entity
@Table(name = "salaries")
public class Salary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    @NotBlank(message = "Tháng không được để trống")
    @Column(length = 7) // YYYY-MM format
    private String month;

    @Column(name = "base_salary", precision = 12, scale = 2)
    @PositiveOrZero(message = "Lương cơ bản phải >= 0")
    private BigDecimal baseSalary = BigDecimal.ZERO;

    @PositiveOrZero(message = "Thưởng phải >= 0")
    private BigDecimal bonus = BigDecimal.ZERO;

    @PositiveOrZero(message = "Khấu trừ phải >= 0")
    private BigDecimal deduction = BigDecimal.ZERO;    @Column(name = "net_salary", precision = 12, scale = 2)
    private BigDecimal netSalary = BigDecimal.ZERO;
    private String note;

    // ✅ Các trường phụ cấp chi tiết từ Employee
    @Column(name = "allowance_meal", precision = 12, scale = 2)
    private BigDecimal allowanceMeal = BigDecimal.ZERO;

    @Column(name = "allowance_transport", precision = 12, scale = 2)
    private BigDecimal allowanceTransport = BigDecimal.ZERO;

    @Column(name = "allowance_seniority", precision = 12, scale = 2)
    private BigDecimal allowanceSeniority = BigDecimal.ZERO;

    // ✅ Các trường bảo hiểm chi tiết
    @Column(name = "insurance_health", precision = 12, scale = 2)
    private BigDecimal insuranceHealth = BigDecimal.ZERO;

    @Column(name = "insurance_social", precision = 12, scale = 2)
    private BigDecimal insuranceSocial = BigDecimal.ZERO;

    // ✅ Thông tin chấm công
    @Column(name = "working_days")
    private Integer workingDays = 0;

    @Column(name = "late_days")
    private Integer lateDays = 0;

    @Column(name = "absent_days")
    private Integer absentDays = 0;

  

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public BigDecimal getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(BigDecimal baseSalary) {
        this.baseSalary = baseSalary;
    }

    public BigDecimal getBonus() {
        return bonus;
    }

    public void setBonus(BigDecimal bonus) {
        this.bonus = bonus;
    }

    public BigDecimal getDeduction() {
        return deduction;
    }

    public void setDeduction(BigDecimal deduction) {
        this.deduction = deduction;
    }

    public BigDecimal getNetSalary() {
        return netSalary;
    }

    public void setNetSalary(BigDecimal netSalary) {
        this.netSalary = netSalary;
    }

    public String getNote() {
        return note;
    }    public void setNote(String note) {
        this.note = note;
    }

    // ✅ Getters và Setters cho các trường mới
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

    public Integer getWorkingDays() {
        return workingDays;
    }

    public void setWorkingDays(Integer workingDays) {
        this.workingDays = workingDays;
    }

    public Integer getLateDays() {
        return lateDays;
    }

    public void setLateDays(Integer lateDays) {
        this.lateDays = lateDays;
    }

    public Integer getAbsentDays() {
        return absentDays;
    }

    public void setAbsentDays(Integer absentDays) {
        this.absentDays = absentDays;
    }

    //  methods để tính toán lương
    public BigDecimal getTotalAllowance() {
        BigDecimal total = BigDecimal.ZERO;
        if (allowanceMeal != null) total = total.add(allowanceMeal);
        if (allowanceTransport != null) total = total.add(allowanceTransport);
        if (allowanceSeniority != null) total = total.add(allowanceSeniority);
        return total;
    }

    public BigDecimal getTotalInsurance() {
        BigDecimal total = BigDecimal.ZERO;
        if (insuranceHealth != null) total = total.add(insuranceHealth);
        if (insuranceSocial != null) total = total.add(insuranceSocial);
        return total;
    }

      public BigDecimal calculateGrossSalary() {
        BigDecimal base = baseSalary != null ? baseSalary : BigDecimal.ZERO;
        BigDecimal allowances = getTotalAllowance();
        BigDecimal bonusAmount = bonus != null ? bonus : BigDecimal.ZERO;
        return base.add(allowances).add(bonusAmount);
    }

    public BigDecimal calculateTotalDeduction() {
        BigDecimal insurance = getTotalInsurance();
        BigDecimal other = deduction != null ? deduction : BigDecimal.ZERO;
        return insurance.add(other);
    }

    @PrePersist
    @PreUpdate
    protected void calculateNetSalary() {
        BigDecimal gross = calculateGrossSalary();
        BigDecimal totalDed = calculateTotalDeduction();
        this.netSalary = gross.subtract(totalDed);
    }
}