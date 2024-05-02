<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.example.triptable.entity.Team"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.triptable.entity.Region"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import ="com.example.triptable.entity.User" %>
<%@ page import ="org.json.simple.JSONObject" %>

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

String teamObject = (String)request.getAttribute("teamObject");
//System.out.println("teamObject : " + teamObject);

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
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/tripplan.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        
    </head>
    <body id="tripplan" class="d-flex flex-column full-screen react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
            <div class="EoVr relative">
                <div class="flex w-full p-2 px-4 gap-3" style="background-color: #00aef0;">
                    <div class="text-center">
                        <div role="button" class="p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">장소 검색</div>
                    </div>
                    <div class="text-center">
                        <div role="button" class="p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">숙소 설정</div>
                    </div>
                    <div id="StepByStep" class="">                        
                    </div>
                    <div class="flex gap-3" style="justify-content: flex-end; flex:auto;">
                        <div class="text-center" style="border-radius: 8px;">
                            <div role="button" onclick="showSection('invite')" class="toggleSpan p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">친구 초대</div>

                        </div>
                        <div class="text-center" style="border-radius: 8px;">
                            <div role="button" onclick="showSection('finance')" class="toggleSpan p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">가계부</div>
                        </div>
                        <div class="text-center" style="border-radius: 8px;">
                            <div role="button" onclick="showSection('preparation')" class="toggleSpan p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">준비물</div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="findPlaces" class="bg-white mh-3 z-3 p-3">
                <!-- 여행지 이름 -->
				<div class="flex gap-3" style="justify-content: flex-end; width: 90%; margin-top: 10px; margin-bottom: 20px;">
					<input type="text" id="team_name"class="fs-6 fw-bold" value="" style="border:none; border-bottom: 1px solid black; width:100%; display: inline-block; vertical-align: middle;" onkeydown="handleEnter(event)">
					<button class=" p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded" onclick="focusTextField()">
						<i class="bi bi-pencil-fill"></i>
					</button>          
				</div>
					<div id="menu_wrap">
                    <div class="option" style="justify-content: flex-end; width: 90%; margin-top: 10px; margin-bottom: 20px;">
                        <form class="form-inline " onsubmit="searchPlaces(); return false;">
                            <input id="keyword" for="spot-search" class="form-control mr-sm-3 w-full" style="flex:1" type="search" value="서울" aria-label="Search" size="15">
                            <button class="btn btn-outline-primary my-2 my-sm-0" type="submit" id="spot-search">검색</button>
                        </form>
                    </div>
                    
                    <div class="flex flex-column align-items-center justify-start w-full relative" style="height: calc(100% - 260px);">
                        <div id="placesList" class="placesList list-group w-full mx-2" style="overflow-y: auto;"></div>
                    </div>
                    <div id="pagination"></div>
                </div>
            </div>
            <div id="findStepPlaces"class="flex h-full block" style="z-index: 11; position: absolute; top: 132px;" >
            </div>
            <!----------------------- 카카오 API 설정 -->  
            <div id="map" class="h-full relative" style="z-index: 10; left: 350px; width: calc(100% - 350px);"></div>
            <div id="mapData" style="width: 170px; z-index: 11; position: fixed; top: 145px; right: 0;">
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
<!----------------------- 카카오 API 설정 -->  
        </main>
<!----------------------- 달력 설정 -->  
        <div class="datepicker" id="CalendarTableara" style="z-index: 50;">
            <div id="datepickerBG" class="fixed top-0 bottom-0 left-0 right-0 z-50 flex items-center justify-center w-screen h-full bg-black bg-opacity-75">
                <div id="datepicker"  class="relative bg-white rounded-none md:rounded-lg shadow md:max-h-[90vh] overflow-y-auto overflow-x-hidden w-full h-full pt-8 p-4 md:p-12 md:w-auto md:h-auto flex flex-col justify-center items-center">
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
                        <button id="CanlenderBtn" class="btn btn-info-light" onclick="saveDay()" style="float:right; margin-right:20px;">선택</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 여행 계획 선택 모달 -->     
		<div class="modal fade" id="selectmodal" tabindex="-1" data-bs-backdrop="false" data-bs-keyboard="false" style="display: none; position: fixed; inset: 0px; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <form>
		                <div class="modal-body text-center">
		                    <h1 class="modal-title">새로운 여행 계획을 생성할까요?</h1>
		                    <br /><br /><br />
                    		<div class="d-flex justify-content-between" style="margin-left: 20%; margin-right: 20%;"> <!-- 좌우 마진을 조정하여 간격을 조절합니다 -->
		                        <button type="button" class="btn btn-secondary" onclick="loadGroupDatas()">이전 여행 계획 불러오기</button>
		                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="createGroup()">새로운 여행 계획 생성하기</button>
		                    </div>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
		<!-- 여행 계획 선택 모달 -->	    
	    
	    <!-- 그룹 선택 모달 -->     
		<div class="modal" id="selectgroup" tabindex="-1" data-bs-backdrop="false" data-bs-keyboard="false" style="display: none; position: fixed; inset: 0px; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7);">
		    <div class="modal-dialog modal-dialog-centered modal-lg">
		        <div class="modal-content">
		            <form>
		                <div class="modal-body text-center">
		                    <h1 class="modal-title">어떤 여행계획을 불러올까요?</h1>
		                    <br /><br /><br />
		                    
		                    <!-- 그룹 리스트 테이블 -->
		                    <table class="table">
                                    <thead>
                                    <tr>
                                        <th class="text-center" style="width: 31px;"></th>
                                        <th class="text-center" style="width: 50px;">번호</th>
                                        <th class="text-center">그룹이름</th>
                                        <th class="text-center" style="width: 100px;">여행지역</th>
                                    </tr>
                                    </thead>
                                    <tbody id="groupTableBody">
                                    <!-- 여기에 그룹 항목이 동적으로 추가될 예정입니다. -->
                                    </tbody>
                                </table>
		                </div>
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-primary" onclick="loadGroup()">불러오기</button>
                		</div>
		            </form>
		        </div>
		    </div>
		</div>
        
        <!-- 친구초대 -->
        <div id="invite" class="content-section flex-column gap-4">
		    <!-- 초대링크 -->
		    <div class="ilink d-flex justify-content-between align-items-center">
		        <div>
		            <input type="hidden" id="team_url" value="">
		            <!-- 
		            <c:set var="team" value="${sessionScope.team}" />
		            <button type="button" class="btn btn-sm" onclick="copyUrl('localhost:8080/joinGroupform.do/${team.url}')">
		                <b>초대링크 복사 </b><i class="bi bi-files"></i>
		            </button>
		            -->
		            <button type="button" class="btn btn-sm" onclick="copyUrl()">
		                <b>초대링크 복사 </b><i class="bi bi-files"></i>
		            </button>
		            <i class="bi bi-info-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="링크를 눌러 공유해보세요" style="color: grey;"></i>
		        </div>
		        <div class="d-flex gap-2">
		            <button type="button" class="btn btn-sm" onclick="loadGroupMember()">
		                <i class="bi bi-arrow-clockwise"></i> <b>새로고침</b>
		            </button>
		        </div>
		    </div>
		    <div id="memberTable">           
		        <!-- 그룹 멤버 현황이 동적으로 추가될 예정 -->
		    </div>
		</div>
        
        <!-- 가계부 -->
        <div id="finance" class="content-section flex-column flex-md-row gap-4 align-items-center justify-content-center">
            <div class="container">

                <!-- 입력 폼 부분 -->
                <div class="form-container">
                    <div class="flex justify-center items-center gap-2">
                        <label for="date" class="none" style="font-size: 0;">일차:</label>
                        <select id="date" class="custom-select mb-2 mr-sm-2" style="width: 110px;">
                            <!-- 일차 정보가 동적으로 추가 될 예정 -->
                        </select>
                        <label for="amount" class="mb-2 mr-sm-2 none" style="font-size: 0;">금액:</label>
                        <input type="text" id="amount" class="form-control mb-2 mr-sm-2" placeholder="금액">
                    </div>
                    <div class="flex justify-center items-center gap-2">
                        <label for="description" class="mb-2 mr-sm-2 none" style="font-size: 0;">내용:</label>
                        <input type="text" id="description" class="form-control mb-2 mr-sm-2" placeholder="비용 내용">
                        <button type="button" onclick="deleteSelected()" class="btn btn-danger mb-2" style="float: right;"><i class="bi bi-dash"></i></button>
                        <button type="button" onclick="addExpense()" class="btn btn-primary mb-2 mr-2" style="float: right;"><i class="bi bi-plus"></i></button>    
                    </div>
                    <!-- 삭제 버튼 -->
                </div>

                <!-- 가계부 테이블 -->
                <table class="table">
                    <!-- <thead>
                    <tr>
                        <th class="text-center" style="width: 31px;"></th>
                        <th class="text-center" style="width: 50px;">일차</th>
                        <th class="text-center">내용</th>
                        <th class="text-center" style="width: 100px;">금액</th>
                    </tr>
                    </thead> -->
                    <tbody id="expenseTableBody">
                    <!-- 여기에 비용 항목이 동적으로 추가될 예정입니다. -->
                    </tbody>
                </table>

                <!-- 총 금액 부분 -->
                <div class="flex gap-2 justify-start items-center">
                    <label for="people" class="mb-2 mr-sm-2" style="width: 40px;">인원:</label>
                    <input type="number" id="people" class="form-control mb-2 mr-sm-2" placeholder="1명" min="1" value="1" style="width: 60px; height: 30px;">
                    <label for="people" class="mb-2 mr-sm-2" style="width: 60px;">총 금액: </label>
                    <div class="flex justify-center items-center mb-2"><span id="totalAmount" class="badge badge-success">0</span></div>
                </div>
                <div class="total flex items-center" style="height: 38px; justify-content: space-between;">
                    <div>인원별 금액: <span id="amountPerPerson" class="badge badge-info">0</span></div>
                    <button type="button" class="btn btn-primary mr-2" style="float: right;" onclick="calculatePerPersonAmount()">계산하기</button>
                </div>
            </div>
        </div>
        
        <!-- 준비물(Check-List) --> 
        <div id="preparation" class="content-section none d-flex flex-column align-items-start justify-content-center" style="margin-right: 10px">
            <div>준비물</div>
            <div class="flex justify-center items-center gap-2">                             
                <input type="text" id="addValue" class="form-control mb-2 mr-sm-2 w-100" placeholder="준비물 추가">
                <button type="button" id="btn" onclick="addTodo()" class="btn btn-primary mb-2 mr-2"><i class="bi bi-plus"></i></button>
            </div>
            <div class="list-group w-full mx-2" id="list-container">
                <ul id="addTodo" class="Todolist"> 
                    <li><div id='result'></div></li>
                </ul>
                <!-- 추가 항목은 JavaScript로 추가 -->
                <table class="table">
                    <tbody id="todoTableBody">
                        <!-- 여기에 준비물 항목이 동적으로 추가될 예정입니다. -->
                    </tbody>
                </table>
            </div>
            <!-- 항목 추가 기능 -->
        </div>
        <!-- 여행지 시간 설정 선택시 MODAL 띄우기 -->
        <div id="spotTimeSetModal" class="">
            <div class="flex gap-2 h-full">
                <div class="setTimeBox h-full" >
                    <div id="spotStartSetTimeContent" class="h-full">
                        <!-- 이 부분에 시간 생성 -->
                    </div>
                </div>
                <div class="setTimeBox h-full">
                    <div id="spotTimeSetContent" class="h-full">
                        <!-- 이 부분에 박스 생성 -->
                    </div>
                </div>
                <div class="flex flex-col" style="flex: 0.1">
                    <button type="button" id="spotTimeSetDelete">취소</button>
                    <button type="button" id="spotTimeSetInsert" onclick="checkTimeIntervals()">확인</button>
                    <!-- <button onclick="addTimeBox()">Add Box</button> -->
                </div>
            </div>
        </div>

        <!-- 여행지 상세 설정 버튼 클릭시 MODAL 띄우기 -->
        <div id="spotSetModal" class="">
            <div class="flex gap-2 h-full">
                <div class="setTimeBox h-full" >
                    <div id="spotStartSetTimeContent" class="h-full">
                        <!-- 이 부분에 시간 생성 -->
                    </div>
                    <div id="spotTimeSetContent" class="h-full">
                        <!-- 이 부분에 박스 생성 -->
                    </div>
                </div>
                <div class="flex flex-col" style="flex: 0.1">
                    <button type="button" id="spotTimeSetDelete">취소</button>
                    <button type="button" id="spotTimeSetInsert" onclick="checkTimeIntervals()">확인</button>
                    <!-- <button onclick="addTimeBox()">Add Box</button> -->
                </div>
            </div>
        </div>
    


<!----------------------- 달력 설정 -->  
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.14.0/Sortable.min.js"></script>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src='//dapi.kakao.com/v2/maps/sdk.js?appkey=61d0c0883a09f0cac4e91b6dee183a31&libraries=services'></script>
<script src="../js/map.js"></script>
<script src="../js/scripts.js"></script>
<script src="../js/calendar.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    
var teamObject = '<%=teamObject%>';
//console.log(teamObject);
if (teamObject === 'null') {
    
    var selectModal = new bootstrap.Modal(document.getElementById('selectmodal'));
    // 모달 보이기
    selectModal.show();
    
}
else {
    teamObject = JSON.parse(teamObject);

    const teamName= teamObject.team_name;
    const teamUrl = teamObject.team_url;
    
    $('#team_name').val(teamName);
    $('#team_url').val(teamUrl);    
    
    createDefault();
    //console.log('dk');
}

});
                

</script>
    </body>
</html>