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
			
			// 닉네임 및 비밀번호 미입시 뜨는 dialogue
			document.getElementById( 'finbtn' ).onclick = function() {
				
				if( document.setfrm.nickname.value.trim() == '' ) {
					// alert( '닉네임을 입력하셔야 합니다.' );
                    alertBody.text('');
                    alertBody.text('닉네임을 입력해 주세요!');
                    alertShowBtn.click();
					return;
				}
				if( document.setfrm.password.value.trim() == '' ) {
					// alert( '비밀번호를 입력하셔야 합니다.' );
                    alertBody.text('');
                    alertBody.text('비밀번호를 입력해 주세요!');
                    alertShowBtn.click();
                    return;
				}
				// form 내에 name="icon" value 설정
				document.getElementById('selecticon').value = icon;
									
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
			
			$('#changepasswordmodal').on('hidden.bs.modal', function () {
		        $('#originpassword').val('');
		        $('#changepassword').val('');
		        $('#checkchangepassword').val('');
		    });
		};
		
		// 비밀번호 변경 기능
		function changePassword() {
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
			
			var changepassword = document.getElementById('changepassword').value;
			const regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
			
			if(changepassword.length<8 || changepassword.length>15) {
				alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
				return false;
			}
			
			if(!regex.test(changepassword)) {
				alert('영어,숫자,특수문자를 포함한 8~15자리를 입력해주세요.');
				return false;
			}
			
			$.ajax({
				url : '/user/check_exist_user_pw.do',
				type : 'POST',
				data : {
					password : document.changepasswordform.originpassword.value.trim()
				},
				success : function(flag){
					if(flag == 1){
						document.changepasswordform.submit(); 
					} else {
						alert('기존 비밀번호가 틀렸습니다.');
						return;
					}
				},
				error : function(){
					
				}
			});
			
		};
		
		
		
		</script>
    </head>
    <body class="d-flex flex-column h-100 react react-st relative" style="box-sizing: border-box;">
        <%@ include file="./header.jsp" %>
        <main class="flex-shrink-0 relative" id="main" style="max-width: 100%; margin: 0; height: calc(100vh - 80px);">
            <div class="" id="navbar-line"></div>
          
 <!-- ==== Main ==== -->
            
          <section style="width: 100%; height: 100%;">
            <div class="container px-5">
             
            <div class="col mb-5 mb-xl-0">
                <div class="profile-card text-center">

                    <div class="card">
                    <form action="/user/profile_set_ok.do" method="post" name="setfrm">
                    <input type="hidden" name="selecticon" id="selecticon" value="" >
                        <div class="card-body profile-card p-4 border" style="border-radius: 8px; box-shadow: 0 0 25px rgba(0, 0, 0, 0.4); height: 500px; position: absolute; top: 50%; left: 50%; transform: translate(-50%, 10%);width: 60%;background: #fff; min-width: 600px;  max-width: 800px;">
                            <div class="flex h-full w-full justify-center align-items-center">
                                <div style="flex:1;" class="flex justify-center align-items-center">
                                    <button type="button" class="img-fluid rounded-circle mb-5" id="profile-btn" data-bs-toggle="modal" data-bs-target="#profile-modal"><img class="rounded-circle" id="profile-img" src="../icon/<%=user.getIcon() %>.png" alt="..." /></button> 
                                </div>   
                                <div style="flex:1;" class="flex justify-center align-items-center">
                                    <div>
                                        <h3 class="profile-text mr-5 fs-5">닉네임</h3>
                                        <div class="profile-set d-flex relative">
                                            <input type="text" class="form-control" name="nickname" value="<%=user.getNickname() %>">
                                            <i class="bi bi-pencil" style="margin-left: 5px; position: absolute; left: 100%;"></i>
                                        </div>
                                        
                                        <h3 class="profile-text mr-5 fs-5">이메일</h3>
                                        <div class="profile-set d-flex ">
                                            <input type="text" class="form-control" value=<%=user.getMail() %> readonly />
                                        </div>
                                        
                                        <h3 class="profile-text mr-5 fs-5">비밀번호</h3>
                                        <div class="profile-set d-flex ">
                                            <input type="password" class="form-control" id=""name="password" value=""  />
                                        </div>
                                            <a href="#" data-bs-toggle="modal" data-bs-target="#changepasswordmodal" style="font-size: small; color: #6e6e6e;">
                                            비밀번호 변경
                                            </a>
                                        <div class="input-group-append mt-5">
                                            <input  style="width: 200px;" type="button" class="btn btn-primary px-5" id="finbtn" value="완료">
                                        </div>
                                        <!-- 회원탈퇴 Modal -->
                                        <a href="#" data-bs-toggle="modal" data-bs-target="#cancelModal" style="font-size: small; color: #6e6e6e;">
                                            회원탈퇴
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    </div>


         <div class="modal fade" id="cancelModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                <form action="/user_delete_ok.do" method="post">
                <div class="modal-header"style="background-color: #00aef0;">
                    <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                        <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                    </span>
                    <!-- <h5 class="modal-title">회원탈퇴</h5> -->
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
                            <div class="reason-check" style="margin-left:-50px;">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option1" checked>
                            <label class="form-check-label" for="">
                                다른 사이트가 더 좋아서
                            </label>
                            </div>
                            <div class="reason-check" style="margin-left:-133px;">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option2">
                            <label class="form-check-label" for="">
                                서비스 불만
                            </label>
                            </div>
                            <div class="reason-check" style="margin-left:-55px;">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option3" >
                            <label class="form-check-label" for="">
                                기록을 삭제하고 싶어서
                            </label>
                            </div>
                            <div class="reason-check" style="margin-left:-90px;">
                            <input class="form-check-input" type="radio" name="gridRadios" id="" value="option4" >
                            <label class="form-check-label" for="">
                              	사용빈도가 낮아서
                            </label>
                        </div>
                    </div> 
                </div>
                <br>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">탈퇴</button>
                </div>
                </form>
                </div>
            </div>
            </div>
    <!-- 비밀번호 변경 Modal-->
    <div class="modal fade" id="changepasswordmodal" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changepasswordform" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
            <form action="/user/change_password_ok.do" name="changepasswordform" id="changepasswordform" method="post">
                <div class="modal-header"style="background-color: #00aef0;">
                    <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                        <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                    </span>
                    <!-- <h5 class="modal-title" style="margin-left: 10px;">비밀번호 변경</h5> -->
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body text-center">
                    <div class="text-center" style="font-weight: 700;">
                            <h1>비밀번호 변경</h1>
                    </div>
                         <br />
                   	<div >
                   		기존 비밀번호<br/>
                    	<input class="form-control" style="width:200px; margin: 0 auto;" type="password" name="originpassword" id="originpassword">
                    	 <br />
                    	 변경할 비밀번호
                    	 <br/>
                    	<input class="form-control" style="width:200px; margin: 0 auto;"type="password" name="changepassword" id="changepassword">
                    	 <br />
                    	 <sub>(영어,숫자,특수문자를 포함한 8~15자리)</sub>
                    	 <br/>
                    	 비밀번호 확인
                    	 <br/>
                    	<input class="form-control" style="width:200px; margin: 0 auto;" type="password" name="checkchangepassword" id="checkchangepassword">
                    </div>
                        
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" id="changepasswordbutton"class="btn btn-primary" onclick="changePassword()">변경</button>
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
    <footer class="bg-dark py-4 mt-auto" style=" position: absolute; bottom: 0; left: 69px; right: 0;">
        <div class="container px-5">
            <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; TripTable 2024</div></div>
                <div class="col-auto">
                    <a class="link-light small" href="#!">대표 [ 손수빈 ]</a>
                    <span class="text-white mx-1">&middot;</span>
                    <a class="link-light small" href="#!">문의 [ 010-1234-5678 ]</a>
                    <span class="text-white mx-1">&middot;</span>
                    <a class="link-light small" href="#!">Mail [ 0928ssb@naver.com ]</a>
                </div>
            </div>
        </div>
    </footer>
    <!-- Button trigger modal -->
    <button type="button" id="alertBtn" class="btn btn-primary none" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
    </button>

    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
            <div class="modal-header" style="background-color: #00aef0;">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">
                    <span style="transform:translate3d(0,0,0);vertical-align:middle;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale;width:auto;height:auto" class="logo-image">
                        <img src="../img/LogoRaccoon.png" alt="로고너구리" style="width: 30px; display: inline-block;" />
                        <img src="../img/Logo.png" alt="로고" style="height: 18px; display: inline-block;" />
                    </span>
                </h1>
                <button id="modalCloseIcon" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                여행계획을 불러왔습니다!
            </div>
            <div id="modalFooter" class="modal-footer ft-face-nm">
                <!-- <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
                <button type="button" class="btn btn-primary " data-bs-dismiss="modal" aria-label="Close" >확인</button>
            </div>
            </div>
        </div>
    </div>
    <!-- Bootstrap core JS-->
    <!-- 부트스트랩 JS 종속성 (jQuery 및 Popper.js) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <!-- 부트스트랩 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

    <!-- Core theme JS-->
    <script src="../js/scripts.js"></script>
        
    </body>
</html>