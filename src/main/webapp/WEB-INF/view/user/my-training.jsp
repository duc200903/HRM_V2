<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Đào tạo của tôi - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />

        <!-- Main Content -->
        <div class="container my-5">
            <!-- Header -->
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold text-primary">
                    <i class="fas fa-graduation-cap me-3"></i>Đào tạo của tôi
                </h1>
                <p class="lead text-muted">Theo dõi tiến trình học tập và phát triển kỹ năng</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row">
                <!-- Thông tin nhân viên -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow border-0 h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="fas fa-user me-2"></i>Thông tin cá nhân
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${currentEmployee != null}">
                                    <div class="mb-3">
                                        <strong>Nhân viên:</strong>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.fullName}">
                                                ${currentEmployee.fullName}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="mb-3">
                                        <strong>Phòng ban:</strong>
                                        <c:choose>
                                            <c:when test="${currentEmployee.department != null}">
                                                ${currentEmployee.department.name}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa phân phòng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="mb-3">
                                        <strong>Mã NV:</strong>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.employeeCode}">
                                                ${currentEmployee.employeeCode}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="mb-3">
                                        <strong>Chức vụ:</strong>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.position}">
                                                ${currentEmployee.position}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa có</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-muted py-3">
                                        <i class="fas fa-exclamation-triangle fa-2x mb-2"></i>
                                        <p>Không thể xem thông tin đào tạo<br>Thông tin nhân viên chưa được cập nhật</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Thống kê và danh sách đào tạo -->
                <div class="col-lg-8">
                    <!-- Thống kê -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-primary text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-book fa-2x mb-2"></i>
                                    <h4 class="mb-0">${totalTrainings}</h4>
                                    <small>Tổng khóa học</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-success text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                                    <h4 class="mb-0">${completedTrainings}</h4>
                                    <small>Hoàn thành</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-warning text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-clock fa-2x mb-2"></i>
                                    <h4 class="mb-0">${pendingTrainings}</h4>
                                    <small>Đang học</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-info text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-trophy fa-2x mb-2"></i>
                                    <h4 class="mb-0">${passedTrainings}</h4>
                                    <small>Đạt</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách đào tạo -->
                    <div class="card shadow border-0">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0">
                                <i class="fas fa-list me-2"></i>Danh sách khóa đào tạo
                            </h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty employeeTrainings}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">                                            <thead class="table-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên khóa học</th>
                                                    <!-- <th>Mô tả</th> -->
                                                    <th>Ngày bắt đầu</th>
                                                    <th>Ngày kết thúc</th>
                                                    <th>Link khóa học</th>
                                                    <th>Kết quả</th>
                                                </tr>
                                            </thead>
                                            <tbody>                                                <c:forEach var="empTraining" items="${employeeTrainings}">
                                                    <tr>
                                                        <!-- ID -->
                                                        <td>
                                                            <span class="badge bg-primary">${empTraining.training.id}</span>
                                                        </td>
                                                        
                                                        <!-- Tên khóa học -->
                                                        <td>
                                                            <strong class="text-primary">${empTraining.training.title}</strong>
                                                        </td>
                                                        <!-- <td>
                                                            <c:choose>
                                                                <c:when test="${not empty empTraining.training.description}">
                                                                    <span class="text-muted small">
                                                                        ${empTraining.training.description.length() > 50 ? 
                                                                          empTraining.training.description.substring(0, 50).concat('...') : 
                                                                          empTraining.training.description}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Không có mô tả</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>                                                         -->
                                                        <!-- Ngày bắt đầu -->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${empTraining.training.startDate != null}">
                                                                    <span class="badge bg-info">
                                                                        ${empTraining.training.startDate.dayOfMonth}/${empTraining.training.startDate.monthValue}/${empTraining.training.startDate.year}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa xác định</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        
                                                        <!-- Ngày kết thúc -->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${empTraining.training.endDate != null}">
                                                                    <span class="badge bg-warning">
                                                                        ${empTraining.training.endDate.dayOfMonth}/${empTraining.training.endDate.monthValue}/${empTraining.training.endDate.year}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa xác định</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        
                                                        <!-- Link khóa học -->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty empTraining.training.link}">
                                                                    <a href="${empTraining.training.link}" target="_blank" class="btn btn-sm btn-outline-primary">
                                                                        <i class="fas fa-external-link-alt me-1"></i>Truy cập
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa có link</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>                                                        
                                                        <!-- Kết quả -->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${empTraining.result == 'Completed'}">
                                                                    <span class="badge bg-success">
                                                                        <i class="fas fa-check me-1"></i>Hoàn thành
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${empTraining.result == 'Pass'}">
                                                                    <span class="badge bg-success">
                                                                        <i class="fas fa-trophy me-1"></i>ĐẠT
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${empTraining.result == 'Fail'}">
                                                                    <span class="badge bg-danger">
                                                                        <i class="fas fa-times me-1"></i>KHÔNG ĐẠT
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${empTraining.result == 'Pending'}">
                                                                    <span class="badge bg-warning text-dark">
                                                                        <i class="fas fa-clock me-1"></i>ĐANG HỌC 
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${empTraining.result}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-muted py-5">
                                        <i class="fas fa-graduation-cap fa-3x mb-3"></i>
                                        <h5>Chưa có khóa đào tạo nào</h5>
                                        <p>Các khóa đào tạo sẽ được HR/Admin phân công cho bạn</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="/WEB-INF/view/layout-user/footer.jsp" />

        <!-- Include Scripts -->
        <jsp:include page="/WEB-INF/view/layout-user/scripts.jsp" />

        <!-- Include Styles -->
        <jsp:include page="/WEB-INF/view/layout-user/styles.jsp" />

        <!-- Page specific script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                console.log('🎓 Training page loaded');
                
                // Add hover effects for training rows
                const trainingRows = document.querySelectorAll('tbody tr');
                trainingRows.forEach(row => {
                    row.addEventListener('mouseenter', function() {
                        this.style.backgroundColor = '#f8f9fa';
                    });
                    row.addEventListener('mouseleave', function() {
                        this.style.backgroundColor = '';
                    });
                });
            });
        </script>
    </body>
</html>
