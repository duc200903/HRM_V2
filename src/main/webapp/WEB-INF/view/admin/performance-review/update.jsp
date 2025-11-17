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
    <meta name="author" content="" />    <title>Chỉnh sửa đánh giá hiệu suất - HRM System</title>
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
          <div class="container-fluid px-4">            
            <h1 class="mt-4">Chỉnh sửa đánh giá hiệu suất</h1>
            <ol class="breadcrumb mb-4">
              <li class="breadcrumb-item">
                <a href="/admin/dashboard">Tổng quan</a>
              </li>
              <li class="breadcrumb-item">
                <a href="/admin/performance-review">Đánh giá hiệu suất</a>
              </li>
              <li class="breadcrumb-item active">Chỉnh sửa</li>
            </ol>
            <div class="row justify-content-center">
              <div class="col-lg-7 col-md-9">
                <div class="card shadow border-0">
                  <div class="card-header bg-warning text-white">
                    <h5 class="mb-0">
                      <i class="fas fa-edit me-2"></i>Chỉnh sửa đánh giá hiệu suất
                    </h5>
                  </div>
                  <div class="card-body p-4">
                    <form:form method="post" action="/admin/performance-review/update" modelAttribute="review" class="row g-3">
                      <form:hidden path="id" />
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Nhân viên</label>
                        <input type="text" class="form-control-plaintext ps-2" value="${review.employee.fullName}" readonly />
                      </div>
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Kỳ đánh giá</label>
                        <input type="text" class="form-control-plaintext ps-2" value="${review.period}" readonly />
                      </div>
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Điểm số *</label>
                        <form:input path="score" type="number" class="form-control" min="0" max="100" required="true" />
                      </div>
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Người đánh giá *</label>
                        <form:select path="reviewer.id" class="form-select" required="true">
                          <form:option value="">-- Chọn người đánh giá --</form:option>
                          <c:forEach var="user" items="${reviewers}">
                            <form:option value="${user.id}">${user.username}</form:option>
                          </c:forEach>
                        </form:select>
                      </div>
                      <div class="mb-3">
                        <label class="form-label fw-semibold">Nhận xét</label>
                        <form:textarea path="comments" class="form-control" rows="3" placeholder="Nhận xét về hiệu suất, điểm mạnh/yếu..." />
                      </div>
                      <div class="d-flex gap-2 mt-3">
                        <button type="submit" class="btn btn-warning px-4">
                          <i class="fas fa-save me-1"></i>Cập nhật đánh giá
                        </button>
                        <a href="/admin/performance-review" class="btn btn-secondary px-4">
                          <i class="fas fa-arrow-left me-1"></i>Quay lại
                        </a>
                      </div>
                    </form:form>
                  </div>
                </div>
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
