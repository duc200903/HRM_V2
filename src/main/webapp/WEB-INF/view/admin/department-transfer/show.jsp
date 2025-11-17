<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Lịch sử chuyển phòng ban - HRM System</title>
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
                        <h1 class="mt-4">Lịch sử chuyển phòng ban</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/admin/dashboard">Tổng quan</a></li>
                            <li class="breadcrumb-item active">Lịch sử chuyển phòng ban</li>
                        </ol>

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

                        <!-- Summary Cards -->
                        <div class="row mb-4">
                            <div class="col-xl-3 col-md-6">
                                <div class="card bg-primary text-white mb-4">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between">
                                            <div>
                                                <div class="h4 mb-0">${totalTransfers}</div>
                                                <div>Tổng lần chuyển</div>
                                            </div>
                                            <div class="fa-3x">
                                                <i class="fas fa-exchange-alt"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Department Transfer History Table -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Danh sách lịch sử chuyển phòng ban
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty transfers}">
                                        <table class="table table-striped table-hover">
                                            <thead class="table-dark">
                                                <tr>
                                                    <th>STT</th>
                                                    <th>Nhân viên</th>
                                                    <th>Từ phòng ban</th>
                                                    <th>Đến phòng ban</th>
                                                    <th>Ngày chuyển</th>
                                                    <th>Lý do</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="transfer" items="${transfers}" varStatus="status">
                                                    <tr>
                                                        <td>${status.index + 1}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <div>
                                                                    <div class="fw-bold">
                                                                        ${transfer.employee.fullName}
                                                                    </div>
                                                                    <small class="text-muted"
                                                                        >${transfer.employee.employeeCode}</small
                                                                    >
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${transfer.fromDepartment != null}">
                                                                    <span class="badge bg-secondary"
                                                                        >${transfer.fromDepartment.name}</span
                                                                    >
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted fst-italic"
                                                                        >Chưa có phòng ban</span
                                                                    >
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${transfer.toDepartment != null}">
                                                                    <span class="badge bg-success"
                                                                        >${transfer.toDepartment.name}</span
                                                                    >
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted fst-italic"
                                                                        >Không có phòng ban</span
                                                                    >
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <i class="fas fa-calendar me-1"></i>
                                                            ${transfer.transferDate.dayOfMonth}/${transfer.transferDate.monthValue}/${transfer.transferDate.year}
                                                        </td>
                                                        <td>
                                                            <span
                                                                class="text-truncate"
                                                                style="max-width: 200px"
                                                                title="${transfer.reason}"
                                                            >
                                                                ${transfer.reason}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group btn-group-sm" role="group">
                                                                <a
                                                                    href="/admin/department-transfer/employee/${transfer.employee.id}"
                                                                    class="btn btn-outline-info"
                                                                    title="Xem lịch sử của nhân viên"
                                                                >
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <i class="fas fa-exchange-alt fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">Chưa có lịch sử chuyển phòng ban nào</h5>
                                            <p class="text-muted">
                                                Lịch sử sẽ được ghi lại khi có nhân viên chuyển phòng ban
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
