<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb - Map</title>
<link href="../css/default.css?ver=16" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?ver=11" rel="stylesheet" type="text/css">

<!-- 추가해서 넣은 css -->
<link href="../css/background_image.css?ver=12" rel="stylesheet" type="text/css">
<style type="text/css">
	/* 지도와 로드뷰를 감싸고 있는 div 입니다 */
#container {
	height: 800px;
	position: relative;
}

/* 지도를 감싸고 있는 div 입니다 */
#mapWrapper {
	width: 650px;
	height: 400px;
	position: static;
	z-index: 1;
}

/* 로드뷰를 감싸고 있는 div 입니다 */
#rvWrapper {
	width: 650px;
	height: 400px;
	top: 0;
	right: 0;
	position: static;
	z-index: 0;
	display: none;
}

/* 로드뷰 버튼처럼 생긴 링크 */
#roadviewControl {
	position: absolute;
	top: 5px;
	left: 5px;
	width: 65px;
	height: 24px;
	padding: 2px;
	z-index: 1;
	background: #f7f7f7;
	border-radius: 4px;
	border: 1px solid #c8c8c8;
	box-shadow: 0px 1px #888;
	cursor: pointer;
}

#roadviewControl span {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mapworker.png)
		no-repeat;
	padding-left: 23px;
	height: 24px;
	font-size: 12px;
	display: inline-block;
	line-height: 2;
	font-weight: bold;
}

#roadviewControl.active {
	background: #ccc;
	box-shadow: 0px 1px #5F616D;
	border: 1px solid #7F818A;
}

#roadviewControl.active span {
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mapworker_on.png)
		no-repeat;
	color: #4C4E57;
}

/* 닫기 버튼(링크) */
#close {
	position: static;
	padding: 4px;
	top: 5px;
	left: 5px;
	cursor: pointer;
	background: #fff;
	border-radius: 4px;
	border: 1px solid #c8c8c8;
	box-shadow: 0px 1px #888;
	
	border: 2px solid red;
}

#close .img {
	display: block;
	background:
		url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/rv_close.png)
		no-repeat;
	width: 14px;
	height: 14px;
}

/* 주소 텍스트 */
#addr {
	font-size: 1.2em;
	font-weight: bold;
	font-family: "나눔고딕", serif;
	margin-bottom: 10px;
}

#addr span {
	color: #ABABAB;
}

</style> 

<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp" />
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="welcome.jsp">FunWeb 소개</a></li>
<li><a href="map.jsp">FunWeb 위치</a></li>
<li><a href="#">FunWeb 소식</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Map</h1>
<div id="addr">주소: 부산 부산진구 동천로 109 삼한골든게이트 7층 <br>
<span>(우편번호) 47246, (지번) 부전동 112-3</span></div>
<div id="container">
		<div id="mapWrapper">
			<div id="map" style="width: 650px; height: 400px"></div>
			<!-- 지도를 표시할 div 입니다 -->
			<div id="roadviewControl" onclick="setRoadviewRoad()">
				<span>로드뷰</span>
			</div>
		</div>
		<div id="rvWrapper">
			<div id="roadview" style="width: 650px; height: 400px;"></div>
			<!-- 로드뷰를 표시할 div 입니다 -->
		</div>
	</div>
	
	<script type="text/javascript"
		src="//apis.daum.net/maps/maps3.js?apikey=e14d35518cc4c0f3fb23cc3fa56ae88d"></script>
	<script type="text/javascript">
		var overlayOn = false, // 지도 위에 로드뷰 오버레이가 추가된 상태를 가지고 있을 변수
		container = document.getElementById('container'), // 지도와 로드뷰를 감싸고 있는 div 입니다
		mapWrapper = document.getElementById('mapWrapper'), // 지도를 감싸고 있는 div 입니다
		mapContainer = document.getElementById('map'), // 지도를 표시할 div 입니다 
		rvContainer = document.getElementById('roadview'); //로드뷰를 표시할 div 입니다

		/* 지도 */
		var mapCenter = new daum.maps.LatLng(35.158417, 129.062073), // 지도의 중심좌표
		mapOption = {
			center : mapCenter, // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
		var map = new daum.maps.Map(mapContainer, mapOption);

		/* 지도 컨트롤 */
		// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
		var mapTypeControl = new daum.maps.MapTypeControl();
		// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
		// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
		map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
		// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
		var zoomControl = new daum.maps.ZoomControl();
		map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
		
		/* 목표지점 마커 */
		// 목표지점 마커가 표시될 위치입니다 
		var finalMarkerPosition  = new daum.maps.LatLng(35.158417, 129.062073); 
		// 목표지점 마커를 생성합니다
		var finalMarker = new daum.maps.Marker({
		    position: finalMarkerPosition
		});
		// 목표지점 마커가 지도 위에 표시되도록 설정합니다
		finalMarker.setMap(map);
		
		/* 인포윈도우 */
		var iwContent = '<div style="padding:5px;">FunWeb(아이티윌)!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
    	iwPosition = new daum.maps.LatLng(35.158800, 129.062073), //인포윈도우 표시 위치입니다
   	 	iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성하고 지도에 표시합니다
		var infowindow = new daum.maps.InfoWindow({
    	map: map, // 인포윈도우가 표시될 지도
    	position : iwPosition, 
    	content : iwContent
		});
		
   	 	// 마커위에 인포윈도우를 생성
   	 	infowindow.open(map, finalMarker);
   	 	
		/* 로드뷰 및 로드뷰생성시 이벤트들 */
		// 로드뷰 객체를 생성합니다 
		var rv = new daum.maps.Roadview(rvContainer);

		// 좌표로부터 로드뷰 파노라마 ID를 가져올 로드뷰 클라이언트 객체를 생성합니다 
		var rvClient = new daum.maps.RoadviewClient();

		// 로드뷰에 좌표가 바뀌었을 때 발생하는 이벤트를 등록합니다 
		daum.maps.event.addListener(rv, 'position_changed', function() {

			// 현재 로드뷰의 위치 좌표를 얻어옵니다 
			var rvPosition = rv.getPosition();

			// 지도의 중심을 현재 로드뷰의 위치로 설정합니다
			map.setCenter(rvPosition);

			// 지도 위에 로드뷰 도로 오버레이가 추가된 상태이면
			if (overlayOn) {
				// 마커의 위치를 현재 로드뷰의 위치로 설정합니다
				marker.setPosition(rvPosition);
			}
		});

		// 마커 이미지를 생성합니다
		var markImage = new daum.maps.MarkerImage(
				'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/roadview_wk.png',
				new daum.maps.Size(35, 39), {
					//마커의 좌표에 해당하는 이미지의 위치를 설정합니다.
					//이미지의 모양에 따라 값은 다를 수 있으나, 보통 width/2, height를 주면 좌표에 이미지의 하단 중앙이 올라가게 됩니다.
					offset : new daum.maps.Point(14, 39)
				});

		// 드래그가 가능한 마커를 생성합니다
		var marker = new daum.maps.Marker({
			image : markImage,
			position : mapCenter,
			draggable : true
		});

		// 마커에 dragend 이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'dragend', function(mouseEvent) {

			// 현재 마커가 놓인 자리의 좌표입니다 
			var position = marker.getPosition();

			// 마커가 놓인 위치를 기준으로 로드뷰를 설정합니다
			toggleRoadview(position);
		});

		//지도에 클릭 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {

			// 지도 위에 로드뷰 도로 오버레이가 추가된 상태가 아니면 클릭이벤트를 무시합니다 
			if (!overlayOn) {
				return;
			}

			// 클릭한 위치의 좌표입니다 
			var position = mouseEvent.latLng;

			// 마커를 클릭한 위치로 옮깁니다
			marker.setPosition(position);

			// 클락한 위치를 기준으로 로드뷰를 설정합니다
			toggleRoadview(position);
		});

		// 전달받은 좌표(position)에 가까운 로드뷰의 파노라마 ID를 추출하여
		// 로드뷰를 설정하는 함수입니다
		function toggleRoadview(position) {
			rvClient.getNearestPanoId(position, 50, function(panoId) {
				// 파노라마 ID가 null 이면 로드뷰를 숨깁니다
				if (panoId === null) {
					toggleMapWrapper(true, position);
				} else {
					toggleMapWrapper(false, position);

					// panoId로 로드뷰를 설정합니다
					rv.setPanoId(panoId, position);
				}
			});
		}

		 // 지도를 감싸고 있는 div의 크기를 조정하는 함수입니다
		function toggleMapWrapper(active, position) {
			if (active) {

				// 지도를 감싸고 있는 div의 너비가 100%가 되도록 class를 변경합니다 
				container.className = '';

				// 지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
				map.relayout();

				// 지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
				map.setCenter(position);
			} else {

				// 지도만 보여지고 있는 상태이면 지도의 너비가 50%가 되도록 class를 변경하여
				// 로드뷰가 함께 표시되게 합니다
				if (container.className.indexOf('view_roadview') === -1) {
					container.className = 'view_roadview';

					// 지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
					map.relayout();

					// 지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
					map.setCenter(position);
				}
			}
		} 

		// 지도 위의 로드뷰 도로 오버레이를 추가,제거하는 함수입니다
		function toggleOverlay(active) {
			if (active) {
				overlayOn = true;

				// 로드뷰를 감싸는 div를 보이는 상태로
				document.getElementById("rvWrapper").style.display="inline";
				
				// 지도 위에 로드뷰 도로 오버레이를 추가합니다
				map.addOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);

				// 지도 위에 마커를 표시합니다
				marker.setMap(map);

				// 마커의 위치를 지도 중심으로 설정합니다 
				marker.setPosition(map.getCenter());

				// 로드뷰의 위치를 지도 중심으로 설정합니다
				toggleRoadview(map.getCenter());
			} else {
				overlayOn = false;

				// 지도 위의 로드뷰 도로 오버레이를 제거합니다
				map.removeOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);

				// 지도 위의 마커를 제거합니다
				marker.setMap(null);
			}
		}

		// 지도 위의 로드뷰 버튼을 눌렀을 때 호출되는 함수입니다
		function setRoadviewRoad() {
			var control = document.getElementById('roadviewControl');

			// 로드뷰를 감싸는 div를 안보이는 상태로
			document.getElementById("rvWrapper").style.display="none";
			
			// 버튼이 눌린 상태가 아니면
			if (control.className.indexOf('active') === -1) {
				control.className = 'active';

				// 로드뷰 도로 오버레이가 보이게 합니다
				toggleOverlay(true);
			} else {
				control.className = '';

				// 로드뷰 도로 오버레이를 제거합니다
				toggleOverlay(false);
			}
		}

		// 로드뷰에서 X버튼을 눌렀을 때 로드뷰를 지도 뒤로 숨기는 함수입니다
		function closeRoadview() {
			var position = marker.getPosition();
			toggleMapWrapper(true, position);
		}
	</script>
	
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear" ></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp" />
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>