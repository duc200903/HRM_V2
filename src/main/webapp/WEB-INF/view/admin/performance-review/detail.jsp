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
        <title>Chi tiết đánh giá hiệu suất - HRM System</title>
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
                        <h1 class="mt-4">Chi tiết đánh giá hiệu suất</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/performance-review">Đánh giá hiệu suất</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <div class="card shadow border-0">
                                    <div class="card-header bg-primary text-white">
                                        <h5 class="mb-0">
                                            <i class="fas fa-star me-2"></i>Đánh giá hiệu suất #${review.id}
                                        </h5>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <h6 class="text-muted">Thông tin nhân viên</h6>
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td width="40%"><strong>Nhân viên:</strong></td>
                                                        <td>
                                                            <i class="fas fa-user text-primary me-1"></i>
                                                            <strong>${review.employee.fullName}</strong>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Phòng ban:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty review.employee.department}">
                                                                    <span class="badge bg-success">
                                                                        <i class="fas fa-building me-1"></i
                                                                        >${review.employee.department.name}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa phân phòng ban</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Chức vụ:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty review.employee.position}">
                                                                    <span class="badge bg-info">
                                                                        <i class="fas fa-briefcase me-1"></i
                                                                        >${review.employee.position}
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
                                                <h6 class="text-muted">Thông tin đánh giá</h6>
                                                <table class="table table-borderless">
                                                    <tr>
                                                        <td width="40%"><strong>Kỳ đánh giá:</strong></td>
                                                        <td>${review.period}</td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Điểm số:</strong></td>
                                                        <td>
                                                            <span
                                                                class="badge bg-${review.score >= 80 ? 'success' : (review.score >= 50 ? 'warning' : 'danger')}"
                                                            >
                                                                <i class="fas fa-star me-1"></i>${review.score}
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Người đánh giá:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty review.reviewer}">
                                                                    <i class="fas fa-user-tie text-info me-1"></i>
                                                                    ${review.reviewer.username}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Thời gian đánh giá:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty formattedReviewedAt}">
                                                                    ${formattedReviewedAt}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa cập nhật</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td><strong>Nhận xét:</strong></td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty review.comments}">
                                                                    <span>${review.comments}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Không có nhận xét</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-footer bg-light d-flex justify-content-end">
                                        <a href="/admin/performance-review" class="btn btn-secondary">
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
