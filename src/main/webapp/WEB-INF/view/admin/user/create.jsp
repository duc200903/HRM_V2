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
        <link
            rel="shortcut icon"
            href="https://p9-sign-sg.tiktokcdn.com/tos-alisg-avt-0068/6d8e3cd4e9b4ca85588b574be866ddfc~tplv-tiktokx-cropcenter:1080:1080.jpeg?dr=14579&refresh_token=24adab12&x-expires=1752980400&x-signature=Kp96fh33zTEkIUAUiYyoP8Mg33Y%3D&t=4d5b0474&ps=13740610&shp=a5d48078&shcp=81f88b70&idc=my"
            type="image/x-icon"
        />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Create User</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script>
            $(document).ready(() => {
                const avatarFile = $('#avatarFile');
                avatarFile.change(function (e) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $('#avatarPreview').attr('src', imgURL);
                    $('#avatarPreview').css({ display: 'block' });
                });
            });
        </script>

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
                        <h1 class="mt-4">Quản lý tài khoản Admin</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/user">Quản lý Admin</a>
                            </li>
                            <li class="breadcrumb-item active">Thêm mới</li>
                        </ol>
                        <div class="mt-5 w-50 mx-auto">
                            <h2 class="mb-4">Tạo tài khoản Admin mới</h2>
                            <form:form action="/admin/user/create" method="post" modelAttribute="newUser" class="row">
                                <!-- ✅ Username field -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="errorUsername">
                                        <form:errors path="username" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label for="username" class="form-label">
                                        <i class="fas fa-user me-1"></i>Tên đăng nhập *
                                    </label>
                                    <form:input
                                        type="text"
                                        class="form-control ${not empty errorUsername ? 'is-invalid' : ''}"
                                        id="username"
                                        name="username"
                                        path="username"
                                        placeholder="Nhập tên đăng nhập"
                                    />
                                    ${errorUsername}
                                </div>

                                <!-- ✅ Email field -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="errorEmail">
                                        <form:errors path="email" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label for="email" class="form-label">
                                        <i class="fas fa-envelope me-1"></i>Email *
                                    </label>
                                    <form:input
                                        type="email"
                                        class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                        id="email"
                                        name="email"
                                        path="email"
                                        placeholder="Nhập địa chỉ email"
                                    />
                                    ${errorEmail}
                                </div>

                                <!-- ✅ Password field -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="errorPasswordHash">
                                        <form:errors path="passwordHash" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label for="passwordHash" class="form-label">
                                        <i class="fas fa-lock me-1"></i>Mật khẩu *
                                    </label>
                                    <form:input
                                        type="password"
                                        class="form-control ${not empty errorPasswordHash ? 'is-invalid' : ''}"
                                        id="passwordHash"
                                        name="passwordHash"
                                        path="passwordHash"
                                        placeholder="Nhập mật khẩu"
                                    />
                                    ${errorPasswordHash}
                                </div>
                                <!-- ✅ Role field - ADMIN ONLY -->
                                <div class="mb-3 col-12 col-md-6">
                                    <c:set var="errorRole">
                                        <form:errors path="role" cssClass="invalid-feedback" />
                                    </c:set>
                                    <label class="form-label"> <i class="fas fa-user-cog me-1"></i>Vai trò </label>
                                    <form:select
                                        class="form-select ${not empty errorRole ? 'is-invalid' : ''}"
                                        path="role"
                                    >
                                        <form:option value="admin">Quản trị viên</form:option>
                                    </form:select>
                                    ${errorRole}
                                </div>
                                <!-- ✅ Info alert -->
                                <div class="col-12 mb-3">
                                    <div class="alert alert-warning">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <small>
                                            <strong>Lưu ý:</strong> Trang này chỉ tạo tài khoản Admin hệ thống. Để tạo
                                            tài khoản nhân viên, vui lòng sử dụng
                                            <a href="/admin/employee/create" class="alert-link">Quản lý nhân viên</a>.
                                        </small>
                                    </div>
                                </div>

                                <!-- ✅ Action buttons -->
                                <div class="col-12">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-user-plus me-1"></i>Tạo tài khoản Admin
                                    </button>
                                    <a href="/admin/user" class="btn btn-secondary ms-2">
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
        <script src="js/scripts.js"></script>
    </body>
</html>
