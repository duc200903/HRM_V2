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
        <title>Quản lý chấm công - HRM System</title>
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
                        <h1 class="mt-4">Quản lý chấm công</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item active">Chấm công</li>
                        </ol>
                        <!-- Statistics Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-success text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Có mặt</div>
                                                <div class="text-lg fw-bold">${presentCount}/${totalEmployees}</div>
                                            </div>
                                            <i class="fas fa-check-circle fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-warning text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Đi trễ</div>
                                                <div class="text-lg fw-bold">${lateCount}</div>
                                            </div>
                                            <i class="fas fa-clock fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-danger text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Vắng mặt</div>
                                                <div class="text-lg fw-bold">${absentCount}</div>
                                            </div>
                                            <i class="fas fa-times-circle fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-info text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="text-white-75 small">Ngày hiển thị</div>
                                                <div class="text-lg fw-bold">${selectedDateFormatted}</div>
                                            </div>
                                            <i class="fas fa-calendar fa-2x text-white-25"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Attendance Table -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <i class="fas fa-clock me-1"></i>
                                        <strong>Chấm công hôm nay - ${selectedDateFormatted}</strong>
                                    </div>
                                    <div class="btn-group">
                                        <input
                                            type="date"
                                            class="form-control"
                                            value="${selectedDate}"
                                            onchange="window.location.href='/admin/attendance?filter=' + this.value"
                                        />
                                        <button class="btn btn-outline-primary" onclick="window.location.reload()">
                                            <i class="fas fa-sync me-1"></i>Làm mới
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover" id="attendanceTable">
                                        <thead class="table-dark">
                                            <tr>
                                                <th><i class="fas fa-hashtag me-1"></i>ID</th>
                                                <th><i class="fas fa-user me-1"></i>Nhân viên</th>
                                                <th><i class="fas fa-building me-1"></i>Phòng ban</th>
                                                <th><i class="fas fa-sign-in-alt me-1"></i>Giờ vào</th>
                                                <th><i class="fas fa-sign-out-alt me-1"></i>Giờ ra</th>
                                                <th><i class="fas fa-info-circle me-1"></i>Trạng thái</th>
                                                <th><i class="fas fa-cogs me-1"></i>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="attendance" items="${attendances}">
                                                <tr>
                                                    <td>
                                                        <span class="badge bg-secondary">${attendance.id}</span>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <i class="fas fa-user text-primary me-2"></i>
                                                            <strong>${attendance.employee.fullName}</strong>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty attendance.employee.department}">
                                                                <span class="badge bg-info">
                                                                    <i class="fas fa-building me-1"></i>
                                                                    ${attendance.employee.department.name}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa phân phòng</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty attendance.checkIn}">
                                                                <span class="badge bg-primary">
                                                                    <i class="fas fa-clock me-1"></i>
                                                                    ${attendance.checkIn}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa vào</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty attendance.checkOut}">
                                                                <span class="badge bg-secondary">
                                                                    <i class="fas fa-clock me-1"></i>
                                                                    ${attendance.checkOut}
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-warning">Chưa ra</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${attendance.status.name() == 'present'}">
                                                                <span class="badge bg-success">
                                                                    <i class="fas fa-check me-1"></i>Đúng giờ
                                                                </span>
                                                            </c:when>
                                                            <c:when test="${attendance.status.name() == 'late'}">
                                                                <span class="badge bg-warning">
                                                                    <i class="fas fa-clock me-1"></i>Đi trễ
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger">
                                                                    <i class="fas fa-times me-1"></i>Vắng mặt
                                                                </span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a
                                                                href="/admin/attendance/detail/${attendance.id}"
                                                                class="btn btn-outline-info btn-sm"
                                                                title="Chi tiết"
                                                            >
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty attendances}">
                                                <tr>
                                                    <td colspan="7" class="text-center py-5">
                                                        <div class="d-flex flex-column align-items-center">
                                                            <i class="fas fa-clock fa-4x text-muted mb-3"></i>
                                                            <h5 class="text-muted mb-2">
                                                                Chưa có ai chấm công hôm nay
                                                            </h5>
                                                            <p class="text-muted mb-0">
                                                                Dữ liệu chấm công sẽ hiển thị khi nhân viên bắt đầu chấm
                                                                công
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
