<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import ="com.example.triptable.entity.User" %>
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
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />
        <style>
            
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
                box-shadow: 0px 0 30px rgba(1, 41, 112, 0.1);
            }
            .card-body {
                padding: 50px 50px 50px 50px;
           
            }
            
            .reason-check {
               
                min-height: 1.5rem;
                padding-left: 1.5em;
                margin-bottom: 0.125rem;
                font-size: medium;
            }

           
        </style>
        <script type="text/javascript">
        window.onload = function() {
			var icon = '<%= user.getIcon()%>';
			console.log(icon);
			// 닉네임 및 비밀번호 미입시 뜨는 dialogue
			document.getElementById( 'finbtn' ).onclick = function() {
				if( document.setfrm.nickname.value.trim() == '' ) {
					alert( '닉네임을 입력하셔야 합니다.' );
					return;
				}
				if( document.setfrm.password.value.trim() == '' ) {
					alert( '비밀번호를 입력하셔야 합니다.' );
					return;
				}
				// form 내에 name="icon" value 설정
				document.getElementById('selecticon').value = icon;
				console.log(icon);
				document.setfrm.submit();
			};
			// 프로필 사진 설정 기능
			for (var i = 1; i <= 24; i++) {
				
			    (function (index) {
			        if (index < 10) {
			            document.getElementById('icon0' + index).onclick = function () {
			                icon = 'icon0' + index;
			                document.getElementById("profile-img").src = "../icon/" + icon + ".png";
			            };
			        } else {
			            document.getElementById('icon' + index).onclick = function () {
			                icon = 'icon' + index
			                document.getElementById("profile-img").src = "../icon/" + icon + ".png";
			            };
			        }
			    })(i);
			    
			};
			
			// 비밀번호 변경 기능
			document.getElementById( 'changepasswordbutton' ).onclick = function() {
				
				if( document.changepasswordform.originpassword.value.trim() == '' ) {
					alert( '기존 비밀번호를 입력하셔야 합니다.' );
					return;
				}
				if( document.changepasswordform.changepassword.value.trim() == '' ) {
					alert( '변경할 비밀번호를 입력하셔야 합니다.' );
					return;
				}
				if( document.changepasswordform.checkchangepassword.value.trim() == '' ) {
					alert( '변경할 비밀번호를 입력하셔야 합니다.' );
					return;
				}
				document.changepasswordform.submit();
			};
		};
		
		</script>
    </head>
    <body class="d-flex flex-column h-100 react react-st" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0" id="main">
            <div class="" id="navbar-line"></div>
          
 <!-- ==== Main ==== -->
            
          <section>
            <div class="container px-5">
             
            <div class="col mb-5 mb-xl-0">
                <div class="profile-card text-center">

                    <div class="card">
                    <form action="./profile_set_ok.do" method="post" name="setfrm">
                    <input type="hidden" name="selecticon" id="selecticon" value="" >
                        <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
                            
                            <button type="button" class="img-fluid rounded-circle mb-5" id="profile-btn" data-bs-toggle="modal" data-bs-target="#profile-modal"><img class="rounded-circle" id="profile-img" src="../icon/<%=user.getIcon() %>.png" alt="..." /></button> 
                            <h3 class="profile-text mr-5 fw-bolder fs-5">닉네임</h3>
                            <div class="profile-set d-flex px-">
                                <input type="text" class="form-control" name="nickname" value=<%=user.getNickname() %>>
                                <i class="bi bi-pencil"></i>
                            </div>
                            
                            <h3 class="profile-text mr-5 fw-bolder fs-5">이메일</h3>
                            <div class="profile-set d-flex ">
                                <input type="text" class="form-control" value=<%=user.getMail() %> readonly />
                            </div>
                            
                            <h3 class="profile-text mr-5 fw-bolder fs-5">비밀번호</h3>
                            <div class="profile-set d-flex ">
                                <input type="password" class="form-control" name="password" value=""  />
                            </div>
                            	<a href="#" data-bs-toggle="modal" data-bs-target="#changepasswordmodal" style="font-size: small; color: #6e6e6e;">
            					비밀번호 변경
						        </a>
                            <div class="input-group-append mt-5">
                                <input type="button" class="btn btn-primary px-5" id="finbtn" value="완료">
                            </div>
                        </div>
                    </form>
                    </div>
        <!-- 회원탈퇴 Modal -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#cancelModal" style="font-size: small; color: #6e6e6e;">
            회원탈퇴
        </a>

         <div class="modal fade" id="cancelModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                <form action="user_delete_ok.do" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">회원탈퇴</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="text-center" style="font-weight: 700;">
                            <h2>정말 떠나시는 건가요?<br />
                            한 번 더 생각해 보지 않으시겠어요?</h2>
                        </div>
                        <br /><br />
                        <div >
                            <h3>탈퇴 사유를 알려주세요.</h3>
                            <div class="reason-check">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option1" checked>
                            <label class="form-check-label" for="">
                                다른 플랫폼으로 이전
                            </label>
                            </div>
                            <div class="reason-check">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option2">
                            <label class="form-check-label" for="">
                                서비스 불만족
                            </label>
                            </div>
                            <div class="reason-check">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option3" >
                            <label class="form-check-label" for="">
                                기록 삭제 목적
                            </label>
                            </div>
                            <div class="reason-check">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option4" >
                            <label class="form-check-label" for="">
                                기타
                            </label>
                            </div>
                        </div>
                        
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">탈퇴</button>
                </div>
                </form>
                </div>
            </div>
            </div>
    <!-- 비밀번호 변경 Modal-->
    <div class="modal fade" id="changepasswordmodal" tabindex="-1" >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
            <form action="./change_password_ok.do" name="changepasswordform" id="changepasswordform" method="post">
                <div class="modal-header">
                    <h5 class="modal-title">비밀번호 변경</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="text-center" style="font-weight: 700;">
                            <h1>비밀번호 변경</h1>
                    </div>
                        <br />
                   	<div >
                   		기존 비밀번호<br/>
                    	<input type="password" name="originpassword" id="originpassword">
                    	 <br />
                    	 변경할 비밀번호<br/>
                    	<input type="password" name="changepassword" id="changepassword">
                    	 <br />
                    	 비밀번호 확인<br/>
                    	<input type="password" name="checkchangepassword" id="checkchangepassword">
                    </div>
                        
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" id="changepasswordbutton"class="btn btn-primary">변경</button>
                </div>
            </form>
            </div>
        </div>
    </div>
    <!-- 비밀번호 변경 Modal-->
            
    <!-- 프로필 사진 변경 Modal -->
    <div class="modal" id="profile-modal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
  
        <!-- Modal body -->
        <div class="modal-body" id = iconmodal>
            <table>
            <tr>
                <td align="center">
                    
                    <tr>
					    <td>
					        <button class="icon" id="icon01" name="icon01" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon01.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon02" name="icon02" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon02.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon03" name="icon03" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon03.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon04" name="icon04" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon04.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon05" name="icon05" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon05.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon06" name="icon06" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon06.png" width="60"/><br /></button>
					    </td>
					</tr>
					<tr>
					    <td>
					        <button class="icon" id="icon07" name="icon07" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon07.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon08" name="icon08" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon08.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon09" name="icon09" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon09.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon10" name="icon10" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon10.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon11" name="icon11" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon11.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon12" name="icon12" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon12.png" width="60"/><br /></button>
					    </td>
					</tr>
					<tr>
					    <td>
					        <button class="icon" id="icon13" name="icon13" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon13.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon14" name="icon14" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon14.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon15" name="icon15" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon15.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon16" name="icon16" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon16.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon17" name="icon17" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon17.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon18" name="icon18" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon18.png" width="60"/><br /></button>
					    </td>
					</tr>
					<tr>
					    <td>
					        <button class="icon" id="icon19" name="icon19" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon19.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon20" name="icon20" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon20.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon21" name="icon21" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon21.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon22" name="icon22" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon22.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon23" name="icon23" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon23.png" width="60"/><br /></button>
					    </td>
					    <td>
					        <button class="icon" id="icon24" name="icon24" data-bs-dismiss="modal" data-target="#profile-modal"><img src="../icon/icon24.png" width="60"/><br /></button>
					    </td>
					</tr>          
                </table>
        </div>
  
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
        </div>
  
      </div>
    </div>
  </div>
  <!-- End 수정 버튼 Modal -->
                           
                            
                        </div>  
                       
                           
                    </div>
            </div>
        </section>
	<table>
  
  	</table>	
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <!-- 부트스트랩 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        
    </body>
</html>