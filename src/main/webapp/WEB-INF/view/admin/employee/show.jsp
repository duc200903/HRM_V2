<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <link
            rel="shortcut icon"
            href="https://p9-sign-sg.tiktokcdn.com/tos-alisg-avt-0068/6d8e3cd4e9b4ca85588b574be866ddfc~tplv-tiktokx-cropcenter:1080:1080.jpeg?dr=14579&refresh_token=24adab12&x-expires=1752980400&x-signature=Kp96fh33zTEkIUAUiYyoP8Mg33Y%3D&t=4d5b0474&ps=13740610&shp=a5d48078&shcp=81f88b70&idc=my"
            type="image/x-icon"
        />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Quản Lý Nhân Viên</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="/WEB-INF/view/layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Quản lý nhân viên</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item active">Nhân viên</li>
                        </ol>
                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Tổng số nhân viên</div>
                                                <div class="text-lg fw-bold">${totalEmployees}</div>
                                            </div>
                                            <i class="fas fa-users fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Employee Table -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-table me-1"></i>
                                        <strong>Danh sách nhân viên</strong>
                                    </div>
                                    <c:if test="${not pageContext.request.isUserInRole('ROLE_MANAGER')}">
                                        <!-- Hiện nút Thêm nếu KHÔNG PHẢI là MANAGER -->
                                        <a href="/admin/employee/create" class="btn btn-primary">
                                            <i class="fas fa-plus me-1"></i>
                                            Thêm nhân viên
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="employeeTable">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                                <th><i class="fas fa-user me-1"></i>Họ và tên</th>
                                                <th><i class="fas fa-envelope me-1"></i>Email</th>
                                                <th><i class="fas fa-phone me-1"></i>Số điện thoại</th>
                                                <th><i class="fas fa-user-tag me-1"></i>Vai trò</th>
                                                <th><i class="fas fa-briefcase me-1"></i>Chức vụ</th>
                                                <th><i class="fas fa-building me-1"></i>Phòng ban</th>
                                                <th><i class="fas fa-calendar me-1"></i>Ngày tạo</th>
                                                <th><i class="fas fa-cogs me-1"></i>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employee" items="${employees}">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-secondary">${employee.id}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-user text-primary me-2"></i>
                                                            <strong>${employee.fullName}</strong>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when
                                                                test="${not empty employee.user && not empty employee.user.email}"
                                                            >
                                                                <i class="fas fa-envelope text-muted me-1"></i>
                                                                <a
                                                                    href="mailto:${employee.user.email}"
                                                                    class="text-decoration-none text-primary"
                                                                >
                                                                    ${employee.user.email}
                                                                </a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có email</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty employee.phone}">
                                                                <i class="fas fa-phone text-muted me-1"></i>
                                                                ${employee.phone}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa cập nhật</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty employee.user}">
                                                                <c:choose>
                                                                    <c:when test="${employee.user.role == 'admin'}">
                                                                        <span class="badge bg-danger">
                                                                            <i class="fas fa-user-shield me-1"></i>Admin
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${employee.user.role == 'hr'}">
                                                                        <span class="badge bg-warning">
                                                                            <i class="fas fa-users me-1"></i>HR
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${employee.user.role == 'manager'}">
                                                                        <span class="badge bg-primary">
                                                                            <i class="fas fa-user-tie me-1"></i>Manager
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${employee.user.role == 'employee'}">
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-user me-1"></i>Employee
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">
                                                                            <i class="fas fa-question me-1"></i
                                                                            >${employee.user.role}
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Không có tài khoản</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty employee.position}">
                                                                <span class="badge bg-info">
                                                                    <i class="fas fa-briefcase me-1"></i
                                                                    >${employee.position}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có chức vụ</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty employee.department}">
                                                                <div class="d-flex align-items-center">
                                                                    <i class="fas fa-building text-success me-2"></i>
                                                                    ${employee.department.name}
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa phân phòng ban</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <i class="fas fa-calendar-alt text-muted me-1"></i>
                                                            ${employee.formattedCreatedAt}
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <div class="btn-group" role="group">
                                                                <!-- ✅ View Button: luôn hiện -->
                                                                <a
                                                                    href="/admin/employee/detail/${employee.id}"
                                                                    class="btn btn-outline-info btn-sm"
                                                                    title="Xem chi tiết"
                                                                >
                                                                    <i class="fas fa-eye"></i>
                                                                </a>

                                                                <!-- ❌ Chỉ hiện khi KHÔNG PHẢI là MANAGER -->
                                                                <c:if
                                                                    test="${not pageContext.request.isUserInRole('ROLE_MANAGER')}"
                                                                >
                                                                    <a
                                                                        href="/admin/employee/update/${employee.id}"
                                                                        class="btn btn-outline-warning btn-sm"
                                                                        title="Chỉnh sửa"
                                                                    >
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>
                                                                    <a
                                                                        href="/admin/employee/delete/${employee.id}"
                                                                        class="btn btn-outline-danger btn-sm"
                                                                        title="Xóa"
                                                                    >
                                                                        <i class="fas fa-trash"></i>
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty employees}">
                                                <tr>
                                                    <td colspan="9" class="text-center py-5">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="fas fa-users fa-4x text-muted mb-3"></i>
                                                            <h5 class="text-muted mb-2">Chưa có nhân viên nào</h5>
                                                            <p class="text-muted mb-0">
                                                                Hãy thêm nhân viên đầu tiên để bắt đầu
                                                            </p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>

        <!-- ✅ Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="toast-container position-fixed bottom-0 end-0 p-3">
                <div class="toast show" role="alert">
                    <div class="toast-header bg-success text-white">
                        <i class="fas fa-check-circle me-2"></i>
                        <strong class="me-auto">Thành công</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                    </div>
                    <div class="toast-body">${successMessage}</div>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="toast-container position-fixed bottom-0 end-0 p-3">
                <div class="toast show" role="alert">
                    <div class="toast-header bg-danger text-white">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong class="me-auto">Lỗi</strong>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
                    </div>
                    <div class="toast-body">${errorMessage}</div>
                </div>
            </div>
        </c:if>

        <!-- Scripts -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"
        ></script>

        <!-- ✅ Auto hide toasts after 5 seconds -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var toastElements = document.querySelectorAll('.toast');
                toastElements.forEach(function (toast) {
                    setTimeout(function () {
                        var bsToast = new bootstrap.Toast(toast);
                        bsToast.hide();
                    }, 5000);
                });
            });
        </script>
    </body>
</html>
