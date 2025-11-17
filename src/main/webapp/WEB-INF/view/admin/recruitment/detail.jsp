<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%> <%@
taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <title>Chi tiết tin tuyển dụng - HRM System</title>
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
                        <h1 class="mt-4">Chi tiết tin tuyển dụng</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/recruitment">Tuyển dụng</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="card shadow border-0">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0">
                                            <i class="fas fa-briefcase me-2"></i>Tin tuyển dụng #${recruitment.id}
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h6 class="text-muted">Thông tin tuyển dụng</h6>
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td width="40%"><strong>Vị trí:</strong></td>
                                                        <td><strong>${recruitment.title}</strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Phòng ban:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty recruitment.department}">
                                                                    <span class="badge bg-info">
                                                                        <i class="fas fa-building me-1"></i
                                                                        >${recruitment.department.name}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa phân phòng</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Trạng thái:</strong></td>
                                                        <td>
                                                            <span
                                                                class="badge bg-${recruitment.status.name() == 'open' ? 'success' : 'secondary'}"
                                                            >
                                                                ${recruitment.status.name() == 'open' ? 'Đang mở' : 'Đã
                                                                đóng'}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Ngày bắt đầu:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty recruitment.startDate}">
                                                                    <c:out value="${formattedStartDate}" />
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa cập nhật</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Ngày kết thúc:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty recruitment.endDate}">
                                                                    <c:out value="${formattedEndDate}" />
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
                                                            <c:choose>
                                                                <c:when test="${not empty recruitment.createdAt}">
                                                                    <c:out value="${formattedCreatedAt}" />
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
                                                <h6 class="text-muted">Mô tả công việc</h6>
                                                <div class="border rounded p-3 bg-light" style="min-height: 120px">
                                                    <c:choose>
                                                        <c:when test="${not empty recruitment.description}">
                                                            ${recruitment.description}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Chưa có mô tả</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="mt-3">
                                                    <span class="badge bg-primary">
                                                        <i class="fas fa-users me-1"></i>
                                                        ${recruitment.applicants.size()} ứng viên
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <h6 class="text-muted mt-3">Danh sách ứng viên</h6>
                                        <div class="table-responsive">
                                            <table class="table table-bordered">
                                                <thead class="table-light">
                                                    <tr>
                                                        <th>#</th>
                                                        <th>Họ tên</th>
                                                        <th>Email</th>
                                                        <th>Trạng thái</th>
                                                        <th>Ngày ứng tuyển</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach
                                                        var="app"
                                                        items="${recruitment.applicants}"
                                                        varStatus="status"
                                                    >
                                                        <tr>
                                                            <td>${status.index + 1}</td>
                                                            <td>${app.name}</td>
                                                            <td>${app.email}</td>
                                                            <td>
                                                                <span
                                                                    class="badge bg-${app.status.name() == 'hired' ? 'success' : (app.status.name() == 'rejected' ? 'danger' : 'secondary')}"
                                                                >
                                                                    ${app.status.name() == 'hired' ? 'Đã nhận' :
                                                                    (app.status.name() == 'rejected' ? 'Từ chối' :
                                                                    (app.status.name() == 'interview' ? 'Phỏng vấn' :
                                                                    'Đang xét'))}
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty app.formattedAppliedAt}">
                                                                        ${app.formattedAppliedAt}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa cập nhật</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                    <c:if test="${empty recruitment.applicants}">
                                                        <tr>
                                                            <td colspan="5" class="text-center text-muted">
                                                                Chưa có ứng viên nào
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-light d-flex justify-content-end">
                                        <a href="/admin/recruitment" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-1"></i>Quay lại
                                        </a>
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
