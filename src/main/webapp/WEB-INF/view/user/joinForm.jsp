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
<script>
	function validatePassword() {
		var password = document.getElementById('password').value;
		var checkpassword = document.getElementById('checkpassword').value;
		const regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
		
		if(password.length<8 || password.length>15) {
			alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
			return false;
		}
		
		if(!regex.test(password)) {
			alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
			return false;
		}
		
		if(password !== checkpassword) {
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}
		
		join.submit();
	}
</script>
</head>
<body class="d-flex flex-column h-100">
	<div class="container" id="container">
		<div class="card-header mb-4">
          <a href="/index.do">
            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
              <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
              <img src="../img/Logo2.png" alt="로고" style="height: 32px; display: inline-block;" />
            </span>
          </a>
      </div>
		<div class="p-5 py-4 pb-5 border shadow">
			<div class="w-100">

				<div class="card mt-3" id="userLogin">
					<div class="container" style="margin-top: 17px" width="400px">
						<div class="container" style=" height:300px; margin: auto; width: 388px; text-align: center">
							<h3>비밀번호를 입력해주세요</h3>
							<br />
							<div class="mb-3 mt-4">
								<div style="display: flex; justify-content: center;">
									<div class="form-group">
										<form action="/user/join.do" name="join" method="POST">
											
											<input type="password" class="form-control" name="password" id="password" placeholder="비밀번호 설정">
											<br/>
											<input type="password" class="form-control" name="checkpassword" id="checkpassword" placeholder="비밀번호 확인">
											<sub>영어, 숫자, 특수문자가 포함된 8~15자리</sub><br/><br/>
																						
											<button type="button" class="btn btn-primary" onclick="return validatePassword()">확인</button>
										</form>

									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JS-->
	<!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

	<!-- Core theme JS-->
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"
		integrity="sha384-oR2wazi8sOb8b2ZUpSZlG60SQIDevzvsy3WlA+cxsn5BE5lssNHDN9oAWD+1bz1g"
		crossorigin="anonymous"></script>
	<script src="../js/scripts.js"></script>
</body>
</html>