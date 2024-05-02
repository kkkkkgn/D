<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page import="com.example.triptable.entity.Manager"%>
<%@page import="org.springframework.data.domain.Page"%>
<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRolename().replace("ROLE_", "") + " MANAGER";  
  String managerName = manager.getName();
  
 
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
  <link href="../wassets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="../assets/css/style.css" rel="stylesheet">
  <link href="../css/managerFont.css" rel="stylesheet" />

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
  
</head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<body>
<%@ include file='mheader.jsp'%>
<!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>연결 페이지</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">메인 페이지 관리</li>
          <li class="breadcrumb-item active">연결 페이지</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">연결 페이지 추가</h5>

              <!-- 총 건수 -->
              <b>총 1건</b> 

<!--               Search Bar -->
<!--               <div class="search-bar" > -->
<!--                 <form class="search-form" method="POST" action="/manager/accDB.do"> -->
<!--                   <b>지역명</b> -->
<!--                   <input type="text" name="address" placeholder="Search" title="Enter search keyword"> -->
<!--                   <button type="submit" title="Search"><i class="bi bi-search"></i></button> -->
<!--                 </form> -->
<!--               </div>End Search Bar -->

              <!-- 연결 링크 추가 버튼 -->
              <div class="insert-link">
                <a class="nav-link nav-icon" href="#">
                  <i class="bi bi-plus-square-fill" data-bs-toggle="modal" data-bs-target="#insertModal">링크 추가</i>
                </a><!-- End  -->

<table class="table">
  <thead>
    <tr>
      <th>링크 이름</th>
      <th>링크</th>
      <th>링크 순서</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>

<%--   	<c:forEach var="accLists" items="${accLists.content}"> --%>
<!--     <tr>    -->
<%--       <td><c:out value="${accLists.id}" /></td> --%>
<%--       <td><c:out value="${accLists.name}" /></td> --%>
<%--       <td><c:out value="${accLists.category}" /></td> --%>
<%--       <td><c:out value="${accLists.rooms}" /></td> --%>
<%--       <td><c:out value="${accLists.address}" /></td> --%>
<%--       <td><c:out value="${accLists.fee}" />원</td> --%>
<!--       <td> -->
<%--         <button type="button" class="ubtn1 btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal" data-acc-id="<c:out value='${accLists.id}' />" > --%>
<!--           수정 -->
<!--         </button> -->
<!--       </td>  -->
<!--       <td> -->
<%--         <button type="button" class="dbtn1 btn btn-primary" data-bs-toggle="modal" data-bs-target="#deleteModal" data-acc-id="<c:out value='${accLists.id}' />"> --%>
<!--           삭제 -->
<!--         </button> -->
<!--       </td> -->
<!--     </tr> -->
<%--     </c:forEach> --%>

  </tbody>
</table>


</div>
</div>

</div>
</div>

</section>

</main><!-- End #main -->

<!-- 모달들 -->
<!-- 숙소 리스트 추가 Modal -->
 <div class="modal fade" id="insertModal" tabindex="-1" >
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">숙소 추가</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="/manager/accDB_insert.do" class="insert-form" method="POST" name="ifrm" >

          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">숙소이름</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="iname">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">위도</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ilatitude">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">경도</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ilongitude">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">개요</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="isummary"></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">종류</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="icategory">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">객실 수</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="irooms">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">주소</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="iaddress">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">금액</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ifee">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">숙소링크</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ilink">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">이미지URL</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="iimage">
            </div>
          </div>
        </form>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="ibtn">추가</button>
      </div>

    </div>
  </div>
</div><!-- End 숙소리스트 추가 Modal-->

<!-- 수정 버튼 Modal -->
    <!-- The Modal -->
    <div class="modal" id="updateModal">
      <div class="modal-dialog modal-dialog-scrollable modal-dialog-left modal-lg">
        <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
       <form action="/manager/accDB_update.do" class="update-form" method="POST" name="ufrm" >		
		 <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">숙소번호</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="uid" id="id" readonly>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">숙소이름</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="uname" id="name">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">위도</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ulatitude" id="latitude" >
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">경도</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ulongitude" id="longitude">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">개요</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="usummary" ></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">종류</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ucategory" id="category">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">객실 수</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="urooms" id="rooms">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">주소</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="uaddress" id="address">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">금액</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ufee" id="fee">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">숙소링크</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="ulink" id="link">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">이미지URL</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="uimage" id="image">
            </div>
          </div>
        </form><!-- End General Form Elements -->
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="ubtn2">수정</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<!-- End 수정 버튼 Modal -->

<!-- 삭제 버튼 모달 -->
<div class="modal" id="deleteModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
    	<form action="/manager/accDB_delete.do" method="POST" name="dfrm">
      <div class="modal-header">
        <h5 class="modal-title">삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        정말 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" id="dbtn2" class="btn btn-danger">삭제</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>     
      </div>
      </form>
    </div>
  </div>
</div>
<!-- End 삭제 버튼 Modal -->
  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>TripTable</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
<!--       All the links in the footer should remain intact. -->
<!--       You can delete the links only if you purchased the pro version. -->
<!--       Licensing information: https://bootstrapmade.com/license/ -->
<!--       Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
<!--       Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
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