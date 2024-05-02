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
<style>
.readonly-field {
    background-color: #f5f5f5; /* 회색 배경색 지정 */
    color: #333; /* 텍스트 색상 지정 */
    caret-color: transparent;
     /* 커서 색상 투명으로 설정 */
    /* 필요한 다른 스타일 추가 */
}

/* 선택될 때의 스타일 변경 */
.readonly-field:focus {
    background-color: #f5f5f5; /* 선택될 때 배경색을 투명으로 설정 */
}
</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script type="text/javascript">
window.onload = function() {
	
	
	// 코스 승인 / 승인해제
	var checkboxes = document.querySelectorAll('.checkState');
	
	checkboxes.forEach(function(checkbox) {
		$(checkbox).on('change', function() {
			
			var parent = $(this).closest('tr');
			var courseId = parent.find('#courseId').html();
			
			if($(this).is(':checked')){
						
				$.ajax({
                    url : '/manager/course_check.do',
                    type: 'POST',
                    data : {
                    	courseId : courseId
                    },
                    success : function(flag){
                     	  if(flag == "1"){
                     		  alert("내용을 수정해주세요.");
                     		  location.reload();
                     	  }
                    },
                    error : function(error){
                       
                    }
                    
                 });
				
			} else {
				
                
                $.ajax({
                   url : '/manager/course_uncheck.do',
                   type: 'POST',
                   data : {
                	   courseId : courseId
                   },
                   success : function(result){
                      
                   },
                   error : function(error){
                      
                   }
                   
                });
			}
		});
	});

   
   /* 추가 버튼 */
   document.getElementById( 'ibtn' ).onclick = function() {
      if( document.ifrm.idest.value.trim() == '' ) {
         alert( '여행지역을 입력하셔야 합니다.' );
         return;
      }
      if( document.ifrm.iname.value.trim() == '' ) {
         alert( '여행이름을 입력하셔야 합니다.' );
         return;
      }
      if( document.ifrm.imanager.value.trim() == '------------- 관리자를 선택하세요 ------------' ) {
         alert( '작성자를 입력하셔야 합니다.' );
         return;
      }

      document.ifrm.submit();
   };
   
    // 추가할 때 파일 미리보기 기능 구현
    const ipreview = document.getElementById('insert-preview');
    const fileInsert = document.getElementById('file-insert');
    
    fileInsert.addEventListener('change', (event) => {
       const file = event.target.files[0];
       const reader = new FileReader();
   
       reader.onload = (e) => {
            ipreview.src = e.target.result;
            ipreview.style.display = 'block';
       };
   
       reader.readAsDataURL(file);
    });
   
    
    // 수정할 때 파일 미리보기 기능 구현
    const upreview = document.getElementById('update-preview');
    const fileUpdate = document.getElementById('file-update');
    
    fileUpdate.addEventListener('change', (event) => {
       const file = event.target.files[0];
       const reader = new FileReader();
       
       $('.uimage').attr('src', "");
       upreview.src = "";
       upreview.style.display = 'none'; 
       
       reader.onload = (e) => {
           
            upreview.src = e.target.result;
            upreview.style.display = 'block';
       };
   
       reader.readAsDataURL(file);
       
      
    });
    
   /* 수정 모달 불러오기 버튼 */
   $(document).on('click', '#ubtn1', function (event){
       
	  var courseId = $('.radioButton:checked').closest('tr').find('#courseId').html();
	  
	  if(courseId == null) {
			alert('코스를 선택하세요');
			return;
		}   
	  
	  $('#updateModal').modal('show');
		        
        $.ajax({
            type: "POST",
            url: "rec_modal.do",
            data: { courseId: courseId },
            success: function (result) {
               
                const modalObj = JSON.parse(result);
                
                initializeModal();
                                
                $('input[name="uid"]').val(modalObj.id); 
                $('input[name="udate"]').val(modalObj.date); 
                $('input[name="udest"]').val(modalObj.dest); 
                $('input[name="uname"]').val(modalObj.name);
                $('.uimage').attr('src', modalObj.image);
                $('input[name="udis"]').val(modalObj.dis); 
                $('input[name="udur"]').val(modalObj.dur); 
                $('input[name="umanager"]').val(modalObj.manager);
                $('textarea[name="usum"]').val(modalObj.summary); 
                $('textarea[name="udetail"]').val(modalObj.detail); 
                
               
            },
            error: function (error) {
                console.error("Error: " + error);
            }
      
       });
        
        // 모달 초기화 함수
        function initializeModal() {
            document.getElementById('update-preview').src = "";
            upreview.style.display = 'none'; 
            $('input[name="uid"]').val(""); 
             $('input[name="udate"]').val(""); 
             $('input[name="udest"]').val(""); 
             $('input[name="uname"]').val(""); 
             $('.uimage').attr('src', "");
             $('input[name="udis"]').val(""); 
             $('input[name="udur"]').val(""); 
             $('input[name="usum"]').val(""); 
             $('input[name="udetail"]').val(""); 
             
        };
      
   });
   
   
   /* 수정 버튼(수정모달안에 버튼) */
   document.getElementById( 'ubtn2' ).onclick = function() {
      
	   var uid = document.getElementById("uid").value;
	   	   
      if( document.ufrm.udest.value.trim() == '' ) {
         alert( '여행지역을 입력하셔야 합니다.' );
         return;
      }
      if( document.ufrm.uname.value.trim() == '' ) {
         alert( '여행이름을 입력하셔야 합니다.' );
         return;
      }
      if( document.ufrm.umanager.value.trim() == '------------- 관리자를 선택하세요 ------------' ) {
         alert( '작성자를 입력하셔야 합니다.' );
         return;
      }
  

      document.ufrm.submit();
   };
   
   /* 삭제 모달 불러오는 버튼 */
   $(document).on('click', '#dbtn1', function (event){
	   
		var courseId = $('.radioButton:checked').closest('tr').find('#courseId').html();
	   
	   if(courseId == null) {
			alert('코스를 선택하세요');
			return;
		}   
	   
      $('#deleteModal').modal('show');
     
   });
   
   /* 삭제 버튼 */
   $(document).on('click', '.dbtn2', function() {
	   
	var courseId = $('.radioButton:checked').closest('tr').find('#courseId').html();
	   
	   $.ajax({
           type: "POST",
           url: "rec_delete.do",
           data: { courseId: courseId },
           success: function (result) {
        	   
           },
           error: function (error) {
               console.error("Error: " + error);
           }
     }); 
	   
      document.dfrm.submit();
   });
   
   // 승인 select 요소 가져오기
   //var selectApproves = document.getElementById('rec_approve');

   $(document).on('change', '.rec_approve', function (event){
     // 선택된 옵션의 값을 가져오기
     var selectedApprove = $(this).val();
     var courseId = $(this).data('course-id');
     
     $.ajax({
          type: "POST",
          url: "rec_approve.do",
          data: { selectedApprove: selectedApprove, courseId: courseId },
          success: function (flag) {

        	  if(flag == "1"){
           		  alert("내용을 수정해주세요.");
           		  location.reload();
           	  }
              
          },
          error: function (error) {
              console.error("Error: " + error);
          }
      });
   });
};

</script>
<body>
<%@ include file='mheader.jsp'%>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>추천 리스트 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">여행지 추천 관리</li>
          <li class="breadcrumb-item active">추천 리스트 관리</li>
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
	              <b>총 <c:out value="${courseList.totalElements}" />건</b> 
					<div class="search-bar" style="display: flex; justify-content: space-between;">
	              <!-- Search Bar-->
	                <form class="search-form" method="POST" action="/manager/recommend.do" style="display: flex; justify-content: space-between;">
	                <div class="d-flex">
	                  <input class="form-control" type="text" name="region" placeholder="검색" title="Enter search keyword" style="margin-right:10px;"/>
	                  <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
	                  </div>
	                </form>
	              </div><!-- End Search Bar -->
              </div>
                
  
              <!-- Table  -->
              <table class="table" style="margin-top:30px;">
                <thead>

                  <tr>
                  	<th style="text-align: center;" width="2%">&nbsp;</th>
                    <th style="text-align: center;" width="3%">번호</th>
                    <th style="text-align: center;" width="10%">승인 상태</th>
                    <th style="text-align: center;" width="15%">여행지역</th>
                    <th style="text-align: center;" width="30%">여행이름</th>
                    <th style="text-align: center;" width="15%">여행거리</th>
                    <th style="text-align: center;" width="15%">여행시간</th>
                    <th style="text-align: center;" width="10%">조회수</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="courseList" items="${courseList.content}">
                  <tr>
                  	<td style="text-align: center;" width="2%"><input class="form-check-input radioButton" name="select" type="radio" value=""></td>
					<td style="text-align: center;" width="3%" id="courseId"><c:out value="${courseList.id }" /></td>
					<td style="text-align: center;" width="10%" class="rec_appreve">
						<input class=" form-check-input checkState"  type="checkbox" <c:if test="${courseList.approve == 'true'}">checked</c:if> />
					</td>
					<td style="text-align: center;" width="15%"><c:out value="${courseList.coursedest }" /></td>
					<td style="text-align: center;" width="30%"><c:out value="${courseList.coursename }" /></td>
					<td style="text-align: center;" width="15%"><c:out value="${courseList.coursedis }" /></td>
					<td style="text-align: center;" width="15%"><c:out value="${courseList.coursedur }" /></td>
					<td style="text-align: center;" width="10%"><c:out value="${courseList.hit }" /></td>
            	 </tr>
               </c:forEach>
                </tbody>
              </table>
              
              <div class="d-flex justify-content-end" style="margin-top: 20px;">
              <a class="nav-link nav-icon ms-auto" href="#">
                  <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#insertModal"><i class="bi bi-plus-square"></i> 코스추가</button>
                  <button type="button" class="btn btn-primary" id="ubtn1" ><i class="bi bi-eraser"></i> 수정</button>
                  <button type="button" class="btn btn-primary" id="dbtn1" ><i class="bi bi-trash"></i> 삭제</button>
              </a>
            </div>
              <!-- End Table with stripped rows -->

            </div>
<!--           </div> -->

        </div>
      </div>
      
      <!-- 페이징 -->
   <div class="d-flex justify-content-center my-3 ft-face-nm">
       <nav aria-label="표준 페이지 매김 예제">
           <ul class="pagination">
            <c:if test="${courseList.hasPrevious()}">
                <li class="page-item">
                    <a class="page-link" href="recommend.do?page=${courseList.previousPageable().getPageNumber()}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            </c:if>

            <c:forEach var="currentPage" begin="${startPage}" end="${endPage}">
                <li class="page-item ${currentPage - 1 eq courseList.number ? 'active' : ''}">
                    <a class="page-link" href="recommend.do?page=${currentPage - 1}">
                        ${currentPage}
                    </a>
                </li>
            </c:forEach>

            <c:if test="${courseList.hasNext()}">
                <li class="page-item">
                    <a class="page-link" href="recommend.do?page=${courseList.nextPageable().getPageNumber()}" aria-label="다음">
                        <span aria-hidden="true">›</span>
                    </a>
                </li>
            </c:if>
        </ul>
       </nav>
   </div>
      
      
    </section>

  </main><!-- End #main -->
<!-- Modal들입니다 -->  
            
<!-- 추가 버튼 Modal -->
 <!-- The Modal -->
 <div class="modal fade" id="insertModal">
      <div class="modal-dialog modal-dialog-scrollable modal-dialog-left modal-lg">
        <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">추가</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
       <!--********** enctype="multipart/form-data" : 파일 업로드에는 추가해줘야함 ********* -->
      <div class="modal-body"> 
       <form action="/rec_insert" class="insert-form" id="insert-form" method="POST" name="ifrm" enctype="multipart/form-data" >      
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행지역</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="idest" >
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행이름</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="iname" >
            </div>
          </div>
          
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">이미지</label>
            <div class="col-sm-10">
            <!-- accept="image/*" : 사용자가 이미지만 선택할 수 있도록 하는 코드 -->
               <input type="file" name="file" value="" id="file-insert" accept="image/*"/><br /><br />
               <img id="insert-preview" src="#" alt="이미지 미리보기" style="display:none; width: 300px" >
            </div>
          </div>
          
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행거리</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="idis">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행시간</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="idur">
            </div>
          </div>
          <div class="row mb-3">
          <label for="" class="col-sm-2 col-form-label">작성자</label>
             <div class="col-sm-10">
                 <select class="form-select" name="imanager" id="imanager">
                  <option selected>------------- 관리자를 선택하세요 ------------</option>
                     <c:forEach var="managerlist" items="${managerlist}">
                        <option><c:out value="${managerlist.name}" /></option>
                     </c:forEach> 
                 </select>
             </div>
         </div>
           <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행개요</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="isum" ></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">일정세부사항</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="idetail" ></textarea>
            </div>
          </div>
   
        </form><!-- End General Form Elements -->
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="ibtn">추가</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<!-- End 추가 버튼 Modal -->

  
<!-- 수정 버튼 Modal -->
<!-- The Modal -->
<div class="modal updateModal" id="updateModal">
      <div class="modal-dialog modal-dialog-scrollable modal-dialog-left modal-lg">
        <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      <!-- enctype="multipart/form-data" : 파일 업로드에는 추가해줘야함 -->
       <form action="/manager/rec_update.do" class="update-form" method="POST" name="ufrm" enctype="multipart/form-data" >      

          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">번호</label>
            <div class="col-sm-10">
              <input type="text" class="form-control readonly-field" name="uid" id="uid" readonly>
            </div>
          </div>
<!--           <div class="row mb-3"> -->
<!--             <label for="" class="col-sm-2 col-form-label">조회수</label> -->
<!--             <div class="col-sm-10"> -->
<!--               <input type="text" class="form-control" name="uhit" id="uhit" readonly> -->
<!--             </div> -->
<!--           </div> -->
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">등록일</label>
            <div class="col-sm-10">
              <input type="text" class="form-control readonly-field" name="udate" readonly>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행지역</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="udest">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행이름</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="uname" >
            </div>
          </div>
          
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">이미지</label>
            <div class="col-sm-10">
               <input type="file" name="uupload" value="" id="file-update" accept="image/*"/><br /><br />
               <img id="update-preview" src="#" alt="이미지 미리보기" style="display:none; width: 300px" >
               <img src="" width="500" onerror="" class="uimage" name="uimage" style="width: 300px"/>
            </div>
          </div>
           
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행거리</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="udis">
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행시간</label>
            <div class="col-sm-10">
              <input type="text" class="form-control" name="udur">
            </div>
          </div>
          <div class="row mb-3">
             <label for="" class="col-sm-2 col-form-label">작성자</label>
             <div class="col-sm-10">
             <input type="text" name="umanager" id="umanager" class="form-control readonly-field" readonly>
             </div>
         </div>
           <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">여행개요</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="usum" ></textarea>
            </div>
          </div>
          <div class="row mb-3">
            <label for="" class="col-sm-2 col-form-label">일정세부사항</label>
            <div class="col-sm-10">
              <textarea class="form-control" id="floatingTextarea" style="height: 100px;" name="udetail" ></textarea>
            </div>
          </div>
   
        </form><!-- End General Form Elements -->
      </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="ubtn2 btn btn-primary" id="ubtn2">수정</button>
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
      </div>

    </div>
  </div>
</div>
<!-- End 수정 버튼 Modal -->

<!-- 삭제 버튼 모달 -->
<div class="deleteModal modal " id="deleteModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">                 
       <form action="/manager/rec_delete.do" method="POST" name="dfrm">
      <div class="modal-header">
        <h5 class="modal-title">삭제</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        정말 삭제하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="dbtn2 btn btn-danger" >삭제</button>
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