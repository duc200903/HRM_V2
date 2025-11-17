<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Thêm đánh giá hiệu suất</title>
    <link href="/css/styles.css" rel="stylesheet" />
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="/WEB-INF/view/layout/header.jsp" />
    <div id="layoutSidenav">
      <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
      <div id="layoutSidenav_content">
        <main>
          <div class="container-fluid px-4">
            <h1 class="mt-4">Thêm đánh giá hiệu suất</h1>
            <form:form method="post" modelAttribute="review" class="row g-3">
              <!-- Nhân viên -->
              <div class="col-md-6">
                <label for="employee" class="form-label">Nhân viên</label>
                <form:select path="employee.id" cssClass="form-select">
                  <form:options
                    items="${employees}"
                    itemValue="id"
                    itemLabel="fullName"
                  />
                </form:select>
              </div>

              <!-- Kỳ đánh giá -->
              <div class="col-md-6">
                <label for="period" class="form-label">Kỳ đánh giá</label>
                <form:input
                  path="period"
                  cssClass="form-control"
                  placeholder="VD: 2025-Q4"
                />
              </div>

              <!-- Điểm -->
              <div class="col-md-12">
                <label for="score" class="form-label">Điểm số</label>
                <form:input
                  path="score"
                  type="number"
                  cssClass="form-control"
                  min="0"
                  max="100"
                />
              </div>

              <form:hidden path="reviewer.id" />

              <!-- Nhận xét -->
              <div class="col-md-12">
                <label for="comments" class="form-label">Nhận xét</label>
                <form:textarea
                  path="comments"
                  cssClass="form-control"
                  rows="3"
                />
              </div>

              <!-- Submit -->
              <div class="col-12">
                <button type="submit" class="btn btn-success">
                  <i class="fas fa-save me-1"></i> Lưu đánh giá
                </button>
                <a href="/admin/performance-review" class="btn btn-secondary"
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
