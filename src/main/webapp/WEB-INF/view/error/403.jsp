<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <title>403 - Truy cập bị từ chối</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
        <style>
            body {
                background: linear-gradient(135deg, #1e3c72, #2a5298);
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
                margin-bottom: 0.5rem;
            }
            p {
                font-size: 1.3rem;
                margin-bottom: 1.5rem;
            }
            a {
                color: #fff;
                background-color: #198754;
                padding: 10px 20px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s;
            }
            a:hover {
                background-color: #157347;
                transform: translateY(-2px);
            }
            .icon {
                font-size: 4rem;
                margin-bottom: 1rem;
                color: #ffc107;
            }
        </style>
    </head>
    <body>
        <div>
            <div class="icon">🚫</div>
            <h1>403</h1>
            <p>Bạn không có quyền truy cập vào chức năng này.</p>
            <a href="/admin/dashboard">⬅ Quay lại Dashboard</a>
        </div>
    </body>
</html>
