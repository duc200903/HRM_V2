package vn.doan.hrm.domain;

import java.time.LocalDateTime;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "applicants")
public class Applicant {
    public enum Status {
        applied, interview, hired, rejected
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "applied_at")
    private LocalDateTime appliedAt;

    @PrePersist
    protected void onApply() {
        if (appliedAt == null)
            appliedAt = LocalDateTime.now();
    }

    // ✅ Biến định dạng ngày (dùng để hiển thị trong JSP)
    @Transient
    private String formattedAppliedAt;

    public String getFormattedAppliedAt() {
        return formattedAppliedAt;
    }

    public void setFormattedAppliedAt(String formattedAppliedAt) {
        this.formattedAppliedAt = formattedAppliedAt;
    }

    @NotBlank(message = "Họ tên không được để trống")
    private String name;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Email không đúng định dạng")
    private String email;

    private String phone;

    @Enumerated(EnumType.STRING)
    private Status status = Status.applied;

    @NotNull(message = "Vị trí ứng tuyển không được để trống")
    @ManyToOne
    @JoinColumn(name = "recruitment_id", nullable = false)
    private Recruitment recruitment;

    // ===== Getter/Setter đầy đủ =====
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(LocalDateTime appliedAt) {
        this.appliedAt = appliedAt;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Recruitment getRecruitment() {
        return recruitment;
    }

    public void setRecruitment(Recruitment recruitment) {
        this.recruitment = recruitment;
    }
}