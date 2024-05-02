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
	
}; 
</script>
<body>
<%@ include file='mheader.jsp'%>
<!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>결제 내역 조회</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">숙소 예약 관리</li>
          <li class="breadcrumb-item active">결제 내역 조회</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
       	<div class="col-lg-12">
          <div class="card">
            <div class="card-body">
            <br/>
              <div class="d-flex justify-content-between">
	              <!-- 총 건수 -->
	              <b>총 <c:out value="${logData.totalElements}" />건</b> 
					<div class="search-bar" style="display: flex; justify-content: space-between;">
	              <!-- Search Bar-->
	                <form id="maccForm" class="search-form" method="get" action="./payLog.do" style="display: flex; justify-content: space-between;">
	                	<div class="d-flex">
	                	<div id="selectDiv" style="margin-right:10px">
                            <!-- select 요소 동적 추가 -->
                    	</div>
	                  	</div>
	                </form>
	             	 </div><!-- End Search Bar -->
              </div>
              <script>
         
         var savedState = localStorage.getItem('selectState');
                  
         if(savedState === null || savedState === '전체'){
            selectState = 'selected';
         } else {
            selectState = '';
         }
         
         
         const selectHtml = '<select class="form-select" name="logStarter" id="selectCategory"><option ' + selectState
         +'>전체</option><option>결제 승인</option><option>취소 요청</option><option>취소 승인</option></select>';
         
         const selectDiv = document.getElementById('selectDiv');
         selectDiv.innerHTML = selectHtml;
         
          var selectCategory = document.querySelector('#selectCategory');
          
          if(savedState){
             selectCategory.value = savedState;
          }
          
          selectCategory.addEventListener('change', function(){
             
             var category = selectCategory.value;
             
             localStorage.setItem('selectState', category);
             
             document.getElementById('maccForm').submit(); 
             
          });
         </script>
				<table class="table" style="margin-top:30px;">
				  <thead>
				    <tr>
				      <th>로그 내역</th>
				    </tr>
				  </thead>
				  <tbody>
				  	<c:forEach var="payLog" items="${logData.content}" >
				      <tr>
				        <td>${payLog.logData}</td>
				      </tr>
					</c:forEach>
				  </tbody>
				</table>
			</div>
		</div>

		</div>
	</div>
<!-- 페이징 -->
<div class="d-flex justify-content-center my-3 ft-face-nm">
    <nav aria-label="표준 페이지 매김 예제">
        <ul class="pagination">
            <c:if test="${logData.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="payLog.do?page=${logData.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq logData.number ? 'active' : ''}">
                    <a class="page-link" href="payLog.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${logData.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="payLog.do?page=${logData.nextPageable().getPageNumber()}" aria-label="다음">
                        <span aria-hidden="true">›</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </nav>
</div>
</section>

</main><!-- End #main -->
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