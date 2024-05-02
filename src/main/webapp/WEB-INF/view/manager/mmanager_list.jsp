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
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
window.onload = function() {
	
	$(document).on('change', '.manager_approve', function (event){
		
		// 선택된 옵션의 값을 가져오기
		  var selectedApprove = $(this).val();
		  var memberId = $(this).data('id');
		  
		$.ajax({
			url : '/manager/check_manager_role.do',
			type : 'POST',
			success : function(flag){
				if(flag == 1){
					
					
					  
					  if(selectedApprove === '비승인') {
						  selectedApprove = '1:ROLE_UNAPPROVED';
					  } else if(selectedApprove === '관리자') {
						  selectedApprove = '2:ROLE_SUPER';
					  } else if(selectedApprove === '운영자') {
						  selectedApprove = '3:ROLE_OPERATOR';
					  }
					  
					  $.ajax({
				        type: "POST",
				        url: "manager_approve.do",
				        data: { selectedApprove: selectedApprove, memberId: memberId },
				        success: function (flag) {
				        },
				        error: function (error) {
				            console.error("Error: " + error);
				        }
					});
					
				} else {
					alert('관리자 권한이 없습니다.');
					
					location.reload();
				}
			}
		});
		  
	});
};
</script>
<body>
<%@ include file='mheader.jsp'%>
  <!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>관리자 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">관리자 설정</li>
          <li class="breadcrumb-item active">관리자 관리</li>
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
	              <b>총 <c:out value="${lists.totalElements}" />건</b> 
					<div class="search-bar" style="display: flex; justify-content: space-between;">
	              <!-- Search Bar-->
	                <form id="managerForm" class="search-form" method="POST" action="/manager/manager.do" style="display: flex; justify-content: space-between;">
	                <div class="d-flex">
	                <div id="selectDiv" style="margin-right:10px;">
	                </div>
	                  <input class="form-control" type="text" name="mname" placeholder="관리자 이름 검색" title="Enter search keyword" style="margin-right:10px;"/>
	                  <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
	                  </div>
	                </form>
	              </div><!-- End Search Bar -->
              </div>


              <!-- Table  -->
              <table class="table" style="margin-top:30px;">
                <thead>
                  <tr>
                    <th style="text-align: center;">관리자번호</th>
                    <th style="text-align: center;">관리자이름</th>
                    <th style="text-align: center;">전화번호</th>
                    <th style="text-align: center;">이메일</th>
                    <th style="text-align: center;">가입일</th>
                    <th style="text-align: center;">권한</th>
                  </tr>
                </thead>
                <tbody>
            
				  <c:forEach var="lists" items="${lists.content}">
				    <tr>
				      <td style="text-align: center;"><c:out value="${lists.id}" /></td>
				      <td style="text-align: center;"><c:out value="${lists.name}" /></td>
				      <td style="text-align: center;"><c:out value="${lists.tel}" /></td>
				      <td style="text-align: center;"><c:out value="${lists.mail}" /></td>
				      <td style="text-align: center;"><fmt:formatDate value="${lists.join_date}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				      <td style="text-align: center;">
				      <select id="manager_approve" class="manager_approve approveSelect form-select" style="width: 180px; margin:0 auto;" data-id="<c:out value='${lists.id}' />">
			                <option<c:if test="${lists.managerRole.rolecode == 1}"> selected</c:if>>비승인</option>
			                <option<c:if test="${lists.managerRole.rolecode == 2}"> selected</c:if>>관리자</option>
			                <option<c:if test="${lists.managerRole.rolecode == 3}"> selected</c:if>>운영자</option>
		            	</select></td>
				    </tr>
				  </c:forEach> 
<%-- 				    <c:out value="${lists.managerRole.role_name}" />        --%>
                </tbody>
              </table>
              <!-- End Table -->
              
              <div class="d-flex justify-content-end" style="margin-top: 20px;">
              <a class="nav-link nav-icon ms-auto" href="#">
                  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal"><i class="bi bi-plus-square"></i> 관리자 추가</button>
              </a>
            </div>

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
                    <a class="page-link" href="manager.do?page=${lists.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq lists.number ? 'active' : ''}">
                    <a class="page-link" href="manager.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${lists.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="manager.do?page=${lists.nextPageable().getPageNumber()}" aria-label="다음">
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
  
  <div class="modal fade" id="insertModal">
      <div class="modal-dialog modal-dialog-scrollable modal-dialog-left" style="max-width:30%;">
        <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">관리자 추가</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
       <!--********** enctype="multipart/form-data" : 파일 업로드에는 추가해줘야함 ********* -->
      <div class="modal-body" > 
       <form method="post" name="mjoin" id="mjoin" action="./mjoin.do">
                <div class="form-group">
                  <label for="adminUsermail">메일</label>
                  <input type="text" class="form-control" name ="adminUsermail" id="adminUsermail" placeholder="이메일을 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminPassword">비밀번호<sup>(영어,숫자,특수문자를 포함한 8~15자리)</sup></label>
                  <input type="password" class="form-control" name ="adminPassword" id="adminPassword" placeholder="비밀번호를 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminPassword">비밀번호 확인</label>
                  <input type="password" class="form-control" name ="checkadminPassword" id="checkadminPassword" placeholder="비밀번호를 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminName">이름</label>
                  <input type="text" class="form-control" name ="adminName" id="adminName" placeholder="이름을 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminUsertel">전화번호</label>
                  <div style="display:flex; justify-content:space-between; align-items:center;">
                  <input type="text" class="form-control" style="width:100px; display:inline-block;" name ="adminUsertel1" id="adminUsertel1" value="010">
                  -
                  <input type="text" class="form-control" style="width:100px; display:inline-block;" name ="adminUsertel2" id="adminUsertel2" placeholder="XXXX">
                  -
                  <input type="text" class="form-control" style="width:100px; display:inline-block;" name ="adminUsertel3" id="adminUsertel3" placeholder="XXXX">
                  <input type="hidden" name ="adminUsertel" id="adminUsertel">
                  </div>
                </div>
              </form>
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="checkInput()" id="mbtn">추가</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<!-- End 추가 버튼 Modal -->

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
         
         var savedManager = localStorage.getItem('selectManager');
                  
         if(savedManager === null || savedManager.trim() === '전체 공지'){
            selectState = 'selected';
         } else {
            selectState = '';
         }
         
         
         const selectHtml = '<select class="form-select"style="width:100px;" name="manager" id="selectManager"><option ' + selectState
         +'>전체</option><option>비승인</option><option>관리자</option><option>운영자</option></select>';
         
         const selectDiv = document.getElementById('selectDiv');
         
         selectDiv.innerHTML = selectHtml;
         
          var selectManager = document.querySelector('#selectManager');
          
          if(savedManager){
        	  selectManager.value = savedManager;
          }
          
          selectManager.addEventListener('change', function(){
             
             var manager = selectManager.value;
             
             localStorage.setItem('selectManager', manager);
             
             document.getElementById('managerForm').submit(); 
             
          });
          
          
          function checkInput() {
        	  
        	  var adminUsermail = $('#adminUsermail').val().trim();
        	  var adminPassword = $('#adminPassword').val().trim();
        	  var adminName = $('#adminName').val().trim();
        	  var adminUsertel1 = $('#adminUsertel1').val().trim();
        	  var adminUsertel2 = $('#adminUsertel2').val().trim();
        	  var adminUsertel3 = $('#adminUsertel3').val().trim();
        	  
        	  if(adminUsermail === '' || adminPassword === '' || adminName === '' || !/^\d{3}$/.test(adminUsertel1) || !/^\d{4}$/.test(adminUsertel2) || !/^\d{4}$/.test(adminUsertel3)) {
        		  alert('모든 항목을 입력하셔야 합니다.');
        	  } else {
        		  
        		  $('#adminUsermail').val(adminUsermail);
        		  $('#adminPassword').val(adminPassword);
        		  $('#adminName').val(adminName);
        		  $('#adminUsertel').val(adminUsertel1 + adminUsertel2 + adminUsertel3);
        		  
        		  $.ajax({
        			  url : '/check_exist_mail.do',
        			  type: 'get',
        			  data : {
        				  mail : adminUsermail
        			  },
        			  success : function(flag){
        				  
        				  if(flag == 0){
        					  validatePassword();
        				  } else {
        					  alert('이미 가입된 메일입니다!');
        					  return;
        				  }
        				  
        			  },
        			  error : function(){
        				  
        			  }
        		  })
        		  
        		  
        		  
        		  
        	  }
         	 
          }
          
          
          
    		function validatePassword() {
    			var password = document.getElementById('adminPassword').value;
    			var checkpassword = document.getElementById('checkadminPassword').value;
    			const regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
    			
    			if(password.length<8 || password.length>15) {
    				alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
    				return false;
    			}
    			
    			if(!regex.test(password)) {
    				alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
    				return false;
    			}
    			
    			if(password !== checkpassword) {
    				alert('비밀번호가 일치하지 않습니다.');
    				return false;
    			}
    			
    			document.mjoin.submit();
    		}
         </script>

</body>

</html>