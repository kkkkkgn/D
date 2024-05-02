$(document).ready(function() {
	var dateCells = $('.tablearea td');
	var startEmpty = true; // 시작일이 빈 공간인지 여부
	var hoverDayCount = 0; // 시작날과 끝날의 사이에 hover 효과를 카운트로 구별하기 위해  
	var count = 0; // 빈공간을 제외시키고 cell 하나당 아이디를 날짜로 부여하기 위해 
	var day = 0; // 날짜

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
		

	});
});