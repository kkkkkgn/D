<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.example.triptable.entity.User" %>
<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();
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
      <%@ include file="./header.jsp" %>  
      <main class="flex-shrink-0" id="main">
          <div class="" id="navbar-line"></div>

  <!-- ======= Blog Section ======= -->

    <div class="container" data-aos="fade-up">

        <div class="select-container mb-3" >
            <div class="col-sm-5" style="display: flex;">
              <select class="form-select mx-3" id="status-select" aria-label="Default select example">
                <option selected>전체 이용상태</option>
                <option value="1">이용 중</option>
                <option value="2">이용 후</option>
                <option value="3">취소 됨</option>
              </select>
              <div class="col-sm-10" id="">
                <input type="date" class="form-control">
              </div>
            </div>

            
              
              
          </div>
             
          <table class="table" id="res-status">
            <thead>
              <tr>
                <th></th>
                <th>예약ID</th>
                <th>이용상태</th>
                <th>숙소이름</th>
                <th>인원수</th>
                <th>체크인- 체크아웃</th>
                <th>판매금액</th>
                <th>예약날짜</th>
                <th>예약취소</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><img class="res-img" src="https://dummyimage.com/600x400/343a40/6c757d"></td>
                <td>1</td>
                <td><span class="badge rounded-pill bg-primary">이용 중</span></td>
                <td>동현이네 민박집</td>
                <td>2명</td>
                <td>2023.12.24.15:00 - 2023.12.26.11:00</td>
                <td>100,000원</td>
                <td>2023.12.15</td>
                <td>
                  <button type="button" class="btn btn-primary">
                    취소
                  </button>
                </td>
              </tr>
              <tr>
                <td><img class="res-img" src="https://dummyimage.com/600x400/343a40/6c757d"></td>
                <td>2</td>
                <td><span class="badge rounded-pill bg-secondary">취소 됨</span></td>
                <td>동현이네 민박집</td>
                <td>2명</td>
                <td>2023.12.24.15:00 - 2023.12.26.11:00</td>
                <td>100,000원</td>
                <td>2023.12.15</td>
                <td>
                  <button type="button" class="btn btn-primary ">
                    취소
                  </button>
                </td>
              </tr>
              <tr>
                <td><img class="res-img" src="https://dummyimage.com/600x400/343a40/6c757d"></td>
                <td>1</td>
                <td><span class="badge rounded-pill bg-success">이용 후</span></td>
                <td>동현이네 민박집</td>
                <td>2명</td>
                <td>2023.12.24.15:00 - 2023.12.26.11:00</td>
                <td>100,000원</td>
                <td>2023.12.15</td>
                <td>
                  <button type="button" class="btn btn-primary ">
                    취소
                  </button>
                </td>
              </tr>
              <tr>
                <td><img class="res-img" src="https://dummyimage.com/600x400/343a40/6c757d"></td>
                <td>1</td>
                <td><span class="badge rounded-pill bg-success">이용 후</span></td>
                <td>동현이네 민박집</td>
                <td>2명</td>
                <td>2023.12.24.15:00 - 2023.12.26.11:00</td>
                <td>100,000원</td>
                <td>2023.12.15</td>
                <td>
                  <button type="button" class="btn btn-primary ">
                    취소
                  </button>
                </td>
              </tr>
              <tr>
                <td><img class="res-img" src="https://dummyimage.com/600x400/343a40/6c757d"></td>
                <td>1</td>
                <td><span class="badge rounded-pill bg-success">이용 후</span></td>
                <td>동현이네 민박집</td>
                <td>2명</td>
                <td>2023.12.24.15:00 - 2023.12.26.11:00</td>
                <td>100,000원</td>
                <td>2023.12.15</td>
                <td>
                  <button type="button" class="btn btn-primary ">
                    취소
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
          <!-- End Table with stripped rows -->

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
