<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.example.triptable.entity.User" %>
<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();


%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        <style>
         
            .res-img {
                max-height: 150px;
                max-width: 150px;
            }

            #res-status td {
                font-weight: 700;
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
            
        </style>
        <script type="text/javascript">
        
	        function cancelRequest(resId) {
	        	//alert(resId);
	        	var inputString = prompt('예약 번호를 입력해주세요.', '예약 취소는 승인 후 처리됩니다.');
	        		        	
	        	if(inputString == null || inputString.trim() == '예약 취소는 승인 후 처리됩니다.') {
	        		return;
	        	} else {

		        	const form = document.getElementById('cancelRequest_' + resId);
		            // 새로운 입력 엘리먼트 생성
		           	const newInput = document.createElement('input');
		            
		           	var existingInput = form.querySelector('input[name="orderNumber"]');
		            // 이미 존재하는 경우 제거
		            if (existingInput) {
		                existingInput.parentNode.removeChild(existingInput);
		            }
		            
		            newInput.type = 'hidden';
		            newInput.name = 'orderNumber';
		            newInput.value = inputString;
		            
		            form.appendChild(newInput);
		            form.submit();
	        	}
	        	
	        }
	            
	        function getDayOfWeek(dayIndex) {
	            var days = ['일', '월', '화', '수', '목', '금', '토'];
	            return days[dayIndex];
	        }
	        
        	function filterReservations() {
        		 // 선택한 상태 가져오기
                var selectedStatus = $("#status-select").val();

                $.ajax({
                    type: "POST",
                    url: "/user/filterReservations.do", // 서버에서 필터링 로직을 처리할 엔드포인트 지정
                    data: { status: selectedStatus },
                    success: function (data) {
                        // 성공적으로 받은 데이터를 사용하여 페이지 업데이트
                        
                        if (data =='') {
                        	// alert('내역이 없습니다.');
							alertBody.text('');
							alertBody.text('내역이 없습니다.');
							alertShowBtn.click();
							$("#status-select").val("ALL");
                        } else {

                        	let result = '';
                        	
                        	let reservations = JSON.parse(data);
                        	
                        	const tbody = document.querySelector("#res-status tbody");

                        	// tbody를 비웁니다.
                        	tbody.innerHTML = '';

                        	for (let res of reservations) {
                        		var dateObject = new Date(res.date);
                        		
                        		var formattedDate = dateObject.getFullYear() + '. ' + (dateObject.getMonth() + 1) + '. ' + dateObject.getDate() +
                        	    ' (' + getDayOfWeek(dateObject.getDay()) + ') ' + dateObject.getHours() + ':' + dateObject.getMinutes();
                        		
                        		const listItem = document.createElement('tr');

                        		if(res.accImg == '') {
									res.accImg = 'https://www.shillastay.com/images/upload/spofrpack/231228/FILEee40455cdf1585bd.jpg';
								}
								listItem.innerHTML =
								    '<td><img class="res-img" src="' + res.accImg + '"></td>' +
								    '<td>' + res.ordernumber + '</td>';

								// 추가된 if 문
								if (res.refundstatus === 'BEFORE_USE') {
								    listItem.innerHTML += '<td><span class="badge rounded-pill bg-primary">이용 전</span></td>';
								} else if (res.refundstatus === 'AFTER_USE') {
								    listItem.innerHTML += '<td><span class="badge rounded-pill bg-warning" style="background-color: var(--bs-#b306ff ) !important">이용 완료</span></td>';
								} else if (res.refundstatus === 'CANCELING') {
								    listItem.innerHTML += '<td><span class="badge rounded-pill bg-warning" style="background-color: var(--bs-yellow) !important">취소 중</span></td>';
								} else {
								    listItem.innerHTML += '<td><span class="badge rounded-pill bg-default" style="background-color: var(--bs-gray) !important">취소 됨</span></td>';
								}

								listItem.innerHTML +=
								    '<td>' + res.accName + '</td>' +
								    '<td>' + res.guests + '</td>' +
								    '<td>' + res.resstart + ' - ' + res.resend + '</td>' +
								    '<td>' + res.fee + '</td>' +
								    '<td>' + formattedDate + '</td>';
								if (res.refundstatus === 'BEFORE_USE') {
									listItem.innerHTML +=
										'<td>' +
										'<form id="cancelRequest_' + res.id + '" action="/user/cancelRequest.do" method="get">' +
									    '<input type="hidden" name="resid" value="' + res.id + '"/>' +
									    '<button type="button" class="btn btn-primary" onclick="cancelRequest(' + res.id + ')">' +
									    '취소' +
									    '</button>' +
									    '</form>' +
									    '</td>';
								} else {
									listItem.innerHTML +=
										'<td>' +
									    '<button type="button" class="btn btn-secondary">' +
									    '취소' +
									    '</button>' +
									    '</td>';
								}

								tbody.append(listItem);
                        	}
                        	
                        	
                        }
                    },
                    error: function () {
                        alert("서버 오류 발생");
                    }
                });
        	}
        	
        </script>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
      <%@ include file="./header.jsp" %>  
      <main class="flex-shrink-0" id="main" style="width: 1400px; margin: auto;">
          <div class="" id="navbar-line"></div>

  <!-- ======= Blog Section ======= -->

    <div class="container" data-aos="fade-up">

        <div class="select-container mb-3" style="margin-top: 10px;">
            <div class="col-sm-5" style="display: flex;">
              <select class="form-select mx-3" id="status-select" aria-label="Default select example" onchange="filterReservations()">
              	 <!-- BEFORE_USE, // 이용 전
    				AFTER_USE, // 이용 후
    				CANCELING, // 취소 진행중 
    				CANCELED; // 취소 됨 -->
                <option value="ALL" selected>전체 이용상태</option>
                <option value="BEFORE_USE">이용 전</option>
                <option value="AFTER_USE">이용 후</option>
                <option value="CANCELING">취소 중</option>
                <option value="CANCELED">취소 됨</option>
              </select>
            </div>    
              
          </div>
             
          <table class="table" id="res-status">
            <thead>
              <tr>
                <th></th>
                <th>예약번호</th>
                <th>이용상태</th>
                <th>숙소이름</th>
                <th style="width: 65px;">인원수</th>
                <th style="width: 160px;">체크인- 체크아웃</th>
                <th style="width: 80px;">판매금액</th>
                <th style="width: 100px">예약날짜</th>
                <th style="width: 80px;">예약취소</th>
              </tr>
            </thead>
            <tbody>
            <c:if test="${not empty reservation}">
	            <c:forEach var="reservation" items="${reservation}">
		            <tr>
		                <td>
		                	 <c:choose>
			                    <c:when test="${not empty reservation.accommodation and not empty reservation.accommodation.getImage()}">
			                        <img class="res-img" src="${reservation.accommodation.getImage()}">
			                    </c:when>
			                    <c:otherwise>
			                        <!-- Handle the case when the image is empty or null -->
			                        <img class="res-img" src="https://www.shillastay.com/images/upload/spofrpack/231228/FILEee40455cdf1585bd.jpg">
			                        <!-- You can use any default image path or display a message -->
			                    </c:otherwise>
			                </c:choose>
		                </td>
		                <td>${reservation.orderNumber}</td>
		                <c:choose>
			                <c:when test="${reservation.refundStatus eq 'BEFORE_USE'}">
			                	<td><span class="badge rounded-pill bg-primary">이용 전</span></td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'AFTER_USE'}">
			                	<td><span class="badge rounded-pill bg-primary" style="background-color: var(--bs-#b306ff ) !important">이용 완료</span></td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'CANCELING'}">
			                	<td><span class="badge rounded-pill bg-primary"  style="background-color: var(--bs-yellow) !important">취소 중</span></td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'CANCELED'}">
			                	<td><span class="badge rounded-pill bg-primary" style="background-color: var(--bs-gray) !important">취소 됨</span></td>        
				            </c:when>
				        </c:choose>
		                <td>${reservation.accommodation.getName()}</td>
		                <td>${reservation.guests} 명</td>
		                <td>${reservation.resstart}
		                <br/>
		                 -
		                 <br/> 
		                 ${reservation.resend}</td>
		                <td>${reservation.fee}</td>
		                <td><fmt:formatDate value="${reservation.date}" pattern="yyyy. M. d. (E) HH:mm" /></td>
		                
		                <c:choose>
			                <c:when test="${reservation.refundStatus eq 'BEFORE_USE'}">
					            <td>
				                	<form id="cancelRequest_${reservation.id}" action="/user/cancelRequest.do" method="get">
										<input type="hidden" name="resid" value="${reservation.id}"/>
										<button type="button" class="btn btn-primary" onclick="cancelRequest(${reservation.id})">
									      취소
									  	</button>
									</form>
				                </td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'AFTER_USE'}">
				            	<td>
				                	<button type="button" class="btn btn-secondary">
									      취소
									</button>
								</td>     
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'CANCELING'}">
			                	<td>
									<button type="button" class="btn btn-secondary">
								      취소
								  	</button>
				                </td>        
				            </c:when>
				            <c:when test="${reservation.refundStatus eq 'CANCELED'}">
			                	<td>
				                	<button type="button" class="btn btn-secondary">
								      취소
								  	</button>
				                </td>        
				            </c:when>
				        </c:choose>
	              	</tr>
	            </c:forEach>
		    </c:if>
            </tbody>
          </table>
          <!-- End Table with stripped rows -->

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
        <!-- Bootstrap core JS-->
        <!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>
