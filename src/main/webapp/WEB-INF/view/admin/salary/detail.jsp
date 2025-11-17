<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <title>Chi tiết bảng lương - HRM System</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .salary-card th {
                width: 200px;
            }
            .salary-card td {
                font-weight: 500;
            }
            .salary-header {
                background-color: #0d6efd;
                color: #fff;
            }
            .salary-table td,
            .salary-table th {
                vertical-align: middle;
            }
        </style>
    </head>

    <body class="sb-nav-fixed">
        <jsp:include page="/WEB-INF/view/layout/header.jsp" />

        <div id="layoutSidenav">
            <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h2 class="mt-4 text-primary">
                            <i class="fas fa-money-bill-wave me-2"></i>Chi tiết bảng lương
                        </h2>

                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item">
                                <a href="/admin/dashboard">Tổng quan</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="/admin/salary-report">Bảng lương</a>
                            </li>
                            <li class="breadcrumb-item active">Chi tiết</li>
                        </ol>

                        <div class="card shadow-sm salary-card">
                            <div class="card-header salary-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="fas fa-user-tie me-2"></i>${salary.employee.fullName}</h5>
                                <span>Tháng: <strong>${salary.month}</strong></span>
                            </div>

                            <div class="card-body">
                                <div class="row">
                                    <!-- Thông tin cơ bản -->
                                    <div class="col-md-6">
                                        <h6 class="text-primary mb-3">
                                            <i class="fas fa-info-circle me-1"></i>Thông tin cơ bản
                                        </h6>
                                        <table class="table table-borderless salary-table">
                                            <tr>
                                                <th>Mã lương</th>
                                                <td>#${salary.id}</td>
                                            </tr>
                                            <tr>
                                                <th>Nhân viên</th>
                                                <td>
                                                    <strong>${salary.employee.fullName}</strong>
                                                    <br /><small class="text-muted"
                                                        >${salary.employee.employeeCode}</small
                                                    >
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Phòng ban</th>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty salary.employee.department}">
                                                            <span class="badge bg-info"
                                                                >${salary.employee.department.name}</span
                                                            >
                                                        </c:when>
                                                        <c:otherwise>Chưa phân phòng</c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Lương cơ bản</th>
                                                <td class="fw-bold">
                                                    <fmt:formatNumber value="${salary.baseSalary}" pattern="#,###" />₫
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <!-- Chấm công -->
                                    <div class="col-md-6">
                                        <h6 class="text-info mb-3">
                                            <i class="fas fa-calendar-check me-1"></i>Chấm công tháng ${salary.month}
                                        </h6>
                                        <div class="row text-center mb-3">
                                            <div class="col-4">
                                                <div class="bg-success text-white rounded p-3">
                                                    <div class="fs-4">${salary.workingDays}</div>
                                                    <small>Ngày làm</small>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="bg-warning text-white rounded p-3">
                                                    <div class="fs-4">${salary.lateDays}</div>
                                                    <small>Đi trễ</small>
                                                </div>
                                            </div>
                                            <div class="col-4">
                                                <div class="bg-danger text-white rounded p-3">
                                                    <div class="fs-4">${salary.absentDays}</div>
                                                    <small>Vắng mặt</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <hr class="my-4" />

                                <!-- Chi tiết lương -->
                                <div class="row">
                                    <!-- Thu nhập -->
                                    <div class="col-md-6">
                                        <h6 class="text-success mb-3">
                                            <i class="fas fa-plus-circle me-1"></i>Thu nhập
                                        </h6>
                                        <table class="table table-borderless table-sm">
                                            <tr>
                                                <td width="60%">Lương cơ bản:</td>
                                                <td class="text-end fw-bold">
                                                    <fmt:formatNumber value="${salary.baseSalary}" pattern="#,###" />₫
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Phụ cấp tiền ăn:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.allowanceMeal != null && salary.allowanceMeal > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.allowanceMeal}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Phụ cấp tiền xe:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.allowanceTransport != null && salary.allowanceTransport > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.allowanceTransport}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Phụ cấp thâm niên:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.allowanceSeniority != null && salary.allowanceSeniority > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.allowanceSeniority}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Thưởng:</td>
                                                <td class="text-end text-success fw-bold">
                                                    <fmt:formatNumber value="${salary.bonus}" pattern="#,###" />₫
                                                </td>
                                            </tr>
                                            <tr class="border-top">
                                                <td><strong>Tổng thu nhập:</strong></td>
                                                <td class="text-end">
                                                    <span class="badge bg-success fs-6">
                                                        <fmt:formatNumber
                                                            value="${salary.calculateGrossSalary()}"
                                                            pattern="#,###"
                                                        />₫
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>

                                    <!-- Khấu trừ -->
                                    <div class="col-md-6">
                                        <h6 class="text-danger mb-3">
                                            <i class="fas fa-minus-circle me-1"></i>Khấu trừ
                                        </h6>
                                        <table class="table table-borderless table-sm">
                                            <tr>
                                                <td width="60%">Bảo hiểm y tế:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.insuranceHealth != null && salary.insuranceHealth > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.insuranceHealth}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Bảo hiểm xã hội:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.insuranceSocial != null && salary.insuranceSocial > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.insuranceSocial}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Khấu trừ khác:</td>
                                                <td class="text-end">
                                                    <c:choose>
                                                        <c:when
                                                            test="${salary.deduction != null && salary.deduction > 0}"
                                                        >
                                                            <fmt:formatNumber
                                                                value="${salary.deduction}"
                                                                pattern="#,###"
                                                            />₫
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Không có</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                            <tr class="border-top">
                                                <td><strong>Tổng khấu trừ:</strong></td>
                                                <td class="text-end">
                                                    <span class="badge bg-danger fs-6">
                                                        <fmt:formatNumber
                                                            value="${salary.calculateTotalDeduction()}"
                                                            pattern="#,###"
                                                        />₫
                                                    </span>
                                                </td>
                                            </tr>
                                            <tr class="border-top border-2">
                                                <td>
                                                    <strong class="text-primary">Lương thực lãnh:</strong>
                                                </td>
                                                <td class="text-end">
                                                    <span class="badge bg-primary fs-5">
                                                        <fmt:formatNumber
                                                            value="${salary.netSalary}"
                                                            pattern="#,###"
                                                        />₫
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <c:if test="${not empty salary.note}">
                                    <hr class="my-4" />
                                    <div class="row">
                                        <div class="col-12">
                                            <h6 class="text-secondary mb-3">
                                                <i class="fas fa-sticky-note me-1"></i>Ghi chú
                                            </h6>
                                            <div class="alert alert-light">
                                                <c:out value="${salary.note}" />
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                                <hr />
                                <div class="text-end">
                                    <a href="/admin/salary-report/update/${salary.id}" class="btn btn-warning me-2">
                                        <i class="fas fa-edit me-1"></i>Cập nhật
                                    </a>
                                    <a href="/admin/salary-report?month=${salary.month}" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-1"></i>Quay lại
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
