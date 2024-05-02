// 카카오 api REST 앱키 
let REST_API_KEY = 'e6f70ebe197d015b321682644e0afc1b';
// 오버레이의 빈 배열 선언
let overlays = [];
// 마커의 빈 배열 선언 
let markers = [];
// 선택한 마커의 빈 배열 선언
let selectMarkers = [];
// 클릭이벤트로 보일 오버레이 선언
let overlay;
// 맵을 띄울 컨테이너 지정
let mapContainer = document.getElementById('map'); 
// 기본 레벨 설정
let defaultLevel = 8;

// 맵 초기 옵션 값 설정
let mapOptions = {
    // 맵에 센터를 지정해주고
    center: new kakao.maps.LatLng(37.5668260, 126.9786567),
    // 맵 확대 축소 레벨을 지정해주고
    level: defaultLevel
};
// 지도 생성
let map = new kakao.maps.Map(mapContainer, mapOptions);
    // center LatLng : 중심 좌표 (필수)
    // level Number : 확대 수준 (기본값: 3)
    // mapTypeId MapTypeId : 지도 종류 (기본값: 일반 지도)
    // draggable Boolean : 마우스 드래그, 휠, 모바일 터치를 이용한 시점 변경(이동, 확대, 축소) 가능 여부
    // scrollwheel Boolean : 마우스 휠, 모바일 터치를 이용한 확대 및 축소 가능 여부
    // disableDoubleClick Boolean : 더블클릭 이벤트 및 더블클릭 확대 가능 여부
    // disableDoubleClickZoom Boolean : 더블클릭 확대 가능 여부
    // projectionId String : 투영법 지정 (기본값: kakao.maps.ProjectionId.WCONG)
    // tileAnimation Boolean : 지도 타일 애니메이션 설정 여부 (기본값: true)
    // keyboardShortcuts Boolean | Object : 키보드의 방향키와 +, – 키로 지도 이동,확대,축소 가능 여부 (기본값: false)
    // speed Number : 지도 이동 속도

// 선의 거리정보를 표시할 커스텀오버레이
var distanceOverlay; 
// 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열
var dots = {}; 
// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지역 최대 축소 레벨
map.setMaxLevel(10);


// 비동기로 지역을 찾아주는 함수 선언
async function getCityHallCoordinatesForRegion(region) {
    // 지역을 설정한 값에서 시청을 찾는다 
    // ex) 서울특별시+청
    let query = region + '청';
    // 카카오 맵 API Developers 에 있는 문서를 참고하여 
    // REST_API_KEY 를 인증해 검색어로 json 데이터를 받을 수 있다.
    let url = 'https://dapi.kakao.com/v2/local/search/keyword.json' +
              '?query=' + encodeURIComponent(query);
    try {
        const response = await fetch(url, {
            headers: {
                'Authorization': 'KakaoAK ' + REST_API_KEY,
            },
        });
        // 받은 데이터를 json 데이터로 반환
        const data = await response.json();
        // 데이터 값이 존재한다면 
        if (data.documents.length > 0) {
                // 처음 데이터에서 
                const firstResult = data.documents[0];
                // 위도 경도 값을 얻어옴
                const latitude = firstResult.y;
                const longitude = firstResult.x;
            return { latitude, longitude };
        } else {
            console.error('시청 정보를 찾을 수 없습니다.');
            return { latitude: 37.5668260, longitude: 126.9786567 };
        }
    } catch (error) {
        console.error('API 요청 중 에러가 발생했습니다.', error);
        return { latitude: 37.5668260, longitude: 126.9786567 };
    }
}


function initializeMap() {
    // 현재 지도의 레벨 얻어오기
    let currentLevel = map.getLevel(); 
    // 얻어온 레벨로 mapOptions 수정
    mapOptions.level = currentLevel;
    // 기존의 맵을 파괴하고 새로운 맵을 현재 레벨로 생성
    mapContainer.innerHTML = '';
    // 맵을 다시 선언 
    // 맵을 지우고 다시 선언하지 않으면 호출할때마다 맵이 중복 생성된다.
    mapContainer = document.getElementById('map'); 
    // 맵의 컨테이너 값과 옵션 값을 지정
    map = new kakao.maps.Map(mapContainer, mapOptions);

    // 지역 값을 얻어온다
    let region = $(".NITa-value.sidoValues").text();
    // 키워드 검색 값을 얻어온다
    let keyword = $('#keyword').val();
    // 검색할 값은 지역 + 키워드 검색 값으로 지정해
    // 지역에서 벗어난 검색 값을 제외시킨다.
    let query = region + " " + keyword;
    let address = "";
    let latitude;
    let longitude;
    let category = '';

  // 시청 좌표 가져오기
  // 지역을 찾아주는 함수를 써 region 값으로 위도 경도를 얻어낼수있다.
getCityHallCoordinatesForRegion(region)
   .then(coordinates => {

        mapContainer.innerHTML = '';
        latitude = coordinates.latitude;
        longitude = coordinates.longitude;
        // 지역값을 이용하여 지역 시청에 위도 경도를 맵에 센터에 위치하게 한다.
        mapOptions.center = new kakao.maps.LatLng(latitude, longitude);
        map = new kakao.maps.Map(mapContainer, mapOptions);
        
        // selectMarkers= [];
       // 다음 코드 추가: 맵이 초기화되면 selectPlaces와 listPlaces 호출
       if (map) {
            zoomLevel = map.getLevel(); 
            map.setLevel(zoomLevel);
            listPlaces(map, query, address, latitude, longitude, category );

            processSpotData(map);
       } else {
           console.error('맵이 초기화되지 않았습니다.');
       }
   })
   .catch(error => console.error('Error:', error));
}

function listPlaces(map, query, address, latitude, longitude, category) {
   const url = 'https://dapi.kakao.com/v2/local/search/keyword.json' +
       '?query=' + encodeURIComponent(query) +
       '&address=' + encodeURIComponent(address) +
       '&y=' + encodeURIComponent(latitude) +
       '&x=' + encodeURIComponent(longitude) +
       '&category=' + encodeURIComponent(category);
   
   fetch(url, {
       method: 'GET',
       headers: {
           'Authorization': 'KakaoAK ' + REST_API_KEY,
       },
   })
   .then(response => response.json())
   .then(data => {
        if (data.documents && Array.isArray(data.documents)) {
           // Continue with your code
           $('#placesList').empty();

            var placeLatLngs = [];

            data.documents.forEach((place, index) => {
                const listItemHTML = 
                '<div class="item spotListone ft-face-nm" data-id="' + (index + 1) + '">' +
                    '<div class="info">' +
                        '<span class="markerbg marker_' + (index + 1) + '"></span>' +
                        '<span class="info-title"><p class="pname" style="margin:0;">' + place.place_name + '</p></span>' +
                        (place.category_group_name
                            ? '<span class="info-address pcategory"><small class="spotPlacesCatagory">' + place.category_group_name + '</small></span>'
                            : '<span class="info-address pcategory"><small class="spotPlacesCatagory">관광지</small></span>'
                        ) +
                        '<span class="info-address plat none"><small>' + place.x + '</small></span>' +
                        '<span class="info-address plong none"><small>' + place.y + '</small></span>' +
                        (place.road_address_name
                            ? '<span class="info-address proadaddress"><small>' + place.road_address_name + '</small></span>'
                            : '<span class="info-address paddress"><small>' + place.address_name + '</small></span>') +
                        '<div class="flex gap-3">' +
                            '<span class="info-address pimgUrl none"><small>' + place.place_url + '</small></span>' +
                            '<small style="font-size:20px;"><a style="color:blue;" href="' + place.place_url + '"><i class="bi bi-house-door-fill"></i></a></small>' +
                            (place.phone
                                ? '<span class="info-address phone"><i class="bi bi-telephone-fill"></i><small style="margin-left: 5px;">' + place.phone + '</small></span>' 
                                : '') +
                        '</div>' +
                        '<div><button type="button" class="btn spotBtn" title="여행지를 선택해주세요!" style="position:absolute; bottom:0; right:5px; font-size:20px; color:#438385;"><i class="bi bi-calendar2-check"></i></button></div>' +
                    '</div>' +
                '</div>';
                

                $('#placesList').append(listItemHTML);

                const latitude = parseFloat(place.y);
                const longitude = parseFloat(place.x);

                let placeLatLng = new kakao.maps.LatLng(latitude, longitude);
                placeLatLngs.push(placeLatLng);


                // 클릭한 엘리먼트에 대한 이벤트 리스너 추가
                $('#placesList').on('click', '.item', function() {
                    // 클릭한 엘리먼트의 데이터 ID를 가져옵니다.
                    var dataIndex = $(this).data('id');

                    // 해당 데이터 ID에 해당하는 장소의 좌표를 가져옵니다.
                    var place = data.documents[dataIndex - 1];
                    var latitude = place.y;
                    var longitude = place.x;

                    // 이동할 위치의 좌표를 설정합니다.
                    var moveLatLng = new kakao.maps.LatLng(latitude, longitude);
                    
                    // 지도를 특정 레벨로 확대합니다.
                    var zoomLevel = map.getLevel(); 
                    map.setLevel(zoomLevel);

                    // panTo 메서드를 사용하여 지도를 이동합니다.
                    map.panTo(moveLatLng);


                });

                // spotBtn 클릭 이벤트 리스너 추가
                $('#placesList').on('click', '.spotBtn', function(event) {
                    // 이벤트 전파를 중지하여 부모 엘리먼트의 클릭 이벤트가 발생하지 않도록 합니다.
                    event.stopPropagation();
                });

                const imageUrl = place.place_url;
                imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
                imageSize = new kakao.maps.Size(36, 37);  // 마커 이미지의 크기
                imgOptions =  {
                    spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
                    spriteOrigin : new kakao.maps.Point(0, (index*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                    offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                };



                markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);

                const marker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(latitude, longitude),
                    map: map,
                    title: place.place_name,
                    image: markerImage
                });
        
                markers.push(marker);
                kakao.maps.event.addListener(marker, 'click', (function (place) {
                    return function () {
                
                        const latitude = place.y;
                        const longitude = place.x;
                        const title = place.place_name;
                        const address = place.address_name;
                        const roadAddress = place.road_address_name;
                        const imageUrl = place.place_url;
                
                        let overlayContent = '<div class="wrap">' +
                            '<div class="info">' +
                            '<div class="title">' +
                            '<a style="text-decoration: none; color: #fff;" href="' + imageUrl + '" alt="' + imageUrl + '">' +
                            title +
                            '</a>' +
                            '<div class="close" onclick="closeOverlay()" title="닫기"><i style="color:#fff;" class="bi bi-x"></i></div>' +
                            '</div>' +
                            '<div class="body">' +
                            '<div class="img">' +
                            '<a href="' + imageUrl + '" alt="' + imageUrl + '">' +
                            '<img src="../img/LogoRaccoon.png" alt="로고너구리" width="73" height="70">' +
                            '</a>' +
                            '</div>' +
                            '<div class="desc">' +
                            '<div class="ellipsis">' + address + '</div>' +
                            '<div class="jibun ellipsis">' + roadAddress + '</div>' +
                            '<div class="jibun ellipsis">' + place.phone + '</div>' +
                            '<div class="jibun ellipsis"><a style="position: absolute; right: 8px; bottom: 2px;color: blueviolet;" href="' + imageUrl + '" alt="' + imageUrl + '">홈페이지</a></div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                
                        overlay = new kakao.maps.CustomOverlay({
                            content: overlayContent,
                            map: map,
                            position: new kakao.maps.LatLng( latitude, longitude),
                            zIndex: 16,
                        });
                
                        overlays.push(overlay);
                        overlay.setMap(map);

                    };
                    
                })(place));
                        
            });

            if (placeLatLngs.length > 0) {
                var bounds = new kakao.maps.LatLngBounds();
                placeLatLngs.forEach((placeLatLng) => {
                    bounds.extend(placeLatLng);
                });
            
                map.setBounds(bounds);
            }


        } else {
           console.error('data : ', data);
        }
   })
   .catch(error => console.error('Error:', error));
}



function processSpotData(map) {
    const selectPlaces = $("#nav-tab .nav-link");
    
    

    function TooltipMarker(position, tooltipText) {
        this.position = position;
        var node = this.node = document.createElement('div');
        node.className = 'node';
    
        var tooltip = document.createElement('div');
        tooltip.className = 'tooltip',
    
        tooltip.appendChild(document.createTextNode(tooltipText));
        node.appendChild(tooltip);
        
        // 툴팁 엘리먼트에 마우스 인터렉션에 따라 보임/숨김 기능을 하도록 이벤트를 등록합니다.
        node.onmouseover = function() {
            tooltip.style.display = 'block';
        };
        node.onmouseout = function() {
            tooltip.style.display = 'none';
        };
    }
    
    // AbstractOverlay 상속. 프로토타입 체인을 연결합니다.
    TooltipMarker.prototype = new kakao.maps.AbstractOverlay;
    
    // AbstractOverlay의 필수 구현 메소드.
    // setMap(map)을 호출했을 경우에 수행됩니다.
    // AbstractOverlay의 getPanels() 메소드로 MapPanel 객체를 가져오고
    // 거기에서 오버레이 레이어를 얻어 생성자에서 만든 엘리먼트를 자식 노드로 넣어줍니다.
    TooltipMarker.prototype.onAdd = function() {
        var panel = this.getPanels().overlayLayer;
        panel.appendChild(this.node);
    };
    
    // AbstractOverlay의 필수 구현 메소드.
    // setMap(null)을 호출했을 경우에 수행됩니다.
    // 생성자에서 만든 엘리먼트를 오버레이 레이어에서 제거합니다.
    TooltipMarker.prototype.onRemove = function() {
        this.node.parentNode.removeChild(this.node);
    };
    
    // AbstractOverlay의 필수 구현 메소드.
    // 지도의 속성 값들이 변화할 때마다 호출됩니다. (zoom, center, mapType)
    // 엘리먼트의 위치를 재조정 해 주어야 합니다.
    TooltipMarker.prototype.draw = function() {
        // 화면 좌표와 지도의 좌표를 매핑시켜주는 projection객체
        var projection = this.getProjection();
        
        // overlayLayer는 지도와 함께 움직이는 layer이므로
        // 지도 내부의 위치를 반영해주는 pointFromCoords를 사용합니다.
        var point = projection.pointFromCoords(this.position);
    
        // 내부 엘리먼트의 크기를 얻어서
        var width = this.node.offsetWidth;
        var height = this.node.offsetHeight;
    
        // 해당 위치의 정중앙에 위치하도록 top, left를 지정합니다.
        this.node.style.left = (point.x - width/2) + "px";
        this.node.style.top = (point.y - height/2) + "px";
    };
    
    // 좌표를 반환하는 메소드
    TooltipMarker.prototype.getPosition = function() {
        return this.position;
    };
    
    /**
     * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
     * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
     */
    function MarkerTracker(map, target) {
        // 클리핑을 위한 outcode
        var OUTCODE = {
            INSIDE: 0, // 0b0000
            TOP: 8, //0b1000
            RIGHT: 2, // 0b0010
            BOTTOM: 4, // 0b0100
            LEFT: 1 // 0b0001
        };
        
        // viewport 영역을 구하기 위한 buffer값
        // target의 크기가 60x60 이므로 
        // 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
        var BOUNDS_BUFFER = 30;
        
        // 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
        // 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
        // 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
        // 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
        var CLIP_BUFFER = 40;
    
        // trakcer 엘리먼트
        var tracker = document.createElement('div');
        tracker.className = 'tracker';
    
        // 내부 아이콘
        var icon = document.createElement('div');
        icon.className = 'icon';
    
        // 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
        var balloon = document.createElement('div');
        balloon.className = 'balloon';
    
        tracker.appendChild(balloon);
        tracker.appendChild(icon);
    
        map.getNode().appendChild(tracker);
    
        // traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
        tracker.onclick = function() {
            map.setCenter(target.getPosition());
            setVisible(false);
        };
    
        // target의 위치를 추적하는 함수
        function tracking() {
            var proj = map.getProjection();
            
            // 지도의 영역을 구합니다.
            var bounds = map.getBounds();
            
            // 지도의 영역을 기준으로 확장된 영역을 구합니다.
            var extBounds = extendBounds(bounds, proj);
    
            // target이 확장된 영역에 속하는지 판단하고
            if (extBounds.contain(target.getPosition())) {
                // 속하면 tracker를 숨깁니다.
                setVisible(false);
            } else {
                // target이 영역 밖에 있으면 계산을 시작합니다.
                
    
                // 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
                //
                //  +-------------------------+
                //  | Map Bounds              |
                //  |   +-----------------+   |
                //  |   | Clipping Rect   |   |
                //  |   |                 |   |
                //  |   |        *       (A)  |     A
                //  |   |                 |   |
                //  |   |                 |   |
                //  |   +----(B)---------(C)  |
                //  |                         |
                //  +-------------------------+
                //
                //        B
                //
                //                                       C
                // * 은 지도의 중심,
                // A, B, C가 TooltipMarker의 위치,
                // (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
                // 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
                // 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
                // tracker의 위치(top, left)값을 지정해주려고 합니다.
                // tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
                // 클리핑된 지점을 tracker의 위치로 사용합니다.
                // 실제 tracker의 position은 화면 좌표가 될 것이므로 
                // 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.
                
                // TooltipMarker의 위치
                var pos = proj.containerPointFromCoords(target.getPosition());
                
                // 지도 중심의 위치
                var center = proj.containerPointFromCoords(map.getCenter());
    
                // 현재 보이는 지도의 영역의 남서쪽 화면 좌표
                var sw = proj.containerPointFromCoords(bounds.getSouthWest());
                
                // 현재 보이는 지도의 영역의 북동쪽 화면 좌표
                var ne = proj.containerPointFromCoords(bounds.getNorthEast());
                
                // 클리핑할 가상의 내부 영역을 만듭니다.
                var top = ne.y + CLIP_BUFFER;
                var right = ne.x - CLIP_BUFFER;
                var bottom = sw.y - CLIP_BUFFER;
                var left = sw.x + CLIP_BUFFER;
    
                // 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
                var clipPosition = getClipPosition(top, right, bottom, left, center, pos);
                
                // 클리핑된 좌표를 tracker의 위치로 사용합니다.
                tracker.style.top = clipPosition.y + 'px';
                tracker.style.left = clipPosition.x + 'px';
    
                // 말풍선의 회전각을 얻습니다.
                var angle = getAngle(center, pos);
                
                // 회전각을 CSS transform을 사용하여 지정합니다.
                // 브라우저 종류에따라 표현되지 않을 수도 있습니다.
                // https://caniuse.com/#feat=transforms2d
                balloon.style.cssText +=
                    '-ms-transform: rotate(' + angle + 'deg);' +
                    '-webkit-transform: rotate(' + angle + 'deg);' +
                    'transform: rotate(' + angle + 'deg);';
    
                // target이 영역 밖에 있을 경우 tracker를 노출합니다.
                setVisible(true);
            }
        }
    
        // 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
        //
        //  +-----------------------------+
        //  |              ^              |
        //  |              |              |
        //  |     +-----------------+     |
        //  |     |                 |     |
        //  |     |                 |     |
        //  |  <- |    Map Bounds   | ->  |
        //  |     |                 |     |
        //  |     |                 |     |
        //  |     +-----------------+     |
        //  |              |              |
        //  |              v              |
        //  +-----------------------------+
        //  
        // 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
        // TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
        // 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
        // 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
        // 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
        function extendBounds(bounds, proj) {
            // 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
            // 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
            // 픽셀 단위인 화면 좌표로 변환해야 합니다.
            var sw = proj.pointFromCoords(bounds.getSouthWest());
            var ne = proj.pointFromCoords(bounds.getNorthEast());
    
            // 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
            sw.x -= BOUNDS_BUFFER;
            sw.y += BOUNDS_BUFFER;
    
            ne.x += BOUNDS_BUFFER;
            ne.y -= BOUNDS_BUFFER;
    
            // 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
            // extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
            return new kakao.maps.LatLngBounds(
                            proj.coordsFromPoint(sw),proj.coordsFromPoint(ne));
            
        }
    
    
        // Cohen–Sutherland clipping algorithm
        // 자세한 내용은 아래 위키에서...
        // https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
        function getClipPosition(top, right, bottom, left, inner, outer) {
            function calcOutcode(x, y) {
                var outcode = OUTCODE.INSIDE;
    
                if (x < left) {
                    outcode |= OUTCODE.LEFT;
                } else if (x > right) {
                    outcode |= OUTCODE.RIGHT;
                }
    
                if (y < top) {
                    outcode |= OUTCODE.TOP;
                } else if (y > bottom) {
                    outcode |= OUTCODE.BOTTOM;
                }
    
                return outcode;
            }
    
            var ix = inner.x;
            var iy = inner.y;
            var ox = outer.x;
            var oy = outer.y;
    
            var code = calcOutcode(ox, oy);
    
            while(true) {
                if (!code) {
                    break;
                }
    
                if (code & OUTCODE.TOP) {
                    ox = ox + (ix - ox) / (iy - oy) * (top - oy);
                    oy = top;
                } else if (code & OUTCODE.RIGHT) {
                    oy = oy + (iy - oy) / (ix - ox) * (right - ox);        
                    ox = right;
                } else if (code & OUTCODE.BOTTOM) {
                    ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
                    oy = bottom;
                } else if (code & OUTCODE.LEFT) {
                    oy = oy + (iy - oy) / (ix - ox) * (left - ox);     
                    ox = left;
                }
    
                code = calcOutcode(ox, oy);
            }
    
            return {x: ox, y: oy};
        }
    
        // 말풍선의 회전각을 구하기 위한 함수
        // 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
        function getAngle(center, target) {
            var dx = target.x - center.x;
            var dy = center.y - target.y ;
            var deg = Math.atan2( dy , dx ) * 180 / Math.PI; 
    
            return ((-deg + 360) % 360 | 0) + 90;
        }
        
        // tracker의 보임/숨김을 지정하는 함수
        function setVisible(visible) {
            tracker.style.display = visible ? 'block' : 'none';
        }
        
        // Map 객체의 'zoom_start' 이벤트 핸들러
        function hideTracker() {
            setVisible(false);
        }
        
        // target의 추적을 실행합니다.
        this.run = function() {
            kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
            kakao.maps.event.addListener(map, 'zoom_changed', tracking);
            kakao.maps.event.addListener(map, 'center_changed', tracking);
            tracking();
        };
        
        // target의 추적을 중지합니다.
        this.stop = function() {
            kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
            kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
            kakao.maps.event.removeListener(map, 'center_changed', tracking);
            setVisible(false);
        };
    }
    
    // 이스터 에그
    var dkpos1 = new kakao.maps.LatLng(37.24163075387211, 131.86505158287127);
    
    // 툴팁을 노출하는 마커를 생성합니다.
    var marker1 = new TooltipMarker(dkpos1, '독도는 한국 땅!');
    marker1.setMap(map);
    
    // MarkerTracker를 생성합니다.
    var markerTracker1 = new MarkerTracker(map, marker1);
    
    // marker의 추적을 시작합니다.
    markerTracker1.run();
    $('.node').on('click', function () {
        console.log('마커가 클릭되었습니다.');
        alertBody.html('');
        alertBody.html("명심하세요! 독도는 한국땅입니다! 😉");
        alertShowBtn.click();
    });
    
    // 선택한 장소 배열을 초기화
    selectedPlaces = [];
    // 선택한 장소 마커 배열을 초기화
    selectMarkers = [];
    // 선택한 마커에 라인 배열을 초기화
    polylineArray = [];
    // 지도를 특정 레벨로 확대합니다.
    var zoomLevel = map.getLevel(); 
    map.setLevel(zoomLevel);
    // 지도에 컨트롤을 추가해야 지도위에 표시됩니다
    // kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
    // 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
    var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

    for (var i = 0; i < selectPlaces.length; i++) {
        const selectedPlacesData = $('#day' + (i + 1) + '.tab-pane').find('.spotListone');
        // const isActive = $('#day' + (i + 1)).hasClass('active show');

        let polyline;
        let path = [];


        if (i === 0) {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#a9a7fa',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        } else if (i === 1) {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#9795CF',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        } else if (i === 2) {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#64638F ',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        } else if (i === 3) {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#45459B',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        } else if (i === 4) {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#363062',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        } else {
            polyline = new kakao.maps.Polyline({
                strokeWeight: 4,
                strokeColor: '#FF0000',
                strokeOpacity: 0.8,
                strokeStyle: 'solid',
                endArrow: true,
                zIndex: 1
            });
        }
        
        selectedPlacesData.each(function (index, element) {
            const spTitle = $(element).find('.pname').text();
            const spLatitude = parseFloat($(element).find('.info-address.plat small').text());
            const spLongitude = parseFloat($(element).find('.info-address.plong small').text());
            const spAddress = $(element).find('.info-address.paddress small').text();
            const spRoadAddress = $(element).find('.info-address.proadaddress small').text();
            const spImgUrl = $(element).find('.info-address.pimgUrl small').text();
            const spCategory = $(element).find('.info-address.pcategory small').text();
            const spPhone = $(element).find('.info-address.phone small').text();

            const placeDetails = {
                title: spTitle,
                latitude: spLatitude,
                longitude: spLongitude,
                address: spAddress,
                roadaddress: spRoadAddress,
                imgUrl: spImgUrl,
                category: spCategory,
                phone: spPhone,
            };

            selectedPlaces.push(placeDetails);


            $(element).on("click", function () {
                const clickedLatitude = placeDetails.latitude;
                const clickedLongitude = placeDetails.longitude;
                // 지도를 특정 레벨로 확대합니다.
                zoomLevel = map.getLevel(); 
                map.setLevel(zoomLevel);

                map.panTo(new kakao.maps.LatLng(clickedLongitude, clickedLatitude));
            });

            let imageSize = new kakao.maps.Size(26, 38);
            let markerImage;

            if ( i === 0 ){
                markerImage = new kakao.maps.MarkerImage(
                    "../img/marker/1marker"+(index+1)+".png",
                    imageSize
                );
            } else if ( i === 1 ){
                markerImage = new kakao.maps.MarkerImage(
                    "../img/marker/2marker"+(index+1)+".png",
                    imageSize
                );
            } else if ( i === 2 ){
                markerImage = new kakao.maps.MarkerImage(
                    "../img/marker/3marker"+(index+1)+".png",
                    imageSize
                );
            } else if ( i === 3 ){
                markerImage = new kakao.maps.MarkerImage(
                    "../img/marker/4marker"+(index+1)+".png",
                    imageSize
                );
            } else if ( i === 4 ){
                markerImage = new kakao.maps.MarkerImage(
                    "../img/marker/5marker"+(index+1)+".png",
                    imageSize
                );
            } else {
                markerImage = new kakao.maps.MarkerImage(
                    "../img/EndMarker.png",
                    imageSize
                );
            }

            let newMarker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(spLongitude, spLatitude),
                map: map,
                title: spTitle,
                image: markerImage,
                zIndex: 15,
            });

            // 생성한 마커를 selectMarkers 배열에 추가
            selectMarkers.push(newMarker);

            kakao.maps.event.addListener(newMarker, 'click', (function (details) {
                return function () {

                    let overlayContent = '<div class="wrap">' +
                        '<div class="info">' +
                        '<div class="title">' +
                        '<a style="text-decoration: none; color: #fff;" href="' + details.imgUrl + '" alt="' + details.imgUrl + '">' +
                        details.title +
                        '</a>' +
                        '<div class="close" onclick="closeOverlay()" title="닫기"><i class="bi bi-x"></i></div>' +
                        '</div>' +
                        '<div class="body">' +
                        '<div class="img">' +
                        '<a  href="' + details.imgUrl + '" alt="' + details.imgUrl + '">' +
                        '<img src="../img/LogoRaccoon.png" width="73" height="70">' +
                        '</a>' +
                        '</div>' +
                        '<div class="desc">' +
                        '<div class="ellipsis">' + details.address + '</div>' +
                        '<div class="jibun ellipsis">' + details.category + '</div>' +
                        '<div class="jibun ellipsis">' + details.roadaddress + '</div>' +
                        '<div class="jibun ellipsis">' + details.phone + '</div>' +
                        '<div class="jibun ellipsis"><a style="position: absolute; right: 8px; bottom: 2px;color: blueviolet;" href="' + details.imgUrl + '" alt="' + details.imgUrl + '">홈페이지</a></div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    let newoverlay = new kakao.maps.CustomOverlay({
                        content: overlayContent,
                        map: map,
                        position: new kakao.maps.LatLng(details.longitude , details.latitude ),
                        zIndex: 16,
                    });
                    overlays.push(newoverlay);
                };
            })(placeDetails));

            path.push(new kakao.maps.LatLng(spLongitude ,spLatitude));
        });
        // polyline을 지도에 추가
        polyline.setPath(path);
        polyline.setMap(map);

        // polyline을 배열에 저장
        polylineArray.push(polyline);

        // selectMarkers 배열의 각 마커를 지도에 추가
        selectMarkers.forEach(marker => {
            marker.setMap(map);
        });
    }
}

function closeOverlay() {
    if (overlay) {
        overlay.setMap(null);
    }
    $('.wrap').css('display', 'none');
}
