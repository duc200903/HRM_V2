<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <title>Quản lý đơn xin nghỉ phép - HRM System</title>
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
                    <h1 class="mt-4">Quản lý đơn xin nghỉ phép</h1>                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item">
                            <a href="/admin/dashboard">Tổng quan</a>
                        </li>
                        <li class="breadcrumb-item active">Đơn xin nghỉ phép</li>
                    </ol>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-${messageType == 'success' ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                            ${message}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if><!-- Filter Controls -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form method="GET" action="/admin/request-leave" class="row g-3">
                                <div class="col-md-2">
                                    <label class="form-label">Năm:</label>
                                    <select name="year" class="form-select">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="availableYear" items="${availableYears}">
                                            <option value="${availableYear}" 
                                                    <c:if test="${availableYear == currentYear}">selected</c:if>>
                                                ${availableYear}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Tháng:</label>
                                    <select name="month" class="form-select">
                                        <option value="">Tất cả</option>
                                        <c:forEach var="i" begin="1" end="12">
                                            <option value="${i}" 
                                                    <c:if test="${i == currentMonth}">selected</c:if>>
                                                Tháng ${i}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Trạng thái:</label>
                                    <select name="status" class="form-select">
                                        <option value="">Tất cả</option>
                                        <option value="pending" 
                                                <c:if test="${'pending' == currentStatus}">selected</c:if>>
                                            Chờ duyệt
                                        </option>
                                        <option value="approved" 
                                                <c:if test="${'approved' == currentStatus}">selected</c:if>>
                                            Đã duyệt
                                        </option>
                                        <option value="rejected" 
                                                <c:if test="${'rejected' == currentStatus}">selected</c:if>>
                                            Đã từ chối
                                        </option>
                                    </select>
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="fas fa-search me-1"></i>Lọc
                                    </button>
                                    <a href="/admin/request-leave" class="btn btn-outline-secondary">
                                        <i class="fas fa-refresh me-1"></i>Reset
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-primary text-white mb-4">
                                <div class="card-body d-flex justify-content-between">
                                    <div>
                                        <div class="fs-4 fw-bold">${totalRequestLeaves}</div>
                                        <div>Tổng đơn xin nghỉ</div>
                                    </div>
                                    <i class="fas fa-calendar-times fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-warning text-white mb-4">
                                <div class="card-body d-flex justify-content-between">
                                    <div>
                                        <div class="fs-4 fw-bold">
                                            <c:set var="pendingCount" value="0" />
                                            <c:forEach var="request" items="${requestLeaves}">
                                                <c:if test="${request.status.name() == 'pending'}">
                                                    <c:set var="pendingCount" value="${pendingCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${pendingCount}
                                        </div>
                                        <div>Chờ duyệt</div>
                                    </div>
                                    <i class="fas fa-clock fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-success text-white mb-4">
                                <div class="card-body d-flex justify-content-between">
                                    <div>
                                        <div class="fs-4 fw-bold">
                                            <c:set var="approvedCount" value="0" />
                                            <c:forEach var="request" items="${requestLeaves}">
                                                <c:if test="${request.status.name() == 'approved'}">
                                                    <c:set var="approvedCount" value="${approvedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${approvedCount}
                                        </div>
                                        <div>Đã duyệt</div>
                                    </div>
                                    <i class="fas fa-check-circle fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-md-6">
                            <div class="card bg-danger text-white mb-4">
                                <div class="card-body d-flex justify-content-between">
                                    <div>
                                        <div class="fs-4 fw-bold">
                                            <c:set var="rejectedCount" value="0" />
                                            <c:forEach var="request" items="${requestLeaves}">
                                                <c:if test="${request.status.name() == 'rejected'}">
                                                    <c:set var="rejectedCount" value="${rejectedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${rejectedCount}
                                        </div>
                                        <div>Đã từ chối</div>
                                    </div>
                                    <i class="fas fa-times-circle fa-2x text-white-50"></i>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Request Leave Table -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách đơn xin nghỉ phép (${totalRequestLeaves})
                        </div>
                        <div class="card-body table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>#</th>
                                        <th>Nhân viên</th>
                                        <th>Thời gian nghỉ</th>
                                        <th>Số ngày</th>
                                        <th>Lý do</th>
                                        <th>Trạng thái</th>
                                        <th>Ngày tạo</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="request" items="${requestLeaves}">
                                        <tr>
                                            <td>${request.id}</td>
                                            <td>
                                                <div>
                                                    <strong>${request.employee.fullName}</strong>
                                                    <br><small class="text-muted">${request.employee.employeeCode}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="small">
                                                    <div><strong>Từ:</strong> ${request.startDate}</div>
                                                    <div><strong>Đến:</strong> ${request.endDate}</div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-info">${request.totalDays} ngày</span>
                                            </td>
                                            <td>
                                                <div class="text-truncate" style="max-width: 200px;" title="${request.reason}">
                                                    ${request.reason}
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${request.status.name() == 'pending'}">
                                                        <span class="badge bg-warning">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${request.status.name() == 'approved'}">
                                                        <span class="badge bg-success">Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${request.status.name() == 'rejected'}">
                                                        <span class="badge bg-danger">Đã từ chối</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>${request.createdAt}</td>
                                            <td>                                                <div class="btn-group" role="group">
                                                    <a href="/admin/request-leave/detail/${request.id}" 
                                                       class="btn btn-outline-info btn-sm" title="Xem chi tiết">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="/admin/request-leave/update/${request.id}" 
                                                       class="btn btn-outline-warning btn-sm" title="Duyệt/Chỉnh sửa">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    
                                    <c:if test="${empty requestLeaves}">
                                        <tr>
                                            <td colspan="8" class="text-center py-5 text-muted">
                                                <h5>Chưa có đơn xin nghỉ phép nào</h5>
                                                <p>Các đơn xin nghỉ phép sẽ hiển thị tại đây</p>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>        function quickApprove(requestId) {
            if (confirm('Bạn có chắc chắn muốn duyệt đơn xin nghỉ này?')) {
                fetch(`/admin/request-leave/approve/${requestId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                })
                .then(response => response.text())
                .then(data => {
                    alert(data);
                    location.reload();
                })
                .catch(error => {
                    alert('Có lỗi xảy ra!');
                    console.error('Error:', error);
                });
            }
        }

        function quickReject(requestId) {
            const reason = prompt('Nhập lý do từ chối:');
            if (reason && reason.trim()) {
                fetch(`/admin/request-leave/reject/${requestId}`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    }
                })
                .then(response => response.text())
                .then(data => {
                    alert(data);
                    location.reload();
                })
                .catch(error => {
                    alert('Có lỗi xảy ra!');
                    console.error('Error:', error);
                });
            }
        }
    </script>
</body>
</html>