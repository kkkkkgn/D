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
        <link rel="icon" type="image/x-icon" href="./favicon.ico" />
       
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
			// 라디오버튼 바뀔 때 페이지 로드
			$("input[name='region']").on('change', function() {
			    $("#regionForm").submit();
			});

		    // 모달 팝업창 데이터 동적으로 가져오기
		    $(document).on('click', '.course-wrap', function (event) {
		        var courseId = $(this).data('course-id');

		        // data-course-id 속성이 있는지 확인
		        if (courseId !== undefined) {
		            // Ajax 요청 보내기
		            $.ajax({
		                type: "GET",
		                url: "course_modal.do",
		                data: { courseId: courseId },
		                success: function (result) {
		                    // 성공 시 동작
		                    initializeModal();

		                    const modalObj = JSON.parse(result);

		                    console.log(modalObj.courseImage);
		                    console.log(modalObj.courseName);
							
		                    // 모달 내부 데이터 채우기
		                    document.getElementById('courseDest').innerHTML = modalObj.courseDest;
		                    document.getElementById('courseName').innerHTML = modalObj.courseName;
		                    document.getElementById('courseDur').innerHTML = modalObj.courseDur;
		                    document.getElementById('courseDis').innerHTML = modalObj.courseDis;
		                    document.getElementById('courseDetail').innerHTML = modalObj.courseDetail;
		                    
							var courseImageElement = document.getElementById('courseImage');
							var imageUrl = modalObj.courseImage;
							
							if (imageUrl) {
							    courseImageElement.src = imageUrl;
							} else {
							    // 이미지 URL이 없는 경우
							    courseImageElement.src = './img/course/noimage.png';
							}
		                    console.log("Course ID: " + courseId);
		                },
		                error: function (error) {
		                    console.error("Error: " + error);
		                }
		            });

		            // 모달 초기화 함수 호출
		            function initializeModal() {
		                document.getElementById('courseDest').innerHTML = "";
		                document.getElementById('courseName').innerHTML = "";
		                document.getElementById('courseDur').innerHTML = "";
		                document.getElementById('courseDis').innerHTML = "";
		                document.getElementById('courseDetail').innerHTML = "";
		                document.getElementById('courseImage').src = "";
		            }
		        } else {
		            console.error("error");
		        }
		    });    
		});
		</script>
		
    </head>
	
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./user/header.jsp" %>
        <main class="flex-shrink-0" id="main">
          <div class="py-3 bg-light">
              <div class="container px-3 my-3">
                  <div class="row gx-5 justify-content-center">
                      <div class="col-lg-10 col-xl-7">
                          <div class="text-center">
                            <h2 class="display-7 fw-bolder text-dark mb-2">여행의 마법,</h2>
                            <h2 class="display-5 fw-bolder text-dark mb-3">우리만의 추억으로</h2>
                            <p class="fw-light text-dark-50 mb-4" style="word-break: break-word;">우리의 여행 코스 추천은 단순한 경로가 아닌, 감동과 기쁨이 깃든 일정으로 여러분을 초대합니다. 그곳에서 펼쳐지는 풍경과 만나는 사람들, 맛보는 음식까지, 모두가 우리만의 특별한 추억으로 남을 것입니다.</p>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <!-- Blog preview section-->
          <section class="py-1">
              <div class="container px-5 my-5">
                  <form action="/course.do" id="regionForm" method="GET" class="form-inline p-2 bd-highlight" role="search" >

                  <div class="flex gap-3 mb-5">
                  <div class="ft-face-nm fw-nomarl" style="display: flex; justify-content: start; align-items: center; flex-wrap: wrap;">
                    <div class="form-check form-check-inline" id="form-check">
                      <input class="form-check-input" type="radio" id="inlineCheckbox1" name="region" value="서울">
                      <label class="form-check-label" for="inlineCheckbox1">서울</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox2" name="region" value="경기">
                        <label class="form-check-label" for="inlineCheckbox2">경기</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox3" name="region" value="인천">
                        <label class="form-check-label" for="inlineCheckbox3">인천</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox4" name="region" value="강원">
                        <label class="form-check-label" for="inlineCheckbox4">강원</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox5" name="region" value="충청">
                        <label class="form-check-label" for="inlineCheckbox5">충청</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox6" name="region" value="대전">
                        <label class="form-check-label" for="inlineCheckbox6">대전</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox7" name="region" value="세종">
                        <label class="form-check-label" for="inlineCheckbox7">세종</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox8" name="region" value="경상">
                        <label class="form-check-label" for="inlineCheckbox8">경상</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox9" name="region" value="부산">
                        <label class="form-check-label" for="inlineCheckbox9">부산</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox10" name="region" value="울산">
                        <label class="form-check-label" for="inlineCheckbox10">울산</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox11" name="region" value="대구">
                        <label class="form-check-label" for="inlineCheckbox11">대구</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox12" name="region" value="전라">
                        <label class="form-check-label" for="inlineCheckbox12">전라도</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox13" name="region" value="광주">
                        <label class="form-check-label" for="inlineCheckbox13">광주</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="inlineCheckbox14" name="region" value="제주">
                        <label class="form-check-label" for="inlineCheckbox14">제주</label>
                    </div>
                  </div>

                </div>
                </form>
          
				<!-- 코스 추천 리스트 -->
				<div class="row course-container" id="courseList">

                <% for (CourseRecommendation course : lists) { %>
                <div class="col-lg-4 col-md-6 course-item filter-web">
                    <div class="course-wrap" id='course' data-bs-toggle='modal' data-bs-target='#course-modal' data-course-id='<%=course.getId() %>'>
                    	<%
						    String imageUrl = (course.getCourseimage() != null && !course.getCourseimage().isEmpty()) 
						                        ? course.getCourseimage() 
						                        : "./img/course/noimage.png";
						%>
                        <img src="<%=imageUrl %>" class="img-fluid" alt="">
                        <div class="course-info">
                            <h4><%= course.getCoursename() %></h4>
                            <p><%= course.getCoursedest() %></p>
                            <div class="course-links">
                                <a href="<%= course.getCourseimage() %>" data-gallery="courseGallery" class="course-lightbox" title="<%= course.getCoursename() %>"><i class="bx bx-plus"></i></a>
                                <a href="#" title="More Details"><i class="bx bx-link"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
           		<% } %>
				</div>
	      	</div>
          </section>
        
		<!-- 페이징 -->          
		<div class="flex justify-center items-center my-3 ft-face-nm">
		    <nav aria-label="표준 페이지 매김 예제" _mstaria-label="655265" _msthash="546">
		        <ul class="pagination">
		            <% if (lists.hasPrevious()) { %>
		                <li class="page-item">
		                    <a class="page-link" href="course.do?page=<%= lists.previousPageable().getPageNumber() %>&region=${selectedRegion}" aria-label="이전의">
		                        <span aria-hidden="true">«</span>
		                    </a>
		                </li>
		            <% } %>
		            
		            <% for (int currentPage = startPage; currentPage <= endPage; currentPage++) { %>
		                <li class="page-item <%= (currentPage - 1 == lists.getNumber() ? "active" : "") %>">
		                    <a class="page-link" href="course.do?page=<%= currentPage - 1 %>&region=${selectedRegion}"><%= currentPage %></a>
		                </li>
		            <% } %>
		
		            <% if (lists.hasNext()) { %>
		                <li class="page-item">
		                    <a class="page-link" href="course.do?page=<%= lists.nextPageable().getPageNumber() %>&region=${selectedRegion}" aria-label="다음" >
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
                  <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2023</div></div>
                  <div class="col-auto">
                      <a class="link-light small" href="#!">Privacy</a>
                      <span class="text-white mx-1">&middot;</span>
                      <a class="link-light small" href="#!">Terms</a>
                      <span class="text-white mx-1">&middot;</span>
                      <a class="link-light small" href="#!">Contact</a>
                  </div>
              </div>
          </div>
      </footer>   	
			<!-- 코스 추천 리스트 모달 -->
			<div class="modal fade" id="course-modal">
		    <!-- 모달 내용 -->
		      <div class="modal-dialog modal-xl fixed top-0 bottom-0 left-0 right-0 flex items-center justify-center">
		        <div class="modal-content relative m-4 md:m-8 bg-white rounded-lg max-h-[82vh] overflow-y-auto w-full md:w-auto" style="width: 80vw; height: 70vh;">
		            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

		            <div class="flex justify-center max-w-screen-lg" style="width: 100%; height: calc(100% - 42px); padding: 50px;">
		                
		                <div class="w-full md:w-1/2 md:p-6" id="courseModal" style="margin-right: 70px; word-break: keep-all;">
		                   
		                    <h1 id="courseDest" class="text-sm text-gray-500 md:text-xl font-Montserrat" style="color: rgba(0, 0, 0, 0.5); font-size: 15px;"></h1>
		                    <h2 class="mb-4 text-xl font-bold leading-none md:mb-2 md:text-4xl">
		                        <span id="courseName" class="text-[9px] md:text-xs font-medium text-red-600 ml-1 align-top"></span>
		                    </h2>
		                    <div class="relative mt-2 md:hidden h-[180px] w-full flex gap-4">
		                        <div id="courseDur" class="text-[8px] text-white opacity-50" style="color: #000 !important;">소모</div>
		                        <div id="courseDis" class="text-[8px] text-white opacity-50" style="color: #000 !important;">KM</div>
		                    </div>
		                    <div id="courseDetail" class="pt-4 text-xs font-thin text-justify lg:text-sm line-clamp-3 line-clamp-3 md:line-clamp-none">
		                    </div>
		                    <div>
		                        <div class="flex flex-col justify-between mt-4 md:flex-row"></div>
		                    </div>
		                </div>
			                <!-- 이미지 부분 -->
			                 <div class="hidden md:flex md:w-1/2 md:p-6" style="display: flex; flex-direction: column; align-items: flex-end;">
			                    <div class="relative w-full h-[340px] mb-4">
			                        <img id="courseImage" src="" class="relative object-cover w-full h-full shadow-sm brightness-95" alt="Image">
			                    </div>
							<!-- 버튼 -->
							<div class="flex w-full mt-4" style="justify-content: space-between;">
							    <button class="flex items-center justify-center btn btn-outline-primary">
							        <a class="flex items-center justify-center w-full px-1.5 text-xs md:text-base text-lightScheme-confirm rounded-md border-2 border-lightScheme-confirm font-bold md:py-2 px-3">
							            숙박 <img style="margin-left: 5px;" src="https://www.myro.co.kr/assets/images/hotel.svg" class="ml-1 mb-0.5" />
							        </a>
							    </button>
							    <button class="flex items-center justify-center btn btn-outline-primary">
							        <a class="flex items-center justify-center w-full px-1.5 text-xs md:text-base text-lightScheme-confirm rounded-md border-2 border-lightScheme-confirm font-bold md:py-2 px-3">
							            HIT <img style="margin-left: 5px;" src="https://www.myro.co.kr/assets/images/hotel.svg" class="ml-1 mb-0.5" />
							        </a>
							    </button>
							</div>
							<div class="flex w-full gap-2 mt-2">
							    <button class="flex items-center justify-center btn btn-outline-primary w-full">
							        <a class="flex items-center justify-center w-full px-1.5 text-xs md:text-base text-lightScheme-confirm rounded-md border-2 border-lightScheme-confirm font-bold md:py-2 px-3">
							            일정만들기 <img style="margin-left: 5px;" src="https://www.myro.co.kr/assets/images/hotel.svg" class="ml-1 mb-0.5">
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
		<script src="js/scripts.js"></script>
		
	</body>
</html>