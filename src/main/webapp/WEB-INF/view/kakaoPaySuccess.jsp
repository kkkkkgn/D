<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.example.triptable.entity.User" %>

<%
	User user = (User)session.getAttribute("user");
	String user_name = user.getName();
%>

<!-- 회원가입 완료 페이지 - 손수빈 -->
<!-- 완료 페이지 이후 로그인된 main페이지로 이동하게 된다. -->
<!DOCTYPE html>
<html lang="ko" xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Trip Table</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="../img/LogoRaccoon.png" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
     <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
<style>
a {
	text-decoration: none;
}

.card {
	border: none;
	width: 400px;
}

h5 {
   
}
h2{
	 color: #007BFF; /* 파란색 글자 색상 */
}

#container {
	display: flex;
	align-items: center;
	justify-content: center;
	flex: 1;
	flex-direction: column;
	margin-top: -90px; /* 위로 올리고 싶은 만큼의 음수 값 설정 */
}

.form-group:nth-of-type(2) {
	margin-top: 10px;
}

.Btn-login {
	margin-top: 30px;
	width: 100%;
	height: 55px;
}

.btn-group {
	padding: 16px;
}

.btn-type {
	border-radius: 0;
	border: 1px solid rgba(0, 0, 0, 0.3);
	opacity: 0.5;
}

.btn-type.active {
	opacity: 1;
	border-top: 2px solid blue;
	border-bottom: 0;
	border-left: 1px solid rgba(0, 0, 0, 0.3);
	border-right: 1px solid rgba(0, 0, 0, 0.3);
}

.text-center {
    text-align: center; /* 텍스트 가운데 정렬 */
}

hr {
    border: 1px solid #888; /* 선의 색상과 굵기 설정 */
    margin: 20px auto; /* 여백 설정 */
    width: 70%; /* 가로 길이 설정 */
}

.btn-primary {
    width: 150px; /* 원하는 가로 길이 */
}

</style>
<script>

window.onload = function() {
    // 페이지 이동 이벤트 등록
    window.addEventListener('beforeunload', function(event) {
        // 현재 URL 가져오기
        var currentUrl = window.location.href;

        // 파라미터 제거
        var urlWithoutParams = removeUrlParameters(currentUrl);

        // 새로운 URL로 이동
        window.location.href = urlWithoutParams;
    });
};

// URL의 파라미터 제거 함수
function removeUrlParameters(url) {
    var urlParts = url.split('?');
    if (urlParts.length > 1) {
        return urlParts[0]; // 파라미터가 있는 경우 파라미터를 제거
    } else {
        return url; // 파라미터가 없는 경우 그대로 반환
    }
}
</script>

</head>
	<body class="d-flex flex-column h-100">
      <!-- Navigation-->
      <div id="nav-container">
    <nav class="navbar navbar-expand-lg navbar-write bg-write">
        <div class="container" style="display: flex; align-items: center;">
			<span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
				<img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
				<img src="../img/Logo2.png" alt="로고" style="height: 18px; display: inline-block;" />
			</span>
        </div>
    </nav>
</div>

       <!-- Navigation 끝 -->
	<div class="container" id="container">
		<div class="text-center">
			<h2 style="font-weight: bold;">결제가 정상적으로 완료 되었습니다.</h2>
			<br />
			결제 날짜 	:    [${formattedDate}]<br/>
			예약 번호	:    [${info.partner_order_id}]<br/>
			숙소 이름 	:    [${info.item_name}]<br/>
			체크 인 :		[${reservation.resstart}]<br/>
			체크 아웃 : 	[${reservation.resend}]<br/>
			결제 금액	:    [${info.amount.total}]<br/>
			<br/><br/>
			
			<h6>저희 Trip Table을 사용해 주셔서 감사합니다.</h6>
			<h6>자세한 결제 내역은 마이페이지에서 보실 수 있습니다.</h6>
		</div>
		<hr />
		<p style=" color: gray;  font-style: italic; font-size: 10px">체크인 시간 이후에는 환불이 어려우니 유의 바랍니다.</p>
        <div class="row">
		    <div class="col-md-6">
		        <button type="button" class="btn btn-primary" style="width: 90px" onclick="location.href='/user/acc_reservation.do'">추가 예약</button>
		    </div>
		    <div class="col-md-6">
		        <button type="button" class="btn btn-secondary" onclick="location.href='/index.do'">홈으로</button>
		    </div>
		</div>	
	</div>
	
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
	<!-- Bootstrap core JS-->
	<!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
	<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

	<!-- Core theme JS-->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"
		integrity="sha384-oR2wazi8sOb8b2ZUpSZlG60SQIDevzvsy3WlA+cxsn5BE5lssNHDN9oAWD+1bz1g"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
</body>
</html>