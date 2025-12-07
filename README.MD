# 🚀 Spring Boot HRM - Human Resource Management System

Hệ thống quản lý nhân sự toàn diện được xây dựng bằng **Spring Boot MVC**, **JSP**, **Spring Security** và **MySQL**.

## ✨ Tính năng chính

### 👥 Quản lý người dùng và phân quyền

-   **Multi-role system**: Admin, HR, Manager, Employee
-   **Secure authentication**: Spring Security với custom login handler
-   **Role-based access control**: Phân quyền chi tiết theo từng chức năng
-   **User management**: Tạo, sửa, xóa tài khoản admin

### 🏢 Quản lý tổ chức

-   **Department management**: Quản lý phòng ban
-   **Employee management**: CRUD nhân viên với thông tin đầy đủ
-   **Department transfer history**: Lưu lịch sử chuyển phòng ban tự động
-   **Employee profiles**: Thông tin cá nhân, lương, phụ cấp, bảo hiểm

### ⏰ Chấm công và nghỉ phép

-   **Attendance tracking**: Chấm công vào/ra với tính trạng thái
-   **Leave request management**: Quản lý đơn nghỉ phép
-   **Approval workflow**: Quy trình duyệt đơn nghỉ phép
-   **Real-time attendance**: Chấm công trực tuyến cho nhân viên

### 💰 Quản lý lương và tài chính

-   **Salary calculation**: Tính lương tự động theo chấm công
-   **Payroll management**: Quản lý bảng lương chi tiết
-   **Allowances & deductions**: Phụ cấp và khấu trừ đa dạng
-   **Salary reports**: Báo cáo lương theo tháng

### 📚 Đào tạo và phát triển

-   **Training programs**: Quản lý chương trình đào tạo
-   **Employee training tracking**: Theo dõi kết quả đào tạo
-   **Training assignments**: Phân công nhân viên vào khóa học
-   **Progress monitoring**: Giám sát tiến độ học tập

### 📊 Đánh giá hiệu suất

-   **Performance reviews**: Đánh giá hiệu suất định kỳ
-   **Scoring system**: Hệ thống chấm điểm hiệu suất
-   **Review management**: Quản lý chu trình đánh giá

### 🤝 Tuyển dụng

-   **Job postings**: Đăng tin tuyển dụng
-   **Application tracking**: Theo dõi hồ sơ ứng viên
-   **Recruitment workflow**: Quy trình tuyển dụng hoàn chỉnh

### 📈 Dashboard và báo cáo

-   **Admin dashboard**: Tổng quan toàn hệ thống
-   **Personal dashboard**: Trang cá nhân cho nhân viên
-   **Statistical reports**: Báo cáo thống kê đa dạng
-   **Real-time data**: Dữ liệu cập nhật thời gian thực

## 🛠 Công nghệ sử dụng

### Backend

-   **Spring Boot 3.2.2** - Framework chính
-   **Spring MVC** - Web framework pattern
-   **Spring Security 6.x** - Authentication & Authorization
-   **Spring Data JPA** - Database access layer
-   **Hibernate 6.x** - ORM framework
-   **MySQL 8.0** - Relational database
-   **Maven** - Build và dependency management

### Frontend

-   **JSP (Jakarta Server Pages)** - Server-side templating
-   **JSTL** - JSP Standard Tag Library
-   **Bootstrap 5** - Responsive UI framework
-   **Font Awesome 6** - Icon library
-   **JavaScript/jQuery** - Client-side scripting

### Security & Validation

-   **Spring Security** - Comprehensive security framework
-   **Bean Validation (Jakarta)** - Server-side validation
-   **BCrypt** - Password hashing
-   **CSRF Protection** - Cross-site request forgery protection

### Database Design

-   **JPA Entities** - Object-relational mapping
-   **Foreign Key Relationships** - Data integrity
-   **Cascade Operations** - Automatic data management
-   **Audit Fields** - Created/updated timestamps

## 📂 Cấu trúc dự án

```
src/main/java/vn/doan/hrm/
├── 📁 config/              # Spring Security & Web configuration
├── 📁 controller/
│   ├── 📁 admin/           # Admin controllers
│   ├── 📁 auth/            # Authentication controllers
│   ├── 📁 error/           # Error handling
│   ├── 📁 hr/              # HR management controllers
│   ├── 📁 manager/         # Manager controllers
│   └── 📁 user/            # User controllers
├── 📁 domain/              # JPA Entities
├── 📁 dto/                 # Data Transfer Objects
├── 📁 repository/          # Spring Data JPA repositories
└── 📁 service/             # Business logic services

src/main/webapp/WEB-INF/view/
├── 📁 admin/               # Admin interface views
├── 📁 auth/                # Login/logout pages
├── 📁 error/               # Error pages
├── 📁 layout/              # Admin layout components
├── 📁 layout-user/         # User layout components
└── 📁 user/                # User interface views
```

## 🗄️ Database Schema

### Core Tables

-   **users** - Thông tin tài khoản và phân quyền
-   **employees** - Thông tin nhân viên chi tiết
-   **departments** - Cấu trúc phòng ban
-   **department_transfers** - Lịch sử chuyển phòng ban

### Attendance & Leave

-   **attendances** - Dữ liệu chấm công
-   **request_leaves** - Đơn xin nghỉ phép

### Payroll

-   **salaries** - Chi tiết bảng lương

### Training & Performance

-   **trainings** - Chương trình đào tạo
-   **employee_trainings** - Kết quả đào tạo
-   **performance_reviews** - Đánh giá hiệu suất

### Recruitment

-   **recruitments** - Tin tuyển dụng
-   **applicants** - Hồ sơ ứng viên

## 🚀 Cài đặt và chạy dự án

### Yêu cầu hệ thống

-   ☕ **Java 17** hoặc cao hơn
-   🗄️ **MySQL 8.0** hoặc cao hơn
-   📦 **Maven 3.6** hoặc cao hơn
-   💻 **IDE**: IntelliJ IDEA, Eclipse, hoặc VS Code

### Bước 1: Clone dự án

```bash
git clone <repository-url>
cd SPRING-HRM_V1
```

### Bước 2: Cấu hình database

```sql
-- Tạo database
CREATE DATABASE hrm_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Tạo user (optional)
CREATE USER 'hrm_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON hrm_db.* TO 'hrm_user'@'localhost';
```

### Bước 3: Cấu hình application.properties

```properties
# Database configuration
spring.datasource.url=jdbc:mysql://localhost:3306/hrm_db
spring.datasource.username=hrm_user
spring.datasource.password=your_password

# JPA configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true

# JSP configuration
spring.mvc.view.prefix=/WEB-INF/view/
spring.mvc.view.suffix=.jsp

# Server configuration
server.port=6969
```

### Bước 4: Chạy ứng dụng

```bash
# Sử dụng Maven
mvn spring-boot:run

# Hoặc chạy từ IDE
# Right-click on HrmApplication.java -> Run
```

### Bước 5: Truy cập ứng dụng

-   🌐 **URL**: http://localhost:6969
-   👤 **Login**: /login
-   🏠 **Home**: /home (sau khi đăng nhập)

<!-- ## 👤 Tài khoản mặc định -->

## 🔐 Phân quyền hệ thống

### ADMIN (Toàn quyền)

-   Quản lý tất cả users và employees
-   Quản lý departments
-   Quản lý đơn nghỉ phép
-   Xem tất cả reports và dashboard

### HR (Nhân sự)

-   Quản lý employees
-   Quản lý attendance và salary
-   Quản lý training programs
-   Quản lý recruitment

### MANAGER (Quản lý)

-   Xem thông tin employees
-   Quản lý performance reviews
-   Xem reports trong phạm vi quản lý

### EMPLOYEE (Nhân viên)

-   Xem thông tin cá nhân
-   Chấm công online
-   Tạo đơn nghỉ phép
-   Xem lương và training

## 📊 Tính năng nổi bật

### 🎯 Tự động hóa

-   **Auto salary calculation**: Tính lương tự động dựa trên chấm công
-   **Department transfer tracking**: Lưu lịch sử chuyển phòng ban tự động
-   **Real-time attendance**: Chấm công thời gian thực
-   **Seniority calculation**: Tính thâm niên tự động

### 📱 Giao diện thân thiện

-   **Responsive design**: Tương thích mọi thiết bị
-   **Bootstrap 5**: Giao diện hiện đại
-   **Real-time clock**: Đồng hồ thời gian thực
-   **Interactive dashboard**: Dashboard tương tác

### 🔒 Bảo mật cao

-   **Spring Security**: Framework bảo mật enterprise
-   **Role-based access**: Phân quyền chi tiết
-   **Password encryption**: Mã hóa mật khẩu BCrypt
-   **CSRF protection**: Bảo vệ chống tấn công CSRF

### 📈 Báo cáo phong phú

-   **Dashboard analytics**: Phân tích dữ liệu trực quan
-   **Export functionality**: Xuất báo cáo nhiều định dạng
-   **Statistical reports**: Báo cáo thống kê chi tiết
-   **Trend analysis**: Phân tích xu hướng

## 🌟 Demo Screenshots

### Admin Dashboard

-   Tổng quan hệ thống với các thống kê quan trọng
-   Biểu đồ phân bổ nhân viên theo phòng ban
-   Thống kê chấm công và nghỉ phép

### Employee Management

-   Danh sách nhân viên với thông tin đầy đủ
-   Form thêm/sửa nhân viên tích hợp user
-   Lịch sử chuyển phòng ban chi tiết

### Attendance System

-   Chấm công online với GPS (nếu cần)
-   Báo cáo chấm công theo ngày/tháng
-   Tính toán giờ làm việc tự động

### Payroll System

-   Bảng lương chi tiết với các khoản phụ cấp
-   Tính lương tự động theo chấm công
-   Báo cáo lương theo tháng

## 🤝 Đóng góp

1. Fork dự án
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Tạo Pull Request

## 📄 License

Dự án được phân phối dưới MIT License. Xem file `LICENSE` để biết thêm chi tiết.

## 🙏 Acknowledgments

-   Spring Boot Team
-   Bootstrap Team
-   Font Awesome Team
-   MySQL Team
-   All contributors to this project

---

⭐ **Star this repo if you find it helpful!** ⭐
