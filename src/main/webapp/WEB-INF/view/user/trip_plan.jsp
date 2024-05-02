
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.example.triptable.entity.Team"%>
<%@ page import="com.example.triptable.entity.Region"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import ="com.example.triptable.entity.User" %>
<%@ page import ="org.json.simple.JSONObject" %>


<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();

String teamObject = (String)request.getAttribute("teamObject");

%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta pageable_count="45" />
        <meta content-type: "application/json;" charset="UTF-8" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trip Table</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../img/LogoRaccoon.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
        <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/tripplan.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" /> 
        <style>
            .node {
    position: absolute;
    background-image: url('../img/marker/eggMarker.png');
    cursor: pointer;
    width: 55px;
    height: 35px;
    background-size: contain;
    background-repeat: no-repeat;
}

.tooltip {
    background-color: #fff;
    position: absolute;
    border: 2px solid #333;
    font-size: 25px;
    font-weight: bold;
    padding: 3px 5px 0;
    left: 65px;
    top: 14px;
    border-radius: 5px;
    white-space: nowrap;
    display: none;
}

.tracker {
    position: absolute;
    margin: -35px 0 0 -30px;
    display: none;
    cursor: pointer;
    z-index: 3;
}

.icon {
    position: absolute;
    left: 30px;
    top: 9px;
    width: 40px;
    height: 20px;
    background-image: url('../img/marker/eggMarker.png');
    background-size: contain;
    background-repeat: no-repeat;
}

/* .balloon {
    position: absolute;
    width: 85px;
    height: 65px;
    background-image: url('../img/marker/eggMarker.png');
    -ms-transform-origin: 50% 34px;
    -webkit-transform-origin: 50% 34px;
    transform-origin: 50% 34px;
} */
        </style>
    </head>
    <body id="tripplan" class="d-flex flex-column full-screen react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main" style="max-width: 100%; margin: 0;">
            <div class="flex p-3 w-full h-full relative">
                <div class="flex" style="position: absolute; top: 6px; left: 6px; right: 6px; bottom: 6px;">
                    <div class="flex p-0 flex-fill w-full h-full col overflow-hidden relative">
                        <div id="findPlaces" class="bg-white mh-3 z-3 top-0" style="transition: 0.7s; position: relative !important; min-width: 368px;">
                            <div class="flex flex-col h-full" style="min-width: 350px;">
                                <nav class="flex flex-fill w-full">
                                    <div class="nav nav-tabs flex" id="nav-sideTab" role="tablist" style="flex: 1;">
                                        <button class="nav-link flex-fill active" id="nav-search-tab" data-bs-toggle="tab" data-bs-target="#nav-search" type="button" role="tab" aria-controls="nav-search" aria-selected="true">검색</button>
                                        <button class="nav-link flex-fill" id="nav-invite-tab" data-bs-toggle="tab" data-bs-target="#nav-invite" type="button" role="tab" aria-controls="nav-invite" aria-selected="false">친구초대</button>
                                        <button class="nav-link flex-fill" id="nav-finance-tab" data-bs-toggle="tab" data-bs-target="#nav-finance" type="button" role="tab" aria-controls="nav-finance" aria-selected="false">가계부</button>
                                        <button class="nav-link flex-fill" id="nav-preparation-tab" data-bs-toggle="tab" data-bs-target="#nav-preparation" type="button" role="tab" aria-controls="nav-preparation" aria-selected="false">준비물</button>
                                    </div>
                                    
                                </nav>
                                <div class="tab-content border w-full h-full relative" id="nav-sideTabContent" style="height: calc(100% - 42px); border: none !important;">
                                    <div class="tab-pane fade h-full show active" id="nav-search" role="tabpanel" aria-labelledby="nav-search-tab" tabindex="0">
                                         <!-- 여행지 이름 -->
                                        <div class="flex gap-3 pl-3" style="justify-content: flex-end; width: 90%; margin-top: 10px; margin-bottom: 20px;">
                                            <input type="text" id="team_name"class="fs-6 fw-bold" value="" style="border:none; border-bottom: 1px solid black; width:100%; display: inline-block; vertical-align: middle;" onkeydown="handleEnter(event)">
                                            <button class=" p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded" onclick="focusTextField()">
                                                <i class="bi bi-pencil-fill"></i>
                                            </button>          
                                        </div>
                                            <div id="menu_wrap">
                                            <div class="option pl-3" style="justify-content: flex-end; width: 90%; margin-top: 10px; margin-bottom: 20px;">
                                                <form class="form-inline " onsubmit="initializeMap(); return false;">
                                                    <input id="keyword" for="spot-search" class="form-control mr-sm-3 w-full" style="flex:1" type="search" value="" aria-label="Search" size="15">
                                                    <button class="btn btn-outline-primary my-2 my-sm-0" type="submit" id="spot-search">검색</button>
                                                </form>
                                            </div>
                                            
                                            <div class="flex flex-column align-items-center justify-start w-full relative" style="height: calc(100% - 200px);">
                                                <div id="placesList" class="placesList list-group w-full mx-2" style="overflow-y: auto;"></div>
                                            </div>
                                            <div id="pagination"></div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade h-full" id="nav-invite" role="tabpanel" aria-labelledby="nav-invite-tab" tabindex="0">
                                        <!-- 친구초대 -->
                                        <div id="invite" class="content-section flex-column gap-4">
                                            <!-- 초대링크 -->
                                            <div class="ilink d-flex justify-content-between align-items-center">
                                                <div>
                                                    <input type="hidden" id="team_url" value="">
                                                    <button type="button" class="btn btn-sm" onclick="copyUrl()">
                                                        <p style="margin:0; margin-right: 5px; display: inline-block;">초대링크 복사 </p><i class="bi bi-files"></i>
                                                    </button>
                                                    <i class="bi bi-info-circle" data-bs-toggle="tooltip" data-bs-placement="top" title="링크를 눌러 공유해보세요" style="color: grey;"></i>
                                                </div>
                                                <div class="d-flex gap-2">
                                                    <button type="button" id="memberRefreshBtn" class="btn btn-sm" >
                                                        <i class="bi bi-arrow-clockwise"></i> <p style="margin:0; display: inline-block;">새로고침</p>
                                                    </button>
                                                </div>
                                            </div>
                                            <div id="memberCapacity" class="flex px-3 mr-2" style="justify-content: flex-end; font-size: 20px;">
                                                <i class="bi bi-person-fill"></i>
                                                <i class="bi bi-person"></i>
                                                <i class="bi bi-person"></i>
                                                <i class="bi bi-person"></i>
                                                <i class="bi bi-person"></i>
                                            </div>
                                            <div id="memberTable">           
                                                <!-- 그룹 멤버 현황이 동적으로 추가될 예정 -->
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tab-pane fade h-full" id="nav-finance" role="tabpanel" aria-labelledby="nav-finance-tab" tabindex="0">
                                        <!-- 가계부 -->
                                        <div id="finance" class="content-section flex-column flex-md-row gap-4 align-items-center justify-content-center">
                                            <div class="form-container">
                                                <nav class="flex">
                                                    <div class="nav nav-tabs flex-fill" id="nav-dayfinance" role="tablist"></div>
                                                </nav>
                                            </div>
                                            <div id="soonGif" class="w-full mt-5" style="height: 700px; background-color: #fff; position: absolute; top: 0; left: 0; right: 0; bottom: 0;">
                                                <img src="../img/soon.gif" style="display: block; width: 100%;"  alt="soon">
                                            </div>
                                            <div class="tab-content w-full border" id="nav-financeContent" style="height: calc(100% - 200px); border-top:none; border-top: none !important;">
												<input id="hiddenDay" type="hidden" value="" />
                                            </div>
                                            <div class="w-full border" style="display:flex; ">

												<div>
													<div style="display:flex;">
														<label for="people" class="mb-2" style="width: 90px;">일차별 금액: </label>
	                                                    <div class="flex justify-center items-center mb-2 mr-2"><span id="daytotalAmount" class="badge badge-success">0</span></div>
													</div>
													<div style="display:flex;">
														<label for="people" class="mb-2" style="width: 70px;">총 금액: </label>
                                                    	<div class="flex justify-center items-center mb-2 mr-4"><span id="totalAmount" class="badge badge-success">0</span></div>
													</div>
													<div style="display:flex;">
														<label for="people" class="mb-2" style="width: 70px;">인원:</label>
                                                   		<input type="number" id="team_num" class="form-control mb-2 mr-sm-2" placeholder="1명" min="1" value="1" style="width: 60px; height: 30px;">
													</div>                                                 
  
												</div>
												<div>

													<div class="mb-2">인원별 금액: <span id="dayamountPerPerson" class="badge badge-info">0</span></div>
													<div class="mb-2">인원별 금액: <span id="amountPerPerson" class="badge badge-info">0</span></div>
													<!-- <button type="button" style="width:130px" class="btn btn-primary mr-2" onclick="calculatePerPersonAmount()">계산하기</button> -->
															
												</div>

                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="tab-pane fade relative" id="nav-preparation" role="tabpanel" aria-labelledby="nav-preparation-tab" tabindex="0" style="height: 100%; display:flex !important; justify-content: center !important; align-items: flex-start;">
    									<div class="content-section w-full h-full d-flex flex-column align-items-start ">
                                            <div class="flex flex-col  w-full items-center gap-2 flex-fill">
                                                <div class="list-group w-full mx-2" id="list-container">
                                                    <ul id="addTodo" class="Todolist">
                                                        <li><div id='result'></div></li>
                                                    </ul>
                                                    <!-- 추가 항목은 JavaScript로 추가 -->
                                                    <table class="ft-face-nm" style="display:table; width:100%;">
                                                        <thead style="display:table; width:100%; margin-bottom: 10px;">
                                                            <tr style="text-align:center;display:table; width:100%;">
                                                                <th style="width:20%">체크</th>
                                                                <th style="width:60%">준비물</th>
                                                                <th style="width:20%">삭제</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="todoTableBody" class="overflow-y-auto" style="min-height:500px;display:block;min-width:253px; max-height:650px;">
                                                        
                                                        <!-- 여기에 준비물 항목이 동적으로 추가될 예정입니다. -->
                                                        </tbody>
                                                    </table>
                                                </div>
                                                        									<!-- 항목 추가 기능 -->
                                                <div style="position: absolute; bottom: 0;">
                                                    <button type="button" id="btn" onclick="showTodoInputText()" class="btn btn-primary mb-2 mr-2" style="width: 160px; padding: 5px;">행 추가</button>
                                                    <button type="button" id="btn" onclick="addTodo()" class="btn btn-primary mb-2" style="width: 160px; padding: 5px;">저장</button>
                                                </div>
        									</div>
                                           

                                        </div>
                                    </div>
								</div>
                            </div>
                           
                        </div>
                        <div id="findPlacesSlideBtn" class="h-full border flex justify-center align-items-center mr-2 shadow" style="cursor: pointer; width: 30px; border-top-right-radius: 10px; border-bottom-right-radius: 10px; background-color: #00aef0;">
                            <div class="flex flex-col text-center justify-center" style="color: #fff;">
                                <i class="bi bi-caret-right-fill none"></i>
                                <i class="bi bi-caret-left-fill"></i>
                            </div>
                        </div>
                        <div class="flex h-full" style="flex:1; ">
                            <div class="flex h-full relative justify-center align-items-center" >
                                <div class="relative h-full flex-fill" style="min-width: 560px;">
                                    <nav class="flex">
                                        <div class="nav nav-tabs flex-fill" id="nav-tab" role="tablist">
                                            <button class="nav-link active" id="day1Tab" data-bs-toggle="tab" data-bs-target="#day1" type="button" role="tab" aria-controls="nav-home" aria-selected="true"><span>1</span>일차</button>
                                            <button class="nav-link" id="day2Tab" data-bs-toggle="tab" data-bs-target="#day2" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"><span>2</span>일차</button>
                                            <button class="nav-link" id="day3Tab" data-bs-toggle="tab" data-bs-target="#day3" type="button" role="tab" aria-controls="nav-profile" aria-selected="false"><span>3</span>일차</button>
                                            <button class="nav-link" id="day4Tab" data-bs-toggle="tab" data-bs-target="#day4" type="button" role="tab" aria-controls="nav-contact" aria-selected="false"><span>4</span>일차</button>
                                            <button class="nav-link" id="day5Tab" data-bs-toggle="tab" data-bs-target="#day5" type="button" role="tab" aria-controls="nav-disabled" aria-selected="false"><span>5</span>일차</button>
                                            <div class="flex align-items-center justify-center" style="width: 20px; cursor: pointer;"><i class="bi bi-plus"></i></div>
                                        </div>
                                        
                                        <div class="border p-2 fixed flex align-items-center justify-center" id="confirmBtn" style="background: #E97777; border-radius: 10px; color: #fff; z-index: 10;cursor: pointer; width: 100px;bottom: 15px;  right: 15px; height: 50px; ">계획 완료</div>
                                    </nav>
                                    <div class="tab-content w-full overflow-y-auto" id="nav-tabContent" style="height: calc(100% - 42px); border-top:none; border-top: none !important;">
                                        <div class="tab-pane fade show active" id="day1" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0"></div>
                                        <div class="tab-pane fade" id="day2" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0"></div>
                                        <div class="tab-pane fade" id="day3" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0"></div>
                                        <div class="tab-pane fade" id="day4" role="tabpanel" aria-labelledby="nav-disabled-tab" tabindex="0"></div>
                                        <div class="tab-pane fade" id="day5" role="tabpanel" aria-labelledby="nav-disabled-tab" tabindex="0"></div>
                                    </div>
                                </div>
                                
                            </div>
                            <!-- <div class="resizer z-3" data-direction="vertical"></div> -->
                            <div class="border relative flex flex-fill justify-center align-items-center" style="flex:1">
                                <div id="map" class="h-full w-full relative mt-2"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------------- 카카오 API 설정 -->  

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
                                ${currentMonthHtml}
                            </div>
                            <div>
                                ${nextMonthHtml}
                            </div>
                            <script>

                                function getSelectedMonth() {
                                    return ${selectedMonth};
                                }

                                function getSelectedYear() {
                                    return ${selectedYear};
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
                    <div class="modal-header" style="background-color: #00aef0;">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                                <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                                <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                            </span>
                        </h1>
                        <!-- <button id="modalCloseIcon" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
                    </div>
		            <form>
		                <div class="modal-body text-center">
		                    <h1 class="modal-title">새로운 여행 계획을 생성할까요?</h1>
		                    <br /><br /><br />
                    		<div class="d-flex justify-content-between" style="margin-left: 20%; margin-right: 20%;"> <!-- 좌우 마진을 조정하여 간격을 조절합니다 -->
		                        <button type="button" class="btn btn-secondary" onclick="loadGroupDatas()" style="font-size:20px;">이전 여행 계획 불러오기</button>
		                        <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="createGroup()" style="font-size:20px;">새로운 여행 계획 생성하기</button>
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
		        <div class="modal-content" style="height: 650px; overflow: hidden;">
                    <div class="modal-header" style="background-color: #00aef0;">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">
                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                                <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                                <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                            </span>
                        </h1>
                        <!-- <button id="modalCloseIcon" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
                    </div>
		            <form class="flex flex-col">
		                <div class="modal-body ">
		                    <span class="modal-title" style="font-size:25px;">어떤 여행계획을 불러올까요?</span>
                        </div>
                        <div style="height: 450px; width: 100%; font-size:20px;">
		                    <!-- 그룹 리스트 테이블 -->
		                    <table class="table" style="display: block; width: 100%; height: 100%; overflow: hidden;"> 
                                <thead style="display: table; width: calc(100% - 14px); margin-right: 10px;">
                                    <tr>
                                        <th class="text-center" style="width: 50px;"></th>
                                        <th class="text-center" style="width: 55px; font-size:20px;">번호</th>
                                        <th class="text-center" style="font-size:20px;">그룹이름</th>
                                        <th class="text-center" style="width: 156px; font-size:20px;">여행지역</th>
                                    </tr>
                                </thead>
                                <tbody id="groupTableBody" style="display: block; max-height: 410px; width: 100%; overflow-y: auto;">
                                    <!-- 여기에 그룹 항목이 동적으로 추가될 예정입니다. -->
                                </tbody>
                            </table>
		                </div>
		                <div class="modal-footer">
                            <!-- 추가: 페이지 번호와 페이지 크기를 설정할 수 있는 입력 필드 -->
                            <div id="loadGroupPagination"></div>
                            <!-- 불러오기 버튼 클릭 시, loadGroup 함수에 페이지 번호와 페이지 크기를 전달 -->
		                    <button type="button" class="btn btn-primary" onclick="loadGroup()">불러오기</button>
                		</div>
		            </form>
		        </div>
		    </div>
		</div>
        <!-- Button trigger modal -->
        <button type="button" id="alertBtn" class="btn btn-primary none" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
        </button>

        <div class="modal fade ft-face-kg" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
              <div class="modal-content">
                <div class="modal-header" style="background-color: #00aef0;">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">
                        <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                            <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                            <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                        </span>
                    </h1>
                    <button id="modalCloseIcon" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    여행계획을 불러왔습니다!
                </div>
                <div id="modalFooter" class="modal-footer ft-face-nm">
                  <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
                  <button type="button" class="btn btn-primary " data-bs-dismiss="modal" aria-label="Close" >확인</button>
                </div>
              </div>
            </div>
        </div>
        
<!----------------------- 달력 설정 -->  
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- Core theme JS-->
<script src='//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services'></script>
<script src="../js/Dmap.js"></script>
<script src="../js/calendar.js"></script>
<script src="../js/scripts.js"></script>

<script type="text/javascript">

/******************************************** 친구초대 링크 관련 함수 *****************************************/

/** 초대 링크 복사 **/
function copyUrl() {
   var url = '${domain}/joinGroupform.do/';
   
  // var url = "http://ec2-43-201-114-248.ap-northeast-2.compute.amazonaws.com:8080/joinGroupform.do/xhCTFFrzjbLm065519517545268";
   url += document.getElementById('team_url').value;
    var textarea = document.createElement("textarea");
    document.body.appendChild(textarea);
    textarea.value = url;
    textarea.select();
    document.execCommand("copy");
    document.body.removeChild(textarea);
    // alert("링크가 복사되었습니다.");
    alertBody.text('');
    alertBody.text("링크가 복사되었습니다.")
    alertShowBtn.click();
} 
/***************************************** 친구초대 링크 관련 함수 END ****************************************/



$(document).ready(function() {
//비용을 수정할때마다 formatAmount 함수 호출해서 콤마 표현하기 


$("#nav-tabContent").find(".sortable").sortable({
    revert: true,
    update: function () {
        var sortedItems = $(this).sortable("toArray");
    }
});

var teamObject = '<%=teamObject%>';
if (teamObject === 'null') {
	    
    var selectModal = new bootstrap.Modal(document.getElementById('selectmodal'));
    // 모달 보이기
    selectModal.show();
    searchDosi();
    
}
else {
    teamObject = JSON.parse(teamObject);

    const teamName= teamObject.team_name;
    const teamUrl = teamObject.team_url;
    const teamNum = teamObject.team_userdata.length;
    
    $('#team_name').val(teamName);
    $('#team_url').val(teamUrl); 
    $('#team_num').val(teamNum);
    createDefault();
    searchDosi();
}


$("#nav-tabContent").on("click", ".sortable", function() {
    $(".sortable").sortable({
        revert: true,
        start: function (event, ui) {
            $("#nav-tabContent .info").css("cursor", "grabbing");
        },
        stop: function (event, ui) {
            $("#nav-tabContent .info").css("cursor", "grab");
        },
        update: function () {
            var sortedItems = $(this).sortable("toArray");
            var activeDay = $('#nav-tab .nav-link.active .loadDay').text();
            
            
            $.ajax({
                url: '/user/updateOrder.do',
                type: 'POST',
                data: {
                    spotDay: activeDay,
                    spotId: sortedItems.join(",")  
                },
                success: function(activeDay) {
                    // 성공 시 처리
                    searchDosi();
                },
                error: function() {
                    // 에러 시 처리
                }
            });
        }
    });
});

});              



</script>
    </body>
</html>