<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <title>404 - Không tìm thấy trang</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            body {
                background: linear-gradient(135deg, #141e30, #243b55);
                color: #fff;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
                flex-direction: column;
                font-family: 'Segoe UI', sans-serif;
                text-align: center;
            }
            h1 {
                font-size: 6rem;
                font-weight: 700;
                color: #ffc107;
            }
            p {
                font-size: 1.3rem;
                margin-bottom: 1.5rem;
            }
            a {
                color: #fff;
                background-color: #0d6efd;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s;
            }
            a:hover {
                background-color: #0b5ed7;
                transform: translateY(-2px);
            }
            .icon {
                font-size: 4rem;
                margin-bottom: 1rem;
            }
        </style>
    </head>
    <body>
        <div>
            <div class="icon">🔍</div>
            <h1>404</h1>
            <p>Trang bạn đang tìm kiếm không tồn tại.</p>
            <a href="/admin/dashboard">⬅ Quay lại Dashboard</a>
        </div>
    </body>
</html>
