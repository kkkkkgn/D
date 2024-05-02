<%@page import="com.example.triptable.entity.Accommodation"%>
<%@page import="org.springframework.data.domain.Page"%>
<%@page import="com.example.triptable.entity.Manager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRolename().replace("ROLE_", "") + " MANAGER";  
  String managerName = manager.getName();
  
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
<script type="text/javascript">
window.onload = function() {
	
	document.getElementById( 'ibtn' ).onclick = function() {
		var ilatitudeValue = document.ifrm.ilatitude.value.trim();
		var ilongitudeValue = document.ifrm.ilongitude.value.trim();
		var iroomsValue = document.ifrm.irooms.value.trim();
		var ifeeValue = document.ifrm.ifee.value.trim();
		
		if( document.ifrm.iname.value.trim() == '' ) {
			alert( '숙소이름을 입력하셔야 합니다.' );
			return;
		}

		if (ilatitudeValue === '' || isNaN(ilatitudeValue)) {
		    alert('숙소위도를 숫자로 입력하셔야 합니다.');
		    return;
		}

		if (ilongitudeValue === '' || isNaN(ilongitudeValue)) {
		    alert('숙소경도를 숫자로 입력하셔야 합니다.');
		    return;
		}

		if( document.ifrm.icategory.value.trim() == '' ) {
			alert( '숙소종류를 입력하셔야 합니다.' );
			return;
		}
		if( iroomsValue === '' || isNaN(iroomsValue) ) {
			alert( '객실수를 입력하셔야 합니다.' );
			return;
		}
		if( document.ifrm.iaddress.value.trim() == '' ) {
			alert( '주소를 입력하셔야 합니다.' );
			return;
		}
		if( ifeeValue === '' || isNaN(ifeeValue)) {
			alert( '금액을 입력하셔야 합니다.' );
			return;
		}
		
		document.ifrm.submit();
	};
	
	$(document).on('click', '#ubtn1', function (event){
		       
		var accId = $('.radioButton:checked').closest('tr').find('#accId').html();
		
		if(accId == null) {
			alert('숙소를 선택하세요');
			return;
		}  
				  
		$('#updateModal').modal('show');
        
        $.ajax({
            type: "POST",
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
		var ulatitudeValue = document.ufrm.ulatitude.value.trim();
		var ulongitudeValue = document.ufrm.ulongitude.value.trim();
		var uroomsValue = document.ufrm.urooms.value.trim();
		var ufeeValue = document.ufrm.ufee.value.trim();
		
		if( document.ufrm.uname.value.trim() == '' ) {
			alert( '숙소이름을 입력하셔야 합니다.' );
			return;
		}
		if( ulatitudeValue === '' || isNaN(ulatitudeValue) ) {
			alert( '숙소위도를 입력하셔야 합니다.' );
			return;
		}
		if( ulongitudeValue === '' || isNaN(ulongitudeValue) ) {
			alert( '숙소경도를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.ucategory.value.trim() == '' ) {
			alert( '숙소종류를 입력하셔야 합니다.' );
			return;
		}
		if( uroomsValue === '' || isNaN(uroomsValue) ) {
			alert( '객실수를 입력하셔야 합니다.' );
			return;
		}
		if( document.ufrm.uaddress.value.trim() == '' ) {
			alert( '주소를 입력하셔야 합니다.' );
			return;
		}
		if( ufeeValue === '' || isNaN(ufeeValue) ) {
			alert( '금액을 입력하셔야 합니다.' );
			return;
		}
		
		document.ufrm.submit();
	};
	
	$(document).on('click', '#dbtn1', function (event){	
		
		var accId = $('.radioButton:checked').closest('tr').find('#accId').html();
		
		if(accId == null) {
			alert('숙소를 선택하세요');
			return;
		}  
		
		$('#deleteModal').modal('show');
		
	});
	
	document.getElementById( 'dbtn2' ).onclick = function() {	
		
		
		var accId = $('.radioButton:checked').closest('tr').find('#accId').html();
		  		
		$.ajax({
            type: "POST",
            url: "accDB_delete.do",
            data: { accId: accId },
            success: function (result) {
            	
            	
               
            },
            error: function (error) {
                console.error("Error: " + error);
            }
		});
		
		document.dfrm.submit();
	}
}; 
</script>
<body>
<%@ include file='mheader.jsp'%>
<!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>숙소 DB 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">숙소 예약 관리</li>
          <li class="breadcrumb-item active">숙소 DB 관리</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">

        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
			<br/>              
              
              <div class="d-flex justify-content-between">
	              <!-- 총 건수 -->
	              <b>총 <c:out value="${accLists.totalElements}" />건</b> 
					<div class="search-bar" style="display: flex; justify-content: space-between;">
	              <!-- Search Bar-->
	                <form class="search-form" method="POST" action="/manager/accDB.do" style="display: flex; justify-content: space-between;">
	                <div class="d-flex">
	                  <input class="form-control" type="text" name="address" placeholder="지역 검색" title="Enter search keyword" style="margin-right:10px;"/>
	                  <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
	                  </div>
	                </form>
	              </div><!-- End Search Bar -->
              </div>              
              
 

<table class="table" style="margin-top:30px;">
  <thead>
    <tr>
      <th style="text-align: center;" width="2%">&nbsp;</th>
      <th style="text-align: center;" width="5%">번호</th>
      <th style="text-align: center;" width="28%">숙소이름</th>
      <th style="text-align: center;" width="20%">종류</th>
      <th style="text-align: center;" width="15%">객실 수</th>
      <th style="text-align: center;" width="15%">주소</th>
      <th style="text-align: center;" width="15%">금액</th>
    </tr>
  </thead>
  <tbody>
	<!-- page는 content 붙여줘야함 -->
  	<c:forEach var="accLists" items="${accLists.content}">
    <tr>   
      <td style="text-align: center;" width="2%"><input class="form-check-input radioButton" name="select" type="radio" value=""></td> 
      <td style="text-align: center;" width="5%" id="accId"><c:out value="${accLists.id}" /></td>
      <td style="text-align: center;" width="28%"><c:out value="${accLists.name}" /></td>
      <td style="text-align: center;" width="20%"><c:out value="${accLists.category}" /></td>
      <td style="text-align: center;" width="15%"><c:out value="${accLists.rooms}" /></td>
      <td style="text-align: center;" width="15%"><c:out value="${accLists.address}" /></td>
      <td style="text-align: center;" width="15%"><c:out value="${accLists.fee}" />원</td>
    </tr>
    </c:forEach>

  </tbody>
</table>

<div class="d-flex justify-content-end" style="margin-top: 20px;">
	<a class="nav-link nav-icon ms-auto" href="#">
		<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal"><i class="bi bi-plus-square"></i> 숙소추가</button>
		<button type="button" class="btn btn-primary" id="ubtn1" ><i class="bi bi-eraser"></i> 수정</button>
		<button type="button" class="btn btn-primary" id="dbtn1"><i class="bi bi-trash"></i> 삭제</button>
	</a>
</div>

<!-- </div> -->
</div>

</div>
</div>
<!-- 페이징 -->
<div class="d-flex justify-content-center my-3 ft-face-nm">
    <nav aria-label="표준 페이지 매김 예제">
        <ul class="pagination">
            <c:if test="${accLists.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="accDB.do?page=${accLists.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq accLists.number ? 'active' : ''}">
                    <a class="page-link" href="accDB.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${accLists.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="accDB.do?page=${accLists.nextPageable().getPageNumber()}" aria-label="다음">
                        <span aria-hidden="true">›</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
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