//******    작성자 : 구동현        *****//
//******    작성일 : 23.12.15     *****//
//******    수정일 : 23.01.14     *****//

var dateCells = $('.tablearea td'); // 달력 cell 하나하나를 지정하기 위해
var startEmpty = true; // 시작일이 빈 공간인지 여부
var hoverDayCount = 0; // 시작날과 끝날의 사이에 hover 효과를 카운트로 구별하기 위해  
var count = 0; // 빈공간을 제외시키고 cell 하나당 아이디를 날짜로 부여하기 위해 
var day = 0; // 날짜
var startDDay; // 사용자가 시작하는 날짜 지정
var endDDay; // 사용자가 끝나는 날짜 지정

// 선택한 날짜를 배열에 저장하기 위해 
var selectedDates = [];	

// 달력 cell 하나하나를 돌려 아이디를 지정하고 빈공간을 제외시키기 위해 
dateCells.each(function (index, cell) {
    // cell 텍스트가 비워있다면 "" 공백 처리 
    if ($(cell).text().trim() === "") {
        // 시작일이 빈 공간이라면, 다음부터 인덱스를 시작
        startEmpty = false;
        // 빈공간에 카운트 세기 
        count++;

        $(cell).removeClass('hover-day');
    }

    // 모든 달력에서 빈공간을 빼면 날짜가 있는 날을 알 수 있다 
    day = (index - (count-1));  // 날짜는 1부터 시작

    //getSeleceted...() 함수는 tripplan 안에 있는 달력 달과 년도를 받아오기 위해 
    // 이번달을 지정하기위해 선언 
    var prevMonth = getSelectedMonth() - 1;
    // 이건 년도 
    var prevYear =  getSelectedYear();

    // 이번 달이 12월이다 그럼 다음년도에 + 1 을 지정해주고 
    // 다음 달은 1월이 되도록 
    if (prevMonth == 12) {
        prevYear++;
        prevMonth = 1;
    } else {
        // 아닐 경우 현재 달에 + 1
        prevMonth++; // 현재 달을 기준으로 계산할 경우 다음 달로 넘어가는 상황이므로 1 증가
    }

    // date로 변환하여 정확한 달의 마지막 날짜를 구하기 위해 
    var lastDayOfPrevMonth = new Date(prevYear, prevMonth, 0).getDate();

    // 날짜가 마지막 날짜보다 클때 
    if (day > lastDayOfPrevMonth) {
        // 다음 달로 넘어가야 할 경우
        prevMonth++;
        // 지금 날짜 카운터에  (빈칸 카운터 + 마지막 날짜)를 빼면은 0 이므로 + 1
        day = (index - count - lastDayOfPrevMonth) + 1;

    } else if (day == lastDayOfPrevMonth) {
        // 마지막 날짜와 같다 그럼 마지막 날짜이므로 (지금 날짜 카운터 - 빈칸 카운터)면 하루가 모자르므로 +1
        day = (index - count + 1);

    }

    // 달이 12를 넘어가면 연도를 1 증가시켜 다음 해로 이동
    if (prevMonth > 12) {
        // 다음년도를 위해 +1
        prevYear++;
        // 년도가 바뀌므로 1로 
        prevMonth = 1;
    }

    // 하나하나의 cell 아이디 구하기 
    // 이번년도 - 이번달이 10보다 작으면 0을 출력하고 아니면 공백
    // 왜냐면 10월달이면 앞에 1이 있으므로 공백을 해야 맞는다 아니면 010 이 아이디에 지정됨
    // 날짜도 같다. 
    var cellId = prevYear + '-' + (prevMonth < 10 ? '0' : '') + prevMonth + '-' + (day < 10 ? '0' : '') + day;
    $(cell).attr('id', cellId);
    
    // 하나하나의 cell=달력날짜를 클릭할 경우 이벤트 발생
    $(cell).on('click', function () {
        // 클릭한 날짜를 아이디 값으로 사용
        var clickedDate = cellId;
        // 클릭 시점의 달 사용
        var clicedMonth = prevMonth; 
        // 클릭 시점의 연도 사용
        var clickedYear = prevYear;   

        // 클릭한 날짜를 배열에 추가하기 위해 
        if ($.inArray(clickedDate, selectedDates) === -1) {
            // 클릭한 날짜를 배열에 넣는다 이것으로 시작날짜와 끝날짜를 구할 수 있다
            selectedDates.push(clickedDate);

            // 배열이 3개 이상이면 ?
            if (selectedDates.length > 2) {
                // 배열이 3개 이상이면 처음 2개 제거 (새로운 범위 설정) .shift() 가 지우는 함수
                selectedDates.shift();
            }

            // 배열이 하나면?
            if (selectedDates.length == 1) {
                // 시작날짜를 배열첫번째로 지정한다 
                // 이것은 앞서 배열을 지웠을 경우 배열의 오류가 날까봐 다시 지정
                startDDay = selectedDates[0];
                // 시작 날짜와 끝 날짜가 같을 경우 설정
                endDDay = startDDay; 

                // 시작 날짜에 클래스 추가한다 
                var startCell = $('#' + startDDay);
                if (startCell.length) {
                    startCell.addClass('selected-day');
                }
            // 여기서 배열이 2개면?
            } else if (selectedDates.length == 2) {
                // 시작한 날짜를 배열 첫번째로 
                startDDay = selectedDates[0];
                // 두번째 클릭한 날짜를 배열 두번째로 
                endDDay = selectedDates[1];
                
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

            // 시작 날짜와 끝 날짜 정확하게 비교하귀 위해 date 로 변환하여 선언
            var startDateObj = new Date(startDDay);
            var endDateObj = new Date(endDDay);

            //시작날짜가 끝 날짜보다 클경우에는 시작과 끝 날짜를 변경해야함
            if (startDateObj > endDateObj) {
                // 시작 날짜가 끝 날짜보다 이후일 경우 두 날짜를 교체
                var temp = startDDay;
                startDDay = endDDay;
                endDDay = temp;
              
            }
        }
        // if ($.inArray(clickedDate, selectedDates) === -1) { 끝!!

        
        // 선택한 날짜를 다시 돌려서..
        // 이번에는 선택한 날짜에 hoverday 클래스를 지정하기 위해
        dateCells.each(function (i, cell) {
            if ($.inArray(cell.id, selectedDates) === -1) {
                $(cell).removeClass('selected-day');
            }
        
            // 현재 날짜가 이미 hover-day 클래스를 가지고 있는지 확인
            var isHovered = $(cell).hasClass('hover-day');

            // 텍스트가 null 이면 hover-day 클래스 삭제
            if ($(cell).text().trim() === "") {
                if (isHovered) {
                    $(cell).removeClass('hover-day');
                    hoverDayCount--;
                }
            } else {
                // 현재 날짜가 범위 내에 있으면서 hover-day 클래스를 가지고 있지 않으면 추가하고 카운트 증가
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
            }

            
        });
        
    });
    // $(cell).on('click', function () { 끝!!
    
});
// dateCells.each(function (index, cell) { 끝!!


// 달력을 누르면 달력 팝업이 나타나는 함수 
$(".trvl_day").on("click", function () {
    $("#CalendarTableara").css("display", "block");
});

// 달력에 뒷 검정색 배경을 누르면 달력이 사라지는 함수
$("#datepickerBG").on("click", function (event) {
    if ($(event.target).closest("#datepicker").length === 0) {
        $("#CalendarTableara").css("display", "none");
    }
});


// 저장된 데이터 불러올 때 달력에 선택했다는 표시 뜨게 하기 
// 달력을 다시 선택할려고 누를때
$(".lfBz").on("click", function () {
    // 기존 달력 텍스트 값을 받아서 시작날과 마지막날 구분하기
    // .NITa-date .trvl_day == 2024.01.29(월) - 2024.02.02(금)
    var NITaDate = $(".NITa-date .trvl_day").text().trim().split("-");
    // 시작날에 (요일) 없애기 
    var startDateReplace = NITaDate[0].replace(/\(.*?\)/g, "").trim();
    // 마지막날에 (요일) 없애기 
    var endDateReplace = NITaDate[1].replace(/\(.*?\)/g, "").trim();

    // 시작날에 . 을 - 로 고치기 
    var startDateRe = startDateReplace.replace(".","-").trim().replace(".","-").trim();
    // 마지막날에 . 을 - 로 고치기 
    var endDateRe = endDateReplace.replace(".","-").trim().replace(".","-").trim();
    // 시작날에 처음에 클래스 줘서 선택했다는 표시 주기 
    $("#"+startDateRe).addClass("selected-day");
    // 마지막날에 처음에 클래스 줘서 선택했다는 표시 주기 
    $("#"+endDateRe).addClass("selected-day");
  
    // 시작날에서 마지막 날짜를 구해오기 
    var startNum =  $("#"+startDateRe).text().trim().split("-")[0];

    // 시작날에서 마지막 날짜를 제외한 년도와 월 구해오기 
    var stYearMonthPart = startDateRe.match(/^\d{4}-\d{2}/)[0];

    // 마지막날에서 마지막 날짜를 구해오기 
    var endNum =  $("#"+endDateRe).text().trim().split("-")[0];

    // 마지막날에서 마지막 날짜를 제외한 년도와 월 구해오기 
    var edYearMonthPart = endDateRe.match(/^\d{4}-\d{2}/)[0];

    // 만약 마지막날이 1일 이라라면 
    if (parseInt(endNum) == 1 ){
        // i 는 시작한날에 다음날 부터 + 3일 
        for (var i = (parseInt(startNum) + 1); i <= (parseInt(startNum) + 3); i++) {
            // 시작날은 시작날에 년도와 월 + i 가 만약 10이 넘지 않는다면 기존의 0 채워주기 
            var strNum = stYearMonthPart + '-' + (i < 10 ? '0' : '') + i;
            $("#" + strNum).addClass("hover-day");
           
        }
    // 만약 시작날이 마지막날보다 클 경우에 
    } else if (parseInt(endNum) < (parseInt(startNum)) ) {
        // i 는 시작한날에 다음날 부터 시작날 + 마지막날 을 계산한 날까지
        for (var i = (parseInt(startNum) + 1); i <= (parseInt(startNum) + parseInt(endNum)); i++) {
            // 시작날은 시작날에 년도와 월 + i 가 만약 10이 넘지 않는다면 기존의 0 채워주기  
            var strNum = stYearMonthPart + '-' + (i < 10 ? '0' : '') + i;
            // 마지막날은 마지막날에 년도와 월 + i 가 만약 10이 넘지 않는다면 기존의 0 채워주기 
            // 기존의 i 는 마지막날과 시작날을 더했으므로 다시 시작날 빼주기  
            var edNum = edYearMonthPart + '-' + (endNum < 10 ? '0' : '') + (i - parseInt(startNum)-1);
            $("#" + strNum).addClass("hover-day");
            $("#" + edNum).addClass("hover-day");
        }
      
    } else {
        // 만약 시작날보다 마지막날이 클 경우에 
        for(var i = (parseInt(startNum)+1); i < endNum; i++ ){
             // 시작날은 시작날에 년도와 월 + i 가 만약 10이 넘지 않는다면 기존의 0 채워주기
            var strNum = stYearMonthPart + '-' + (startNum < 10 ? '0' : '') + i;
            $("#"+strNum).addClass("hover-day");
        }
    }

});




$(".dosi").on("click", function (e) {
    var sidoValue = $(e.target).text();
    var dosi = $(".sidoValues").val(sidoValue);
    dosi = dosi[0].value;

    $.ajax({
        url : '/user/save_dosi.do',
        type : 'POST',
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



function createSpotBox(numDays){
    createSpotContainer(numDays);
    createButtons(numDays);
}

// tabId를 매개변수로 받는 activateTab이라는 함수를 정의합니다.
function activateTab(tabId) {
    // 'nav-link' 클래스를 가진 모든 요소를 선택하고 'buttons' 변수에 저장합니다.
    var buttons = document.querySelectorAll('.nav-link');

    // 'spot-container' 클래스를 가진 모든 요소를 선택하고 'tabContents' 변수에 저장합니다.
    var tabContents = document.querySelectorAll('.spot-container');

    // tabId에서 정규 표현식을 사용하여 숫자 부분을 추출합니다.
    numericPart = tabId.match(/\d+/)[0];

    // getNavlinkDay 함수를 호출합니다. 
    getNavlinkDay();

    // 모든 버튼을 반복하며 각각에서 'active' 클래스를 제거합니다.
    buttons.forEach(function (button) {
        button.classList.remove('active');
    });

    // 지정된 tabId를 가진 버튼을 찾아 'active' 클래스를 추가합니다.
    var activeButton = document.querySelector("#"+tabId+"Tab");
    activeButton.classList.add('active');

    // 모든 tabContents에 대해 반복합니다.
    tabContents.forEach(function (content) {
        // 각 content의 id가 tabId와 일치하는지에 따라 'active' 클래스를 토글합니다.
        content.classList.toggle('active', content.id === tabId);

        // 만약 content가 'spotListPage' 클래스를 가진 자식 요소를 가지고 있다면 해당 요소의 'active' 클래스를 토글합니다.
        var spotListPage = content.querySelector('.spotListPage');
        if (spotListPage) {
            spotListPage.classList.toggle('active', content.id === tabId);
        }
    });
}

function createSpotContainer(numDays) {
    $("#nav-tabContent").empty();
    $('#nav-financeContent').empty();

    for (var i = 1; i <= numDays; i++) {
        var container = $('<div>', {
            class: 'tab-pane fade sortable',
            role: 'tabpanel',
            'aria-labelledby': 'nav-day'+i+'-tab',
            tabindex: '0',
            id: 'day' + i,
        });

        $("#nav-tabContent").append(container);
    }
     for (var i = 1; i <= numDays; i++) {
         var finContainer = $('<div>', {
             class: 'tab-pane fade expenseTableDiv',
             role: 'tabpanel',
             'aria-labelledby': 'nav-finance'+i+'-tab',
             tabindex: '0',
             id: 'finance' + i,
            //  style: 'height:500px;',
         }).html(
            '<table class="ft-face-nm" style="display:table; width:100%;">'+
                '<thead style="display:table; width:100%;">'+
                    '<tr class="" style="text-align:center;display:table; width:100%;">'+
                        '<td style="width:18%">일차</td>'+
                        '<td style="width:42%">비용내용</td>'+
                        '<td style="width:30%">비용</td>'+
                        '<td style="width:10%">삭제</td>'+
                    '</tr>'+
                '</thead>'+
                '<tbody id="expenseTableBody' + i + '" class="overflow-y-auto" style="display:block;min-width:253px; max-height:calc(100vh - 390px);">' +
                '</tbody>'+
                '<div style="display: flex; justify-content: center; flex-direction: column; position:absolute; bottom:0px;">'+
                    '<div>'+
                    '<button type="button" id="btn" onclick="showExpenseInputText()" class="btn btn-primary mb-2 mr-2" style="width: 160px; padding: 5px;">행 추가</button>'+
                    '<button type="button" id="btn" onclick="addExpense()" class="btn btn-primary mb-2" style="width: 160px; padding: 5px;">저장</button>'+
                '</div>'+
            '</table>'
         );

         $("#nav-financeContent").append(finContainer);
     }

}

function createButtons(numDays) {
    $('#nav-tab').empty();
    $('#nav-dayfinance').empty();

    for (var i = 1; i <= numDays; i++) {
        var isActive = (i === 1);



        var button = $('<button>', {
            type: 'button',
            class: 'nav-link haru drag-handle' ,
            id: 'day' + i + 'Tab',
            'data-bs-toggle': 'tab',
            'data-bs-target': '#day' + i,
            role: 'tab',
            'aria-controls': 'day' + i,
            'aria-selected': isActive.toString() ,
        }).html(
            '<span class="loadDay">'+ i + '</span> 일차'
        );
        var buttonItem = $('<div>', {
            class: 'nav-item' ,
        }).html(button);
        
        $('#nav-tab').append(buttonItem);
        
        var financeBtn = $('<button>', {
            type: 'button',
            class: 'nav-link',
            id: 'day' + i + 'finance',
            'data-bs-toggle': 'tab',
            'data-bs-target': '#finance1' ,
            role: 'tab',
            'aria-controls': 'finance1',
            'aria-selected': isActive.toString()  
        }).html(
            '<span class="loadDay">'+ i + '</span> 일차'
        );

        $('#nav-dayfinance').append(financeBtn);

    }
    if( numDays < 6  && numDays > 1 ){
        var plusbutton = $('<button>', {
            type: 'button',
            class: 'nav-link dayUpdate' ,
            id: 'dayDashTab',
            role: 'tab',
        }).html(
            '<i class="bi bi-dash"></i>'
        );
        $('#nav-tab').append(plusbutton);
    }

    if( numDays < 5 ){
        var plusbutton = $('<button>', {
            type: 'button',
            class: 'nav-link dayUpdate' ,
            id: 'dayPlusTab',
            role: 'tab',
        }).html(
            '<i class="bi bi-plus-lg"></i>'
        );
        $('#nav-tab').append(plusbutton);
    }

}

var dayClick = 0;
 $(document).on("click", ".dayUpdate", function () {
    dayClick++;
    var NITaDate = $(".NITa-date .trvl_day").text().trim().split("-");
    // 시작날에 (요일) 없애기 
    var startDateReplace = NITaDate[0].replace(/\(.*?\)/g, "").trim();
    // 마지막날에 (요일) 없애기 

    var endDateReplace = NITaDate[1].replace(/\(.*?\)/g, "").trim();
    var startDDay = startDateReplace.replace(".","-").trim().replace(".","-").trim();
    var endDDay = endDateReplace.replace(".","-").trim().replace(".","-").trim();
    var sliceEndDay = endDDay.split('-');
    var YearDate = sliceEndDay[0];
    var MonthDate = sliceEndDay[1];
    var DayDate = sliceEndDay[2];
    var intDayDate = parseInt(DayDate);
    // plusBtn이 클릭되었을 때 실행될 함수 등록

    if ($(this).attr('id') === "dayPlusTab" ){
        intDayDate += 1;
    } else {
        if (dayClick < 2) {
            alertBody.html('');
            alertBody.html('일차를 줄이면 선택한 장소가 사라집니다 😢 <br/> 신중하게 선택해주세요');
            $(".modal-footer").html('');
            $(".modal-footer").html(
                '<button id="intDayDelete" type="button" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">확인</button>'
            );

            alertShowBtn.click();
    
        } else {
            intDayDelete();
        }

        function intDayDelete() {
            intDayDate -= 1;
        }
    }
    


    // 날짜 갱신
    endDDay = YearDate + "-" + MonthDate + "-" + (intDayDate < 10 ? "0" : "") + intDayDate;

    endDate = new Date(endDDay);
    $.ajax({
        url: '/user/save_day.do',
        type: 'POST',
        data: {
            startDay: startDDay,
            endDay: endDDay
        },
        success: function (result) {

            $("#CalendarTableara").css("display", "none");
            createDefault();

        },
        error: function (e) {

        }

    });

});



function saveDay() {
    var startDate = new Date(startDDay);
    var endDate = new Date(endDDay);
    var dayDifference = (endDate - startDate) / (1000 * 60 * 60 * 24);

    if (dayDifference >= 5) {
        alert('최대 5일을 선택할 수 있습니다.');
        // 달력 초기화하고 $(cell) 에 클래스가 있다면 지우고 첫째날부터 다시 선택할 수 있도록 처리
        dateCells.removeClass('selected-day');
        dateCells.removeClass('hover-day');
        selectedDates = [];
    } else {
        $.ajax({
            url: '/user/save_day.do',
            type: 'POST',
            data: {
                startDay: startDDay,
                endDay: endDDay
            },
            success: function (result) {

                $("#CalendarTableara").css("display", "none");
                createDefault();

            },
            error: function (e) {

            }

        });
    }
}

function showCalendar(){
	
	$.ajax({
	          url: '/show_calendar.do',
	          type: 'POST',
	          success: function(result) {
				  
	          },
	          error:function() {
				  
	          }
	      });
	
}



