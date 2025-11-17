<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <title>Quản lý bảng lương - HRM System</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    <div id="layoutSidenav">
       <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Quản lý bảng lương</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/dashboard">Tổng quan</a>
              </li>
              <li class="breadcrumb-item active">Bảng lương</li>
            </ol>

            <!-- Bộ lọc -->
            <form
              class="row g-3 mb-4"
              method="get"
              action="/admin/salary-report"
            >
              <div class="col-auto">
                <label for="month" class="col-form-label">Tháng</label>
              </div>
              <div class="col-auto">
                <input
                  type="month"
                  class="form-control"
                  id="month"
                  name="month"
                  value="${month}"
                />
              </div>
              <div class="col-auto">
                <button class="btn btn-primary">
                  <i class="fas fa-filter me-1"></i> Lọc
                </button>
              </div>
              <div class="col-auto ms-auto">
                <a
                  href="/admin/salary-report/calculate?month=${month}"
                  class="btn btn-success"
                >
                  <i class="fas fa-calculator me-1"></i> Tính lương tự động
                </a>
              </div>
            </form>

            <!-- Thống kê -->
            <div class="row mb-4">
              <div class="col-xl-3 col-md-6">
                <div class="card bg-primary text-white mb-4">
                  <div class="card-body d-flex justify-content-between">
                    <div>
                      <div class="small">Tổng bản lương</div>
                      <div class="fw-bold fs-5">${salaries.size()}</div>
                    </div>
                    <i class="fas fa-users fa-2x text-white-50"></i>
                  </div>
                </div>
              </div>
              <div class="col-xl-3 col-md-6">
                <div class="card bg-success text-white mb-4">
                  <div class="card-body d-flex justify-content-between">
                    <div>
                      <div class="small">Tổng lương Net</div>
                      <div class="fw-bold fs-5">
                        <fmt:formatNumber
                          value="${totalNet}"
                          type="currency"
                          currencySymbol="₫"
                        />
                      </div>
                    </div>
                    <i class="fas fa-sack-dollar fa-2x text-white-50"></i>
                  </div>
                </div>
              </div>
              <div class="col-xl-3 col-md-6">
                <div class="card bg-warning text-white mb-4">
                  <div class="card-body d-flex justify-content-between">
                    <div>
                      <div class="small">Tổng thưởng</div>
                      <div class="fw-bold fs-5">
                        <fmt:formatNumber
                          value="${totalBonus}"
                          type="currency"
                          currencySymbol="₫"
                        />
                      </div>
                    </div>
                    <i class="fas fa-gift fa-2x text-white-50"></i>
                  </div>
                </div>
              </div>
              <div class="col-xl-3 col-md-6">
                <div class="card bg-danger text-white mb-4">
                  <div class="card-body d-flex justify-content-between">
                    <div>
                      <div class="small">Tổng khấu trừ</div>
                      <div class="fw-bold fs-5">
                        <fmt:formatNumber
                          value="${totalDeduction}"
                          type="currency"
                          currencySymbol="₫"
                        />
                      </div>
                    </div>
                    <i class="fas fa-minus-circle fa-2x text-white-50"></i>
                  </div>
                </div>
              </div>
            </div>

            <!-- Bảng lương -->
            <div class="card mb-4">
              <div class="card-header">
                <i class="fas fa-table me-1"></i> Danh sách lương tháng ${month}
              </div>
              <div class="card-body table-responsive">
                <table class="table table-striped table-hover">                  <thead class="table-dark">
                    <tr>
                      <th>#</th>
                      <th>Nhân viên</th>
                      <th>Phòng ban</th>
                      <th>Lương CB</th>
                      <th>Phụ cấp</th>
                      <th>Thưởng</th>
                      <th>Bảo hiểm</th>
                      <th>Khấu trừ</th>
                      <th>Lương Net</th>
                      <th>Thao tác</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="salary" items="${salaries}">                      <tr>
                        <td>${salary.id}</td>
                        <td>
                          <div>
                            <strong>${salary.employee.fullName}</strong>
                            <br><small class="text-muted">${salary.employee.employeeCode}</small>
                          </div>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${not empty salary.employee.department}">
                              <span class="badge bg-info">${salary.employee.department.name}</span>
                            </c:when>
                            <c:otherwise>
                              <span class="text-muted">Chưa phân phòng</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <fmt:formatNumber value="${salary.baseSalary}" pattern="#,###" />₫
                        </td>                        <td>
                          <div class="small">
                            <div>Ăn: 
                              <c:choose>
                                <c:when test="${salary.allowanceMeal != null && salary.allowanceMeal > 0}">
                                  <fmt:formatNumber value="${salary.allowanceMeal}" pattern="#,###" />₫
                                </c:when>
                                <c:otherwise>0₫</c:otherwise>
                              </c:choose>
                            </div>
                            <div>Xe: 
                              <c:choose>
                                <c:when test="${salary.allowanceTransport != null && salary.allowanceTransport > 0}">
                                  <fmt:formatNumber value="${salary.allowanceTransport}" pattern="#,###" />₫
                                </c:when>
                                <c:otherwise>0₫</c:otherwise>
                              </c:choose>
                            </div>
                            <div>TN: 
                              <c:choose>
                                <c:when test="${salary.allowanceSeniority != null && salary.allowanceSeniority > 0}">
                                  <fmt:formatNumber value="${salary.allowanceSeniority}" pattern="#,###" />₫
                                </c:when>
                                <c:otherwise>0₫</c:otherwise>
                              </c:choose>
                            </div>
                          </div>
                        </td>
                        <td>
                          <span class="text-success fw-bold">
                            <fmt:formatNumber value="${salary.bonus}" pattern="#,###" />₫
                          </span>
                        </td>                        <td>
                          <div class="small text-danger">
                            <div>YT: 
                              <c:choose>
                                <c:when test="${salary.insuranceHealth != null && salary.insuranceHealth > 0}">
                                  <fmt:formatNumber value="${salary.insuranceHealth}" pattern="#,###" />₫
                                </c:when>
                                <c:otherwise>0₫</c:otherwise>
                              </c:choose>
                            </div>
                            <div>XH: 
                              <c:choose>
                                <c:when test="${salary.insuranceSocial != null && salary.insuranceSocial > 0}">
                                  <fmt:formatNumber value="${salary.insuranceSocial}" pattern="#,###" />₫
                                </c:when>
                                <c:otherwise>0₫</c:otherwise>
                              </c:choose>
                            </div>
                          </div>
                        </td>
                        <td>
                          <span class="text-danger fw-bold">
                            <fmt:formatNumber value="${salary.deduction}" pattern="#,###" />₫
                          </span>
                        </td>                        <td class="fw-bold text-primary">
                          <fmt:formatNumber value="${salary.netSalary}" pattern="#,###" />₫
                        </td>
                        <td>
                          <div class="btn-group">
                            <a href="/admin/salary-report/detail/${salary.id}" class="btn btn-outline-info btn-sm" title="Xem chi tiết">
                              <i class="fas fa-eye"></i>
                            </a>
                            <a href="/admin/salary-report/update/${salary.id}" class="btn btn-outline-warning btn-sm" title="Cập nhật">
                              <i class="fas fa-edit"></i>
                            </a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>                      <c:if test="${empty salaries}">
                      <tr>
                        <td colspan="10" class="text-center py-5 text-muted">
                          <!-- <i class="fas fa-inbox fa-3x mb-3 d-block"></i> -->
                          <h5>Chưa có bản lương nào trong tháng ${month}</h5>
                          <p>Hãy click "Tính lương tự động" để tạo bảng lương cho tháng này</p>
                        </td>
                      </tr>
                    </c:if>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </main>
        <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
      </div>
    </div>

    <!-- Toast success/error -->
    <c:if test="${not empty successMessage}">
      <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast show" role="alert">
          <div class="toast-header bg-success text-white">
            <i class="fas fa-check-circle me-2"></i>
            <strong class="me-auto">Thành công</strong>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="toast"
            ></button>
          </div>
          <div class="toast-body">${successMessage}</div>
        </div>
      </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
      <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast show" role="alert">
          <div class="toast-header bg-danger text-white">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <strong class="me-auto">Lỗi</strong>
            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="toast"
            ></button>
          </div>
          <div class="toast-body">${errorMessage}</div>
        </div>
      </div>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        document.querySelectorAll(".toast").forEach(function (t) {
          setTimeout(() => new bootstrap.Toast(t).hide(), 5000);
        });
      });
    </script>
  </body>
</html>
