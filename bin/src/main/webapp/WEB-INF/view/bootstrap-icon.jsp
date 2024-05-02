<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Trip Table</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="./favicon.ico" />
       
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/course.css" rel="stylesheet" />
        <link href="../css/font.css" rel="stylesheet" />
        <link href="../css/dong.css" rel="stylesheet" />

        <style>
            button {
                width: 44px;
                height: 44px;
            }
            .setTimeBox {
                width: 100%;
                border: 1px solid;
            }
        </style>
    </head>
	
<body class="flex gap-4 mt-3" style="box-sizing: border-box; flex-wrap: wrap; width: 1000px; margin: auto;">

    <div id="spotTimeSetModal" class="">
        <div class="flex h-full w-full gap-3">
            <div style="flex: 1;" class="setTimeBox">
                <div id="spotTimeSetContent" >          
                    <div class="item spotListone ft-face-nm mb-2 draggable" draggable="true" data-id="1" style="background-color: rgb(197, 197, 255); width: 100%; height: auto;">
                        <div class="spotSetTime"><input type="time" class="StartTime mr-2" value="10:00" /> <input type="time" class="EndTime" value="11:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div>
                        <div class="checkOrder"></div>
                        <div class="info">
                            <span class="markerbg marker_1"></span> 
                            <span class="info-title"><b>경복궁</b></span>
                            <span class="info-address"><small>서울 종로구 사직로 161</small></span>    
                        </div>
                    </div>
                    <div class="item spotListone ft-face-nm mb-2 draggable" draggable="true" data-id="2" style="background-color: rgb(197, 197, 255); width: 100%; height: auto;">
                        <div class="spotSetTime"><input type="time" class="StartTime mr-2" value="10:00" /> <input type="time" class="EndTime" value="11:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div>
                        <div class="checkOrder"></div>
                        <div class="info">
                            <span class="markerbg marker_1"></span> 
                            <span class="info-title"><b>경화루</b></span>
                            <span class="info-address"><small>서울 종로구 오직로 161</small></span>    
                        </div>
                    </div>
                    <div class="item spotListone ft-face-nm mb-2 draggable" draggable="true" data-id="2" style="background-color: rgb(197, 197, 255); width: 100%; height: auto;">
                        <div class="spotSetTime"><input type="time" class="StartTime mr-2" value="10:00" /> <input type="time" class="EndTime" value="11:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div>
                        <div class="checkOrder"></div>
                        <div class="info">
                            <span class="markerbg marker_1"></span> 
                            <span class="info-title"><b>경화루</b></span>
                            <span class="info-address"><small>서울 종로구 오직로 161</small></span>    
                        </div>
                    </div>
                    <div class="item spotListone ft-face-nm mb-2 draggable" draggable="true" data-id="2" style="background-color: rgb(197, 197, 255); width: 100%; height: auto;">
                        <div class="spotSetTime"><input type="time" class="StartTime mr-2" value="10:00" /> <input type="time" class="EndTime" value="11:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div>
                        <div class="checkOrder"></div>
                        <div class="info">
                            <span class="markerbg marker_1"></span> 
                            <span class="info-title"><b>경화루</b></span>
                            <span class="info-address"><small>서울 종로구 오직로 161</small></span>    
                        </div>
                    </div>
                </div>
            </div>
            <div class="flex flex-col gap-3" style="flex: 1;">
                <div class="flex flex-col gap-3" style="flex: 0.9">
                    <div id="spotStartSetTimeContent" class="setTimeBox" style="flex: 1">
                        <span class="">시작 시간 정하기</span>
                        <div class="spotSetTime"><input type="time" class="StartTime mr-2" value="10:00" /> </div>
                    </div>
                </div>
                <div style="flex: 0.1">
                    <button type="button" id="spotTimeSetDelete">취소</button>
                    <button type="button" id="spotTimeSetInsert">확인</button>
                </div>
            </div>
        </div>

    </div>


    <div class="my-5" id="#spotTimeSetContent" class="flex flex-col gap-4">    
        <div><input type="time" class="StartTime mr-2" value="10:00" /> <input type="time" class="EndTime" value="11:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div> 
        <div><input type="time" class="StartTime mr-2" value="11:00" /> <input type="time" class="EndTime" value="12:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div> 
        <div><input type="time" class="StartTime mr-2" value="12:00" /> <input type="time" class="EndTime" value="13:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div> 
        <div><input type="time" class="StartTime mr-2" value="13:00" /> <input type="time" class="EndTime" value="14:00" /> <label for="LT_s"><input type="text" name="LT_s" style="width: 40px;"/> 소요시간</label> </div>
    </div>

<!--     <div id="boxContainer" style="background-color: #fff; position: fixed; width: 500px; height: 500px; border: 1px solid; top:50%; left:50%; transform: translate(-50%,-50%);"> -->
        
    </div>
    <button onclick="addBox()">Add Box</button>
    <button onclick="deleteBox()">Delete Box</button>
    


    <script>
    $(document).ready(function() {
        $("#spotTimeSetContent").on("change", "input[type='time']", checkTimeOrder);
        

    });

    let timetable = ["09:00 ~ 10:00"];
    let boxNumber = 0;
    const boxContainer = document.getElementById('boxContainer');

    function addHour(time, hours) {
        const [hour, minute] = time.split(':').map(Number);
        const newHour = (hour + hours) % 24;
        const formattedHour = newHour < 10 ? '0' + newHour : '' + newHour;
        const formattedMinute = minute < 10 ? '0' + minute : '' + minute;
        return formattedHour + ':' + formattedMinute;
    }

    function addBox() {
        // 새로운 시간 추가
        const lastTime = timetable[timetable.length - 1];
        const [start, end] = lastTime.trim().split('~');
        const newStart = addHour(start, 1);
        const newEnd = addHour(end, 1);
        const newTime = newStart + ' ~ ' + newEnd;
        timetable.push(newTime);

        // 박스 추가
        boxNumber++;
        const box = document.createElement('div');
        box.className = 'box';
        box.innerHTML = 'Box ' + boxNumber + ' : <strong>' + newTime + '</strong> <button onclick="deleteBox(this)">Delete</button>';
        boxContainer.appendChild(box);
    }



    function checkTimeOrder() {
            var timeGroups = $("#spotTimeSetContent").find("> .item");
            console.log("timeGroups.length: ", timeGroups.length);

            // 배열로 변환
            var timeGroupsArray = timeGroups.toArray();

            // 시작 시간을 기준으로 정렬
            timeGroupsArray.sort(function (a, b) {
                var startTimeA = $(a).find(".StartTime").val();
                var startTimeB = $(b).find(".StartTime").val();

                // 시작 시간을 비교하여 오름차순으로 정렬
                return startTimeA.localeCompare(startTimeB);
            });

            // 정렬된 배열을 다시 화면에 적용
            $("#spotTimeSetContent").empty().append(timeGroupsArray);
        }




    function checkTimeIntervals() {
        var timeGroups = $("#LT_spot").find("> div");
        console.log("timeGroups.length: ", timeGroups.length);

        for (var i = 0; i < timeGroups.length; i++) {
            var startTime = $(timeGroups[i]).find(".StartTime").val();
            console.log("startTime: ", startTime);
            var endTime = $(timeGroups[i]).find(".EndTime").val();
            console.log("endTime: ", endTime);
            var durationInput = $(timeGroups[i]).find("input[name='LT_s']");

            // 시간 문자열을 Date 객체로 변환
            var startDateTime = new Date("1970-01-01T" + startTime + ":00");
            var endDateTime = new Date("1970-01-01T" + endTime + ":00");

            // 시작 시간이 종료 시간보다 크거나 같거나 동일한 경우 알림창 표시
            if (startDateTime >= endDateTime || startDateTime.getTime() === endDateTime.getTime()) {
                console.log("startTime >= endTime or startTime === endTime");

                // 종료 시간을 1 시간 뒤로 설정
                endDateTime.setHours(startDateTime.getHours() + 1);

                // 종료 시간을 문자열로 변환하여 입력 필드에 설정
                var adjustedEndTime = endDateTime.toTimeString().substring(0, 5);
                $(timeGroups[i]).find(".EndTime").val(adjustedEndTime);
            }

            // 추가 부분: 두 개의 연속된 timeGroups에 대한 검증과 조치
            if (i > 0) {
                var prevEndTime = new Date("1970-01-01T" + $(timeGroups[i - 1]).find(".EndTime").val() + ":00");
                var nextStartTime = new Date("1970-01-01T" + startTime + ":00");
                var nextEndTime = new Date("1970-01-01T" + endTime + ":00");
                
                console.log("prevEndTime : ", prevEndTime);
                console.log("nextStartTime : ", nextStartTime);
                console.log("nextEndTime : ", nextEndTime);

                // 이전 그룹의 종료 시간이 현재 그룹의 시작 시간보다 크거나 같은 경우 알림창 표시
                if (prevEndTime >= nextStartTime) {
                    console.log("Prev group's endTime >= Current group's startTime");

                    // 현재 그룹의 시작 시간을 이전 그룹의 종료 시간과 같게 만들기
                    nextStartTime.setHours(prevEndTime.getHours());
                    nextStartTime.setMinutes(prevEndTime.getMinutes() + 1);

                    // 시작 시간을 문자열로 변환하여 입력 필드에 설정
                    var adjustedStartTime = nextStartTime.toTimeString().substring(0, 5);
                    $(timeGroups[i]).find(".StartTime").val(adjustedStartTime);
                }

                if (nextStartTime >= nextEndTime) {
                    // 시작 시간이 종료 시간보다 크거나 같은 경우 알림창 표시
                    console.log("nextStartTime >= nextEndTime");

                    // 종료 시간을 1 시간 뒤로 설정
                    nextEndTime.setHours(nextStartTime.getHours() + 1);

                    // 종료 시간을 문자열로 변환하여 입력 필드에 설정
                    var adjustedEndTime = nextEndTime.toTimeString().substring(0, 5);
                    $(timeGroups[i]).find(".EndTime").val(adjustedEndTime);
                }
            }
        }
    }
        </script>

    <div>
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-alarm"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-alt"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-app"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-archive"></i></button>   
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-asterisk"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-at"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-award"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-back"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-backspace"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bag"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-battery"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bell"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bezier"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bicycle"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-binoculars"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-book"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bookmark"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bookmarks"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bookshelf"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bootstrap"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-border"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-box"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-braces"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bricks"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-briefcase"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-broadcast"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-brush"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bucket"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bug"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-building"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bullseye"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-calculator"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-calendar"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-camera"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-capslock"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cart"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cash"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cast"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-chat"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-check"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-circle"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-clipboard"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-clock"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cloud"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-clouds"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cloudy"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-code"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-collection"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-columns"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-command"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-compass"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cone"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-controller"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cpu"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-crop"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cup"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-cursor"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-dash"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-diamond"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-disc"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-discord"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-display"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-dot"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-download"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-droplet"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-earbuds"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-easel"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-egg"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-eject"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-envelope"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-eraser"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-exclamation"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-exclude"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-eye"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-eyedropper"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-eyeglasses"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-facebook"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-file"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-files"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-film"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-filter"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-flag"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-flower"></i></button>
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-folder"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-fonts"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-forward"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-front"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-fullscreen"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-funnel"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-gear"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-gem"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-geo"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-gift"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-github"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-globe"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-google"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-grid"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hammer"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-handbag"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hash"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hdd"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-headphones"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-headset"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-heart"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-heptagon"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hexagon"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hourglass"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-house"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hr"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-hurricane"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-image"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-images"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-inbox"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-inboxes"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-info"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-instagram"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-intersect"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-journal"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-journals"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-joystick"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-justify"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-kanban"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-key"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-keyboard"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-ladder"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-lamp"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-laptop"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-layers"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-lightbulb"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-lightning"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-link"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-linkedin"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-list"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-lock"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-mailbox"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-map"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-markdown"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-mask"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-megaphone"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-mic"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-minecart"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-moisture"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-moon"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-mouse"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-newspaper"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-nut"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-octagon"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-option"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-outlet"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-palette"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-paperclip"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-paragraph"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pause"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-peace"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pen"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pencil"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pentagon"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-people"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-percent"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-person"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-phone"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pin"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-pip"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-play"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-plug"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-plus"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-power"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-printer"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-puzzle"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-question"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-rainbow"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-receipt"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-record"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-reply"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-rss"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-rulers"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-save"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-scissors"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-screwdriver"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-search"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-server"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-share"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-shield"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-shift"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-shop"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-shuffle"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-signpost"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sim"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-slack"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-slash"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sliders"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-smartwatch"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-snow"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-soundwave"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-speaker"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-speedometer"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-spellcheck"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-square"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stack"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-star"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stars"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stickies"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sticky"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stop"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stoplights"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-stopwatch"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-subtract"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sun"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sunglasses"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sunrise"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-sunset"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-table"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tablet"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tag"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tags"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-telegram"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-telephone"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-terminal"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-textarea"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-thermometer"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-toggles"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tools"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tornado"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-trash"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tree"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-triangle"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-trophy"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-truck"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tsunami"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-tv"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-twitch"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-twitter"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-type"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-umbrella"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-union"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-unlock"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-upc"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-upload"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-vinyl"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-voicemail"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-vr"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-wallet"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-watch"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-water"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-whatsapp"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-wifi"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-wind"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-window"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-wrench"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-x"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-youtube"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-bank"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-coin"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-mastodon"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-messenger"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-recycle"></i></button>  
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-reddit"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-skype"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-translate"></i></button> 
<button type="button" class="btn btn-primary mb-2 mr-2"><i class="bi bi-safe"></i></button>
</div>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <!-- 부트스트랩 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- Core theme JS-->
    <script src="js/scripts.js"></script>
		
	</body>
</html>