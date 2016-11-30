<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주소로 장소 표시하기</title>
<style type="text/css">
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<body>
	<p style="margin-top: -12px">
		<em class="link"> <a href="javascript:void(0);"
			onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
				혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. </a>
		</em>
	</p>
	<div id="map" style="width: 100%; height: 350px;"></div>
	<br/> 
	<div>
		<form id="searchAddrFrm">
			주소 검색 : <input type="text" id="searchAddr" name="searchAddr" placeholder="왜 엔터입력시 새로고침 되는가"/>
		</form>
		<br/> 
		<br/> 
		<form id="regRestaurantFrm">
			지번주소  : <input type="text" id="addr" name="addr"  size="50"/> <br/> <br/> 
			도로명주소  : <input type="text" id="newAddr" name="newAddr" size="50" /><br/> <br/> 
			위도  : <input type="text" id="latitude" name="latitude" size="50" /><br/> <br/> 
			경도  : <input type="text" id="longitude" name="longitude" size="50" /><br/> <br/> 
		</form>
	</div>

	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=0d211626a8ca667e54b95403a7ae692f&libraries=services"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			$("#searchAddr").keyup(function(){
				
				showAddr($(this).val());	
				
			});
		
			
		});//end of $(document).ready()
	
	</script>
	<!-- 주소입력으로 장소 검색 -->
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(37.518517, 126.984507), // 지도의 중심좌표 : 서빙고 골프연습장
			level : 5
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);

		function showAddr(keyword){
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new daum.maps.services.Geocoder();
	
			// 주소로 좌표를 검색합니다
			geocoder.addr2coord(keyword, function(status, result) {
	
								// 정상적으로 검색이 완료됐으면 
								if (status === daum.maps.services.Status.OK) {
	
									var coords = new daum.maps.LatLng(
											result.addr[0].lat, result.addr[0].lng);
	
									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new daum.maps.Marker({
										map : map,
										position : coords
									});
	
									// 인포윈도우로 장소에 대한 설명을 표시합니다
									var infowindow = new daum.maps.InfoWindow(
											{
												content : '<div style="width:150px;text-align:center;padding:6px 0;">'+keyword+'</div>'
											});
									infowindow.open(map, marker);
	
									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		}
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();

		var marker = new daum.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new daum.maps.InfoWindow({
				zindex : 100
		}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

		// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
							searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
										//alert(mouseEvent.latLng);
										
										// 클릭한 위도, 경도 정보를 가져옵니다 
									    var latlng = mouseEvent.latLng;
										
										$("#latitude").val(latlng.getLat());
										$("#longitude").val(latlng.getLng());
										
										if (status === daum.maps.services.Status.OK) {
											var detailAddr = !!result[0].roadAddress.name ? '<div>도로명주소 : '
													+ result[0].roadAddress.name
													+ '</div>'
													: '';
											detailAddr += '<div>지번 주소 : '
													+ result[0].jibunAddress.name
													+ '</div>';

											var content = '<div class="bAddr">'
													+ '<span class="title">주소정보</span>'
													+ detailAddr + '</div>';

											// 마커를 클릭한 위치에 표시합니다 
											marker.setPosition(mouseEvent.latLng);
											marker.setMap(map);

											// 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
											infowindow.setContent(content);
											infowindow.open(map, marker);
											
											//검색된 주소정보를  input태그에 입력하기.
											$("#addr").val(result[0].jibunAddress.name);
											$("#newAddr").val(result[0].roadAddress.name);
										}
									});
						});

		function searchDetailAddrFromCoords(coords, callback) {
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2detailaddr(coords, callback);
		}
	</script>

	
</body>
</html>