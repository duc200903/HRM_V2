<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Chấm công - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />

        <!-- Main Content -->
        <div class="container my-5">
            <!-- Header -->
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold text-primary"><i class="fas fa-clock me-3"></i>Chấm công</h1>
                <p class="lead text-muted">Quản lý thời gian làm việc của bạn</p>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="row">
                <!-- Thông tin nhân viên và chấm công hôm nay -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow border-0 h-100">
                        <div class="card-header bg-primary text-white">
                            <h5 class="card-title mb-0"><i class="fas fa-user me-2"></i>Thông tin chấm công</h5>
                        </div>
                        <div class="card-body">
                            <!-- Thông tin nhân viên -->
                            <div class="mb-4">
                                <h6 class="text-muted mb-3">Thông tin cá nhân</h6>
                                <div class="mb-2">
                                    <strong>Nhân viên:</strong>
                                    ${not empty currentEmployee && not empty currentEmployee.fullName ?
                                    currentEmployee.fullName : '<span class="text-muted">Chưa cập nhật</span>'}
                                </div>

                                <div class="mb-2">
                                    <strong>Phòng ban:</strong>
                                    ${currentEmployee != null && currentEmployee.department != null && not empty
                                    currentEmployee.department.name ? currentEmployee.department.name : '<span
                                        class="text-muted"
                                        >Chưa phân phòng</span
                                    >'}
                                </div>

                                <div class="mb-2">
                                    <strong>Mã NV:</strong>
                                    ${currentEmployee != null && not empty currentEmployee.employeeCode ?
                                    currentEmployee.employeeCode : '<span class="text-muted">Chưa có</span>'}
                                </div>
                            </div>

                            <!-- Thông tin thời gian hiện tại -->
                            <div class="mb-4 p-3 bg-light rounded">
                                <h6 class="text-muted mb-2">Thời gian hiện tại</h6>
                                <div class="text-center">
                                    <div class="fs-4 fw-bold text-primary" id="currentTime">${currentTime}</div>
                                    <div class="text-muted">${currentDate}</div>
                                </div>
                            </div>

                            <!-- Trạng thái chấm công hôm nay -->
                            <div class="mb-4">
                                <h6 class="text-muted mb-3">Trạng thái hôm nay</h6>
                                <c:choose>
                                    <c:when test="${todayAttendance != null}">
                                        <div class="row text-center">
                                            <div class="col-6">
                                                <div class="border-end">
                                                    <div class="fw-bold text-success">
                                                        <c:choose>
                                                            <c:when test="${todayAttendance.checkIn != null}">
                                                                ${todayAttendance.checkIn}
                                                            </c:when>
                                                            <c:otherwise>--:--:--</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <small class="text-muted">Giờ vào</small>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="fw-bold text-danger">
                                                    <c:choose>
                                                        <c:when test="${todayAttendance.checkOut != null}">
                                                            ${todayAttendance.checkOut}
                                                        </c:when>
                                                        <c:otherwise>--:--:--</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <small class="text-muted">Giờ ra</small>
                                            </div>
                                        </div>

                                        <div class="text-center mt-3">
                                            <c:choose>
                                                <c:when test="${todayAttendance.status.toString() == 'present'}">
                                                    <span class="badge bg-success fs-6">Đúng giờ</span>
                                                </c:when>
                                                <c:when test="${todayAttendance.status.toString() == 'late'}">
                                                    <span class="badge bg-warning fs-6">Trễ</span>
                                                </c:when>
                                                <c:when test="${todayAttendance.status.toString() == 'absent'}">
                                                    <span class="badge bg-danger fs-6">Vắng</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary fs-6"
                                                        >${todayAttendance.status}</span
                                                    >
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-muted">
                                            <i class="fas fa-calendar-times fa-2x mb-2"></i>
                                            <p>Chưa chấm công hôm nay</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Buttons chấm công -->
                            <div class="d-grid gap-2">
                                <c:choose>
                                    <c:when test="${todayAttendance == null || todayAttendance.checkIn == null}">
                                        <form method="post" action="/my-attendance/check-in">
                                            <button type="submit" class="btn btn-success btn-lg w-100">
                                                <i class="fas fa-sign-in-alt me-2"></i>Chấm công vào
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:when test="${todayAttendance.checkOut == null}">
                                        <form method="post" action="/my-attendance/check-out">
                                            <button type="submit" class="btn btn-danger btn-lg w-100">
                                                <i class="fas fa-sign-out-alt me-2"></i>Chấm công ra
                                            </button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-secondary btn-lg w-100" disabled>
                                            <i class="fas fa-check me-2"></i>Đã hoàn thành
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Lịch sử chấm công -->
                <div class="col-lg-8 mb-4">
                    <div class="card shadow border-0">
                        <div class="card-header bg-info text-white">
                            <h5 class="card-title mb-0"><i class="fas fa-history me-2"></i>Lịch sử chấm công</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty attendances}">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-light">
                                                <tr class="text-center">
                                                    <th>Ngày</th>
                                                    <th>Giờ vào</th>
                                                    <th>Giờ ra</th>
                                                    <th>Trạng thái</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="attendance" items="${attendances}" varStatus="status">
                                                    <c:if test="${status.index < 20}">
                                                        <tr class="text-center">
                                                            <td>
                                                                <c:set var="dateKey" value="date_${attendance.id}" />
                                                                ${formattedDates[dateKey]}
                                                            </td>
                                                            <td class="checkin-time">
                                                                <c:choose>
                                                                    <c:when test="${attendance.checkIn != null}">
                                                                        <span class="text-success"
                                                                            >${attendance.checkIn}</span
                                                                        >
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">--:--:--</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td class="checkout-time">
                                                                <c:choose>
                                                                    <c:when test="${attendance.checkOut != null}">
                                                                        <span class="text-danger"
                                                                            >${attendance.checkOut}</span
                                                                        >
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted">--:--:--</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${attendance.status.toString() == 'present'}"
                                                                    >
                                                                        <span class="badge bg-success">Đúng giờ</span>
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${attendance.status.toString() == 'late'}"
                                                                    >
                                                                        <span class="badge bg-warning text-dark"
                                                                            >Trễ</span
                                                                        >
                                                                    </c:when>
                                                                    <c:when
                                                                        test="${attendance.status.toString() == 'absent'}"
                                                                    >
                                                                        <span class="badge bg-danger">Vắng</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary"
                                                                            >${attendance.status}</span
                                                                        >
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:if>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-muted py-5">
                                        <i class="fas fa-calendar-times fa-3x mb-3"></i>
                                        <h5>Chưa có dữ liệu chấm công</h5>
                                        <p>Hãy bắt đầu chấm công để theo dõi thời gian làm việc của bạn</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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
        <!-- Real-time clock script -->
        <script>
            function updateTime() {
                const now = new Date();
                const timeString = now.toLocaleTimeString('vi-VN', {
                    hour12: false,
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                });
                const timeElement = document.getElementById('currentTime');
                if (timeElement) {
                    timeElement.textContent = timeString;
                }
            } // Update time every second
            setInterval(updateTime, 1000);

            // Initial call
            updateTime();
        </script>
    </body>
</html>
