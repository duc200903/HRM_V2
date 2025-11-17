<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> <%
org.springframework.security.core.Authentication auth =
org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication(); String email =
auth.getName(); %>

<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">
                <!-- BẢNG ĐIỀU KHIỂN -->
                <div class="sb-sidenav-menu-heading">BẢNG ĐIỀU KHIỂN</div>
                <a class="nav-link" href="/admin/dashboard">
                    <div class="sb-nav-link-icon">
                        <i class="fas fa-tachometer-alt"></i>
                    </div>
                    Tổng quan
                </a>

                <!-- QUẢN LÝ HỆ THỐNG (Chỉ ADMIN) -->
                <sec:authorize access="hasRole('ADMIN')">
                    <div class="sb-sidenav-menu-heading">QUẢN LÝ HỆ THỐNG</div>

                    <a class="nav-link" href="/admin/user">
                        <div class="sb-nav-link-icon"><i class="fas fa-users-cog"></i></div>
                        Quản lý admin
                    </a>

                    <a class="nav-link" href="/admin/department">
                        <div class="sb-nav-link-icon"><i class="fas fa-building"></i></div>
                        Quản lý phòng ban
                    </a>
                </sec:authorize>
                <!-- Quản lý nhân viên (HR + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR', 'MANAGER')">
                    <a class="nav-link" href="/admin/employee">
                        <div class="sb-nav-link-icon"><i class="fas fa-user-tie"></i></div>
                        Quản lý nhân viên
                    </a>

                    <a class="nav-link" href="/admin/department-transfer">
                        <div class="sb-nav-link-icon"><i class="fas fa-exchange-alt"></i></div>
                        Lịch sử chuyển phòng ban
                    </a>
                </sec:authorize>
                <!-- Quản lý nghỉ phép (ADMIN) -->
                <sec:authorize access="hasRole('ADMIN')">
                    <a class="nav-link" href="/admin/request-leave">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        Quản lý nghỉ phép
                    </a>
                </sec:authorize>
                <!-- Quản lý đào tạo (HR + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR')">
                    <a class="nav-link" href="/admin/training">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-chalkboard-teacher"></i>
                        </div>
                        Quản lý đào tạo
                    </a>
                </sec:authorize>

                <!-- BÁO CÁO & THỐNG KÊ -->
                <div class="sb-sidenav-menu-heading">BÁO CÁO & THỐNG KÊ</div>

                <!-- Chấm công (HR + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR')">
                    <a class="nav-link" href="/admin/attendance">
                        <div class="sb-nav-link-icon"><i class="fas fa-clock"></i></div>
                        Quản lý chấm công
                    </a>
                </sec:authorize>

                <!-- Lương (HR + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR')">
                    <a class="nav-link" href="/admin/salary-report">
                        <div class="sb-nav-link-icon">
                            <i class="fas fa-money-bill"></i>
                        </div>
                        Quản lý lương
                    </a>
                </sec:authorize>

                <!-- Hiệu suất (MANAGER + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
                    <a class="nav-link" href="/admin/performance-review">
                        <div class="sb-nav-link-icon"><i class="fas fa-trophy"></i></div>
                        Quản lý hiệu suất
                    </a>
                </sec:authorize>

                <!-- Tuyển dụng (HR + ADMIN) -->
                <sec:authorize access="hasAnyRole('ADMIN','HR')">
                    <a class="nav-link" href="/admin/recruitment">
                        <div class="sb-nav-link-icon"><i class="fas fa-user-plus"></i></div>
                        Quản lý tuyển dụng
                    </a>
                </sec:authorize>

                <!-- Điều hướng -->
                <div class="sb-sidenav-menu-heading">ĐIỀU HƯỚNG</div>
                <a class="nav-link" href="/home">
                    <div class="sb-nav-link-icon"><i class="fas fa-home"></i></div>
                    Về trang chủ
                </a>

                <!-- Đăng xuất -->
                <form action="<c:url value='/logout' />" method="post" class="nav-link p-0 m-0 border-0 bg-transparent">
                    <button type="submit" class="btn w-100 text-start text-danger px-3 py-2">
                        <div class="sb-nav-link-icon d-inline-block me-2">
                            <i class="fas fa-sign-out-alt"></i>
                        </div>
                        Đăng xuất
                    </button>
                </form>
            </div>
        </div>

        <!-- Footer -->
        <div class="sb-sidenav-footer">
            <div class="small">Đăng nhập với:</div>
            <strong><%= email %></strong>
        </div>
    </nav>
</div>
