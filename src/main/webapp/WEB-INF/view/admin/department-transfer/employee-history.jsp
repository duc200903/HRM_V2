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
        <title>Lịch sử chuyển phòng ban - ${employee.fullName} - HRM System</title>
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
                            <li class="breadcrumb-item"><a href="/admin/employee">Nhân viên</a></li>
                            <li class="breadcrumb-item">
                                <a href="/admin/department-transfer">Lịch sử chuyển phòng ban</a>
                            </li>
                            <li class="breadcrumb-item active">${employee.fullName}</li>
                        </ol>

                        <!-- Employee Info Card -->
                        <div class="card mb-4">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fas fa-user-circle me-2"></i>Thông tin nhân viên</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Họ và tên:</strong> ${employee.fullName}</p>
                                        <p><strong>Mã nhân viên:</strong> ${employee.employeeCode}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Chức vụ:</strong> ${employee.position}</p>
                                        <p>
                                            <strong>Phòng ban hiện tại:</strong>
                                            <c:choose>
                                                <c:when test="${employee.department != null}">
                                                    <span class="badge bg-success">${employee.department.name}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa phân phòng ban</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Transfer History Timeline -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-history me-1"></i>
                                Lịch sử chuyển phòng ban (${totalTransfers} lần chuyển)
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty transfers}">
                                        <div class="timeline">
                                            <c:forEach var="transfer" items="${transfers}" varStatus="status">
                                                <div class="timeline-item mb-4">
                                                    <div class="row">
                                                        <div class="col-auto">
                                                            <div class="timeline-badge bg-primary">
                                                                <i class="fas fa-exchange-alt"></i>
                                                            </div>
                                                        </div>
                                                        <div class="col">
                                                            <div class="card">
                                                                <div class="card-body">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-start mb-2"
                                                                    >
                                                                        <h6 class="card-title mb-0">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${transfer.fromDepartment == null && transfer.toDepartment != null}"
                                                                                >
                                                                                    <i
                                                                                        class="fas fa-plus-circle text-success me-1"
                                                                                    ></i>
                                                                                    Phân công vào phòng ban
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${transfer.fromDepartment != null && transfer.toDepartment == null}"
                                                                                >
                                                                                    <i
                                                                                        class="fas fa-minus-circle text-danger me-1"
                                                                                    ></i>
                                                                                    Rời khỏi phòng ban
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <i
                                                                                        class="fas fa-exchange-alt text-warning me-1"
                                                                                    ></i>
                                                                                    Chuyển phòng ban
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </h6>
                                                                        <small class="text-muted">
                                                                            <i class="fas fa-calendar me-1"></i>
                                                                            ${transfer.transferDate.dayOfMonth}/${transfer.transferDate.monthValue}/${transfer.transferDate.year}
                                                                        </small>
                                                                    </div>

                                                                    <div class="row">
                                                                        <div class="col-md-6">
                                                                            <p class="mb-1">
                                                                                <strong>Từ:</strong>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${transfer.fromDepartment != null}"
                                                                                    >
                                                                                        <span class="badge bg-secondary"
                                                                                            >${transfer.fromDepartment.name}</span
                                                                                        >
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="text-muted fst-italic"
                                                                                            >Chưa có phòng ban</span
                                                                                        >
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <p class="mb-1">
                                                                                <strong>Đến:</strong>
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${transfer.toDepartment != null}"
                                                                                    >
                                                                                        <span class="badge bg-success"
                                                                                            >${transfer.toDepartment.name}</span
                                                                                        >
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="text-muted fst-italic"
                                                                                            >Không có phòng ban</span
                                                                                        >
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </div>
                                                                    </div>

                                                                    <c:if test="${not empty transfer.reason}">
                                                                        <p class="mb-0">
                                                                            <strong>Lý do:</strong> ${transfer.reason}
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <i class="fas fa-history fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">Nhân viên này chưa có lịch sử chuyển phòng ban</h5>
                                            <p class="text-muted">
                                                Lịch sử sẽ được ghi lại khi nhân viên được chuyển phòng ban
                                            </p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="d-flex gap-2 mb-4">
                            <a href="/admin/employee/detail/${employee.id}" class="btn btn-primary">
                                <i class="fas fa-user me-1"></i>Xem thông tin nhân viên
                            </a>
                            <a href="/admin/employee/update/${employee.id}" class="btn btn-warning">
                                <i class="fas fa-edit me-1"></i>Chỉnh sửa nhân viên
                            </a>
                            <a href="/admin/department-transfer" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i>Quay lại danh sách
                            </a>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>

        <style>
            .timeline {
                position: relative;
            }

            .timeline-item {
                position: relative;
            }

            .timeline-badge {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 14px;
            }

            .timeline-item:not(:last-child)::after {
                content: '';
                position: absolute;
                left: 19px;
                top: 40px;
                bottom: -20px;
                width: 2px;
                background-color: #dee2e6;
            }
        </style>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
            crossorigin="anonymous"
        ></script>
    </body>
</html>
