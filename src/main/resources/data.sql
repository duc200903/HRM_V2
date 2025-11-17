-- HRM Sample Data
-- Insert data in correct order to handle foreign key constraints

-- 1. Insert Users first (no foreign keys)
INSERT INTO users (id, username, password_hash, email, role, created_at, updated_at) VALUES
(1, 'admin01', '$2a$10$8YZtW5sMHnEUUvh5t2KCpO7OGHxDfh0X2YH5FMXgF2JzUGH5KjN7W', 'admin@hrm.com', 'admin', '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(2, 'hr01', '$2a$10$8YZtW5sMHnEUUvh5t2KCpO7OGHxDfh0X2YH5FMXgF2JzUGH5KjN7W', 'hr@hrm.com', 'hr', '2025-01-05 00:00:00', '2025-01-05 00:00:00'),
(3, 'manager01', '$2a$10$8YZtW5sMHnEUUvh5t2KCpO7OGHxDfh0X2YH5FMXgF2JzUGH5KjN7W', 'manager@hrm.com', 'manager', '2025-01-10 00:00:00', '2025-01-10 00:00:00'),
(4, 'nv01', '$2a$10$8YZtW5sMHnEUUvh5t2KCpO7OGHxDfh0X2YH5FMXgF2JzUGH5KjN7W', 'nva@company.com', 'employee', '2025-01-15 00:00:00', '2025-01-15 00:00:00'),
(5, 'nv02', '$2a$10$8YZtW5sMHnEUUvh5t2KCpO7OGHxDfh0X2YH5FMXgF2JzUGH5KjN7W', 'nvb@company.com', 'employee', '2025-01-20 00:00:00', '2025-01-20 00:00:00');

-- 2. Insert Departments
INSERT INTO departments (id, name, description, created_at, updated_at) VALUES
(1, 'Kinh doanh', 'Phòng Kinh doanh và Bán hàng', '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(2, 'Nhân sự', 'Phòng Nhân sự và Hành chính', '2025-01-01 00:00:00', '2025-01-01 00:00:00'),
(3, 'IT', 'Phòng Công nghệ thông tin', '2025-01-01 00:00:00', '2025-01-01 00:00:00');

-- 3. Insert Employees
INSERT INTO employees (id, user_id, employee_code, full_name, dob, phone, address, department_id, position, hire_date, base_salary, created_at, updated_at) VALUES
(1, 2, 'EMP001', 'Trần Thị HR', '1990-03-02', '901234567', 'Hà Nội', 2, 'HR Staff', '2020-02-01', 9000000.00, '2020-02-01 00:00:00', '2020-02-01 00:00:00'),
(2, 3, 'EMP002', 'Lê Văn Quản', '1988-05-11', '912233445', 'Đà Nẵng', 1, 'Manager', '2019-01-10', 15000000.00, '2019-01-10 00:00:00', '2019-01-10 00:00:00'),
(3, 4, 'EMP003', 'Nguyễn Văn A', '1995-07-20', '988777666', 'TP.HCM', 1, 'Nhân viên', '2022-06-01', 10000000.00, '2022-06-01 00:00:00', '2022-06-01 00:00:00'),
(4, 5, 'EMP004', 'Trần Thị B', '1996-08-15', '977665544', 'Hải Phòng', 3, 'Developer', '2023-03-10', 12000000.00, '2023-03-10 00:00:00', '2023-03-10 00:00:00');

-- 4. Insert Recruitments
INSERT INTO recruitments (id, department_id, title, description, status, created_at) VALUES
(1, 3, 'Lập trình viên Java', 'Phát triển ứng dụng Java Spring Boot', 'open', '2025-08-01 00:00:00'),
(2, 1, 'Nhân viên Marketing', 'Quản lý nội dung và truyền thông', 'closed', '2025-07-15 00:00:00');

-- 5. Insert Applicants
INSERT INTO applicants (id, recruitment_id, name, email, phone, status) VALUES
(1, 1, 'Phạm Văn C', 'pvc@gmail.com', '905551111', 'applied'),
(2, 1, 'Nguyễn Thị D', 'ntd@gmail.com', '933334444', 'interview'),
(3, 2, 'Lê Văn E', 'lve@gmail.com', '911222333', 'rejected');

-- 6. Insert Trainings
INSERT INTO trainings (id, title, description, start_date, end_date) VALUES
(1, 'Kỹ năng bán hàng', 'Khóa học nội bộ về kỹ năng bán hàng', '2025-09-01', '2025-09-10'),
(2, 'ReactJS nâng cao', 'Khóa học online về ReactJS', '2025-10-01', '2025-10-20');

-- 7. Insert Employee Trainings
INSERT INTO employee_trainings (id, employee_id, training_id, result) VALUES
(1, 3, 1, 'Pass'),
(2, 4, 2, 'Fail');

-- 8. Insert Attendances (01/09/2025 - 05/09/2025)

INSERT INTO attendances (id, employee_id, date, check_in, check_out, status) VALUES
-- Nguyễn Văn A (ID 3) → có late
(1, 3, '2025-09-01', '08:05:00', '17:00:00', 'late'),
(2, 3, '2025-09-02', '08:00:00', '17:00:00', 'present'),
(3, 3, '2025-09-03', '08:10:00', '17:00:00', 'late'),
(4, 3, '2025-09-04', '07:55:00', '17:00:00', 'present'),
(5, 3, '2025-09-05', '08:00:00', '17:00:00', 'present'),

-- Trần Thị B (ID 4) → có late
(6, 4, '2025-09-01', '08:10:00', '17:00:00', 'late'),
(7, 4, '2025-09-02', '08:00:00', '17:00:00', 'present'),
(8, 4, '2025-09-03', '08:05:00', '17:00:00', 'late'),
(9, 4, '2025-09-04', '08:20:00', '17:00:00', 'late'),
(10, 4, '2025-09-05', '08:00:00', '17:00:00', 'present'),

-- ✅ Lê Văn Quản (ID 2) → toàn bộ present → được thưởng 500k
(11, 2, '2025-09-01', '07:55:00', '17:00:00', 'present'),
(12, 2, '2025-09-02', '08:00:00', '17:00:00', 'present'),
(13, 2, '2025-09-03', '08:00:00', '17:00:00', 'present'),
(14, 2, '2025-09-04', '08:00:00', '17:00:00', 'present'),
(15, 2, '2025-09-05', '08:00:00', '17:00:00', 'present'),

-- ❌ Trần Thị HR (ID 1) → không chấm công → không tạo bản lương

-- ✅ Nguyễn Văn C (ID 5) → toàn bộ absent
(16, 5, '2025-09-01', NULL, NULL, 'absent'),
(17, 5, '2025-09-02', NULL, NULL, 'absent'),
(18, 5, '2025-09-03', NULL, NULL, 'absent'),
(19, 5, '2025-09-04', NULL, NULL, 'absent'),
(20, 5, '2025-09-05', NULL, NULL, 'absent');

-- 9. Insert Salaries (Đã tính thưởng/phạt theo quy tắc trên)
--INSERT INTO salaries (id, employee_id, month, base_salary, bonus, deduction, net_salary) VALUES
-- Nguyễn Văn A (ID 3): đi sớm 1 ngày (04/09), đi trễ 2 ngày (01/09, 03/09)
--(1, 3, '2025-09', 10000000.00, 100000.00, 100000.00, 10009900.00),
-- Trần Thị B (ID 4): đi sớm 1 ngày (02/09), đi trễ 4 ngày (01/09, 05/09, 08/09, 04/09)
--(2, 4, '2025-09', 12000000.00, 100000.00, 200000.00, 12009900.00);

-- 10. Insert Leave Requests
INSERT INTO leave_requests (id, employee_id, start_date, end_date, reason, status) VALUES
(1, 3, '2025-09-15', '2025-09-16', 'Việc gia đình', 'approved'),
(2, 4, '2025-09-20', '2025-09-22', 'Ốm', 'pending');

-- 11. Insert Performance Reviews
INSERT INTO performance_reviews (id, employee_id, reviewer_id, period, score, comments) VALUES
(1, 3, 2, 'Q3-2025', 85, 'Làm việc tốt'),
(2, 4, 2, 'Q3-2025', 70, 'Cần cải thiện deadline');