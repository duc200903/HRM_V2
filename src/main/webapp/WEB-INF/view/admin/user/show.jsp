<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Quản lý tài khoản Admin - HRM System</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
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
                        <h1 class="mt-4">Quản lý tài khoản Admin</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item active">Quản lý Admin</li>
                        </ol>

                        <!-- Warning Alert -->
                        <div class="alert alert-warning mb-4">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Lưu ý:</strong> Trang này chỉ quản lý tài khoản Admin hệ thống. Để quản lý nhân viên
                            và tài khoản của họ, vui lòng sử dụng
                            <a href="/admin/employee" class="alert-link">Quản lý nhân viên</a>.
                        </div>

                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Tài khoản Admin</div>
                                                <div class="text-lg fw-bold">${totalAdmins}</div>
                                            </div>
                                            <i class="fas fa-user-shield fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Admin Table -->
                        <div class="card mb-4">
                            <div class="card-header bg-danger text-white">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-user-shield me-1"></i>
                                        <strong>Danh sách tài khoản Admin</strong>
                                    </div>
                                    <a href="/admin/user/create" class="btn btn-light btn-sm">
                                        <i class="fas fa-plus me-1"></i>
                                        Thêm Admin
                                    </a>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="userTable">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                                <th><i class="fas fa-user me-1"></i>Tên đăng nhập</th>
                                                <th><i class="fas fa-envelope me-1"></i>Email</th>
                                                <th><i class="fas fa-user-tag me-1"></i>Vai trò</th>
                                                <th><i class="fas fa-calendar me-1"></i>Ngày tạo</th>
                                                <th><i class="fas fa-cogs me-1"></i>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="user" items="${users}">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-secondary">${user.id}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:choose>
                                                                <c:when test="${user.role == 'admin'}">
                                                                    <i class="fas fa-crown text-warning me-2"></i>
                                                                    <strong>${user.username}</strong>
                                                                </c:when>
                                                                <c:when test="${user.role == 'hr'}">
                                                                    <i class="fas fa-user-tie text-success me-2"></i>
                                                                    ${user.username}
                                                                </c:when>
                                                                <c:when test="${user.role == 'manager'}">
                                                                    <i class="fas fa-user-cog text-warning me-2"></i>
                                                                    ${user.username}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <i class="fas fa-user text-info me-2"></i>
                                                                    ${user.username}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <i class="fas fa-envelope text-muted me-1"></i>
                                                        ${user.email}
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${user.role == 'admin'}">
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-user-shield me-1"></i>ADMIN
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.role == 'hr'}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-users me-1"></i>HR
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${user.role == 'manager'}">
                                                                <span class="badge bg-warning">
                                                                    <i class="fas fa-user-cog me-1"></i>MANAGER
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-info">
                                                                    <i class="fas fa-user me-1"></i>EMPLOYEE
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <i class="fas fa-calendar-alt text-muted me-1"></i>
                                                            ${user.formattedCreatedAt}
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <!--  View Button -->
                                                            <a
                                                                href="/admin/user/detail/${user.id}"
                                                                class="btn btn-outline-info btn-sm"
                                                                title="Xem chi tiết"
                                                            >
                                                                <i class="fas fa-eye"></i>
                                                            </a>

                                                            <!--  Edit Button -->
                                                            <a
                                                                href="/admin/user/update/${user.id}"
                                                                class="btn btn-outline-warning btn-sm"
                                                                title="Chỉnh sửa"
                                                            >
                                                                <i class="fas fa-edit"></i>
                                                            </a>

                                                            <!--  Delete Button -->
                                                            <c:choose>
                                                                <c:when test="${user.role == 'admin'}">
                                                                    <button
                                                                        class="btn btn-outline-secondary btn-sm"
                                                                        disabled
                                                                        title="Admin không thể xóa"
                                                                    >
                                                                        <i class="fas fa-shield-alt"></i>
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a
                                                                        href="/admin/user/delete/${user.id}"
                                                                        class="btn btn-outline-danger btn-sm"
                                                                        title="Xóa"
                                                                    >
                                                                        <i class="fas fa-trash"></i>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty users}">
                                                <tr>
                                                    <td colspan="6" class="text-center py-5">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="fas fa-users fa-4x text-muted mb-3"></i>
                                                            <h5 class="text-muted mb-2">Chưa có người dùng nào</h5>
                                                            <p class="text-muted mb-0">
                                                                Hãy thêm người dùng đầu tiên để bắt đầu
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

        <!--  Success/Error Messages -->
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!--  Auto hide toasts after 5 seconds -->
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
