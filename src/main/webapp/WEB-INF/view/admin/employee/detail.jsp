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
        <title>Chi tiết nhân viên - HRM System</title>
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
                        <h1 class="mt-4">Quản lý nhân viên</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/employee">Nhân viên</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>

                        <div class="mt-4">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-user me-2"></i>Thông tin nhân viên #${employee.id}
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Thông tin cá nhân</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="35%"><strong>ID:</strong></td>
                                                            <td>
                                                                <span class="badge bg-secondary">${employee.id}</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Họ và tên:</strong></td>
                                                            <td>${employee.fullName}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Email:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${not empty employee.user && not empty employee.user.email}"
                                                                    >
                                                                        <i class="fas fa-envelope text-muted me-1"></i>
                                                                        <a
                                                                            href="mailto:${employee.user.email}"
                                                                            class="text-decoration-none"
                                                                        >
                                                                            ${employee.user.email}
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có email</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Số điện thoại:</strong></td>
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
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Địa chỉ:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty employee.address}">
                                                                        <i
                                                                            class="fas fa-map-marker-alt text-muted me-1"
                                                                        ></i>
                                                                        ${employee.address}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa cập nhật</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Ngày sinh:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty employee.dob}">
                                                                        <i
                                                                            class="fas fa-birthday-cake text-muted me-1"
                                                                        ></i>
                                                                        ${employee.formattedDob}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa cập nhật</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Thông tin công việc</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="35%"><strong>Chức vụ:</strong></td>
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
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Phòng ban:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty employee.department}">
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-building me-1"></i
                                                                            >${employee.department.name}
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
                                                            <td><strong>Ngày vào làm:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty employee.hireDate}">
                                                                        <i
                                                                            class="fas fa-calendar-plus text-muted me-1"
                                                                        ></i>
                                                                        ${employee.formattedHireDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa cập nhật</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Ngày tạo:</strong></td>
                                                            <td>
                                                                <small class="text-muted"
                                                                    >${employee.formattedCreatedAt}</small
                                                                >
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Thâm niên:</strong></td>
                                                            <td>
                                                                <span class="badge bg-warning text-dark">
                                                                    <i class="fas fa-medal me-1"></i>
                                                                    ${employee.yearsOfService} năm
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Mã nhân viên:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty employee.employeeCode}">
                                                                        <span class="badge bg-dark">
                                                                            <i class="fas fa-id-badge me-1"></i>
                                                                            ${employee.employeeCode}
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có mã</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Cập nhật cuối:</strong></td>
                                                            <td>
                                                                <small class="text-muted"
                                                                    >${employee.formattedUpdatedAt}</small
                                                                >
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--  SALARY AND BENEFITS SECTION -->
                                    <div class="card mt-4">
                                        <div class="card-header bg-success text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-money-bill-wave me-2"></i>Thông tin lương và phúc lợi
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <!-- Salary Information -->
                                                <div class="col-md-6">
                                                    <h6 class="text-success">
                                                        <i class="fas fa-dollar-sign me-1"></i>Thu nhập
                                                    </h6>
                                                    <table class="table table-borderless table-sm">
                                                        <tr>
                                                            <td width="50%"><strong>Lương cơ bản:</strong></td>
                                                            <td class="text-end">
                                                                <span class="text-primary fw-bold">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${employee.baseSalary != null && employee.baseSalary > 0}"
                                                                        >
                                                                            ${String.format("%,.0f",
                                                                            employee.baseSalary)} VNĐ
                                                                        </c:when>
                                                                        <c:otherwise>0 VNĐ</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>PC Tiền ăn:</strong></td>
                                                            <td class="text-end">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${employee.allowanceMeal != null && employee.allowanceMeal > 0}"
                                                                    >
                                                                        ${String.format("%,.0f",
                                                                        employee.allowanceMeal)} VNĐ
                                                                    </c:when>
                                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>PC Tiền xe:</strong></td>
                                                            <td class="text-end">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${employee.allowanceTransport != null && employee.allowanceTransport > 0}"
                                                                    >
                                                                        ${String.format("%,.0f",
                                                                        employee.allowanceTransport)} VNĐ
                                                                    </c:when>
                                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>PC Thâm niên:</strong></td>
                                                            <td class="text-end">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${employee.allowanceSeniority != null && employee.allowanceSeniority > 0}"
                                                                    >
                                                                        ${String.format("%,.0f",
                                                                        employee.allowanceSeniority)} VNĐ
                                                                    </c:when>
                                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr class="border-top">
                                                            <td><strong>Tổng thu nhập:</strong></td>
                                                            <td class="text-end">
                                                                <span class="badge bg-success fs-6">
                                                                    ${String.format("%,.0f", employee.totalSalary)} VNĐ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>

                                                <!-- Deductions -->
                                                <div class="col-md-6">
                                                    <h6 class="text-danger">
                                                        <i class="fas fa-minus-circle me-1"></i>Khấu trừ
                                                    </h6>
                                                    <table class="table table-borderless table-sm">
                                                        <tr>
                                                            <td width="50%"><strong>Bảo hiểm y tế:</strong></td>
                                                            <td class="text-end">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${employee.insuranceHealth != null && employee.insuranceHealth > 0}"
                                                                    >
                                                                        ${String.format("%,.0f",
                                                                        employee.insuranceHealth)} VNĐ
                                                                    </c:when>
                                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Bảo hiểm xã hội:</strong></td>
                                                            <td class="text-end">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${employee.insuranceSocial != null && employee.insuranceSocial > 0}"
                                                                    >
                                                                        ${String.format("%,.0f",
                                                                        employee.insuranceSocial)} VNĐ
                                                                    </c:when>
                                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr class="border-top">
                                                            <td><strong>Tổng khấu trừ:</strong></td>
                                                            <td class="text-end">
                                                                <span class="badge bg-danger fs-6">
                                                                    ${String.format("%,.0f", employee.totalInsurance)}
                                                                    VNĐ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                        <tr class="border-top">
                                                            <td><strong class="text-success">Thực lãnh:</strong></td>
                                                            <td class="text-end">
                                                                <span class="badge bg-warning text-dark fs-5">
                                                                    <i class="fas fa-hand-holding-usd me-1"></i>
                                                                    ${String.format("%,.0f", employee.netSalary)} VNĐ
                                                                </span>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!--  ADDITIONAL INFO SECTION -->
                                    <div class="card mt-4">
                                        <div class="card-header bg-info text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-info-circle me-2"></i>Thông tin bổ sung
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6 class="text-info">Thời gian làm việc</h6>
                                                    <div class="alert alert-info">
                                                        <h6>
                                                            <i class="fas fa-calendar-alt me-1"></i>Chi tiết thâm niên:
                                                        </h6>
                                                        <p class="mb-1">
                                                            <strong>${employee.detailedWorkingTime}</strong>
                                                        </p>
                                                        <small class="text-muted">
                                                            <i class="fas fa-info-circle me-1"></i>
                                                            Tổng: ${employee.totalWorkingDays} ngày
                                                            (${employee.totalWorkingMonths} tháng)
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="text-info">Nghỉ phép</h6>
                                                    <div class="alert alert-warning">
                                                        <h6>
                                                            <i class="fas fa-calendar-times me-1"></i>Số ngày phép còn
                                                            lại:
                                                        </h6>
                                                        <div class="d-flex align-items-center">
                                                            <span class="badge bg-warning text-dark fs-4 me-2">
                                                                ${employee.remainingLeaveDays != null ?
                                                                employee.remainingLeaveDays : 0}
                                                            </span>
                                                            <span>ngày trong năm nay</span>
                                                        </div>
                                                        <small class="text-muted mt-2 d-block">
                                                            <i class="fas fa-info-circle me-1"></i>
                                                            Được cập nhật theo chính sách công ty
                                                        </small>
                                                    </div>
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
                                                <a href="/admin/employee/update/${employee.id}" class="btn btn-warning">
                                                    <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                                </a>
                                                <a
                                                    href="/admin/employee/delete/${employee.id}"
                                                    class="btn btn-outline-danger"
                                                >
                                                    <i class="fas fa-trash me-1"></i>Xóa nhân viên
                                                </a>
                                                <a href="/admin/employee" class="btn btn-secondary">
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
