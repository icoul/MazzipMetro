<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>:: 업장 등록 페이지입니다 ::</title>
<style type="text/css">
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<body>
	<p style="margin-top: 10px">
		<em style="color: orange; font-size: 13px;"> 지도를 직접 클릭하셔서 입력하실 수 있습니다.
		</em>
	</p> 
	<div id="map" style="width: 100%; height: 350px;"></div>
	<br/> 
	<div>
		주소 검색 : <input type="text" id="searchAddr" name="searchAddr" placeholder="주소를 입력해주세요." onkeydown="goButton();"/>
		&nbsp;<button type="button" onclick="goFrm();">입력</button>
		<br/> 
		<hr/> 
		<br/> 
		지번주소  : <input type="text" id="addr" name="addr"  size="50"/> <br/> <br/> 
		도로명주소  : <input type="text" id="newAddr" name="newAddr" size="50" /><br/> <br/> 
		위도  : <input type="text" id="latitude" name="latitude" size="50" /><br/> <br/> 
		경도  : <input type="text" id="longitude" name="longitude" size="50" /><br/> <br/>
		인근 지하철역  : <select id="metroName" >
					<option>상계역</option>
					<option>잠실역</option>
					<option>잠실나루역</option>
					<option>강변역</option>
					<option>구의역</option>
					<option>건대입구역</option>
					<option>성수역</option>
					<option>뚝섬역</option>
					<option>한양대역</option>
					<option>상왕십리역</option>
					<option>신당역</option>
					<option>동대문역사문화공원역</option>
					<option>을지로4가역</option>
					<option>을지로3가역</option>
					<option>을지로입구역</option>
					<option>시청역</option>
					<option>충정로역</option>
					<option>아현역</option>
					<option>이대역</option>
					<option>신촌역</option>
					<option>홍대입구역</option>
					<option>합정역</option>
					<option>당산역</option>
					<option>영등포구청역</option>
					<option>문래역</option>
					<option>신도림역</option>
					<option>대림역</option>
					<option>구로디지털단지역</option>
					<option>신대방역</option>
					<option>신림역</option>
					<option>봉천역</option>
					<option>서울대입구역</option>
					<option>낙성대역</option>
					<option>사당역</option>
					<option>방배역</option>
					<option>서초역</option>
					<option>교대역</option>
					<option>강남역</option>
					<option>왕십리역</option>
					<option>도림천역</option>
					<option>양천구청역</option>
					<option>신정네거리역</option>
					<option>까치산역</option>
					<option>용답역</option>
					<option>신답역</option>
					<option>용두역</option>
					<option>신설동역</option>
					<option>역삼역</option>
					<option>선릉역</option>
					<option>삼성역</option>
					<option>종합운동장역</option>
					<option>당고개역</option>
					<option>신천역</option>
				 </select> 
		
		<button type= "button" id = "button1" onClick = "goRegister();">등록</button>
	</div>

	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=0d211626a8ca667e54b95403a7ae692f&libraries=services"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			$("#searchAddr").focus();
			
			getMetroName();
			$("#searchAddr").keyup(function(){
				
				showAddr($(this).val());	
				
			});
		
		});//end of $(document).ready()
		
		// input 태그 엔터키 refresh 방지 및 form 주소 입력!
		function goButton() {
			 if (event.keyCode == 13) {
				 goFrm();
			  	return false;
			 }
			 return true;
		}
		
		function goRegister(){
			var metroName = $("#metroName").val();
			
			var name = "${name}";
			var addr = $("#addr").val();
			var newAddr = $("#newAddr").val();
			var latitude = $("#latitude").val();
			var longitude = $("#longitude").val();
			var metroId = getMetroId(metroName);
			var dongId = getDongId(addr);
			
			if (addr == null || latitude == null || longitude == null || metroId == null || dongId == null) {
				alert("등록할 수 없는 가게입니다. 다시 입력해주세요.");
				event.preventDefault();
			}
			else if (name == null){
				alert("가게명을 올바르게 입력해주세요.");
				self.window.close(); // 팝업창 닫기
			}
			else {
				var frm = opener.window.document.registerFrm; 
		        
				frm.name.value = name;
		        frm.addr.value = addr;
		        frm.newAddr.value = newAddr;
				frm.latitude.value = latitude;
				frm.longitude.value = longitude;
				frm.metroId.value = metroId;
				frm.dongId.value = dongId;
				
				self.window.close(); // 팝업창 닫기
			}
		}
		//지하철역 명 가져오기
		function getMetroName () {
			//지하철 호선을 입력하면 해당 역이름 리스트를 가져온다.
			var metroNum = 2;
			
			$.ajax({
				url: "getMetroNameList.eat",  
				method:"POST",  	
				async: false,
				data: "metroNum="+metroNum, 
				dataType: "json",
				success: function(data) {
					//alert(data.metroId);
					metroNameList =  data.metroNameList;
					var metroNameOptionHtml = '';
					
					for (var i = 0; i < metroNameList.length; i++) {
						metroNameOptionHtml += "<option>"+metroNameList[i]+"</option>";
					}
					
					$("#metroName").html(metroNameOptionHtml);
					}
			});//end of $.ajax()
		}
		
		//지하철역id얻어오기
		function getMetroId(metroName){
			
		    var metroId;
			$.ajax({
				url: "getMetroId.eat",  
				method:"POST",  	
				async: false,
				data: "metroName="+metroName, 
				dataType: "json",
				success: function(data) {
					//alert(data.metroId);
					metroId =  data.metroId;
					
					}
			});//end of $.ajax()
			
			return metroId;
		}
		
		//동id얻어오기
		function getDongId(addr){
			//alert(addr);
			var position = new Array();
			var pos = addr.indexOf(" "); //index값이 담길 변수

		    while(pos > -1){
		        position.push(pos);
		        pos =  addr.indexOf(" ", pos + 1);
		    }
		    var dong = addr.substring(position[1]+1, position[2]);//시작index, 끝 index
			var dongId="";
		    
			$.ajax({
				url: "getDongId.eat",  
				method:"POST",  	
				async: false,
				data: "dongName="+dong, 
				dataType: "json",
				success: function(data) {
					//alert(data.dongId);
					dongId =  data.dongId;
					}
			});//end of $.ajax()
			
			return dongId;
		}
	
	</script>
	
	<!-- 주소입력으로 장소 검색 -->
	<script>
	
		var marker, infowindow, coords;
		
		function goFrm(){
			searchDetailAddrFromCoords(coords, function(status, result){
				//alert(coords);
				//alert(result[0].roadAddress.name);
				
				if (status === daum.maps.services.Status.OK) {
					
					//위,경도값 가져오기
					var lat = coords.getLat()
					    , lng = coords.getLng()
					    , addr =  result[0].jibunAddress.name
					    , newAddr = result[0].roadAddress.name;
					
					$("#addr").val(addr);
					$("#newAddr").val(newAddr);
					$("#latitude").val(lat);
					$("#longitude").val(lng);
				
				}  
				    
			});// end of searchDetailAddrFromCoords()
		}
		
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

					marker.setMap(null);
					infowindow.close();
					
					coords = new daum.maps.LatLng(
							result.addr[0].lat, result.addr[0].lng);

					// 결과값으로 받은 위치를 마커로 표시합니다
					marker = new daum.maps.Marker({
						map : map,
						position : coords
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					infowindow = new daum.maps.InfoWindow(
							{
								content : '<div style="width:150px;text-align:center;padding:6px 0;">'+keyword+'</div>'
							});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);
					
					// 클릭 이벤트 추가 
					daum.maps.event.addListener(marker, 'click', function() {
						searchDetailAddrFromCoords(coords, function(status, result){
							//alert(coords);
							//alert(result[0].roadAddress.name);
							
							if (status === daum.maps.services.Status.OK) {
								
								//위,경도값 가져오기
								var lat = coords.getLat()
								    , lng = coords.getLng()
								    , addr =  result[0].jibunAddress.name
								    , newAddr = result[0].roadAddress.name;
								
								$("#addr").val(addr);
								$("#newAddr").val(newAddr);
								$("#latitude").val(lat);
								$("#longitude").val(lng);
							
							}  
							    
						});// end of searchDetailAddrFromCoords()
						
						/* $("#addr").val(keyword);
						$("#newAddr").val('도로명 주소는 우째 구하냐..');
						$("#latitude").val(result.addr[0].lat);
						$("#longitude").val(result.addr[0].lng); */
		            });
					
				}// end of if (status === daum.maps.services.Status.OK)
					
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
						
						//alert(result[0].roadAddress);
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
			//alert('1');
		    // 좌표로 법정동 상세 주소 정보를 요청합니다
		    geocoder.coord2detailaddr(coords, callback);
		}
	</script>

	
</body>
</html>