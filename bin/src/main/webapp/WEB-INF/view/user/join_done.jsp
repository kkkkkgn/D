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
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Trip Table</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
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
</head>
	<body class="d-flex flex-column h-100">
      <!-- Navigation-->
      <div id="nav-container">
    <nav class="navbar navbar-expand-lg navbar-write bg-write">
        <div class="container" style="display: flex; align-items: center;">
            <a class="navbar-brand text-primary" href="index.do" style="font-family: 'Anja'; font-size: 40px; text-shadow: 5px 1px 4px rgba(0,0,0,0.2);">Trip Table</a>
            <sub style="font-size: 17px; margin-right: 1020px;">회원가입</sub>
        </div>
    </nav>
</div>

       <!-- Navigation 끝 -->
	<div class="container" id="container">
		<div class="text-center">
			<h2 style="font-weight: bold;">회원가입 완료</h2>
			<br />
			<h5><%=user.getName() %>님의 회원가입이</h5>
			<h5>성공적으로 완료되었습니다.</h5>
			<br/><br/>
			
			<h6>이제 Trip Table의 다양한 서비스를 만나보세요.</h6>
		</div>
		<hr />
		<div class="form-group">
			<a href="./index.do"><button type="button" class="btn btn-primary btn-lg">확인</button></a>
		</div>
<!-- 		<div class="p-5 py-4 pb-5 border shadow"> -->
<!-- 			<div class="w-100"> -->

<!-- 				<div class="card mt-3" id="userLogin"> -->
<!-- 					<div class="container" style="margin-top: 17px" width="400px"> -->
<!-- 						<div class="container" style=" height:300px; margin: auto; width: 388px; text-align: center"> -->
<!-- 							<h3>비밀번호를 입력해주세요</h3> -->
<!-- 							<br /> -->
<!-- 							<br /> -->
<!-- 							<div class="mb-3 mt-4"> -->
<!-- 								<div style="display: flex; justify-content: center;"> -->
<!-- 									<div class="form-group"> -->
<!-- 											<form action="./join.do" method="POST"> -->
<!-- 											<input type="password" class="form-control" name="password" id="adminUsermail" placeholder="비밀번호 설정"><br/><br/>											 -->
<!-- 											<button type="submit" class="btn btn-primary">확인</button> -->
<!-- 										</form> -->

<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->

<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
	
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