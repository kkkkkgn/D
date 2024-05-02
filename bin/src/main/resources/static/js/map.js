// 마커를 담을 배열입니다
var markers = [];
// 선택한 데이터의 마커를 담을 배열
var selectedMarkers = [];
// 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var drawingFlag = false;
// 마커 좌표로 그려질 선 객체입니다
var lines = [];
// 선의 거리정보를 표시할 커스텀오버레이 입니다
var distanceOverlay; 
// 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
var dots = {}; 
// 지도를 표시할 div 
var mapContainer = document.getElementById('map'), 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
// for ( var i = 0; i < markers.length; i ++ ){
//     var imageSize = new kakao.map.Size(24, 35);
//     var markerImage = new kakao.map.MarkerImage(imageSrc,imageSize);
//     var marker = new kakao.maps.Marker({
//         map : map ,
//         position : markers[i].LatLng,
//         title : markers[i].title,
//         image : markerImage
//     });
// }

// 주소 검색 서비스 객체 생성 
var geocoder = new kakao.maps.services.Geocoder();
// 좌표로 주소를 검색합니다


// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var addressDefind;

// 키워드로 장소를 검색합니다.
searchPlaces();
// 시도 키워드로 장소를 검색합니다. 
// searchSidoPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    // var zipcodeKeyword = document.getElementById().value + ' ';
    var zipcodeKeyword = $(".sidoValues").val();
    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false;
    }

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( (zipcodeKeyword + " " + keyword), placesSearchCB); 
}




// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

        getSelectedDataFromUI();

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}



// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds(),
        listStr = '';

    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for (var i = 0; i < places.length; i++) {
        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
            // console.log(itemEl);
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기 위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을 때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function (marker, title, addresses, address, plat, plng) {
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                displayInfowindow(map, infowindow, marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });

            itemEl.onclick = function () {
                // alert("click");
                // displayInfowindow(map, infowindow, marker, title);

                if (addresses){
                    document.getElementById('fulladdress').value = "[" + title + "]" + addresses;
                } else {
                    document.getElementById('fulladdress').value = "[" + title + "]" + address;
                }
                document.getElementById('title').value = title;
                if (addresses){
                    document.getElementById('address').value = addresses;
                } else {
                    document.getElementById('address').value = address;
                }
                document.getElementById('latclick').value = plat;
                document.getElementById('lngclick').value = plng;

            }

            itemEl.onmouseover = function () {
                displayInfowindow(map, infowindow, marker, title);
            };

            itemEl.onmouseout = function () {
                infowindow.close();
            };
        })(marker, places[i].place_name, places[i].road_address_name, places[i].address_name, places[i].y, places[i].x);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}


// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('div'),
    itemStr =   '<div class="info">' +
                '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '   <span class = "info-title"><b>' + places.place_name + '</b></span>';


    if (places.road_address_name) {
        itemStr += '    <span class = "info-address"><small>' + places.road_address_name + '</small></span>'
    } else {
        itemStr += '    <span class = "info-address"><small>' +  places.address_name  + '</small></span>'; 
    }
    itemStr += '    <div><button type="button" class="btn spotBtn">선택</button></div>';

    el.innerHTML = itemStr;
    el.className = 'item spotListone ft-face-nm';
    el.setAttribute('data-id', index + 1);

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
        imageSize = new kakao.maps.Size(36, 37),
        imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691),
            spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10),
            offset: new kakao.maps.Point(13, 37)
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
            position: position,
            image: markerImage
        });

    marker.setMap(map);
    markers.push(marker);

    return marker;
}



// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색 결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(map, infowindow, marker, title) {

    var content = '<div class="label"><span class="left"></span><span class="center">' + title + '</span><span class="right"></span></div>';
    var center = marker.getPosition(); // 마커의 위치를 얻어옵니다.

    // 인포윈도우에 내용 설정
    infowindow.setContent(content);

    // 인포윈도우가 표시될 위치 설정
    infowindow.setPosition(center);

    // 인포윈도우 열기
    infowindow.open(map, marker);

    // 지도를 인포윈도우가 열린 위치로 이동
    map.panTo(center);

    // 선택한 마커를 따로 관리하는 selectedMarkers 배열에 추가합니다.
    selectedMarkers.push(marker);
}



// 주소로 좌표를 검색하는 함수를 Promise로 감싸서 반환합니다.
// @param {string} address - 검색할 주소
// @returns {Promise<Array>} - 주소 검색 결과 배열을 포함하는 Promise
function getAddressCoordinates(address) {
    return new Promise((resolve, reject) => {
        // geocoder 객체의 addressSearch 메서드를 사용하여 주소를 검색합니다.
        geocoder.addressSearch(address, (result, status) => {
            // 검색이 성공한 경우
            if (status === kakao.maps.services.Status.OK) {
                // 검색 결과를 Promise로 resolve합니다.
                resolve(result);
            } else {
                // 검색이 실패한 경우 Promise를 reject하며 에러 메시지를 전달합니다.
                reject('주소로 좌표를 검색하는데 실패했습니다.');
            }
        });
    });
}

/**
 * UI에서 선택한 데이터를 이용하여 마커 및 선을 추가하는 함수
 * @async
 */


async function searchSpotPlace() {
    // UI에서 선택한 데이터를 가져옵니다.
    var selectedData = await getSelectedDataFromUI();
    console.log(selectedData);

    // 이전에 생성한 모든 마커와 선을 지웁니다.
    removeMarkersAndLines();
    // 이전 마커의 위치를 저장할 배열
    var MarkersPositions = [];

    // 선택한 데이터에 대한 좌표를 구해서 마커를 추가하고 선을 그립니다.
    for (let i = 0; i < selectedData.length; i++) {
        const data = selectedData[i];
        console.log(data);

        try {
            // 주소로 좌표를 검색합니다.
            const result = await getAddressCoordinates(data.address);
            console.log(result);

            if (result && result.length > 0) {
                // 첫 번째 검색 결과를 가져옵니다.
                const firstResult = result[0];
                console.log(firstResult);

                if (firstResult.address_name && firstResult.address_name.length > 0) {
                    // 새로운 마커의 위치를 LatLng 객체로 생성합니다.
                    const newMarkerPosition = new kakao.maps.LatLng(firstResult.y, firstResult.x);
                    // 새로운 마커를 생성합니다.
                    const newMarker = new kakao.maps.Marker({
                        map: map,
                        position: newMarkerPosition,
                        title: data.title
                    });

                    // 인포윈도우를 생성합니다.
                    const infowindow = new kakao.maps.InfoWindow({
                        content :'<div style="background-color:#fff; width:150px;text-align:center;padding:6px 0;">' + data.title + '</div>'
                    });

                    // 생성한 마커에 클릭 이벤트 리스너를 등록합니다.
                    kakao.maps.event.addListener(newMarker, 'click', function () {
                        // 해당 마커에 연결된 인포윈도우를 엽니다.
                        infowindow.open(map, newMarker);
                    });

                    // 생성한 마커를 배열에 추가합니다.
                    markers.push(newMarker);

                    // 생성한 마커의 정보를 배열에 추가합니다.
                    selectedMarkers.push({
                        marker: newMarker,
                        title: data.title,
                        position: newMarkerPosition
                    });

                    // 인포윈도우를 엽니다.
                    infowindow.open(map, newMarker);

                    // 생성한 마커의 위치를 배열에 추가합니다.
                    MarkersPositions.push(newMarkerPosition);

                    if (i > 0) {
                        // 이전 마커와 현재 마커의 위치를 이용하여 선을 그립니다.
                        const prevMarkerPosition = MarkersPositions[i - 1];
                        const linePath = [
                            new kakao.maps.LatLng(prevMarkerPosition.getLat(), prevMarkerPosition.getLng()),
                            newMarkerPosition
                        ];
                        const line = new kakao.maps.Polyline({
                            map: map,
                            path: linePath,
                            strokeWeight: 3,
                            strokeColor: '#db4040',
                            strokeOpacity: 0.7,
                            strokeStyle: 'solid'
                        });

                        // 생성한 선을 배열에 추가합니다.
                        lines.push(line);
                    }
                } else {
                    // 주소로 좌표를 검색하는데 실패한 경우 에러를 출력합니다.
                    console.error('주소로 좌표를 검색하는데 실패했습니다. 결과:', firstResult);
                }
            } else {
                // 주소로 좌표를 검색하는데 실패한 경우 에러를 출력합니다.
                console.error('주소로 좌표를 검색하는데 실패했습니다. 결과:', result);
            }
        } catch (error) {
            // 주소 검색 중 오류가 발생한 경우 에러를 출력합니다.
            console.error('주소 검색 중 오류가 발생했습니다:', error);
        }
    }

    // 기존에 있던 마커와 라인을 제거하는 함수
    function removeMarkersAndLines() {
        removeMarkers();
        removeLines();
    }

    // 마커를 제거하는 함수
    function removeMarkers() {
        markers.forEach(marker => {
            marker.setMap(null);
        });
        // markers 배열 초기화
        markers = [];
    }

    // 라인을 제거하는 함수
    function removeLines() {
        lines.forEach(line => {
            line.setMap(null);
        });
        // lines 배열 초기화
        lines = [];
    }
}
/**
 * UI에서 선택한 spot-container 요소들에서 spotListone 요소의 데이터를 수집하여 배열에 저장하는 함수
 * @returns {Array} 선택한 데이터 객체들의 배열
 */
async function getSelectedDataFromUI() {
    // UI에서 spot-container 요소들을 모두 가져옵니다.
    var spotContainers = document.querySelectorAll(".spot-container");
    var selectedData = [];

    // 각 spot-container에 대한 반복문
    for (let i = 0; i < spotContainers.length; i++) {
        const spotContainer = spotContainers[i];

        // 현재 활성화된 spot-container만 처리합니다.
        if (spotContainer.classList.contains('active')) {
            // 현재 spot-container 내부의 모든 spotListone 요소들을 가져옵니다.
            var spotListElements = spotContainer.querySelectorAll('.spotListPage .spotListone');

            // 각 spotListone 요소에 대한 반복문
            for (let j = 0; j < spotListElements.length; j++) {
                const spotListElement = spotListElements[j];
                var titleElement = spotListElement.querySelector('.info-title');
                var addressElement = spotListElement.querySelector('.info-address');

                // .info-address 에 내용이 있을 경우 || 없을경우 
                var address = addressElement?.innerText || '';

                try {
                    // 주소로 좌표를 비동기적으로 검색합니다.
                    const result = await getAddressCoordinates(address);

                    if (result && result.length > 0) {
                        // 검색 결과에서 위도와 경도를 추출합니다.
                        var latitude = result[0].y;
                        var longitude = result[0].x;

                        // 수집한 데이터를 객체에 담아 배열에 추가합니다.
                        var elementData = {
                            title: titleElement?.innerText || '',
                            address: address,
                            latitude: latitude,
                            longitude: longitude
                        };

                        selectedData.push(elementData);
                    } else {
                        console.error('주소로 좌표를 검색하는데 실패했습니다.');
                    }
                } catch (error) {
                    console.error('주소 검색 중 오류가 발생했습니다:', error);
                }
            }
        }
    }

    // 수집한 데이터 객체들의 배열을 반환합니다.
    return selectedData;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    markers.forEach(marker => marker.setMap(null));
    markers = [];
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

