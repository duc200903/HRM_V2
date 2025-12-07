<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Tạo phòng ban mới - HRM System</title>
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
                            <li class="breadcrumb-item active">Thêm mới</li>
                        </ol>
                        <div class="mt-5 w-50 mx-auto">
                            <h2 class="mb-4">Thêm phòng ban mới</h2>
                            <form:form
                                action="/admin/department/create"
                                method="post"
                                modelAttribute="newDepartment"
                                class="row"
                            >
                                <!--  Name field -->
                                <div class="mb-3 col-12">
                                    <c:set var="errorName">
                                        <form:errors path="name" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label for="name" class="form-label">
                                        <i class="fas fa-building me-1"></i>Tên phòng ban *
                                    </label>
                                    <form:input
                                        type="text"
                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                        id="name"
                                        name="name"
                                        path="name"
                                        placeholder="Nhập tên phòng ban"
                                    />
                                    ${errorName}
                                </div>

                                <!--  Description field -->
                                <div class="mb-3 col-12">
                                    <c:set var="errorDescription">
                                        <form:errors path="description" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label for="description" class="form-label">
                                        <i class="fas fa-align-left me-1"></i>Mô tả
                                    </label>
                                    <form:textarea
                                        class="form-control ${not empty errorDescription ? 'is-invalid' : ''}"
                                        id="description"
                                        name="description"
                                        path="description"
                                        rows="3"
                                        placeholder="Nhập mô tả về phòng ban (tùy chọn)"
                                    />
                                    ${errorDescription}
                                </div>

                                <!--  Info alert -->
                                <div class="col-12 mb-3">
                                    <div class="alert alert-info">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <small
                                            >Các trường có dấu (*) là bắt buộc. ID và thời gian sẽ được tự động
                                            tạo.</small
                                        >
                                    </div>
                                </div>

                                <!--  Action buttons -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-plus me-1"></i>Tạo phòng ban
                                    </button>
                                    <a href="/admin/department" class="btn btn-secondary ms-2">
                                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                                    </a>
                                </div>
                            </form:form>
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
