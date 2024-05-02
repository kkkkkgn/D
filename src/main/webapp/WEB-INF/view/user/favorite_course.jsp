<%@page import="com.example.triptable.entity.User"%>
<%@page import="org.springframework.data.domain.Page"%>
<%@page import="com.example.triptable.entity.CourseRecommendation"%>
<%@page import="java.util.List"%>
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
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/course.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script type="text/javascript">
		$(document).ready(function () {
			var userName = "<%= user_name %>";
   
        /** 모달 창 띄우기 **/
	    // 모달 팝업창 데이터 동적으로 가져오기
	    $(document).on('click', '.course-wrap', function (event) {
		        var courseId = $(this).data('course-id');

		        // data-course-id 속성이 있는지 확인
		        if (courseId !== undefined) {
		            // Ajax 요청 보내기
		            $.ajax({
		                type: "POST",
		                url: "/course_modal.do",
		                data: { courseId: courseId },
		                success: function (result) {
		                    // 성공 시 동작
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
		            	document.getElementById('mcourseHit').innerText = "";
		                document.getElementById('mcourseDest').innerHTML = "";
		                document.getElementById('mcourseName').innerHTML = "";
		                document.getElementById('mcourseDur').innerHTML = "";
		                document.getElementById('mcourseDis').innerHTML = "";
		                document.getElementById('mcourseManager').innerHTML ="";
		                document.getElementById('mcourseDetail').innerHTML = "";
		                document.getElementById('mcourseImage').src = "";
		                document.getElementById('mcourseDate').innerHTML = "";

		            }
		            
		        } else {
		            console.error("error");
		        }
		        
		        /** 즐겨찾기 버튼 **/
		        // 즐겨찾기 추가 / 삭제  
			    $(document).on('click', '#favbtn'+courseId , function (event) {
			    	//var courseId = $(this).attr('data-id');
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
			 		                
			 		                // 페이지 리로드
			 		                location.reload(true);
					                
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
		     
		    });  
		});
		
		/** 즐겨찾기 버튼 활성화 / 비활성화 **/
		function showFavorite(){
		
		   var courseId = $('.favbtn').attr('data-id');
			
		   // 사용자가 코스 ID 목록 가져오기
	       $.ajax({
	           type: "POST",
	           url: "/user/show_favorite.do",
	           success: function (favCourses) {
	               // 사용자 코스 즐겨찾기 목록에 포함되어 있는지 확인
	               if (favCourses.includes(courseId)) {
	                   //  목록에 포함되어 있으면 버튼을 활성화
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
		    } 
		};
		</script>
		
    </head>
	
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
          <div class="py-3 bg-light" id="lists">
              <div class="container px-3 my-3">
                  <div class="row gx-5 justify-content-center">
                      <div class="col-lg-10 col-xl-7">
                          <div class="text-center">
                          
                            <h4 class="display-6 fw-bolder text-dark mb-3">즐겨찾기</h4>
                        
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <!-- Blog preview section-->
          
          
          <section class="py-1 px-2 relative border">
              <div class="container px-5 my-5">
              <h4><b></b></h4>

                 <div class="flex ">

				    </form>	
				    <!-- 검색 -->
				    <form action="/user/favorite.do" id="searchForm" method="GET" class="form-inline p-2 bd-highlight" role="search" >
				   		<span class="search-form" style="display: flex; align-items: center; margin-left: 1000px;">
			                <input type="text" name="keyword" class="form-control" id="search" placeholder="검색" value="${keyword }" style="width: 200px;">
			                <button class="btn btn-outline-info bi bi-search"></button>
			            </span>
				    </form>	

				</div>
				
                </div>

				<!-- 코스 추천 리스트 -->
				<div class="course-container " id="courseList" style="max-width: 1300px; margin: 0 auto;" >
					<div style="display: flex; gap: 20px;justify-content: start;align-items: center;flex-wrap: wrap;" >
		                <% for (CourseRecommendation course : lists) {%>
		                <div class=" course-item filter-web border" style="box-shadow: 0 0 5px rgba(0, 0, 0, 0.3);">
		                    <div class="course-wrap" id='courseId' data-bs-toggle='modal' data-bs-target='#course-modal' data-course-id='<%=course.getId() %>' style="">
		                   
		                        <img src="<%=course.getCourseimage() %>" class="img-fluid" alt="" style=" width: 100%; display: block; height: 250px;">
		                        <div class="course-info">
		                            <h4><%= course.getCoursename() %></h4>
		                            <p><%= course.getCoursedest() %></p>
		                        </div>
		                    </div>
		                </div>
		           		<% } %>
	       			</div>
					<!-- 페이징 -->          
					<div class="flex justify-center items-center my-3 ft-face-nm">
					    <nav aria-label="표준 페이지 매김 예제" _mstaria-label="655265" _msthash="546">
					        <ul class="pagination">
					            <% if (lists.hasPrevious()) { %>
					                <li class="page-item">
					                    <a class="page-link" href="favorite.do?page=<%= lists.previousPageable().getPageNumber() %>&keyword=${keyword}" aria-label="이전의">
					                        <span aria-hidden="true">«</span>
					                    </a>
					                </li>
					            <% } %>
					            
					            <% for (int currentPage = startPage; currentPage <= endPage; currentPage++) { %>
					                <li class="page-item <%= (currentPage - 1 == lists.getNumber() ? "active" : "") %>">
					                    <a class="page-link" href="favorite.do?page=<%= currentPage - 1 %>&keyword=${keyword}"><%= currentPage %></a>
					                </li>
					            <% } %>
					
					            <% if (lists.hasNext()) { %>
					                <li class="page-item">
					                    <a class="page-link" href="favorite.do?page=<%= lists.nextPageable().getPageNumber() %>&keyword=${keyword}" aria-label="다음" >
					                        <span aria-hidden="true">»</span>
					                    </a>
					                </li>
					            <% } %>
					        </ul>
					    </nav>
					</div>
				     
          </section>
        
	
<!-- 페이징 정보 출력 -->


      </main>
      <!-- Footer-->
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
			<div class="modal fade" id="course-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"  aria-hidden="true" >
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
		            <div class="flex justify-center max-w-screen-lg relative" style="width: 100%; height: calc(100% - 42px); padding: 70px;">
		                
			                <div class="w-full md:w-1/2 md:p-6" id="courseModal" style="margin-right: 70px; word-break: keep-all;">
			                   
			                    <h1 id="mcourseDest" class="text-sm text-gray-500 md:text-xl font-Montserrat" style="color: rgba(0, 0, 0, 0.5); font-size: 15px;"></h1>
			                    <h2 class="mb-4 text-xl font-bold leading-none md:mb-2 md:text-4xl">
			                        <span id="mcourseName" class="text-[9px] md:text-xs font-medium text-red-600 ml-1 align-top"></span>
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
			                    	 <span class="text-[8px] text-white opacity-50" style="color: #000 !important;">추천인: </span>
			                        <div id="mcourseManager" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                    </div>
			                     <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-2">
			                    	 <span class="text-[8px] text-white opacity-50" style="color: #000 !important;">업로드일자 : </span>
			                        <div id="mcourseDate" class="text-[8px] text-white opacity-50" style="color: #000 !important;"></div>
			                    </div>
			                    <div id="mcourseDetail" style="overflow-y: auto;  height: calc(100% - 270px);" class="mt-4 text-xs font-thin text-justify lg:text-sm line-clamp-3 line-clamp-3 md:line-clamp-none">
			                    </div>
			                    <div>
			                        <div class="flex flex-col justify-between mt-4 md:flex-row"></div>
			                    </div>
			                </div>
			                <!-- 이미지 부분 -->
			                 <div class="hidden md:flex md:w-1/2 md:p-6" style="display: flex; flex-direction: column; align-items: flex-end;">
			                    <div class="relative w-full h-[340px] mb-4">
			                        <img id="mcourseImage" src="" class="relative object-cover w-full h-full shadow-sm brightness-95" alt="Image">
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
		<!--       <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script> -->
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
		<!-- 부트스트랩 JS -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

		<!-- Core theme JS-->
		<script src="../js/scripts.js"></script>
		
	</body>
</html>