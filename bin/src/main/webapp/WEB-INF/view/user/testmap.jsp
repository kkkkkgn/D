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
        .wrap {
            position: absolute;left:0;bottom:40px;
            width: 288px;height: 132px;margin-left: -144px;text-align: left;
            overflow: hidden;font-size:12px;line-height: 1.5;
        }
        .wrap * {
            padding:0;margin: 0;box-sizing: border-box;
        }
        .wrap .info {
            width: 286px;height: 120px;border-radius: 5px;
            border-bottom: 1px solid #ccc; border-right: 1px solid #ccc;
            overflow: hidden;background: #fff;
        }
        .wrap .info:nth-child(1){ border:0px; box-shadow: 0px 1px 2px #888;}
        .info .title {
            padding: 5px 0 0 10px; height: 30px; background-color: #eee;
            border-bottom: 1px solid #ddd; font-size: 18px; overflow: hidden;
        }
        .info .close {
            position: absolute; top:10px;color:#888;
            width: 17px; height: 17px; background: url('http://t1.daumcdn.net/localimages/07/mapapidoc/overlay_close.png');
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
    </head>
	
<body class="flex gap-4 mt-3" style="box-sizing: border-box; flex-wrap: wrap; width: 1000px; margin: auto;">

    <div id="map" style="width: 500px; height: 500px;"></div>
    <script src='//dapi.kakao.com/v2/maps/sdk.js?appkey=61d0c0883a09f0cac4e91b6dee183a31&libraries=services'></script>
    <script>
        var mapContainer = document.getElementById('map'),
            mapOption = {
                center: new kakao.maps.LatLng(37.554688, 126.970669), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };
    
        // 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다.
        var map = new kakao.maps.Map(mapContainer, mapOption);
    
        // 커스텀 오버레이에 대한 콘텐츠
        // 닫기 버튼을 제공하여 이벤트 제어를 사용자에게 맡김
        var positions = [
            {
                content: '<div class="bg-white">서울역</div>',
                latlng: new kakao.maps.LatLng(37.554688, 126.970669)
            },
            {
                content: '<div class="bg-white">서울특별시청</div>',
                latlng: new kakao.maps.LatLng(37.5668260, 126.9786567)
            }
        ];
    
        var overlay = new kakao.maps.CustomOverlay({
            content: '<div class="wrap">' +
                '<div class="info">' +
                '<div class="title"> 서울역' +
                '<div class="close" onclick="closeOverlay()" title="닫기"></div>' +
                '</div>' +
                '<div class="body">' +
                '<div class="img">' +
                '<img src="https://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
                '</div>' +
                '<div class="desc">' +
                '<div class="ellipsis">서울특별시 용산구 동자동 43-205</div>' +
                '<div class="jibun ellipsis">서울역은 서울특별시 용산구와 중구에 </div>' +
                '<div class="jibun ellipsis">위치한 민자역사 철도역입니다. </div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>' +
                '</div>',
            map: map,
            position: positions[0].latlng
        });
    
        // 마커 이미지의 이미지 주소
        var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
    
        for (var i = 0; i < positions.length; i++) {
            // 마커 이미지의 이미지 크기
            var imageSize = new kakao.maps.Size(24, 35);
            // 마커 이미지 생성
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
            // 마커 생성
            var marker = new kakao.maps.Marker({
                map: map,
                position: positions[i].latlng,
                image: markerImage
            });
    
            // 마커에 이벤트를 등록하는 함수 추가 (즉시 호출하여 클로저 생성)
            // 클로저를 만들지 않으면 마지막 마커에만 이벤트 생성됨
            (function (marker) {
                // 마우스 클릭 이벤트
                kakao.maps.event.addListener(marker, 'click', function () {
                    overlay.setPosition(marker.getPosition());
                    overlay.setMap(map);
                });
            })(marker);
        }
    
        function closeOverlay() {
            overlay.setMap(null);
        }
    </script>
</body>
</html>