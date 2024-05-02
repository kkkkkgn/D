<!-- header.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="com.example.triptable.entity.User" />
<c:set var="user" value="${sessionScope.user}" />
<c:set var="listDosi" value="${requestScope.listDosi}" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet" />


<script>
function login_alert() {
    alert("로그인 후 이용할 수 있는 페이지입니다.");
    window.location.href = "./loginForm.do";
}

$(document).ready(function() {
	$('#chatbot').on('click', function() {
		$("#headerAlertBtn").click();
	});
});
</script>
<!-- Button trigger modal -->
<button type="button" id="headerAlertBtn" class="btn btn-primary none" data-bs-toggle="modal" data-bs-target="#headerAlert">
</button>

<div class="modal fade ft-face-kg" id="headerAlert" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
<div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    <div class="modal-header" style="background-color: #00aef0;">
        <h1 class="modal-title fs-5" id="">
            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
            </span>
        </h1>
        <button id="" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>
    <div class="modal-body" style="font-size:20px;">
        보다 나은 서비스를 준비중입니다!<br/>
        [너구리 일동] 
    </div>
    <div id="" class="modal-footer ft-face-nm">
        <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
        <button type="button" class="btn btn-primary " data-bs-dismiss="modal" aria-label="Close" >확인</button>
    </div>
    </div>
</div>
</div>
<div>
    <header class="common-layout-react-HeaderV2 fv-6 fv-6-header--fixed fv-6-header--fixed--desktop" style="height:80px">
        <div class="fv-6-header">
            <div class="kml-layout mod-full edges-m mobile-edges fv-6-header__container fv-6-navBelowHeader c31EJ">
                <div class="fv-6-left-section">
                    <div class="fv-6-menu-button">
                        <button class="Button-No-Standard-Style theme-dark yWJT yWJT-new-nav-ux" aria-label="내비게이션 메뉴" aria-expanded="false">
                            <svg viewBox="30 50 100 100" width="20" height="20" xmlns="http://www.w3.org/2000/svg" role="img">
                                <path d="M155 135H45a5 5 0 1 1 0-10h110c2.762 0 5 2.238 5 5s-2.238 5-5 5zm0-30H45a5 5 0 1 1 0-10h110a5 5 0 1 1 0 10zm0-30H45a5 5 0 0 1 0-10h110a5 5 0 1 1 0 10z"></path>
                            </svg>
                        </button>
                    </div>
                    <div class="ui-layout-HeaderMainLogo normal-from-l-size main-logo--mobile">
                        <a class="main-logo__link" href="/" itemprop="https://schema.org/logo" aria-label="홈페이지로 이동하기">
                            <div class="main-logo__logo has-compact-logo inverted-logo">
                                <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                                    <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                                    <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                                </span>
                                <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image-compact">
                                    <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                                </span>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="lfBz">
                    <div class="iiio-fields iiio-mod-animate-width" role="search" style="width: 625.234px;">
                        <div class="iiio-mod-display-extended iiio-animate-end" style="visibility: visible;">
                            <div class="lfBz-field-outline lfBz-mod-presentation-extended">
                                <div role="button" tabindex="0" class="NITa NITa-location NITa-hasValue NITa-mod-presentation-expanded" aria-label="목적지">
                                    <span style="transform: translate3d(0px, 0px, 0px); vertical-align: middle; -webkit-font-smoothing: antialiased; width: 23px; height: 16px;">
                                        <svg viewBox="0 0 200 200" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="NITa-icon" role="img" style="width: inherit; height: inherit; line-height: inherit; color: inherit; vertical-align: baseline;">
                                            <path d="M175 170a5 5 0 0 1-5-5v-5H30v5a5 5 0 1 1-10 0v-43.092c0-8.176 3.859-15.462 10-20.027V65c0-13.785 11.215-25 25-25h90c13.785 0 25 11.215 25 25v36.98c6.093 4.613 10 11.922 10 19.928V165a5 5 0 0 1-5 5zM30 150h140v-10H30v10zm0-20h140v-8.092c0-7.342-5.486-13.707-12.762-14.806c-40.216-6.077-73.399-6.207-114.477 0C35.415 108.21 30 114.4 30 121.908V130zm120-34.027c2.877.382 9.581 1.381 10 1.467V65c0-8.271-6.729-15-15-15H55c-8.271 0-15 6.729-15 15v32.438c.418-.084 7.123-1.083 10-1.465V85c0-8.271 6.729-15 15-15h25a14.94 14.94 0 0 1 10 3.829A14.943 14.943 0 0 1 110 70h25c8.271 0 15 6.729 15 15v10.973zm-45-3.45c11.463.167 22.988.912 35 2.233V85c0-2.757-2.243-5-5-5h-25c-2.757 0-5 2.243-5 5v7.523zM65 80c-2.757 0-5 2.243-5 5v9.756c12.012-1.321 23.537-2.065 35-2.232V85c0-2.757-2.243-5-5-5H65z"></path>
                                        </svg>
                                    </span>
                                    <span class="NITa-value sidoValues"></span>
                                </div>
                                <div class="iiio-date">
                                    <div role="button" tabindex="0" class="NITa NITa-date NITa-hasValue NITa-withDateArrows NITa-mod-presentation-expanded" style="padding: 4px;">
                                        <span style="transform: translate3d(0px, 0px, 0px); vertical-align: middle; -webkit-font-smoothing: antialiased; width: 23px; height: 16px;">
                                            <svg viewBox="0 0 200 200" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="NITa-icon" role="img" style="width: inherit; height: inherit; line-height: inherit; color: inherit; vertical-align: baseline;">
                                                <path d="M165 180H35c-8.3 0-15-6.7-15-15V35c0-8.3 6.7-15 15-15h25v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h60v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h25c8.3 0 15 6.7 15 15v130c0 8.3-6.7 15-15 15zM30 60v105c0 2.8 2.2 5 5 5h130c2.8 0 5-2.2 5-5V60H30zm0-10h140V35c0-2.8-2.2-5-5-5h-25v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H70v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H35c-2.8 0-5 2.2-5 5v15zm75 100c-2.8 0-5-2.2-5-5V97.1l-11.5 11.5c-2 2-5.1 2-7.1 0s-2-5.1 0-7.1l20-20c1.4-1.4 3.6-1.9 5.4-1.1c1.9.8 3.1 2.6 3.1 4.6v60c.1 2.8-2.1 5-4.9 5z"></path>
                                            </svg>
                                        </span>
                                        <button class="btn btn-light trvl_day"  style="background-color: #f0f2f5; border: none !important;"><span class="ml-2"></span></button>                                 
                                    </div>
                                </div>
                                <div role="button" tabindex="0" class="personnel NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded" aria-label="인원">
                                    <span style="transform: translate3d(0px, 0px, 0px); vertical-align: middle; -webkit-font-smoothing: antialiased; width: 23px; height: 16px;">
                                        <svg viewBox="0 0 200 200" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="NITa-icon" role="img" style="width: inherit; height: inherit; line-height: inherit; color: inherit; vertical-align: baseline;">
                                            <path d="M160.6 180H39.4c-1.6 0-3.2-.8-4.1-2.1c-8-11.5-6.8-32.8 2.2-41.5c3.9-3.8 23.8-10.5 35.6-14C58.8 108.1 50 95.4 50 70.9C50 38.6 68.2 20 100 20s50 18.6 50 50.9c0 23.8-8.2 36.7-23.1 51.5c11.8 3.5 31.6 10.2 35.6 14c9.1 8.7 10.3 30 2.3 41.5c-1 1.3-2.6 2.1-4.2 2.1zM42.3 170h115.5c4-8.3 2.4-21.8-2.1-26.3c-3.6-2.8-31.2-12.1-38.9-13.8c-3.5-.8-5.1-4.9-3-7.8c7.9-10.8 26.3-19.2 26.3-51.2c0-18.7-6.9-40.9-40-40.9S60 52.2 60 70.9c0 31.9 18.4 40.3 26.3 51.2c2.1 2.9.5 7.1-3 7.8c-7.7 1.6-35.3 10.9-38.9 13.7c-4.6 4.5-6.1 18.1-2.1 26.4zm2.2-26.4z"></path>
                                        </svg>
                                    </span>
                                    <span class="NITa-value">인원 2명</span>
                                </div>
                                <div class="iiio-submit">
                                    <button role="button" style="border-color:transparent; border-radius: 8px; background-color:#fbfcfd; width: 44px;" class="Iqt3 Iqt3-mod-stretch Iqt3-mod-bold Button-No-Standard-Style Iqt3-mod-variant-solid Iqt3-mod-theme-progress-inverted Iqt3-mod-shape-rounded-medium Iqt3-mod-shape-mod-default Iqt3-mod-spacing-default Iqt3-mod-size-medium Iqt3-mod-animation-search" tabindex="0" aria-disabled="false" title="" type="submit" aria-label="Search">
                                        <div class="Iqt3-button-container">
                                            <div class="Iqt3-button-content">
                                                <svg viewBox="0 0 200 200" width="28" height="28" xmlns="http://www.w3.org/2000/svg" class="c8LPF-icon" role="img" style="vertical-align: baseline;">
                                                    <path d="M178.5 171.5l-44.2-44.2c9.8-11.4 15.7-26.1 15.7-42.3c0-35.8-29.2-65-65-65S20 49.2 20 85s29.2 65 65 65c16.1 0 30.9-5.9 42.3-15.7l44.2 44.2c2 2 5.1 2 7.1 0c1.9-1.9 1.9-5.1-.1-7zM30 85c0-30.3 24.7-55 55-55s55 24.7 55 55s-24.7 55-55 55s-55-24.7-55-55z"></path>
                                                </svg>
                                            </div>
                                        </div>
                                        <div class="Iqt3-button-focus-outline"></div>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            

                <div class="fv-6-right-section">
                    <div>
                        <div class="common-layout-react-HeaderAccountWrapper theme-dark account--collapsible">
                            <span>
                                <div class="auth-account-wrap menu__wrapper">
                                    <div class="menu-icon__wrapper menu-icon__wrapper--auth">
                                        <span class="menu-icon">
                                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:35px;height:auto;display:block;fill:#fff;margin-right:5px;">
                                                <svg viewBox="20 0 200 200" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="auth-account-icon" role="img" style="width:inherit;height:inherit;line-height:inherit;color:inherit">
                                                    <path d="M180 100c0-44.1-35.9-80-80-80s-80 35.9-80 80s35.9 80 80 80s80-35.9 80-80zm-80-70c38.6 0 70 31.4 70 70c0 16.3-5.6 31.3-15 43.2c-.5-.7-1-1.4-1.7-2c-3.2-3.1-17.3-7.1-27.3-9.6c9.5-10.2 13.9-25.5 13.9-38.3c0-28.7-13.5-43.3-40-43.3s-40 14.6-40.1 43.3c0 12.8 4.4 28.1 13.9 38.3c-9.9 2.5-24 6.5-27.2 9.5c-.6.6-1.2 1.2-1.7 2C35.6 131.2 30 116.2 30 100c0-38.6 31.4-70 70-70zM52 150.9c.6-1.4 1.1-2.1 1.3-2.4c3.4-2.2 25.1-8 32.5-9.5c4.5-.9 5.5-7 1.4-9.3c-10.4-5.8-17.4-20.5-17.4-36.4C70 70 79 60 100 60c20.7 0 30 10.3 30 33.3c0 15.7-7.2 30.7-17.4 36.4c-4 2.2-3.1 8.3 1.4 9.2c9.6 2.1 29.4 7.4 32.6 9.5c.3.3.8 1.1 1.4 2.4c-27.1 25.5-69 25.6-96 .1z"></path>
                                                </svg>
                                            </span>
                                        </span>
                                    </div>
                                    
                                    <c:if test="${not empty user}">
                                    <!-- user 변수가 세션에 존재하는 경우 -->
                                        <div class="menu-label__wrapper" id="rogin_label">
                                            <div class="account-pic__wrapper">
                                                <div class="common-layout-react-HeaderAccountPic profile-icon-letter inspectlet-sensitive theme-dark mcfly">t</div>
                                            </div>
                                            <span class="menu-label">
                                                <div class="common-layout-react-HeaderAccountBadge">
                                                    <div class="account-label">
                                                        <div class="account-label__inner">
                                                            <span class="account-name inspectlet-sensitive" dir="auto"> ${user.nickname}</span> 님
                                                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto">
                                                                <svg width="100%" height="100%" viewBox="0 0 8 5" xmlns="http://www.w3.org/2000/svg" stroke-linejoin="round" stroke-linecap="round" stroke-width="1.35" class="account-label__svg" role="img" style="width:12px; margin-left: 5px; height:inherit;line-height:inherit;color:inherit">
                                                                    <path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none"></path>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </span>
                                        </div>
                                    </c:if>
                                    
                                    <c:if test="${empty user}">
                                    <!-- user 변수가 세션에 존재하지 않는 경우 -->
                                        <a href="./loginForm.do" class="menu-label__wrapper" id="rogout_label">
                                            <span class="menu-label">
                                                <button role="button"  class="Iqt3 Iqt3-mod-bold Button-No-Standard-Style Iqt3-mod-variant-outline Iqt3-mod-theme-none Iqt3-mod-shape-rounded-small Iqt3-mod-shape-mod-default Iqt3-mod-spacing-default Iqt3-mod-size-default" tabindex="0" aria-disabled="false">
                                                    <div class="Iqt3-button-container">
                                                        <div class="Iqt3-button-content">
                                                            <div>
                                                                <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:27px;height:auto;display:block;fill:#fff;margin-right:5px;">
                                                                    <svg viewBox="0 0 200 200" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="auth-account-icon" role="img" style="width:inherit;height:inherit;line-height:inherit;color:inherit">
                                                                        <path d="M180 100c0-44.1-35.9-80-80-80s-80 35.9-80 80s35.9 80 80 80s80-35.9 80-80zm-80-70c38.6 0 70 31.4 70 70c0 16.3-5.6 31.3-15 43.2c-.5-.7-1-1.4-1.7-2c-3.2-3.1-17.3-7.1-27.3-9.6c9.5-10.2 13.9-25.5 13.9-38.3c0-28.7-13.5-43.3-40-43.3s-40 14.6-40.1 43.3c0 12.8 4.4 28.1 13.9 38.3c-9.9 2.5-24 6.5-27.2 9.5c-.6.6-1.2 1.2-1.7 2C35.6 131.2 30 116.2 30 100c0-38.6 31.4-70 70-70zM52 150.9c.6-1.4 1.1-2.1 1.3-2.4c3.4-2.2 25.1-8 32.5-9.5c4.5-.9 5.5-7 1.4-9.3c-10.4-5.8-17.4-20.5-17.4-36.4C70 70 79 60 100 60c20.7 0 30 10.3 30 33.3c0 15.7-7.2 30.7-17.4 36.4c-4 2.2-3.1 8.3 1.4 9.2c9.6 2.1 29.4 7.4 32.6 9.5c.3.3.8 1.1 1.4 2.4c-27.1 25.5-69 25.6-96 .1z"></path>
                                                                    </svg>
                                                                </span>
                                                            </div>
                                                            <div class="sign-in-nav-link">로그인</div>
                                                        </div>
                                                    </div>
                                                    <div class="Iqt3-button-focus-outline"></div>
                                                </button>
                                            </span>
                                        </a>
                                    </c:if>
                                </div>
                            </span>
                        </div>
                    </div>
                    <div class="fv-6-picker"></div>
                </div>
            </div>

        </div>
        <div class="c5ab7 c5ab7-collapsed">
            <div role="dialog" style="height: 100vh;">
                <div index=" " tabindex="-1" class="pRB0 pRB0-collapsed pRB0-mod-variant-accordion pRB0-mod-position-fixed" style="top:80px; height:calc(100% - 80px); background-color:#fff; position: fixed;">
                    <div>
                        <div class="pRB0-nav-items">
                            <nav class="HtHs" aria-label="홈">
                                <ul class="HtHs-nav-list">
                            
                                    <c:if test="${not empty user}">
                                    <!-- user 변수가 세션에 존재하는 경우 -->
                                        <li>
                                            <a href="/user/trip_plan.do" aria-label="여행 계획" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                               <path d="M166.9 185.3L145 170.7l-21.9 14.6c-1.7 1.2-4 1.1-5.7-.1c-1.7-1.2-2.4-3.4-1.9-5.4l7-25.4l-20.6-16.4c-1.6-1.3-2.3-3.5-1.6-5.5c.6-2 2.5-3.4 4.5-3.5l26.3-1.2l9.2-24.7c.7-2 2.6-3.2 4.7-3.2s4 1.3 4.7 3.2l9.2 24.7l26.3 1.2c2.1.1 3.9 1.5 4.5 3.5c.6 2 0 4.2-1.6 5.5l-20.6 16.3l7 25.4c.6 2-.2 4.2-1.9 5.4c-1.6 1.3-3.9 1.3-5.7.2zm-19.1-24.8l13.6 9l-4.3-15.7c-.5-1.9.1-4 1.7-5.2l12.7-10.1l-16.2-.7c-2-.1-3.8-1.4-4.5-3.2l-5.7-15.3l-5.7 15.3c-.7 1.9-2.5 3.2-4.5 3.2l-16.2.7l12.7 10.1c1.6 1.2 2.2 3.3 1.7 5.2l-4.3 15.7l13.6-9c1.5-1.1 3.7-1.1 5.4 0zM95 180H35c-8.3 0-15-6.7-15-15V35c0-8.3 6.7-15 15-15h25v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h60v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h25c8.3 0 15 6.7 15 15v70c0 2.8-2.2 5-5 5s-5-2.2-5-5V60H30v105c0 2.8 2.2 5 5 5h60c2.8 0 5 2.2 5 5s-2.2 5-5 5zM30 50h140V35c0-2.8-2.2-5-5-5h-25v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H70v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H35c-2.8 0-5 2.2-5 5v15z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">여행 계획</div>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${empty user}">
                                    <!-- user 변수가 세션에 존재하지 않는 경우 -->
                                        <li>
                                            <a onclick="login_alert()" aria-label="여행 계획" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                    <path d="M166.9 185.3L145 170.7l-21.9 14.6c-1.7 1.2-4 1.1-5.7-.1c-1.7-1.2-2.4-3.4-1.9-5.4l7-25.4l-20.6-16.4c-1.6-1.3-2.3-3.5-1.6-5.5c.6-2 2.5-3.4 4.5-3.5l26.3-1.2l9.2-24.7c.7-2 2.6-3.2 4.7-3.2s4 1.3 4.7 3.2l9.2 24.7l26.3 1.2c2.1.1 3.9 1.5 4.5 3.5c.6 2 0 4.2-1.6 5.5l-20.6 16.3l7 25.4c.6 2-.2 4.2-1.9 5.4c-1.6 1.3-3.9 1.3-5.7.2zm-19.1-24.8l13.6 9l-4.3-15.7c-.5-1.9.1-4 1.7-5.2l12.7-10.1l-16.2-.7c-2-.1-3.8-1.4-4.5-3.2l-5.7-15.3l-5.7 15.3c-.7 1.9-2.5 3.2-4.5 3.2l-16.2.7l12.7 10.1c1.6 1.2 2.2 3.3 1.7 5.2l-4.3 15.7l13.6-9c1.5-1.1 3.7-1.1 5.4 0zM95 180H35c-8.3 0-15-6.7-15-15V35c0-8.3 6.7-15 15-15h25v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h60v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h25c8.3 0 15 6.7 15 15v70c0 2.8-2.2 5-5 5s-5-2.2-5-5V60H30v105c0 2.8 2.2 5 5 5h60c2.8 0 5 2.2 5 5s-2.2 5-5 5zM30 50h140V35c0-2.8-2.2-5-5-5h-25v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H70v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H35c-2.8 0-5 2.2-5 5v15z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">여행 계획</div>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${not empty user}">
                                    <!-- user 변수가 세션에 존재하는 경우 -->
                                        <li>
                                            <a href="/user/acc_reservation.do" aria-label="숙소 예약" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="page" tabindex="0">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                    <path d="M175 170a5 5 0 0 1-5-5v-5H30v5a5 5 0 1 1-10 0v-43.092c0-8.176 3.859-15.462 10-20.027V65c0-13.785 11.215-25 25-25h90c13.785 0 25 11.215 25 25v36.98c6.093 4.613 10 11.922 10 19.928V165a5 5 0 0 1-5 5zM30 150h140v-10H30v10zm0-20h140v-8.092c0-7.342-5.486-13.707-12.762-14.806c-40.216-6.077-73.399-6.207-114.477 0C35.415 108.21 30 114.4 30 121.908V130zm120-34.027c2.877.382 9.581 1.381 10 1.467V65c0-8.271-6.729-15-15-15H55c-8.271 0-15 6.729-15 15v32.438c.418-.084 7.123-1.083 10-1.465V85c0-8.271 6.729-15 15-15h25a14.94 14.94 0 0 1 10 3.829A14.943 14.943 0 0 1 110 70h25c8.271 0 15 6.729 15 15v10.973zm-45-3.45c11.463.167 22.988.912 35 2.233V85c0-2.757-2.243-5-5-5h-25c-2.757 0-5 2.243-5 5v7.523zM65 80c-2.757 0-5 2.243-5 5v9.756c12.012-1.321 23.537-2.065 35-2.232V85c0-2.757-2.243-5-5-5H65z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">숙소 예약</div>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${empty user}">
                                    <!-- user 변수가 세션에 존재하지 않는 경우 -->
                                        <li>
                                            <a onclick="login_alert()" aria-label="숙소 예약" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="page" tabindex="0">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                    <path d="M175 170a5 5 0 0 1-5-5v-5H30v5a5 5 0 1 1-10 0v-43.092c0-8.176 3.859-15.462 10-20.027V65c0-13.785 11.215-25 25-25h90c13.785 0 25 11.215 25 25v36.98c6.093 4.613 10 11.922 10 19.928V165a5 5 0 0 1-5 5zM30 150h140v-10H30v10zm0-20h140v-8.092c0-7.342-5.486-13.707-12.762-14.806c-40.216-6.077-73.399-6.207-114.477 0C35.415 108.21 30 114.4 30 121.908V130zm120-34.027c2.877.382 9.581 1.381 10 1.467V65c0-8.271-6.729-15-15-15H55c-8.271 0-15 6.729-15 15v32.438c.418-.084 7.123-1.083 10-1.465V85c0-8.271 6.729-15 15-15h25a14.94 14.94 0 0 1 10 3.829A14.943 14.943 0 0 1 110 70h25c8.271 0 15 6.729 15 15v10.973zm-45-3.45c11.463.167 22.988.912 35 2.233V85c0-2.757-2.243-5-5-5h-25c-2.757 0-5 2.243-5 5v7.523zM65 80c-2.757 0-5 2.243-5 5v9.756c12.012-1.321 23.537-2.065 35-2.232V85c0-2.757-2.243-5-5-5H65z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">숙소 예약</div>
                                            </a>
                                        </li>
                                    </c:if>
                                     <c:if test="${not empty user}">
                                    <!-- user 변수가 세션에 존재하는 경우 -->
                                    <li>
                                        <a href="/user/time_machine.do" aria-label="타임머신 " class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                            <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                <path d="M90.7 176.6C76.1 165 60 149.7 42.9 130.9C21.1 107.1 10 85.3 10 66c0-24.2 20-44.9 44.5-46c23.6-1 38.6 15.3 45.5 25.3c6.9-10 21.9-26.3 45.5-25.3C170 21.1 190 41.8 190 66c0 19.2-11.1 41.1-32.9 65c-17.7 19.4-33.4 34.3-47.8 45.7c-5.5 4.2-13.2 4.3-18.6-.1zM56.5 30C36.7 30 20 46.4 20 66c0 16.5 10.5 36.6 30.3 58.1c16.8 18.4 32.4 33.4 46.6 44.7c1.8 1.4 4.3 1.4 6.2 0c14-11 29.2-25.6 46.6-44.5c20.1-22 30.3-41.6 30.3-58.2c0-19-15.7-35.1-34.9-36c-26.7-1.2-40.4 26.9-40.6 27.2c-1.8 3.8-7.2 3.8-9 0c-.1-.4-13.5-27.3-39-27.3z"></path>
                                            </svg>
                                            <div class="dJtn-menu-item-title">타임 머신</div>
                                        </a>
                                    </li>
                                    </c:if>
                                     <c:if test="${empty user}">
                                    <!-- user 변수가 세션에 존재하지않는 경우 -->
                                    <li>
                                        <a onclick="login_alert()" aria-label="타임머신 " class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                            <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                <path d="M90.7 176.6C76.1 165 60 149.7 42.9 130.9C21.1 107.1 10 85.3 10 66c0-24.2 20-44.9 44.5-46c23.6-1 38.6 15.3 45.5 25.3c6.9-10 21.9-26.3 45.5-25.3C170 21.1 190 41.8 190 66c0 19.2-11.1 41.1-32.9 65c-17.7 19.4-33.4 34.3-47.8 45.7c-5.5 4.2-13.2 4.3-18.6-.1zM56.5 30C36.7 30 20 46.4 20 66c0 16.5 10.5 36.6 30.3 58.1c16.8 18.4 32.4 33.4 46.6 44.7c1.8 1.4 4.3 1.4 6.2 0c14-11 29.2-25.6 46.6-44.5c20.1-22 30.3-41.6 30.3-58.2c0-19-15.7-35.1-34.9-36c-26.7-1.2-40.4 26.9-40.6 27.2c-1.8 3.8-7.2 3.8-9 0c-.1-.4-13.5-27.3-39-27.3z"></path>
                                            </svg>
                                            <div class="dJtn-menu-item-title">타임 머신</div>
                                        </a>
                                    </li>
                                    </c:if>
                                    <c:if test="${not empty user}">
                                    <!-- user 변수가 세션에 존재하는 경우 -->
                                        <li>
                                            <a href="/course.do" aria-label="코스 추천" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                    <path d="M165 160h-10c-7.2 0-13.2-5.1-14.7-11.9c-26.8 2.5-53.9 2.5-80.6 0c-1.5 6.8-7.5 11.9-14.7 11.9H35c-8.3 0-15-6.7-15-15v-43.7c-2.1-.5-4.2-1-6.2-1.5c-2.7-.7-4.3-3.4-3.6-6.1c.7-2.7 3.4-4.3 6.1-3.6c1.6.4 3.2.8 4.7 1.1l12.4-37.7C34.9 49 39.2 45 44.7 44c30-5.3 80.7-5.3 110.6 0c5.5 1 9.8 4.9 11.4 9.7L179 91.4c1.6-.4 3.1-.8 4.7-1.2c2.7-.7 5.4.9 6.1 3.6c.7 2.7-.9 5.4-3.6 6.1c-2.1.5-4.2 1.1-6.3 1.6v43.6c.1 8.2-6.6 14.9-14.9 14.9zm-15-17.4v2.4c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5v-19.2c-11 1.6-26.2 3.5-34.6 4.2c-2.8.2-5.2-1.8-5.4-4.6c-.2-2.8 1.8-5.2 4.6-5.4c8.4-.7 24.6-2.8 35.4-4.3v-12.1c-43.8 8.7-94.9 8.7-140-.1v12.2c10.8 1.6 27 3.7 35.4 4.3c2.8.2 4.8 2.6 4.6 5.4c-.2 2.8-2.6 4.8-5.4 4.6c-8.4-.7-23.6-2.6-34.6-4.2V145c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5v-2.4c0-2.9 2.5-5.3 5.5-5c29.5 3.2 59.4 3.2 88.9 0c3.1-.3 5.6 2.1 5.6 5zM30.8 93.4c44.6 8.9 95.3 8.9 138.5.1l-12-36.7c-.6-1.6-2-2.7-3.6-3c-29-5.1-78.1-5.1-107.2 0c-1.7.3-3.1 1.4-3.6 3L30.8 93.4zm74.4-4c-2.4-1.4-3.2-4.4-1.9-6.8C107.7 74.8 116 70 125 70s17.1 4.7 21.6 12.5c1.4 2.4.6 5.4-1.8 6.8c-2.4 1.4-5.4.6-6.8-1.8c-2.7-4.7-7.6-7.5-13-7.5s-10.3 2.9-12.9 7.5c-1.4 2.4-4.5 3.2-6.9 1.9z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">코스 추천</div>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:if test="${empty user}">
<!--                                     user 변수가 세션에 존재하지 않는 경우 -->
                                        <li>
                                            <a href="/course.do" aria-label="코스 추천" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                                <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                                    <path d="M165 160h-10c-7.2 0-13.2-5.1-14.7-11.9c-26.8 2.5-53.9 2.5-80.6 0c-1.5 6.8-7.5 11.9-14.7 11.9H35c-8.3 0-15-6.7-15-15v-43.7c-2.1-.5-4.2-1-6.2-1.5c-2.7-.7-4.3-3.4-3.6-6.1c.7-2.7 3.4-4.3 6.1-3.6c1.6.4 3.2.8 4.7 1.1l12.4-37.7C34.9 49 39.2 45 44.7 44c30-5.3 80.7-5.3 110.6 0c5.5 1 9.8 4.9 11.4 9.7L179 91.4c1.6-.4 3.1-.8 4.7-1.2c2.7-.7 5.4.9 6.1 3.6c.7 2.7-.9 5.4-3.6 6.1c-2.1.5-4.2 1.1-6.3 1.6v43.6c.1 8.2-6.6 14.9-14.9 14.9zm-15-17.4v2.4c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5v-19.2c-11 1.6-26.2 3.5-34.6 4.2c-2.8.2-5.2-1.8-5.4-4.6c-.2-2.8 1.8-5.2 4.6-5.4c8.4-.7 24.6-2.8 35.4-4.3v-12.1c-43.8 8.7-94.9 8.7-140-.1v12.2c10.8 1.6 27 3.7 35.4 4.3c2.8.2 4.8 2.6 4.6 5.4c-.2 2.8-2.6 4.8-5.4 4.6c-8.4-.7-23.6-2.6-34.6-4.2V145c0 2.8 2.2 5 5 5h10c2.8 0 5-2.2 5-5v-2.4c0-2.9 2.5-5.3 5.5-5c29.5 3.2 59.4 3.2 88.9 0c3.1-.3 5.6 2.1 5.6 5zM30.8 93.4c44.6 8.9 95.3 8.9 138.5.1l-12-36.7c-.6-1.6-2-2.7-3.6-3c-29-5.1-78.1-5.1-107.2 0c-1.7.3-3.1 1.4-3.6 3L30.8 93.4zm74.4-4c-2.4-1.4-3.2-4.4-1.9-6.8C107.7 74.8 116 70 125 70s17.1 4.7 21.6 12.5c1.4 2.4.6 5.4-1.8 6.8c-2.4 1.4-5.4.6-6.8-1.8c-2.7-4.7-7.6-7.5-13-7.5s-10.3 2.9-12.9 7.5c-1.4 2.4-4.5 3.2-6.9 1.9z"></path>
                                                </svg>
                                                <div class="dJtn-menu-item-title">코스 추천</div>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </div>
                        <div class="pRB0-line"></div>
                        <div class="pRB0-nav-items">
                            <div>
                                <a href="/notice.do" aria-label="공지사항 " class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                    <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                        <path d="M20 165V45c0-8.3 6.7-15 15-15h130c8.3 0 15 6.7 15 15v80c0 8.3-6.7 15-15 15H75c-23.3 0-33.9 13.5-46.2 28.2c-3 3.6-8.8 1.5-8.8-3.2zM35 40c-2.8 0-5 2.2-5 5v106.4c9.8-10.9 22.8-21.4 45-21.4h90c2.8 0 5-2.2 5-5V45c0-2.8-2.2-5-5-5H35zm110 70c-3.8 0-7.3-1.4-10-3.8c-2.7 2.4-6.2 3.8-10 3.8c-2.8 0-5-2.2-5-5s2.2-5 5-5s5-2.2 5-5V75c0-2.8-2.2-5-5-5s-5-2.2-5-5s2.2-5 5-5c3.8 0 7.3 1.4 10 3.8c2.7-2.4 6.2-3.8 10-3.8c2.8 0 5 2.2 5 5s-2.2 5-5 5s-5 2.2-5 5v20c0 2.8 2.2 5 5 5s5 2.2 5 5s-2.2 5-5 5zm-50 0H55c-2.8 0-5-2.2-5-5s2.2-5 5-5h40c2.8 0 5 2.2 5 5s-2.2 5-5 5zm0-20H55c-2.8 0-5-2.2-5-5s2.2-5 5-5h40c2.8 0 5 2.2 5 5s-2.2 5-5 5zm0-20H55c-2.8 0-5-2.2-5-5s2.2-5 5-5h40c2.8 0 5 2.2 5 5s-2.2 5-5 5z"></path>
                                    </svg>
                                    <div class="dJtn-menu-item-title">공지 사항</div>
                                </a>
                            </div>
                        </div>
                        <div class="pRB0-line"></div>
                        <div class="pRB0-nav-items">
                            <div>
                                <a data-bs-toggle="modal" data-bs-target="#exampleModal" aria-label="이용 안내" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
                                    <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="dJtn-menu-item-icon" role="img" aria-hidden="true">
                                        <path d="M140.448 177.069l-19.846-43.661c-2.877-6.328-7.998-11.612-12.447-14.676a1029.409 1029.409 0 0 1-14.935 12.983c-4.045 3.618-5.452 9.494-3.67 15.347l2.733 8.981a4.997 4.997 0 0 1-1.248 4.991l-10 10c-2.267 2.268-6.043 1.838-7.754-.851l-14.154-22.241l-10.592 10.592a5 5 0 1 1-7.071-7.07l10.593-10.593l-22.242-14.153c-2.695-1.716-3.112-5.493-.851-7.754l10-10a5 5 0 0 1 4.992-1.248l8.981 2.733c5.85 1.777 11.728.375 15.348-3.671c4.269-5.007 8.599-9.988 12.983-14.935c-3.063-4.449-8.349-9.571-14.676-12.447L22.931 59.552c-3.563-1.619-3.965-6.539-.705-8.712l11.53-7.687a15.083 15.083 0 0 1 11.333-2.213l60.319 12.364c6.006 1.33 14.836-3.512 20.984-9.246c6.775-6.625 13.831-12.567 25.684-17.738c5.899-2.573 12.876-1.07 17.773 3.828l.003.002c4.898 4.897 6.401 11.874 3.828 17.773c-5.171 11.853-11.111 18.909-17.735 25.682c-5.736 6.148-10.583 14.976-9.266 20.906l12.382 60.4a15.1 15.1 0 0 1-2.215 11.332l-7.687 11.53c-2.182 3.276-7.096 2.849-8.711-.704zm-24.66-65.169c5.789 4.467 10.925 10.784 13.918 17.369l16.123 35.472l2.697-4.045a5.034 5.034 0 0 0 .738-3.778L136.9 96.6a19.235 19.235 0 0 1-.445-3.891a1041.686 1041.686 0 0 1-20.667 19.191zm-49.416 28.799l12 18.857l3.471-3.471l-1.86-6.111c-2.938-9.652-.396-19.525 6.631-25.767l.077-.066c23.665-20.174 47.419-42.531 62.016-57.438c6.149-6.558 10.969-11.688 15.808-22.779c1.113-2.552-.165-5.136-1.733-6.703l-.003-.002c-1.567-1.568-4.151-2.846-6.704-1.734c-10.394 4.535-15.439 8.933-22.782 15.811c-15.335 15.027-37.539 38.676-57.433 62.013l-.067.076c-6.242 7.028-16.115 9.567-25.767 6.631l-6.111-1.859l-3.471 3.471l18.858 12l7.164-7.163a5 5 0 1 1 7.071 7.07l-7.165 7.164zM35.258 54.17l35.471 16.124c6.585 2.993 12.903 8.128 17.37 13.918a1045.845 1045.845 0 0 1 19.202-20.678a19.358 19.358 0 0 1-3.982-.452L43.081 50.735a5.039 5.039 0 0 0-3.778.738l-4.045 2.697z"></path>
                                    </svg>
                                    <div class="dJtn-menu-item-title">이용 안내</div>
                                </a>
                            </div>
                        </div>
                        <div class="pRB0-line"></div>
                        <div class="pRB0-nav-items">
                            <div>
                                <div id="chatbot" aria-label="챗봇" class="dJtn dJtn-collapsed dJtn-mod-variant-drawer" aria-current="false" tabindex="-1">
									<svg xmlns="http://www.w3.org/2000/svg" width="36px" height="36px" fill="currentColor" class="bi bi-chat-dots dJtn-menu-item-icon" viewBox="0 0 16 16">
									  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
									  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2z"/>
									</svg>
						            <div class="dJtn-menu-item-title">챗봇</div>
                                </div>
                            </div>
                        </div>
                        <div class="pRB0-line"></div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div role="presentation" aria-modal="true" aria-expanded="true" tabindex="0" class="ui-dialog-Popover js-popover mod-layer-default none" style="position: fixed; transform: translate(-12px, 70px); top: 0px; right: 0px;">
        <div class="xvRy xvRy-mod-radius-default xvRy-mod-animated xvRy-visible" style="width: 250px; height: 173px;">
            <div role="tab" tabindex="0" aria-hidden="true" style="opacity: 0; height: 0px; width: 0px;"></div>
            <div class="xvRy-content">
                <div class="c4Nhy c4Nhy-mod-dropdown">
                    <a class="XeSA" data-bs-toggle="modal" data-bs-target="#exampleModal" aria-labelledby="help-menu-item-label" role="menuitem" tabindex="0">
                        <div id="help-menu-item-label" class="XeSA-item-label">이용안내</div>
                    </a>
                    <a class="XeSA" href="/user/mypage.do" aria-labelledby="account-menu-item-label" role="menuitem" tabindex="0">
                        <div id="account-menu-item-label" class="XeSA-item-label">내 계정</div>
                    </a>
                    <div class="c4Nhy-logout">
                        <div class="c4Nhy-button-wrapper">
                            <button role="button" class="Iqt3 Iqt3-mod-stretch Iqt3-mod-bold Button-No-Standard-Style Iqt3-mod-variant-outline Iqt3-mod-theme-none Iqt3-mod-shape-rounded-small Iqt3-mod-shape-mod-default Iqt3-mod-spacing-default Iqt3-mod-size-default" tabindex="0" aria-disabled="false">
                                <div class="Iqt3-button-container">
                                    <a href="/logout" class="Iqt3-button-content">로그아웃</a>
                                </div>
                                <div class="Iqt3-button-focus-outline"></div>
                            </button>
                        </div>
                    </div>
                </div>
                <div role="tab" tabindex="0" aria-hidden="true" style="opacity: 0; height: 0px; width: 0px;"></div>
            </div>
        </div>
    </div>
    
    <!-- 모달 -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    	<div class="modal-dialog modal-xl modal-dialog-centered">
        	<div class="modal-content">
            	<div class="modal-header">
            	<h5 class="modal-title">이용안내</h5>
                	<!-- 닫기 버튼 -->
                	<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            	</div>
            	<div class="modal-body p-0">
                	<!-- 이미지 슬라이드 -->
                	<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-bs-ride="carousel">
                		<!-- 인디케이터 -->
  						<div class="carousel-indicators">
    					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
    					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
    					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
  					</div>
  					
                    	<div class="carousel-inner">
                        	<div class="carousel-item active" data-bs-interval="4000">
                            	<img src="../img/tt이용안내1.jpg" alt="Los Angeles" class="d-block" style="width: 100%">
                        	</div>
                        	<div class="carousel-item" data-bs-interval="4000">
                            	<img src="../img/tt이용안내2.jpg" alt="Chicago" class="d-block" style="width: 100%">
                        	</div>
                        	<div class="carousel-item" data-bs-interval="4000">
                            	<img src="../img/tt이용안내3.jpg" alt="Los Angeles" class="d-block" style="width: 100%">
                        	</div>
                        	<!-- 추가 이미지 -->
                    	</div>
                    
                    	<!-- Left and right controls/icons -->
						<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
    						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    						<span class="visually-hidden">Previous</span>
  						</button>
  						
  						<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
    						<span class="carousel-control-next-icon" aria-hidden="true"></span>
    						<span class="visually-hidden">Next</span>
  						</button>
                	</div>
            	</div>
        	</div>
    	</div>
	</div>
	
	
	
</div>
<div id="root" class="z-50">
    <div aria-hidden="false" class="YSUE YSUE-mod-animate YSUE-mod-layer-default YSUE-mod-position-fixed">
        <div class="YSUE-background YSUE-mod-variant-default"></div>
        <div role="dialog" aria-modal="true" class="dDYU dDYU-mod-theme-default dDYU-mod-variant-header-search-form-v3 dDYU-mod-padding-none dDYU-mod-position-top dDYU-mod-direction-none  dDYU-mod-animate dDYU-mod-visible a11y-focus-outlines dDYU-mod-shadow-elevation-one">
            <div class="dDYU-viewport">
                <div class="dDYU-content">
                    <div class="dDYU-body">
                        <div tabindex="-1" id="searchFormDialog" class="c1r2d c1r2d-mod-vertical-hotels c1r2d-pres-animated c1r2d-mod-primary-colors">
                            <section class="c1r2d-header-section">
                                <div class="ui-layout-HeaderMainLogo normal-from-l-size main-logo--mobile">
                                    <a class="main-logo__link" href="/" itemprop="https://schema.org/logo" aria-label="호텔스컴바인 홈페이지로 이동하기">
                                        <div class="main-logo__logo has-compact-logo inverted-logo">
                                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                                                <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 20px; display: inline-block;" />
                                                <img src="../img/Logo.png" alt="로고" style="height: 14px; display: inline-block;" />
                                            </span>
                                            <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image-compact">
                                                <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 20px; display: inline-block;" />
                                            </span>
                                        </div>
                                    </a>
                                </div>
                            </section>
                            <section class="c1r2d-form-section">
                                <form onsubmit="initializeMap(); return false;">
                                    <div class="J_T2">
                                        <div class="J_T2-header"></div>
                                        <div class="J_T2-row J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall">
                                            <div class="J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall J_T2-mod-grow relative">
                                                <div class="pM26">
                                                    <div role="button" tabindex="-1" class="puNl puNl-mod-cursor-inherit puNl-mod-font-size-base puNl-mod-radius-base puNl-mod-corner-radius-all puNl-mod-size-large puNl-mod-spacing-default puNl-mod-state-default puNl-mod-text-overflow-ellipsis puNl-mod-theme-search puNl-mod-validation-state-neutral puNl-mod-validation-style-border">
                                                        <div role="img" class="TWls TWls-mod-size-large TWls-mod-variant-prefix">
                                                            <svg viewBox="0 0 200 200" width="20" height="20" xmlns="http://www.w3.org/2000/svg" role="img">
                                                                <path d="M175 170a5 5 0 0 1-5-5v-5H30v5a5 5 0 1 1-10 0v-43.092c0-8.176 3.859-15.462 10-20.027V65c0-13.785 11.215-25 25-25h90c13.785 0 25 11.215 25 25v36.98c6.093 4.613 10 11.922 10 19.928V165a5 5 0 0 1-5 5zM30 150h140v-10H30v10zm0-20h140v-8.092c0-7.342-5.486-13.707-12.762-14.806c-40.216-6.077-73.399-6.207-114.477 0C35.415 108.21 30 114.4 30 121.908V130zm120-34.027c2.877.382 9.581 1.381 10 1.467V65c0-8.271-6.729-15-15-15H55c-8.271 0-15 6.729-15 15v32.438c.418-.084 7.123-1.083 10-1.465V85c0-8.271 6.729-15 15-15h25a14.94 14.94 0 0 1 10 3.829A14.943 14.943 0 0 1 110 70h25c8.271 0 15 6.729 15 15v10.973zm-45-3.45c11.463.167 22.988.912 35 2.233V85c0-2.757-2.243-5-5-5h-25c-2.757 0-5 2.243-5 5v7.523zM65 80c-2.757 0-5 2.243-5 5v9.756c12.012-1.321 23.537-2.065 35-2.232V85c0-2.757-2.243-5-5-5H65z"></path>
                                                            </svg>
                                                        </div>
                                                        <span class="sidoValues NhpT NhpT-mod-radius-base NhpT-mod-corner-radius-all NhpT-mod-size-large NhpT-mod-state-default NhpT-mod-text-overflow-ellipsis NhpT-mod-theme-search NhpT-mod-validation-state-neutral NhpT-mod-validation-style-border" type="text" tabindex="0" placeholder="도시 지역을 선택해주세요." aria-autocomplete="list" aria-haspopup="listbox"></span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall J_T2-mod-grow">
                                                <div>
                                                    <div class="cBaN">
                                                        <div class="cBaN-date-select-wrapper">
                                                            <div class="jZyL">
                                                                <div role="button" tabindex="0" class="JONo-button" aria-label="시작 날짜">
                                                                    <svg viewBox="0 0 200 200" width="1.25em" height="1.25em" xmlns="http://www.w3.org/2000/svg" class="JONo-icon" role="img">
                                                                        <path d="M165 180H35c-8.3 0-15-6.7-15-15V35c0-8.3 6.7-15 15-15h25v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h60v-5c0-2.8 2.2-5 5-5s5 2.2 5 5v5h25c8.3 0 15 6.7 15 15v130c0 8.3-6.7 15-15 15zM30 60v105c0 2.8 2.2 5 5 5h130c2.8 0 5-2.2 5-5V60H30zm0-10h140V35c0-2.8-2.2-5-5-5h-25v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H70v5c0 2.8-2.2 5-5 5s-5-2.2-5-5v-5H35c-2.8 0-5 2.2-5 5v15zm75 100c-2.8 0-5-2.2-5-5V97.1l-11.5 11.5c-2 2-5.1 2-7.1 0s-2-5.1 0-7.1l20-20c1.4-1.4 3.6-1.9 5.4-1.1c1.9.8 3.1 2.6 3.1 4.6v60c.1 2.8-2.1 5-4.9 5z"></path>
                                                                    </svg>
                                                                    <button class="btn btn-light trvl_day" style="background-color: #f0f2f5; border: none !important; flex:1;"><span class="ml-2"></span></button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="personnel J_T2-field-group J_T2-mod-collapse-l J_T2-mod-spacing-y-xxsmall">
                                                <div>
                                                    <div class="c3JX7-wrapper">
                                                        <button role="button" class="RxNS RxNS-mod-stretch RxNS-mod-variant-none RxNS-mod-theme-none RxNS-mod-shape-default RxNS-mod-spacing-none RxNS-mod-size-xlarge" tabindex="0" aria-disabled="false">
                                                            <div class="RxNS-button-container">
                                                                <div class="RxNS-button-content">
                                                                    <div class="c3JX7-displayContent">
                                                                        <span class="c3JX7-userIcon">
                                                                            <svg viewBox="0 0 200 200" width="20" height="20" xmlns="http://www.w3.org/2000/svg" role="img">
                                                                                <path d="M160.6 180H39.4c-1.6 0-3.2-.8-4.1-2.1c-8-11.5-6.8-32.8 2.2-41.5c3.9-3.8 23.8-10.5 35.6-14C58.8 108.1 50 95.4 50 70.9C50 38.6 68.2 20 100 20s50 18.6 50 50.9c0 23.8-8.2 36.7-23.1 51.5c11.8 3.5 31.6 10.2 35.6 14c9.1 8.7 10.3 30 2.3 41.5c-1 1.3-2.6 2.1-4.2 2.1zM42.3 170h115.5c4-8.3 2.4-21.8-2.1-26.3c-3.6-2.8-31.2-12.1-38.9-13.8c-3.5-.8-5.1-4.9-3-7.8c7.9-10.8 26.3-19.2 26.3-51.2c0-18.7-6.9-40.9-40-40.9S60 52.2 60 70.9c0 31.9 18.4 40.3 26.3 51.2c2.1 2.9.5 7.1-3 7.8c-7.7 1.6-35.3 10.9-38.9 13.7c-4.6 4.5-6.1 18.1-2.1 26.4zm2.2-26.4z"></path>
                                                                            </svg>
                                                                        </span>
                                                                        <span class="c3JX7-displayText">인원 2명</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                            <span class="QdG_" >
                                                <span class="x_pP">
                                                    <button onclick="searchDosi()" role="button" class="RxNS RxNS-mod-stretch RxNS-mod-animation-search RxNS-mod-variant-solid RxNS-mod-theme-base RxNS-mod-shape-default RxNS-mod-spacing-base RxNS-mod-size-xlarge" tabindex="0" aria-disabled="false" title="" type="submit" aria-label="검색" style="background-color: #fff; color: #444;">
                                                        <div class="RxNS-button-container">
                                                            <div class="RxNS-button-content">
                                                                <div class="a7Uc">
                                                                    <div class="a7Uc-infix">
                                                                        <svg viewBox="0 0 200 200" width="24" height="24" xmlns="http://www.w3.org/2000/svg" class="A_8a-icon" role="img">
                                                                            <path d="M178.5 171.5l-44.2-44.2c9.8-11.4 15.7-26.1 15.7-42.3c0-35.8-29.2-65-65-65S20 49.2 20 85s29.2 65 65 65c16.1 0 30.9-5.9 42.3-15.7l44.2 44.2c2 2 5.1 2 7.1 0c1.9-1.9 1.9-5.1-.1-7zM30 85c0-30.3 24.7-55 55-55s55 24.7 55 55s-24.7 55-55 55s-55-24.7-55-55z"></path>
                                                                        </svg>
                                                                    </div>
                                                                    <div class="a7Uc-suffix">
                                                                        <span class="A_8a-label">검색</span>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </button>
                                                </span>
                                            </span>
                                        </div>
                                        <div class="J_T2-footer">
                                            <div class="OJEY-cmp2-wrapper">
                                                <div>

                                                </div>
                                            </div>
                                            <div class="c1ClF relative">
                                                <div class="Loading" style="display: none; width: 491px; padding: 20px; z-index: 51; position: absolute; height: 100px; top: -19px; left: 0px; border-radius: 8px; background-color: #fbfcfd;">
                                                    <img src="../img/Loading.gif" alt="Loading" style="display: flex; width: 60px; margin: auto; align-items: center; justify-content: center;" />
                                                </div>
                                                <div class="sidoModal" style="display: none; width: 491px; overflow-y: auto; padding: 20px; z-index: 51; position: absolute; height: 500px; top: -19px; left: 0px; border-radius: 8px; background-color: #fbfcfd; color: #444;">
                                                    <form action="" name="region" id="region" class="flex" style="display: block;">
                                                    <input type="hidden" name="dosi" id="dosi" value="">
                                                        <div id="sido">
                                                            <c:forEach var="dosi" items="${listDosi}">
                                                                <div id="${dosi}" class="dosi">${dosi}</div>
                                                            </c:forEach>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="headCountModal" style="display: none; width: 491px; overflow-y: auto; padding: 20px; z-index: 51; position: absolute; height: 500px; top: -19px; left: 0px; border-radius: 8px; background-color: #fbfcfd; color: #444;">
                                                    <div id="headCountSelectBox">
                                                    	<div>1 명</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
        