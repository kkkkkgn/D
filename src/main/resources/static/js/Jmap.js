//// acc_reservation.jsp ////
const REST_API_KEY = 'e6f70ebe197d015b321682644e0afc1b';
let overlays = [];

// 맵을 띄울 컨테이너 지정
let mapContainer = document.getElementById('map'); 
// 기본 레벨 설정
let defaultLevel = 11;
// 맵 초기 옵션 값 설정
let mapOptions = {
    // 맵에 센터를 지정해주고
    center: new kakao.maps.LatLng(37.5668260, 126.9786567),
    // 맵 확대 축소 레벨을 지정해주고
    level: defaultLevel
};
// 지도 생성
let map = new kakao.maps.Map(mapContainer, mapOptions);
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

var marker = new kakao.maps.Marker();
var markers = [];

var latitude;
var longitude;

var marker = new kakao.maps.Marker({
		position : new kakao.maps.LatLng(latitude, longitude)
	});
// 마커에 마우스오버 이벤트를 등록합니다
var markerOver = new kakao.maps.event.addListener(marker, 'mouseover', function() {
  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
    infowindow.open(map, marker);
});

// 마커에 마우스아웃 이벤트를 등록합니다
var markerOut = new kakao.maps.event.addListener(marker, 'mouseout', function() {
    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
    infowindow.close();
});

var markerClick = new kakao.maps.event.addListener(marker, 'click', function() {
    alert('marker click!');
});	



//// res_header에 있는 검색 버튼 클릭시 실행되는 함수입니다. ////
function initializeMapByDosi() {
	// 초기 지역 설정값 (ex: 서울 특별시)
    const dosi = $(".sidoValues").val();
    
    // 각 시도별 대표 경위도.
	if (dosi === '서울특별시') {
	    latitude = 37.5665;
	    longitude = 126.9780;
	} else if (dosi === '부산광역시') {
	    latitude = 35.1796;
	    longitude = 129.0756;
	} else if (dosi === '대구광역시') {
	    latitude = 35.8714;
	    longitude = 128.6014;
	} else if (dosi === '인천광역시') {
	    latitude = 37.4550;
	    longitude = 126.7052;
	} else if (dosi === '광주광역시') {
	    latitude = 35.1595;
	    longitude = 126.8526;
	} else if (dosi === '대전광역시') {
	    latitude = 36.3504;
	    longitude = 127.3845;
	} else if (dosi === '울산광역시') {
	    latitude = 35.5384;
	    longitude = 129.3114;
	} else if (dosi === '세종특별자치시') {
	    latitude = 36.4803;
	    longitude = 127.2890;
	} else if (dosi === '경기도') {
	    latitude = 37.4138;
	    longitude = 127.5188;
	} else if (dosi === '강원도') {
	    latitude = 37.8228;
	    longitude = 128.1555;
	} else if (dosi === '충청북도') {
	    latitude = 36.8001;
	    longitude = 127.7230;
	} else if (dosi === '충청남도') {
	    latitude = 36.5184;
	    longitude = 126.8009;
	} else if (dosi === '전라북도') {
	    latitude = 35.7167;
	    longitude = 127.1446;
	} else if (dosi === '전라남도') {
	    latitude = 34.8679;
	    longitude = 126.9910;
	} else if (dosi === '경상북도') {
	    latitude = 36.4919;
	    longitude = 128.8889;
	} else if (dosi === '경상남도') {
	    latitude = 35.2598;
	    longitude = 128.6640;
	} else if (dosi === '제주특별자치도') {
	    latitude = 33.4996;
	    longitude = 126.5312;
	} else {
	    // 기본값 설정 또는 에러 처리
	    latitude = 37.5665;
	    longitude = 126.9780;
	}

	// 현재 지도의 레벨 얻어오기
	let currentLevel = map.getLevel(); 
	// 얻어온 레벨로 mapOptions 수정
	mapOptions.level = currentLevel;
	// 기존의 맵을 파괴하고 새로운 맵을 현재 레벨로 생성
	mapOptions.center = new kakao.maps.LatLng(latitude, longitude);
	mapContainer.innerHTML = '';
	// 맵을 다시 선언 
	// 맵을 지우고 다시 선언하지 않으면 호출할때마다 맵이 중복 생성된다.
	mapContainer = document.getElementById('map'); 

	// 맵의 컨테이너 값과 옵션 값을 지정
	map = new kakao.maps.Map(mapContainer, mapOptions);
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	let bounds = new kakao.maps.LatLngBounds();

    //// 초기 지역값의 숙소들을 불러오는 ajax 처리 입니다 ////
    $.ajax({
        url :'/user/accListByDosi.do',
        type: 'POST',
        data: {
        	dosi : dosi
        },
        success : function(data){
			// html : list 초기화
            $('#accList').empty();
            
            var parsedData = JSON.parse(data);
			
			// 페이지에 15개의 숙소만 기술하기 위한 변수 설정
			var i = 1;
						
			for (let acc of parsedData) {
				
			    // 방이 없는 숙소에 대한 예외처리				
			    if (acc.acc_rooms != 0) {
			        // html 객체 'listItem' 생성
			        const listItem = document.createElement('div');
			        listItem.innerHTML = `
			            <div class="info" onclick="showPositionSelected(${acc.acc_id})">
			                <span class="markerbg marker_${i}"></span>
			                <span class="info-title">${acc.acc_name}</span>
			                <span class="info-address"><small>${acc.acc_address}</small></span>
			                <div>
			                	<button type="button" class="btn accBtn" onclick="openReservationModal(${acc.acc_id})">예약</button>
			                </div>
			            </div>
			        `;
			        // listItem class 설정
			        listItem.className = 'item spotListone';
			        // data-id 속성값 입력
			        listItem.setAttribute('data-id', acc.acc_id);
			        
			        // #accList 에 html 삽입
			        $('#accList').append(listItem);
			        
			        //// 마커 작업 ////
		        	latitude = acc.acc_latitude;
		        	longitude = acc.acc_longitude;
		        	
					let markerPosition = new kakao.maps.LatLng(acc.acc_latitude, acc.acc_longitude);
        			bounds.extend(markerPosition);
					
					
		            var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
		            var imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
		            var imgOptions =  {
		                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		                spriteOrigin : new kakao.maps.Point(0, ((i-1)*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		            };
		            
		        	
		        	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
		        	
		        	marker = new kakao.maps.Marker({
						position : new kakao.maps.LatLng(latitude, longitude),
						image : markerImage
					})
					
										
					// 지도에 마커설정
					marker.setMap(map);
					markers.push(marker);
					var content = `
					        <div class="info-window">
					          <div class="info-window-title">${acc.acc_name}</div>
					          <div class="info-window-content">${acc.acc_address}</div>
					        </div>
					      `;
					var infowindow = new kakao.maps.InfoWindow({
						content : content
					});
					
					(function(marker, infowindow) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				        kakao.maps.event.addListener(marker, 'mouseover', function() {
				            infowindow.open(map, marker);
				        });
				
				        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
				        kakao.maps.event.addListener(marker, 'mouseout', function() {
				            infowindow.close();
				        });
				        
				        kakao.maps.event.addListener(marker, 'click', function() {
				            //alert(acc.acc_name);
				            openReservationModal(acc.acc_id);
							
							
				        });
			    	})(marker, infowindow);
			  		
					//// 마커 작업 끝 ////

			        i++;
			        // 15개까지만 처리
			        if (i > 15) {
			            break; // for 루프 종료
			        }
			    }
			}
			map.setBounds(bounds);
        },error : function(e){
			console.log('error : ' + e);
        }
    });
}


function handleKeyPress(event) {
	
  // Enter 키의 keyCode는 13입니다.
  if (event.keyCode === 13) {
    // 포커스된 요소에서 Enter 키를 눌렀을 때 실행할 함수 호출
    SearchAcc();
  }
}
//// 숙소이름별로 찾기 ////
function SearchAcc() {
	const keyword = $("#keyword").val();
	$('#accList').empty();
	
	markers.forEach(function(element) {
	  element.setMap(null);
	});
	//marker.setMap(null);
	markers.length = 0
	
	var sido = $(".sidoValues").val();
	
	
	if(sido == '') {
		$.ajax({
		url:'/user/accByName.do',
		type:'POST',
		data:{
			keyword : keyword
		},
		success : function(data) {
			// html : list 초기화
            
            if (data == "") {
				alert('검색 가능한 숙소가 없습니다.');
				$("#keyword").val('');
				false;
			} else {
            	var parsedData = JSON.parse(data);
				  
	            var i = 1;
							
				for (let acc of parsedData) {
			        // html 객체 'listItem' 생성
			        const listItem = document.createElement('div');
			        listItem.innerHTML = `
			            <div class="info" onclick="showPositionSelected(${acc.acc_id})">
			                <span class="markerbg marker_${i}"></span>
			                <span class="info-title">${acc.acc_name}</span>
			                <span class="info-address"><small>${acc.acc_address}</small></span>
			                <div>
			                	<button type="button" class="btn accBtn" onclick="showPositionSelected(${acc.acc_id})">선택</button>
			                	<button type="button" class="btn accBtn" onclick="openReservationModal(${acc.acc_id})">예약</button>
			                </div>
			            </div>
			        `;
			        // listItem class 설정
			        listItem.className = 'item spotListone ft-face-nm';
			        // data-id 속성값 입력
			        listItem.setAttribute('data-id', acc.acc_id);
			        
			        // #accList 에 html 삽입
			        $('#accList').append(listItem);
			        
			        
			        //// 마커 작업 ////
		        	latitude = acc.acc_latitude;
		        	longitude = acc.acc_longitude;
		        	
		        	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
		            var imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
		            var imgOptions =  {
		                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		                spriteOrigin : new kakao.maps.Point(0, ((i-1)*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		            };
		        	
		        	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
		        	
		        	marker = new kakao.maps.Marker({
						position : new kakao.maps.LatLng(latitude, longitude),
						image : markerImage
					})
		        				
					// 지도에 마커설정
					marker.setMap(map);
					markers.push(marker);
					var content = `
					        <div class="info-window">
					          <div class="info-window-title">${acc.acc_name}</div>
					          <div class="info-window-content">${acc.acc_address}</div>
					        </div>
					      `;
					var infowindow = new kakao.maps.InfoWindow({
						content : content
					});
					
					(function(marker, infowindow) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				        kakao.maps.event.addListener(marker, 'mouseover', function() {
				            infowindow.open(map, marker);
				        });
				
				        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
				        kakao.maps.event.addListener(marker, 'mouseout', function() {
				            infowindow.close();
				        });
				        
				        kakao.maps.event.addListener(marker, 'click', function() {
				            //alert(acc.acc_name);
				            openReservationModal(acc.acc_id);
				        });
					})(marker, infowindow);
					
					//// 마커 작업 끝 ////
					var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
		    		map.setCenter(moveLatLon);
			        i++;
			        // 15개까지만 처리
			        if (i > 15) {
			            break; // for 루프 종료
			        }
				}
				
			  	
			}
		}, error : function(e) {
			console.log(e);
		}
	})
	} else {
		$.ajax({
		url:'/user/accByNameAndSido.do',
		type:'POST',
		data:{
			keyword : keyword,
			sido : sido
		},
		success : function(data) {
			// html : list 초기화
            
            if (data == "") {
				alert('검색 가능한 숙소가 없습니다.');
				$("#keyword").val('');
				false;
			} else {
            	var parsedData = JSON.parse(data);
				  
	            var i = 1;
							
				for (let acc of parsedData) {
			        // html 객체 'listItem' 생성
			        const listItem = document.createElement('div');
			        listItem.innerHTML = `
			            <div class="info" onclick="showPositionSelected(${acc.acc_id})">
			                <span class="markerbg marker_${i}"></span>
			                <span class="info-title">${acc.acc_name}</span>
			                <span class="info-address"><small>${acc.acc_address}</small></span>
			                <div>
								<button type="button" class="btn accBtn" onclick="showPositionSelected(${acc.acc_id})">선택</button>
			                	<button type="button" class="btn accBtn" onclick="openReservationModal(${acc.acc_id})">예약</button>
			                </div>
			            </div>
			        `;
			        // listItem class 설정
			        listItem.className = 'item spotListone ft-face-nm';
			        // data-id 속성값 입력
			        listItem.setAttribute('data-id', acc.acc_id);
			        
			        // #accList 에 html 삽입
			        $('#accList').append(listItem);
			        
			        
			        //// 마커 작업 ////
		        	latitude = acc.acc_latitude;
		        	longitude = acc.acc_longitude;
		        
		        	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
		            var imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
		            var imgOptions =  {
		                spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		                spriteOrigin : new kakao.maps.Point(0, ((i-1)*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		                offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		            };
		        	
		        	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
		        	
		        	marker = new kakao.maps.Marker({
						position : new kakao.maps.LatLng(latitude, longitude),
						image : markerImage
					})
							
					// 지도에 마커설정
					marker.setMap(map);
					markers.push(marker);
					var content = `
					        <div class="info-window">
					          <div class="info-window-title">${acc.acc_name}</div>
					          <div class="info-window-content">${acc.acc_address}</div>
					        </div>
					      `;
					var infowindow = new kakao.maps.InfoWindow({
						content : content
					});
					
					(function(marker, infowindow) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				        kakao.maps.event.addListener(marker, 'mouseover', function() {
				            infowindow.open(map, marker);
				        });
				
				        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
				        kakao.maps.event.addListener(marker, 'mouseout', function() {
				            infowindow.close();
				        });
				        
				        kakao.maps.event.addListener(marker, 'click', function() {
				            //alert(acc.acc_name);
				            openReservationModal(acc.acc_id);
				        });
					})(marker, infowindow);
					var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
		    		map.setCenter(moveLatLon);
					//// 마커 작업 끝 ////
	
			        i++;
			        // 15개까지만 처리
			        if (i > 15) {
			            break; // for 루프 종료
			        }
				}
				
			  	
			}
		}, error : function(e) {
			console.log(e);
		}
	})
	}
		
	
}

//// 숙소 예약 모달 ////
function openReservationModal(acc_id) {
	
	 $.ajax({
        url :'/user/accById.do',
        type: 'POST',
        data: {
        	id : acc_id
        },
        success : function(data){
			var acc = JSON.parse(data);
			
			$(".accommodationName").text(acc.acc_name);
			$("#acc_id").val(acc.acc_id);
	        $("#accommodationFee").text(acc.acc_fee);
	        $("#reservateCheckoutFee").text(acc.acc_fee + ' 원');
	        $("#accommodationSummary").text(acc.acc_summary.replace(/<br>/g, '\n'));
	        setTimeout(() => {
				var fee = parseInt($("#accommodationFee").text());
				var feeCommas = accFeeAddCommas(fee);
				$("#accommodationFee").text(feeCommas);
			}, 500);
		
			function accFeeAddCommas(fee) {
				if (!isNaN(fee)) {
					return numberWithCommas(fee);
				}
				return "Invalid Fee";
			}
		
			function numberWithCommas(number) {
				var integerPart = Math.round(number);
				return integerPart.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
	        var image;
	        if(acc.acc_image == "") {
				image = "https://www.shillastay.com/images/upload/spofrpack/231228/FILEee40455cdf1585bd.jpg";
			} else {
				image = acc.acc_image
			}
			
			
		
		    $("#accommodationImage").attr("src", image);
		
			
	        var trvl_day = $('.trvl_day').html();
	        if(trvl_day != '<span class="ml-2"></span>') {	
	        	var checkDay = trvl_day.split('-'); 
	     		
	        	$("#checkinDate").text(checkDay[0] + ' 15:00');
	        	$("#checkoutDate").text(checkDay[1] + ' 11:00');
			} else {
				$("#checkinDate").text('체크인 날짜를 설정하셔야 합니다.');
	        	$("#checkoutDate").text('체크아웃 날짜를 설정하셔야 합니다.');
			}
        	
        	latitude = acc.acc_latitude;
        	longitude = acc.acc_longitude;
        	
        	
        	var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
		    map.setCenter(moveLatLon);
		    map.setLevel(3);
		    
		},error : function error(e) {
			console.log('error : ' + e);
		}
	});
	$('#reservationModal').modal('show');
}

function showPositionSelected(acc_id) {
	
	$.ajax({
        url :'/user/accById.do',
        type: 'POST',
        data: {
        	id : acc_id
        },
        success : function(data){
			var acc = JSON.parse(data);
			
        	latitude = acc.acc_latitude;
        	longitude = acc.acc_longitude;
		   
		   	var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
		    map.setCenter(moveLatLon);
		    map.setLevel(3);
		    
		},error : function error(e) {
			console.log('error : ' + e);
		}
	});
}

