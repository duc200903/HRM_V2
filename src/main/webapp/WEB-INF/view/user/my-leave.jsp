<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Nghỉ phép - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />

        <!-- Main Content -->
        <div class="container my-5">
            <!-- Header -->
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold text-warning"><i class="fas fa-calendar-times me-3"></i>Nghỉ phép</h1>
                <p class="lead text-muted">Quản lý đơn xin nghỉ phép của bạn</p>
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
            </c:if>            <div class="row">
                <!-- Form tạo đơn nghỉ phép -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow border-0 h-100">
                        <div class="card-header bg-warning text-dark">
                            <h5 class="card-title mb-0"><i class="fas fa-plus me-2"></i>Tạo đơn nghỉ phép</h5>
                        </div>
                        <div class="card-body">
                            <!-- Thông tin nhân viên -->
                            <div class="mb-4">
                                <h6 class="text-muted mb-3">Thông tin cá nhân</h6>
                                <div class="mb-2">
                                    <strong>Nhân viên:</strong>
                                    <c:choose>
                                        <c:when test="${currentEmployee != null && not empty currentEmployee.fullName}">
                                            ${currentEmployee.fullName}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-2">
                                    <strong>Phòng ban:</strong>
                                    <c:choose>
                                        <c:when test="${currentEmployee != null && currentEmployee.department != null}">
                                            ${currentEmployee.department.name}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa phân phòng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="mb-2">
                                    <strong>Mã NV:</strong>
                                    <c:choose>
                                        <c:when test="${currentEmployee != null && not empty currentEmployee.employeeCode}">
                                            ${currentEmployee.employeeCode}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa có</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Form tạo đơn -->
                            <c:if test="${currentEmployee != null}">
                                <form method="post" action="/my-leave/create">
                                    <div class="mb-3">
                                        <label for="startDate" class="form-label">Từ ngày</label>
                                        <input type="date" class="form-control" id="startDate" name="startDate" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="endDate" class="form-label">Đến ngày</label>
                                        <input type="date" class="form-control" id="endDate" name="endDate" required>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="leaveType" class="form-label">Loại nghỉ phép</label>
                                        <select class="form-select" id="leaveType" name="leaveType" required>
                                            <option value="">Chọn loại nghỉ phép</option>
                                            <option value="annual">Nghỉ phép năm</option>
                                            <option value="sick">Nghỉ ốm</option>
                                            <option value="personal">Nghỉ việc riêng</option>
                                            <option value="maternity">Nghỉ thai sản</option>
                                            <option value="emergency">Nghỉ khẩn cấp</option>
                                            <option value="emergency">Khác</option>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="reason" class="form-label">Lý do nghỉ phép</label>
                                        <textarea class="form-control" id="reason" name="reason" rows="3" 
                                                placeholder="Nhập lý do nghỉ phép..." required></textarea>
                                    </div>
                                    
                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-warning btn-lg">
                                            <i class="fas fa-paper-plane me-2"></i>Gửi đơn nghỉ phép
                                        </button>
                                    </div>
                                </form>
                            </c:if>
                            
                            <c:if test="${currentEmployee == null}">
                                <div class="text-center text-muted py-3">
                                    <i class="fas fa-exclamation-triangle fa-2x mb-2"></i>
                                    <p>Không thể tạo đơn nghỉ phép<br>Thông tin nhân viên chưa được cập nhật</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>                <!-- Thống kê và danh sách nghỉ phép -->
                <div class="col-lg-8 mb-4">
                    <!-- Thống kê ngắn gọn -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-primary text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-clipboard-list fa-2x mb-2"></i>
                                    <h4 class="mb-0">${totalCount}</h4>
                                    <small>Tổng đơn</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-warning text-dark">
                                <div class="card-body text-center">
                                    <i class="fas fa-hourglass-half fa-2x mb-2"></i>
                                    <h4 class="mb-0">${pendingCount}</h4>
                                    <small>Chờ duyệt</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-success text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                                    <h4 class="mb-0">${approvedCount}</h4>
                                    <small>Đã duyệt</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="card border-0 bg-danger text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-times-circle fa-2x mb-2"></i>
                                    <h4 class="mb-0">${rejectedCount}</h4>
                                    <small>Bị từ chối</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Danh sách nghỉ phép -->
                    <div class="card shadow border-0">
                        <div class="card-header bg-info text-white">
                            <h5 class="card-title mb-0"><i class="fas fa-list me-2"></i>Danh sách đơn nghỉ phép</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${not empty leaveRequests}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">                                            <thead class="table-light">
                                                <tr>
                                                    <th>Từ ngày</th>
                                                    <th>Đến ngày</th>
                                                    <th>Số ngày</th>
                                                    <th>Lý do</th>
                                                    <th>Trạng thái</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="leave" items="${leaveRequests}" varStatus="status">
                                                    <c:if test="${status.index < 20}">
                                                        <tr>
                                                            <td>
                                                                <c:set var="startKey" value="start_${leave.id}" />
                                                                ${formattedDates[startKey]}
                                                            </td>
                                                            <td>
                                                                <c:set var="endKey" value="end_${leave.id}" />
                                                                ${formattedDates[endKey]}
                                                            </td>                                                            <td>
                                                                <span class="badge bg-info">
                                                                    <c:set var="daysKey" value="days_${leave.id}" />
                                                                    ${leaveDays[daysKey]} ngày
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <span class="text-truncate" style="max-width: 200px; display: inline-block;" 
                                                                      title="${leave.reason}">
                                                                    ${leave.reason}
                                                                </span>
                                                            </td>                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${leave.status.toString() == 'pending'}">
                                                                        <span class="badge bg-warning">
                                                                            <i class="fas fa-clock me-1"></i>Chờ duyệt
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${leave.status.toString() == 'approved'}">
                                                                        <span class="badge bg-success">
                                                                            <i class="fas fa-check me-1"></i>Đã duyệt
                                                                        </span>
                                                                    </c:when>
                                                                    <c:when test="${leave.status.toString() == 'rejected'}">
                                                                        <span class="badge bg-danger">
                                                                            <i class="fas fa-times me-1"></i>Bị từ chối
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${leave.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${leave.status.toString() == 'pending'}">
                                                                        <a href="/my-leave-delete/${leave.id}" class="btn btn-outline-danger btn-sm">
                                                                            <i class="fas fa-times me-1"></i>Hủy
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="text-muted small">
                                                                            <i class="fas fa-check-circle me-1"></i>Đã xử lý
                                                                        </span>
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
                                        <i class="fas fa-calendar-plus fa-3x mb-3"></i>
                                        <h5>Chưa có đơn nghỉ phép nào</h5>
                                        <p>Tạo đơn nghỉ phép đầu tiên của bạn bằng form bên trái</p>
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
        <jsp:include page="/WEB-INF/view/layout-user/styles.jsp" />        <!-- Form validation script -->        <script>
            document.addEventListener('DOMContentLoaded', function() {
                console.log('🔧 JavaScript loaded');
                
                const startDateInput = document.getElementById('startDate');
                const endDateInput = document.getElementById('endDate');
                
                if (!startDateInput || !endDateInput) {
                    console.error('❌ Không tìm thấy input elements');
                    return;
                }
                
                console.log('✅ Tìm thấy date inputs');
                
                // Set minimum date to today
                const today = new Date().toISOString().split('T')[0];
                startDateInput.min = today;
                endDateInput.min = today;
                
                // Event listeners with debugging
                startDateInput.addEventListener('change', function() {
                    console.log('📅 Start date changed:', this.value);
                    endDateInput.min = this.value;
                    calculateDays();
                });
                
                endDateInput.addEventListener('change', function() {
                    console.log('📅 End date changed:', this.value);
                    calculateDays();
                });
                
                function calculateDays() {
                    console.log('🔢 Calculating days...');
                    
                    // Remove existing day info
                    const existingDayInfo = document.getElementById('dayInfo');
                    if (existingDayInfo) {
                        existingDayInfo.remove();
                        console.log('🗑️ Removed existing dayInfo');
                    }
                    
                    const startVal = startDateInput.value;
                    const endVal = endDateInput.value;
                    
                    console.log('📊 Values:', { start: startVal, end: endVal });
                    
                    if (!startVal || !endVal) {
                        console.log('⚠️ Missing values, skipping...');
                        return;
                    }
                    
                    const startDate = new Date(startVal);
                    const endDate = new Date(endVal);
                    
                    console.log('📆 Dates:', { startDate, endDate });
                    
                    // Calculate difference in days
                    const timeDiff = endDate.getTime() - startDate.getTime();
                    const daysDiff = Math.floor(timeDiff / (1000 * 60 * 60 * 24)) + 1;
                    
                    console.log('⏰ Time diff:', timeDiff);
                    console.log('📈 Days calculated:', daysDiff);
                    
                    if (daysDiff < 1) {
                        console.log('❌ Invalid days, skipping...');
                        return;
                    }
                    
                    // Create day info element
                    const dayInfo = document.createElement('small');
                    dayInfo.id = 'dayInfo';
                    dayInfo.className = 'text-info mt-2 d-block fw-bold';
                    dayInfo.innerHTML = '<i class="fas fa-calendar-day me-1"></i>(' + daysDiff + ' ngày)';
                    
                    // Insert after end date input
                    endDateInput.parentNode.appendChild(dayInfo);                    console.log('✅ Day info added:', dayInfo.innerHTML);
                }
            });
        </script>
    </body>
</html>
