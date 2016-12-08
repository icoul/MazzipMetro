<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../top.jsp" />
	 <style type="text/css">
	    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
	    .wrap * {padding: 0;margin: 0;}
	    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
	    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
	    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
	    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
	    .info .close:hover {cursor: pointer;}
	    .info .body {position: relative;overflow: hidden;}
	    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
	    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
	    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
	    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
	    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	    .info .link {color: #5085BB;}
	 </style>
	 
	 <style>
	 table, th, td { border: solid 1px black;}
	 th, td {padding: 10px;}
	 </style>
	
</head>


<div id="selectFrmContainer" style="padding-top: 20px;padding-left: 20px;">
	<form id="selectFrm" onsubmit="return false;">
		<label class="radio-inline"><input type="radio" name="conq" value="already" checked>정복한 맛집</label>
		<label class="radio-inline"><input type="radio" name="conq" value="notYet">정복해야 할 맛집</label>
	</form>
</div>

<br/> 
<div id="map" style="width:100%;height:500px;"></div>

<script>
	$(document).ready(function(){
		
		//페이지 최초로딩시 등록된 음식점 모두 띄우기
		$("[name=conq]").change(function(){
			//alert($("[name=conq]").val());
			getRestaurant();
		});
		
		var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
	        level : 8// 지도의 확대 레벨 
	    });
		
		getRestaurant($("[name=conq]:checked").val());
			
	});// end of $(document).ready(
	
	var map, clusterer;
	
	// 업장 검색 함수
	function getRestaurant(){
	
		var conq = $("[name=conq]:checked").val();
	    // 데이터를 가져오기 위해 jQuery를 사용합니다
	    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	    $.ajaxSettings.traditional = true;
	    $.ajax({
			url: "<%=request.getContextPath()%>/getRestaurantVOList.eat",  
			async: false, 
			data: "conq="+conq,
			dataType: "json",
			success: function(data) {
				//alert(data.positions[0].restName);
				
				if(data.positions.length == 0 && conq =="already"){
					alert('정복한 음식점이 없습니다. 맛집 리뷰를 작성해주세요!');
					return;
				}else if(data.positions.length == 0 && conq=="notYet"){
					alert('모든 음식점을 정복하셨습니다. 당신은 맛집지존입니다!');
					return;
				}
				
				
				
				// 검색조건이 없을 때에는 기존의 마커들을 유지 하기 위햐여 지도 객체를 success 함수 안에 위치 시켰다. 전역변수화
				map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
			        level : 8// 지도의 확대 레벨 
			    });
				
			    
			    // 마커 클러스터러를 생성합니다 
			    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
			    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다 
			    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
			    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다 
			    clusterer = new daum.maps.MarkerClusterer({
			        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			        minLevel: 4, // 클러스터 할 최소 지도 레벨 
			        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다 
			    });
				
				var markers = $(data.positions).map(function(i, position) {
	        	//alert(i+" : "+position.lat+", "+position.lng+", "+position.restName);
		        	
				// 마커를 생성합니다
			    var marker = new daum.maps.Marker({
			        position:  new daum.maps.LatLng(position.restLatitude, position.restLongitude)// 마커의 위치
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
							             '                <img src="<%=request.getContextPath()%>/files/'+position.restImg+'" width="73" height="70">' +
							             '           </div>' + 
							             '            <div class="desc"><div class="ellipsis">'; 
							             
				if (position.restBgTag) {
					content += '                <span style="color:#ff6600; font_size: 14px;">'+position.restBgTag+'</span>&nbsp;';
				}		
				if (position.restMdTag) {
					content += '<span style="color:#80b3ff; font_size: 11px;">'+position.restMdTag+'</span>' ;  
				}
					  
							            
					   content += '                </div>'+
					   					 '<div class="ellipsis"><span style="color: #000099; font-weight:bold;">'+position.guName+'</span>&nbsp<span style="color: #b3b3ff; font-weight: bold;">'+position.dongName+'</span></div>' + 
							             '                <div class="jibun ellipsis">'+position.restPhone+'</div>' + 
							             '                <div>마커를 <span style="color:red">클릭</span>해서 음식점 정보를 수정하기</div>' + 
							             '            </div>' + 
							             '        </div>' + 
							             '    </div>' +    
							             '</div>';

					//alert(marker.getPosition());
				 
					// 마커 위에 커스텀오버레이를 표시합니다
				 // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
				 var overlay = new daum.maps.CustomOverlay({
				     content: content,
				     //map: map, //overlay에는 생성시에 map 옵션 지정하지 말것. 
				     position: marker.getPosition()       

				 }); // end of $(data.positions).map()


				    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
				    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
				    (function(marker, overlay) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				        daum.maps.event.addListener(marker, 'mouseover', function() {
				        	overlay.setMap(map);
				        });

				        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
				       daum.maps.event.addListener(marker, 'mouseout', function() {
				        	closeOverlay();
				        }); 
				        
				        
				        // 마커를 클릭하면 해당 업장 상세페이지로 이동한다.
				       daum.maps.event.addListener(marker, 'click', function() {
				    	   	//closeOverlay();
				    	   	goEdit(position.restSeq);
				    	   	
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
		
	}//end of getRestaurant()
    
</script>
<jsp:include page="../footer.jsp" />