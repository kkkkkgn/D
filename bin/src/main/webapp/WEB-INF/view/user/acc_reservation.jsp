<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.triptable.entity.Region"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import ="com.example.triptable.entity.User" %>
<%-- 
-- 날짜 데이터 불러오기 
LocalDate currentDate = LocalDate.now();
-- 이번 년도
int currentYear = currentDate.getYear();
-- 이번 달
int currentMonth = currentDate.getMonthValue();
-- 이번 년도, 이번 달 초기화
int year = 0;
int month = 0;
-- 년도와 달이 0이 아닐때
int selectedYear = (year != 0) ? year : currentYear;
int selectedMonth = (month != 0) ? month : currentMonth;
-- 달이 13개 될 수도 있어서 12개로 고정
if (selectedMonth > 12) {
    selectedYear += selectedMonth / 12;
    selectedMonth = selectedMonth % 12;
}
-- 달력시작 이번년도 , 이번달 , 1일부터 시작
LocalDate endCalendar = LocalDate.of(selectedYear, selectedMonth, startCalendar.lengthOfMonth());
-- 현재 달에서 1일이 무슨 요일인지 계산하기 위해 getValue() = 현재 요일 반환 
int startDayOfWeek = startCalendar.getDayOfWeek().getValue()+1;
-- 현재 달에서 마지막 날이 무슨 요일인지 계산하기 위해 getValue() = 현재 요일 반환 
int endDay = endCalendar.getDayOfWeek().getValue();
--%>
<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();


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

    String cellClass = (LocalDate.of(selectedYear, selectedMonth, i).isBefore(currentDate)) ? "past-day" : "";

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
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/tripplan.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        
    </head>
    <body id="accRes" class="d-flex flex-column full-screen react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
            <div class="EoVr relative">
                <div class="flex w-full p-2 px-4 gap-4" style="background-color: #00aef0;">
                    <!-- <div class="text-center">
                        <div role="button" class="p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">장소 검색</div>
                    </div> -->
                    <div class="text-center">
                        <div role="button" class="p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">숙소 설정</div>
                    </div>
                </div>
            </div>
            <div id="findPlaces" class="bg-white mh-3 z-3 p-3">
                <!-- 여행지 이름 -->
                <div class="fs-6 fw-bold pb-2">민희와 함께하는 여행</div> 
                <div id="menu_wrap">
                    <div class="option">
                        <form class="form-inline " onsubmit="searchPlaces(); return false;">
                            <input id="keyword" for="spot-search" class="form-control mr-sm-3 w-full" style="flex:1" type="search" value="강남" aria-label="Search" size="15">
                            <button class="btn btn-outline-primary my-2 my-sm-0" type="submit" id="spot-search">검색</button>
                        </form>
                    </div>
                    
                    <div class="flex flex-column align-items-center justify-start w-full relative" style="height: calc(100% - 260px);">
                        <div id="placesList" class="placesList list-group w-full mx-2" style="overflow-y: auto;"></div>
                    </div>
                    <div id="pagination"></div>
                </div>
            </div>
             <!----------------------- 카카오 API 설정 -->  
             <div id="map" class="h-full relative" style="z-index: 1; left: 350px; width: calc(100% - 350px);"></div>
             <div id="mapData" style="width: 170px; z-index: 9999; position: fixed; top: 145px; right: 0;">
                 <label>정보 : </label> 
                 <input style="display: inline-block;" type="text" id="fulladdress" name="fulladdress" style="width: 100%;"/>
                 <label>이름 : </label>
                 <input style="display: inline-block;" type="text" id="title" name="title" value="" />
                 <label>주소 : </label>
                 <input style="display: inline-block;" type="text" id="address" name="address" value="" />
                 <label>위도 : </label>
                 <input style="display: inline-block;" type="text" id="latclick" name="latclick" value="" />
                 <label>경도 : </label>
                 <input style="display: inline-block;" type="text" id="lngclick" name="lngclick" value="" />
             </div>
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
                        <button id="CanlenderBtn" type="submit" class="btn btn-info-light" style="float:right; margin-right:20px;">선택</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="root">
            <div aria-hidden="false" class="YSUE YSUE-mod-animate YSUE-mod-layer-default YSUE-mod-position-fixed">
                <div class="YSUE-background YSUE-mod-variant-default"></div>
                <div role="dialog" aria-modal="true" class="dDYU dDYU-mod-theme-default dDYU-mod-variant-header-search-form-v3 dDYU-mod-padding-none dDYU-mod-position-top dDYU-mod-direction-none  dDYU-mod-animate dDYU-mod-visible a11y-focus-outlines dDYU-mod-shadow-elevation-one">
                    <div class="dDYU-viewport">
                        <div class="dDYU-content">
                            <div class="dDYU-body">
                                <div tabindex="-1" id="searchFormDialog" class="c1r2d c1r2d-mod-vertical-hotels c1r2d-pres-animated c1r2d-mod-primary-colors">
                                    <section class="c1r2d-header-section">
                                        <div class="ui-layout-HeaderMainLogo normal-from-l-size main-logo--mobile">
                                            <a class="main-logo__link" href="/" itemprop="https://schema.org/logo" aria-label="호텔스컴바인 홈페이지로 이동하기">
                                                <div class="main-logo__logo has-compact-logo inverted-logo">
                                                    <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                                                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 20px; display: inline-block;" />
                                                        <img src="../img/Logo.png" alt="로고" style="height: 14px; display: inline-block;" />
                                                    </span>
                                                </div>
                                            </a>
                                        </div>
                                    </section>
                                    <section class="c1r2d-form-section">
                                        <div class="J_T2">
                                            <div class="J_T2-header"></div>
                                            <div class="J_T2-row J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall">
                                                <div class="J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall J_T2-mod-grow">
                                                    <div class="pM26">
                                                        <div role="button" tabindex="-1" class="puNl puNl-mod-cursor-inherit puNl-mod-font-size-base puNl-mod-radius-base puNl-mod-corner-radius-all puNl-mod-size-large puNl-mod-spacing-default puNl-mod-state-default puNl-mod-text-overflow-ellipsis puNl-mod-theme-search puNl-mod-validation-state-neutral puNl-mod-validation-style-border">
                                                            <div role="img" class="TWls TWls-mod-size-large TWls-mod-variant-prefix">
                                                                <svg viewBox="0 0 200 200" width="20" height="20" xmlns="http://www.w3.org/2000/svg" role="img">
                                                                    <path d="M175 170a5 5 0 0 1-5-5v-5H30v5a5 5 0 1 1-10 0v-43.092c0-8.176 3.859-15.462 10-20.027V65c0-13.785 11.215-25 25-25h90c13.785 0 25 11.215 25 25v36.98c6.093 4.613 10 11.922 10 19.928V165a5 5 0 0 1-5 5zM30 150h140v-10H30v10zm0-20h140v-8.092c0-7.342-5.486-13.707-12.762-14.806c-40.216-6.077-73.399-6.207-114.477 0C35.415 108.21 30 114.4 30 121.908V130zm120-34.027c2.877.382 9.581 1.381 10 1.467V65c0-8.271-6.729-15-15-15H55c-8.271 0-15 6.729-15 15v32.438c.418-.084 7.123-1.083 10-1.465V85c0-8.271 6.729-15 15-15h25a14.94 14.94 0 0 1 10 3.829A14.943 14.943 0 0 1 110 70h25c8.271 0 15 6.729 15 15v10.973zm-45-3.45c11.463.167 22.988.912 35 2.233V85c0-2.757-2.243-5-5-5h-25c-2.757 0-5 2.243-5 5v7.523zM65 80c-2.757 0-5 2.243-5 5v9.756c12.012-1.321 23.537-2.065 35-2.232V85c0-2.757-2.243-5-5-5H65z"></path>
                                                                </svg>
                                                            </div>
                                                            <input class="sidoValues NhpT NhpT-mod-radius-base NhpT-mod-corner-radius-all NhpT-mod-size-large NhpT-mod-state-default NhpT-mod-text-overflow-ellipsis NhpT-mod-theme-search NhpT-mod-validation-state-neutral NhpT-mod-validation-style-border" type="text" tabindex="0" placeholder="도시 지역을 선택해주세요." aria-autocomplete="list" aria-haspopup="listbox" value="서울">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall J_T2-mod-grow">
                                                    <div>
                                                        <div class="cBaN">
                                                            <div class="cBaN-date-select-wrapper">
                                                                <div class="jZyL">
                                                                    <div role="button" tabindex="0" class="JONo-button" aria-label="시작 날짜">
                                                                        <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="JONo-icon" role="img">
                                                                            <path d="M165 180H35c-8.3 0-15-6.7-15-15V35c0-8.3 6.7-15 15-15h25v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h60v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h25c8.3 0 15 6.7 15 15v130c0 8.3-6.7 15-15 15zM30 60v105c0 2.8 2.2 5 5 5h130c2.8 0 5-2.2 5-5V60H30zm0-10h140V35c0-2.8-2.2-5-5-5h-25v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H70v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H35c-2.8 0-5 2.2-5 5v15zm75 100c-2.8 0-5-2.2-5-5V97.1l-11.5 11.5c-2 2-5.1 2-7.1 0s-2-5.1 0-7.1l20-20c1.4-1.4 3.6-1.9 5.4-1.1c1.9.8 3.1 2.6 3.1 4.6v60c.1 2.8-2.1 5-4.9 5z"></path>
                                                                        </svg>
                                                                        <button class="btn btn-light trvl_day" style="background-color: #f0f2f5; border: none !important; flex:1;">2023.12.12(화) - 2023.12.14(목)<span class="ml-2"></span></button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall">
                                                    <div>
                                                        <div class="c3JX7-wrapper">
                                                            <button role="button" class="RxNS RxNS-mod-stretch RxNS-mod-variant-none RxNS-mod-theme-none RxNS-mod-shape-default RxNS-mod-spacing-none RxNS-mod-size-xlarge" tabindex="0" aria-disabled="false">
                                                                <div class="RxNS-button-container">
                                                                    <div class="RxNS-button-content">
                                                                        <div class="c3JX7-displayContent">
                                                                            <span class="c3JX7-userIcon">
                                                                                <svg viewBox="0 0 200 200" width="20" height="20" xmlns="http://www.w3.org/2000/svg" role="img">
                                                                                    <path d="M160.6 180H39.4c-1.6 0-3.2-.8-4.1-2.1c-8-11.5-6.8-32.8 2.2-41.5c3.9-3.8 23.8-10.5 35.6-14C58.8 108.1 50 95.4 50 70.9C50 38.6 68.2 20 100 20s50 18.6 50 50.9c0 23.8-8.2 36.7-23.1 51.5c11.8 3.5 31.6 10.2 35.6 14c9.1 8.7 10.3 30 2.3 41.5c-1 1.3-2.6 2.1-4.2 2.1zM42.3 170h115.5c4-8.3 2.4-21.8-2.1-26.3c-3.6-2.8-31.2-12.1-38.9-13.8c-3.5-.8-5.1-4.9-3-7.8c7.9-10.8 26.3-19.2 26.3-51.2c0-18.7-6.9-40.9-40-40.9S60 52.2 60 70.9c0 31.9 18.4 40.3 26.3 51.2c2.1 2.9.5 7.1-3 7.8c-7.7 1.6-35.3 10.9-38.9 13.7c-4.6 4.5-6.1 18.1-2.1 26.4zm2.2-26.4z"></path>
                                                                                </svg>
                                                                            </span>
                                                                            <span class="c3JX7-displayText">인원 2명</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <span class="QdG_" >
                                                    <span class="x_pP">
                                                        <button role="button" class="RxNS RxNS-mod-stretch RxNS-mod-animation-search RxNS-mod-variant-solid RxNS-mod-theme-base RxNS-mod-shape-default RxNS-mod-spacing-base RxNS-mod-size-xlarge" tabindex="0" aria-disabled="false" title="" type="submit" aria-label="검색" style="background-color: #fff; color: #444;">
                                                            <div class="RxNS-button-container">
                                                                <div class="RxNS-button-content">
                                                                    <div class="a7Uc">
                                                                        <div class="a7Uc-infix">
                                                                            <svg viewBox="0 0 200 200" width="24" height="24" xmlns="http://www.w3.org/2000/svg" class="A_8a-icon" role="img">
                                                                                <path d="M178.5 171.5l-44.2-44.2c9.8-11.4 15.7-26.1 15.7-42.3c0-35.8-29.2-65-65-65S20 49.2 20 85s29.2 65 65 65c16.1 0 30.9-5.9 42.3-15.7l44.2 44.2c2 2 5.1 2 7.1 0c1.9-1.9 1.9-5.1-.1-7zM30 85c0-30.3 24.7-55 55-55s55 24.7 55 55s-24.7 55-55 55s-55-24.7-55-55z"></path>
                                                                            </svg>
                                                                        </div>
                                                                        <div class="a7Uc-suffix">
                                                                            <span class="A_8a-label">업데이트</span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </button>
                                                    </span>
                                                </span>
                                            </div>
                                            <div class="J_T2-footer">
                                                <div class="OJEY-cmp2-wrapper">
                                                    <div>

                                                    </div>
                                                </div>
                                                <div class="c1ClF"></div>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </div>
                        </div>
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

        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61d0c0883a09f0cac4e91b6dee183a31&libraries=services"></script>
        <script src="../js/map.js"></script>
        <script src="../js/scripts.js"></script>
        <script src="../js/calendar.js"></script>
        <script>
        $(document).ready(function () {

            function getDosi(dosi) {
                $.ajax({
                    type: "GET",
                    url: "/addressJson.do", // 실제 서버 엔드포인트
                    data: {
                        dosi: dosi
                    },
                    success: function(data) {
                        // 서버에서 받은 응답 처리
                        //console.log(data);
                        var jsonData = JSON.parse(data);
                        var sido = $("#sido");
                                     
                        sido.empty();
                        // JSON 데이터를 반복하여 div를 추가
                        $.each(jsonData, function(index, value) {
                            var div = $("<div>").attr('id', value).text(value);
                            sido.append(div);
                        });
                    },
                    error: function(error) {
                        // 오류 처리
                        console.error(error);
                    }
                });
            }

            var sidoValues = $(".sidoValues").val();

            // 리스트 순서 바꾸기 
            $('#placesList').on('click', '.spotListone', function (event) {
                // 초기에 order indicators 업데이트
                $('.spot-container .spotListPage').each(function () {
                    updateOrderIndicators('#' + this.id);
                });
                    // 각 .spot-container에 대한 Sortable 인스턴스 초기화
                    $('.spot-container .spotListPage').each(function () {
                    var spotListPageId = '#' + this.id;

                    var sortableListInstance = new Sortable($(spotListPageId)[0], {
                        animation: 200,
                        onUpdate: function (event) {
                            console.log('순서가 변경되었습니다.');
                            updateOrderIndicators(spotListPageId);
                        }
                    });
                });
                // 순서 업데이트 함수
                function updateOrderIndicators(spotListPageId) {
                    var orderElements = $(spotListPageId + ' .spotListone');
                    orderElements.each(function (index, element) {
                        var checkOrder = $(element).find('.checkOrder');
                        if (!checkOrder.length) {
                            checkOrder = $('<div class="checkOrder"></div>');
                            $(element).prepend(checkOrder);
                        }
                        checkOrder.text((index + 1) + '순서');
                    });
                }
            });
        });
        </script>
    </body>
</html>