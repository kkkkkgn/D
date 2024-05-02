<%@page import="com.example.triptable.entity.User"%>
<%@page import="org.springframework.data.domain.Page"%>
<%@page import="com.example.triptable.entity.CourseRecommendation"%>
<%@page import="java.util.List"%>
<%@ page import="org.springframework.util.StringUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<% 
	User user = (User)session.getAttribute("user");
	String user_name = (user != null) ? user.getName() : "";
	
	Page<CourseRecommendation> lists = (Page)request.getAttribute("lists");
	int nowPage = (int) request.getAttribute("nowPage");
	int startPage = (int) request.getAttribute("startPage");
	int endPage = (int) request.getAttribute("endPage");
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
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/course.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
	
        <script type="text/javascript">
		$(document).ready(function () {
			var userName = "<%= user_name %>";
			
			// 페이지 로드 시 저장된 버튼 상태를 확인하여 클래스 추가
	        var activeRegion = localStorage.getItem('activeRegion');
	        if (activeRegion) {
	            $('.rbtn[value="' + activeRegion + '"]').addClass('active');
	        }

	        // 각 버튼에 대한 클릭 이벤트 처리
	        $('.rbtn').click(function () {
	            var regionValue = $(this).val();

	            // 모든 버튼에서 active 클래스 제거
	            $('.rbtn').removeClass('active');

	            // 클릭된 버튼에 active 클래스 추가
	            $(this).addClass('active');

	            // 클릭된 버튼의 값을 localStorage에 저장
	            localStorage.setItem('activeRegion', regionValue);
	        });
			
		    /** 모달 창 띄우기 **/
		    // 모달 팝업창 데이터 동적으로 가져오기
		    $(document).on('click', '.course-wrap', function (event) {
		        var courseId = $(this).data('course-id');

		        // data-course-id 속성이 있는지 확인
		        if (courseId !== undefined) {
		            // Ajax 요청 보내기
		            $.ajax({
		                type: "POST",
		                url: "course_modal.do",
		                data: { courseId: courseId },
		                success: function (result) {
		                    initializeModal();

		                    const modalObj = JSON.parse(result);
							
		                    // 모달 내부 데이터 채우기
		                    $('.favbtn').attr('id', 'favbtn'+ courseId );                                                                                                                      
		                    $('.favbtn').attr('data-id', courseId ); 
		                    $('.tripbtn').attr('id', modalObj.courseDest ); 
		                    document.getElementById('mcourseHit').innerText = modalObj.courseHit;
		                    document.getElementById('mcourseDest').innerHTML = modalObj.courseDest;
		                    document.getElementById('mcourseName').innerHTML = modalObj.courseName;
		                    document.getElementById('mcourseDur').innerHTML = modalObj.courseDur;
		                    document.getElementById('mcourseDis').innerHTML = modalObj.courseDis;
		                    document.getElementById('mcourseManager').innerHTML = modalObj.courseManager;
		                    document.getElementById('mcourseDetail').innerHTML = modalObj.courseDetail;
							document.getElementById('mcourseImage').src = modalObj.courseImage;
							document.getElementById('mcourseDate').innerHTML = modalObj.courseDateString;
							
						
							if(userName !== ""){
								showFavorite();
							}
							
		                },
		                error: function (error) {
		                    console.error("Error: " + error);
		                }
		            });

		            // 모달 초기화 함수 호출
		            function initializeModal() {
		                document.getElementById('mcourseDest').innerHTML = "";
		                document.getElementById('mcourseName').innerHTML = "";
		                document.getElementById('mcourseDur').innerHTML = "";
		                document.getElementById('mcourseDis').innerHTML = "";
		                document.getElementById('mcourseManager').innerHTML ="";
		                document.getElementById('mcourseDetail').innerHTML = "";
		                document.getElementById('mcourseImage').src = "";
		                document.getElementById('mcourseDate').innerHTML = "";
		            };
		            
		        } else {
		            console.error("error");
		        }
		        
		        /** 즐겨찾기 버튼 **/
		        // 즐겨찾기 추가 / 삭제  
			    $(document).on('click', '#favbtn'+courseId , function (event) {

			    	var $button = $(this);
			        
			        if(userName !== ""){
				        if (!$button.hasClass('active')) {
			 		        $.ajax({
			 		            type: "POST",
			 		            url: "/user/favorite_insert.do",
			 		            data: { courseId: courseId },
			 		            success: function (result) {
					                
			 		                $button.addClass('active');
					                
			 		            },
			 		            error: function (error) {
			 		                console.error("Error: " + error);
			 		            }
			 		        });
				        } else {
			 		        $.ajax({
			 		            type: "POST",
			 		            url: "/user/favorite_delete.do",
			 		            data: { courseId: courseId },
			 		            success: function (result) {
					                
			 		                $button.removeClass('active');
					                
			 		            },
			 		            error: function (error) {
			 		                console.error("Error: " + error);
			 		            }
			 		        });
				        }
			        } else {
			        	alert('로그인을 해주세요.');
			        
			        }	        
			        
			    });
		     ///////////////////// 즐겨찾기
		    });   
		///////////////////모달클릭
			
		});
		
		/** 즐겨찾기 버튼 활성화 / 비활성화 **/
		function showFavorite(){
		
		   var courseId = $('.favbtn').attr('data-id');
			
		   // 사용자 코스 ID 목록 가져오기
	       $.ajax({
	           type: "POST",
	           url: "/user/show_favorite.do",
	           success: function (favCourses) {
	               // 사용자 코스 즐겨찾기 목록에 포함되어 있는지 확인
	               if (favCourses.includes(courseId)) {
	                   // 목록에 포함되어 있으면 버튼을 활성화
	                   $('#favbtn' + courseId).addClass('active');
	               } else {
	            	   // 목록에 포함되지 않으면 버튼 비활성화
	            	   $('#favbtn' + courseId).removeClass('active');
	               }
	           },
	           error: function (error) {
	               console.error("Error: " + error);
	           }
	       });
	
		};
		
		function tripButton() {
		    // 세션에서 사용자 정보 가져오기
		    var user_name = "<%=user_name %>";
		    var reg_dosi = $('.tripbtn').attr('id');
		    
		    if (user_name !== "") {
		        // 사용자 세션이 존재하면 일정 만들기 페이지로 이동
				window.location.href = '/user/trip_plan.do?region=' + reg_dosi;
		    } else {
		        // 사용자 세션이 없으면 로그인 폼으로 이동
		        alert('로그인을 해주세요');
		        location.href = '/loginForm.do';
		    }
		};
		
		function refreshPage() {
		    location.reload();
		};
	
	
		</script>
		
    </head>
	
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./user/header.jsp" %>
        <main class="flex-shrink-0" id="main">
          <div class="py-3 bg-light" id="lists">
              <div class="container px-3 my-3">
                  <h3  class="fw-bolder text-dark"><a href="course.do" style="text-decoration: none; color: #333;">&nbsp;</a></h3>
                  <div class="row gx-5 justify-content-center">
                      <div class="col-lg-10 col-xl-7" style="width:1000px">
                          <div class="text-center">
                            <h2 class="display-7 fw-bolder text-dark mb-2" style="font-size:40px;">특별한 코스로,</h2>
                            <h2 class="display-5 fw-bolder text-dark mb-3" style="font-size:55px;">여행을 더 특별하게</h2>
                            <p class="fw-light text-dark-50" style="word-break: break-word; font-size:19px; margin:0;">우리의 여행 코스 추천은 단순한 경로가 아닌, 감동과 기쁨이 깃든 일정으로 여러분을 초대합니다. </p>
                            <p class="fw-light text-dark-50 mb-4" style="word-break: break-word; font-size:19px; margin:0;">그곳에서 펼쳐지는 풍경과 만나는 사람들, 맛보는 음식까지, 모두가 우리만의 특별한 추억으로 남을 것입니다.</p>                       
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <!-- Blog preview section-->
          
          
          <section class="py-1 px-2 relative border">
              	<div class="container px-5 my-5" style="height: 155px;">
              	<!-- <h3 class="relative" style="top: -24px;"><b>${region}</b></h3> -->
			  	<span class="flex gap-4 align-items-center relative" style="justify-content: space-between;">
					<b style="position: absolute; left: 0; top: -34px;">총 ${lists.totalElements}건</b>
					<div class="ft-face-nm fw-nomarl">
						<form action="/course.do" id="regionForm" method="GET" class="form-inline p-2 bd-highlight" role="search" style="width: 500px;">
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="">전체</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="서울">서울</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="경기">경기</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="인천">인천</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="강원">강원</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="충청">충청</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="대전">대전</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="세종">세종</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="경상">경상</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="부산">부산</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="울산">울산</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="대구">대구</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="전라">전라도</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="광주">광주</button>
							<button class="rbtn btn btn-outline-info" type="submit" name="region" value="제주">제주</button>
						</form>	
				    </div>
					<!-- 검색 -->
					<form action="/course.do" id="searchForm" method="GET" class="form-inline p-2 bd-highlight" role="search" style="position: relative; top: -26px;">
						<div class="flex" >
						<span class="search-form" style="display: flex; align-items: center; margin-left: 5px;">
							<select class="form-select" id="sort" name="sort" style="margin-right: 5px;">
								<c:choose>
								   <c:when test="${sort == 'hit'}">
									   <option value="hit" selected>조회순</option>
									   <option value="latest">최신순</option>
								   </c:when>
								   <c:when test="${sort == 'latest'}">
									   <option value="hit">조회순</option>
									   <option value="latest" selected>최신순</option>
								   </c:when>
								   <c:otherwise>
									   <option value="hit">조회순</option>
									   <option value="latest">최신순</option>
								   </c:otherwise>
							   </c:choose>
							</select>
							<input type="text" name="keyword" class="form-control" id="search" placeholder="검색" value="${keyword }" style="width: 200px; margin-right:10px">
							<button class="btn btn-outline-info bi bi-search"></button>
						</span>
						</div>
					</form>
	
				</span>
				
             </div>
                
          		
	              
				<!-- 코스 추천 리스트 -->
				<div class="course-container" id="courseList" style="display: flex; gap: 20px;justify-content: start; align-items: center;flex-wrap: wrap; max-width: 1300px; margin: 0 auto;">

                <% for (CourseRecommendation course : lists) { %>
                <div class="course-item filter-web">
                    <div class="course-wrap" data-bs-toggle='modal' data-bs-target='#course-modal' data-course-id='<%=course.getId() %>' >
          
                        <img src="<%=course.getCourseimage() %>" class="img-fluid" alt="" style="display: block; width: 100%; height: 250px;" >
                        <div class="course-info">
                            <h4 style="font-size:25px; font-weight:500"><%= course.getCoursename() %></h4>
                            <p style="font-size:19px; font-weight:500"><%= course.getCoursedest() %></p>
                            <p style="font-size:19px; font-weight:500">조회수: <%= course.getHit() %></p>
                        </div>
                    </div>
                </div>
           		<% } %>
				</div>
	     
          </section>
        
		<!-- 페이징 -->     
     

<div class="flex justify-center items-center my-3 ft-face-nm">
    <nav aria-label="표준 페이지 매김 예제">
        <ul class="pagination">
            <% if (lists.hasPrevious()) { %>
                <li class="page-item">
                    <a class="page-link" href="course.do?sort=${sort}&page=<%= lists.previousPageable().getPageNumber() %>&region=${region}&keyword=${keyword}" aria-label="이전의">
                        <span aria-hidden="true">‹</span>
                    </a>
                </li>
            <% } %>

            <% for (int currentPage = startPage; currentPage <= endPage; currentPage++) { %>
                <li class="page-item <%= (currentPage - 1 == lists.getNumber() ? "active" : "") %>">
                    <a class="page-link" href="course.do?sort=${sort}&page=<%= currentPage - 1 %>&region=${region}&keyword=${keyword}"><%= currentPage %></a>
                </li>
            <% } %>

            <% if (lists.hasNext()) { %>
                <li class="page-item">
                    <a class="page-link" href="course.do?sort=${sort}&page=<%= lists.nextPageable().getPageNumber() %>&region=${region}&keyword=${keyword}" aria-label="다음">
                        <span aria-hidden="true">›</span>
                    </a>
                </li>
            <% } %>
        </ul>
    </nav>
</div>



      </main>
      <!-- Footer-->--
	  <footer class="bg-dark py-4 mt-auto">
		<div class="container px-5">				
			<div class="flex flex-col">
				<div class="flex-fill row align-items-center justify-content-between flex-column flex-sm-row">
					<div class="col-auto"><div class="small m-0 text-white">Copyright &copy; TripTable 2024</div></div>
					<div class="col-auto">
						<a class="link-light small" href="#!">대표 [ 손수빈 ]</a>
						<span class="text-white mx-1">&middot;</span>
						<a class="link-light small" href="#!">문의 [ 010-1234-5678 ]</a>
						<span class="text-white mx-1">&middot;</span>
						<a class="link-light small" href="#!">Mail [ 0928ssb@naver.com ]</a>
					</div>
				</div>
				<div class="flex-fill">
					<div style="color: #fff; font-size: 11px;">이미지 출처 : 한국공공포탈데이터활용</div>
				</div>
			</div>
		</div>
	</footer>	
			<!-- 코스 추천 리스트 모달 -->
			<div class="modal fade" id="course-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-hidden="true">
		    <!-- 모달 내용 -->
		      <div class="modal-dialog modal-xl fixed top-0 bottom-0 left-0 right-0 flex items-center justify-center">

				<div class="modal-content relative m-4 md:m-8 bg-white rounded-lg max-h-[82vh] w-full md:w-auto" style="width: 80vw; height: 80vh;">		           
					<div class="modal-header"  style="background-color: #00aef0;">
						<span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
							<img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
							<img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
						</span>
					</div>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="right: 15px; position: absolute; top: 15px; z-index: 9999;" onclick="refreshPage()"></button>
		            <div class="flex justify-center max-w-screen-lg" style="width: 100%; height: calc(100% - 42px); padding: 70px;">
		                
			                <div class="w-full md:w-1/2 md:p-6" id="courseModal" style="margin-right: 70px; word-break: keep-all;">
			                   
			                    <h1 id="mcourseDest" class="text-sm text-gray-500 md:text-xl font-Montserrat" style="color: rgba(0, 0, 0, 0.5); font-size: 20px;"></h1>
			                    <h2 class="mb-4 text-xl font-bold leading-none md:mb-2 md:text-4xl">
			                        <span id="mcourseName" class="text-[9px] md:text-xs font-medium text-red-600 ml-1 align-top" style="font-size:25px;"></span>
			                    </h2>
			                    <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-2">
			                    	 <span class="text-[8px] text-white opacity-50" style="color: #000 !important;">소요 시간 : </span>
			                        <div id="mcourseDur" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                         
			                    </div>
			                     <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-2">
			                    	<span class="text-[8px] text-white opacity-50" style="color: #000 !important;">거리 : </span>
			                        <div id="mcourseDis" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                     </div>
			                     <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-2">
			                    	 <span class="text-[8px] text-white opacity-50" style="color: #000 !important;">추천인 : </span>
			                        <div id="mcourseManager" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                    </div>
			                     <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-2">
			                    	 <span class="text-[8px] text-white opacity-50" style="color: #000 !important;">업로드일자 : </span>
			                        <div id="mcourseDate" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                    </div>
			                    <div id="mcourseDetail" style="overflow-y: auto; height: 360px;" class="pt-4 text-xs font-thin text-justify lg:text-sm line-clamp-3 line-clamp-3 md:line-clamp-none">
			                    </div>
			                    <div>
			                        <div class="flex flex-col justify-between mt-4 md:flex-row"></div>
			                    </div>
			                </div>
			                <!-- 이미지 부분 -->
			                 <div class="hidden md:flex md:w-1/2 md:p-6" style="display: flex; flex-direction: column; align-items: flex-end;">
			                    <div class="relative w-full h-[340px] mb-4">
			                        <img id="mcourseImage" src="" class="relative object-cover w-full h-full shadow-sm brightness-95" alt="Image" style="background-size: cover;">
			                    </div>
								<!-- 버튼 -->
								<div class="flex w-full mt-4" style="justify-content: space-between;">
								    <button class="flex items-center justify-center btn btn-outline-primary" style="pointer-events: none;">
								      <i id="mcourseHit" style="margin-left: 5px;" class="bi bi-heart-fill ml-1 mb-0.5" ></i> 						      
								    </button>
	
								    <button class="favbtn flex items-center justify-center btn btn-outline-primary" id="">
								    	<i class="bi bi-bookmark-plus"></i>
								    </button>
								    
								</div>
								<div class="flex w-full gap-2 mt-2">
								    <button class="tripbtn flex items-center justify-center btn btn-outline-primary w-full">
								        <a href="javascript:void(0);" onclick="tripButton()" class="tripButton flex items-center justify-center w-full px-1.5 text-xs md:text-base text-lightScheme-confirm rounded-md border-2 border-lightScheme-confirm font-bold md:py-2 px-3">
								            일정만들기 <i style="margin-left: 5px;" class="bi bi-calendar-week ml-1 mb-0.5"></i>
								        </a>
								    </button>
								</div>
							</div>
					</div>
				</div>
			</div>
		</div>

		<a href="#" class="back-to-top d-flex align-items-center justify-content-center active"><i class="bi bi-arrow-up-short"></i></a>
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>

		<!-- Core theme JS-->
		<script src="js/scripts.js"></script>
		
	</body>
</html>