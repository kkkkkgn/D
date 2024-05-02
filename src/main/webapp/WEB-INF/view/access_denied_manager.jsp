<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
      #errLoginForm {
         background-color: #00aef0;
         width: 500px;
         margin: 0 auto;
         padding: 60px;
         border-radius: 20px;
         box-shadow: 0 0 10px rgba(0,0,0,0.4);
         word-break: keep-all;
      }
   </style>

</head>
<body class="d-flex align-items-center py-4" " >
   <main class="form-signin w-100 m-auto">
      <div id="errLoginForm">
         <div style="padding:0 20px 20px 0;">
            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
               <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
               <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
            </span>
         </div>
         <div class="relative">
            <h3 class="ft-face-do mb-3" style="font-weight: 500; " >매니저 권한이 없습니다.</h3>
            <div class="mt-1 ft-face-do" style="color: rgb(52, 49, 49);">최고 관리자에게 권한을 요청하거나 </div>
            <div class="mt-1 mb-3 ft-face-do" style="color: rgb(52, 49, 49);">조민희에게 문의하세요 (010-8280-4136)</div>
         </div>
         <div style="margin: auto;">
            <a href="/loginForm.do" style="display: block;"><button type="button" class="btn btn-light ft-face-do">다시 로그인</button></a>
         </div>
        
         
      </div>
   </main>
</body>
</html>