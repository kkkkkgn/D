<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
      <meta name="description" content="" />
      <meta name="author" content="" />
      <title>Trip Table Login</title>
      <!-- Favicon-->
      <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
      <!-- Bootstrap icons-->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

      <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
      <style>
        a {
          text-decoration: none;
        }
        .card {
          border:none;
          width: 400px;
        }

        h3 {
          color: #007BFF; /* 파란색 글자 색상 */
        }
        #container {
          display: flex;
          align-items: center;
          justify-content: center;
          flex:1;
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
          border: 1px solid rgba(0,0,0,0.3);
          opacity: 0.5;
        }
        .btn-type.active {
          opacity: 1;
          border-top: 2px solid blue;
          border-bottom: 0;
          border-left: 1px solid rgba(0,0,0,0.3);
          border-right: 1px solid rgba(0,0,0,0.3);
        }
        .centered {
    	text-align: center;
    	text-decoration: underline;
    	font-weight:bold;
    	color:#666666;
		}
		
		.manage-text:hover{
			color: blue;		
		}
		
		
      </style>
  </head>
  <body class="d-flex flex-column h-100">
    <div class="container" id="container">
      <div class="card-header">
       <h3 class="text-center w-100 block p-3 fw-normal"> <a href="index.do" href="index.do" style="font-family: 'Anja'; font-size: 40px; text-shadow: 5px 1px 4px rgba(0,0,0,0.2);">Trip Table</a></h3>
      </div>
      <div class="p-5 py-4 pb-5 border shadow">
        <div class="w-100">

          <div class="card mt-3" id="userLogin">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">User</button>
              <button type="button" class="btn btn-type adminBtn">Admin</button>
            </div>
            <div class="card-body">
              <form>
                <div class="form-group" style="text-align: center;">
                
                  <h1>LOGIN</h1>
                  <p>간편로그인으로 여행을 시작하세요!</p>
                  <br />
                  <a href="/oauth2/authorization/google" style="display:flex; justify-content: center;">
                  <img src="../img/google_login2.png" alt="로고" class="d-block" style="width:70%; height:auto;">
                  </a>  <br/> 
                  <a href="/oauth2/authorization/kakao" style="display:flex; justify-content: center;">
                    <img src="../img/kakao_login_large_narrow.png" alt="로고" class="d-block" style="width:70%; height:auto;">
                  </a>
                </div>
              </form>
            </div>
          </div>
    
          <div class="card mt-3" id="adminLogin" style="display: none;">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">User</button>
              <button type="button" class="btn btn-type adminBtn">Admin</button>
            </div>
            <div class="card-body">
              <form action="/mlogin" method="post">
                <div class="form-group">
                  <label for="adminUsername">아이디</label>
                  <input type="text" class="form-control" name="username" id="adminUsermail" placeholder="아이디를 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminPassword">비밀번호</label>
                  <input type="password" class="form-control" name="password" id="adminPassword" placeholder="비밀번호를 입력해주세요.">
           
                </div>
                
               <a href="/muser_info.do"><button type="submit" class="btn btn-primary Btn-login">Log in</button></a>
                 <br />
                <!-- 회원가입 -->
                <br />
				<div class="centered">
				<a href="/mjoinForm.do" class="manage-text">관리자 회원가입</a>
				</div>
				</form>
            </div>
          </div>

        </div>
      </div>
    </div>
  <!-- Bootstrap core JS-->
    <!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
  <script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
  <!-- 부트스트랩 JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

  <!-- Core theme JS-->
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="js/scripts.js"></script>
  
  </body>
</html>