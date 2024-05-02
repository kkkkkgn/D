<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import ="com.example.triptable.entity.Manager" %>
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

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
  
</head>

<body>
<%@ include file='mheader.jsp'%>
  <!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>탈퇴 계정 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">사용자 관리</li>
          <li class="breadcrumb-item active">탈퇴 계정 관리</li>
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
             <b>총 <c:out value="${lists.totalElements}" />건</b>
             <div class="search-bar ms-auto">
                 <form action="duserInfo.do" id="searchForm" class="search-form" method="GET">
                     <div class="d-flex">
                        <div id ="selectDiv" class="col-sm-2" style="width:200px;">
							<!-- javascript 코드로 select 요소를 추가할 예정-->
							<!-- 전체, 다른 플랫폼으로 이전, 서비스 불만족, 계정보안문제, 기타 등 탈퇴사유를 선택해서 볼 수 있음 -->
							<!-- 선언하면 default 값 때문에 딜레이돼서 라디오 값이 바뀌는게 보여서 보기 안좋음 -->
		                  </div>
                         &nbsp;
                         <input class="form-control" style="width:200px;" type="text" name="user" title="Enter search keyword" id="searchInput" placeholder="회원이름 검색">
                         &nbsp;
                         <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
                     </div>
                 </form>
             </div><!-- End Search Bar -->
         </div>
            
                
              <!-- Table with stripped rows -->
              <table class="table" style="margin-top:30px">
                <thead>
                  <tr>
                    <th style="text-align: center;">회원번호</th>
                    <th style="text-align: center;">회원이름</th>
                    <th style="text-align: center;">메일</th>
                    <th style="text-align: center;">탈퇴 날짜</th>
                    <th style="text-align: center;">탈퇴 사유</th>
                  </tr>
                </thead>
                <tbody>
                
                  <c:forEach var="lists" items="${lists.content}">
				    <tr>
				      <td style="text-align: center;"><c:out value="${lists.id}" /></td>
				      <td style="text-align: center;"><c:out value="${lists.name}" /></td>
				      <td style="text-align: center;"><c:out value="${lists.mail}" /></td>
				      <td style="text-align: center;"><fmt:formatDate value="${lists.date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>				      
				         <c:choose> 
				          <c:when test="${lists.reason eq 'option1'}">
						        <td style="text-align: center;">다른 플랫폼으로 이전</td>
						    </c:when>
						    <c:when test="${lists.reason eq 'option2'}">
						        <td style="text-align: center;">서비스 불만족</td>
						    </c:when>
						    <c:when test="${lists.reason eq 'option3'}">
						        <td style="text-align: center;">계정 보안 문제</td>
						    </c:when>
						    <c:when test="${lists.reason eq 'option4'}">
						        <td style="text-align: center;">기타</td>
						    </c:when>
						    <c:otherwise>
						        <td style="text-align: center;">Other Reason</td>
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
      <!-- 페이징 -->
	<div class="d-flex justify-content-center my-3 ft-face-nm">
	    <nav aria-label="표준 페이지 매김 예제">
	        <ul class="pagination">
	            <c:if test="${lists.hasPrevious()}">
	                <li class="page-item">
	                    <a class="page-link" href="duserInfo.do?page=${lists.previousPageable().getPageNumber()}" aria-label="이전의">
	                        <span aria-hidden="true">‹</span>
	                    </a>
	                </li>
	            </c:if>
	
	            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
	                <li class="page-item ${currentPage - 1 eq lists.number ? 'active' : ''}">
	                    <a class="page-link" href="duserInfo.do?page=${currentPage - 1}">
	                        ${currentPage}
	                    </a>
	                </li>
	            </c:forEach>
	
	            <c:if test="${lists.hasNext()}">
	                <li class="page-item">
	                    <a class="page-link" href="duserInfo.do?page=${lists.nextPageable().getPageNumber()}" aria-label="다음">
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

  <!-- Template Main JS File -->
  <script src="../assets/js/main.js"></script>

<script>
//기존에 저장되어있던 값을 가져옴, submit 되기전 눌렀던 옵션 값
	const savedOption2 = localStorage.getItem('selectedOption2');
	
	let selectState = null;
	
	// 기존에 저장되어있던 값이 null이거나 전체라면 전체옵션의 상태 값을 selected로 바꿈
	if(savedOption2 == null || savedOption2 === '전체'){
		selectState = 'selected';
	
	// 이외에는 공백으로 저장해서 selectCode라는 html 코드에 추가함
	} else {
		selectState = '';
	}
	
	// selectDiv라는 div안에 innerHTML로 저장할 값
	var selectCode = "<select id=\"selectOption2\" name=\"reason\" class=\"form-select\" aria-label=\"Default select example\">" +
  "<option " + selectState + "value='all'>전체</option>" +
  "<option value='option1'>다른플랫폼으로이전</option>" +
  "<option value='option2'>서비스불만족</option>" +
  "<option value='option3'>계정보안문제</option>" +
  "<option value='option4'>기타</option>" +
	"</select>";
	
	const selectDiv = document.getElementById('selectDiv');
	selectDiv.innerHTML = selectCode;

	// 아이디가 selectOption인 select 요소를 selectOption이라는 값으로 저장
  const selectOption2 = document.getElementById('selectOption2');    
 
	// submit후 저장되어있는 값이 있을때 selectOption의 값을 submit전에 눌렀던 option 값으로 바꿔줌
  if (savedOption2) {
    selectOption2.value = savedOption2;
  }
  
	// selectOption의 값이 바뀔 때
  selectOption2.addEventListener('change', function() {
  // 로컬 저장소에 바뀐 옵션 값을 저장
  localStorage.setItem('selectedOption2', selectOption2.value);	
  
  // submit해서 페이지 새로고침되고 리스트 불러오게 함
 	document.getElementById('searchForm').submit();
  });
  </script>
</body>

</html>