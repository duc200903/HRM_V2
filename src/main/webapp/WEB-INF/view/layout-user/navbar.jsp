<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%@ taglib
prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/home"> <i class="fas fa-building me-2"></i>HRM System </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="/home"> <i class="fas fa-home me-1"></i>Trang chủ </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/my-attendance"> <i class="fas fa-clock me-1"></i>Chấm công </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/my-leave"> <i class="fas fa-calendar-alt me-1"></i>Nghỉ phép </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/my-salary"> <i class="fas fa-money-bill-wave me-1"></i>Lương thưởng </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/my-training"> <i class="fas fa-graduation-cap me-1"></i>Đào tạo </a>
                </li>

                <!--  Nút quay lại trang quản trị (chỉ ADMIN, HR, MANAGER) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR','MANAGER')">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="/admin/dashboard">
                            <i class="fas fa-tools me-1"></i>Trang quản trị
                        </a>
                    </li>
                </sec:authorize>
            </ul>

            <ul class="navbar-nav">
                <li>
                    <a class="dropdown-item text-danger" href="/logout">
                        <i class="fas fa-sign-out-alt me-2"></i>Đăng xuất
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
