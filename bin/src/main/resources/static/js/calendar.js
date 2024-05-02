//******    작성자 : 구동현        *****//
//******    작성자 : 구동현        *****//
//******    작성일 : 23.12.15     *****//



// 달력 구현 ...
var dateCells = $('.tablearea td');
var startEmpty = true; // 시작일이 빈 공간인지 여부
var hoverDayCount = 0;
var count = 0;
var startDDay;
var endDDay;

var selectedDates = [];	

$(document).ready(function() {
	
    dateCells.each(function (index, cell) {
        if ($(cell).text().trim() === "") {
            // 시작일이 빈 공간이라면, 다음부터 인덱스를 시작
            startEmpty = false;
            count++;
        }

        var day = (index - count) + 1; // 날짜는 1부터 시작
        var prevMonth = getSelectedMonth() - 1;
        var prevYear =  getSelectedYear();

        if (prevMonth == 12) {
            prevYear++;
            prevMonth = 1;
        } else {
            prevMonth++; // 현재 달을 기준으로 계산할 경우 다음 달로 넘어가는 상황이므로 1 증가
        }

        var lastDayOfPrevMonth = new Date(prevYear, prevMonth, 0).getDate();

        if (day > lastDayOfPrevMonth) {
            // 다음 달로 넘어가야 할 경우
            prevMonth++;
            day = (index - count - lastDayOfPrevMonth) + 1;
        } else if (day == lastDayOfPrevMonth) {
            day = "";
        }

        // 달이 12를 넘어가면 연도를 1 증가시켜 다음 해로 이동
        if (prevMonth > 12) {
            prevYear++;
            prevMonth = 1;
        }

        var cellId = prevYear + '-' + (prevMonth < 10 ? '0' : '') + prevMonth + '-' + (day < 10 ? '0' : '') + day;
        $(cell).attr('id', cellId);


	    
	    //var startDate = null;
	    
        $(cell).on('click', function () {
            var clickedDate = cellId; // 클릭한 날짜를 아이디 값으로 사용
            var clicedMonth = prevMonth; // 클릭 시점의 달 사용
            var clickedYear = prevYear;   // 클릭 시점의 연도 사용



			//console.log(selectedDates);


            // 클릭한 날짜를 배열에 추가
            if ($.inArray(clickedDate, selectedDates) === -1) {
              	//console.log("Adding to selectedDates:", clickedDate);
                selectedDates.push(clickedDate);
               	//console.log("Dates after click:", selectedDates);

                if (selectedDates.length > 2) {
                    // 배열이 3개 이상이면 처음 2개 제거 (새로운 범위 설정)
                   selectedDates.shift();
                   //console.log(selectedDates);
                }

                if (selectedDates.length == 1) {
                    startDDay = selectedDates[0];
                    endDDay = startDDay; // 시작 날짜와 끝 날짜가 같을 경우 설정
                    //console.log("시작 날과 끝 날을 설정합니다.");
                    // 시작 날짜에 클래스 추가
                    var startCell = $('#' + startDDay);
                    if (startCell.length) {
                        startCell.addClass('selected-day');
                    }
                } else if (selectedDates.length == 2) {
                    startDDay = selectedDates[0];
                    endDDay = selectedDates[1];
                    //console.log("시작 날 : " + startDDay);
                    //console.log("끝 날 : " + endDDay);

                    // 시작 날짜에 클래스 추가
                    var startCell = $('#' + startDDay);
                    if (startCell.length) {
                        startCell.addClass('selected-day');
                    }

                    // 끝 날짜에 클래스 추가
                    var endCell = $('#' + endDDay);
                    if (endCell.length) {
                        endCell.addClass('selected-day');
                    }
                }

                // 시작 날짜와 끝 날짜 비교 후 교체
                var startDateObj = new Date(startDDay);
                var endDateObj = new Date(endDDay);

                if (startDateObj > endDateObj) {
                    // 시작 날짜가 끝 날짜보다 이후일 경우 두 날짜를 교체
                    var temp = startDDay;
                    startDDay = endDDay;
                    endDDay = temp;
                    //console.log("시작 날과 끝 날을 교체합니다.");
                    //console.log("교체 된 시작 날 : " + startDDay);
                    //console.log("교체 된 끝 날 : " + endDDay);
                }

                
               

            }
            // if ($.inArray(clickedDate, selectedDates) === -1) { 끝!!

            
            
            dateCells.each(function (i, cell) {
                if ($.inArray(cell.id, selectedDates) === -1) {
                    $(cell).removeClass('selected-day');
                }
            
                // 현재 날짜가 이미 hover-day 클래스를 가지고 있는지 확인
                var isHovered = $(cell).hasClass('hover-day');
            
                if ((startDDay < cell.id && cell.id < endDDay) || (endDDay < cell.id && cell.id < startDDay)) {
                    if (!isHovered) {
                        // 현재 날짜가 hover-day 클래스를 가지고 있지 않으면 추가하고 카운트 증가
                        $(cell).addClass('hover-day');
                        hoverDayCount++;
                    }
                } else {
                    if (isHovered) {
                        // 현재 날짜가 hover-day 클래스를 가지고 있으면 제거하고 카운트 감소
                        $(cell).removeClass('hover-day');
                        hoverDayCount--;
                    }
                }
            });
            
            // hover-day 클래스 개수가 4개일 때 알림 창 띄우고 달력 초기화
//            if (hoverDayCount >= 4) {
//                //alert('최대 5일을 선택할 수 있습니다.');
//                // 달력 초기화하고 $(cell) 에 클래스가 있다면 지우고 첫째날부터 다시 선택할 수 있도록 처리
//                //dateCells.removeClass('selected-day');
//                //dateCells.removeClass('hover-day');
//                //selectedDates = [];
//            }

            // 요일을 반환하는 함수
            function getDayOfWeek(dateString) {
                const date = new Date(dateString);
                const days = ['일', '월', '화', '수', '목', '금', '토'];
                return days[date.getDay()];
            }

		});
		// $(cell).on('click', function () { 끝!!
		
           
        

    });
    // dateCells.each(function (index, cell) { 끝!!
    
    
    // 달력 나타내기 
    $(".trvl_day").on("click", function () {
        $("#CalendarTableara").css("display", "block");
    });

    // 달력 사라지기 
    $("#datepickerBG").on("click", function (event) {
        if ($(event.target).closest("#datepicker").length === 0) {
            $("#CalendarTableara").css("display", "none");
        }
    });

    // #datepicker 안에 있는 #CanlenderBtn 클릭시 달력 사라지게 하기
//    $("#datepicker #CanlenderBtn").on("click", function () {
//        $("#CalendarTableara").css("display", "none");
//    });

    //var numericPart = "";    
                
    
    
    $(".dosi").on("click", function (e) {
		var sidoValue = $(e.target).text();
		var dosi = $(".sidoValues").val(sidoValue);
		dosi = dosi[0].value;

		$.ajax({
		url : '/save_dosi.do',
		type : 'get',
		data : {
			dosi : dosi
		},
		success : function(result){
			
			createDefault();
			$('.sidoModal').css("display", "none");
					
		},error : function(e){
								
		}
						
	});
		
	});

   
	
	
});


function createSpotBox(numDays){
    createSpotContainer(numDays);
    createButtons(numDays);
}

function activateTab(tabId) {
    var buttons = document.querySelectorAll('.nav-link');
    var tabContents = document.querySelectorAll('.spot-container');
    numericPart = tabId.match(/\d+/)[0];
    //console.log(numericPart); // 출력: 1
    getNavlinkDay();
    // 모든 버튼에서 'active' 클래스 제거
    buttons.forEach(function (button) {
        button.classList.remove('active');
    });

    // 클릭한 버튼에 'active' 클래스 추가
    var activeButton = document.querySelector("#"+tabId+"Tab");
        activeButton.classList.add('active');

    tabContents.forEach(function (content) {
        content.classList.toggle('active', content.id === tabId);
        var spotListPage = content.querySelector('.spotListPage');
        if (spotListPage) {
        spotListPage.classList.toggle('active', content.id === tabId);
        }
    });
}


function createSpotContainer(numDays) {
    $("#findStepPlaces").empty();
    for (var i = 1; i <= numDays; i++) {
        var containerText = i + '일차';
        //var isActive = (i === 1); // 첫 번째 버튼은 활성화 상태로 설정
        
        // 생성한 요소를 jQuery 객체로 저장
        var container = $('<div>').attr({
			//class: 'left-plan-container bg-white mh-3 h-full spot-container z-11' + (isActive ? ' active' : ''),
	        class: 'left-plan-container bg-white mh-3 h-full spot-container z-11',
            id: 'day' + i,
        }).html(
            '<div class="p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded">'+ containerText +'</div>' +
            '<div style="position:absolute; right:127px; top:16px;"><button type="button" ; class="btn btn-outline-primary createMapLine showTimeSetModalBtn" onclick="showTimeSetModal()";>시간설정</button></div>' +
            '<div style="position:absolute; right:27px; top:16px;"><button type="button"  onclick="searchSpotPlace()"; class="btn btn-outline-primary createMapLine">지도생성</button></div>' +
            '<div class="flex justify-center" style="height: calc(100% - 200px); margin-top: 10px;">' +
            '<div></div>' + 
            //'<div id="spotListPage' + i + '" class="spotListPage list-group w-full mx-2 ' + (isActive ? 'active' : '') + '" style="overflow-y: auto;"></div></div>'
            '<div id="spotListPage' + i + '" class="spotListPage list-group w-full mx-2 " style="overflow-y: auto;"></div></div>'

        );

        // 생성한 요소를 DOM에 추가
        $("#findStepPlaces").append(container);
    }

   
      
    var containerBtn = $('<div>').attr({
        class: 'relative h-full block',
        style: 'width: 350px' ,
        id: 'findStepPlacesSlideBtn'
    }).html(
        '<button aria-expanded="true" class="sc-agadnx jxEMAm p-2 bg-white"><span style="font-size: 0px;"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="14" viewBox="10 0 20 24"><path d="M6.028 0v6.425l5.549 5.575-5.549 5.575v6.425l11.944-12z"/></svg></span></button>'
    );
    // 생성한 요소를 DOM에 추가
    $("#findStepPlaces").append(containerBtn);

    $("#findStepPlacesSlideBtn .sc-agadnx").on("click", function () {
        $("#findStepPlaces").toggleClass('active');
    });

}

function createButtons(numDays) {
    $('#StepByStep').empty();
    for (var i = 1; i <= numDays; i++) {
        var buttonText = i + '일차';
        var isActive = (i === 1); // 첫 번째 버튼은 활성화 상태로 설정

        var button = $('<button>').attr({
            type: 'button',
            class: 'p-2 NITa NITa-roomsGuests NITa-hasValue NITa-mod-presentation-expanded' + (isActive ? ' active' : ''),
            id: 'day' + i + 'Tab'
            // onclick: "activateTab('day" + i + "')"
        }).text(buttonText);

        let dayId = 'day' + i;
        $('#StepByStep').append(button);
        button.on('click', function () {
            activateTab.call(this, dayId);
        });
    }
}

function activateTab(tabId) {
    // 원하는 일차 탭에 대한 로직을 구현
    //console.log(tabId + ' 탭이 활성화되었습니다.');
    // 탭에 'active' 클래스 추가
    $("#nav-tab .dayTab").each(function() {
        var idValue = $(this).attr("id"); // .attr()에 직접 "id"를 사용
        var idValue2 = idValue.replace("Tab", "");
    
        if (tabId === idValue2) {
            $(this).addClass('active');
        } else {
            $(this).removeClass('active');
        }
    });
    
    $(".spot-container").each(function () {
        var spotDay = $(this).attr("id"); // id 속성을 가져옴

        if (tabId === spotDay) {
            // 탭이 일치하는 경우 해당 .spot-container에 'active' 클래스를 추가
            $(this).addClass('active');
        } else {
            // 탭이 일치하지 않는 경우 해당 .spot-container에서 'active' 클래스를 제거
            $(this).removeClass('active');
        }
    });
}

function saveDay(){

	var startDate = new Date(startDDay);
	var endDate = new Date(endDDay);

	var dayDifference = (endDate - startDate) / (1000 * 60 * 60 * 24);

	
	if(dayDifference >= 5){
		alert('최대 5일을 선택할 수 있습니다.');
        //달력 초기화하고 $(cell) 에 클래스가 있다면 지우고 첫째날부터 다시 선택할 수 있도록 처리
		dateCells.removeClass('selected-day');
		dateCells.removeClass('hover-day');
		selectedDates = [];
	}else{
		$.ajax({
			url : '/save_day.do',
			type : 'get',
			data : {
				startDay : startDDay,
				endDay : endDDay
			},
			success : function(result){
				
				$("#CalendarTableara").css("display", "none");
				createDefault();
						
			},error : function(e){
									
			}
						
		});
	}

}

function showCalendar(){
	
	$.ajax({
	          url: '/show_calendar.do',
	          type: 'get',
	          success: function(result) {
				  
	          },
	          error:function() {
				  
	          }
	      });
	
}



