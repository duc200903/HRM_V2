<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Lương thưởng - HRM System</title>
        <jsp:include page="/WEB-INF/view/layout-user/head.jsp" />
    </head>
    <body class="bg-light">
        <!-- Include Navbar -->
        <jsp:include page="/WEB-INF/view/layout-user/navbar.jsp" />

        <!-- Main Content -->
        <div class="container my-5">
            <!-- Header -->
            <div class="text-center mb-5">
                <h1 class="display-5 fw-bold text-success"><i class="fas fa-money-bill-wave me-3"></i>Lương thưởng</h1>
                <p class="lead text-muted">Xem thông tin lương thưởng của bạn</p>
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
                <!-- Filter và thông tin cá nhân -->
                <div class="col-lg-4 mb-4">
                    <div class="card shadow border-0 h-100">
                        <div class="card-header bg-success text-white">
                            <h5 class="card-title mb-0"><i class="fas fa-filter me-2"></i>Lọc và thông tin</h5>
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
                                </div>                                <div class="mb-2">
                                    <strong>Lương cơ bản (hợp đồng):</strong>
                                    <c:choose>
                                        <c:when test="${currentEmployee != null && currentEmployee.baseSalary != null}">
                                            <span class="text-success fw-bold">
                                                <fmt:formatNumber value="${currentEmployee.baseSalary}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </span>
                                            <br>                                            <small class="text-muted">
                                                <i class="fas fa-info-circle me-1"></i>
                                                Lương thực tế = Lương HĐ ÷ ngày chuẩn × ngày làm<br>
                                                <i class="fas fa-calculator me-1"></i>
                                                Ví dụ: 2.000.000₫ ÷ 22 ngày × 5 ngày = 454.545₫
                                            </small>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">Chưa cập nhật</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Filter form -->
                            <c:if test="${currentEmployee != null}">
                                <form method="get" action="/my-salary">
                                    <div class="mb-3">
                                        <label for="year" class="form-label">Năm</label>
                                        <select class="form-select" id="year" name="year">
                                            <option value="">Tất cả năm</option>
                                            <c:forEach begin="2020" end="2025" var="yearOption">
                                                <option value="${yearOption}" ${selectedYear == yearOption ? 'selected' : ''}>${yearOption}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="month" class="form-label">Tháng</label>
                                        <select class="form-select" id="month" name="month">
                                            <option value="">Tất cả tháng</option>
                                            <c:forEach begin="1" end="12" var="monthOption">
                                                <option value="${monthOption}" ${selectedMonth == monthOption ? 'selected' : ''}>
                                                    Tháng ${monthOption}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                      <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-success">
                                            <i class="fas fa-search me-2"></i>Lọc dữ liệu
                                        </button>
                                        <c:if test="${selectedYear != null || selectedMonth != null}">
                                            <a href="/my-salary" class="btn btn-outline-secondary">
                                                <i class="fas fa-times me-2"></i>Xóa bộ lọc
                                            </a>
                                        </c:if>
                                    </div>
                                </form>
                            </c:if>
                            
                            <c:if test="${currentEmployee == null}">
                                <div class="text-center text-muted py-3">
                                    <i class="fas fa-exclamation-triangle fa-2x mb-2"></i>
                                    <p>Không thể xem lương<br>Thông tin nhân viên chưa được cập nhật</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>                <!-- Thống kê và danh sách lương -->
                <div class="col-lg-8 mb-4">
                    <!-- Thống kê ngắn gọn -->
                    <div class="row mb-4">
                        <div class="col-md-4 mb-3">
                            <div class="card border-0 bg-success text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-receipt fa-2x mb-2"></i>
                                    <h4 class="mb-0">${salaryCount}</h4>
                                    <small>Tổng bảng lương</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card border-0 bg-primary text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-money-bill-wave fa-2x mb-2"></i>
                                    <div class="mb-0">
                                        <small>Tổng thu nhập</small><br>
                                        <strong>
                                            <fmt:formatNumber value="${totalNetSalary}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card border-0 bg-info text-white">
                                <div class="card-body text-center">
                                    <i class="fas fa-calculator fa-2x mb-2"></i>                                    <div class="mb-0">
                                        <small>Lương TB/tháng</small><br>
                                        <strong>
                                            <fmt:formatNumber value="${averageSalary}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                        </strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>                    <!-- Danh sách bảng lương -->
                    <div class="card shadow border-0">
                        <div class="card-header bg-success text-white">
                            <h5 class="card-title mb-0"><i class="fas fa-list me-2"></i>Danh sách bảng lương</h5>
                        </div>
                        <div class="card-body">
                            <!-- Info alert -->
                            <div class="alert alert-info alert-dismissible fade show" role="alert">
                                <i class="fas fa-lightbulb me-2"></i>
                                <strong>Lưu ý:</strong> 
                                <span class="fw-bold text-primary">Lương CB trong bảng</span> là lương đã tính theo ngày công thực tế, 
                                khác với <span class="fw-bold text-success">Lương cơ bản (hợp đồng)</span> ở trên.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <c:choose>
                                <c:when test="${not empty salaries}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">                                            <thead class="table-light">
                                                <tr>
                                                    <th>Kỳ lương</th>
                                                    <th data-bs-toggle="tooltip" title="Lương cơ bản tính theo ngày công thực tế (Lương hợp đồng ÷ ngày chuẩn × ngày làm)">
                                                        Lương CB <i class="fas fa-info-circle text-muted ms-1"></i>
                                                    </th>
                                                    <th data-bs-toggle="tooltip" title="Chi tiết: Ăn + Xe + Thâm niên">
                                                        Phụ cấp <i class="fas fa-info-circle text-muted ms-1"></i>
                                                    </th>
                                                    <th>Thưởng</th>
                                                    <th data-bs-toggle="tooltip" title="Chi tiết: BHYT + BHXH">
                                                        Bảo hiểm <i class="fas fa-info-circle text-muted ms-1"></i>
                                                    </th>
                                                    <th>Khấu trừ khác</th>
                                                    <th>Lương Net</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="salary" items="${salaries}" varStatus="status">
                                                    <c:if test="${status.index < 20}">
                                                        <tr>
                                                            <td>
                                                                <c:set var="periodKey" value="period_${salary.id}" />
                                                                <strong>${formattedSalaries[periodKey]}</strong>
                                                            </td>                                            <!-- Lương CB -->
                                            <td>
                                                <fmt:formatNumber value="${salary.baseSalary}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                            </td>
                                            
                                            <!-- Phụ cấp (Chi tiết) -->
                                            <td>
                                                <div class="text-success small">
                                                    <c:if test="${salary.allowanceMeal != null && salary.allowanceMeal > 0}">
                                                        <div>Ăn: <fmt:formatNumber value="${salary.allowanceMeal}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                    </c:if>
                                                    <c:if test="${salary.allowanceTransport != null && salary.allowanceTransport > 0}">
                                                        <div>Xe: <fmt:formatNumber value="${salary.allowanceTransport}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                    </c:if>
                                                    <c:if test="${salary.allowanceSeniority != null && salary.allowanceSeniority > 0}">
                                                        <div>TN: <fmt:formatNumber value="${salary.allowanceSeniority}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                    </c:if>
                                                    <c:if test="${(salary.allowanceMeal == null || salary.allowanceMeal == 0) && 
                                                                  (salary.allowanceTransport == null || salary.allowanceTransport == 0) && 
                                                                  (salary.allowanceSeniority == null || salary.allowanceSeniority == 0)}">
                                                        <span class="text-muted">0₫</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            
                                            <!-- Thưởng -->
                                            <td>
                                                <span class="text-warning fw-bold">
                                                    <c:choose>
                                                        <c:when test="${salary.bonus != null && salary.bonus > 0}">
                                                            <fmt:formatNumber value="${salary.bonus}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">0₫</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            
                                            <!-- Bảo hiểm (Chi tiết) -->
                                            <td>
                                                <div class="text-danger small">
                                                    <c:if test="${salary.insuranceHealth != null && salary.insuranceHealth > 0}">
                                                        <div>YT: <fmt:formatNumber value="${salary.insuranceHealth}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                    </c:if>
                                                    <c:if test="${salary.insuranceSocial != null && salary.insuranceSocial > 0}">
                                                        <div>XH: <fmt:formatNumber value="${salary.insuranceSocial}" type="currency" currencySymbol="₫" groupingUsed="true"/></div>
                                                    </c:if>
                                                    <c:if test="${(salary.insuranceHealth == null || salary.insuranceHealth == 0) && 
                                                                  (salary.insuranceSocial == null || salary.insuranceSocial == 0)}">
                                                        <span class="text-muted">0₫</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            
                                            <!-- Khấu trừ khác -->
                                            <td>
                                                <span class="text-danger">
                                                    <c:choose>
                                                        <c:when test="${salary.deduction != null && salary.deduction > 0}">
                                                            <fmt:formatNumber value="${salary.deduction}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">0₫</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </td>
                                            
                                            <!-- Lương Net -->
                                            <td>
                                                <span class="fw-bold text-primary">
                                                    <fmt:formatNumber value="${salary.netSalary}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                                                </span>
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
                                        <i class="fas fa-money-bill-alt fa-3x mb-3"></i>
                                        <h5>Chưa có bảng lương nào</h5>
                                        <p>Bảng lương sẽ được tạo hàng tháng bởi HR/Admin</p>
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
        <jsp:include page="/WEB-INF/view/layout-user/styles.jsp" />        <!-- Page specific script -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                console.log('💰 Salary page loaded');
                
                // Initialize Bootstrap tooltips
                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                    return new bootstrap.Tooltip(tooltipTriggerEl);
                });
                
                // Add hover effects for salary rows
                const salaryRows = document.querySelectorAll('tbody tr');
                salaryRows.forEach(row => {
                    row.addEventListener('mouseenter', function() {
                        this.style.backgroundColor = '#f8f9fa';
                    });
                    row.addEventListener('mouseleave', function() {
                        this.style.backgroundColor = '';
                    });
                });
            });
        </script>
    </body>
</html>
