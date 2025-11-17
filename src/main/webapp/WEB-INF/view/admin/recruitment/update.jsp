<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <title>Chỉnh sửa tin tuyển dụng - HRM System</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="/WEB-INF/view/layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4 mb-4 text-center text-primary fw-bold">Chỉnh sửa tin tuyển dụng</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/recruitment">Tuyển dụng</a>
                            </li>
                            <li class="breadcrumb-item active">Chỉnh sửa</li>
                        </ol>
                        <div class="row justify-content-center">
                            <div class="col-lg-7 col-md-9">
                                <div class="card shadow border-0">
                                    <div class="card-header bg-warning text-white">
                                        <h5 class="mb-0"><i class="fas fa-edit me-2"></i>Chỉnh sửa tin tuyển dụng</h5>
                                    </div>
                                    <div class="card-body p-4">
                                        <form:form
                                            method="post"
                                            action="/admin/recruitment/update"
                                            modelAttribute="recruitment"
                                            class="row g-3"
                                        >
                                            <form:hidden path="id" />
                                            <div class="col-md-6">
                                                <label for="title" class="form-label">Vị trí tuyển dụng *</label>
                                                <form:input path="title" cssClass="form-control" required="true" />
                                            </div>
                                            <div class="col-md-6">
                                                <label for="department" class="form-label">Phòng ban *</label>
                                                <form:select
                                                    path="department.id"
                                                    cssClass="form-select"
                                                    required="true"
                                                >
                                                    <form:options
                                                        items="${departments}"
                                                        itemValue="id"
                                                        itemLabel="name"
                                                    />
                                                </form:select>
                                            </div>
                                            <div class="col-md-12">
                                                <label for="description" class="form-label">Mô tả công việc</label>
                                                <form:textarea path="description" cssClass="form-control" rows="3" />
                                            </div>
                                            <div class="col-md-6">
                                                <label for="status" class="form-label">Trạng thái</label>
                                                <form:select path="status" cssClass="form-select">
                                                    <form:option value="open">Đang mở</form:option>
                                                    <form:option value="closed">Đã đóng</form:option>
                                                </form:select>
                                            </div>
                                            <div class="col-md-3">
                                                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                                <form:input path="startDate" type="date" cssClass="form-control" />
                                            </div>
                                            <div class="col-md-3">
                                                <label for="endDate" class="form-label">Ngày kết thúc</label>
                                                <form:input path="endDate" type="date" cssClass="form-control" />
                                            </div>
                                            <div class="col-12 mt-3 d-flex gap-2">
                                                <button type="submit" class="btn btn-warning px-4">
                                                    <i class="fas fa-save me-1"></i>Cập nhật tin tuyển dụng
                                                </button>
                                                <a href="/admin/recruitment" class="btn btn-secondary px-4">
                                                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                                                </a>
                                            </div>
                                        </form:form>
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
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
