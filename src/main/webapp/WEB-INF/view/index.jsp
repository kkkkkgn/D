<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="user" value="${sessionScope.user}" />
<%@ page import="com.example.triptable.entity.CourseRecommendation"%>
<%@ page import="java.util.List"%>
<%@page import="com.example.triptable.entity.User"%>
<%

	User user = (User)session.getAttribute("user");
	String user_name = (user != null) ? user.getName() : "";

   List<CourseRecommendation> courseList = (List)request.getAttribute("courseList");
   
   String course123 = "";
   String course456 = "";


   for(int i=0; i<2; i++){   
      for(int j=0; j<3; j++){
         CourseRecommendation course = courseList.get(i*3+j);
           
           // Timestamp 타입을 그대로 사용
           Timestamp timestamp = course.getDate();
           
           // Date를 분까지 포맷
           SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
           String formattedDate = dateFormat.format(timestamp);
         
         
         String course0 = "<div class=\"course col-lg-4 mb-5\" data-bs-toggle=\"modal\" data-bs-target=\"#course-modal\" data-course-id=\"" + course.getId() +"\"><div class=\"card h-100 shadow border-0\">"
               + "<img class=\"card-img-top\" src= \""
               + course.getCourseimage() + "\" alt=\"...\" /><div class=\"card-body p-4\"><div class=\"flex gap-2 justify-content-between items-center\"><div class=\"badge bg-primary bg-gradient rounded-pill mb-2\">"
               + course.getCoursedest() + "</div><p> </p></div><a class=\"text-decoration-none link-dark stretched-link\" href=\"#!\"><h5 class=\"card-title mb-3\">"
               + course.getCoursename() + "</h5></a><p class=\"card-text mb-0\">"
               + course.getCoursesum() + "</p></div><div class=\"card-footer p-4 pt-0 bg-transparent border-top-0 flex\"><div><img src='../img/rank" + (i*3+j+1) + ".png' style='width:40px; margin-right:15px;'/></div><div class=\"d-flex align-items-end justify-content-between\">"
               + "<div class=\"small\"><div class=\"fw-bold\">"+course.getCoursemanager()+"</div><div class=\"text-muted\">"+formattedDate+"&nbsp; &middot; &nbsp;조회 수 "+course.getHit()+"</div></div></div></div></div></div>";
         
               
               
         if(i == 0){
            course123 += course0;
         } else if(i == 1){
            course456 += course0;
         }      
      }
   }
      
   

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
		<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/mainCalendar.css" rel="stylesheet" />
        
         <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        <script src="../js/mainCalendar.js"></script>
        <script src="../js/index.js"></script>
    </head>
    
    <!-- 경고창 -->
   
   
   <style>
/*    #movingIcon { */
/*     position: fixed; */
/*     /* bottom: 20px; 원하는 위치 (예: 20px) */ */
/*     /* right: 20px; 원하는 위치 (예: 20px) */ */
/* 	left: 214px; */
/* 	top: 2px; */
/* 	color: #fff; */
/*     width: 50px; /* 원하는 크기 */ */
/*     height: 50px; /* 원하는 크기 */ */
/*     transition: bottom 0.3s, right 0.3s; /* 부드러운 이동 효과 */ */
/* 	} */
	
/*  	#chatButton {  */
/*  	    background: none;  */
/* 	    border: none;  */
/*  	    padding: 0;  */
/*  	}  */

	/* 팝업 스타일 */
	.popup {
	    position: fixed; /* 화면 스크롤과 관계없이 고정 */
	    width: 250px;
	    background-color: white;
	    border: 1px solid #ccc;
 	    padding: 10px; 
	    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	    display: none;
	    /* bottom: 90px; */
	    left: 214px;
		top: 62px;
	    z-index: 999; /* 다른 요소 위에 표시 */
	}

	/* 채팅창 스타일 */
	.chat-container {
	    position: relative;
	}
	
	/* 채팅 아이콘 스타일 */
	.chat-icon {
	    /* 아이콘에 대한 스타일링은 필요한 경우 추가하세요 */
	}
	
 	.shadow-drop-br {
	-webkit-animation: shadow-drop-br 0.4s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
	        animation: shadow-drop-br 0.4s cubic-bezier(0.250, 0.460, 0.450, 0.940) both;
}
	
	@-webkit-keyframes shadow-drop-br {
  0% {
    -webkit-box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
            box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
  }
  100% {
    -webkit-box-shadow: 12px 12px 20px -12px rgba(0, 0, 0, 0.35);
            box-shadow: 12px 12px 20px -12px rgba(0, 0, 0, 0.35);
  }
}
@keyframes shadow-drop-br {
  0% {
    -webkit-box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
            box-shadow: 0 0 0 0 rgba(0, 0, 0, 0);
  }
  100% {
    -webkit-box-shadow: 12px 12px 20px -12px rgba(0, 0, 0, 0.35);
            box-shadow: 12px 12px 20px -12px rgba(0, 0, 0, 0.35);
  }
}
	
	
.region-info {
      text-align: left;
}

.region-info h1 {
    color: #f4f3fc;
    font-size: 4em; /* 원하는 크기로 조절하세요 */
/*     font-weight:bold; */
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* 테두리 그림자 설정 */
    margin-bottom: 20px;
}

.region-info h4 {
    color: #3e3e3ef5;
    font-size: 1.2em; /* 원하는 크기로 조절하세요 */
    text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3); /* 테두리 그림자 설정 */
    margin-bottom: 20px;
    margin-top:20px;
}

.region-info h5 {
    color: #857ffcf5;
    font-size: 1.1em; /* 원하는 크기로 조절하세요 */
    text-shadow: 1px 1px 6px rgba(0, 0, 0, 0.3); /* 테두리 그림자 설정 */
/*     font-weight: bold; */
}

.video {
	width:100%;
	z-index: -1;
	outline: none;
	border: none;
	-webkit-mask-image: -webkit-radial-gradient(white, black);    
	-webkit-backface-visibility: hidden;    
	-moz-backface-visibility: hidden;
}


#tablearea tr {
	width: 100%;
}
#tablearea tr:last-child td:last-child {
	display: none;
}
.card-img, .card-img-top {
	height: 248px;
}
	
	</style>
	
	
<body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;" id="index">
        
<%@ include file="./user/header.jsp" %>

<script>
function login_alert() {
    alert("로그인 후 이용할 수 있는 페이지입니다.");
    window.location.href = "./loginForm.do";
}
</script>


	<main id="main" class="flex-shrink-0" style="overflow: hidden; max-width: 100%; margin: 0; margin-top:-25px; border: none;">
		<!-- Navigation-->
		<!-- Header-->
		<div class="py-5 relative z-1" style="background-color: #fff; ">
			<video class="video" muted autoplay loop style="position: absolute; top: 0; border:0;">
				<source src="/img/map/Above Clouds.webm" type="video/webm">
			</video>
			<div id="myDiv" class="container relative px-5">
				<div class="container relative px-5 flex" style="top: -25px;">
					<div class="row gx-5 align-items-center justify-content-center">
						<div class="col-lg-8 col-xl-7 col-xxl-6" style="height:760px; display: flex; align-items: center; justify-content: center; height: 100vh; flex-direction: column;"">
							<div class="my-5 text-center" style="top:10%; position: relative;">
							<!-- 지역 사진과 설명이 추가될 div -->
								<div id="regionDiv" class="col-xl-5 col-xxl-6 d-none d-xl-block text-center stretchRight" style="overflow:hidden; width:600px; height:800px; position: relative; margin-top:-52px;">
									<div id="regionImgDiv" class="animate__animated animate__fadeIn">
										<div class="region-info">
											<h1 id="regionH1">서울특별시</h1>
											<img id="regionImg" src="/img/map/seoul.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">
											<h4>&nbsp;서울은 역사, 현대, 음식, 쇼핑, 문화가 어우러진 도시입니다.<br/>&nbsp;아름다움과 독특한 매력으로 특별한 경험을 선사합니다.</h4>
											<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5>
										</div>
									</div>
								</div>
							</div>   
						</div>
					</div>
					<div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center" style="overflow:hidden; margin-top:50px; height:760px; position: relative;">
					<!-- 메인페이지 지도 표시 -->
						<%@ include file="koreamap.jsp" %>
					</div>
				</div>
			</div>
		</div>			
		<div class="relative" style="height: 250px; border: none;"></div>
		<div style="border: none; position: fixed; top:0; left:0; right: 0; width: calc(100% - 20px); height: 707px; z-index: -2;">
			<video class="video" style="border: none; width: 100%; height: 100%; object-fit: cover;" src="../img/nature(1080p).mp4" muted autoplay playsinline loop></video>
		</div>
		<div class="relative" style="background-color: #fff; padding-left: 90px; padding-top: 50px; word-break: keep-all; margin-bottom: -20px;">
			<div class="" style="position: absolute;top:82px;left:0;width: 60px;height: 3px;background-color:#00aef0;"></div>
			<div class="col-lg-8 col-xl-6">
				<div class="w-full" style="text-align: left;">
					<h3 style="font-weight: 700; font-size: 60px; line-height: 1.09em; color:#2e2e2e;"><span style="color:#00aef0; font-size: 60px;">N</span>OTI<span style="color:#fff; font-size: 60px; -webkit-text-stroke: 1px #5f5f5f;">CE</span></h3>
					<p class="" style="font-weight: 1000;font-size: 18px;line-height: 1.41em; color:#4b3838; letter-spacing: -0.025em;margin-top: 15px;">우리와 함께하는 <span class="" style="color:#00aef0; font-weight: 1000;">여행 코스</span>, <span class="" style="color:#ea9d9d; font-weight: 1000;">우리만의 특별한 순간</span>을 담아냅니다.</p>
				</div>
			</div>
		</div>
	<!-- 공지사항 & 달력 -->
		<section class="py-5 relative" style="background-color: #fff; margin-bottom: 250px;">
			<div class="container px-5 my-5" style="display:flex; color:#555555;">
			
				<!-- 여행 달력 -->
				<div class="row row-cols-1 row-cols-md-3 mb-3 text-center" style="margin-right:70px;">      
					<div class="col">
					<div class="card mb-4 rounded-3 shadow-sm" style="width:550px; box-shadow: 7px 7px 10px #888888;">
						<div class="card-header py-3 text-black" style="display:flex; background-color:#F3C5C5; text-align:left; border-bottom: 1.5px solid #AAAAAA; justify-content: space-between; align-items:center">
						<div>
							<h4 style="margin: 0; color:#555555;"><i class="bi bi-calendar-heart"></i> 여행 달력 </h4>
						</div>
						<div>
							<c:if test="${not empty user }">
							<a href="/user/time_machine.do"><i class="bi bi-plus-lg" style="font-size:25px; font-weight:bold; color:#555555; text-align:right;"></i></a>
							</c:if>
							<c:if test="${empty user }">
							<a onclick="login_alert()"><i class="bi bi-plus-lg" style="font-size:25px; font-weight:bold; color:#555555; text-align:right;"></i></a>
							</c:if>
						</div>         
						</div>
						<div class="card-body" style="display:flex; align-items:center; justify-content: space-between; height:400px">
						<div><i class="bi bi-caret-left-fill" data-bs-target="#planDemo" data-bs-slide="prev" style="color:#555555"></i></div>
						<div id="planDemo" class="carousel slide" data-bs-ride="carousel" style="width:480px;">
								
								<div id="carouselExample" class="carousel-inner container-fluid mt-3" style="width:480px; text-align:left; ">
								<div>&nbsp;</div>
									<div class="carousel-item active" style="width:460px" >
										<div class="datepicker" style="width:460px">
											
											<div>
												${currentMonthHtml}
											</div>
										</div>
									</div>
									<div class="carousel-item" style="width:460px" >
										<div class="datepicker" style="width:460px">
											<div>
												${nextMonthHtml}
											</div>
										</div>
									</div>
									<script>
									</script>			
									
								</div>				
						</div>
						<div><i class="bi bi-caret-right-fill"data-bs-target="#planDemo" data-bs-slide="next" style="color:#555555"></i></div>
						</div>
					</div>
					</div>
				</div>				    
				
				
				<script>

					function getSelectedMonth() {
						return ${selectedMonth};
					}

					function getSelectedYear() {
						return ${selectedYear};
					}
					
					var list = JSON.parse('${activeTeamList}');
					
					$(document).ready(function() {
						for(var i=0; i<list.length; i++){
							
							var startDate = new Date(list[i][0]);
							var endDate = new Date(list[i][1]);
							
							var formatter = new Intl.DateTimeFormat('en-US', { year: 'numeric', month: '2-digit', day: '2-digit' });

							for(var j=startDate; j <= endDate; j.setDate(j.getDate() + 1)){
									var formattedDate = j.toISOString().split('T')[0];
									var hoverDay = formattedDate.replace(/-/g, '-');
									
									if(hoverDay == list[i][0] || hoverDay == list[i][1]){
										var selectedDay = $('#' + hoverDay);		                    	    	 
										selectedDay.addClass('selected-day');
										
									}else {
										var hoverDay = $('#' + hoverDay);		                    	    	 
										hoverDay.addClass('hover-day');
									}
							}
						}
					});
					
				</script>
				
				<!--  공지사항 캐러셀 -->
				<div class="row row-cols-1 row-cols-md-3 mb-3 text-center">      
					<div class="col">
					<div class="card mb-4 rounded-3 shadow-sm" style="width:550px; box-shadow: 7px 7px 10px #888888;">
						<div class="card-header py-3 text-black" style="display:flex; background-color:#F3C5C5; text-align:left; border-bottom: 1.5px solid #AAAAAA; justify-content: space-between; align-items:center">
						<div>
							<h4 style="margin: 0; color:#555555"><i class="bi bi-megaphone-fill"></i> 공지 사항 </h4>
						</div>
						<div>
							<a href="/notice.do"><i class="bi bi-plus-lg" style="font-size:25px; font-weight:bold; color:#555555; text-align:right;"></i></a>
						</div>         
						</div>
						<div class="card-body" style="overflow: hidden; height:400px; display:flex; justify-content: center;">
						<div id="noticeDemo" class="carousel slide" data-bs-ride="carousel" style="width:480px">
			
								<!-- 인디케이터 -->
								<div class="carousel-indicators" style="top:350px">
									<c:forEach var="urgentNotice" items="${urgentNoticeList}" varStatus="status">
										<button type="button" style="background-color:#555555" data-bs-target="#noticeDemo" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></button>
									</c:forEach>
								</div>
								
								<!-- 캐러셀 슬라이드 -->
								
								<div id="carouselExample" class="carousel-inner container-fluid mt-3" style="width:480px; text-align:left; vertical-align:middle">
								
								<c:forEach var="urgentNotice" items="${urgentNoticeList}" varStatus="status">
								<div class="carousel-item ${status.index == 0 ? 'active' : ''}" onclick="sendNoticePage(${urgentNotice.id})" style="width:400px" >
									<div id="notice${urgentNotice.id}" style="width:450px; height:400px;">									
										<h5>${urgentNotice.name}</h5>
										<br/>
										<span>${urgentNotice.content}</span>
									</div>
								</div>
								</c:forEach>
								</div>
			
						</div>
						</div>
					</div>
					</div>
				</div>
				
			</div>
		</section>
	
		<!-- Blog preview section-->
		<section class="py-5 relative" style="background-color: #fff;">
			<div class="relative mb-5" style="padding-left: 90px; word-break: keep-all; ">
				<div class="" style="position: absolute;top:32px;left:0;width: 60px; height: 3px;background-color:#00aef0;"></div>
				<div class="col-lg-8 col-xl-6">
					<div class="w-full" style="text-align: left;">
						<h3 style="font-weight: 700; font-size: 60px; line-height: 1.09em; color:#2e2e2e;"><span style="color:#00aef0; font-size: 60px;">C</span>OUR<span style="color:#fff; -webkit-text-stroke: 1px #5f5f5f; font-size: 60px;">SE</span></h3>
						<p class="" style="font-weight: 1000;font-size: 18px;line-height: 1.41em; color:#4b3838; letter-spacing: -0.025em;margin-top: 15px;">우리와 함께하는 <span class="" style="color:#00aef0; font-weight: 1000;">여행 코스</span>, <span class="" style="color:#ea9d9d; font-weight: 1000;">우리만의 특별한 순간</span>을 담아냅니다.</p>
						<!-- <p class="lead fw-normal text-muted mb-5">이 여행 코스는 단순한 관광이 아닌, 우리만의 특별한 순간들을 담아냅니다. 함께한 순간들은 마치 시간을 멈추게 하듯 특별하고 소중한 기억들이 될 것입니다.</p> -->
					</div>
				</div>
			</div>
			<div class="container">

					
				<!-- 추천코스 삽입내용 -->
				<!-- Carousel -->
				<div id="demo" class="carousel slide" data-bs-ride="carousel">
					<!-- The slideshow/carousel -->
					<div class="carousel-inner">
						<div class="carousel-item active" data-bs-interval="3000">
							<!-- 추천코스 삽입내용 -->
							<div class="row gx-5">
								<%=course123 %>
							</div>
						</div>
						<div class="carousel-item" data-bs-interval="3000">
							<!-- 추천코스 삽입내용 -->
							<div class="row gx-5">
								<%=course456 %>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</section>
	</main>
<!--         </div> -->
        
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
		
		<!-- 팝업 공지 모달 -->
		<div class="modal" id="popupNotice" tabindex="-1" role="dialog">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header"  style="background-color: #00aef0;">
		                <h5 class="modal-title" >
							<span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
								<img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
								<img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
							</span>
						</h5>
		                <i class="bi bi-x-lg" type="button" id="close1" class="close" data-dismiss="modal" aria-label="Close">
		                </i>
		            </div>
		            <div class="modal-body">
		                <p>제목 : ${popUpNotice.name}</p>
		                <!-- 이미지 넣을 예정 -->
						<span>${popUpNotice.content}</span>
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-primary" id = "modal-today-close">오늘 하루 보지않기</button>
		                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="close2">닫기</button>
		            </div>
		        </div>
		    </div>
		</div>
		<script>
		
		$(document).ready(function() {
			
			/** 모달 창 띄우기 **/
		    // 모달 팝업창 데이터 동적으로 가져오기
		    $('.course').on('click', function(){
		    	
		    	var userName = "<%= user_name %>";
		    	
        		 var courseId = $(this).data('course-id');

		        // data-course-id 속성이 있는지 확인
		        if (courseId !== undefined) {
		            // Ajax 요청 보내기
		            $.ajax({
		                type: "POST",
		                url: "course_modal.do",
		                data: { 
		                	courseId: courseId 
		                	},
		                success: function(result){
		                		
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
		        //////즐겨찾기
		    });   
		///////////////////모달클릭


			if('${popUpNotice}' === ''){
				$('#popUpNotice').hide();
				
		} else {
			
			// myCookie라는 이름의 쿠키를 얻음
        	var cookie = getCookie('myCookie');
        	
        	// 값이 popupEnd이면 모달을 띄우지 않음
        	if(cookie === 'popupEnd'){
        		$('#popupNotice').modal('hide');
        		
        	// 모달을 띄움
        	} else{
        		if("${popUpNotice.name}" === ''){
        			$('#popupNotice').modal('hide');
        		}else{
        			$('#popupNotice').modal('show');
        		}
        	}
        	
        	// 오늘하루 보지않기 누르면 팝업 없어지게 하고 쿠키 설정
        	$('#modal-today-close').on('click', function(){
        		$('#popupNotice').modal('hide');
        		
        		setCookie('myCookie', 'popupEnd', 1);
        	});
        	
        	$('#close1').on('click', function(){
        		$('#popupNotice').modal('hide');
        		
        	});
        	
        	$('#close2').on('click', function(){
        		$('#popupNotice').modal('hide');
        		
        	});
		}
		});
		
		function tripButton() {
		    // 세션에서 사용자 정보 가져오기
		    var user_name = "<%=user_name %>";
		    var reg_dosi = $('.tripbtn').attr('id');
		    
		    if (user_name !== "") {
		        // 사용자 세션이 존재하면 일정 만들기 페이지로 이동
				window.location.href = '/trip_plan.do?region=' + reg_dosi;
		    } else {
		        // 사용자 세션이 없으면 로그인 폼으로 이동
		        alert('로그인을 해주세요');
		        location.href = '/loginForm.do';
		    }
		};
		
		
		</script>
        <!-- Bootstrap core JS-->
        <!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
    </body>
</html>