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
      <link rel="icon" type="image/x-icon" href="../img/LogoRaccoon.png" />
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
          border: 2px solid rgb(0 123 255 / 35%);
          opacity: 0.5;
        }
        .btn-type.active {
          opacity: 1;
          border-top: 2px solid #007bff;
          border-bottom: 0;
          border-left: 2px solid #007bff;
          border-right: 2px solid #007bff;
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
				
		p{
		font-weight: bold;
		}
		
		.form-group label {
    		text-align: left;
    		padding-left:5px; /* 원하는 간격으로 조절 */
    		padding-bottom:3px;
    		display: block; /* 레이블을 블록 요소로 변경하여 오른쪽 정렬 적용 */
  		}
      </style>
  </head>
  <body class="d-flex flex-column h-100">
    <div class="container" id="container">
      <div class="card-header mb-4">
          <a href="index.do">
            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
              <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
              <img src="../img/Logo2.png" alt="로고" style="height: 32px; display: inline-block;" />
            </span>
          </a>
      </div>
      <div class="p-5 py-4 pb-5 border shadow">
        <div class="w-100">

          <div class="card mt-3" id="userLogin">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn" style="font-weight: bold;">User</button>
              <button type="button" class="btn btn-type adminBtn" style="font-weight: bold;">Admin</button>
            </div>
            <div class="card-body">
              <form>
                <div class="form-group" style="text-align: center;">
                
                  <h1 style="font-size:60px;">LOGIN</h1>
                  <p style="font-weight:500; font-size:19px">간편로그인으로 여행을 시작하세요!</p>
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
              <button type="button" class="btn btn-type active userBtn" style="font-weight: bold;">User</button>
              <button type="button" class="btn btn-type adminBtn" style="font-weight: bold;">Admin</button>
            </div>
            <div class="card-body">
              <form action="/mlogin" method="post">
                <div class="form-group">
                  <label for="adminUsername" style="">ID</label>
                  <input type="text" class="form-control" name="username" id="adminUsermail" placeholder="아이디를 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminPassword">Password</label>
                  <input type="password" class="form-control" name="password" id="adminPassword" placeholder="비밀번호를 입력해주세요.">
           
                </div>
                
               <button type="submit" class="btn btn-primary Btn-login">Log in</button>
                 <br />
				</form>
            </div>
          </div>

        </div>
      </div>
    </div>
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
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body ft-face-nm">
                여행계획을 불러왔습니다!
            </div>
            <div class="modal-footer ft-face-nm">
              <button type="button" class="btn btn-primary " data-bs-dismiss="modal" aria-label="Close" >확인</button>
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