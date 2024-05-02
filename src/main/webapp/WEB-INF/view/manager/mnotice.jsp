<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.example.triptable.entity.Manager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.springframework.data.domain.Page"%>
<%@ page import ="com.example.triptable.entity.Notice" %>
<%@page import="java.util.List"%>
<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRolename().replace("ROLE_", "") + " MANAGER";  
  String managerName = manager.getName();
  
  //페이징 list나타내기 위해 사용
  Page<Notice> lists = (Page)request.getAttribute("lists");

  int startPage = (int) request.getAttribute("startPage");
  int endPage = (int) request.getAttribute("endPage");
  long totalElements = lists.getTotalElements();

  
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
  
  <!-- Jquery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>
<style>
/* 관리자(작성자) 변경 불가능 */
.readonly-field {
    background-color: #f5f5f5; /* 회색 배경색 지정 */
    color: #333; /* 텍스트 색상 지정 */
    caret-color: transparent; /* 커서 색상 투명으로 설정 */
    /* 필요한 다른 스타일 추가 */
}

/* 선택될 때의 스타일 변경 */
.readonly-field:focus {
    background-color: #f5f5f5; /* 선택될 때 배경색을 투명으로 설정 */
}

</style>

<body>

<%@ include file='mheader.jsp'%>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>공지사항 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">공지사항 관리</li>
          <li class="breadcrumb-item active">공지사항 세부관리</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">

              <!-- Search Bar-->
              <br />
             

              <!-- 리스트 추가 버튼 -->
              <div class="insert-spot ">
              
            
            <div class="d-flex justify-content-between">
             <b>총 <%=totalElements%>건</b>
             <div class="search-bar ms-auto">
                 <form action="./mnotice.do" id="mnoticeForm" class="search-form" method="GET">
                     <div class="d-flex">
                        <div id="selectDiv">
                            <!-- select 요소 동적 추가 -->
                         </div>
                         &nbsp;
                         <input class="form-control" style="width:200px;" type="text" name="title" title="Enter search keyword" id="searchInput" placeholder="제목 검색">
                         &nbsp;
                         <button class="btn btn-primary" type="submit" title="Search"><i class="bi bi-search"></i></button>
                     </div>
                 </form>
             </div><!-- End Search Bar -->
         </div>
         <br />

         <script>
         
         var savedCategory = localStorage.getItem('selectCategory');
         
         
         if(savedCategory === null || savedCategory.trim() === '전체 공지'){
            selectState = 'selected';
         } else {
            selectState = '';
         }
         
         
         const selectHtml = '<select class="form-select" name="category" id="selectCategory"><option ' + selectState
         +'>전체 공지</option><option>긴급 공지</option><option>업데이트 공지</option><option>팝업 공지</option><option>일반 공지</option></select>';
         
         const selectDiv = document.getElementById('selectDiv');
         selectDiv.innerHTML = selectHtml;
         
          var selectCategory = document.querySelector('#selectCategory');
          
          if(savedCategory){
             selectCategory.value = savedCategory;
          }
          
          selectCategory.addEventListener('change', function(){
             
             var category = selectCategory.value;
             
             localStorage.setItem('selectCategory', category);
             
             document.getElementById('mnoticeForm').submit(); 
             
          });
         </script>
             
             
     
              <!-- 공지사항 수정 모달에 데이터 set -->
              <script>
              // 모달 초기화 함수
              function initializeModal() {
                  // 모달 내부의 파일 리스트 컨테이너를 비웁니다.
                  $('.fileListContainer').empty();
              }
              
              
            function openUpdateModal() {
                // noticeId를 사용하여 모달을 열거나 원하는 작업을 수행합니다.
                var noticeId = $('.radioButton:checked').closest('tr').find('#noticeId').html();
                
                if(noticeId == null) {
					alert('공지사항을 선택하세요');
					return;
				}   
                                
                // 모달 초기화
			    initializeModal();

                // 모달 열기
                $('#disablebackdrop2').modal('show');

                // 모달 안에 공지사항 값 세팅을 위한 AJAX 요청
                $.ajax({
                    url: '/manager/mnotice_setting.do',
                    data: {
                        notice_id: noticeId
                    },
                    type: 'get',
                    success: function (result) {
                        // 받아온 데이터를 모달 내부에 표시
                  
                        $('#noticeTitle').val(result.name);
                        $('#updateCategory').val(result.category);
                        $('#updateNoticestart').val(result.noticestart);
                        $('#updateNoticeend').val(result.noticeend);
                        $('#noticeContent').val(result.content);
                        $('#noticeManager').val(result.manager);
                        
			            // 받아온 파일 데이터를 JSON으로 파싱
			            var fileData = JSON.parse(result.file);
			            var fileListContainer = $('.fileListContainer');
			            
			            // 파일 리스트에 대한 처리
			            for (var i = 0; i < fileData.length; i++) {
			                var ufile = fileData[i];

			                // 파일에 대한 HTML 엘리먼트 생성
			                var fileElement = $('<div>').html(
			                    '<a href="#" class="fileLink" data-fileurl="' + ufile.fileUrl + '">' + ufile.fileName + '</a>' +
			                    '(' + ufile.size + ' Kbyte)'
			                );

			                // 이미지 파일인 경우에만 이미지를 추가
			                if (isImageFile(ufile.fileUrl)) {
			                    // 이미지 파일인 경우 이미지 추가
			                    var imageElement = $('<img>').attr({
								    'src': ufile.fileUrl,
								    'alt': 'Image',
								    'style': 'width:400px;'
								});
			                    fileElement.append(imageElement);
			                }
			                
			                // 리스트에 파일 추가
			                fileListContainer.append(fileElement);
			            }
			                noticeIdToUpdate = result.id;
			                
			             // 다운로드 링크에 클릭 이벤트 추가
				            $('.fileLink').on('click', function(e) {
				                e.preventDefault();
				                var fileName = $(this).text();
				                downloadFile(fileName);
				            });
			                
                    },
                    error: function () {
                        console.log('전송 실패');
                    }
                });
                
                // 이미지 파일인지 확인하는 함수
			    function isImageFile(fileUrl) {
			        var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp']; // 이미지로 간주할 확장자들

			        // 파일 이름에서 확장자 추출
			        var fileExtension = fileUrl.substr(fileUrl.lastIndexOf('.')).toLowerCase();

			        // 이미지 확장자 여부 확인
			        return imageExtensions.includes(fileExtension);
			    }
            }
            
            // 공지사항 복사 모달
            function openCopyModal(){
            	
            	var noticeId = $('.radioButton:checked').closest('tr').find('#noticeId').html();
            	
				if(noticeId == null) {
					alert('공지사항을 선택하세요');
					return;
				}            	
               $('#copyModal').modal('show');
               
               $.ajax({
                    url: '/manager/mnotice_setting.do',
                    data: {
                        notice_id: noticeId
                    },
                    type: 'get',
                    success: function (result) {
                        // 받아온 데이터를 모달 내부에 표시
                        
                        $('#copyTitle').val(result.name);
                        $('#copyCategory').val(result.category);
                        $('#copyNoticestart').val(result.noticestart);
                        $('#copyNoticeend').val(result.noticeend);
                        $('#copyContent').val(result.content);
                        $('#copyManager').val(result.manager);
                        $('.noticeFile').attr('src', '../img/upload/'+ result.file);
                    },
                    error: function () {
                        console.log('전송 실패');
                    }
                });
            }
            </script>
            
            
            <!-- 공지사항 수정 완료 눌렀을 때 수정 -->
              <script>
              function updateModal() {
                  // FormData 객체 생성
                  var formData = new FormData();

                 // 파일 인풋에서 파일 가져오기
                var ufile = $('input[name="ufile"]').get(0).files;


 			    // 각 파일을 FormData에 추가
 			    for (var i = 0; i < ufile.length; i++) {
 			        formData.append('ufile', ufile[i]);
 			    }

                  var title = $('#noticeTitle').val();
                  var category = $('#updateCategory').val();
                  var start = $('#updateNoticestart').val();
                  var end = $('#updateNoticeend').val();
                  var content = $('#noticeContent').val();
                  const replacedContent = content.replace(/\n/g, "<br>");
                  
                  var startDate = new Date(start);
                  var endDate = new Date(end);

                 // 제목이 공란일 경우
                if(title.trim() === ''){
                   alert('제목을 입력하세요!');
                
                // 카테고리 선택안했을 경우
                } else if(category === '------------- 카테고리를 선택하세요 ------------'){
                   alert('카테고리를 선택하세요!');
                
                // 시작날짜보다 끝날짜가 빠를 경우
                } else if(start === '' || end === '' || startDate > endDate){
                   alert('공지기간 설정이 올바르지 않습니다!');
                
                // 내용이 공란일 경우
                } else if(replacedContent.trim() === ''){
                   alert('내용을 입력하세요!');
                   
                // 다 제대로 입력했을 경우
                } else{   
                  
                  formData.append('notice_title', title);
                  formData.append('notice_content', replacedContent);
                  formData.append('notice_category', category);
                  formData.append('notice_start', start);
                  formData.append('notice_end', end);

                  // noticeIdToUpdate 변수가 전역 변수로 선언되었다고 가정
   			      formData.append('notice_id', noticeIdToUpdate);
                  
                  $.ajax({
                      url: '/mnotice_update.do',
                      data: formData,
                      enctype: 'multipart/form-data',
                      type: 'POST',
                      contentType: false,
                      processData: false,
                      success: function (result) {
                          window.location.href = 'mnotice.do';
                      },
                      error: function () {
                          console.log('데이터 전송 실패');
                      }
                  });
                }
              }
              
              // 공지사항 복사 완료 눌렀을 때
              function copyModal(){
                 
                 // FormData 객체 생성
                  var formData = new FormData();
                 
                 // 파일 인풋에서 파일 가져오기
                var file = $('input[name="file2"]').get(0).files[0];

                  // FormData에 파일 추가
                  formData.append('file2', file);

                // 제목, 작성자, 내용 값 가져오기
                const title = $('#copyModal input[type="text"]').val();
                const category = $('#copyCategory').val();
                const start = $('#copyNoticestart').val();
                const end = $('#copyNoticeend').val();
                const content = $('#copyModal textarea').val();
                const replacedContent = content.replace(/\n/g, "<br>");
                
                var startDate = new Date(start);
                var endDate = new Date(end);
                
                // 제목이 공란일 경우
                if(title.trim() === ''){
                   alert('제목을 입력하세요!');
                
                // 카테고리 선택안했을 경우
                } else if(category === '------------- 카테고리를 선택하세요 ------------'){
                   alert('카테고리를 선택하세요!');
                
                // 시작날짜보다 끝날짜가 빠를 경우
                } else if(start === '' || end === '' || startDate > endDate){
                   alert('공지기간 설정이 올바르지 않습니다!');
                
                // 내용이 공란일 경우
                } else if(replacedContent.trim() === ''){
                   alert('내용을 입력하세요!');
                   
                // 다 제대로 입력했을 경우
                } else{   
                   
                    formData.append('notice_title', title);
                    formData.append('notice_content', replacedContent);
                    formData.append('notice_category', category);
                    formData.append('notice_start', start);
                    formData.append('notice_end', end);

                    $.ajax({
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        url: '/insert',
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function(result) {                
                            window.location.href='mnotice.do';
                        },
                        error: function(xhr, status, error) {
                            console.log('업로드 실패');
                            console.log('Status: ' + status);
                            console.log('Error: ' + error);
                            console.log(xhr.responseText); // 전체 응답 내용을 출력하거나 필요한 부분을 추출하여 확인할 수 있습니다.
                        }
                       });
                }   
              }
              
          	   // 파일 다운로드 함수
			    function downloadFile(fileName) {
			        // AJAX를 통해 다운로드 URL에 접근
			        
			        if (!fileName) {
				        console.error('에러');
				        return;
				    }
			        
			        
			        $.ajax({
			            url: '/download/' + fileName,
			            type: 'GET',
			            xhrFields: {
			                responseType: 'blob'
			            },
			            success: function (data) {
			                // 파일 다운로드 링크 생성
			                var a = document.createElement('a');
			                var url = window.URL.createObjectURL(data);
			                a.href = url;

			                // 다운로드할 파일명 설정
			                a.download = fileName.substring(fileName.lastIndexOf('_') + 1);

			                // 다운로드 링크를 클릭하여 다운로드 시작
			                document.body.append(a);
			                a.click();

			                // 다운로드 링크 삭제
			                window.URL.revokeObjectURL(url);
			                a.remove();
			            },
			            error: function (error) {
			                console.error('파일 다운로드 실패:', error);
			            }
			        });
			    }

              </script>
     
              
              <!-- 공지사항 update modal -->
              <!-- notice id에 대한 notice 세부 내용을 띄움 -->
              <div class="modal fade" id="disablebackdrop2" tabindex="-1" aria-labelledby="disableBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">공지사항 수정</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <form>

			            
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">제목</label>
                          <div class="col-sm-10">
                            <input type="text" id="noticeTitle" class="form-control">
                          </div>
                        </div>
                        
                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">카테고리</label>
                      <div class="col-sm-10">
                       <select id="updateCategory" class="form-select">
                           <option>------------- 카테고리를 선택하세요 ------------</option>
                           <option>팝업 공지</option>
                           <option>긴급 공지</option>
                           <option>업데이트 공지</option>
                           <option>일반 공지</option>      

                       </select>
                      </div>
                  </div>
                  
                  <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">공지기간</label>
                      <div class="col-sm-10">
                      <input type="date" id="updateNoticestart" name="datepicker">
                      ~
                      <input type="date" id="updateNoticeend" name="datepicker">
                      </div>
                  </div>
                        
                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">작성자</label>
                      <div class="col-sm-10">
                      <input type="text" id="noticeManager" class="form-control readonly-field" readonly>
                      </div>
                  </div>
                  
                  <div class="row mb-3">
                        <label for="" class="col-sm-2 col-form-label">이미지</label>
                        <div class="col-sm-10">
                           <input multiple="multiple" type="file" name="ufile" value="" id="ufileInput" required="required"/><br /><br />
                        </div>
                        <div class="fileListContainer col-sm-10">
<!--                              <img src="" width="500" onerror="" id="noticeFile" class="noticeFile" /> -->
<!--                            <a href="">파일명</a>(filesize Kbyte); -->
                        </div>
                      </div>

                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">내용</label>
                      <div class="col-sm-10">
                       <textarea class="form-control" id="noticeContent" rows="5"></textarea>
                      </div>
                  </div>
                         
                      </form><!-- End General Form Elements -->
                    </div>

                    <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="updateModal()">수정</button>
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                      
                    </div>

                  </div>
                </div>
              </div><!-- End Disabled Backdrop updateModal-->
              
              
              <!-- 공지사항 copy modal -->
              <!-- notice id에 대한 notice 세부 내용을 띄움 -->
              <div class="modal fade" id="copyModal" tabindex="-1" aria-labelledby="disableBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">공지사항을 복사하시겠습니까?</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <form>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">제목</label>
                          <div class="col-sm-10">
                            <input type="text" id="copyTitle" class="form-control">
                          </div>
                        </div>
                        
                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">카테고리</label>
                      <div class="col-sm-10">
                       <select id="copyCategory" class="form-select">
                           <option>------------- 카테고리를 선택하세요 ------------</option>
                           <option>팝업 공지</option>
                           <option>긴급 공지</option>
                           <option>업데이트 공지</option>
                           <option>일반 공지</option>      

                       </select>
                      </div>
                  </div>
                  
                  <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">공지기간</label>
                      <div class="col-sm-10">
                      <input type="date" id="copyNoticestart" name="datepicker">
                      ~
                      <input type="date" id="copyNoticeend" name="datepicker">
                      </div>
                  </div>
                        
                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">작성자</label>
                      <div class="col-sm-10">
                      <input type="text" id="copyManager" class="form-control readonly-field" readonly>
                      </div>
                  </div>
                  
                  <div class="row mb-3">
                        <label for="" class="col-sm-2 col-form-label">이미지</label>
                        <div class="col-sm-10">
                           <input type="file" name="file2" value="" id="fileInput" required="required"/><br /><br />
                        </div>
                        <div class="col-sm-10">
                             <img src="" width="500" onerror="" id="copyFile" class="noticeFile" />
                           <a href="">파일명</a>(filesize Kbyte);
                        </div>
                      </div>

                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">내용</label>
                      <div class="col-sm-10">
                       <textarea class="form-control" id="copyContent" rows="5"></textarea>
                      </div>
                  </div>
                         
                      </form><!-- End General Form Elements -->
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                      <button type="button" class="btn btn-primary" onclick="copyModal()">복사</button>
                    </div>

                  </div>
                </div>
              </div><!-- End Disabled Backdrop copyModal-->
             
         
              
              <!-- 공지사항 insert modal -->
              
              <div class="modal fade" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">공지사항 추가</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">제목</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        
                       
                        
                         <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">카테고리</label>
                      <div class="col-sm-10">
                       <select id="noticeCategory" class="form-select">
                           <option selected>------------- 카테고리를 선택하세요 ------------</option>
                           <option>팝업 공지</option>
                           <option>긴급 공지</option>
                           <option>업데이트 공지</option>
                           <option>일반 공지</option>      

                       </select>
                      </div>
                  </div>
                  
                  <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">공지기간</label>
                      <div class="col-sm-10">
                      <input type="date" id="noticestart" name="datepicker">
                      ~
                      <input type="date" id="noticeend" name="datepicker">
                      </div>
                  </div>
                  
<!--                    <div class="row mb-3"> -->
<!--     						<label for="" class="col-sm-2 col-form-label">작성자</label> -->
<!--     						<div class="col-sm-10"> -->
<!--         					<select class="form-select"> -->
<!--             					<option selected>------------- 관리자를 선택하세요 ------------</option> -->
<%--             					<c:forEach var="managerlists" items="${managerlists}"> --%>
<%--             					<option><c:out value="${managerlists.name}" /></option> --%>
<%--             					</c:forEach>  --%>

<!--         					</select> -->
<!--     						</div> -->
<!-- 						</div> -->
						
                   <form id="uploadForm">
                             <div class="form-group">
                                 <label for="fileInput">파일 선택</label>
                                 <div class="col-sm-10">
                                 <input multiple="multiple" type="file" class="form-control-file" id="ifileInput" name="files" required="required">
                                 </div>
                             </div>
                      </form>

                        <div class="row mb-3">
                      <label for="" class="col-sm-2 col-form-label">내용</label>
                      <div class="col-sm-10">
                       <textarea class="form-control" rows="5"></textarea>
                      </div>
                  </div>
     
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                      <button type="button" class="btn btn-primary" onclick="saveNotice()">추가</button>
                    </div>

                  </div>
                </div>
              </div><!-- End Disabled Backdrop insert Modal-->
              
               
          
              <!-- 공지사항 저장 -->
            <script>
             // 모달에서 '추가' 버튼 클릭 시 동작하는 함수
             function saveNotice() {
             
               // FormData 객체 생성
                var formData = new FormData();

                // 파일 인풋에서 파일 가져오기
                var files = $('input[name="files"]').get(0).files;
                
                // FormData에 파일 추가
                for(var i=0 ; i<files.length ; i++){
                   formData.append('files', files[i]);
                }
                

                // 제목, 작성자, 내용 값 가져오기
                const title = $('#disablebackdrop input[type="text"]').val();
                const manager = $('#disablebackdrop select').val();
                const category = $('#noticeCategory').val();
                const start = $('#noticestart').val();
                const end = $('#noticeend').val();
                const content = $('#disablebackdrop textarea').val();
                const replacedContent = content.replace(/\n/g, "<br>");
                
                var startDate = new Date(start);
                var endDate = new Date(end);
                
                // 제목이 공란일 경우
                if(title.trim() === ''){
                   alert('제목을 입력하세요!');
                
                // 카테고리 선택안했을 경우
                } else if(category === '------------- 카테고리를 선택하세요 ------------'){
                   alert('카테고리를 선택하세요!');
                
                // 시작날짜보다 끝날짜가 빠를 경우
                } else if(start === '' || end === '' || startDate > endDate){
                   alert('공지기간 설정이 올바르지 않습니다!');
                
                // 내용이 공란일 경우
                } else if(replacedContent.trim() === ''){
                   alert('내용을 입력하세요!');
                   
                // 다 제대로 입력했을 경우
                } else{   
                   
                   formData.append('notice_title', title);
                   formData.append('notice_manager', manager);
                   formData.append('notice_content', replacedContent);
                   formData.append('notice_category', category);
                   formData.append('notice_start', start);
                   formData.append('notice_end', end);

                    $.ajax({
                        type: 'POST',
                        enctype: 'multipart/form-data',
                        url: '/insert',
                        data: formData,
                        contentType: false,
                        processData: false,
                        success: function(result) {                
                            window.location.href='mnotice.do';
                        },
                        error: function(xhr, status, error) {
                            console.log('업로드 실패');
                            console.log('Status: ' + status);
                            console.log('Error: ' + error);
                            console.log(xhr.responseText); // 전체 응답 내용을 출력하거나 필요한 부분을 추출하여 확인할 수 있습니다.
                        }
                       });
                }   
             }
                
         </script>



              <!-- 공지사항 테이블 head  -->
              <table class="table">
                <thead>
             <tr style="background-color: #F0F8FF;">
               
                <th style="text-align: center;" width="1%">&nbsp;</th>
	            <th style="text-align: center;" width="1%">&nbsp;</th>
	            <th style="text-align: center;" width="5%">번호</th>
	            <th style="text-align: center;" width="15%">승인 상태</th>
	            <th style="text-align: center;" width="25%">제목</th>
	            <th style="text-align: center;" width="19%">작성자</th>
	            <th style="text-align: center;" width="20%">등록일</th>
	            <th style="text-align: center;" width="10%">조회</th>               
			</tr>
			</thead>
			<tbody>
                  
            <!-- 공지사항 리스트 -->
                <% for (Notice notice : lists) { 
                
                   // notice.getDate()를 가져와서 Java에서 원하는 형식으로 가공
                    Date originalDate = notice.getDate();
                    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    String formattedDate = outputFormat.format(originalDate);
                    
                    String state = "";
                    if(notice.getState() ==  true){
                       state = "checked";
                    }
                    
                    // JSP 변수에 가공된 값을 담아 전달
                    request.setAttribute("formattedDate", formattedDate);
                   %>
                <tr> 
                 <td style="text-align: center;" width="1%">&nbsp;</td>
                 <td style="text-align: center;" width="1%"><input class="form-check-input radioButton" name="select" type="radio" value=""></td>
                <td id="noticeId" style="text-align: center;" width="9%"><%=notice.getId() %></td>
                <td style="text-align: center;" width="15%">
                 <input class="form-check-input checkState" type="checkbox" value="" id="flexCheckDefault" <%=state%>>
             	</td>
                <td style="text-align: center;" width="25%"><%=notice.getName() %></td>
                <td style="text-align: center;" width="19%"><%=notice.getManager() %></td>
                <td style="text-align: center;" width="20%"><%=formattedDate %></td>
                <td style="text-align: center;" width="10%"><%=notice.getHit() %></td>
                
<!--              <td style="text-align: center;" width="15%"> -->
                 
<!--              </td> -->
<!--                   <td style="text-align: center;" width="10%"> -->
                 
<!--              </td> -->
             
              </tr>
                 <% } %>
                </tbody>  
              </table>
              <!-- 상태값 변경 ajax -->
              <script type="text/javascript">
              
              $(document).ready(function() {
            	  
                var checkboxes = document.querySelectorAll('.checkState');
                                      
                   checkboxes.forEach(function(checkbox) {
                       $(checkbox).on('change', function() {
                           if($(this).is(':checked')){
                               var parent = $(this).closest('tr');
                               var noticeId = parent.find('td#noticeId').html();
                                                              
                               $.ajax({
                                  url : '/manager/notice_check.do',
                                  type: 'POST',
                                  data : {
                                     noticeId : noticeId
                                  },
                                  success : function(result){
                                     
                                  },
                                  error : function(error){
                                     
                                  }
                                  
                               });
                           } else {
                              var parent = $(this).closest('tr');
                               var noticeId = parent.find('td#noticeId').html();
                               
                               $.ajax({
                                  url : '/manager/notice_uncheck.do',
                                  type: 'POST',
                                  data : {
                                     noticeId : noticeId
                                  },
                                  success : function(result){
                                     
                                  },
                                  error : function(error){
                                     
                                  }
                                  
                               });
                           }
                       });
                   });
               });
              </script>
          <!-- 글쓰기 버튼:공지사항 추가하는 모달 띄우기 -->
            <div class="d-flex justify-content-end" style="margin-top: 20px;">
              <a class="nav-link nav-icon ms-auto" href="#">
                  <button type="button" class="btn btn-primary" data-bs-toggle="modal" id="btn1" data-bs-target="#disablebackdrop"><i class="bi bi-plus-square"></i> 공지추가</button>
                  <button type="button" class="btn btn-primary" onclick="openCopyModal()"><i class="bi bi-clipboard"></i> 복사</button>
                  <button type="button" class="btn btn-primary" onclick="openUpdateModal()" id=""><i class="bi bi-eraser"></i> 수정</button>
              </a>
            </div>
              <!-- End Table with stripped rows -->
            </div>
            
         
            
          </div>
		
        </div>
        <!-- 페이징 -->
         <div class="d-flex justify-content-center my-3 ft-face-nm">
             <nav aria-label="표준 페이지 매김 예제" _mstaria-label="655265" _msthash="546">
              <ul class="pagination">
                  <% if (lists.hasPrevious()) { %>
                      <li class="page-item">
                          <a class="page-link" href="mnotice.do?page=<%= lists.previousPageable().getPageNumber() %>&title=${searchTitle}&manager=${searchManager}" aria-label="이전의">
                              <span aria-hidden="true">«</span>
                          </a>
                      </li>
                  <% } %>
                  
                  <% for (int currentPage = startPage; currentPage <= endPage; currentPage++) { %>
                      <li class="page-item <%= (currentPage - 1 == lists.getNumber() ? "active" : "") %>">
                          <a class="page-link" href="mnotice.do?page=<%= currentPage - 1 %>&title=${searchTitle}&manager=${searchManager}"><%= currentPage %></a>
                      </li>
                  <% } %>
      
                  <% if (lists.hasNext()) { %>
                      <li class="page-item">
                         <a class="page-link" href="mnotice.do?page=<%= lists.nextPageable().getPageNumber() %>&title=${searchTitle}&manager=${searchManager}" aria-label="다음">
                              <span aria-hidden="true">»</span>
                          </a>
                      </li>
                  <% } %>
              </ul>
          </nav>
      </div>
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

</body>

</html>