<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Nov 17 2023 with Bootstrap v5.3.2
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="dashboard.html" class="logo d-flex align-items-center">
        <img src="assets/img/logo.png" alt="">
        <span class="d-none d-lg-block">TripTable_Manager</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">

        <!-- 홈페이지 변경(사용자 메인으로 이동 버튼) -->
          <a class="nav-link pe-3" href="#">
            <i class="bi bi-box-arrow-right">홈페이지 변경</i>
          </a><!-- End 홈페이지 변경 -->

          <!-- 로그인 프로필 -->
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <span class="d-none d-md-block dropdown-toggle ps-2">K. Anderson</span>
          </a>
          <!-- end 로그인 프로필-->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6>Kevin Anderson</h6>
              <span>Web Designer</span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <!-- <li>
              <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                <i class="bi bi-person"></i>
                <span>My Profile</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                <i class="bi bi-gear"></i>
                <span>Account Settings</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="pages-faq.html">
                <i class="bi bi-question-circle"></i>
                <span>Need Help?</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li> -->

            <li>
              <a class="dropdown-item d-flex align-items-center" href="#">
                <i class="bi bi-box-arrow-right"></i>
                <span>Sign Out</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

  <ul class="sidebar-nav" id="sidebar-nav">

    <li class="nav-item">
      <a class="nav-link collapsed" href="dashboard.html">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link " data-bs-target="#recommendation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>여행지 추천 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="recommendation-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="recommend.do" class="active">
            <i class="bi bi-circle"></i><span>추천 리스트 관리</span>
          </a>
        </li>
       
      </ul>
    </li><!-- End 여행지 추천 관리 Nav -->


    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#accommodation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>숙소 예약 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="accommodation-nav" class="nav-content" data-bs-parent="#sidebar-nav">
        <li>
          <a href="accDB.do" >
            <i class="bi bi-circle"></i><span>숙소 DB 관리</span>
          </a>
        </li>
        <li>
          <a href="accRes.do"> <!--res: reservation-->
            <i class="bi bi-circle"></i><span>예약 내역 관리</span>
          </a>
          </li>
          </ul>
        </li><!-- End 숙소 예약 관리 Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#user-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-journal-text"></i><span>사용자 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="user-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="user.do">
            <i class="bi bi-circle"></i><span>사용자 계정 관리</span>
          </a>
        </li>
        <li>
          <a href="userDel.do">
            <i class="bi bi-circle"></i><span>탈퇴 계정 관리</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 사용자 관리 Nav -->

	 <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#manager-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>관리자 조작</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="manager-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="manager-agree.html" class="active">
            <i class="bi bi-circle"></i><span>관리자 등록 승인</span>
          </a>
        </li>
        <li>
          <a href="manager.do">
            <i class="bi bi-circle"></i><span>기존 관리자 list</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 관리자 승인 Nav -->
	

  </ul>

</aside><!-- End Sidebar-->


  <main id="main" class="main">

    <div class="pagetitle">
      <h1>추천 리스트 관리</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="dashboard.html">Home</a></li>
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
      &copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved
    </div>
    <div class="credits">
      <!-- All the links in the footer should remain intact. -->
      <!-- You can delete the links only if you purchased the pro version. -->
      <!-- Licensing information: https://bootstrapmade.com/license/ -->
      <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
      Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
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