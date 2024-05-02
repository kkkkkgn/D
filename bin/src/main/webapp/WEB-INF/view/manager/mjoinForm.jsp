<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	String client_id = "e6f70ebe197d015b321682644e0afc1b";
	String redirect_uri = "http://192.168.133.1:8080/kakao.do";
%>
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
      <link href="css/styles.css" rel="stylesheet" />
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
      </style>
  </head>
  <body class="d-flex flex-column h-100">
    <div class="container" id="container">
      <div class="card-header">
        <h3 class="text-center w-100 block p-3 fw-normal">Trip Table</h3>
      </div>
      <div class="p-5 py-4 pb-5 border shadow">
        <div class="w-100">

          <div class="card mt-3" id="userLogin" style="display: none;">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">User</button>
              <button type="button" class="btn btn-type adminBtn">Admin</button>
            </div>
            <div class="card-body">
              <form>
                <div class="form-group" style="text-align: center;">
                
                  <h1>회원 로그인</h1>
                  <p>저희는 소셜 로그인밖에 없습니다..</p>
                  <a href="/oauth2/authorization/google">
                  <img src="../img/google_login.png" alt="로고" class="d-block" style="width: 100%">
                  </a>   
                  <a href="/oauth2/authorization/kakao">
                    <img src="../img/kakao_login_large_wide.png" alt="로고" class="d-block" style="width: 100%">
                  </a>
                </div>
              </form>
            </div>
          </div>
    
          <div class="card mt-3" id="adminLogin" >
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type userBtn">User</button>
              <button type="button" class="btn btn-type active adminBtn">Admin</button>
            </div>
            <div class="card-body">
              <form method="post" action="/mjoin.do">
                <div class="form-group">
                  <label for="adminUsermail">메일</label>
                  <input type="text" class="form-control" name ="adminUsermail" id="adminUsermail" placeholder="이메일을 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminPassword">비밀번호</label>
                  <input type="password" class="form-control" name ="adminPassword" id="adminPassword" placeholder="비밀번호를 입력해주세요.">
                </div>
                <div class="form-group">
                  <label for="adminUsertel">전화번호</label>
                  <input type="text" class="form-control" name ="adminUsertel" id="adminUsertel" placeholder="전화번호를 입력해주세요.">
                  <br/>
                 <b>가입 후 최상위 관리자의 승인을 기다리셔야 합니다...</b>
                </div>
                <button type="submit" class="btn btn-primary Btn-login">join</button>
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
  <script src="https://code.jquery.com/jquery-3.6.4.min.js" integrity="sha384-oR2wazi8sOb8b2ZUpSZlG60SQIDevzvsy3WlA+cxsn5BE5lssNHDN9oAWD+1bz1g" crossorigin="anonymous"></script>
  <script src="js/scripts.js"></script>
  
  </body>
</html>
