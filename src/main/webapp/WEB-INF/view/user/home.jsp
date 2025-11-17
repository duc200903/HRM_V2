<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Trang cá nhân - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />
        <!-- Main Content -->
        <div class="container my-5">
            <!-- Header chào mừng -->
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold text-primary"><i class="fas fa-user-circle me-3"></i>Hồ sơ cá nhân</h1>
                <p class="lead text-muted">Thông tin tài khoản của bạn</p>
            </div>

            <!-- Thông tin cá nhân chi tiết -->
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    <div class="card shadow-lg border-0">
                        <div class="card-header bg-primary text-white py-3">
                            <h4 class="card-title mb-0"><i class="fas fa-id-card me-2"></i>Thông tin chi tiết</h4>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <!-- Thông tin tài khoản -->
                                <div class="col-12">
                                    <h6 class="text-primary border-bottom pb-2 mb-3">
                                        <i class="fas fa-user-cog me-2"></i>Thông tin tài khoản
                                    </h6>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Email đăng nhập:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-envelope text-primary me-2"></i>
                                        ${currentUser.email}
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Vai trò:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <c:choose>
                                            <c:when test="${currentUser.role.name() == 'admin'}">
                                                <span class="badge bg-danger fs-6">
                                                    <i class="fas fa-crown me-1"></i>Quản trị viên
                                                </span>
                                            </c:when>
                                            <c:when test="${currentUser.role.name() == 'hr'}">
                                                <span class="badge bg-warning fs-6">
                                                    <i class="fas fa-users-cog me-1"></i>Nhân sự
                                                </span>
                                            </c:when>
                                            <c:when test="${currentUser.role.name() == 'manager'}">
                                                <span class="badge bg-info fs-6">
                                                    <i class="fas fa-user-tie me-1"></i>Quản lý
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success fs-6">
                                                    <i class="fas fa-user me-1"></i>Nhân viên
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Thông tin cá nhân -->
                                <div class="col-12 mt-4">
                                    <h6 class="text-primary border-bottom pb-2 mb-3">
                                        <i class="fas fa-address-card me-2"></i>Thông tin cá nhân
                                    </h6>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Họ và tên:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-user text-success me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.fullName}">
                                                ${currentEmployee.fullName}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted fst-italic">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Số điện thoại:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-phone text-info me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.phone}">
                                                ${currentEmployee.phone}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Ngày sinh:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-birthday-cake text-warning me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.formattedDob}">
                                                ${currentEmployee.formattedDob}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Địa chỉ:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-map-marker-alt text-danger me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.address}">
                                                ${currentEmployee.address}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa cập nhật</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <!-- Thông tin công việc -->
                                <div class="col-12 mt-4">
                                    <h6 class="text-primary border-bottom pb-2 mb-3">
                                        <i class="fas fa-briefcase me-2"></i>Thông tin công việc
                                    </h6>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Chức vụ:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-id-badge text-purple me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.position}">
                                                ${currentEmployee.position}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa xác định</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Phòng ban:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-building text-info me-2"></i>
                                        <c:choose>
                                            <c:when test="${currentEmployee.department != null}">
                                                ${currentEmployee.department.name}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa phân phòng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Ngày vào làm:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-calendar-alt text-success me-2"></i>
                                        <c:choose>
                                            <c:when test="${not empty currentEmployee.hireDate}">
                                                ${currentEmployee.formattedHireDate}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">Chưa xác định</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Mã nhân viên:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-hashtag text-primary me-2"></i>
                                        ${not empty currentEmployee.employeeCode ? currentEmployee.employeeCode : '<span
                                            class="text-muted fst-italic"
                                            >Chưa được cấp mã</span
                                        >'}
                                    </div>
                                </div>
                            </div>

                            <!-- Action buttons -->
                            <div class="row mt-4 pt-4 border-top">
                                <div class="col-12 text-center">
                                    <h6 class="text-secondary mb-3">Truy cập nhanh</h6>
                                    <a href="/my-attendance" class="btn btn-outline-primary me-2 mb-2">
                                        <i class="fas fa-clock me-1"></i>Chấm công
                                    </a>
                                    <a href="/my-leave" class="btn btn-outline-warning me-2 mb-2">
                                        <i class="fas fa-calendar-times me-1"></i>Nghỉ phép
                                    </a>
                                    <a href="/my-salary" class="btn btn-outline-success me-2 mb-2">
                                        <i class="fas fa-money-bill-wave me-1"></i>Lương thưởng
                                    </a>
                                    <a href="/my-training" class="btn btn-outline-info mb-2">
                                        <i class="fas fa-chart-line me-1"></i>Đào tạo
                                    </a>
                                </div>
                            </div>
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
    </body>
</html>
