<%@page import="com.example.triptable.entity.Manager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  Manager manager = (Manager)session.getAttribute("manager");
  String managerRole = manager.getManagerRole().getRolename().replace("ROLE_", "") + " MANAGER";  
  String managerName = manager.getName();
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>TripTable</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">
  <link href="../css/managerFont.css" rel="stylesheet" />

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
<%@ include file='mheader.jsp'%>
  <!-- ======= Main ======= -->
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>추천 리스트 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.do">Home</a></li>
          <li class="breadcrumb-item">여행지 추천 관리</li>
          <li class="breadcrumb-item active">추천 리스트 관리</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Datatables</h5>

              <!-- 총 건수 -->
              <b>총 1건</b> 

              <!-- Search Bar-->
              <div class="search-bar" >
                <form class="search-form" method="POST" action="#">
                  <b>지역명</b>
                  <input type="text" name="query" placeholder="Search" title="Enter search keyword">
                  <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                </form>
              </div><!-- End Search Bar -->

              <!-- 리스트 추가 버튼 -->
              <div class="insert-spot ">
                <a class="nav-link nav-icon" href="#">
                  <i class="bi bi-plus-square-fill" data-bs-toggle="modal" data-bs-target="#disablebackdrop">코스 추가</i>
                </a><!-- End Notification Icon -->
                
              
              <div class="modal fade" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false">
                <div class="modal-dialog">
                  <div class="modal-content">
                    <div class="modal-header">
                      <h5 class="modal-title">Disabled Backdrop</h5>
                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                      <form>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">번호</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">여행지역</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">계절</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">링크</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">순서</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label for="" class="col-sm-2 col-form-label">비고</label>
                          <div class="col-sm-10">
                            <input type="text" class="form-control">
                          </div>
                        </div>
                       
                      </form><!-- End General Form Elements -->
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                      <button type="button" class="btn btn-primary">추가</button>
                    </div>

                  </div>
                </div>
              </div><!-- End Disabled Backdrop Modal-->


              <!-- Table  -->
              <table class="table">
                <thead>

                  <tr>
                    <th>번호</th>
                    <th>여행지역</th>
                    <th>계절</th>
                    <th>링크</th>
                    <th>순서</th>
                    <th>비고</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Unity Pugh</td>
                    <td>9958</td>
                    <td>Curicó</td>
                    <td><a href="#">https://naver.com</a></td>
                    <td>37%</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Theodore Duran</td>
                    <td>8971</td>
                    <td>Dhanbad</td>
                    <td>1999/04/07</td>
                    <td>97%</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Kylie Bishop</td>
                    <td>3147</td>
                    <td>Norman</td>
                    <td>2005/09/08</td>
                    <td>63%</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Willow Gilliam</td>
                    <td>3497</td>
                    <td>Amqui</td>
                    <td>2009/29/11</td>
                    <td>30%</td>
                    <td></td>
                  </tr>
                  <tr>
                    <td>Blossom Dickerson</td>
                    <td>5018</td>
                    <td>Kempten</td>
                    <td>2006/11/09</td>
                    <td>17%</td>
                    <td></td>
                  </tr>
                 
                </tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>TripTable</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
<!--       All the links in the footer should remain intact. -->
<!--       You can delete the links only if you purchased the pro version. -->
<!--       Licensing information: https://bootstrapmade.com/license/ -->
<!--       Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
<!--       Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.umd.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>

</html>