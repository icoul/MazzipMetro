<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 클러스터러에 클릭이벤트 추가하기</title>
    
</head>
<body>
<p style="margin-top:-12px">
     사용한 데이터를 보시려면
    <em class="link">
       <a href="/download/web/data/chicken.json" target="_blank">여기를 클릭하세요!</a>
    </em>
</p>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=bf7db50bdf035e740bf5fd98b5509627&libraries=clusterer"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script>
    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 14 // 지도의 확대 레벨 
    });
    
    // 마커 클러스터러를 생성합니다 
    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다 
    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다 
    var clusterer = new daum.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 10, // 클러스터 할 최소 지도 레벨 
        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다 
    });
 
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
  $.ajax({
		url: "<%=request.getContextPath()%>/getRestaurantList.eat",  
		async: false, 
		dataType: "json",
		success: function(data) {
			alert(data.positions.length);
        	//alert(i+" : "+position.lat+", "+position.lng+", "+position.restName);
			var markers = $(data.positions).map(function(i, position) {
	        	
				// 마커를 생성합니다
			    var marker = new daum.maps.Marker({
			        position:  new daum.maps.LatLng(position.lat, position.lng)// 마커의 위치
			    });

			 // 커스텀 오버레이에 표시할 컨텐츠 입니다
			 // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
			 // 별도의 이벤트 메소드를 제공하지 않습니다 
			 var content = '<div class="wrap">' + 
						             '    <div class="info">' + 
						             '        <div class="title">' + position.restName+ '('+position.restSeq+')'+
						             /* '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +  */
						             '        </div>' + 
						             '        <div class="body">' + 
						             '            <div class="img">' +
						             '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70" title="음식점 대표이미지">' +
						             '           </div>' + 
						             '            <div class="desc">' + 
						             '                <div class="ellipsis">음식점 태그</div>' + 
						             '                <div class="jibun ellipsis">전화번호</div>' + 
						             '                <div><a href="" target="_blank" class="link">음식점 상세 페이지</a></div>' + 
						             '            </div>' + 
						             '        </div>' + 
						             '    </div>' +    
						             '</div>';

			 // 마커 위에 커스텀오버레이를 표시합니다
			 // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
			 var overlay = new daum.maps.CustomOverlay({
			     content: content,
			     //map: map, //overlay에는 생성시에 map 옵션 지정하지 말것. 
			     position: marker.getPosition()       
			 });


			    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
			    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
			    (function(marker, overlay) {
			        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
			        daum.maps.event.addListener(marker, 'mouseover', function() {
			        	overlay.setMap(map);
			        });

			        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
			       /* daum.maps.event.addListener(marker, 'mouseout', function() {
			        	closeOverlay();
			        });  */
			        
			        
			        // 마커를 클릭하면 해당 업장 상세페이지로 이동한다.
			       daum.maps.event.addListener(marker, 'click', function() {
			    	   	closeOverlay();
			        	<%-- location.href = '<%=request.getContextPath()%>/restaurantDetail.eat?restSeq='+position.restSeq; --%>
			        }); 
			 
			        
			        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
			        function closeOverlay() {
			            overlay.setMap(null);     
			        }
			        
			    })(marker, overlay);
	        	
			    return marker;
			    
	        });

	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
			
			}
	});//end of $.ajax()

    // 마커 클러스터러에 클릭이벤트를 등록합니다 
    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우 
    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다 
    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

        // 현재 지도 레벨에서 1레벨 확대한 레벨 
        var level = map.getLevel()-1;

        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다 
        map.setLevel(level, {anchor: cluster.getCenter()});  
    });
</script>
</body>
</html> 
<%-- <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>마커 클러스터러에 클릭이벤트 추가하기</title>
    
</head>
<body>
<p style="margin-top:0px">
     사용한 데이터를 보시려면
    <em class="link">
       <a href="<%=request.getContextPath()%>/getRestaurantList.eat" target="_blank">여기를 클릭하세요!</a>
    </em>
</p>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=07a6ce4a014b94664ec5968dee2fb0d2&libraries=clusterer"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script>
    var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new daum.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 14 // 지도의 확대 레벨 
    });
    
    // 마커 클러스터러를 생성합니다 
    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다 
    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다 
    var clusterer = new daum.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 5, // 클러스터 할 최소 지도 레벨 
        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다 
    });
 
    // 데이터를 가져오기 위해 jQuery를 사용합니다
    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
    $.ajax({
		url: "<%=request.getContextPath()%>/getRestaurantList.eat",  
		async: false, 
		dataType: "json",
		success: function(data) {
			//alert(data);
			var markers = $(data.positions).map(function(i, position) {
	        	alert(i+" : "+position.lat+" "+position.lng);
	            return new daum.maps.Marker({
	                position : new daum.maps.LatLng(Number(position.lat), Number(position.lng))
	            });
	        });

	        // 클러스터러에 마커들을 추가합니다
	        clusterer.addMarkers(markers);
			
			}
	});//end of $.ajax()
    
    $.get("<%=request.getContextPath()%>/getRestaurantList.eat", function(data) {
    	alert(data);
        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
        var markers = $(data.positions).map(function(i, position) {
        	alert(i+" : "+position.lat+" "+position.lng);
            return new daum.maps.Marker({
                position : new daum.maps.LatLng(position.lat, position.lng)
            });
        });

        // 클러스터러에 마커들을 추가합니다
        clusterer.addMarkers(markers);
    });

    // 마커 클러스터러에 클릭이벤트를 등록합니다 
    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우 
    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다 
    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

        // 현재 지도 레벨에서 1레벨 확대한 레벨 
        var level = map.getLevel()-1;

        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다 
        map.setLevel(level, {anchor: cluster.getCenter()});  
    });
</script>
</body>
</html> --%>
