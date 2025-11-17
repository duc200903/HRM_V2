<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <title>Đăng nhập hệ thống</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

        <style>
            body {
                background: linear-gradient(135deg, #74b9ff, #a29bfe);
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', sans-serif;
            }

            .login-card {
                background: white;
                border-radius: 16px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                padding: 40px 30px;
                width: 420px;
            }

            .form-control:focus {
                box-shadow: 0 0 0 0.25rem rgba(41, 128, 185, 0.25);
                border-color: #2980b9;
            }

            .btn-primary {
                background-color: #2980b9;
                border: none;
            }
            .btn-primary:hover {
                background-color: #21618c;
            }

            .text-muted a {
                text-decoration: none;
                color: #2980b9;
            }
            .text-muted a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <div class="login-card">
            <h3 class="text-center mb-4 text-primary">Đăng Nhập</h3>
            <c:if test="${param.error != null}">
                <div class="alert alert-danger">Sai email hoặc mật khẩu</div>
            </c:if>

            <c:if test="${param.logout != null}">
                <div class="alert alert-success">Bạn đã đăng xuất thành công</div>
            </c:if>

            <form action="<c:url value='/login'/>" method="post">
                <div class="mb-3">
                    <label>Email:</label>
                    <input type="text" name="username" class="form-control mt-2" placeholder="Nhập email của bạn" />
                </div>
                <div class="mb-3">
                    <label>Mật khẩu:</label>
                    <input
                        type="password"
                        name="password"
                        class="form-control mt-2"
                        placeholder="Nhập mật khẩu của bạn"
                    />
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-2 mt-3">Đăng nhập</button>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
