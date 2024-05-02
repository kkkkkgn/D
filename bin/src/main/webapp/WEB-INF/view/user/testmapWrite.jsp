<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <!-- Kakao Map API 스크립트 추가 -->
    <style>
         .wrap {
            position: absolute;left:0;bottom:40px;
            width: 288px;height: 132px;margin-left: -144px;text-align: left;
            overflow: hidden;
            font-size:12px;line-height: 1.5;
        }
        .wrap * {
            padding:0;margin: 0;box-sizing: border-box;
        }
        .wrap .info {
            width: 286px;height: 120px;border-radius: 5px;
            border-bottom: 1px solid #ccc; border-right: 1px solid #ccc;
            overflow: hidden; 
            background: #fff;
        }
        .wrap .info:nth-child(1){ border:0px; box-shadow: 0px 1px 2px #888;}
        .info .title {
            padding: 5px 0 0 10px; height: 30px; background-color: #eee;
            border-bottom: 1px solid #ddd; font-size: 18px; overflow: hidden;
        }
        .info .close {
            position: absolute;
            top: 4px;
            color: #888;
            width: 21px;
            height: 20px;
            background: url(../img/x-icon.png);
            right: 8px;
        }
        .info .close:hover{
            cursor: pointer;
        }
        .info .body {
            position: relative; overflow: hidden;
        }
        .info .desc {
            position: relative; margin: 13px 0 0 90px; height: 75px;
        }
        .desc .ellipsis {
            overflow: hidden; text-overflow: ellipsis; white-space: nowrap;
        }
        .info .jibun{
            font-size: 11px; color: #888; margin-top: -2px;
        }
        .info .img {
            position: absolute; top: 6px; left: 5px; width: 73px; height: 71px; border: 1px solid #ddd;
            color: #888; overflow: hidden;
        }
        .info::after {
            content: '';
            position: absolute; margin-left: -12px; left: 50%;  bottom: 0;
            width: 22px; height: 12px; background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png');
        }
        .info .link{ color: #5085BB;} 
    </style>
        <script type="text/javascript">
         
        </script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61d0c0883a09f0cac4e91b6dee183a31"></script>
</head>
<body class="flex gap-4 mt-3" style="box-sizing: border-box; flex-wrap: wrap; width: 1000px; margin: auto;">
    <!-- 지도를 표시할 컨테이너 -->
    <div id="map" style="width:100%;height:400px;"></div>

    <script type="text/javascript">

        const REST_API_KEY = 'e6f70ebe197d015b321682644e0afc1b';
        let overlays = [];
        // Your map-related JavaScript code here
        function initializeMap() {
            const latitude = '';
            const longitude = '';
            const radius = 10000;
            const query = '학원';
            const region = '강남';
            const size = 15;
            const address = '';

            const url = 'https://dapi.kakao.com/v2/local/search/keyword.json' +
                '?region=' + encodeURIComponent(region) +
                '&query=' + encodeURIComponent(query) +
                '&address=' + encodeURIComponent(address) +
                '&y=' + encodeURIComponent(latitude) +
                '&x=' + encodeURIComponent(longitude) +
                '&radius=' + encodeURIComponent(radius) +
                '&size=' + encodeURIComponent(size);

            const mapContainer = document.getElementById('map');
            const mapOptions = {
                center: new kakao.maps.LatLng(37.5668260, 126.9786567), // 서울시청을 기본 중심으로 설정
                level: 12, // 지도 확대 레벨
            };

            // 지도 생성
            const map = new kakao.maps.Map(mapContainer, mapOptions);

            // Kakao API로부터 데이터를 가져오는 코드 (fetch 등 사용)
            fetch(url, {
                method: 'GET',
                headers: {
                    'Authorization': 'KakaoAK ' + REST_API_KEY,
                },
            })
            .then(response => response.json())
            .then(data => {
                console.log(data);
                // 검색 결과를 활용하여 마커 표시
                data.documents.forEach(place => {
                    const latitude = place.y;
                    const longitude = place.x;

                    // 마커 이미지의 이미지 크기
                    const imageSize = new kakao.maps.Size(24, 35);
                    // 마커 이미지 생성
                    const markerImage = new kakao.maps.MarkerImage(
                        "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png",
                        imageSize
                    );
                    const imageUrl = place.place_url;
                    // 마커 생성
                    const marker = new kakao.maps.Marker({
                        position: new kakao.maps.LatLng(latitude, longitude),
                        map: map,
                        title: place.place_name,
                        image: markerImage,
                    });

                    // 마커에 클릭 이벤트 등록
                    kakao.maps.event.addListener(marker, 'click', function () {
                        // 오버레이를 생성하고 지도에 표시
                        overlay = new kakao.maps.CustomOverlay({
                            content: '<div class="wrap">' +
                                '<div class="info">' +
                                '<div class="title">' + 
                                '<a href="'+ imageUrl +'" alt="'+ imageUrl +'">' +
                                place.place_name +
                                '</a>' +
                                '<div class="close" onclick="closeOverlay(overlay)" title="닫기"></div>' +
                                '</div>' +
                                '<div class="body">' +
                                '<div class="img">' +
                                '<a href="'+ imageUrl +'" alt="'+ imageUrl +'">' +
                                '<img src="../img/kakaoMap.png" width="73" height="70">' +
                                '</a>' +
                                '</div>' +
                                '<div class="desc">' +
                                '<div class="ellipsis">' + place.address_name + '</div>' +
                                '<div class="jibun ellipsis">' + place.road_address_name + '</div>' +
                                '<div class="jibun ellipsis">' + place.phone + '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>' +
                                '</div>',
                            map: map,
                            position: new kakao.maps.LatLng(latitude, longitude),
                        });

                       
                        // 오버레이를 지도에 표시
                        overlay.setMap(map);
                        overlays.push(overlay);
                    });

                });
            })
            .catch(error => console.error('Error:', error));
        }
        function closeOverlay(e) {
            // Close all overlays in the array
            overlays.forEach(overlay => overlay.setMap(null));
            // Clear the overlays array
            overlays = [];
        }

        document.addEventListener('DOMContentLoaded', function() {
            initializeMap();
        });
    </script>
</body>
</html>