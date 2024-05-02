<%@page import="com.example.triptable.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
User user = (User)session.getAttribute("user");
String user_name = (user != null) ? user.getName() : "";
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
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/font.css" rel="stylesheet" />
        <link href="css/dong.css" rel="stylesheet" />
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
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
      <%@ include file="./user/header.jsp" %>
      <main class="flex-shrink-0" id="main">
          <div class="" id="navbar-line"></div>

  <!-- ======= Blog Section ======= -->

    <div class="container" data-aos="fade-up">

<!--         <div class="select-container mb-3" > -->
<!--             <div class="col-sm-5" style="display: flex;"> -->
<!--               <select class="form-select mx-3" id="status-select" aria-label="Default select example"> -->
<!--                 <option selected>전체 이용상태</option> -->
<!--                 <option value="1">이용 중</option> -->
<!--                 <option value="2">이용 후</option> -->
<!--                 <option value="3">취소 됨</option> -->
<!--               </select> -->
<!--               <div class="col-sm-10" id=""> -->
<!--                 <input type="date" class="form-control"> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
	
		<div class="pagetitle d-flex justify-content-between align-items-center" style="margin-top: 20px; margin-bottom: 30px;">
		    <h2><b>공지사항</b></h2>
		    <div class="d-flex">
		        <input type="text" id="course-search" class="form-control mx-3" placeholder="검색어를 입력하세요" style="width: 300px;">
		        <button class="btn btn-primary px-5" type="button" id="search-button">검색</button>
		    </div>
		</div>

        

          <table class="table" id="res-status">
            <thead>
              <tr style="background-color: #F0F8FF;">
               
                <th width="3%">&nbsp;</th>
				<th width="5%">번호</th>
				<th>제목</th>
				<th width="10%">작성자</th>
				<th width="17%">등록일</th>
				<th width="5%">조회</th>
				<th width="3%">&nbsp;</th>
                
              </tr>
            </thead>
            <tbody>
              <tr>
              	<td>&nbsp;</td>
                <td>1</td>
                <td><a href="#">공지사항</a>&nbsp;<img src='./img/new.png' alt='NEW'></td>
                <td>조민희</td>
                <td>2023.12.24 15:16</td>
                <td>10</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>1</td>
                <td><a href="#">공지사항</a>&nbsp;<img src='./img/new.png' alt='NEW'></td>
                <td>조민희</td>
                <td>2023.12.24 15:16</td>
                <td>10</td>
                <td>&nbsp;</td></tr>
              <tr>
                <td>&nbsp;</td>
                <td>1</td>
                <td><a href="#">공지사항</a></td>
                <td>조민희</td>
                <td>2023.12.24 15:16</td>
                <td>10</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td>&nbsp;</td>
                <td>1</td>
                <td><a href="#">공지사항</a></td>
                <td>조민희</td>
                <td>2023.12.24 15:16</td>
                <td>10</td>
                <td>&nbsp;</td>
              </tr>
              <tr>
              	<td>&nbsp;</td>
                <td>1</td>
                <td><a href="#">공지사항</a></td>
                <td>조민희</td>
                <td>2023.12.24 15:16</td>
                <td>10</td>
                <td>&nbsp;</td>
              </tr>
            </tbody>
          </table>
          <!-- End Table with stripped rows -->

        </div>
        
        <div class="flex justify-center items-center my-3 ft-face-nm">
            <nav aria-label="표준 페이지 매김 예제" _mstaria-label="655265" _msthash="546">
              <ul class="pagination">
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="이전의" _mstaria-label="119327" _msthash="547">
                    <span aria-hidden="true">«</span>
                  </a>
                </li>
                <li class="page-item"><a class="page-link" href="#" _msttexthash="4459" _msthash="548">1</a></li>
                <li class="page-item"><a class="page-link" href="#" _msttexthash="4550" _msthash="549">2</a></li>
                <li class="page-item"><a class="page-link" href="#" _msttexthash="4641" _msthash="550">3</a></li>
                <li class="page-item">
                  <a class="page-link" href="#" aria-label="다음" _mstaria-label="46722" _msthash="551">
                    <span aria-hidden="true">»</span>
                  </a>
                </li>
              </ul>
            </nav>
          </div>

        </main>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
    </body>
</html>
