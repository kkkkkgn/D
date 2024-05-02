<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="com.example.triptable.entity.User" %>
<%@ page import ="com.example.triptable.entity.Team" %>
<%@ page import ="java.util.List" %>
<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();

List<Team> teamlist = (List<Team>)request.getAttribute("teamlist");

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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/font.css" rel="stylesheet" />
        <link href="css/dong.css" rel="stylesheet" />
        <style>

            .card {
                margin-bottom: 30px;
                border: none;
                border-radius: 5px;
                box-shadow: 0px 3px 5px rgba(1, 41, 112, 0.1);
            }
            .card-body {
                padding: 0 30px 30px 30px;
                
            }
            
            #container {
          display: flex;
          align-items: center;
          justify-content: center;
          flex:1;
          flex-direction: column;
        }
        </style>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
        <!-- ===== Main ===== -->
        <!-- ====== 프로필 ====== -->
        <section class="section profile">
            <div class="card">
                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                
                    <h3 style=" margin-top: 20px; color: #6e6e6e; font-family: 'Jalnan';"><i class="bi bi-clock"></i>타임머신<i class="bi bi-clock"></i></h3>
                </div>
            </div>
            <section class="section profile">
    <!-- ======= mypage Section ======= -->
         
            <div class="p-5 py-4 pb-5 border shadow">
        <div class="w-100">

          <div class="card mt-3" id="userLogin">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">진행중인 여행</button>
              <button type="button" class="btn btn-type adminBtn">다녀온 여행</button>
            </div>
            <div class="card-body">
              <form>
                <div class="form-group">
                <br/>
                <div class="row gx-5">
                <!-- 진행중인 여행 계획 블럭 -->
                <c:forEach var="team" items="${teamlist}">
                  <div class="col-lg-4 mb-5">
                        <div class="card h-80 shadow border-0" onclick="saveTeamToSession(${team.id})">
                            <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                            <div class="card-body p-4">
                				<div class="badge bg-primary bg-gradient rounded-pill mb-2">${team.destination}</div>
                				<div class="h5 card-title mb-3">${team.name}</div>
                				<div class="text-muted">${team.travlestart} ~ ${team.travleend}</div>
           				 </div>
                        </div>
                    </div>
            </c:forEach>  
              
            <!-- teamID넘기는 ajax -->  
              <script>
              function saveTeamToSession(id){
                $.ajax({
            url: '/team_session.do',
            data: {
                team_id : id
            
            },
            type: 'get',
            success: function(result) {                
                console.log('전송 성공');
                window.location.href='trip_plan.do';

            },
            error:function() {
               console.log('전송 실패');
            }
        });  	
              }
                </script> 
                  </div>
                </div>
              </form>
            </div>
          </div>
    
    
    
          <div class="card mt-3" id="adminLogin" style="display: none;">
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">진행중인 여행</button>
              <button type="button" class="btn btn-type adminBtn">다녀온 여행</button>
            </div>
            <div class="card-body">
              <!-- 다녀온 여행 블럭 -->
              <br />
              <div class="row gx-5">
                    <div class="col-lg-4 mb-5">
                        <div class="card h-80 shadow border-0">
                            <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a>
                                <div class="text-muted">April 2, 2023 &middot;</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-5">
                        <div class="card h-80 shadow border-0">
                            <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a>
                                <div class="text-muted">April 2, 2023</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 mb-5">
                        <div class="card h-80 shadow border-0">
                            <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." />
                            <div class="card-body p-4">
                                <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div>
                                <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a>
                                <div class="text-muted">April 2, 2023</div>
                            </div>
                        </div>
                    </div>
                  </div>
            </div>
          </div>

        </div>
      </div>
<!--                 <div class="row gx-5"> -->
<!--                     <div class="col-lg-4 mb-5"> -->
<!--                         <div class="card h-80 shadow border-0"> -->
<!--                             <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." /> -->
<!--                             <div class="card-body p-4"> -->
<!--                                 <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div> -->
<!--                                 <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a> -->
<!--                                 <div class="text-muted">April 2, 2023 &middot;</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4 mb-5"> -->
<!--                         <div class="card h-80 shadow border-0"> -->
<!--                             <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." /> -->
<!--                             <div class="card-body p-4"> -->
<!--                                 <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div> -->
<!--                                 <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a> -->
<!--                                 <div class="text-muted">April 2, 2023</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4 mb-5"> -->
<!--                         <div class="card h-80 shadow border-0"> -->
<!--                             <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." /> -->
<!--                             <div class="card-body p-4"> -->
<!--                                 <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div> -->
<!--                                 <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a> -->
<!--                                 <div class="text-muted">April 2, 2023</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4 mb-5"> -->
<!--                         <div class="card h-80 shadow border-0"> -->
<!--                             <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." /> -->
<!--                             <div class="card-body p-4"> -->
<!--                                 <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div> -->
<!--                                 <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a> -->
<!--                                 <div class="text-muted">April 2, 2023</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                     <div class="col-lg-4 mb-5"> -->
<!--                         <div class="card h-80 shadow border-0"> -->
<!--                             <img class="card-img-top" src="https://dummyimage.com/600x350/adb5bd/495057" alt="..." /> -->
<!--                             <div class="card-body p-4"> -->
<!--                                 <div class="badge bg-primary bg-gradient rounded-pill mb-2">News</div> -->
<!--                                 <a class="text-decoration-none link-dark stretched-link" href="#!"><div class="h5 card-title mb-3">민희와 함께하는 여행</div></a> -->
<!--                                 <div class="text-muted">April 2, 2023</div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                     </div> -->
<!--                 </div> -->
                
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
        <script src="js/scripts.js"></script>
    </body>
</html>