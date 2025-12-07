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
    <meta name="author" content="" />    <title>Chỉnh sửa nhân viên - HRM System</title>
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
          <div class="container-fluid px-4">            <h1 class="mt-4">Quản lý nhân viên</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/dashboard">Tổng quan</a>
              </li>
              <li class="breadcrumb-item">
                <a href="/admin/employee">Nhân viên</a>
              </li>
              <li class="breadcrumb-item active">Chỉnh sửa</li>
            </ol>
            <div class="mt-4">
              <h2 class="mb-4">Chỉnh sửa nhân viên</h2>
              <form:form
                action="/admin/employee/update"
                method="post"
                modelAttribute="employeeUpdateRequest"
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

                <!--  ACCOUNT INFO SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-warning text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-user-lock me-2"></i>Thông tin tài khoản
                    </h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <!-- Username -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorUsername">
                          <form:errors path="username" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="username" class="form-label">
                          <i class="fas fa-user me-1"></i>Tên đăng nhập *
                        </label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorUsername ? 'is-invalid' : ''}"
                          id="username"
                          path="username"
                          placeholder="Nhập tên đăng nhập"
                        />
                        ${errorUsername}
                      </div>

                      <!-- Email -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorEmail">
                          <form:errors path="email" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="email" class="form-label">
                          <i class="fas fa-envelope me-1"></i>Email *
                        </label>
                        <form:input
                          type="email"
                          class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                          id="email"
                          path="email"
                          placeholder="Nhập email đăng nhập"
                        />
                        ${errorEmail}
                      </div>
                    </div>
                    
                    <div class="row">
                      <!-- Role -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorRole">
                          <form:errors path="role" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="role" class="form-label">
                          <i class="fas fa-user-tag me-1"></i>Vai trò
                        </label>
                        <form:select
                          class="form-select ${not empty errorRole ? 'is-invalid' : ''}"
                          id="role"
                          path="role"
                        >
                          <form:option value="employee">Nhân viên</form:option>
                          <form:option value="manager">Quản lý</form:option>
                          <form:option value="hr">HR</form:option>
                        </form:select>
                        ${errorRole}
                      </div>
                    </div>
                  </div>
                </div>

                <!--  EMPLOYEE INFO SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-id-card me-2"></i>Thông tin nhân viên
                    </h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <!-- Full Name -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorFullName">
                          <form:errors path="fullName" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="fullName" class="form-label">
                          <i class="fas fa-user me-1"></i>Họ và tên *
                        </label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                          id="fullName"
                          path="fullName"
                          placeholder="Nhập họ và tên đầy đủ"
                        />
                        ${errorFullName}
                      </div>

                      <!-- Phone -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorPhone">
                          <form:errors path="phone" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="phone" class="form-label">
                          <i class="fas fa-phone me-1"></i>Số điện thoại
                        </label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorPhone ? 'is-invalid' : ''}"
                          id="phone"
                          path="phone"
                          placeholder="Nhập số điện thoại"
                        />
                        ${errorPhone}
                      </div>
                    </div>

                    <div class="row">
                      <!-- Position -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorPosition">
                          <form:errors path="position" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="position" class="form-label">
                          <i class="fas fa-briefcase me-1"></i>Chức vụ
                        </label>
                        <form:input
                          type="text"
                          class="form-control ${not empty errorPosition ? 'is-invalid' : ''}"
                          id="position"
                          path="position"
                          placeholder="Nhập chức vụ"
                        />
                        ${errorPosition}
                      </div>

                      <!-- Department -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorDepartmentId">
                          <form:errors path="departmentId" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="departmentId" class="form-label">
                          <i class="fas fa-building me-1"></i>Phòng ban
                        </label>
                        <form:select
                          class="form-select ${not empty errorDepartmentId ? 'is-invalid' : ''}"
                          id="departmentId"
                          path="departmentId"
                        >
                          <form:option value="">-- Chọn phòng ban --</form:option>
                          <c:forEach var="dept" items="${departments}">
                            <form:option value="${dept.id}">${dept.name}</form:option>
                          </c:forEach>
                        </form:select>
                        ${errorDepartmentId}
                      </div>
                    </div>

                    <div class="row">                      <!-- Date of Birth -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorDob">
                          <form:errors path="dob" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="dob" class="form-label">
                          <i class="fas fa-birthday-cake me-1"></i>Ngày sinh
                        </label>
                        <form:input
                          type="date"
                          class="form-control ${not empty errorDob ? 'is-invalid' : ''}"
                          id="dob"
                          path="dob"
                          value="${employeeUpdateRequest.formattedDob}"
                        />
                        ${errorDob}
                      </div>

                      <!-- Hire Date -->
                      <div class="col-md-6 mb-3">
                        <c:set var="errorHireDate">
                          <form:errors path="hireDate" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="hireDate" class="form-label">
                          <i class="fas fa-calendar-plus me-1"></i>Ngày vào làm
                        </label>
                        <form:input
                          type="date"
                          class="form-control ${not empty errorHireDate ? 'is-invalid' : ''}"
                          id="hireDate"
                          path="hireDate"
                          value="${employeeUpdateRequest.formattedHireDate}"
                        />
                        ${errorHireDate}
                      </div>
                    </div>

                    <!-- Address -->
                    <div class="row">
                      <div class="col-12 mb-3">
                        <c:set var="errorAddress">
                          <form:errors path="address" cssClass="invalid-feedback" />
                        </c:set>
                        <label for="address" class="form-label">
                          <i class="fas fa-map-marker-alt me-1"></i>Địa chỉ
                        </label>
                        <form:textarea
                          class="form-control ${not empty errorAddress ? 'is-invalid' : ''}"
                          id="address"
                          path="address"
                          rows="2"
                          placeholder="Nhập địa chỉ liên hệ"
                        />
                        ${errorAddress}
                      </div>
                    </div>                  </div>
                </div>

                <!--  SALARY AND ALLOWANCE SECTION -->
                <div class="card mb-4">
                  <div class="card-header bg-success text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-money-bill-wave me-2"></i>Thông tin lương và phụ cấp
                    </h5>
                  </div>
                  <div class="card-body">
                    <div class="row">
                      <!-- Employee Code -->
                      <div class="col-md-6 mb-3">
                        <label for="employeeCode" class="form-label">
                          <i class="fas fa-id-badge me-1"></i>Mã nhân viên
                        </label>
                        <form:input
                          type="text"
                          class="form-control"
                          id="employeeCode"
                          path="employeeCode"
                          placeholder="Mã nhân viên"
                        />
                        <small class="form-text text-muted">
                          <i class="fas fa-info-circle me-1"></i>Mã định danh nhân viên
                        </small>
                      </div>
                      
                      <!-- Base Salary -->
                      <div class="col-md-6 mb-3">
                        <label for="baseSalary" class="form-label">
                          <i class="fas fa-dollar-sign me-1"></i>Lương cơ bản (VNĐ)
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="baseSalary"
                          path="baseSalary"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.baseSalary != null && employeeUpdateRequest.baseSalary.longValue() > 0 ? employeeUpdateRequest.baseSalary.longValue() : ''}"
                        />
                      </div>
                    </div>
                    
                    <div class="row">
                      <!-- Allowance Meal -->
                      <div class="col-md-4 mb-3">
                        <label for="allowanceMeal" class="form-label">
                          <i class="fas fa-utensils me-1"></i>Phụ cấp tiền ăn
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="allowanceMeal"
                          path="allowanceMeal"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.allowanceMeal != null && employeeUpdateRequest.allowanceMeal.longValue() > 0 ? employeeUpdateRequest.allowanceMeal.longValue() : ''}"
                        />
                      </div>
                      
                      <!-- Allowance Transport -->
                      <div class="col-md-4 mb-3">
                        <label for="allowanceTransport" class="form-label">
                          <i class="fas fa-car me-1"></i>Phụ cấp tiền xe
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="allowanceTransport"
                          path="allowanceTransport"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.allowanceTransport != null && employeeUpdateRequest.allowanceTransport.longValue() > 0 ? employeeUpdateRequest.allowanceTransport.longValue() : ''}"
                        />
                      </div>
                      
                      <!-- Allowance Seniority -->
                      <div class="col-md-4 mb-3">
                        <label for="allowanceSeniority" class="form-label">
                          <i class="fas fa-medal me-1"></i>Phụ cấp thâm niên
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="allowanceSeniority"
                          path="allowanceSeniority"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.allowanceSeniority != null && employeeUpdateRequest.allowanceSeniority.longValue() > 0 ? employeeUpdateRequest.allowanceSeniority.longValue() : ''}"
                        />
                      </div>
                    </div>
                    
                    <div class="row">
                      <!-- Insurance Health -->
                      <div class="col-md-4 mb-3">
                        <label for="insuranceHealth" class="form-label">
                          <i class="fas fa-heartbeat me-1"></i>Bảo hiểm y tế
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="insuranceHealth"
                          path="insuranceHealth"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.insuranceHealth != null && employeeUpdateRequest.insuranceHealth.longValue() > 0 ? employeeUpdateRequest.insuranceHealth.longValue() : ''}"
                        />
                      </div>
                      
                      <!-- Insurance Social -->
                      <div class="col-md-4 mb-3">
                        <label for="insuranceSocial" class="form-label">
                          <i class="fas fa-shield-alt me-1"></i>Bảo hiểm xã hội
                        </label>                        <form:input
                          type="number"
                          class="form-control"
                          id="insuranceSocial"
                          path="insuranceSocial"
                          placeholder="0"
                          min="0"
                          step="1000"
                          value="${employeeUpdateRequest.insuranceSocial != null && employeeUpdateRequest.insuranceSocial.longValue() > 0 ? employeeUpdateRequest.insuranceSocial.longValue() : ''}"
                        />
                      </div>
                      
                      <!-- Remaining Leave Days -->
                      <div class="col-md-4 mb-3">
                        <label for="remainingLeaveDays" class="form-label">
                          <i class="fas fa-calendar-alt me-1"></i>Số ngày phép còn lại
                        </label>
                        <form:input
                          type="number"
                          class="form-control"
                          id="remainingLeaveDays"
                          path="remainingLeaveDays"
                          placeholder="12"
                          min="0"
                          max="365"
                        />
                      </div>
                    </div>
                    
                    <!-- Salary Summary -->
                    <div class="alert alert-info">
                      <h6><i class="fas fa-calculator me-1"></i>Tóm tắt lương:</h6>
                      <div class="row">
                        <div class="col-md-4">
                          <small>
                            <strong>Tổng thu nhập:</strong> 
                            <span id="totalSalary">0 VNĐ</span>
                          </small>
                        </div>
                        <div class="col-md-4">
                          <small>
                            <strong>Tổng khấu trừ:</strong> 
                            <span id="totalInsurance">0 VNĐ</span>
                          </small>
                        </div>
                        <div class="col-md-4">
                          <small>
                            <strong>Lương thực lãnh:</strong> 
                            <span id="netSalary" class="fw-bold text-success">0 VNĐ</span>
                          </small>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!--  Info alert -->
                <div class="alert alert-info">
                  <i class="fas fa-info-circle me-2"></i>
                  <small>Các trường có dấu (*) là bắt buộc. Thông tin lương sẽ được cập nhật theo thay đổi.</small>
                </div>

                <!--  Action buttons -->
                <div class="d-flex gap-2">
                  <button type="submit" class="btn btn-warning">
                    <i class="fas fa-save me-1"></i>Cập nhật nhân viên
                  </button>
                  <a href="/admin/employee" class="btn btn-secondary">
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
    
    <!--  JavaScript for real-time salary calculation -->
    <script>
    function formatCurrency(amount) {
      return new Intl.NumberFormat('vi-VN').format(amount) + ' VNĐ';
    }

    function calculateSalary() {
      const baseSalary = parseFloat(document.getElementById('baseSalary').value) || 0;
      const allowanceMeal = parseFloat(document.getElementById('allowanceMeal').value) || 0;
      const allowanceTransport = parseFloat(document.getElementById('allowanceTransport').value) || 0;
      const allowanceSeniority = parseFloat(document.getElementById('allowanceSeniority').value) || 0;
      const insuranceHealth = parseFloat(document.getElementById('insuranceHealth').value) || 0;
      const insuranceSocial = parseFloat(document.getElementById('insuranceSocial').value) || 0;
      
      const totalSalary = baseSalary + allowanceMeal + allowanceTransport + allowanceSeniority;
      const totalInsurance = insuranceHealth + insuranceSocial;
      const netSalary = totalSalary - totalInsurance;
      
      document.getElementById('totalSalary').textContent = formatCurrency(totalSalary);
      document.getElementById('totalInsurance').textContent = formatCurrency(totalInsurance);
      document.getElementById('netSalary').textContent = formatCurrency(netSalary);
    }

    // Bind events để tính toán real-time
    document.addEventListener('DOMContentLoaded', function() {
      const salaryInputs = [
        'baseSalary', 'allowanceMeal', 'allowanceTransport', 'allowanceSeniority', 
        'insuranceHealth', 'insuranceSocial'
      ];
      
      salaryInputs.forEach(id => {
        const element = document.getElementById(id);
        if (element) {
          element.addEventListener('input', calculateSalary);
          element.addEventListener('change', calculateSalary);
        }
      });
      
      // Delay để đảm bảo form được load đầy đủ trước khi tính toán
      setTimeout(calculateSalary, 100);
    });
    </script>
  </body>
</html>
