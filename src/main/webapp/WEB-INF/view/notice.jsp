<%@page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.example.triptable.entity.Notice" %>
<%@ page import="org.springframework.data.domain.Page" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page import="com.example.triptable.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
User user = (User)session.getAttribute("user");
String user_name = (user != null) ? user.getName() : "";

Page<Notice> lists = (Page)request.getAttribute("lists");
int nowPage = (int) request.getAttribute("nowPage");
int startPage = (int) request.getAttribute("startPage");
int endPage = (int) request.getAttribute("endPage");

System.out.println("lists :" + lists);

List<Notice> sortedList = new ArrayList<>(lists.getContent());

Collections.sort(sortedList, new Comparator<Notice>() {
    @Override
    public int compare(Notice notice1, Notice notice2) {
        if (notice1.getCategory().equals("긴급 공지") && !notice2.getCategory().equals("긴급 공지")) {
            return -1;
        } else if (!notice1.getCategory().equals("긴급 공지") && notice2.getCategory().equals("긴급 공지")) {
            return 1;
        } else {
            return notice2.getDate().compareTo(notice1.getDate());
        }
    }
});

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
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/font.css" rel="stylesheet" />
        <link href="css/dong.css" rel="stylesheet" />
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

            .noticeCategory {
                background-color: #ddd;
            }
            #res-status th:nth-child(1) {
                width: 15px;
            }
            #res-status th:nth-child(2) {
                width: 50px;
                text-align: center;
            }
            #res-status th:nth-child(3) {
                display: none;
            }
            #res-status th:nth-child(4) {
                min-width: 315px;
                white-space: nowrap;
                text-overflow: ellipsis;
                overflow: hidden;
                text-align: left;
            }
            #res-status th:nth-child(5) {
                width: 75px;
                text-align: center;
            }
            #res-status th:nth-child(6) {
                width: 130px;
                text-align: center;
            }
            #res-status th:nth-child(7) {
                width: 50px;
                text-align: center;
            }
            #res-status th:nth-child(8) {
                width: 15px;
            }

            .noticeList td:nth-child(1) {
                width: 15px;
            }
            .noticeList td:nth-child(2) {
                width: 50px;
                text-align: center;
            }
            .noticeList td:nth-child(3) {
                display: none;
            }
            .noticeList td:nth-child(4) {
                min-width: 315px;
                white-space: nowrap;
                text-overflow: ellipsis;
                overflow: hidden;
                text-align: left;
            }
            .noticeList td:nth-child(5) {
                width: 75px;
                text-align: center;
            }
            .noticeList td:nth-child(6) {
                width: 130px;
                text-align: center;
            }
            .noticeList td:nth-child(7) {
                width: 50px;
                text-align: center;
            }
            .noticeList td:nth-child(8) {
                width: 15px;
            }
            
        </style>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
      <%@ include file="./user/header.jsp" %>
      <main class="flex-shrink-0" id="main" style="min-width: 1000px;">
          <div class="" id="navbar-line"></div>

  <!-- ======= Blog Section ======= -->

    <div class="container" data-aos="fade-up">

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
		    <h2 style="font-weight:500; font-size:40px">공지사항</h2>
		    <form action="/notice.do" id="noticeForm" method ="GET" role="search" >
		    <div class="d-flex">
		    <div id="selectDiv">
<!-- 		    	<select name="category" id="selectCategory"> -->
<!-- 		    	<option selected>전체 공지</option> -->
<!-- 		    	<option>긴급 공지</option> -->
<!-- 		    	<option>업데이트 공지</option> -->
<!-- 		    	<option>일반 공지</option> -->
<!-- 		    	</select> -->
		    </div>
		        <input type="text" id="course-search" name="title" class="form-control mx-3" placeholder="검색어를 입력하세요" style="width: 300px;">
		        <button class="btn btn-primary px-5" type="submit" id="search-button">검색</button>
		    </div>
		    </form>
		</div>
		
		<!-- 공지사항 검색 기능 script -->
		<script>
    		
			var savedCategory = localStorage.getItem('selectCategory');
			
			
			if(savedCategory == null || savedCategory === '전체 공지'){
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
    			
    			document.getElementById('noticeForm').submit(); 
    			
    		});
    		
            
		</script>
        

          <table class="table" id="res-status">
            <thead>
              <tr style="background-color: #F0F8FF;">
               
                <th width="3%">&nbsp;</th>
				<th width="5%">번호</th>
                <th></th>
				<th>제목</th>
				<th width="10%">작성자</th>
				<th width="17%">등록일</th>
				<th width="5%">조회</th>
				<th width="3%">&nbsp;</th>
                
              </tr>
            </thead>
            
            
            <tbody>
            
            <!-- 공지사항 리스트 -->
            <%
            
            Date currentDate = new Date(); 
            SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
            String strCurrentDate = outputFormat.format(currentDate);
            
            for (Notice notice : sortedList) {
                
                String formattedDate = outputFormat.format(notice.getDate());
            %>


            <tr class="noticeList">
                <td>&nbsp;</td>
                <td>
                    <% if (notice.getCategory() != null && notice.getCategory().trim().equals("긴급 공지")) { %>
                        <i class="bi bi-megaphone-fill"></i><span class="fade" style="font-size: 0;"><%= notice.getId() %></span>
                    <% } else { %>
                        <%= notice.getId() %>
                    <% } %>
                </td>
                <td class="none"><%= notice.getId() %></td>
                <td>
                	<a href="./notice_view.do?noticenum=<%= notice.getId() %>"><%= notice.getName() %></a>
                </td>
                <td><%= notice.getManager() %></td>
                <td><%= formattedDate %></td>
                <td><%= notice.getHit() %></td>
                <td>&nbsp;</td>
            </tr>
            
            <% } %>
 
            </tbody>
          </table>
          <!-- End Table with stripped rows -->
          
          <script>
            
            $(document).ready(function() {
                $(".noticeList").find('td i.bi-megaphone-fill').each(function() {
                    // 현재 i 요소에 bi-megaphone-fill 클래스가 있는 경우
                    if ($(this).hasClass('bi-megaphone-fill')) {
                        // 부모 td 요소에 noticeCategory 클래스 추가
                        $(this).closest('tr').addClass("noticeCategory");
                    }
                });
            });
          </script>
        </div>
        
       <!-- 페이징 -->          
		<div class="flex justify-center items-center my-3 ft-face-nm">
		    <nav aria-label="표준 페이지 매김 예제" _mstaria-label="655265" _msthash="546">
		        <ul class="pagination">
		            <% if (lists.hasPrevious()) { %>
		                <li class="page-item">
		                    <a class="page-link" href="notice.do?page=<%= lists.previousPageable().getPageNumber() %>&title=${searchTitle}" aria-label="이전의">
		                        <span aria-hidden="true">«</span>
		                    </a>
		                </li>
		            <% } %>
		            
		            <% for (int currentPage = startPage; currentPage <= endPage; currentPage++) { %>
		                <li class="page-item <%= (currentPage - 1 == lists.getNumber() ? "active" : "") %>">
		                    <a class="page-link" href="notice.do?page=<%= currentPage - 1 %>&title=${searchTitle}"><%= currentPage %></a>
		                </li>
		            <% } %>
		
		            <% if (lists.hasNext()) { %>
		                <li class="page-item">
		                   <a class="page-link" href="notice.do?page=<%= lists.nextPageable().getPageNumber() %>&title=${searchTitle}" aria-label="다음">
		                        <span aria-hidden="true">»</span>
		                    </a>
		                </li>
		            <% } %>
		        </ul>
		    </nav>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
