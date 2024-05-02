<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.example.triptable.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="com.example.triptable.entity.Notice" %>
<%@ page import ="java.util.List" %>

<%
User user = (User)session.getAttribute("user");
String user_name = (user != null) ? user.getName() : "";

//indexcontroller 중 notice_view.do에서 받은 notice
Notice notice = (Notice) request.getAttribute("notice");

boolean hasPreviousNotice = (boolean) request.getAttribute("hasPreviousNotice");
boolean hasNextNotice = (boolean) request.getAttribute("hasNextNotice");

%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trip Table</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../img/LogoRaccoon.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/font.css" rel="stylesheet" />
        <link href="css/dong.css" rel="stylesheet" />
        
         <!-- Jquery -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
         
            .res-img {
                max-height: 150px;
                max-width: 150px;
            }

            #res-status td {
                font-weight: 500;
                font-size: large;
            }
            #res-status th {
                color: #545454;
            }

            #status-select {
                float: right;
                width: 150px ;
            }

            div.select-container {
                width:100%;
                overflow:auto;
            }
            div.select-container div {
                width:33%;  
                float:right;
            }
            
        </style>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
      <%@ include file="./user/header.jsp" %>
      <main class="flex-shrink-0" id="main">
          <div class="" id="navbar-line"></div>

  <!-- ======= Blog Section ======= -->

    <div class="container relative" data-aos="fade-up">

<!--         <div class="select-container mb-3" > -->
<!--             <div class="col-sm-5" style="display: flex;"> -->
<!--               <select class="form-select mx-3" id="status-select" aria-label="Default select example"> -->
<!--                 <option selected>전체 이용상태</option> -->
<!--                 <option value="1">이용 중</option> -->
<!--                 <option value="2">이용 후</option> -->
<!--                 <option value="3">취소 됨</option> -->
<!--               </select> -->
<!--               <div class="col-sm-10" id=""> -->
<!--                 <input type="date" class="form-control"> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
	
		<div class="pagetitle d-flex justify-content-between align-items-center" style="margin-top: 20px; margin-bottom: 30px;">
		     <h2><b><a href="notice.do" style="text-decoration: none; color: #333;" >공지사항</a></b></h2>
		</div>
          <table class="table" id="res-status">
            <thead>
              <tr>
               
               <%
            	// notice.getDate()를 가져와서 Java에서 원하는 형식으로 가공
               Date originalDate = notice.getDate();
               SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
               String formattedDate = outputFormat.format(originalDate);
               
               // JSP 변수에 가공된 값을 담아 전달
               request.setAttribute("formattedDate", formattedDate);
               
               %>
                
				<th width="5%" style="background-color: #F0F8FF; text-align: center;">번호</th>
				<th width="5%" style="text-align: center;">${notice.getId()}</th>
				<th width="5%" style="background-color: #F0F8FF; text-align: center;">제목</th>
				<th>${notice.getName()}</th>
				<th width="6%" style="background-color: #F0F8FF;text-align: center;">작성자</th>
				<th width="8%" style="text-align: center;">${notice.getManager()}</th>
				<th width="6%" style="background-color: #F0F8FF;text-align: center;">등록일</th>
				<th width="13%"style="text-align: center;">${formattedDate}</th>
				<th width="5%" style="background-color: #F0F8FF;text-align: center;">조회</th>
				<th width="4%" style="text-align: center;">${notice.getHit()}</th>
				
                
              </tr>
			  <tr>
			    <th style="background-color: #F0F8FF; text-align: center; width: 10%;">첨부파일</th>
        		<th colspan="10">
			        <script>
			    var fileData = JSON.parse('${notice.getFile()}');
			
			    if (fileData && fileData.length > 0) {
			        for (var i = 0; i < fileData.length; i++) {
			            document.write(
			                '<a href="#" class="fileLink" data-fileurl="' + fileData[i].fileUrl + '">' +
			                fileData[i].fileName+ '</a>' +
			                '(' + fileData[i].size + ' Kbyte)<br>'
			            );
			        }
			    } else {
			        document.write('No files');
			    }
			
			    // 다운로드 링크에 클릭 이벤트 추가
			    $('.fileLink').on('click', function (e) {
			        e.preventDefault();
			        var fileName = $(this).text();
			        downloadFile(fileName);
			    });
			
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
			
			    
			</tr>
            </thead>
            
             <!-- 본문내용 -->
            <tbody>
            
           <tr>
               <td colspan="10">${notice.getContent()}</td>
           </tr>
             
            </tbody>
          </table>
          
          
          <!-- End Table with stripped rows -->
			<div style="position:absolute; bottom: -54px; right: 0;"> 
		        <a href="./notice.do">
		            <button class="btn btn-primary px-5" type="button" id="list-button" >목록</button>
		        </a>
		    </div>
        </div>
        
        
        <!-- view안에서 다른 view 페이지로 넘길 수 있도록 함 -->
		<div class="d-flex justify-center items-center my-3 ft-face-nm">
		
    	<c:if test="${hasPreviousNotice && preIndex != null}">
		    <a href="./notice_view.do?noticenum=${preIndex}">
		        <button class="btn btn-primary px-5" type="button" id="search-button">이전</button>
		    </a>
		</c:if>

    	<c:if test="${hasPreviousNotice && hasNextNotice}">
        	<div style="margin: 0 10px;"> <!-- 여기서 10px는 원하는 간격으로 조절 가능합니다 -->
        	</div>
    	</c:if>

    	<c:if test="${hasNextNotice}">
        	<a href="./notice_view.do?noticenum=${nextIndex}">
            	<button class="btn btn-primary px-5" type="button" id="search-button">다음</button>
        	</a>
    	</c:if>
    	
    	
		</div>

        </main>
        
       <!-- Footer-->
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; TripTable 2024</div></div>
                    <div class="col-auto">
                        <a class="link-light small" href="#!">대표 [ 손수빈 ]</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">문의 [ 010-1234-5678 ]</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Mail [ 0928ssb@naver.com ]</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
<!--         <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script> -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
