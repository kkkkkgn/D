//******    작성자 : 구동현        *****//
//******    편집자 : 박수진        *****//
//******    작성일 : 23.12.15     *****//

// 달력 구현 ...

var dateCells = $('.tablearea td');
var startEmpty = true; // 시작일이 빈 공간인지 여부
var hoverDayCount = 0; // 시작날과 끝날의 사이에 hover 효과를 카운트로 구별하기 위해  
var count = 0; // 빈공간을 제외시키고 cell 하나당 아이디를 날짜로 부여하기 위해 
var day = 0; // 날짜
$(document).ready(function() {

	// 선택한 날짜를 배열에 저장하기 위해 
	var selectedDates = [];

	// 달력 cell 하나하나를 돌려 아이디를 지정하고 빈공간을 제외시키기 위해 
	dateCells.each(function(index, cell) {
		// cell 텍스트가 비워있다면 "" 공백 처리 
		if ($(cell).text().trim() === "") {
			// 시작일이 빈 공간이라면, 다음부터 인덱스를 시작
			startEmpty = false;
			// 빈공간에 카운트 세기 
			count++;

			$(cell).removeClass('hover-day');
		}

		// 모든 달력에서 빈공간을 빼면 날짜가 있는 날을 알 수 있다 
		day = (index - (count - 1));  // 날짜는 1부터 시작

		//getSeleceted...() 함수는 tripplan 안에 있는 달력 달과 년도를 받아오기 위해 
		// 이번달을 지정하기위해 선언 
		var prevMonth = getSelectedMonth() - 1;
		// 이건 년도 
		var prevYear = getSelectedYear();

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
		$(cell).on('click', function() {
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
			dateCells.each(function(i, cell) {
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
		
    });    
    
    // 달력 나타내기 
    $(".trvl_day").on("click", function () {
        $("#CalendarTableara").css("display", "block");
    });
	
    $(".userBtn").click(function() {
        $("#userLogin").show();
        $("#adminLogin").hide();
        $(".userBtn").addClass("active");
        $(".adminBtn").removeClass("active");
    });

    $(".adminBtn").click(function() {
        $("#userLogin").hide();
        $("#adminLogin").show();
        $(".adminBtn").addClass("active");
        $(".userBtn").removeClass("active");
    });

    /* 메뉴 구성 드롭박스 */
    var $dropdownToggle = $('.dropdown-toggle');
    var $dropdownMenu = $('.dropdown-menu');

    $dropdownMenu.on('mouseover', function() {
        $(this).css('display', 'block');
    });

    $dropdownMenu.on('mouseleave', function() {
        $(this).css('display', 'none');
    });

    $dropdownToggle.on('click', function() {
        var $dropdownMenu = $(this).next('.dropdown-menu');
        $dropdownMenu.css('display', 'block');
    });


    $(".yWJT-new-nav-ux").on('click', function () {
        // 요소에 'pRB0-expanded' 클래스가 있는지 확인
        var isExpanded = $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").hasClass('pRB0-expanded');

        // 클래스 토글
        if (isExpanded) {
            $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").removeClass('pRB0-expanded');
            $("#main").removeClass('JjjA-moved');
        } else {
            $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").addClass('pRB0-expanded');
            $("#main").addClass('JjjA-moved');
        }
    });

    $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").on("mouseenter", function () {
        $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").addClass('pRB0-expanded');
        $("#main").addClass('JjjA-moved');
    });
    $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").on("mouseleave", function () {
        $(".pRB0.pRB0-collapsed.pRB0-mod-variant-accordion").removeClass('pRB0-expanded');
        $("#main").removeClass('JjjA-moved');
    });


    $(".lfBz-field-outline div").on('click', function (event) {
        if ($(event.target).hasClass('iiio-submit')) {
            // 클릭한 요소가 iiio-submit 클래스를 가지고 있으면 YSUE-mod-visible 클래스 제거
            $(".YSUE").removeClass('YSUE-mod-visible');
            $(".sidoModal").css('display','none');
        } else {
            // iiio-submit 클래스를 가지고 있지 않으면 YSUE-mod-visible 클래스 추가
            $(".YSUE").addClass('YSUE-mod-visible');
        }
    });

    // 지역검색 시 나오는 팝업창 생성 및 제거 
    $('.dDYU-viewport').on({
        mouseenter: function () {
            // .dDYU-viewport .dDYU-content(검색 조건 창)에 마우스를 올렸을 때
            $(".YSUE").addClass('YSUE-mod-visible');
        },
        click: function (event) {
            // .dDYU-viewport(어두운 배경화면)를 클릭했을 때 팝업창 제거
            if ($(event.target).hasClass('dDYU-viewport') || $(event.target).closest('.dDYU-viewport .dDYU-content .QdG_').length > 0) {
                $(".YSUE").removeClass('YSUE-mod-visible');
                $(".sidoModal").css('display','none');
            }
        }
    });
    
    // .dDYU-viewport .dDYU-content .QdG_(업데이트)를 클릭했을 때 팝업창 제거
    $('.dDYU-viewport .dDYU-content .QdG_').on('click', function () {
        $(".YSUE").removeClass('YSUE-mod-visible');
        $(".sidoModal").css('display','none');
    });


    $(".pM26").on("click", function () {
        $(".Loading").css('display','block');
        
        $(".Loading").css('display','none');
        $(".sidoModal").css('display','block');
        
    });

	$(".fBan").on("click", function () {
        $(".Loading").css('display','block');
        $(".Loading").css('display','none');
        $(".headCountModal").css('display','block');
    });
    
    // 사용자 드롭다운 메뉴 보이기/ 감추기
    $("#rogin_label").on("click", function () {
        $(".ui-dialog-Popover").toggleClass("none");
    });
    // 사용자 드롭다운 메뉴 마우스 떠날때 감추기
    $(".ui-dialog-Popover").on("mouseenter", function () {
        $(".ui-dialog-Popover").removeClass("none");
    }).on("mouseleave", function () {
        $(".ui-dialog-Popover").addClass("none");
    });
    $(".sidoValues").html('서울특별시');
	$(".sidoValues").val('서울특별시');
	$(".dosi").on("click", function (e) {
		$(".sidoValues").html('');
		$(".sidoValues").val('');
		var sidoValue = $(e.target).text();
		$(".sidoValues").html(sidoValue);
		dosi = $(".sidoValues").val(sidoValue);
		dosi = dosi[0].value;
		
		$.ajax({
			url : '/user/accListByDosi.do',
			type : 'POST',
			data : {
				dosi : dosi
			},
			success : function(result){
				
				$('.sidoModal').css("display", "none");
						
			},error : function(e){
									
			}				
		});
	});
	
	$(".headCountOption").on("click", function (e) {
		var count = $(e.target).text();

		$(".peopleHeadCount").text('인원 ' + count);
		$(".headCountModal").css("display", "none");
		
	});
}); /***********window.ready()end**************/

// 도시 리스트 불러오기
function getDosi(dosi) {
	
    $.ajax({
        type: "POST",
        url: "/user/addressJson.do", // 실제 서버 엔드포인트
        data: {
            dosi: dosi
        },
        success: function(data) {
            // 서버에서 받은 응답 처리
            var jsonData = JSON.parse(data);
            var sido = $("#sido");
                            
            sido.empty();
            // JSON 데이터를 반복하여 div를 추가
            $.each(jsonData, function(index, value) {
                var div = $("<div>").attr('id', value).text(value);
                sido.append(div);
            });
        },
        error: function(error) {
            // 오류 처리
            console.error(error);
        }
    });
}

//// 날짜 출력 포맷 ////
// 요일 배열
var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];

// 포맷 함수 정의
function formatDateWithDayOfWeek(date) {
    var year = date.getFullYear();
    var month = date.getMonth() + 1; // 월은 0부터 시작하므로 1을 더합니다.
    var day = date.getDate();
    var dayOfWeek = daysOfWeek[date.getDay()];

    return `${year}. ${month}. ${day}.(${dayOfWeek})`;
}

function calendarOn() {
	// 새로운 날짜 객체 생성		
	var startDate = new Date(startDDay);
	var endDate = new Date(endDDay);
	var dayDifference = (endDate - startDate) / (1000 * 60 * 60 * 24);
	
	if(dayDifference >= 5){
		alert('최대 5일을 선택할 수 있습니다.');
        //달력 초기화하고 $(cell) 에 클래스가 있다면 지우고 첫째날부터 다시 선택할 수 있도록 처리
		dateCells.removeClass('selected-day');
		dateCells.removeClass('hover-day');
		selectedDates = [];
	} else if(dayDifference == 0 || isNaN(dayDifference)){
		alert('최소 2일을 선택하셔야 합니다.');
        //달력 초기화하고 $(cell) 에 클래스가 있다면 지우고 첫째날부터 다시 선택할 수 있도록 처리
		dateCells.removeClass('selected-day');
		dateCells.removeClass('hover-day');
		selectedDates = [];
	} else {
		// 포맷된 문자열 생성
		var formattedStartDate = formatDateWithDayOfWeek(startDate);
		var formattedEndDate = formatDateWithDayOfWeek(endDate);
		
		// 문자열 정렬 및 출력
		const stringDay = `${formattedStartDate} - ${formattedEndDate}`; 
		$('.trvl_day').html(stringDay);
		$("#CalendarTableara").css("display", "none");
	}	
}
//// 달력 포맷 끝 ////

//// 인원 설정 ////
function headCount() {
	
}
//// 인원 설정 끝 ////

// 검색 버튼을 눌렀을 때 시도를 검색 창에 넣어서 검색함
function searchDosi(){
    
    //$('#keyword').val('숙소 이름을 검색해 보세요!');
	
	initializeMapByDosi();
}


let paymentElem = document.querySelectorAll('.btn-payment');

Array.from(paymentElem).forEach(function(elem) {
	elem.addEventListener('click', function (event) {
		
		var returnValue = confirm('실제로 결제되지 않습니다. 그냥 진행 해주세요.');
		
		if(returnValue == false) {
			event.preventDefault();
		} else {
			
			
			var acc_id = $("#acc_id").val();
			var acc_fee = $("#accommodationFee").html().replaceAll(',','');
			var trvl_day = $('.trvl_day').html();
			var checkDay = trvl_day.split('-'); 
			var res_start = checkDay[0].trim();
			var res_end = checkDay[1].trim();
			var headCount = $('.peopleHeadCount').html();
			// 숫자가 아닌 문자열을 선택하는 정규식
			var regex = /[^0-9]/g;
			var res_guests = headCount.replace(regex, "");
			if(res_guests == "") {
				res_guests = '단체';
			}
			
			var payment = $(this).attr('id');
			
			//주문번호 생성
			//YYYYMMDD +랜덤숫자 
			const currentDate = new Date();
		    const year = currentDate.getFullYear();
		    const month = String(currentDate.getMonth() + 1).padStart(2, '0');
		    const day = String(currentDate.getDate()).padStart(2, '0');
		
		    // 랜덤한 4자리 숫자 생성
		    const randomDigits = Math.floor(1000 + Math.random() * 9000);
		
		    // 주문번호 생성 (YYYYMMDD + 랜덤숫자 6자리)
		    const orderNumber = `${year}${month}${day}${randomDigits}`;
		   
		   	var form = document.forms.kakaoPayForm;
	
		   	form.elements.orderNumber.value = orderNumber + acc_id;
		    form.elements.res_guests.value = res_guests;
		    form.elements.acc_id.value = acc_id;
		    form.elements.acc_fee.value = acc_fee;
		    form.elements.res_start.value = res_start;
		    form.elements.res_end.value = res_end;
		    
		    form.submit();
		}
	   	
	
	});

});







function reservateAccommodation() {
	if($("#checkinDate").text() == '체크인 날짜를 설정하셔야 합니다.' || $("#checkoutDate").text() == '체크아웃 날짜를 설정하셔야 합니다.' ) {
		alert('날짜를 먼저 정하셔야 합니다.');
		$('#reservationModal').modal('hide');
		$("#CalendarTableara").css("display", "block");
		
	} else {
		$('#reservationModal').modal('hide');
		$('#paymentModal').modal('show');
	}	
}
function closePaymentmodal(){
	$('#paymentModal').modal('hide');
}

function completeReservation() {
	$('#paymentModal').modal('hide');
	
	let reservateModal = new bootstrap.Modal(document.getElementById('reservateModal'));
    reservateModal.show();	
    
    $("#reservateCheckinDate").text($("#checkinDate").text());
	$("#reservateCheckoutDate").text($("#checkoutDate").text());
    
}

function closeReservationModal() {
	$('#reservationModal').modal('hide');
}
