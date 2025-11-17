<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <title>Duyệt đơn nghỉ phép - HRM System</title>
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
                    <h1 class="mt-4">
                        <i class="fas fa-edit me-2"></i>Duyệt đơn nghỉ phép
                    </h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item">
                            <a href="/admin/dashboard">Tổng quan</a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="/admin/request-leave">Đơn nghỉ phép</a>
                        </li>
                        <li class="breadcrumb-item active">Duyệt đơn #${requestLeave.id}</li>
                    </ol>

                    <div class="row">
                        <!-- Thông tin đơn nghỉ -->
                        <div class="col-lg-8">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-info-circle me-2"></i>Thông tin đơn nghỉ phép
                                </div>
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Mã đơn:</strong></div>
                                        <div class="col-sm-9">#${requestLeave.id}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Nhân viên:</strong></div>
                                        <div class="col-sm-9">
                                            <strong>${requestLeave.employee.fullName}</strong>
                                            <br><small class="text-muted">${requestLeave.employee.employeeCode}</small>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Phòng ban:</strong></div>
                                        <div class="col-sm-9">
                                            <c:choose>
                                                <c:when test="${not empty requestLeave.employee.department}">
                                                    <span class="badge bg-info">${requestLeave.employee.department.name}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa phân phòng</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Thời gian nghỉ:</strong></div>
                                        <div class="col-sm-9">
                                            <div>
                                                <i class="fas fa-calendar me-1"></i>
                                                <strong>Từ:</strong> ${requestLeave.startDate}
                                            </div>
                                            <div>
                                                <i class="fas fa-calendar me-1"></i>
                                                <strong>Đến:</strong> ${requestLeave.endDate}
                                            </div>
                                            <div class="mt-2">
                                                <span class="badge bg-primary">
                                                    <i class="fas fa-clock me-1"></i>${requestLeave.totalDays} ngày
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Lý do:</strong></div>
                                        <div class="col-sm-9">
                                            <div class="alert alert-light border">
                                                ${requestLeave.reason}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Trạng thái hiện tại:</strong></div>
                                        <div class="col-sm-9">
                                            <span class="badge ${requestLeave.statusBadgeClass} fs-6">
                                                ${requestLeave.statusText}
                                            </span>
                                        </div>
                                    </div>                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Ngày phép còn lại:</strong></div>
                                        <div class="col-sm-9">
                                            <span class="badge bg-info fs-6">
                                                <i class="fas fa-calendar-day me-1"></i>
                                                ${requestLeave.employee.remainingLeaveDays != null ? requestLeave.employee.remainingLeaveDays : 12} ngày
                                            </span>
                                            <small class="text-muted d-block mt-1">
                                                Nếu duyệt đơn này sẽ trừ ${requestLeave.totalDays} ngày
                                            </small>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-3"><strong>Ngày tạo:</strong></div>
                                        <div class="col-sm-9">${requestLeave.createdAt}</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form duyệt đơn -->
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-header bg-primary text-white">
                                    <i class="fas fa-check-circle me-2"></i>Duyệt đơn nghỉ phép
                                </div>
                                <div class="card-body">
                                    <form method="POST" action="/admin/request-leave/update/${requestLeave.id}">
                                        <div class="mb-3">
                                            <label class="form-label"><strong>Quyết định:</strong></label>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="status" 
                                                       id="approve" value="approved" 
                                                       <c:if test="${requestLeave.status.name() == 'approved'}">checked</c:if>>
                                                <label class="form-check-label text-success" for="approve">
                                                    <i class="fas fa-check me-1"></i><strong>Duyệt đơn</strong>
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="status" 
                                                       id="reject" value="rejected"
                                                       <c:if test="${requestLeave.status.name() == 'rejected'}">checked</c:if>>
                                                <label class="form-check-label text-danger" for="reject">
                                                    <i class="fas fa-times me-1"></i><strong>Từ chối</strong>
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="status" 
                                                       id="pending" value="pending"
                                                       <c:if test="${requestLeave.status.name() == 'pending'}">checked</c:if>>
                                                <label class="form-check-label text-warning" for="pending">
                                                    <i class="fas fa-clock me-1"></i><strong>Chờ duyệt</strong>
                                                </label>
                                            </div>
                                        </div>                                        <div class="mb-3">
                                            <label class="form-label">Người duyệt:</label>
                                            <div class="alert alert-info">
                                                <i class="fas fa-info-circle me-1"></i>
                                                Sẽ tự động ghi nhận tài khoản của bạn khi duyệt/từ chối
                                            </div>
                                            <c:if test="${not empty requestLeave.approvedBy}">
                                                <div class="text-muted">
                                                    <strong>Đã duyệt bởi:</strong> ${requestLeave.approvedBy}
                                                </div>
                                            </c:if>
                                        </div>

                                        <div class="mb-3">
                                            <label for="note" class="form-label">Ghi chú:</label>
                                            <textarea class="form-control" id="note" name="note" rows="4" 
                                                      placeholder="Nhập ghi chú (tùy chọn)">${requestLeave.note}</textarea>
                                        </div>

                                        <div class="d-grid gap-2">
                                            <button type="submit" class="btn btn-primary btn-lg">
                                                <i class="fas fa-save me-2"></i>Cập nhật
                                            </button>
                                            <a href="/admin/request-leave" class="btn btn-outline-secondary">
                                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                                            </a>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!-- Lịch sử thay đổi -->
                            <c:if test="${not empty requestLeave.approvedAt}">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-history me-2"></i>Lịch sử
                                    </div>
                                    <div class="card-body">
                                        <div class="timeline">
                                            <div class="timeline-item">
                                                <div class="timeline-marker bg-primary"></div>
                                                <div class="timeline-content">
                                                    <small class="text-muted">${requestLeave.createdAt}</small>
                                                    <div>Đơn được tạo</div>
                                                </div>
                                            </div>
                                            <c:if test="${not empty requestLeave.approvedAt}">
                                                <div class="timeline-item">
                                                    <div class="timeline-marker 
                                                        <c:choose>
                                                            <c:when test="${requestLeave.status.name() == 'approved'}">bg-success</c:when>
                                                            <c:otherwise>bg-danger</c:otherwise>
                                                        </c:choose>"></div>
                                                    <div class="timeline-content">
                                                        <small class="text-muted">${requestLeave.approvedAt}</small>
                                                        <div>
                                                            ${requestLeave.statusText}
                                                            <c:if test="${not empty requestLeave.approvedBy}">
                                                                bởi <strong>${requestLeave.approvedBy}</strong>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>        // Validation form
        document.querySelector('form').addEventListener('submit', function(e) {
            const status = document.querySelector('input[name="status"]:checked');
            
            if (!status) {
                alert('Vui lòng chọn trạng thái!');
                e.preventDefault();
                return;
            }
            
            // Hiển thị confirm cho approve/reject
            if (status.value === 'approved') {
                if (!confirm('Bạn có chắc chắn muốn duyệt đơn nghỉ phép này?\nTài khoản của bạn sẽ được ghi nhận là người duyệt.')) {
                    e.preventDefault();
                    return;
                }
            } else if (status.value === 'rejected') {
                if (!confirm('Bạn có chắc chắn muốn từ chối đơn nghỉ phép này?\nTài khoản của bạn sẽ được ghi nhận là người từ chối.')) {
                    e.preventDefault();
                    return;
                }
            }
        });
    </script>

    <style>
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
            margin-bottom: 20px;
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
            padding: 10px 15px;
            border-radius: 8px;
            border-left: 3px solid #007bff;
        }
    </style>
</body>
</html>