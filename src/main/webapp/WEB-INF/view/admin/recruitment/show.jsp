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
        <title>Quản lý tuyển dụng - HRM System</title>
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
                        <h1 class="mt-4">Quản lý tuyển dụng</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item active">Tuyển dụng</li>
                        </ol>
                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Tổng tin tuyển dụng</div>
                                                <div class="text-lg fw-bold">${totalRecruitments}</div>
                                            </div>
                                            <i class="fas fa-briefcase fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Recruitment Table -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-table me-1"></i>
                                        <strong>Danh sách tin tuyển dụng</strong>
                                    </div>
                                    <a href="/admin/recruitment/create" class="btn btn-primary">
                                        <i class="fas fa-plus me-1"></i>
                                        Thêm tin tuyển dụng
                                    </a>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="recruitmentTable">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>#</th>
                                                <th>Vị trí</th>
                                                <th>Phòng ban</th>
                                                <th>Mô tả</th>
                                                <th>Trạng thái</th>
                                                <th>Ngày tạo</th>
                                                <th>Ứng viên</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="rec" items="${recruitments}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td><strong>${rec.title}</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty rec.department}">
                                                                <span class="badge bg-info">
                                                                    <i class="fas fa-building me-1"></i
                                                                    >${rec.department.name}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa phân phòng</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="text-truncate d-inline-block"
                                                            style="max-width: 200px"
                                                            title="${rec.description}"
                                                        >
                                                            ${rec.description}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span
                                                            class="badge bg-${rec.status.name() == 'open' ? 'success' : 'secondary'}"
                                                        >
                                                            ${rec.status.name() == 'open' ? 'Đang mở' : 'Đã đóng'}
                                                        </span>
                                                    </td>
                                                    <td>${rec.formattedCreatedAt}</td>
                                                    <td>
                                                        <span class="badge bg-primary">
                                                            <i class="fas fa-users me-1"></i>${rec.applicants.size()}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a
                                                                href="/admin/recruitment/detail/${rec.id}"
                                                                class="btn btn-outline-info btn-sm"
                                                                title="Xem chi tiết"
                                                            >
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a
                                                                href="/admin/recruitment/update/${rec.id}"
                                                                class="btn btn-outline-warning btn-sm"
                                                                title="Chỉnh sửa"
                                                            >
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a
                                                                href="/admin/recruitment/delete/${rec.id}"
                                                                class="btn btn-outline-danger btn-sm"
                                                                title="Xóa"
                                                            >
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty recruitments}">
                                                <tr>
                                                    <td colspan="8" class="text-center py-5">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="fas fa-briefcase fa-4x text-muted mb-3"></i>
                                                            <h5 class="text-muted mb-2">Chưa có tin tuyển dụng nào</h5>
                                                            <p class="text-muted mb-0">
                                                                Hãy thêm tin tuyển dụng đầu tiên để bắt đầu
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
