<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Xác nhận hủy đơn nghỉ phép - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />

        <!-- Main Content -->
        <div class="container my-5">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <!-- Header -->
                    <div class="text-center mb-5">
                        <div class="mb-3">
                            <i class="fas fa-exclamation-triangle fa-4x text-warning"></i>
                        </div>
                        <h1 class="display-6 fw-bold text-danger">Xác nhận hủy đơn nghỉ phép</h1>
                        <p class="lead text-muted">Bạn có chắc chắn muốn hủy đơn nghỉ phép này không?</p>
                    </div>

                    <!-- Leave Request Details Card -->
                    <div class="card shadow-lg border-0 mb-4">
                        <div class="card-header bg-danger text-white py-3">
                            <h5 class="card-title mb-0">
                                <i class="fas fa-calendar-times me-2"></i>Thông tin đơn nghỉ phép
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <!-- Thông tin nhân viên -->
                                <div class="col-12">
                                    <h6 class="text-primary border-bottom pb-2 mb-3">
                                        <i class="fas fa-user me-2"></i>Thông tin nhân viên
                                    </h6>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Họ và tên:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-user text-primary me-2"></i>
                                        ${currentEmployee.fullName}
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Mã nhân viên:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <i class="fas fa-hashtag text-primary me-2"></i>
                                        ${currentEmployee.employeeCode}
                                    </div>
                                </div>

                                <!-- Thông tin đơn nghỉ phép -->
                                <div class="col-12 mt-4">
                                    <h6 class="text-primary border-bottom pb-2 mb-3">
                                        <i class="fas fa-calendar-alt me-2"></i>Chi tiết đơn nghỉ phép
                                    </h6>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold text-secondary">Từ ngày:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded text-center">
                                        <i class="fas fa-calendar-day text-success me-2"></i>
                                        <strong>${formattedStartDate}</strong>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold text-secondary">Đến ngày:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded text-center">
                                        <i class="fas fa-calendar-day text-danger me-2"></i>
                                        <strong>${formattedEndDate}</strong>
                                    </div>
                                </div>

                                <div class="col-md-4">
                                    <label class="form-label fw-bold text-secondary">Tổng số ngày:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded text-center">
                                        <span class="badge bg-info fs-6">
                                            <i class="fas fa-calculator me-1"></i>${daysDiff} ngày
                                        </span>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-bold text-secondary">Lý do nghỉ phép:</label>
                                    <div class="form-control-plaintext bg-light p-3 rounded">
                                        <i class="fas fa-comment-alt text-warning me-2"></i>
                                        ${leaveRequest.reason}
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label fw-bold text-secondary">Trạng thái hiện tại:</label>
                                    <div class="form-control-plaintext bg-light p-2 rounded">
                                        <span class="badge bg-warning fs-6">
                                            <i class="fas fa-clock me-1"></i>Chờ duyệt
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Warning Alert -->
                    <div class="alert alert-warning border-0 shadow-sm mb-4">
                        <div class="d-flex">
                            <div class="me-3">
                                <i class="fas fa-exclamation-triangle fa-2x text-warning"></i>
                            </div>
                            <div>
                                <h6 class="alert-heading fw-bold">
                                    <i class="fas fa-info-circle me-1"></i>Lưu ý quan trọng
                                </h6>
                                <p class="mb-0">
                                    • Hành động này sẽ <strong>xóa hoàn toàn</strong> đơn nghỉ phép khỏi hệ thống<br />
                                    • Bạn sẽ <strong>không thể khôi phục</strong> đơn nghỉ phép sau khi hủy<br />
                                    • Nếu muốn nghỉ phép trong thời gian này, bạn phải <strong>tạo đơn mới</strong>
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="card shadow border-0">
                        <div class="card-body p-4">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <a href="/my-leave" class="btn btn-outline-secondary btn-lg w-100">
                                        <i class="fas fa-arrow-left me-2"></i>
                                        Không, quay lại
                                    </a>
                                </div>
                                <div class="col-md-6">
                                    <form method="post" action="/my-leave/cancel/${leaveRequest.id}" class="w-100">
                                        <button type="submit" class="btn btn-danger btn-lg w-100">
                                            <i class="fas fa-trash me-2"></i>
                                            Có, hủy đơn nghỉ phép
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="/WEB-INF/view/layout-user/footer.jsp" />

        <!-- Include Scripts -->
        <jsp:include page="/WEB-INF/view/layout-user/scripts.jsp" />

        <!-- Include Styles -->
        <jsp:include page="/WEB-INF/view/layout-user/styles.jsp" />
    </body>
</html>
