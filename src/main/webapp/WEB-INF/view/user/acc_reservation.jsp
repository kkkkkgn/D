<%@page import="java.time.LocalDateTime"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.triptable.entity.Region"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import ="com.example.triptable.entity.User" %>

<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();

LocalDateTime currentDateTime = LocalDateTime.now();
LocalDate currentDate = LocalDate.now();
int currentYear = currentDate.getYear();
int currentMonth = currentDate.getMonthValue();

int year = 0;
int month = 0;

int selectedYear = (year != 0) ? year : currentYear;
int selectedMonth = (month != 0) ? month : currentMonth;

if (selectedMonth > 12) {
    selectedYear += selectedMonth / 12;
    selectedMonth = selectedMonth % 12;
}

LocalDate startCalendar = LocalDate.of(selectedYear, selectedMonth, 1);
LocalDate endCalendar = LocalDate.of(selectedYear, selectedMonth, startCalendar.lengthOfMonth());

int startDayOfWeek = startCalendar.getDayOfWeek().getValue()+1;
int endDay = endCalendar.getDayOfWeek().getValue();

StringBuilder strCalendar = new StringBuilder();
strCalendar.append("<table border='0' cellspacing='0' id='tablearea' class='tablearea'>");
strCalendar.append("<caption>").append(selectedYear).append("년").append(selectedMonth).append("월").append("</caption>");
strCalendar.append("<thead><tr align='center'>");

String[] daysOfWeek = {"일", "월", "화", "수", "목", "금", "토"};

for (String day : daysOfWeek) {
    strCalendar.append("<th>").append(day).append("</th>");
}

strCalendar.append("</tr></thead><tbody>");
strCalendar.append("<tr>");

for (int i = 1; i < startDayOfWeek; i++) {
    strCalendar.append("<td></td>");
}

for (int i = 1, n = startDayOfWeek; i <= endCalendar.getDayOfMonth(); i++, n++) {
    if (n % 7 == 1) {
        strCalendar.append("<tr>");
    }
    LocalDateTime selectedDateTime = LocalDateTime.of(selectedYear, selectedMonth, i, 12, 0); // 12시로 설정
    
    String cellClass = (selectedDateTime.isBefore(currentDateTime)) ? "past-day" : "";

    strCalendar.append("<td class='").append(cellClass).append("'>").append(i).append("</td>");
    if (n % 7 == 0) {
        strCalendar.append("</tr>");
    }
}

for (int i = 0; i < 7 - endDay; i++) {
    if (endDay == 0) {
        continue;
    }
    strCalendar.append("<td></td>");
}
strCalendar.append("</tbody></table>");


int nextMonth = selectedMonth + 1;
int nextYear = selectedYear;


if (nextMonth > 12) {
    nextYear += nextMonth / 12;
    nextMonth = nextMonth % 12;
}

LocalDate startNextCalendar = LocalDate.of(nextYear, nextMonth, 1);
LocalDate endNextCalendar = LocalDate.of(nextYear, nextMonth, startNextCalendar.lengthOfMonth());
int startNextDayOfWeek = startNextCalendar.getDayOfWeek().getValue()+1;
int endNextDay = endNextCalendar.getDayOfWeek().getValue();

StringBuilder strNextCalendar = new StringBuilder();
strNextCalendar.append("<table border='0' cellspacing='0' id='nextTableArea' class='tablearea'>");
strNextCalendar.append("<caption>").append(nextYear).append("년").append(nextMonth).append("월").append("</caption>");
strNextCalendar.append("<thead><tr align='center'>");

for (String day : daysOfWeek) {
    strNextCalendar.append("<th>").append(day).append("</th>");
}

strNextCalendar.append("</tr></thead><tbody>");
strNextCalendar.append("<tr>");

for (int i = 1; i < startNextDayOfWeek; i++) {
    strNextCalendar.append("<td></td>");
}

for (int i = 1, n = startNextDayOfWeek; i <= endNextCalendar.getDayOfMonth(); i++, n++) {
    if (n % 7 == 1) {
        strNextCalendar.append("<tr>");
    }
    String cellClass = (LocalDate.of(nextYear, nextMonth, i).isBefore(currentDate)) ? "past-day" : "";
    
    strNextCalendar.append("<td class='").append(cellClass).append("'>").append(i).append("</td>");
    if (n % 7 == 0) {
        strNextCalendar.append("</tr>");
    }
}

for (int i = 0; i < 7 - endNextDay; i++) {
    if (endNextDay == 0) {
        continue;
    }
    strNextCalendar.append("<td></td>");
}
strNextCalendar.append("</tbody></table>");
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        
        
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/reservation.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/tripplan.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        
        
    </head>
    <body id="accRes" class="d-flex flex-column full-screen react react-st" style="box-sizing: border-box;">
        <%@ include file="./res_header.jsp" %>
        <main class="flex-shrink-0" id="main" style="max-width: 100%; margin: 0;">
            <div class="EoVr relative">
                <div class="flex w-full p-2 px-4 gap-4" style="background-color: #00aef0;">
                    <div class="text-center">
                        <div role="text" style="height: 50px; color: white; font-size: 20px;">숙소 예약</div>
                    </div>
                </div>
            </div>
            <div id="findPlaces" class="bg-white mh-3 z-3 p-3">
                <!-- 숙소 이름 -->
                <div class="fs-6 fw-bold pb-2"><%= user.getNickname() %>님 환영합니다!</div> 
                <div id="menu_wrap">
                    <div class="option">
                    	<div class="flex">
                            <input id="keyword" for="spot-search" class="form-control mr-sm-3 w-full" placeholder="숙소 이름 검색" onkeydown="handleKeyPress(event)" style="flex:1" type="search" value="" aria-label="Search" size="15">
                            <button class="btn btn-outline-primary my-2 my-sm-0" type="button" onclick="SearchAcc()" id="spot-search">검색</button>
                        </div>
                        <!-- </form> -->
                    </div>
                    
                    <div class="flex flex-column align-items-center justify-start w-full relative mt-3" style="height: calc(100% - 260px);">
                        <div id="accList" class="placesList list-group w-full mx-2" style="overflow-y: auto; height:850px"></div>
                    </div>
                    <div id="pagination"></div>
                </div>
            </div>
             <!----------------------- 카카오 API 설정 -->  
             
            <div id="map" class="h-full relative" style="z-index: 1; left: 350px; width: calc(100% - 420px); top: 133px; position: absolute; left: 420px;"></div>
        </main>
<!----------------------- 달력 설정 -->  
        <div class="datepicker" id="CalendarTableara">
            <div id="datepickerBG" class="fixed top-0 bottom-0 left-0 right-0 z-50 flex items-center justify-center w-screen h-full bg-black bg-opacity-75">
                <div id="datepicker" class="relative bg-white rounded-none md:rounded-lg shadow md:max-h-[90vh] overflow-y-auto overflow-x-hidden w-full h-full pt-8 p-4 md:p-12 md:w-auto md:h-auto flex flex-col justify-center items-center">
                    <div class="flex items-center justify-center w-full pt-2 bg-white md:pt-4 md:text-4xl">여행 기간이 어떻게 되시나요?</div>
                    <div class="flex flex-col items-center justify-center w-full px-2 py-1">
                        <div class="text-[9px] text-black md:text-sm underline-offset-4 underline ">* 여행 일자는 <b class="">최대 5일</b>까지 설정 가능합니다.</div>
                        <div class="py-1 px-2 text-[9px] text-black md:text-sm underline-offset-4 underline">현지 여행 기간<b class="">(여행지 도착 날짜, 여행지 출발 날짜)</b>으로 입력해 주세요.</div>
                    </div>
                    <div class="flex flex-col items-center justify-center my-2"></div>
                    <div class="relative my-4">
                        <div class="datepicker__month-container flex gap-3 px-3">
                            <div>
                                <%=strCalendar.toString() %>
                            </div>
                            <div>
                                <%=strNextCalendar.toString() %>
                            </div>
                            <script>
                                function getSelectedMonth() {
                                    // 이 부분에 서버측에서 selectedMonth 값을 가져오는 로직을 추가
                                    return <%=selectedMonth%>;
                                }

                                function getSelectedYear() {
                                    // 이 부분에 서버측에서 selectedYear 값을 가져오는 로직을 추가
                                    return <%=selectedYear%>; 
                                }

                            </script>

                        </div>
                    </div>
                    <div class="btn-container w-full">
                        <button id="CanlenderBtn" type="submit" onclick="calendarOn()" class="btn btn-info-light" style="float:right; margin-right:20px;">선택</button>
                    </div>
                </div>
            </div>
        </div>

        <!-------- 예약 모달 -->
        <div class="modal fade" id="reservationModal" tabindex="-1" role="dialog" aria-labelledby="reservationModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-lg" role="document" style="max-width: 60%;">
		        <div class="modal-content bg-white" style="top: 50%;">
		            <!-- Title -->
		            <input type="hidden" name="acc_id" id="acc_id" value="">
		            <div class="modal-header accInfo-header" style="background-color: #00aef0;">
		                 <h1 class="modal-title fs-5" id="staticBackdropLabel">
                    		<span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
		                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
		                        <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
		                    </span>
		                 </h1>
		            </div>
		
		            <!-- Top left: Accommodation Image -->
		            <div class="modal-body relative">
		                <div class="d-flex gap-1">
                            <div class="flex flex-col">
                                <div class="accommodationName" id="accommodationName"  class="ft-face-nm" style="font-size: 22px; word-break: keep-all; font-weight: 500; margin-bottom: 15px;">숙소 이름</div>
                                <div class="flex gap-3">
                                    <img id="accommodationImage" src="" alt="Accommodation Image" style="height: 250px; width:350px">
                                    <div class="flex flex-col" style="font-size: 12px;">
                                        <p>체크인 날짜 : <br/><span id="checkinDate" style="font-size: 20px;"></span></p>
                                        <p>체크아웃 날짜 : <br/><span id="checkoutDate" style="font-size: 20px;"></span></p>
                                        <p>숙소 가격 ( 1박 ) : <br/><span id="accommodationFee" style="font-size: 20px;"></span> 원</p>
                                    </div>
                                </div>
                            </div>

		                </div>
		            </div>

		
		            <div class="accSummary" style="padding: 0 15px; margin-block: 10px;" >
		                <div id="accommodationSummary" style="max-height: 150px; overflow-y: auto;">여기에 숙소의 상세 정보를 입력하세요.</div>
		            </div>
		            <div class="modal-footer accInfo-footer">
		                <button class="btn btn-primary" onclick="reservateAccommodation()">예약하기</button>
		                <button class="btn btn-secondary" onclick="closeReservationModal()">닫기</button>
		            </div>
		        </div>
		    </div>
		</div>
        
		<div class="modal fade small-modal" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="paymentModalLabel" aria-hidden="true" >
		    <div class="modal-dialog" role="document">
		        <div class="modal-content" style="top: 50px;">
		           	<div class="modal-header" style="background-color: #00aef0;">
		                <h1 class="modal-title fs-5" id="staticBackdropLabel">
	                    <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
	                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
	                        <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
	                    </span>
	                  </h1>
		            </div>
		            <div class="modal-body">
		                <div class="payment-options">
		                	<!-- <p>결제 방식을 선택 해주세요.</p> -->
		                	<p>현재 카카오페이만 지원하고 있습니다.</p>
		                	
		                		 <form method="post" name="kakaoPayForm" action="/user/kakaoPay.do">
			                		<input type="hidden" name="orderNumber" value="">
			                		<input type="hidden" name="res_guests" value="">
			                		<input type="hidden" name="acc_id" value="">
			                		<input type="hidden" name="acc_fee" value="">
			                		<input type="hidden" name="res_start" value="">
			                		<input type="hidden" name="res_end" value="">
			                		<button style="border:none !important; background-color: #fff;">
			                			<img src="../img/kakaoPay.png" alt="카카오페이" class="btn-payment" style="width: 140px;">
			                		</button>
			                    </form>
		                   
		                </div>
		            </div>
		            <div class="modal-footer" >
		                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="closePaymentmodal()">닫기</button>
		            </div>
		        </div>
		    </div>
		</div>
		
<!----------------------- 달력 설정 -->  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61d0c0883a09f0cac4e91b6dee183a31&libraries=services"></script>
        <script src="../js/Jmap.js"></script>
        <script src="../js/res_scripts.js"></script>
        <script type="text/javascript">
        $(document).ready(function() {
            // 초기 지역 설정값 (ex: 서울 특별시)
            // $(".sidoValues").text('서울특별시');
            initializeMapByDosi();
            // 오늘 날짜 가져오기
            var today = new Date();

            // 내일 날짜 계산
            var tomorrow = new Date(today);
            tomorrow.setDate(today.getDate() + 1);

            // 그 다음 날짜 계산
            var nextDay = new Date(today);
            nextDay.setDate(today.getDate() + 2);

            // 요일을 반환하는 함수
            var getDayOfWeek = function(date) {
                var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
                return daysOfWeek[date.getDay()];
            };

            // 날짜를 텍스트로 설정하여 $(".trvl_day")에 추가
            var formattedToday = today.getFullYear() + '. ' + (today.getMonth() + 1) + '. ' + today.getDate() + '.(' + getDayOfWeek(today) + ')';
            var formattedTomorrow = tomorrow.getFullYear() + '. ' + (tomorrow.getMonth() + 1) + '. ' + tomorrow.getDate() + '.(' + getDayOfWeek(tomorrow) + ')';
            var formattedNextDay = nextDay.getFullYear() + '. ' + (nextDay.getMonth() + 1) + '. ' + nextDay.getDate() + '.(' + getDayOfWeek(nextDay) + ')';

            $(".trvl_day").text(formattedTomorrow + " - " + formattedNextDay);
        });

        </script>
    </body>
</html>