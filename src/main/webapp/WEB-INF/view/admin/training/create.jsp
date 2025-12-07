<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form" %> <%@taglib
prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="en">
  <head>
   <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />    <title>Tạo khóa đào tạo mới - HRM System</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
  </head>

  <body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>          <div class="container-fluid px-4">
            <h1 class="mt-4">Quản lý đào tạo</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/dashboard">Tổng quan</a>
              </li>
              <li class="breadcrumb-item">
                <a href="/admin/training">Đào tạo</a>
              </li>
              <li class="breadcrumb-item active">Thêm mới</li>
            </ol>            <div class="mt-4">
              <h2 class="mb-4">Thêm khóa đào tạo mới</h2>
              <form:form
                action="/admin/training/create"
                method="post"
                modelAttribute="training"
              >
                <!--  TRAINING INFO SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-graduation-cap me-2"></i>Thông tin khóa đào tạo
                    </h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <!-- Title -->
                      <div class="col-md-12 mb-3">
                        <c:set var="errorTitle">
                          <form:errors
                            path="title"
                            cssClass="invalid-feedback"
                          />
                        </c:set>
                        <label for="title" class="form-label">
                          <i class="fas fa-graduation-cap me-1"></i>Tên khóa học *
                        </label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorTitle ? 'is-invalid' : ''}"
                          id="title"
                          path="title"
                          placeholder="Nhập tên khóa đào tạo"
                        />
                        ${errorTitle}
                      </div>
                    </div>

                    <div class="row">
                      <!-- Start Date -->
                      <div class="col-md-6 mb-3">
                        <label for="startDate" class="form-label">
                          <i class="fas fa-calendar-alt me-1"></i>Ngày bắt đầu
                        </label>                        
                        <form:input
                          type="date"
                          class="form-control"
                          id="startDate"
                          path="startDate"
                          pattern="yyyy-MM-dd"
                        />
                      </div>

                      <!-- End Date -->
                      <div class="col-md-6 mb-3">
                        <label for="endDate" class="form-label">
                          <i class="fas fa-calendar-check me-1"></i>Ngày kết thúc
                        </label>                        
                        <form:input
                          type="date"
                          class="form-control"
                          id="endDate"
                          path="endDate"
                          pattern="yyyy-MM-dd"
                        />
                      </div>
                    </div>

                    <!-- Link -->
                    <div class="row">
                      <div class="col-12 mb-3">
                        <label for="link" class="form-label">
                          <i class="fas fa-link me-1"></i>Link khóa học
                        </label>
                        <form:input
                          type="url"
                          class="form-control"
                          id="link"
                          path="link"
                          placeholder="https://example.com/training"
                        />
                        <small class="form-text text-muted">
                          <i class="fas fa-info-circle me-1"></i>Link tài liệu hoặc khóa học online (tùy chọn)
                        </small>
                      </div>
                    </div>

                    <!-- Description -->
                    <div class="row">
                      <div class="col-12 mb-3">
                        <label for="description" class="form-label">
                          <i class="fas fa-info-circle me-1"></i>Mô tả khóa học
                        </label>
                        <form:textarea
                          class="form-control"
                          id="description"
                          path="description"
                          rows="4"
                          placeholder="Nhập mô tả chi tiết về khóa đào tạo..."
                        />
                      </div>
                    </div>
                  </div>
                </div>

                <!--  EMPLOYEE SELECTION SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-users me-2"></i>Chọn nhân viên tham gia
                    </h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <div class="col-12 mb-3">
                        <label class="form-label">
                          <i class="fas fa-check-square me-1"></i>Danh sách nhân viên
                        </label>
                        <div class="border rounded p-3" style="max-height: 300px; overflow-y: auto;">
                          <c:forEach var="employee" items="${employees}">
                            <div class="form-check mb-2">
                              <input class="form-check-input" type="checkbox" name="selectedEmployees" 
                                     value="${employee.id}" id="employee_${employee.id}">
                              <label class="form-check-label" for="employee_${employee.id}">
                                <strong>${employee.fullName}</strong>
                                <c:if test="${not empty employee.department}">
                                  <span class="badge bg-info ms-2">${employee.department.name}</span>
                                </c:if>
                                <c:if test="${not empty employee.position}">
                                  <span class="badge bg-secondary ms-1">${employee.position}</span>
                                </c:if>
                              </label>
                            </div>
                          </c:forEach>
                        </div>
                        <small class="form-text text-muted">
                          <i class="fas fa-info-circle me-1"></i>Chọn các nhân viên sẽ tham gia khóa đào tạo này
                        </small>
                      </div>
                    </div>
                  </div>
                </div>

                <!--  INFO ALERT -->
                <div class="alert alert-info">
                  <i class="fas fa-info-circle me-2"></i>
                  <small>
                    Các trường có dấu (*) là bắt buộc. Bạn có thể chọn nhiều nhân viên để tham gia khóa đào tạo.
                  </small>
                </div>

                <!--  ACTION BUTTONS -->
                <div class="d-flex gap-2">
                  <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus me-1"></i>Tạo khóa đào tạo
                  </button>
                  <a href="/admin/training" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i>Quay lại
                  </a>
                </div>
              </form:form>
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
