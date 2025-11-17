<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@taglib
uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, shrink-to-fit=no"
    />
     <link
      rel="shortcut icon"
      href="https://p9-sign-sg.tiktokcdn.com/tos-alisg-avt-0068/6d8e3cd4e9b4ca85588b574be866ddfc~tplv-tiktokx-cropcenter:1080:1080.jpeg?dr=14579&refresh_token=24adab12&x-expires=1752980400&x-signature=Kp96fh33zTEkIUAUiYyoP8Mg33Y%3D&t=4d5b0474&ps=13740610&shp=a5d48078&shcp=81f88b70&idc=my"
      type="image/x-icon"
    />
    <meta name="description" content="" />
    <meta name="author" content="" />    <title>Chỉnh sửa khóa đào tạo - HRM System</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>

</script>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <body class="sb-nav-fixed">
   <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">            <h1 class="mt-4">Quản lý đào tạo</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/dashboard">Tổng quan</a>
              </li>
              <li class="breadcrumb-item">
                <a href="/admin/training">Đào tạo</a>
              </li>
              <li class="breadcrumb-item active">Chỉnh sửa</li>
            </ol>            <div class="mt-4">
              <h2 class="mb-4">Chỉnh sửa khóa đào tạo</h2>
              <form:form
                action="/admin/training/update"
                method="post"
                modelAttribute="training"
              >                <div class="mb-3" style="display: none">
                  <label for="text" class="form-label">ID</label>
                  <form:input
                    type="text"
                    class="form-control"
                    id="text"
                    name="id"
                    path="id"
                    placeholder="Enter text"
                  />
                </div>

                <!-- ✅ TRAINING INFO SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-warning text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-graduation-cap me-2"></i>Thông tin khóa đào tạo
                    </h5>
                  </div>                  <div class="card-body">
                    <div class="row">
                      <!-- Title -->
                      <div class="col-md-12 mb-3">
                        <c:set var="errorTitle">
                          <form:errors path="title" cssClass="invalid-feedback" />
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
                </div>                <!-- ✅ PARTICIPANTS RESULTS SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-users me-2"></i>Quản lý kết quả đào tạo
                    </h5>
                  </div>                  <div class="card-body">
                    <c:if test="${not empty employeeTrainings}">
                      <div class="table-responsive">
                        <table class="table table-striped table-hover">
                          <thead class="table-dark">
                            <tr>                              <th><i class="fas fa-hashtag me-1"></i>STT</th>
                              <th><i class="fas fa-user me-1"></i>Nhân viên</th>
                              <th><i class="fas fa-building me-1"></i>Phòng ban</th>
                              <th><i class="fas fa-briefcase me-1"></i>Chức vụ</th>
                              <th><i class="fas fa-trophy me-1"></i>Kết quả</th>
                            </tr>
                          </thead>
                          <tbody>
                            <c:forEach var="employeeTraining" items="${employeeTrainings}" varStatus="status">
                              <tr>
                                <td><span class="badge bg-secondary">${status.index + 1}</span></td>
                                <td>
                                  <div class="d-flex align-items-center">
                                    <i class="fas fa-user text-primary me-2"></i>
                                    <strong>${employeeTraining.employee.fullName}</strong>
                                  </div>
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${not empty employeeTraining.employee.department}">
                                      <span class="badge bg-success">
                                        <i class="fas fa-building me-1"></i>
                                        ${employeeTraining.employee.department.name}
                                      </span>
                                    </c:when>
                                    <c:otherwise>
                                      <span class="text-muted">Chưa phân phòng ban</span>
                                    </c:otherwise>
                                  </c:choose>
                                </td>
                                <td>
                                  <c:choose>
                                    <c:when test="${not empty employeeTraining.employee.position}">
                                      <span class="badge bg-info">
                                        <i class="fas fa-briefcase me-1"></i>
                                        ${employeeTraining.employee.position}
                                      </span>
                                    </c:when>
                                    <c:otherwise>
                                      <span class="text-muted">Chưa có chức vụ</span>
                                    </c:otherwise>
                                  </c:choose>
                                </td>                                <td>
                                  <select class="form-select form-select-sm" 
                                          name="employeeTrainingResults[${employeeTraining.id}]">
                                    <option value="Pending" ${employeeTraining.result == 'Pending' ? 'selected' : ''}>Đang học</option>
                                    <option value="Pass" ${employeeTraining.result == 'Pass' ? 'selected' : ''}>Đạt</option>
                                    <option value="Fail" ${employeeTraining.result == 'Fail' ? 'selected' : ''}>Không đạt</option>
                                  </select>
                                </td>
                              </tr>
                            </c:forEach>
                          </tbody>
                        </table>
                      </div>
                    </c:if>
                    <c:if test="${empty employeeTrainings}">
                      <div class="text-center py-4">
                        <i class="fas fa-users fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">Chưa có nhân viên tham gia khóa đào tạo này</h5>
                      </div>
                    </c:if>
                  </div>
                </div>                <!-- ✅ Info alert -->
                <div class="alert alert-info">
                  <i class="fas fa-info-circle me-2"></i>
                  <small>Các trường có dấu (*) là bắt buộc. Thay đổi kết quả đào tạo và nhấn "Cập nhật khóa đào tạo" để lưu tất cả.</small>
                </div>

                <!-- ✅ Action buttons -->
                <div class="d-flex gap-2">
                  <button type="submit" class="btn btn-warning">
                    <i class="fas fa-save me-1"></i>Cập nhật khóa đào tạo
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
    </div>    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
