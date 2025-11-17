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
        <title>Chi tiết phòng ban - HRM System</title>
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
                        <h1 class="mt-4">Quản lý phòng ban</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/department">Phòng ban</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>

                        <div class="mt-4">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="card">
                                        <div class="card-header bg-primary text-white">
                                            <h5 class="mb-0">
                                                <i class="fas fa-building me-2"></i>Thông tin phòng ban
                                                #${department.id}
                                            </h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Thông tin cơ bản</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="30%"><strong>ID:</strong></td>
                                                            <td>
                                                                <span class="badge bg-secondary">${department.id}</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Tên phòng ban:</strong></td>
                                                            <td>${department.name}</td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Mô tả:</strong></td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${not empty department.description}">
                                                                        ${department.description}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">Chưa có mô tả</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div class="col-md-6">
                                                    <h6 class="text-muted">Thời gian</h6>
                                                    <table class="table table-borderless">
                                                        <tr>
                                                            <td width="40%"><strong>Ngày tạo:</strong></td>
                                                            <td>
                                                                <small class="text-muted"
                                                                    >${department.formattedCreatedAt}</small
                                                                >
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><strong>Cập nhật cuối:</strong></td>
                                                            <td>
                                                                <small class="text-muted"
                                                                    >${department.formattedUpdatedAt}</small
                                                                >
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
                                                <a
                                                    href="/admin/department/update/${department.id}"
                                                    class="btn btn-warning"
                                                >
                                                    <i class="fas fa-edit me-1"></i>Chỉnh sửa
                                                </a>
                                                <a
                                                    href="/admin/department/delete/${department.id}"
                                                    class="btn btn-outline-danger"
                                                >
                                                    <i class="fas fa-trash me-1"></i>Xóa phòng ban
                                                </a>
                                                <a href="/admin/department" class="btn btn-secondary">
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
