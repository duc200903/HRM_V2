<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Thêm tin tuyển dụng - HRM System</title>
    <link href="/css/styles.css" rel="stylesheet" />
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Thêm tin tuyển dụng</h1>
            <form:form
              method="post"
              modelAttribute="recruitment"
              class="row g-3"
            >
              <div class="col-md-6">
                <label for="title" class="form-label"
                  >Vị trí tuyển dụng *</label
                >
                <form:input
                  path="title"
                  cssClass="form-control"
                  placeholder="VD: Lập trình viên Java"
                  required="true"
                />
              </div>
              <div class="col-md-6">
                <label for="department" class="form-label">Phòng ban *</label>
                <form:select
                  path="department.id"
                  cssClass="form-select"
                  required="true"
                >
                  <form:options
                    items="${departments}"
                    itemValue="id"
                    itemLabel="name"
                  />
                </form:select>
              </div>
              <div class="col-md-12">
                <label for="description" class="form-label"
                  >Mô tả công việc</label
                >
                <form:textarea
                  path="description"
                  cssClass="form-control"
                  rows="3"
                  placeholder="Mô tả chi tiết về công việc, yêu cầu, quyền lợi..."
                />
              </div>
              <div class="col-md-6">
                <label for="status" class="form-label">Trạng thái</label>
                <form:select path="status" cssClass="form-select">
                  <form:option value="open">Đang mở</form:option>
                </form:select>
              </div>
              <div class="col-md-3">
                <label for="startDate" class="form-label">Ngày bắt đầu</label>
                <form:input
                  path="startDate"
                  type="date"
                  cssClass="form-control"
                />
              </div>
              <div class="col-md-3">
                <label for="endDate" class="form-label">Ngày kết thúc</label>
                <form:input
                  path="endDate"
                  type="date"
                  cssClass="form-control"
                />
              </div>
              <div class="col-12 mt-3">
                <button type="submit" class="btn btn-success">
                  <i class="fas fa-save me-1"></i> Lưu tin tuyển dụng
                </button>
                <a href="/admin/recruitment" class="btn btn-secondary"
                  >Quay lại</a
                >
              </div>
            </form:form>
          </div>
        </main>
        <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
      </div>
    </div>
  </body>
</html>
