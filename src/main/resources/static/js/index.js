function sendNoticePage(urgentNoticeId) {

	window.location.href = '/notice_view.do?noticenum=' + urgentNoticeId;
}

// 팝업 설정과 관련된 쿠키
// 쿠키 설정
function setCookie(name, value, expiredays) {
	var today = new Date();
	today.setDate(today.getDate() + expiredays);

	document.cookie = name + '=' + escape(value) + '; expires=' + today.toGMTString();
}

// 쿠키 얻기
function getCookie(name) {
	var cookie = document.cookie;

	if (document.cookie !== "") {
		var cookie_array = cookie.split('; ');
		for (var index in cookie_array) {
			var cookie_name = cookie_array[index].split("=");
			if (cookie_name[0] === name) {
				return cookie_name[1];
			}
		}
	}
}

/** 즐겨찾기 버튼 활성화 / 비활성화 **/
function showFavorite(){

   var courseId = $('.favbtn').attr('data-id');
	
   // 사용자 코스 ID 목록 가져오기
   $.ajax({
       type: "POST",
       url: "/user/show_favorite.do",
       success: function (favCourses) {
           // 사용자 코스 즐겨찾기 목록에 포함되어 있는지 확인
           if (favCourses.includes(courseId)) {
               // 목록에 포함되어 있으면 버튼을 활성화
               $('#favbtn' + courseId).addClass('active');
           } else {
        	   // 목록에 포함되지 않으면 버튼 비활성화
        	   $('#favbtn' + courseId).removeClass('active');
           }
       },
       error: function (error) {
           console.error("Error: " + error);
       }
   });

};
		
		
function refreshPage() {
    location.reload();
};

$(document).ready(function() {   	
        		
        	// koreamap.jsp의 지도 클래스
			var land = document.querySelectorAll('.land');
			
    		// 지도에 hover 했을 때
    		land.forEach(function(landElement) {
    			landElement.addEventListener('mouseover', function(event) {
        			
        			// 네임스페이스를 지정하여 요소의 속성 값을 가져오는 메서드
        			landElementName = event.target.getAttributeNS(null, 'title');   
        			        			
        			var descriptionElement = document.createElement('div');

					switch (landElementName) {
        			case 'seoul':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
        				+ '<div class="region-info"><h1 style="font-weigth:500" id="regionH1">서울특별시</h1>' 
        				+ '<img id="regionImg" src="/img/map/seoul.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
        				+ '<h4>&nbsp;서울은 역사, 현대, 음식, 쇼핑, 문화가 어우러진 도시입니다.<br/>'
        				+ '&nbsp;아름다움과 독특한 매력으로 특별한 경험을 선사합니다.</h4>'
        				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
            			break;
        			case 'busan':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">부산광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/busan.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;해안가의 아름다운 풍경과 신선한 해산물로 유명한 도시로, <br/>'
            				+ '&nbsp;다양한 해변과 맛집이 즐비합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'incheon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">인천광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/incheon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;국제적인 항구 도시로, <br/>'
            				+ '&nbsp;역사적인 명소와 현대적인 도시 모습을 함께 간직하고 있습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'daegu':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">대구광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/daegu.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적지와 현대적인 도시 구조가 조화를 이루며, <br/>'
            				+ '&nbsp;맛있는 떡볶이로 유명합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'daejeon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">대전광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/daejeon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;과학과 기술의 중심지로 알려진 도시로, <br/>'
            				+ '&nbsp;현대적인 도시 계획과 자연 경관이 어우러져 있습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gwangju':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">광주광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/gwangju.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;민주화 운동의 중심지로 유명하며, <br/>'
            				+ '&nbsp;예술과 문화가 풍부한 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'ulsan':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">울산광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/ulsan.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;산업의 중심지로 알려져 있으며, <br/>'
            				+ '&nbsp;독특한 바다 풍경과 해양 문화가 특징입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'sejong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">세종특별자치시</h1>' 
            				+ '<img id="regionImg" src="/img/map/sejong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;한국의 국회와 대통령의 청사가 위치한 행정 중심지로, <br/>'
            				+ '&nbsp;조용하면서도 발전하는 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gyeonggi':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경기도</h1>' 
            				+ '<img id="regionImg" src="/img/map/gyeonggi.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;수도권의 중심에 위치하여 교통이 발달하고, <br/>'
            				+ '&nbsp;다양한 문화와 역사를 경험할 수 있는 지역입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gangwon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">강원도</h1>' 
            				+ '<img id="regionImg" src="/img/map/gangwon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 자연 경관과 겨울 스포츠로 유명한 도시로, <br/>'
            				+ '&nbsp;휴양과 스포츠가 함께 어울립니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northChungcheong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">충청북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northChungcheong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적지와 자연 경관이 조화를 이루며, <br/>'
            				+ '&nbsp;전통과 현대가 공존하는 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southChungcheong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">충청남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southChungcheong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;농업과 자연이 어우러져 있는 도시로, <br/>'
            				+ '&nbsp;맛있는 농산물이 특징입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northJeolla':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">전라북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northJeolla.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 문화와 예술이 풍부한 도시로, <br/>'
            				+ '&nbsp;전통과 현대가 공존합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southJeolla':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">전라남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southJeolla.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 해안선과 섬으로 둘러싸인 도시로, <br/>'
            				+ '&nbsp;신선한 해산물이 자랍니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northGyeongsang':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경상북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northGyeongsang.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적과 아름다운 자연 경관이 있는 도시로, <br/>'
            				+ '&nbsp;다양한 문화가 펼쳐집니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southGyeongsang':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경상남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southGyeongsang.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;다양한 해변과 해양 문화가 동시에 즐길 수 있는 도시로, <br/>'
            				+ '&nbsp;특색 있는 음식이 많이 나옵니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'jeju':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">제주특별자치도</h1>' 
            				+ '<img id="regionImg" src="/img/map/jeju.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 자연 풍경과 독특한 문화가 공존하는 섬으로, <br/>'
            				+ '&nbsp;휴양과 여행지로 인기가 많습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			
        			}

        			$('#regionDiv').html(descriptionElement);
        		});    			
    		});
    		
    		
    		// 지도 위 글씨에 hover 했을 때
    		var landText = document.querySelectorAll('.landText');
    		
    		landText.forEach(function(landElement) {
    			landElement.addEventListener('mouseover', function(event) {
        			
        			// 네임스페이스를 지정하여 요소의 속성 값을 가져오는 메서드
        			landElementName = event.target.id;
        			
        			var descriptionElement = document.createElement('div');        			

        			switch (landElementName) {
        			case 'seoul':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
        				+ '<div class="region-info"><h1 id="regionH1">서울특별시</h1>' 
        				+ '<img id="regionImg" src="/img/map/seoul.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
        				+ '<h4>&nbsp;서울은 역사, 현대, 음식, 쇼핑, 문화가 어우러진 도시입니다.<br/>'
        				+ '&nbsp;아름다움과 독특한 매력으로 특별한 경험을 선사합니다.</h4>'
        				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
            			break;
        			case 'busan':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">부산광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/busan.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;해안가의 아름다운 풍경과 신선한 해산물로 유명한 도시로, <br/>'
            				+ '&nbsp;다양한 해변과 맛집이 즐비합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'incheon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">인천광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/incheon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;국제적인 항구 도시로, <br/>'
            				+ '&nbsp;역사적인 명소와 현대적인 도시 모습을 함께 간직하고 있습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'daegu':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">대구광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/daegu.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적지와 현대적인 도시 구조가 조화를 이루며, <br/>'
            				+ '&nbsp;맛있는 떡볶이로 유명합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'daejeon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">대전광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/daejeon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;과학과 기술의 중심지로 알려진 도시로, <br/>'
            				+ '&nbsp;현대적인 도시 계획과 자연 경관이 어우러져 있습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gwangju':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">광주광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/gwangju.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;민주화 운동의 중심지로 유명하며, <br/>'
            				+ '&nbsp;예술과 문화가 풍부한 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'ulsan':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">울산광역시</h1>' 
            				+ '<img id="regionImg" src="/img/map/ulsan.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;산업의 중심지로 알려져 있으며, <br/>'
            				+ '&nbsp;독특한 바다 풍경과 해양 문화가 특징입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'sejong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">세종특별자치시</h1>' 
            				+ '<img id="regionImg" src="/img/map/sejong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;한국의 국회와 대통령의 청사가 위치한 행정 중심지로, <br/>'
            				+ '&nbsp;조용하면서도 발전하는 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gyeonggi':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경기도</h1>' 
            				+ '<img id="regionImg" src="/img/map/gyeonggi.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;수도권의 중심에 위치하여 교통이 발달하고, <br/>'
            				+ '&nbsp;다양한 문화와 역사를 경험할 수 있는 지역입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'gangwon':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">강원도</h1>' 
            				+ '<img id="regionImg" src="/img/map/gangwon.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 자연 경관과 겨울 스포츠로 유명한 도시로, <br/>'
            				+ '&nbsp;휴양과 스포츠가 함께 어울립니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northChungcheong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">충청북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northChungcheong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적지와 자연 경관이 조화를 이루며, <br/>'
            				+ '&nbsp;전통과 현대가 공존하는 도시입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southChungcheong':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">충청남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southChungcheong.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;농업과 자연이 어우러져 있는 도시로, <br/>'
            				+ '&nbsp;맛있는 농산물이 특징입니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northJeolla':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">전라북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northJeolla.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 문화와 예술이 풍부한 도시로, <br/>'
            				+ '&nbsp;전통과 현대가 공존합니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southJeolla':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">전라남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southJeolla.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 해안선과 섬으로 둘러싸인 도시로, <br/>'
            				+ '&nbsp;신선한 해산물이 자랍니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'northGyeongsang':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경상북도</h1>' 
            				+ '<img id="regionImg" src="/img/map/northGyeongsang.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;역사적인 유적과 아름다운 자연 경관이 있는 도시로, <br/>'
            				+ '&nbsp;다양한 문화가 펼쳐집니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'southGyeongsang':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">경상남도</h1>' 
            				+ '<img id="regionImg" src="/img/map/southGyeongsang.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;다양한 해변과 해양 문화가 동시에 즐길 수 있는 도시로, <br/>'
            				+ '&nbsp;특색 있는 음식이 많이 나옵니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			case 'jeju':
        				descriptionElement.innerHTML = '<div id="regionImgDiv" class="animate__animated animate__fadeIn">' 
            				+ '<div class="region-info"><h1 id="regionH1">제주특별자치도</h1>' 
            				+ '<img id="regionImg" src="/img/map/jeju.jpg" width="90%" height="90%" style="border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.5)";">' 
            				+ '<h4>&nbsp;아름다운 자연 풍경과 독특한 문화가 공존하는 섬으로, <br/>'
            				+ '&nbsp;휴양과 여행지로 인기가 많습니다.</h4>'
            				+ '<h5 class="display-7 fw-bolder mb-2">&nbsp;새로운 여행 계획을 생성하려면 지역을 클릭 하세요!</h5></div></div>';
                			break;
        			
        			}
        			

        			$('#regionDiv').html(descriptionElement);
        		});
    		});
    		
        });