<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="com.example.triptable.entity.User" %>
<%
	User user = (User)session.getAttribute("user");
	String user_name = user.getName();
	String user_nick = user.getNickname();
	String user_mail = user.getMail();
	String user_icon = user.getIcon();
	System.out.println(user_icon);
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trip Table</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        <style>
            /*--------------------------------------------------------------
            # mypage
            --------------------------------------------------------------*/
            .mypage {
            position: relative;
            z-index: 2;
            }

            .mypage .icon-box {
            padding: 40px 30px;
            box-shadow: 0px 2px 15px rgba(0, 0, 0, 0.15);
            border-radius: 10px;
            background: #fff;
            transition: all ease-in-out 0.3s;
            height: 100%;
            }

            .mypage .icon-box i {
            color: #99ccff;
            font-size: 42px;
            margin-bottom: 15px;
            display: block;
            line-height: 0;
            }

            .mypage .icon-box h3 {
            font-weight: 700;
            margin-bottom: 15px;
            font-size: 20px;
            }

            .mypage .icon-box h3 a {
            color: #545454;
            transition: 0.3s;
            }

            .mypage .icon-box p {
            color: #545454;
            line-height: 24px;
            font-size: 14px;
            margin-bottom: 0;
            }

            .mypage .icon-box:hover {
            background: #99ccff;
            }

            .mypage .icon-box:hover i,
            .mypage .icon-box:hover h3 a,
            .mypage .icon-box:hover p {
            color: #fff;
            }
             /* 프로필 사진 선택 버튼 id 바꾸기 */
             #profile-btn { 
                height: 200px;
                width: 200px;
            }

            #profile-img {
                height: 180px;
            }

            .card {
                margin-bottom: 30px;
                border: none;
                border-radius: 5px;
                box-shadow: 0px 3px 5px rgba(1, 41, 112, 0.1);
            }
            .card-body {
                padding: 0 30px 30px 30px;
                
            }
            
        </style>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">

            <section class="section profile">
            <div class="card">
               
                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                   
                    <button type="button" class="img-fluid rounded-circle mb-5" id="profile-btn" ><img class="rounded-circle" id="profile-img" src="../icon/<%=user_icon %>.png" alt="..." /></button> 
                    <div class="h1 fw-bolder fs-5 mb-3"><%=user_nick %></div>
                    <div class="text-muted"><%=user_mail %></div>
                </div>
              </div>
              <section class="section profile">
            <!-- ======= mypage Section ======= -->
            
            <section id="mypage" class="mypage">
                <div class="container">
        
                <div class="row">
                    <div class="col-lg-4">
                        <a href="time_machine.do">
                            <div class="icon-box text-center">
                                <i class="bi bi-map"></i>
                                <h3>타임머신</a></h3>
                                <p>나의 여행 기록을 확인해 보아요!</p>
                            </div>
                       
                    </div>
                    <div class="col-lg-4 ">
                        <a href="res_status.do">
                            <div class="icon-box text-center">
                                <i class="bi bi-calendar4-week"></i>
                                <h3>숙소 예약 현황</a></h3>
                                <p></p>
                            </div>
                      
                    </div>
                    <div class="col-lg-4">
                        <a href="profile_set.do">
                            <div class="icon-box text-center">
                                <i class="bi bi-gear"></i>
                                <h3>회원정보 수정</a></h3>
                                <p></p>
                            </div>
                        
                    </div>
                </div>
        
                </div>
            </section><!-- End mypage Section -->
        
            
        
            
            </main><!-- End #main -->

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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>
