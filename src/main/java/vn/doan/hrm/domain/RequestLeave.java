package vn.doan.hrm.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "request_leaves")
public class RequestLeave {

    public enum Status {
        pending, approved, rejected
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "employee_id", nullable = false)
    private Employee employee;

    @NotNull(message = "Ngày bắt đầu không được để trống")
    @Column(name = "start_date")
    private LocalDate startDate;

    @NotNull(message = "Ngày kết thúc không được để trống")
    @Column(name = "end_date")
    private LocalDate endDate;

    @NotBlank(message = "Lý do nghỉ phép không được để trống")
    @Column(columnDefinition = "TEXT")
    private String reason;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status = Status.pending;

    @Column(name = "created_at")
    private LocalDate createdAt = LocalDate.now();

    @Column(name = "leave_month")
    private Integer leaveMonth;

    @Column(name = "leave_year")
    private Integer leaveYear;

    @Column(name = "total_days")
    private Integer totalDaysDb;

    @Column(name = "approved_by")
    private String approvedBy;

    @Column(name = "approved_at")
    private LocalDate approvedAt;

    @Column(columnDefinition = "TEXT")
    private String note;

    // Constructors
    public RequestLeave() {}

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }

    public LocalDate getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDate createdAt) { this.createdAt = createdAt; }

    public Integer getLeaveMonth() { return leaveMonth; }
    public void setLeaveMonth(Integer leaveMonth) { this.leaveMonth = leaveMonth; }

    public Integer getLeaveYear() { return leaveYear; }
    public void setLeaveYear(Integer leaveYear) { this.leaveYear = leaveYear; }

    public Integer getTotalDaysDb() { return totalDaysDb; }
    public void setTotalDaysDb(Integer totalDaysDb) { this.totalDaysDb = totalDaysDb; }

    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }

    public LocalDate getApprovedAt() { return approvedAt; }
    public void setApprovedAt(LocalDate approvedAt) { this.approvedAt = approvedAt; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    // Utility methods
    public long getTotalDays() {
        // Ưu tiên dùng từ DB, nếu không có thì tính toán
        if (totalDaysDb != null && totalDaysDb > 0) {
            return totalDaysDb;
        }
        if (startDate == null || endDate == null) return 0;
        return ChronoUnit.DAYS.between(startDate, endDate) + 1;
    }

    public String getStatusText() {
        switch (status) {
            case pending: return "Chờ duyệt";
            case approved: return "Đã duyệt";
            case rejected: return "Đã từ chối";
            default: return "Không xác định";
        }
    }

    public String getStatusBadgeClass() {
        switch (status) {
            case pending: return "bg-warning";
            case approved: return "bg-success";
            case rejected: return "bg-danger";
            default: return "bg-secondary";
        }
    }

    public String getLeaveMonthYear() {
        if (leaveMonth != null && leaveYear != null) {
            return String.format("%02d/%d", leaveMonth, leaveYear);
        }
        return "";
    }
}