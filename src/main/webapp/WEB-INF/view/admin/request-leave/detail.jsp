<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <title>Chi tiết đơn nghỉ phép - HRM System</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    
    <div id="layoutSidenav">
        <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
        
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h2 class="mt-4">
                        <i class="fas fa-info-circle me-2"></i>Chi tiết đơn nghỉ phép
                    </h2>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item">
                            <a href="/admin/dashboard">Tổng quan</a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/admin/request-leave">Đơn nghỉ phép</a>
                        </li>
                        <li class="breadcrumb-item active">Chi tiết #${requestLeave.id}</li>
                    </ol>

                    <div class="row">
                        <!-- Thông tin chính -->
                        <div class="col-lg-8">
                            <!-- Thông tin cơ bản -->
                            <div class="card mb-4">
                                <div class="card-header bg-primary text-white">
                                    <i class="fas fa-calendar-alt me-2"></i>Thông tin đơn nghỉ phép
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Mã đơn:</label>
                                                <div class="fs-5">#${requestLeave.id}</div>
                                            </div>
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Trạng thái:</label>
                                                <div>
                                                    <span class="badge ${requestLeave.statusBadgeClass} d-flex justify-content-center w-50 fs-6 py-2">
                                                        <i class="fas fa-
                                                            <c:choose>
                                                                <c:when test="${requestLeave.status.name() == 'approved'}">check-circle</c:when>
                                                                <c:when test="${requestLeave.status.name() == 'rejected'}">times-circle</c:when>
                                                                <c:otherwise>clock</c:otherwise>
                                                            </c:choose> me-1"></i>
                                                        ${requestLeave.statusText}
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Thời gian nghỉ:</label>
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <i class="fas fa-calendar-day text-primary me-2"></i>
                                                        <span><strong>Từ:</strong> ${requestLeave.startDate}</span>
                                                    </div>
                                                    <div class="d-flex align-items-center mb-2">
                                                        <i class="fas fa-calendar-day text-danger me-2"></i>
                                                        <span><strong>Đến:</strong> ${requestLeave.endDate}</span>
                                                    </div>
                                                    <div>
                                                        <span class="badge bg-info fs-6">
                                                            <i class="fas fa-clock me-1"></i>${requestLeave.totalDays} ngày
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Tháng/Năm nghỉ:</label>
                                                <div>
                                                    <c:if test="${not empty requestLeave.leaveMonthYear}">
                                                        <span class="badge bg-secondary">${requestLeave.leaveMonthYear}</span>
                                                    </c:if>
                                                    <c:if test="${empty requestLeave.leaveMonthYear}">
                                                        <span class="text-muted">Chưa cập nhật</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Ngày tạo đơn:</label>
                                                <div>${requestLeave.createdAt}</div>
                                            </div>
                                            <c:if test="${not empty requestLeave.approvedAt}">
                                                <div class="info-item mb-3">
                                                    <label class="fw-bold text-muted">Ngày duyệt:</label>
                                                    <div>${requestLeave.approvedAt}</div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Thông tin nhân viên -->
                            <div class="card mb-4">
                                <div class="card-header bg-success text-white">
                                    <i class="fas fa-user me-2"></i>Thông tin nhân viên
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Họ tên:</label>
                                                <div class="fs-5">${requestLeave.employee.fullName}</div>
                                            </div>
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Mã nhân viên:</label>
                                                <div>
                                                    <span class="badge bg-dark">${requestLeave.employee.employeeCode}</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Phòng ban:</label>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty requestLeave.employee.department}">
                                                            <span class="badge bg-info fs-6">${requestLeave.employee.department.name}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Chưa phân phòng</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Chức vụ:</label>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${not empty requestLeave.employee.position}">
                                                            ${requestLeave.employee.position}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Chưa cập nhật</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="info-item mb-3">
                                                <label class="fw-bold text-muted">Ngày phép còn lại:</label>
                                                <div class="d-flex align-items-center">
                                                    <span class="badge bg-info fs-6 me-2">
                                                        <i class="fas fa-calendar-day me-1"></i>
                                                        ${requestLeave.employee.remainingLeaveDays != null ? requestLeave.employee.remainingLeaveDays : 12} ngày
                                                    </span>
                                                    <c:if test="${requestLeave.status.name() == 'pending'}">
                                                        <small class="text-warning">
                                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                                            Sẽ trừ ${requestLeave.totalDays} ngày nếu duyệt
                                                        </small>
                                                    </c:if>
                                                    <c:if test="${requestLeave.status.name() == 'approved'}">
                                                        <small class="text-success">
                                                            <i class="fas fa-check-circle me-1"></i>
                                                            Đã trừ ${requestLeave.totalDays} ngày
                                                        </small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Lý do nghỉ phép -->
                            <div class="card mb-4">
                                <div class="card-header bg-warning text-dark">
                                    <i class="fas fa-comment-dots me-2"></i>Lý do nghỉ phép
                                </div>
                                <div class="card-body">
                                    <div class="bg-light p-4 rounded border-start border-warning border-4">
                                        <p class="mb-0 lh-lg">${requestLeave.reason}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Ghi chú -->
                            <c:if test="${not empty requestLeave.note}">
                                <div class="card mb-4">
                                    <div class="card-header bg-secondary text-white">
                                        <i class="fas fa-sticky-note me-2"></i>Ghi chú từ người duyệt
                                    </div>
                                    <div class="card-body">
                                        <div class="bg-light p-4 rounded border-start border-secondary border-4">
                                            <p class="mb-0 lh-lg">${requestLeave.note}</p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-4">
                            <!-- Thao tác nhanh -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-tools me-2"></i>Thao tác
                                </div>
                                <div class="card-body">
                                    <div class="d-grid gap-2">
                                        <a href="/admin/request-leave/update/${requestLeave.id}" 
                                           class="btn btn-primary btn-lg">
                                            <i class="fas fa-edit me-2"></i>Duyệt/Chỉnh sửa
                                        </a>
                                        <a href="/admin/request-leave" class="btn btn-outline-secondary">
                                            <i class="fas fa-arrow-left me-2"></i>Quay lại danh sách
                                        </a>
                                        <button class="btn btn-outline-info" onclick="window.print()">
                                            <i class="fas fa-print me-2"></i>In đơn
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- Timeline lịch sử -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-history me-2"></i>Lịch sử thay đổi
                                </div>
                                <div class="card-body">
                                    <div class="timeline">
                                        <!-- Tạo đơn -->
                                        <div class="timeline-item">
                                            <div class="timeline-marker bg-primary"></div>
                                            <div class="timeline-content">
                                                <div class="timeline-time text-muted small">
                                                    ${requestLeave.createdAt}
                                                </div>
                                                <div class="timeline-title">
                                                    <i class="fas fa-plus-circle text-primary me-1"></i>
                                                    Đơn được tạo
                                                </div>
                                                <div class="timeline-desc text-muted small">
                                                    Bởi ${requestLeave.employee.fullName}
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Duyệt/Từ chối -->
                                        <c:if test="${not empty requestLeave.approvedAt}">
                                            <div class="timeline-item">
                                                <div class="timeline-marker 
                                                    <c:choose>
                                                        <c:when test="${requestLeave.status.name() == 'approved'}">bg-success</c:when>
                                                        <c:otherwise>bg-danger</c:otherwise>
                                                    </c:choose>"></div>
                                                <div class="timeline-content">
                                                    <div class="timeline-time text-muted small">
                                                        ${requestLeave.approvedAt}
                                                    </div>
                                                    <div class="timeline-title">
                                                        <i class="fas fa-
                                                            <c:choose>
                                                                <c:when test="${requestLeave.status.name() == 'approved'}">check-circle text-success</c:when>
                                                                <c:otherwise>times-circle text-danger</c:otherwise>
                                                            </c:choose> me-1"></i>
                                                        ${requestLeave.statusText}
                                                    </div>
                                                    <div class="timeline-desc text-muted small">
                                                        <c:choose>
                                                            <c:when test="${not empty requestLeave.approvedBy}">
                                                                Bởi ${requestLeave.approvedBy}
                                                            </c:when>
                                                            <c:otherwise>
                                                                Người duyệt không rõ
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <!-- Thống kê -->
                            <div class="card">
                                <div class="card-header">
                                    <i class="fas fa-chart-pie me-2"></i>Thống kê
                                </div>
                                <div class="card-body">
                                    <div class="row text-center">
                                        <div class="col-6">
                                            <div class="stat-item">
                                                <div class="stat-number text-primary fs-4 fw-bold">
                                                    ${requestLeave.totalDays}
                                                </div>
                                                <div class="stat-label small text-muted">Số ngày nghỉ</div>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="stat-item">
                                                <div class="stat-number text-info fs-4 fw-bold">
                                                    <c:choose>
                                                        <c:when test="${not empty requestLeave.leaveMonth}">${requestLeave.leaveMonth}</c:when>
                                                        <c:otherwise>--</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="stat-label small text-muted">Tháng nghỉ</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        @media print {
            .sidebar, .breadcrumb, .card:has(.fas.fa-tools), .card:has(.fas.fa-chart-pie) {
                display: none !important;
            }
            .col-lg-8 {
                width: 100% !important;
            }
        }

        .info-item {
            padding: 0.5rem 0;
            border-bottom: 1px solid #f1f3f4;
        }
        .info-item:last-child {
            border-bottom: none;
        }

        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #dee2e6;
        }
        .timeline-item {
            position: relative;
            margin-bottom: 25px;
        }
        .timeline-item:last-child {
            margin-bottom: 0;
        }
        .timeline-marker {
            position: absolute;
            left: -22px;
            top: 5px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 0 0 2px #dee2e6;
        }
        .timeline-content {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border-left: 3px solid #007bff;
        }
        .timeline-title {
            font-weight: 600;
            margin-bottom: 5px;
        }
        .timeline-time {
            margin-bottom: 8px;
        }

        .stat-item {
            padding: 1rem 0;
        }
        .stat-number {
            line-height: 1;
        }
    </style>
</body>
</html>