package vn.doan.hrm.domain;

import jakarta.persistence.*;

@Entity
@Table(name = "employee_trainings")
public class EmployeeTraining {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "training_id")
    private Training training;

    private String result; // "Pending", "Pass", "Fail", "Completed", etc.

    // Constructors
    public EmployeeTraining() {}

    public EmployeeTraining(Employee employee, Training training, String result) {
        this.employee = employee;
        this.training = training;
        this.result = result;
    }

    // Getters and Setters
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

    public Training getTraining() {
        return training;
    }

    public void setTraining(Training training) {
        this.training = training;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    @Override
    public String toString() {
        return "EmployeeTraining{" +
                "id=" + id +
                ", employee=" + (employee != null ? employee.getFullName() : "null") +
                ", training=" + (training != null ? training.getTitle() : "null") +
                ", result='" + result + '\'' +
                '}';
    }
}