package vn.doan.hrm.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDate;

public class EmployeeUpdateRequest {

    private Long id; // Employee ID

    // ===== USER FIELDS =====
    @NotBlank(message = "Username không được để trống")
    private String username;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    private String email;

    private String role = "employee";

    // ===== EMPLOYEE FIELDS =====
    @NotBlank(message = "Họ và tên không được để trống")
    private String fullName;

    private String phone;
    private String address;
    private String position;
    private Long departmentId;
    private LocalDate hireDate;
    private LocalDate dob;

    // ✅ Thông tin lương và phụ cấp mới
    private String employeeCode;
    private BigDecimal baseSalary = BigDecimal.ZERO;
    private BigDecimal allowanceMeal = BigDecimal.ZERO;
    private BigDecimal allowanceTransport = BigDecimal.ZERO;
    private BigDecimal allowanceSeniority = BigDecimal.ZERO;
    private BigDecimal insuranceHealth = BigDecimal.ZERO;
    private BigDecimal insuranceSocial = BigDecimal.ZERO;
    private Integer remainingLeaveDays = 12;

    // Constructors
    public EmployeeUpdateRequest() {
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Long getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public LocalDate getHireDate() {
        return hireDate;
    }

    public void setHireDate(LocalDate hireDate) {
        this.hireDate = hireDate;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getEmployeeCode() {
        return employeeCode;
    }

    public void setEmployeeCode(String employeeCode) {
        this.employeeCode = employeeCode;
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

    // ✅ Helper methods để format date cho HTML form
    public String getFormattedDob() {
        if (this.dob != null) {
            return this.dob.toString(); // yyyy-MM-dd format cho HTML5 date input
        }
        return "";
    }

    public String getFormattedHireDate() {
        if (this.hireDate != null) {
            return this.hireDate.toString(); // yyyy-MM-dd format cho HTML5 date input
        }
        return "";
    }
}