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
        <title>Chi tiết khóa đào tạo - HRM System</title>
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
                        <h1 class="mt-4">Quản lý đào tạo</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/training">Đào tạo</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>

                        <div class="mt-4">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-graduation-cap me-2"></i>Chi tiết khóa đào tạo
                                                #${training.id}
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h6 class="text-muted">Thông tin khóa đào tạo</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="20%"><strong>ID:</strong></td>
                                                            <td>
                                                                <span class="badge bg-secondary">${training.id}</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Tên khóa học:</strong></td>
                                                            <td><h6 class="mb-0">${training.title}</h6></td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Mô tả:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty training.description}">
                                                                        <p class="mb-0">${training.description}</p>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có mô tả</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Ngày bắt đầu:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty training.startDate}">
                                                                        <i
                                                                            class="fas fa-calendar-alt text-muted me-1"
                                                                        ></i>
                                                                        ${training.startDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa xác định</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Ngày kết thúc:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty training.endDate}">
                                                                        <i
                                                                            class="fas fa-calendar-check text-muted me-1"
                                                                        ></i>
                                                                        ${training.endDate}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa xác định</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Link khóa học:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty training.link}">
                                                                        <a
                                                                            href="${training.link}"
                                                                            target="_blank"
                                                                            class="btn btn-outline-primary btn-sm"
                                                                        >
                                                                            <i
                                                                                class="fas fa-external-link-alt me-1"
                                                                            ></i>
                                                                            Truy cập khóa học
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có link</span>
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
                                                <a href="/admin/training/update/${training.id}" class="btn btn-warning">
                                                    <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                                </a>
                                                <a
                                                    href="/admin/training/delete/${training.id}"
                                                    class="btn btn-outline-danger"
                                                >
                                                    <i class="fas fa-trash me-1"></i>Xóa khóa đào tạo
                                                </a>
                                                <a href="/admin/training" class="btn btn-secondary">
                                                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Statistics Card -->
                                    <div class="card mt-3">
                                        <div class="card-header">
                                            <h6 class="mb-0"><i class="fas fa-chart-bar me-1"></i>Thống kê</h6>
                                        </div>
                                        <div class="card-body">
                                            <div class="text-center">
                                                <h4 class="text-primary">${totalParticipants}</h4>
                                                <p class="text-muted mb-0">Nhân viên tham gia</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Participants Table -->
                            <c:if test="${not empty employeeTrainings}">
                                <div class="row mt-4">
                                    <div class="col-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h6 class="mb-0">
                                                    <i class="fas fa-users me-1"></i>Danh sách nhân viên tham gia
                                                </h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="table-responsive">
                                                    <table class="table table-striped table-hover">
                                                        <thead class="table-dark">
                                                            <tr>
                                                                <th><i class="fas fa-hashtag me-1"></i>STT</th>
                                                                <th><i class="fas fa-user me-1"></i>Nhân viên</th>
                                                                <th><i class="fas fa-building me-1"></i>Phòng ban</th>
                                                                <th><i class="fas fa-briefcase me-1"></i>Chức vụ</th>
                                                                <th><i class="fas fa-trophy me-1"></i>Kết quả</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach
                                                                var="employeeTraining"
                                                                items="${employeeTrainings}"
                                                                varStatus="status"
                                                            >
                                                                <tr>
                                                                    <td>
                                                                        <span class="badge bg-secondary"
                                                                            >${status.index + 1}</span
                                                                        >
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex align-items-center">
                                                                            <i
                                                                                class="fas fa-user text-primary me-2"
                                                                            ></i>
                                                                            <strong
                                                                                >${employeeTraining.employee.fullName}</strong
                                                                            >
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty employeeTraining.employee.department}"
                                                                            >
                                                                                <span class="badge bg-success">
                                                                                    <i class="fas fa-building me-1"></i>
                                                                                    ${employeeTraining.employee.department.name}
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted"
                                                                                    >Chưa phân phòng ban</span
                                                                                >
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty employeeTraining.employee.position}"
                                                                            >
                                                                                <span class="badge bg-info">
                                                                                    <i
                                                                                        class="fas fa-briefcase me-1"
                                                                                    ></i>
                                                                                    ${employeeTraining.employee.position}
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted"
                                                                                    >Chưa có chức vụ</span
                                                                                >
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty employeeTraining.result}"
                                                                            >
                                                                                <span class="badge bg-primary">
                                                                                    <i class="fas fa-trophy me-1"></i>
                                                                                    ${employeeTraining.result}
                                                                                </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="text-muted"
                                                                                    >Chưa có kết quả</span
                                                                                >
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
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
