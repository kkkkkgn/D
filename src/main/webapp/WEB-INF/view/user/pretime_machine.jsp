<%@page import="java.text.NumberFormat"%>
<%@page import="com.example.triptable.entity.Team"%>
<%@page import="com.example.triptable.entity.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.example.triptable.entity.CourseRecommendation"%>
<%@ page import="java.util.List"%>
<%
User user = (User)session.getAttribute("user");
String user_name = user.getName();

List<Team> teamlist = (List<Team>)request.getAttribute("teamlist");
%>
<!DOCTYPE html>
<html lang="en">

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

        <script src="../assets/vendor/tinymce/tinymce.min.js"></script>
        <!-- Quill editor -->
        <link rel="stylesheet" href="https://cdn.quilljs.com/1.3.6/quill.core.css">
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>

        <!-- Template Main CSS File -->
        <link href="../assets/css/style.css" rel="stylesheet">
    <style>
    	 .btn {
		    pointer-events: auto !important; /* 기본값, 마우스 이벤트 허용 */
		  }
		
		  .btn-hidden {
		    pointer-events: none !important; /* 마우스 이벤트 차단 */
		  }
    
        body {
            background-color: #fafafa; /* Light gray background */
            margin: 0;
        }
        
        @Font-face {
        	font-family: 'ChosunGu';
        	src:url('../fonts/ChosunGu.TTF');
        }

        h3 {
            color: #FFF; /* Blue text color */
        }

       table {
		    font-size: 1.2em;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, .1);
		    width: auto; /* 변경 */
		    border-collapse: separate;
		    border-radius: 5px;
		    overflow: hidden;
		    background: #ffffff;
		    margin-bottom: 0;
		}

		
		th {
		    text-align: center;
		    color: #ffffff;
		    background: #3498db;
		}
		
		td {
		    text-align: center;
		    padding: 1em;
		    vertical-align: middle;
		    border-bottom: 1px solid rgba(0, 0, 0, .1);
		    background: #ecf0f1;
		    height: auto;
		    width: auto;
		}


        .card {
            border: 3px solid #3498db; /* Blue border */
            background: #ffffff; /* White background for the card */
            border-radius: 15px;
            margin-bottom: 20px;
        }

        .list-group-item {
            background: #ecf0f1; /* Light blue background for list items */
            border: none;
            margin-bottom: 5px;
        }

        .scrollable-card {
            max-height: 240px; /* Increased max-height */
            overflow-y: auto;
            background: #ffffff; /* White background for the card */
            border: 3px solid #3498db; /* Blue border */
            border-radius: 15px; /* Increased border radius */
            margin-bottom: 20px;
        }

        .memo-card {
            max-height: 770px; /* Increased max-height */
            overflow-y: auto;
            background: #ffffff; /* White background for the card */
            border: 3px solid #3498db; /* Blue border */
            border-radius: 15px; /* Increased border radius */
            margin-bottom: 20px;
        }

        .section {
            margin: 30px 0;
        }

        .card-title {
            color: #537188;
        }

        .badge {
            background-color: #3498db;
        }

        .list-group-item label {
            margin-bottom: 0;
        }

        .list-group-item input {
            margin-right: 5px;
        }

        @media (max-width: 767px) {
            .table {
                width: auto;
            }
        }

        @media (min-width: 768px) {
            .list-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
        }

    </style>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript">

	</script>
</head>

<body class="d-flex flex-column h-100 react react-st" style="background-image: url('../img/timemachine.png'); background-size: cover; background-position: center center; background-repeat: no-repeat; box-sizing: border-box;">
 <%@ include file="./header.jsp" %>
 <main class="flex-shrink-0" id="main" style="max-width: 100%; margin: 0;">
    <div style="margin-left: 100px; margin-right: 100px;">
        
            <section class="previous-time-machine section">
                <div class="text-center mb-4">
                    <h3><b>${team.name}</b></h3>
                    <span style="color: #FFF">${team.destination}</span>
                </div>

                <div class="row">
                    <!-- Left Section - 여행 일정 -->
                    <div class="col-xl-8">
                      <div>
                        <div class="card " style="border-radius: 15px;" >
                            <div class="card-body" style="">
                                 <h5 class="card-title"><b><i class="bi bi-airplane-fill"></i> 여행 계획</b> <span>| <b>${team.travlestart } ~ ${team.travleend }</b></span></h5>
								<div style="overflow-x: auto;  width: 100%; height: 420px;">
				                  <table class="table" style="width: 1500px; height: 95%;">
								
									  <tbody>
									   <c:forEach var="dayData" items="${spotArr}">
										    <tr>
										    	<td style="border-right: 2px solid #3498db;"></td>
										        <th>Day ${dayData.day}</th>
										        <c:forEach var="spot" items="${dayData.spot}">
										            <td style="font-size: 18px"><b>${spot.name}</b></td>
										        </c:forEach>
										    </tr>
										</c:forEach>
				                    </tbody>
				                    
				                  </table>
								</div>
                            </div>
                        </div>
                        </div>
                    

                        <!-- 하단의 가계부와 준비물 목록 -->
                        <div class="row mt-4">
                            <div class="col-lg-6">
                                <!-- 가계부 -->
                                <div class="card scrollable-card">
                                    <div class="card-body " style="min-height: 230px; overflow-y: auto;;" >
                                          <h5 class="card-title"><b><i class="bi bi-cash-coin"></i> 가계부</b></h5>
							              <ul class="list-group">	
							              <c:forEach var="day" items="${financeArr}">
									    		
									        <b>Day ${day.day}</b>
											    <c:forEach var="financeItem" items="${day.finance}">
											        <li class="list-group-item d-flex justify-content-between align-items-center">
											            <b>${financeItem.detail}</b>
											            <span class="badge bg-primary">${financeItem.expense}원</span>
											        </li>
											    </c:forEach>
										    </c:forEach>
										</ul>

                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-6">
                                <!-- 준비물 목록 -->
                                <div class="card scrollable-card">
                                    <div class="card-body " style="min-height: 230px; overflow-y: auto;">
                                          <h5 class="card-title"><b><i class="bi bi-list-check"></i> 준비물</b></h5>
							              <ul class="list-group">
							               <c:forEach var="preparation" items="${preparationLists }"> 
										      <li class="list-group-item d-flex justify-content-between align-items-center">
										        
										              <b><i class="bi bi-check"></i> <c:out value="${preparation.name }" /></b>
										        
										      </li>
										    </c:forEach>
										      
										    </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Right Section - 메모장 -->
                    <div class="col-lg-4">
                        <div class="card">
                        
                            <div class="card-body" style="min-height: 300px; margin-top: 5px;">

				               <div class="flex d-flex">
								    <h5 class="card-title"><b><i class="bi bi-journal-richtext"></i> 다이어리</b></h5>
								    <button type="button" onclick="saveContent('${team.id}')" class="btn btn-primary ms-auto" style="height: 35px; margin-top:14px; margin-right: 3px">저장</button>
								</div>
				              <div class="editor" style="height: 630px; font-size: 15px" id="editor">
				                ${pretimeContent }
				              </div>
							  <input type="hidden" id="quill_html">
                            </div>
                            
                        </div>
                    </div>
           
                </div>
            </section>
        </main>
    </div>
         
<script>
var quill;

function quilljsEditorInit() {
    // Quill 에디터 설정 옵션
    var options = {
        modules: {
            toolbar: [
                ['bold', 'italic', 'underline', 'strike'],
                [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                [{ 'script': 'sub'}, { 'script': 'super' }],
                [{ 'indent': '-1'}, { 'indent': '+1' }],
                [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                [{ 'font': [] }],
                [{ 'color': [] }, { 'background': [] }],
                [{ 'align': [] }],
                ['image']
            ]
        },
        placeholder: '나만의 추억을 저장해 보세요~',
        theme: 'snow'
    };

    // Quill 에디터 초기화
    quill = new Quill('#editor', options);

    // 텍스트 변경 이벤트 처리
    quill.on('text-change', function () {
        var content = quill.root.innerHTML;
    });

    // 이미지 업로드 핸들러 등록
    quill.getModule('toolbar').addHandler('image', function () {
        selectLocalImage(quill);
    });
}

// Quill 에디터 초기화 함수 호출
quilljsEditorInit();

function selectLocalImage(quill) {
    // 파일 선택 input 엘리먼트 생성
    const fileInput = document.createElement('input');
    fileInput.setAttribute('type', 'file');
    fileInput.setAttribute('accept', 'image/*'); // 이미지 파일만 허용
    fileInput.click();

    // 파일 선택 이벤트 처리
    fileInput.addEventListener("change", function () {
        const formData = new FormData();
        const file = fileInput.files[0];
        formData.append('file', file);

        // 이미지 업로드를 위한 AJAX 요청
        $.ajax({
            type: 'post',
            url: '/imageUpload',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                const range = quill.getSelection();
                const imageUrl = "/display?fileName=" + data.uploadPath ;
                quill.insertEmbed(range.index, 'image', imageUrl);
            },
            error: function (err) {
                console.log(err);
            }
        });
    });
}

function saveContent(teamId) {
    var content = quill.root.innerHTML;
    
    $.ajax({
        type: 'POST',
        url: '/user/pretime_content.do', // 실제 서버 엔드포인트에 맞게 수정
        data: {
            teamId: teamId,
            content: content
        },
        success: function (response) {
        },
        error: function (error) {
            console.error('에러 : ', error);
        }
    });
}

</script>
    <!-- Bootstrap JS (optional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


    <!-- Template Main JS File -->
  	<script src="../assets/js/main.js"></script>
  
	<!-- Core theme JS-->
	<script src="../js/scripts.js"></script>
</body>

</html>
<!-- <a href="https://www.flaticon.com/kr/free-icons/" title="스크랩북 아이콘">스크랩북 아이콘  제작자: Freepik - Flaticon</a> -->