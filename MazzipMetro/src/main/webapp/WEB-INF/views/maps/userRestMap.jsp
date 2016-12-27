<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 기본 jquery 라이브러리 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<!-- 동현_다음지도 api를 사용하기 위한 라이브러리 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=07a6ce4a014b94664ec5968dee2fb0d2&libraries=services,clusterer,drawing"></script>

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
	    
	    
	    table#tbl_conq {border: 1px solid gray;}
		table#tbl_conq th{border-bottom : 1px solid gray; padding: 9px;} 
	 </style>
	 
	 <style>
	 /* table, th, td { border: solid 1px black;} */
	 th, td {padding: 10px;}
	 </style>
	
</head>


<div id="selectFrmContainer" style="padding-top: 20px;margin: auto; width: 80%;">
	<form id="selectFrm" onsubmit="return false;">
		<div style="float: left;">
		<table id="tbl_conq" style="margin-right: 20px;margin-bottom: 15px;">
		<tr>
			<th><label class="radio-inline"><input type="radio" name="conq" value="already" checked>정복한 맛집</label></th>
			<th><label class="radio-inline"><input type="radio" name="conq" value="notYet">정복해야 할 맛집</label></th>
		</tr>
		<tr>
			<td><select name="selMenu_metroName" id="selMenu_metroName" class="form-control"></select></td>
			<td><select name="selMenu_dongName" id="selMenu_dongName" class="form-control"></select></td>
		</tr>
		</table>
		</div>
		
		<div style="float: left;">
			<table>
				<tr><th style="border: solid 1px gray; padding: 10px;">대분류</th><td style="border: solid 1px gray; padding: 10px;">
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="한식">한식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="일식">일식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="중식">중식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="양식">양식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="동남아">동남아</label>
				</td></tr>
				<tr><th style="border: solid 1px gray; padding: 10px;">중분류</th><td style="border: solid 1px gray; padding: 10px;">
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="고기류">고기류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="어폐류">어폐류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="채소류">채소류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="면류">면류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="밥류">밥류</label>
				</td></tr>
			</table>
		</div>
		
		
	</form>
</div>



<br/> 
<div id="map" style="width:100%;height:500px;"></div>

<script>
	$(document).ready(function(){
		
		// 대분류/중분류 변화시 바로 restarant.eat 구하기
		$("[name=restBgTag]").change(function(){
			var conq = $("[name=conq]:checked").val();
			getRestaurant(conq);
		});
		
		$("[name=restMdTag]").change(function(){
			var conq = $("[name=conq]:checked").val();
			getRestaurant(conq);
		});
		
		//페이지 최초로딩시 등록된 음식점 모두 띄우기
		$("[name=conq]").change(function(){
			getList();
		});
		
		var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
	        level : 8// 지도의 확대 레벨 
	    });
		
		map.setZoomable(false);
		
		getList();
		
		$("#selMenu_dongName").change(function(){
			$("#selMenu_metroName").val('metroId');
			getRestaurant($("[name=conq]:checked").val());
		});	
		
		$("#selMenu_metroName").change(function(){
			$("#selMenu_dongName").val('dongId');
			getRestaurant($("[name=conq]:checked").val());
		});
		
	});// end of $(document).ready(
	
	var map, clusterer;
	
	// 지도 마커 및 메뉴리스트 호출 함수
	function getList(){
		var conq = $("[name=conq]:checked").val();
		getDongMetroNameList(conq);
		getRestaurant(conq);
	}
	
	// 동이름/지하철이름 셀렉트 메뉴 호출
	function getDongMetroNameList(conq){
		var metroId = $("#selMenu_metroName").val()
		, dongId = $("#selMenu_dongName").val();
		
		//alert('dongId = '+dongId+', metroId = '+metroId)
		
		$.ajax({
				url:"<%=request.getContextPath()%>/getDongMetroNameList.eat",
				type :"GET",
				data: "conq="+conq,
				dataType:"json",
				success: function(data){
							var dongNameList = data.dongNameList;
							var metroNameList = data.metroNameList;
							
							var dongNameHtml = '<option value="dongId">동 선택하기</option>';
							var metroNameHtml = '<option value="metroId">지하철 선택하기</option>';
							
							for (var i = 0; i < dongNameList.length; i++) {
								if(dongId == dongNameList[i].dongId ){
									dongNameHtml += '<option value="'+dongNameList[i].dongId+'" selected>'+dongNameList[i].dongName+'</option>';
								} else {
									dongNameHtml += '<option value="'+dongNameList[i].dongId+'">'+dongNameList[i].dongName+'</option>';
								}
							}
							
							$("#selMenu_dongName").html(dongNameHtml);
							
							for (var i = 0; i < metroNameList.length; i++) {
								if (metroId == metroNameList[i].metroId) {
									metroNameHtml += '<option value="'+metroNameList[i].metroId+'" selected>'+metroNameList[i].metroName+'</option>';
								}else {
									metroNameHtml += '<option value="'+metroNameList[i].metroId+'">'+metroNameList[i].metroName+'</option>';									
								}
							}
							$("#selMenu_metroName").html(metroNameHtml);
							
				}, //end of success: function(data)
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error: function(request,status,error)
			}); //end of $.ajax()
	}
	
	function setBounds(bounds) {
	    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
	    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
	    map.setBounds(bounds);
	}
	
		
	// 업장 검색 함수
	function getRestaurant(conq){
		var metroId="metroId", dongId='dongId';
		if ($("#selMenu_metroName").val() !=null) {
			metroId = $("#selMenu_metroName").val();
		} 
		
		// **자바스크립트 배열은 반드시 아래와 같이 push를 통해서 할 것.**
		// jquery 셀렉터를 이용해 
		// var restBgTag = $("[name=restBgTag]:checked"); 
		// 이렇게 하면, [object Object]를 전송하고 사용이 불가하다.
		
		var restBgTag = [];
		$("[name=restBgTag]:checked").each(function(){
			restBgTag.push($(this).val());
		});
		
		var restMdTag = [];
		$("[name=restMdTag]:checked").each(function(){
			restMdTag.push($(this).val());
		});
		
		if ($("#selMenu_dongName").val() != null) {
			dongId = $("#selMenu_dongName").val();	
		}
		
		var searchFrmData = {
				conq : conq
			  , metroId : metroId
			  , dongId : dongId
			  , restBgTag : restBgTag
			  , restMdTag : restMdTag
		}
	
	    // 데이터를 가져오기 위해 jQuery를 사용합니다
	    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	    $.ajaxSettings.traditional = true;
	    $.ajax({
			url: "<%=request.getContextPath()%>/getRestaurantVOList.eat",  
			async: false,
			data: searchFrmData,
			dataType: "json",
			success: function(data) {
				//alert(data.positions[0].restName);
				
				if(data.positions.length == 0 && conq =="already"){
					var warning;
					if(metroId != null || dongId != null){
						warning = "이곳은 ";
					}
					warning += '정복한 맛집이 없습니다. 맛집 리뷰를 작성해주세요!';
					alert(warning);
					return;
				}else if(data.positions.length == 0 && conq=="notYet"){
					var warning;
					if(metroId != null || dongId != null){
						warning = "이곳은 ";
					}
					warning += "정복할 음식점이 없습니다. 검색조건을 확인해주세요!";
					alert(warning);
					return;
				}
				// 검색조건이 없을 때에는 기존의 마커들을 유지 하기 위햐여 지도 객체를 success 함수 안에 위치 시켰다. 전역변수화
				map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
			        level : 8// 지도의 확대 레벨 
			    });
				
				map.setZoomable(false);
				
				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new daum.maps.ZoomControl();
				map.addControl(zoomControl, daum.maps.ControlPosition.BOTTOMRIGHT);
			    
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
			    
			 	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			    var bounds = new daum.maps.LatLngBounds();    
			    
			 	
				var markers = $(data.positions).map(function(i, position) {
	        	//alert(i+" : "+position.lat+", "+position.lng+", "+position.restName);
		        	
				// 마커를 생성합니다
			    var marker = new daum.maps.Marker({
			        position:  new daum.maps.LatLng(position.restLatitude, position.restLongitude)// 마커의 위치
			    });
				
			    // LatLngBounds 객체에 좌표를 추가합니다
			    bounds.extend(marker.getPosition());

				 // 커스텀 오버레이에 표시할 컨텐츠 입니다
				 // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
				 // 별도의 이벤트 메소드를 제공하지 않습니다 
				 var content = '<div class="wrap">' + 
							             '    <div class="info">' + 
							             '        <div class="title">' + position.restName+
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
							             '                <div>마커를 <span style="color:red">클릭</span>해서 음식점 상세정보 보기</div>' + 
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
				    	   	location.href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq="+position.restSeq;
				    	   	
				        }); 
				 
				        
				        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
				        function closeOverlay() {
				            overlay.setMap(null);     
				        }
				        
				    })(marker, overlay);
		        	
				    return marker;
				    
		        }); //end of $(data.positions).map(function(i, postion){})

		        // 클러스터러에 마커들을 추가합니다
		        clusterer.addMarkers(markers);
				
		        setBounds(bounds);
		        
				}// end of success
			
	    		
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

