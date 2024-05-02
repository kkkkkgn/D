<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import ="com.example.triptable.entity.Manager" %>

<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRole_name().replace("ROLE_", "") + " MANAGER";  
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>TripTable</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="../assets/img/favicon.png" rel="icon">
  <link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="../assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<!-- <script>
  alert('경고');
</script> -->
<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="dashboard.html" class="logo d-flex align-items-center">
        <img src="assets/img/logo.png" alt="">
        <span class="d-none d-lg-block">TripTable_Manager</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
       
        <!-- 홈페이지 변경(사용자 메인으로 이동 버튼) -->
        <a class="nav-link pe-3" href="index.do">
          <i class="bi bi-box-arrow-right">홈페이지 변경</i>
        </a><!-- End Notification Icon -->

<!--           로그인 프로필 -->
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <span class="d-none d-md-block dropdown-toggle ps-2"><c:out value="${manager.getName()}"/></span>
          </a>
          
          <!-- end 로그인 프로필-->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><c:out value="${manager.getName()}"/></h6>
              <span><%= managerRole %></span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="/logout">
                <i class="bi bi-box-arrow-right"></i>
                <span>로그아웃</span>
              </a>
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="#" data-bs-toggle="modal" data-bs-target="#cancelModal">
                <i class="bi bi-box-arrow-right"></i>
                <span>회원 탈퇴</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>

     
    </nav><!-- End Icons Navigation -->

   

  </header><!-- End Header -->

  <div class="modal" id="cancelModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
        <form action="../muser_delete_ok.do">
        <div class="modal-header">
            <h5 class="modal-title">회원탈퇴</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body text-center">
            <div class="text-center" style="font-weight: 700;">
                    <h2>정말 탈퇴하시겠습니까?<br />
                    탈퇴 버튼을 누르면 관리자 권한이 사라집니다</h2>
                </div>
                
                
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="submit" class="btn btn-primary">탈퇴</button>
        </div>
        </form>
        </div>
    </div>
    </div><!-- End 회원탈퇴 Modal-->


 <!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

  <ul class="sidebar-nav" id="sidebar-nav">

    <li class="nav-item">
      <a class="nav-link collapsed" href="dashboard.html">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#recommendation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>여행지 추천 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="recommendation-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="/recommend.do">
            <i class="bi bi-circle"></i><span>추천 리스트 관리</span>
          </a>
        </li>
       
      </ul>
    </li><!-- End 여행지 추천 관리 Nav -->


    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#accommodation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>숙소 예약 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="accommodation-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="/accDB.do">
            <i class="bi bi-circle"></i><span>숙소 DB 관리</span>
          </a>
        </li>
        <li>
          <a href="/accRes.do"> <!--res: reservation-->
            <i class="bi bi-circle"></i><span>예약 내역 관리</span>
          </a>
          </li>
          </ul>
        </li><!-- End 숙소 예약 관리 Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#user-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>사용자 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="user-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="/user.do">
            <i class="bi bi-circle"></i><span>사용자 계정 관리</span>
          </a>
        </li>
        <li>
          <a href="/userDel.do">
            <i class="bi bi-circle"></i><span>탈퇴 계정 관리</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 사용자 관리 Nav -->
    
    
    <li class="nav-item">
      <a class="nav-link" data-bs-target="#manager-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>관리자 조작</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="manager-nav" class="nav-content" data-bs-parent="#sidebar-nav">
        <li>
          <a href="manager-agree.html">
            <i class="bi bi-circle"></i><span>관리자 등록 승인</span>
          </a>
        </li>
        <li>
          <a href="manager.do" class="active">
            <i class="bi bi-circle"></i><span>기존 관리자 list</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 관리자 승인 Nav -->


  </ul>

</aside><!-- End Sidebar-->


  <!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>기존 관리자 list</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.html">Home</a></li>
          <li class="breadcrumb-item">관리자 조작</li>
          <li class="breadcrumb-item active">기존 관리자 list</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Datatables</h5>
              
              <!-- 총 건수 -->
              <b>총 <c:out value="${fn:length(lists)}" />건</b>
              
              <!-- Search Bar-->
              <div class="search-bar" >
                <form class="search-form" method="POST" action="/manager.do">
                  <b>관리자이름</b>
                  <input type="text" name="mname" placeholder="Search" title="Enter search keyword">
                  <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                </form>
                
              </div><!-- End Search Bar -->


              <!-- Table  -->
              <table class="table">
                <thead>
                  <tr>
                    <th>관리자번호</th>
                    <th>관리자이름</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                    <th>가입일</th>
                    <th>권한</th>
                  </tr>
                </thead>
                <tbody>
            
				  <c:forEach var="lists" items="${lists}">
				    <tr>
				      <td><c:out value="${lists.id}" /></td>
				      <td><c:out value="${lists.name}" /></td>
				      <td><c:out value="${lists.tel}" /></td>
				      <td><c:out value="${lists.mail}" /></td>
				      <td> <fmt:formatDate value="${lists.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				      <td><c:out value="${lists.managerRole.role_name}" /></td>
				    </tr>
				  </c:forEach> 
				           
                </tbody>
              </table>
              <!-- End Table -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="../assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/vendor/chart.js/chart.umd.js"></script>
  <script src="../assets/vendor/echarts/echarts.min.js"></script>
  <script src="../assets/vendor/quill/quill.min.js"></script>
  <script src="../assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="../assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="../assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="../assets/js/main.js"></script>

</body>

</html>