<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="manager" value="${sessionScope.manager}" />

 <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="dashboard.do" class="logo d-flex align-items-center">
        <img src="../../img/logo.png" alt="">
<!--         <span class="d-none d-lg-block">TripTable_Manager</span> -->
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
       
        <!-- 홈페이지 변경(사용자 메인으로 이동 버튼) -->
        <a class="nav-link pe-3" href="index.do">
          <a href="/logout">
          <i class="bi bi-box-arrow-right">홈페이지 변경</i>
          </a>
        </a><!-- End Notification Icon -->

<!--           로그인 프로필 -->
          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <span class="d-none d-md-block dropdown-toggle ps-2"><c:out value="${manager.getName()}"/></span>
          </a>
          
          <!-- end 로그인 프로필-->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><c:out value="${manager.getName()}"/></h6>
              <span><c:out value="${fn:replace(manager.managerRole.rolename, 'ROLE_', '')} MANAGER" /></span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

          <li>
              <a class="dropdown-item d-flex align-items-center" href="/logout">
                <i class="bi bi-box-arrow-right"></i>
                <span>로그아웃</span>
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
      <a class="nav-link collapsed" href="dashboard.do">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->
    
    
    
    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#notice-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>공지사항 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="notice-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="mnotice.do">
            <i class="bi bi-circle"></i><span>공지사항 추가/수정</span>
          </a>
        </li>
       
      </ul>
    </li><!-- End 공지사항 관리 Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#recommendation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>여행지 추천 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="recommendation-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="recommend.do">
            <i class="bi bi-circle"></i><span>추천 리스트 관리</span>
          </a>
        </li>
       
      </ul>
    </li><!-- End 여행지 추천 관리 Nav -->
    
    


    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#accommodation-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>숙소 예약 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="accommodation-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
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
          <li>
          <a href="payLog.do"> <!--res: reservation-->
            <i class="bi bi-circle"></i><span>결제 내역 조회</span>
          </a>
          </li>
          </ul>
        </li><!-- End 숙소 예약 관리 Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#user-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>사용자 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="user-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="userInfo.do" >
            <i class="bi bi-circle"></i><span>회원 관리</span>
          </a>
        </li>
        <li>
          <a href="duserInfo.do" >
            <i class="bi bi-circle"></i><span>탈퇴 회원 관리</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 사용자 관리 Nav -->

	 <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#manager-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>관리자 설정</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="manager-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="manager.do">
            <i class="bi bi-circle"></i><span>관리자 관리</span>
          </a>
        </li>
        
      </ul>
    </li><!-- End 관리자 승인 Nav -->
	
	
	<li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#main-nav" data-bs-toggle="collapse" href="#">
        <i class="bi bi-menu-button-wide"></i><span>메인 페이지 관리</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="main-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
        <li>
          <a href="#">
            <i class="bi bi-circle"></i><span style="color: #A9A9A9">연결 페이지</span>
          </a>
        </li>
      </ul>
    </li><!-- End 메인페이지 내용 변경 Nav -->

  </ul>

</aside><!-- End Sidebar-->
