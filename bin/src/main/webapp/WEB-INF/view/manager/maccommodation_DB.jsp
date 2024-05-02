<%@page import="com.example.triptable.entity.Accommodation"%>
<%@page import="org.springframework.data.domain.Page"%>
<%@page import="com.example.triptable.entity.Manager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRole_name().replace("ROLE_", "") + " MANAGER";  
  
  Page<Accommodation> allLists = (Page)request.getAttribute("allLists");
 
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
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
  
</head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
window.onload = function() {
	
	document.getElementById( 'ibtn' ).onclick = function() {
		if( document.ifrm.iname.value.trim() == '' ) {
			alert( '숙소이름을 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.ilatitude.value.trim() == '' ) {
			alert( '숙소위도를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.ilongitude.value.trim() == '' ) {
			alert( '숙소경도를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.icategory.value.trim() == '' ) {
			alert( '숙소종류를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.irooms.value.trim() == '' ) {
			alert( '객실수를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.iaddress.value.trim() == '' ) {
			alert( '주소를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.ifee.value.trim() == '' ) {
			alert( '금액을 입력하셔야 합니다.' );
			return;
		}
		
		document.ifrm.submit();
	};
	
	$(document).on('click', '.ubtn1', function (event){
       
        var accId = $(event.target).data('acc-id');
        
        $.ajax({
            type: "GET",
            url: "accDB_modal.do",
            data: { accId: accId },
            success: function (result) {
               
                const modalObj = JSON.parse(result);
                
                initializeModal();
                
                $('input[name="uid"]').val(modalObj.id); 
                $('input[name="uname"]').val(modalObj.name); 
                $('input[name="ulatitude"]').val(modalObj.latitude); 
                $('input[name="ulongitude"]').val(modalObj.longitude); 
                $('textarea[name="usummary"]').val(modalObj.summary); 
                $('input[name="ucategory"]').val(modalObj.category); 
                $('input[name="urooms"]').val(modalObj.rooms); 
                $('input[name="uaddress"]').val(modalObj.address); 
                $('input[name="ufee"]').val(modalObj.fee); 
                $('input[name="ulink"]').val(modalObj.link); 
                $('input[name="uimage"]').val(modalObj.image); 
                
                console.log(accId);
               
            },
            error: function (error) {
                console.error("Error: " + error);
            }
      
    	});
        
        function initializeModal() {
        	$('input[name="uid"]').val(""); 
            $('input[name="uname"]').val(""); 
            $('input[name="ulatitude"]').val(""); 
            $('input[name="ulongitude"]').val(""); 
            $('textarea[name="usummary"]').val("");
            $('input[name="ucategory"]').val("");
            $('input[name="urooms"]').val(""); 
            $('input[name="uaddress"]').val(""); 
            $('input[name="ufee"]').val(""); 
            $('input[name="ulink"]').val(""); 
            $('input[name="uimage"]').val(""); 
        }
		
	});
	
	document.getElementById( 'ubtn2' ).onclick = function() {
		if( document.ufrm.uname.value.trim() == '' ) {
			alert( '숙소이름을 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.ulatitude.value.trim() == '' ) {
			alert( '숙소위도를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.ulongitude.value.trim() == '' ) {
			alert( '숙소경도를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.ucategory.value.trim() == '' ) {
			alert( '숙소종류를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.urooms.value.trim() == '' ) {
			alert( '객실수를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.uaddress.value.trim() == '' ) {
			alert( '주소를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.ufee.value.trim() == '' ) {
			alert( '금액을 입력하셔야 합니다.' );
			return;
		}
		
		document.ufrm.submit();
	};
	
	$(document).on('click', '.dbtn1', function (event){
		var accId = $(this).data('acc-id');
		
		$.ajax({
            type: "POST",
            url: "accDB_delete.do",
            data: { accId: accId },
            success: function (result) {

                console.log(accId);
               
            },
            error: function (error) {
                console.error("Error: " + error);
            }
		});
	});
	
// 	document.getElementById( 'dbtn2' ).onclick = function() {
// 		document.dfrm.submit();
// 	}
};
</script>
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
          <a class="nav-link pe-3" href="#">
            <i class="bi bi-box-arrow-right">홈페이지 변경</i>
          </a><!-- End 홈페이지 변경 -->

          <!-- 로그인 프로필 -->
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
              <a class="dropdown-item d-flex align-items-center" href="#">
                <i class="bi bi-box-arrow-right"></i>
                <span>Sign Out</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

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
          <a href="recommend.do">
            <i class="bi bi-circle"></i><span>추천 리스트 관리</span>
          </a>
        </li>
       
      </ul>
    </li><!-- End 여행지 추천 관리 Nav -->


    <li class="nav-item">
      <a class="nav-link" data-bs-target="#accommodation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>숙소 예약 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="accommodation-nav" class="nav-content" data-bs-parent="#sidebar-nav">
        <li>
          <a href="accDB.do" class="active">
            <i class="bi bi-circle"></i><span>숙소 DB 관리</span>
          </a>
        </li>
        <li>
          <a href="accRes.do"> <!--res: reservation-->
            <i class="bi bi-circle"></i><span>예약 내역 관리</span>
          </a>
          </li>
          </ul>
        </li><!-- End 숙소 예약 관리 Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#user-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-journal-text"></i><span>사용자 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="user-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="user.do">
            <i class="bi bi-circle"></i><span>사용자 계정 관리</span>
          </a>
        </li>
        <li>
          <a href="userDel.do">
            <i class="bi bi-circle"></i><span>탈퇴 계정 관리</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 사용자 관리 Nav -->
	
	 <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#manager-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>관리자 조작</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="manager-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="manager-agree.html" class="active">
            <i class="bi bi-circle"></i><span>관리자 등록 승인</span>
          </a>
        </li>
        <li>
          <a href="manager.do">
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
      <h1>숙소 DB 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.html">Home</a></li>
          <li class="breadcrumb-item">숙소 예약 관리</li>
          <li class="breadcrumb-item active">숙소 DB 관리</li>
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
              <b>총 <c:out value="${lists.totalElements}" />건</b> 

              <!-- Search Bar-->
              <div class="search-bar" >
                <form class="search-form" method="POST" action="/accDB.do">
                  <b>지역명</b>
                  <input type="text" name="address" placeholder="Search" title="Enter search keyword">
                  <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                </form>
              </div><!-- End Search Bar -->

              <!-- 숙소 리스트 추가 버튼 -->
              <div class="insert-accommodation ">
                <a class="nav-link nav-icon" href="#">
                  <i class="bi bi-plus-square-fill" data-bs-toggle="modal" data-bs-target="#insertModal">숙소 추가</i>
                </a><!-- End  -->
                
              
 <!-- 숙소 리스트 추가 Modal -->
 <div class="modal fade" id="insertModal" tabindex="-1" data-bs-backdrop="false">
  <div class="modal-dialog modal-dialog-scrollable modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">숙소 추가</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="/accDB_insert.do" class="insert-form" method="POST" name="ifrm" >

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


<table class="table">
  <thead>
    <tr>
      <th>숙소번호</th>
      <th>숙소이름</th>
      <th>위도</th>
      <th>경도</th>
      <th>종류</th>
      <th>객실 수</th>
      <th>주소</th>
      <th>금액</th>
      <th>링크</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>

  	<c:forEach var="allLists" items="${allLists.content}">
    <tr>   
      <td><c:out value="${allLists.id}" /></td>
      <td><c:out value="${allLists.name}" /></td>
      <td><c:out value="${allLists.latitude}" /></td>
      <td><c:out value="${allLists.longitude}" /></td>
      <td><c:out value="${allLists.category}" /></td>
      <td><c:out value="${allLists.rooms}" /></td>
      <td><c:out value="${allLists.address}" /></td>
      <td><c:out value="${allLists.fee}" /></td>
      <td><a href="${allLists.url}" target="_blank">${allLists.url}</a></td>
      <td>
        <button type="button" class="ubtn1 btn btn-primary" data-bs-toggle="modal" data-bs-target="#updateModal" data-acc-id="<c:out value='${allLists.id}' />" >
          수정
        </button>
    </td> 
      <td>
        <button type="button" class="dbtn1 btn btn-primary" data-bs-toggle="modal" data-bs-target="#deleteModal" data-acc-id="<c:out value='${allLists.id}' />">
          삭제
        </button>
      </td>
    </tr>
    </c:forEach>

  </tbody>
</table>


</div>
</div>

</div>
</div>
<!-- 페이징 -->
<div class="flex-d justify-center items-center my-3 ft-face-nm" style="margin-top: 20px;">
    <nav aria-label="표준 페이지 매김 예제">
        <ul class="pagination">
            <c:if test="${lists.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="accDB.do?page=${lists.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">«</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq lists.number ? 'active' : ''}">
                    <a class="page-link" href="accDB.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${lists.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="accDB.do?page=${lists.nextPageable().getPageNumber()}" aria-label="다음">
                        <span aria-hidden="true">»</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</section>

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
       <form action="/accDB_update.do" class="update-form" method="POST" name="ufrm" >		
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
    	<form action="./accDB_delete.do" method="POST" name="dfrm">
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
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>