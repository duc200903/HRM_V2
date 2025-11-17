<%@page contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
  <!-- Navbar Brand-->
  <a class="navbar-brand ps-3" href="/admin">HRM</a>
  <!-- Sidebar Toggle-->
  <button
    class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0"
    id="sidebarToggle"
    href="#!"
  >
    <i class="fas fa-bars"></i>
  </button>
  <!-- Navbar Search-->
  <!-- Navbar-->

</nav>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const sidebarToggle = document.getElementById("sidebarToggle");
    if (sidebarToggle) {
      sidebarToggle.addEventListener("click", function (e) {
        e.preventDefault();
        document.body.classList.toggle("sb-sidenav-toggled");
      });
    }
  });
</script>
