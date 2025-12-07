<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="vi">
<head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <title>Dashboard HRM - Trang quản trị</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    
    <div id="layoutSidenav">
        <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">
                        <i class="fas fa-tachometer-alt me-2"></i>Dashboard HRM
                    </h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Tổng quan hệ thống</li>
                    </ol>                    <!--  Thống kê chính -->
                    <div class="row">
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-primary text-white mb-4">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="fs-4 fw-bold">${stats.adminUsers}</div>
                                            <div>Tổng quản trị viên</div>
                                        </div>
                                        <i class="fas fa-user-shield fa-3x text-white-50"></i>
                                    </div>
                                </div>
                                <div class="card-footer d-flex align-items-center justify-content-between">
                                    <a class="small text-white stretched-link" href="/admin/user">Xem chi tiết</a>
                                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-warning text-white mb-4">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="fs-4 fw-bold">${stats.totalEmployees}</div>
                                            <div>Tổng nhân viên</div>
                                        </div>
                                        <i class="fas fa-user-tie fa-3x text-white-50"></i>
                                    </div>
                                </div>
                                <div class="card-footer d-flex align-items-center justify-content-between">
                                    <a class="small text-white stretched-link" href="/admin/employee">Xem chi tiết</a>
                                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-success text-white mb-4">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="fs-4 fw-bold">${stats.totalDepartments}</div>
                                            <div>Phòng ban</div>
                                        </div>
                                        <i class="fas fa-building fa-3x text-white-50"></i>
                                    </div>
                                </div>
                                <div class="card-footer d-flex align-items-center justify-content-between">
                                    <a class="small text-white stretched-link" href="/admin/department">Xem chi tiết</a>
                                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-info text-white mb-4">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <div class="fs-4 fw-bold">${stats.pendingLeaveRequests}</div>
                                            <div>Đơn chờ duyệt</div>
                                        </div>
                                        <i class="fas fa-calendar-times fa-3x text-white-50"></i>
                                    </div>
                                </div>
                                <div class="card-footer d-flex align-items-center justify-content-between">
                                    <a class="small text-white stretched-link" href="/admin/request-leave?status=pending">Xem chi tiết</a>
                                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--  Thống kê vai trò -->
                    <div class="row mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                <i class="fas fa-user-shield me-1"></i>Admin
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.adminUsers}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                <i class="fas fa-users-cog me-1"></i>HR
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.hrUsers}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                                <i class="fas fa-user-plus me-1"></i>Manager
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.managerUsers}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                                <i class="fas fa-user me-1"></i>Employee
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">${stats.employeeUsers}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!--  Thống kê chấm công hôm nay -->
                        <div class="col-xl-12">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-clock me-1"></i>Chấm công hôm nay
                                </div>
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-4">
                                            <div class="p-3">
                                                <div class="fs-3 fw-bold text-success">${stats.todayPresent}</div>
                                                <small class="text-muted">Có mặt</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="p-3">
                                                <div class="fs-3 fw-bold text-warning">${stats.todayLate}</div>
                                                <small class="text-muted">Trễ giờ</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="p-3">
                                                <div class="fs-3 fw-bold text-danger">${stats.todayAbsent}</div>
                                                <small class="text-muted">Vắng mặt</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                   
                    <!--  Thống kê phòng ban -->
                    <div class="row">
                        <div class="col-xl-8">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-chart-bar me-1"></i>Nhân viên theo phòng ban
                                </div>
                                <div class="card-body">
                                    <canvas id="departmentChart" width="100%" height="50"></canvas>
                                </div>
                            </div>
                        </div>

                          
                        <div class="col-xl-4">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-list me-1"></i>Truy cập nhanh
                            </div>
                            <div class="card-body">
                                <div class="d-grid gap-2">
                        <!-- ADMIN & HR: thêm nhân viên -->
                        <sec:authorize access="hasAnyRole('ADMIN','HR')">
                            <a href="/admin/employee/create" class="btn btn-success">
                                <i class="fas fa-user-plus me-2"></i>Thêm nhân viên
                            </a>
                        </sec:authorize>

                        <!-- ADMIN: duyệt đơn nghỉ phép -->
                        <sec:authorize access="hasRole('ADMIN')">
                            <a href="/admin/request-leave" class="btn btn-warning">
                                <i class="fas fa-tasks me-2"></i>Duyệt đơn nghỉ phép
                            </a>
                        </sec:authorize>

                        <!-- ADMIN & HR: tính lương -->
                        <sec:authorize access="hasAnyRole('ADMIN','HR')">
                            <a href="/admin/salary-report" class="btn btn-primary">
                                <i class="fas fa-calculator me-2"></i>Tính lương
                            </a>
                        </sec:authorize>

                        <!-- ADMIN & HR: quản lý đào tạo -->
                        <sec:authorize access="hasAnyRole('ADMIN','HR')">
                            <a href="/admin/training" class="btn btn-info">
                                <i class="fas fa-graduation-cap me-2"></i>Quản lý đào tạo
                            </a>
                        </sec:authorize>

                        <!-- MANAGER & ADMIN: đánh giá hiệu suất -->
                        <sec:authorize access="hasAnyRole('ADMIN','MANAGER')">
                            <a href="/admin/performance-review" class="btn btn-secondary">
                                <i class="fas fa-trophy me-2"></i>Đánh giá hiệu suất
                            </a>
                        </sec:authorize>

                        <!-- HR & ADMIN: quản lý tuyển dụng -->
                        <sec:authorize access="hasAnyRole('ADMIN','HR')">
                            <a href="/admin/recruitment" class="btn btn-dark">
                                <i class="fas fa-briefcase me-2"></i>Tuyển dụng
                            </a>
                        </sec:authorize>

                    </div>
                </div>
            </div>
        </div>
                    </div>

                    <!--  Thông báo quan trọng -->
                   <sec:authorize access="hasAnyRole('ADMIN', 'HR')">
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-bell me-1"></i>Thông báo hệ thống
                            </div>
                            <div class="card-body">
                                <div class="row">
                                
                                <!-- 🔒 Chỉ ADMIN thấy thông báo đơn nghỉ phép -->
                                <sec:authorize access="hasRole('ADMIN')">
                                    <div class="col-md-4">
                                        <div class="alert alert-warning">
                                            <strong>${stats.pendingLeaveRequests}</strong> đơn nghỉ phép đang chờ duyệt
                                            <a href="/admin/request-leave" class="alert-link">Xem ngay</a>
                                        </div>
                                    </div>
                                </sec:authorize>
                                    <div class="col-md-4">
                                        <div class="alert alert-info">
                                            <strong>${stats.todayAttendances}</strong> nhân viên đã chấm công hôm nay
                                            <a href="/admin/attendance" class="alert-link">Chi tiết</a>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="alert alert-success">
                                            Đã tính lương cho <strong>${stats.currentMonthSalaries}</strong> nhân viên
                                            <a href="/admin/salary-report" class="alert-link">Xem lương</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </sec:authorize>
                </div>
            </main>
            
            <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        //  Chart phòng ban
        const ctx = document.getElementById('departmentChart');
        const departmentData = {
            labels: [
                <c:forEach var="dept" items="${departmentStats}" varStatus="status">
                    '${dept.key}'<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            datasets: [{
                label: 'Số nhân viên',
                data: [
                    <c:forEach var="dept" items="${departmentStats}" varStatus="status">
                        ${dept.value}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                backgroundColor: [
                    '#007bff', '#28a745', '#ffc107', '#dc3545', 
                    '#6f42c1', '#fd7e14', '#20c997', '#6c757d'
                ],
                borderWidth: 1
            }]
        };
        
        new Chart(ctx, {
            type: 'bar',
            data: departmentData,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1
                        }
                    }
                }
            }
        });
    </script>
    
    <style>
        .border-left-primary {
            border-left: 0.25rem solid #007bff !important;
        }
        .border-left-success {
            border-left: 0.25rem solid #28a745 !important;
        }
        .border-left-info {
            border-left: 0.25rem solid #17a2b8 !important;
        }
        .border-left-warning {
            border-left: 0.25rem solid #ffc107 !important;
        }
    </style>
</body>
</html>
