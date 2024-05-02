<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:import url="com.example.triptable.entity.User" />
<c:set var="user" value="${sessionScope.user}" />
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
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Core theme CSS (includes Bootstrap)-->
         <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
    </head>
    <body id="index" class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
            <div class="bg-write py-5">
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                            <div class="my-5 text-center text-xl-start">
                                <h5 class="display-7 fw-bolder text-black-30 mb-2">함께하는 여행 ,</h5>
                                <h1 class="display-4 fw-bolder text-black mb-2">플래너와 함께!</h1>
                                <p class="lead fw-normal text-black-50 mb-4">지금까지의 여행 계획을 친구들과 함께 나눠보세요.<br>새로운 모험과 추억이 기다리고 있습니다.</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                                    <a href="/trip_plan.do"><button class="btn btn-primary btn-lg px-4 me-sm-3" >여행 시작하기!</button></a>
                                    <!--<a class="btn btn-outline-light btn-lg px-4" href="#!">Learn More</a>-->
                                    <!--<a class="btn btn-outline-light btn-lg px-4" href="#!">Learn More</a>-->
                                </div>
                            </div>
                        </div>
                          <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center" style="overflow:hidden; height:760px; position: relative;">
                        
                           <%@ include file="../koreamap.jsp" %>
                           
<!--                            <img class="img-fluid rounded-3 my-5" src="https://dummyimage.com/600x400/343a40/6c757d" alt="..." /> -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blog preview section-->
            <section class="py-5">
                <div class="container px-5 my-5">
                    <div class="row gx-5 justify-content-center">
                        <div class="col-lg-8 col-xl-6">
                            <div class="text-center">
                                <h5 class="fw-bolder">최고의 추억 ,</h5>
                                <h2 class="fw-bolder">우리와 함께하는 여행 코스</h2>
                                <p class="lead fw-normal text-muted mb-5">이 여행 코스는 단순한 관광이 아닌, 우리만의 특별한 순간들을 담아냅니다. 함께한 순간들은 마치 시간을 멈추게 하듯 특별하고 소중한 기억들이 될 것입니다.</p>
                            </div>
                        </div>
                    </div>
                      	
                    <!-- 추천코스 삽입내용 -->
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src= "${courseRecommendation1.courseimage}" alt="..." />
                                <div class="card-body p-4">
                                	<div class="flex gap-2 justify-content-between items-center">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">${courseRecommendation1.coursedest}</div>
                                    <p>${courseRecommendation1.coursedis}</p>
                                    </div>                    
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">${courseRecommendation1.coursename}</h5></a>
                                    <p class="card-text mb-0">${courseRecommendation1.coursesum}</p> 
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Minii Cho</div>
                                                <div class="text-muted">March 12, 2023 &middot; 6 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="${courseRecommendation2.courseimage}" alt="..." />
                                <div class="card-body p-4">
                                <div class="flex gap-2 justify-content-between items-center">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">${courseRecommendation2.coursedest}</div>
                                     <p>${courseRecommendation2.coursedis}</p>
                                    </div>    
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">${courseRecommendation2.coursename}</h5></a>
                                    <p class="card-text mb-0">${courseRecommendation2.coursesum}</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Sora Yeo</div>
                                                <div class="text-muted">March 23, 2023 &middot; 4 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="col-lg-4 mb-5">
                            <div class="card h-100 shadow border-0">
                                <img class="card-img-top" src="${courseRecommendation3.courseimage}" alt="..." />
                                <div class="card-body p-4">
                                 <div class="flex gap-2 justify-content-between items-center">
                                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">${courseRecommendation3.coursedest}</div>
                                   	<p>${courseRecommendation3.coursedis}</p>
                                    </div>    
                                    <a class="text-decoration-none link-dark stretched-link" href="#!"><h5 class="card-title mb-3">${courseRecommendation3.coursename}</h5></a>
                                    <p class="card-text mb-0">${courseRecommendation3.coursesum}</p>
                                </div>
                                <div class="card-footer p-4 pt-0 bg-transparent border-top-0">
                                    <div class="d-flex align-items-end justify-content-between">
                                        <div class="d-flex align-items-center">
                                            <img class="rounded-circle me-3" src="https://dummyimage.com/40x40/ced4da/6c757d" alt="..." />
                                            <div class="small">
                                                <div class="fw-bold">Subin Son</div>
                                                <div class="text-muted">April 2, 2023 &middot; 10 min read</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </section>
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
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>