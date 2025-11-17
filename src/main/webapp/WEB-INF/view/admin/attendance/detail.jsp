<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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
        <title>Chi tiết chấm công - HRM System</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
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
                            <li class="breadcrumb-item">
                                <a href="/admin/attendance">Chấm công</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>

                        <div class="mt-4">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-clock me-2"></i>Chi tiết chấm công #${attendance.id}
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Thông tin nhân viên</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="35%"><strong>ID:</strong></td>
                                                            <td>
                                                                <span class="badge bg-secondary">${attendance.id}</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Họ và tên:</strong></td>
                                                            <td>
                                                                <div class="d-flex align-items-center">
                                                                    <i class="fas fa-user text-primary me-2"></i>
                                                                    <strong>${attendance.employee.fullName}</strong>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Phòng ban:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty attendance.employee.department}"
                                                                    >
                                                                        <span class="badge bg-info">
                                                                            <i class="fas fa-building me-1"></i>
                                                                            ${attendance.employee.department.name}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted"
                                                                            >Chưa phân phòng ban</span
                                                                        >
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Email:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty attendance.employee.user && not empty attendance.employee.user.email}"
                                                                    >
                                                                        <span class="badge bg-primary">
                                                                            <i class="fas fa-envelope me-1"></i>
                                                                            <a
                                                                                href="mailto:${attendance.employee.user.email}"
                                                                                class="text-white text-decoration-none"
                                                                            >
                                                                                ${attendance.employee.user.email}
                                                                            </a>
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có email</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Chức vụ:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty attendance.employee.position}"
                                                                    >
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-briefcase me-1"></i>
                                                                            ${attendance.employee.position}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có chức vụ</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Chi tiết chấm công</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="35%"><strong>Ngày:</strong></td>
                                                            <td>
                                                                <span class="badge bg-primary">
                                                                    <i class="fas fa-calendar me-1"></i>
                                                                    ${attendance.date}
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Giờ vào:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty attendance.checkIn}">
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-sign-in-alt me-1"></i>
                                                                            ${attendance.checkIn}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted"
                                                                            >Chưa chấm công vào</span
                                                                        >
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Giờ ra:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty attendance.checkOut}">
                                                                        <span class="badge bg-secondary">
                                                                            <i class="fas fa-sign-out-alt me-1"></i>
                                                                            ${attendance.checkOut}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-warning"
                                                                            >Chưa chấm công ra</span
                                                                        >
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Trạng thái:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${attendance.status.name() == 'present'}"
                                                                    >
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-check me-1"></i>Đúng giờ
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${attendance.status.name() == 'late'}"
                                                                    >
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
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <h6 class="mb-0"><i class="fas fa-cogs me-1"></i>Thao tác</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="d-grid gap-2">
                                                <a href="/admin/attendance" class="btn btn-secondary">
                                                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
