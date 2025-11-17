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
        <title>Xóa đánh giá hiệu suất - HRM System</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="/WEB-INF/view/layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Quản lý đánh giá hiệu suất</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/performance-review">Đánh giá hiệu suất</a>
                            </li>
                            <li class="breadcrumb-item active">Xóa</li>
                        </ol>

                        <div class="mt-4 w-50 mx-auto">
                            <div class="card border-danger">
                                <div class="card-header bg-danger text-white">
                                    <h5 class="mb-0">
                                        <i class="fas fa-exclamation-triangle me-2"></i>Xác nhận xóa đánh giá hiệu suất
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <div class="alert alert-warning">
                                        <h6>
                                            <i class="fas fa-warning me-2"></i>Bạn có chắc chắn muốn xóa đánh giá hiệu
                                            suất này?
                                        </h6>
                                        <hr />
                                        <p><strong>ID:</strong> ${review.id}</p>
                                        <p><strong>Nhân viên:</strong> ${review.employee.fullName}</p>
                                        <p><strong>Kỳ đánh giá:</strong> ${review.period}</p>
                                        <p><strong>Điểm số:</strong> ${review.score}</p>
                                        <c:if test="${not empty review.reviewer}">
                                            <p>
                                                <strong>Người đánh giá:</strong>
                                                ${review.reviewer.username}
                                            </p>
                                        </c:if>
                                        <p class="mb-0 text-danger">
                                            <small
                                                ><i class="fas fa-info-circle me-1"></i>Hành động này không thể hoàn
                                                tác!</small
                                            >
                                        </p>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center">
                                        <form method="post" action="/admin/performance-review/delete/${review.id}">
                                            <button type="submit" class="btn btn-danger">
                                                <i class="fas fa-trash me-1"></i>Xác nhận xóa
                                            </button>
                                        </form>

                                        <a href="/admin/performance-review" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-1"></i>Hủy bỏ
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
