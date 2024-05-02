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
        <link rel="icon" type="image/x-icon" href="../img/LogoRaccoon.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
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
			.tripBlock img {
				min-width: 350px;
				height: 250px;
				display: block;
				background-size: contain;
			}
			.form-group div div div .card-body {
				height: 170px;
			}
			.card {
				cursor: pointer;
			}
            
            #container {
				display: flex;
				align-items: start;
				justify-content: start;
				flex:1;
				flex-direction: column;
			}
        </style>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main" style="max-width: 100%; margin: 0;">
        <!-- ===== Main ===== -->
        <!-- ====== 프로필 ====== -->
        <section class="section profile">
           <div class="card" >
			    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
			        <span class="icon-ufo" style="margin-right: 10px !important; vertical-align: middle !important; display: inline-block !important;">
			            <img src="../img/ufo.png" alt="UFO" class="small-ufo" style="width: 50px !important; height: auto !important; ">
			        </span>
			        <h3 style="margin-top: 20px; color: #6e6e6e; font-family: 'Dovemayo_gothic';">타임머신</h3>  
			    </div>
			</div>
            <section class="section profile">
    <!-- ======= mypage Section ======= -->
         
            <div class="py-4 pb-5 border shadow" style="padding: 150px;" >
        <div class="w-100" >

          <div class="card mt-3" id="userLogin" >
            <div class="btn-group w-100" role="group" aria-label="User Type">
              <button type="button" class="btn btn-type active userBtn">진행중인 여행</button>
              <button type="button" class="btn btn-type adminBtn">다녀온 여행</button>
            </div>
            <div class="card-body tripBlock" style="min-height: 750px;">
              <form>
                <div class="form-group" style="margin-top: 30px ">
                <br/>
                <div class="gx-5 justify-start align-items-center" style="display: flex; flex-wrap: wrap; gap: 30px; max-width: 1300px; margin: 0 auto; justify-content: start;">
                <!-- 진행중인 여행 계획 블럭 -->
                <c:forEach var="team" items="${activeTeamList}">
    				<div class="mb-5 relative" style="width: 400px;">
						<button type="button" class="btn-close" style="position: absolute; top: 12px; right: 12px; z-index: 1;  background-color: #e6e6e6; color: #FFF;"></button>
        				<div class="card h-80 shadow border-0" onclick="saveTeamToSession('${team.id}')">
            				<img class="card-img-top team-image" id="destinationImage_${team.id}"  style="width: 400px; display: block; height: 250px;"/>
            				<div class="card-body  p-4">
                				<div class="badge bg-primary bg-gradient rounded-pill mb-2">${team.destination}</div>
                				<div class="h5 card-title mb-3">${team.name}</div>
                				<div class="text-muted">${team.travlestart} ~ ${team.travleend}</div>
            				</div>
        				</div>
    				</div>

    				<script>
        				// 이미지 경로 설정
        				document.addEventListener('DOMContentLoaded', function() {
            				const destination = '${team.destination}';
            				const destinationImage = document.getElementById('destinationImage_${team.id}');
            
            				// 서울특별시인 경우에만 이미지 설정
            				if (destination === '서울특별시') {
                				destinationImage.setAttribute('src', 'https://t1.daumcdn.net/cfile/tistory/252FA9345225669928'); 
                				destinationImage.setAttribute('alt', '서울특별시 이미지');
            				} else if (destination === '부산광역시') {
                				destinationImage.setAttribute('src', 'https://www.kkday.com/ko/blog/wp-content/uploads/busan_tower_1.jpg'); 
                				destinationImage.setAttribute('alt', '부산광역시 이미지');
            				} else if (destination === '대구광역시') {
                				destinationImage.setAttribute('src', 'https://img.sbs.co.kr/newimg/news/20170623/201061716_700.jpg');
                				destinationImage.setAttribute('alt', '대구광역시 이미지');
            				} else if (destination === '인천광역시') {
                				destinationImage.setAttribute('src', 'https://img.khan.co.kr/news/2018/07/02/l_2018070201000159300013515.jpg'); 
                				destinationImage.setAttribute('alt', '인천광역시 이미지');
            				} else if (destination === '광주광역시') {
                				destinationImage.setAttribute('src', 'https://t1.daumcdn.net/cfile/tistory/9974613B5AC2DC4A1C'); 
                				destinationImage.setAttribute('alt', '광주광역시 이미지');
            				} else if (destination === '대전광역시') {
                				destinationImage.setAttribute('src', 'https://a.cdn-hotels.com/gdcs/production185/d1535/aec497d4-8632-4f54-8f11-af3dd8516ae8.jpg'); 
                				destinationImage.setAttribute('alt', '대전광역시 이미지');
            				} else if (destination === '울산광역시') {
                				destinationImage.setAttribute('src', 'https://a.cdn-hotels.com/gdcs/production161/d694/7bf49a46-c729-4446-9240-19a3d984815b.jpg'); 
                				destinationImage.setAttribute('alt', '울산광역시 이미지');
            				} else if (destination === '세종특별자치시') {
                				destinationImage.setAttribute('src', 'https://img.newspim.com/news/2020/10/15/2010151646296730.jpg'); 
                				destinationImage.setAttribute('alt', '세종특별자치시 이미지');
            				} else if (destination === '경기도') {
                				destinationImage.setAttribute('src', 'https://d2ur7st6jjikze.cloudfront.net/offer_photos/116208/630901_medium_1653633931.jpg?1653633931'); 
                				destinationImage.setAttribute('alt', '경기도 이미지');
            				} else if (destination === '강원도') {
                				destinationImage.setAttribute('src', 'https://www.ttlnews.com/upload/editor_content_images/1558423014204_editor_image.jpg'); 
                				destinationImage.setAttribute('alt', '강원도 이미지');
            				} else if (destination === '충청북도') {
                				destinationImage.setAttribute('src', 'https://res.klook.com/image/upload/fl_lossy.progressive,w_800,c_fill,q_85/Mobile/City/ymsocf8x4eaqvamikwah.jpg'); 
                				destinationImage.setAttribute('alt', '충청북도 이미지');
            				} else if (destination === '충청남도') {
                				destinationImage.setAttribute('src', 'https://res.klook.com/image/upload/fl_lossy.progressive,w_800,c_fill,q_85/Mobile/City/ymsocf8x4eaqvamikwah.jpg'); 
                				destinationImage.setAttribute('alt', '충청남도 이미지');
            				}else if (destination === '전라북도') {
                				destinationImage.setAttribute('src', 'https://image.kkday.com/v2/image/get/s1.kkday.com/product_12339/20170704084013_TfXFI/jpg'); 
                				destinationImage.setAttribute('alt', '전라북도 이미지');
            				}else if (destination === '전라남도') {
                				destinationImage.setAttribute('src', 'https://cdn.gjdream.com/news/photo/202101/605746_205436_2217.jpg'); 
                				destinationImage.setAttribute('alt', '전라남도 이미지');
            				}else if (destination === '경상북도') {
                				destinationImage.setAttribute('src', 'https://cdn.balpumnews.com/news/photo/202312/2651_14165_3725.jpg'); 
                				destinationImage.setAttribute('alt', '경상북도 이미지');
            				}else if (destination === '경상남도') {
                				destinationImage.setAttribute('src', 'https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=63b6ff8a-7ea9-4df1-a4e6-0a60bf8912d9'); 
                				destinationImage.setAttribute('alt', '경상남도 이미지');
            				}else if (destination === '제주특별자치도') {
                				destinationImage.setAttribute('src', 'https://res.klook.com/image/upload/fl_lossy.progressive,w_800,c_fill,q_85/Mobile/City/nsejkwbumyk3cc5oep61.jpg'); 
                				destinationImage.setAttribute('alt', '제주특별자치도 이미지');
            				}
        				});
    			 	</script>
				</c:forEach>
              
              
              
              
            <!-- teamID넘기는 ajax -->  
              <script>
              function saveTeamToSession(id){
                $.ajax({
		            url: '/user/team_session.do',
		            data: {
		                team_id : id
		            
		            },
		            type: 'POST',
		            success: function(result) {                

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
            <div class="card-body tripBlock" style="min-height: 750px; margin-top: 30px">
            <br />
                <div class="gx-5 justify-start align-items-center" style="display: flex; flex-wrap: wrap; gap: 30px; max-width: 1300px; margin: 0 auto; justify-content: start;">
              <!-- 다녀온 여행 블럭 -->
              
                    <c:forEach var="team" items="${inActiveTeamList}">
				    <form id="teamForm_${team.id}" action="/user/pretime_machine.do" method="post" name="pretimefrm">
				        <input type="hidden" value="${team.id}" name="teamId" class="inActivePlan"/>
				        <div class="mb-5 relative" style="width: 400px;">
							<button type="button" class="btn-close" style="position: absolute; top: 12px; right: 12px; z-index: 1; background-color: #e6e6e6;"></button>
				            <div class="card h-80 shadow border-0" onclick="submitTeamForm('${team.id}')">
				                <img class="card-img-top" id="destinationImage_${team.id}" style="height: 250px; width: 400px; display: block;" />
				                <div class="card-body p-4">
				                    <div class="badge bg-primary bg-gradient rounded-pill mb-2">${team.destination}</div>
				                    <div class="h5 card-title mb-3">${team.name}</div>
				                    <div class="text-muted">${team.travlestart} ~ ${team.travleend}</div>
				                </div>
				            </div>
				         </form>
				      </div>
				
				<script>
				   // 지난 여행 계획페이지로 teamId 전송
				    function submitTeamForm(teamId) {
				        var formId = 'teamForm_' + teamId;
				        document.getElementById(formId).submit();
				    };
    				
    				
    				
        				// 이미지 경로 설정
        				document.addEventListener('DOMContentLoaded', function() {
            				const destination = '${team.destination}';
            				const destinationImage = document.getElementById('destinationImage_${team.id}');
            
            				// 서울특별시인 경우에만 이미지 설정
            				if (destination === '서울특별시') {
                				destinationImage.setAttribute('src', 'https://img.freepik.com/free-photo/downtown-cityscape-at-night-in-seoul-south-korea_335224-272.jpg?size=626&ext=jpg&ga=GA1.1.1546980028.1704153600&semt=sph'); 
                				destinationImage.setAttribute('alt', '서울특별시 이미지');
            				} else if (destination === '부산광역시') {
                				destinationImage.setAttribute('src', 'https://www.kkday.com/ko/blog/wp-content/uploads/busan_tower_1.jpg'); 
                				destinationImage.setAttribute('alt', '부산광역시 이미지');
            				} else if (destination === '대구광역시') {
                				destinationImage.setAttribute('src', 'https://img.sbs.co.kr/newimg/news/20170623/201061716_700.jpg');
                				destinationImage.setAttribute('alt', '대구광역시 이미지');
            				} else if (destination === '인천광역시') {
                				destinationImage.setAttribute('src', 'https://img.khan.co.kr/news/2018/07/02/l_2018070201000159300013515.jpg'); 
                				destinationImage.setAttribute('alt', '인천광역시 이미지');
            				} else if (destination === '광주광역시') {
                				destinationImage.setAttribute('src', 'https://t1.daumcdn.net/cfile/tistory/9974613B5AC2DC4A1C'); 
                				destinationImage.setAttribute('alt', '광주광역시 이미지');
            				} else if (destination === '대전광역시') {
                				destinationImage.setAttribute('src', 'https://a.cdn-hotels.com/gdcs/production185/d1535/aec497d4-8632-4f54-8f11-af3dd8516ae8.jpg'); 
                				destinationImage.setAttribute('alt', '대전광역시 이미지');
            				} else if (destination === '울산광역시') {
                				destinationImage.setAttribute('src', 'https://a.cdn-hotels.com/gdcs/production161/d694/7bf49a46-c729-4446-9240-19a3d984815b.jpg'); 
                				destinationImage.setAttribute('alt', '울산광역시 이미지');
            				} else if (destination === '세종특별자치시') {
                				destinationImage.setAttribute('src', 'https://img.newspim.com/news/2020/10/15/2010151646296730.jpg'); 
                				destinationImage.setAttribute('alt', '세종특별자치시 이미지');
            				} else if (destination === '경기도') {
                				destinationImage.setAttribute('src', 'https://d2ur7st6jjikze.cloudfront.net/offer_photos/116208/630901_medium_1653633931.jpg?1653633931'); 
                				destinationImage.setAttribute('alt', '경기도 이미지');
            				} else if (destination === '강원도') {
                				destinationImage.setAttribute('src', 'https://www.ttlnews.com/upload/editor_content_images/1558423014204_editor_image.jpg'); 
                				destinationImage.setAttribute('alt', '강원도 이미지');
            				} else if (destination === '충청북도') {
                				destinationImage.setAttribute('src', 'https://cdn.ggilbo.com/news/photo/202203/902792_733861_457.jpg'); 
                				destinationImage.setAttribute('alt', '충청북도 이미지');
            				} else if (destination === '충청남도') {
                				destinationImage.setAttribute('src', 'https://wimg.mk.co.kr/meet/neds/2021/07/image_readtop_2021_648532_16254692944706068.jpg'); 
                				destinationImage.setAttribute('alt', '충청남도 이미지');
            				}else if (destination === '전라북도') {
                				destinationImage.setAttribute('src', 'https://image.kkday.com/v2/image/get/s1.kkday.com/product_12339/20170704084013_TfXFI/jpg'); 
                				destinationImage.setAttribute('alt', '전라북도 이미지');
            				}else if (destination === '전라남도') {
                				destinationImage.setAttribute('src', 'https://cdn.gjdream.com/news/photo/202101/605746_205436_2217.jpg'); 
                				destinationImage.setAttribute('alt', '전라남도 이미지');
            				}else if (destination === '경상북도') {
                				destinationImage.setAttribute('src', 'https://cdn.balpumnews.com/news/photo/202312/2651_14165_3725.jpg'); 
                				destinationImage.setAttribute('alt', '경상북도 이미지');
            				}else if (destination === '경상남도') {
                				destinationImage.setAttribute('src', 'https://cdn.visitkorea.or.kr/img/call?cmd=VIEW&id=63b6ff8a-7ea9-4df1-a4e6-0a60bf8912d9'); 
                				destinationImage.setAttribute('alt', '경상남도 이미지');
            				}else if (destination === '제주특별자치도') {
                				destinationImage.setAttribute('src', 'https://res.klook.com/image/upload/fl_lossy.progressive,w_800,c_fill,q_85/Mobile/City/nsejkwbumyk3cc5oep61.jpg'); 
                				destinationImage.setAttribute('alt', '제주특별자치도 이미지');
            				}
        				});
    			 </script>
				</c:forEach>
                    
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
				<div class="flex flex-col">
					<div class="flex-fill row align-items-center justify-content-between flex-column flex-sm-row">
						<div class="col-auto"><div class="small m-0 text-white">Copyright &copy; TripTable 2024</div></div>
						<div class="col-auto">
							<a class="link-light small" href="#!">대표 [ 손수빈 ]</a>
							<span class="text-white mx-1">&middot;</span>
							<a class="link-light small" href="#!">문의 [ 010-1234-5678 ]</a>
							<span class="text-white mx-1">&middot;</span>
							<a class="link-light small" href="#!">Mail [ 0928ssb@naver.com ]</a>
						</div>
					</div>
					<div class="flex-fill">
						<div style="color: #fff; font-size: 11px;">이미지 출처 : 한국공공포탈데이터활용</div>
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