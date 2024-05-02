<%@page import="com.example.triptable.entity.Manager"%>
<%@page import="java.time.LocalDate" %>
<%@page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Manager manager = (Manager)session.getAttribute("manager");
  	String managerRole = manager.getManagerRole().getRolename().replace("ROLE_", "") + " MANAGER";  
  	String managerName = manager.getName();
  
  	// 시간별 로그인 현황
  	List<Integer> timeList = (List<Integer>)request.getAttribute("timeList");
  	LocalDate today = LocalDate.now();
	String strToday = today.toString();
	
	String data = "[";
	
	for(int i=0; i<timeList.size()-1; i++){
		data += timeList.get(i) + ",";
	}
	data += timeList.get(22) + "]";
	
	// 일자별 로그인 현황
	int todayTotal = (Integer)request.getAttribute("todayTotal");
	
	// 소셜로그인 경로별 회원 수
	int kakao = (Integer)request.getAttribute("kakao");
	int google = (Integer)request.getAttribute("google");

	// 많이 가는 여행 지역 순위
	List<Object[]> destRank = (List<Object[]>)request.getAttribute("destRank");
	
	String strDestRank = "";
	for(int i=0; i<destRank.size(); i++){
		Object[] dest = destRank.get(i);
		strDestRank += "<tr><th scope='row'><a href='#'>" + (i+1) + "</a></th><td>" 
		+ dest[0] + "</td><td><a href='#' class='text-primary'>" + dest[1] + "</a></td><td>"
		+ dest[2] + "</td><td>" + (dest[3] != null ? dest[3] : "0" )+ "</td></tr>";
	}

	// 추천 코스 조회수 랭킹
	List<Object[]> courseRank = (List<Object[]>)request.getAttribute("courseRank");
	
	String strCouseRank = "";
	for(int i=0; i<courseRank.size(); i++){
		Object[] course = courseRank.get(i);
		strCouseRank += "<tr><th scope='row'><a href='#'>" + (i+1) + "</a></th><td>" 
				+ course[0] + "</td><td><a href='#' class='text-primary'>" + course[1] + "</a></td><td>"
				+ course[2] + "</td><td><span class='badge bg-success'>" + (course[3] != null ? course[3].toString() : "정보 없음") + "</span></td></tr>";
	}
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="../assets/img/favicon.png" rel="icon">
  <link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="../assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="../assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="../assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="../assets/css/style.css" rel="stylesheet">
  <link href="../css/managerFont.css" rel="stylesheet" />

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
<%@ include file='mheader.jsp'%>
  <!-- ======= Main ======= -->
  <main id="main" class="main">
    <div class="pagetitle">
      <h1>Dashboard</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/manager/dashboard.do">Home</a></li>
          <li class="breadcrumb-item active">Dashboard</li>
        </ol>
      </nav>
    </div><!-- 타이틀 끝 -->

    <section class="section dashboard">
      <div class="row">

        <div>
          <div class="row">

            <!-- 일자별 로그인 수 -->
            <div class="col-12" style="display: flex;">

              <div class="card info-card customers-card" style="margin-right:30px;">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" onclick="selectDayTotal('today')">오늘</a></li>
                    <li><a class="dropdown-item" onclick="selectDayTotal('yesterday')">1일 전</a></li>
                    <li><a class="dropdown-item" onclick="selectDayTotal('twoDaysAgo')">2일 전</a></li>
                  </ul>
                </div>

                <div class="card-body" style="width:400px">
                  <h5 class="card-title">일자별 로그인 현황 <span id="daySpan">| <%=strToday %></span></h5>
				<div style="top: 20%; position: relative; left: 15%;">
				    <div style="display: flex; align-items: center;">
				        <div class="card-icon rounded-circle d-flex align-items-center justify-content-center" style="width:130px; height:130px">
				            <i class="bi bi-people" style="font-size:87px"></i>
				        </div>
				        <div class="ps-3">
				            <h6 id="dayTotal"><%=todayTotal %></h6>
				            <!-- 추가적인 내용 -->
				        </div>
				    </div>
				    <!-- 추가적인 내용 -->
				</div>

                </div>
              </div>
              
              <!-- 소셜로그인 회원 수 -->
          <div class="card">
            <div class="filter">
            </div>

            <div class="card-body pb-0" style="width:400px; height:400px">
              <h5 class="card-title" style="margin-bottom:30px;">소셜로그인 경로별 가입자 수</h5>

              <div id="trafficChart" style="min-height: 300px;" class="echart"></div>

              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  echarts.init(document.querySelector("#trafficChart")).setOption({
                    tooltip: {
                      trigger: 'item'
                    },
                    legend: {
                      top: '5%',
                      left: 'center'
                    },
                    series: [{
                      name: '소셜 로그인 회원 현황',
                      type: 'pie',
                      radius: ['40%', '70%'],
                      avoidLabelOverlap: false,
                      label: {
                        show: false,
                        position: 'center'
                      },
                      emphasis: {
                        label: {
                          show: true,
                          fontSize: '18',
                          fontWeight: 'bold'
                        }
                      },
                      labelLine: {
                        show: false
                      },
                      data: [{
                    	  value: <%=google%>,
                          name: 'Google',
                          itemStyle: {
                        	  color : '#4286f4'
                          }
                        },
                        {
                          
                          value: <%=kakao%>,
                          name: 'Kakao',
                          itemStyle: {
                        	  color : '#F7E600'
                          }
                        }]
                    }]
                  });
                });
              </script>

            </div>
          </div><!-- 소셜로그인 회원 수 -->

            </div><!-- 일자별 로그인 수 -->

            <!-- 시간별 로그인 현황 -->
            <div class="col-12">
              <div class="card">

                <div class="filter" style="display:flex;">
                	<!-- 엑셀파일 다운로드 -->
                	<form action="/manager/loginExcelDownload.do" method="POST" style="margin-right:30px;">
	                  	<input id="dayHidden" type="hidden" value="today" name="day"/>
	                  	<button type="submit" class="btn btn-outline-success"><img src="../img/excel.png" width="20px;"> 엑셀 다운로드</button>
                  	</form>
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" onclick="selectDayTime('today')">오늘</a></li>
                    <li><a class="dropdown-item" onclick="selectDayTime('yesterday')">1일 전</a></li>
                    <li><a class="dropdown-item" onclick="selectDayTime('twoDaysAgo')">2일 전</a></li>
                  </ul>
                </div>

                <div class="card-body">
                  <h5 class="card-title">시간별 로그인 현황<span id="timeDaySpan"> | <%=strToday %></span></h5>
				</div>
                  <!-- Line Chart 하루동안의 사용자 접속 수 확인 -->
                  <div id="reportsChart">
                  </div>
                  <!-- End Line Chart -->

                </div>

              </div>
            </div><!-- 시간별 로그인 현황 -->
            

            <!-- 여행 지역 순위 -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">
				 <div class="filter" style="display:flex;">
					<!-- 엑셀파일 다운로드 -->
                	<form action="/manager/DestExcelDownload.do" method="POST" style="margin-right:30px;">
	                  	<button type="submit" class="btn btn-outline-success"><img src="../img/excel.png" width="20px;"> 엑셀 다운로드</button>
                  	</form>
                </div>
                <div class="card-body">
                  <h5 class="card-title">많이 가는 여행지역 순위</h5>

                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">순위</th>
                        <th scope="col">여행지역</th>
                        <th scope="col">여행계획 수</th>
                        <th scope="col">해당 지역에 등록되어 있는 숙소 개수</th>
                        <th scope="col">해당 지역에 등록되어 있는 코스 개수</th>
                      </tr>
                    </thead>
                    <tbody>
							<%=strDestRank %>
                    </tbody>
                  </table>

                </div>

              </div>
            </div><!-- End Recent Sales -->
            
            <!-- 추천코스 랭킹 -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">
				 <div class="filter" style="display:flex;">
				 	<!-- 엑셀파일 다운로드 -->
                	<form action="/manager/courseExcelDownload.do" method="POST" style="margin-right:30px;">
	                  	<button type="submit" class="btn btn-outline-success"><img src="../img/excel.png" width="20px;"> 엑셀 다운로드</button>
                  	</form>
                </div>
                <div class="card-body">
                  <h5 class="card-title">추천 코스 조회수 랭킹</h5>

                  <table class="table table-borderless datatable">
                    <thead>
                      <tr>
                        <th scope="col">순위</th>
                        <th scope="col">추천코스 이름</th>
                        <th scope="col">추천코스 지역</th>
                        <th scope="col">추천코스 조회수</th>
                        <th scope="col">코스 소요시간</th>
                      </tr>
                    </thead>
                    <tbody>
					<%=strCouseRank %>
                    </tbody>
                  </table>

                </div>

              </div>
            </div><!-- 추천코스 랭킹 -->

 

          </div>
        </div><!-- 차트 div 끝 -->


      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>TripTable</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
<!--       All the links in the footer should remain intact. -->
<!--       You can delete the links only if you purchased the pro version. -->
<!--       Licensing information: https://bootstrapmade.com/license/ -->
<!--       Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
<!--       Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
	<script src="../assets/vendor/apexcharts/apexcharts.min.js"></script>
	<script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="../assets/vendor/chart.js/chart.umd.js"></script>
	<script src="../assets/vendor/echarts/echarts.min.js"></script>
	<script src="../assets/vendor/quill/quill.min.js"></script>
	<script src="../assets/vendor/simple-datatables/simple-datatables.js"></script>
	<script src="../assets/vendor/tinymce/tinymce.min.js"></script>
	<script src="../assets/vendor/php-email-form/validate.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

  <!-- Template Main JS File -->
  <script src="../assets/js/main.js"></script>
	<script type="text/javascript">
		chart = new ApexCharts(document.querySelector("#reportsChart"), {
             	// ApexCharts에서 사용하는 시리즈 데이터
                 series: [{
                   name: '로그인한 회원 수',
                      data: <%=data%>
                 }],
               	// 차트의 기본 설정 지정
                 chart: {
                   height: 350,
                   type: 'area',
                   toolbar: {
                     show: false
                   },
                 },
                 // 마커의 크기를 지정
                 markers: {
                   size: 5
                 },
                 // 차트에서 사용되는 색상을 배열로 지정
                 colors: ['#ff771d'],
                 // 차트의 영역을 그라데이션 형태로 채우기 위한 설정을 지정, 그라데이션의 색, 투명도, 그라데이션 정지점 등을 설정
                 fill: {
                   type: "gradient",
                   gradient: {
                     shadeIntensity: 1,
                     opacityFrom: 0.3,
                     opacityTo: 0.4,
                     stops: [0, 90, 100]
                   }
                 },
                 // 데이터 라벨을 설정
                 dataLabels: {
                   enabled: false
                 },
                 // 차트의 선에 대한 설정을 지정
                 stroke: {
                   curve: 'straight',
                   width: 2
                 },
                 // x축의 설정을 지정, 날짜 및 시간 데이터를 표시하기 위해 datetime 유형을 선택하고, 각 데이터 포인트에 해당하는 카테고리(날짜 및 시간)를 배열로 설정
                 xaxis: {
                   type: 'time',
                   categories: [
                	    "12 AM", 
                	    "1 AM", 
                	    "2 AM", 
                	    "3 AM", 
                	    "4 AM", 
                	    "5 AM", 
                	    "6 AM", 
                	    "7 AM", 
                	    "8 AM", 
                	    "9 AM", 
                	    "10 AM",
                	    "11 AM", 
                	    "12 PM", 
                	    "1 PM", 
                	    "2 PM", 
                	    "3 PM", 
                	    "4 PM", 
                	    "5 PM", 
                	    "6 PM",
                	    "7 PM",
                	    "8 PM",
                	    "9 PM",
                	    "10 PM",
                	    "11 PM"
                	]
                 },
                 // 차트에서 마우스를 올렸을 때 표시되는 툴팁의 형식을 설정
                 tooltip: {
                   x: {
                     format: 'yy/MM/dd HH:mm'
                   },
                 }
               })
		chart.render();
	
	// 시간별 로그인 현황 그래프를 동적으로 업데이트
	function selectDayTime(day){

		$.ajax({
			url : '/manager/select_day_time.do',
			type : 'POST',
			data : {
				day : day
			},
			success : function(timeArray){
				var timeArray = JSON.parse(timeArray);
				var date = timeArray[0];
				var timeList = timeArray[1];
				
				$('#timeDaySpan').html(" | "+date);
				
				chart.updateSeries([{
			        data: timeList
			    }]);
				
				// 일자 별 로그인현황 엑셀 다운로드를 위한 정보
 				$('#dayHidden').val(day);
				
			},
			error : function(error){
				
			}
		});
	}
	
	// 일자별 로그인 현황을 동적으로 업데이트
	function selectDayTotal(day){
		$.ajax({
			url : '/manager/select_day_total.do',
			type : 'POST',
			data : {
				day : day
			},
			success : function(totalObject){
				var totalObject = JSON.parse(totalObject);
				var date = totalObject.date;
				var loginUserNum = totalObject.loginUserNum;

 				$('#daySpan').html(" | " + date);
 				$('#dayTotal').html(loginUserNum);
				
			},
			error : function(error){
				
			}
		
		});
	}
	
	</script>
	
</body>

</html>