<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href="css/styles.css" rel="stylesheet" />
<style>
a {
	text-decoration: none;
}

.card {
	border: none;
	width: 400px;
}

h3 {
	color: #007BFF; /* 파란색 글자 색상 */
}

#container {
	display: flex;
	align-items: center;
	justify-content: center;
	flex: 1;
	flex-direction: column;
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
</style>
</head>
<body class="d-flex flex-column h-100">
	<div class="container" id="container">
		<div class="card-header">
			<h3 class="text-center w-100 block p-3 fw-normal">Trip Table</h3>
		</div>
		<div class="p-5 py-4 pb-5 border shadow">
			<div class="w-100">

				<div class="card mt-3" id="userLogin">
					<div class="container" style="margin-top: 17px" width="400px">
						<div class="container" style=" height:300px; margin: auto; width: 388px; text-align: center">
							<h3>비밀번호를 입력해주세요</h3>
							<br />
							<br />
							<div class="mb-3 mt-4">
								<div style="display: flex; justify-content: center;">
									<div class="form-group">
											<form action="./join.do" method="POST">
											<input type="password" class="form-control" name="password" id="adminUsermail" placeholder="비밀번호 설정"><br/><br/>											
											<button type="submit" class="btn btn-primary">확인</button>
										</form>

									</div>
								</div>
							</div>
						</div>
					</div>

<!-- 					<div class="card mt-3" id="adminLogin" style="display: none;"> -->
<!-- 						<div class="btn-group w-100" role="group" aria-label="User Type"> -->
<!-- 							<button type="button" class="btn btn-type active userBtn">User</button> -->
<!-- 							<button type="button" class="btn btn-type adminBtn">Admin</button> -->
<!-- 						</div> -->
<!-- 						<div class="card-body"> -->
<!-- 							<form> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="adminUsername">아이디</label> <input type="text" -->
<!-- 										class="form-control" id="adminUsername" -->
<!-- 										placeholder="아이디를 입력해주세요."> -->
<!-- 								</div> -->
<!-- 								<div class="form-group"> -->
<!-- 									<label for="adminPassword">비밀번호</label> <input type="password" -->
<!-- 										class="form-control" id="adminPassword" -->
<!-- 										placeholder="비밀번호를 입력해주세요."> -->
<!-- 								</div> -->
<!-- 								<button type="button" class="btn btn-primary Btn-login"> -->
<!-- 									<a href="./index.html" class="text-white">Log in</a> -->
<!-- 								</button> -->
<!-- 							</form> -->
<!-- 						</div> -->
<!-- 					</div> -->

				</div>
			</div>
		</div>
	</div>

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