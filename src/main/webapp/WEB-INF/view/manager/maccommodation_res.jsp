<%@page import="org.springframework.data.domain.Page"%>
<%@page import="com.example.triptable.entity.Manager"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">
  <!-- Template Main CSS File -->
  <link href="../assets/css/style.css" rel="stylesheet">
  <link href="../css/managerFont.css" rel="stylesheet" />
  
</head>

<body>
<%@ include file='mheader.jsp'%>
<!-- ======= main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>예약 내역 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">숙소 예약 관리</li>
          <li class="breadcrumb-item active">예약 내역 관리</li>
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
	              <b>총 <c:out value="${reservationData.totalElements}" />건</b> 
					<div class="search-bar" style="display: flex; justify-content: space-between;">
	              <!-- Search Bar-->
	                <form id="maccForm" class="search-form" method="get" action="./accRes.do" style="display: flex; justify-content: space-between;">
	                <div class="d-flex">
	                <div id="selectDiv" style="margin-right:10px">
                            <!-- select 요소 동적 추가 -->
                    </div>
	                  <input class="form-control" style="width:200px;" type="text" name="username" placeholder="회원이름 검색" title="Enter search keyword" style="margin-right:10px;"/>
	                  <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
	                  </div>
	                </form>
	              </div><!-- End Search Bar -->
              </div>

		<script>
         
         var savedState = localStorage.getItem('selectState');
                  
         if(savedState === '' || savedState === '전체'){
            selectState = 'selected';
         } else {
            selectState = '';
         }
         
         
         const selectHtml = '<select class="form-select" name="category" id="selectCategory"><option ' + selectState
         +'>전체</option><option>이용 전</option><option>이용 후</option><option>취소 중</option><option>취소 됨</option></select>';
         
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

              <!-- Table with stripped rows -->
              <table class="table" style="margin-top:30px;">
                <thead>
                  <tr>
                    <th style="text-align: center;" width="10%">예약번호</th>
                    <th style="text-align: center;" width="10%">회원이름</th>
                    <th style="text-align: center;" width="10%">숙소이름</th>
                    <th style="text-align: center;" width="10%">인원수</th>
                    <th style="text-align: center;" width="10%">체크인</th>
                    <th style="text-align: center;" width="10%">체크아웃</th>
                    <th style="text-align: center;" width="10%">금액</th>
                    <th style="text-align: center;" width="10%">예약날짜</th>
                    <th style="text-align: center;" width="8%">이용상태</th>
                    <th style="text-align: center;" width="12%">취소</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="reservation" items="${reservationData.content}" >
                      <tr>   
                        <td style="text-align: center;" width="10%">${reservation.orderNumber}</td>
                        <td style="text-align: center;" width="10%">${reservation.user.getName()}</td>
                        <td style="text-align: center;" width="10%">${reservation.accommodation.getName()}</td>
                        <td style="text-align: center;" width="10%">${reservation.guests}</td>
                        <td style="text-align: center;" width="10%">${reservation.resstart}</td>
                        <td style="text-align: center;" width="10%">${reservation.resend}</td>
                        <td style="text-align: center;" width="10%">${reservation.fee}</td>
                        <td style="text-align: center;" width="10%">${reservation.date.toString().substring(0, 10)}</td>
                        <td class="refundeStatus" style="text-align: center;" width="8%">
	                        <c:choose>
				                <c:when test="${reservation.refundStatus eq 'BEFORE_USE'}">
						            이용 전
					            </c:when>
					            <c:when test="${reservation.refundStatus eq 'AFTER_USE'}">
						            이용 후    
					            </c:when>
					             <c:when test="${reservation.refundStatus eq 'CANCELING'}">
						            취소 중    
					            </c:when>
					             <c:when test="${reservation.refundStatus eq 'CANCELED'}">
						            취소 됨      
					            </c:when>
					        </c:choose>
				        </td>
                        
                        <c:choose>
			                <c:when test="${reservation.refundStatus eq 'BEFORE_USE'}">
					            <td style="text-align: center;" width="12%">
		                        	<form action="/manager/managerCancelReservation.do" method="get">
		                        		<input type="hidden" name="resId" value="${reservation.id}"/>
			                            <button type="submit" class="cancelBtn btn btn-primary">취소</button> <!-- 예약취소 -->
		                        	</form>
				                </td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'CANCELING'}">
					            <td style="text-align: center;" width="12%">
		                        	<form action="/manager/managerCancelReservation.do" method="get">
		                        		<input type="hidden" name="resId" value="${reservation.id}"/>
			                            <button type="submit" class="cancelBtn btn btn-primary">취소</button> <!-- 예약취소 -->
		                        	</form>
				                </td>        
				            </c:when>
				            <c:otherwise>
				            	<td style="text-align: center;" width="12%">
				                	<button type="button" class="btn btn-secondary">
									      취소
									</button>
								</td>     
				           	</c:otherwise>
				        </c:choose>
                      </tr>
                  </c:forEach>      
                </tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
      
      <div class="d-flex justify-content-center my-3 ft-face-nm">
       <nav aria-label="표준 페이지 매김 예제">
           <ul class="pagination">
            <c:if test="${reservationData.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="accRes.do?page=${reservationData.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq reservationData.number ? 'active' : ''}">
                    <a class="page-link" href="accRes.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${reservationData.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="accRes.do?page=${reservationData.nextPageable().getPageNumber()}" aria-label="다음">
                        <span aria-hidden="true">›</span>
                    </a>
                </li>
            </c:if>
        </ul>
       </nav>
   </div>
    </section>

  </main><!-- End #main -->

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
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <!-- Template Main JS File -->
  <script src="../assets/js/main.js"></script>
  <script type="text/javascript" >
    $(document).ready(function(){

      $(".cancelBtn").on("click", function () {
        var result = confirm("취소하시면 다시 예약하셔야 합니다. 계속하시겠습니까?");

        if (result) {
            var resId = this.value;			          
            
        } else {
            alert("옳은 결정입니다.");
            return false; 
        }
      });

      document.addEventListener('DOMContentLoaded', function () {
        var searchForm = document.querySelector('.search-form');
    
        searchForm.addEventListener('submit', function (event) {
          var selectedRadio = document.querySelector('input[name="gridRadios"]:checked');
          if (selectedRadio) {
            var refundstatus = selectedRadio.value;
            var hiddenInput = document.createElement('input');
            hiddenInput.type = 'hidden';
            hiddenInput.name = 'refundstatus';
            hiddenInput.value = refundstatus;
            
            searchForm.appendChild(hiddenInput);
          }
        });
      });
      
    });

  </script>
</body>

</html>