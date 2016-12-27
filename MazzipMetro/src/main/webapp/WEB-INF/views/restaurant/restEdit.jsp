<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>:: 업장 수정 페이지입니다 ::</title>
<style type="text/css">
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    
    /* 테이블 css */
    th, td { padding: 10px;}
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
		주소 검색 : <input type="text" id="searchAddr" name="searchAddr" placeholder="새로운 주소를 입력해주세요." onkeydown="goButton();"/>
		&nbsp;<button type="button" onclick="goFrm();">입력</button>
		<br/> 
		<hr/> 
		<br/> 
		<form name="editFrm"  enctype="multipart/form-data">
		<table style=" border-collapse: collapse; ">
		<tr><th>업장명 :					</th><td><input type="text" id="restName" 			name="restName"  		size="50" value="${vo.restName}" class="required" /></td></tr>
		<tr><th>지번주소  :					</th><td><input type="text" id="restAddr" 			name="restAddr"  		size="50" value="${vo.restAddr}" 	class="required" disabled/></td></tr>
		<tr><th>도로명주소  : 				</th><td><input type="text" id="restNewAddr" 		name="restNewAddr" 	size="50" value="${vo.restNewAddr}"/></td></tr>
		<tr><th>전화번호  : 				</th><td><input type="text" id="restPhone" 			name="restPhone" 		size="50" value="${vo.restPhone}" /></td></tr>
		<tr><th>위도  : 					</th><td><input type="text" id="restLatitude" 		name="restLatitude" 	size="50" value="${vo.restLatitude}" class="required" disabled/></td></tr>
		<tr><th>경도  :	 				</th><td><input type="text" id="restLongitude"	name="restLongitude" size="50" value="${vo.restLongitude}" class="required" disabled/></td></tr>
		<tr><th>업장 대표이미지  :	 		</th><td id="addImg"><img src="<%=request.getContextPath()%>/files/rest/${vo.restImg}" id="currImg" width="300px;"><br/><br/><input type='file' id="attach" name="attach" /></td></tr>
		<tr><th>업장 소개글  :	 			</th><td><textarea id="restContent"		name="restContent"  rows="4" cols="48">${vo.restContent}</textarea></td></tr>
		<tr><th>인근 지하철역  : 			</th><td><select id="metroId" name="metroId" class="required"></select>
		<tr><th>태그(대분류)  :</th><td> 		
								<input type = "checkbox" class = "restBgTag" name = "restBgTag" id="한식" value="한식" /><label for="한식">한식</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restBgTag" name = "restBgTag" id="양식" value="양식" /><label for="양식">양식</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restBgTag" name = "restBgTag" id="일식" value="일식" /><label for="일식">일식</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restBgTag" name = "restBgTag" id="중식" value="중식" /><label for="중식">중식</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restBgTag" name = "restBgTag" id="동남아" value="동남아" /><label for="동남아">동남아</label>
							</td></tr>		
		<tr><th>태그(중분류)  :</th><td>			
								<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="고기류" value="고기류" /><label for="고기류">고기류</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="어폐류" value="어폐류" /><label for="어폐류">어폐류</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="채소류" value="채소류" /><label for="채소류">채소류</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="밥류" value="밥류" /><label for="밥류">밥류</label>&nbsp;&nbsp;
								<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="면류" value="면류" /><label for="면류">면류</label>
							</td></tr>
		<input type="hidden" id="userSeq" name="userSeq" value="${vo.userSeq}"/>
		<input type="hidden" name="dongId" />
		<input type="hidden" name="restSeq" value = "${vo.restSeq}" />
		<input type="hidden" name="gradeSeq" id="gradeSeq" value = "${vo.gradeSeq}" />
		<input type="hidden" name="restStatus" value = "0" />
		</table>
		</form>
		<hr/> 
		<div align="center">
		<button type= "button" id = "btnEdit" onClick = "goEdit();"><span style="color:red; font-weight: bold;">업장 정보 변경</span></button>
		</div>
	</div>

	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=0d211626a8ca667e54b95403a7ae692f&libraries=services"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
	<script type="text/javascript">
	
		$(document).ready(function(){
			
			$("#searchAddr").focus();
			getMetroName();
			setCenter();
			tagChecked();
			
			// restStatus 값 select 에 넣어주기
			$("#restStatus").val('${vo.restStatus}');
			
			// 주소 입력시 keyup이벤트 생성
			$("#searchAddr").keyup(function(){
				showAddr($(this).val());	
			});
			
			// 파일 인풋태그변화시 호출된다. 하지만, 새로 생성한  html 코드에 대해서는 적용되지 않는다.
			$("[name=attach]").change(function(){
			    showCurrImg(this);
			});
		
		});//end of $(document).ready()
		
		// 태그에 체크하기
		function tagChecked(){
			<c:forEach var = "bgtag" items = "${bgTagArr}">
				$("input:checkbox[id='${bgtag}']").prop("checked",true);
			</c:forEach>
			<c:forEach var = "mdtag" items = "${mdTagArr}">
				$("input:checkbox[id='${mdtag}']").prop("checked",true);
			</c:forEach>
		}
		
		// input 태그 엔터키 refresh 방지 및 form 주소 입력!
		function goButton() {
			 if (event.keyCode == 13) {
				 goFrm();
			  	return false;
			 }
			 return true;
		}
		
		// test : 이미지 업로드시 바로 보여주는 코드
		function showCurrImg(input) {
			
		    if (input.files && input.files[0]) {
		        var reader = new FileReader();
		
		        reader.onload = function (e) {
		            $('#currImg').attr('src', e.target.result);
		        }
		
		        reader.readAsDataURL(input.files[0]);
		    }
		}


		// event를 파라미터로 전달해서 event.preventDefault(); 실행!
		function goEdit(event){
			
			var dongId = getDongId($("#restAddr").val());
			
			$(".required").each(function(){
				//alert($(this).prop('tagName'));
				if($(this).val().trim().length == 0){
					alert('필수항목을 기입해주세요!');
					$(this).focus();
					event.preventDefault();
				} 
			});
			
			var bgTagCheck = $(".restBgTag:checked").length;
			var mdTagCheck = $(".restMdTag:checked").length;
			
			if (bgTagCheck < 1 || mdTagCheck < 1) {
				alert('태그는 꼭 1개 이상 선택하셔야합니다');
				event.preventDefault();
			}
			
				editFrm.dongId.value = dongId;
				//editFrm.restArr.disabled = false;
				//editFrm.restSeq.disabled = false;
				$("#restAddr").prop('disabled', false);
				$("#restSeq").prop('disabled', false);
				$("#gradeName").prop('disabled', false);
				$("#restLatitude").prop('disabled', false);
				$("#restLongitude").prop('disabled', false);
				
				editFrm.method="post";
				editFrm.action="<%=request.getContextPath()%>/restEditEnd.eat";
				editFrm.submit();
				
		
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
						if ('${vo.metroId}' == metroNameList[i].metroId ) {
								metroNameOptionHtml += "<option value='"+metroNameList[i].metroId+"' selected>"+metroNameList[i].metroName+"</option>";
						} else {
							metroNameOptionHtml += "<option value='"+metroNameList[i].metroId+"'>"+metroNameList[i].metroName+"</option>";							
						}
					} // end of for (var i = 0; i < metroNameList.length; i++)
					
					$("#metroId").html(metroNameOptionHtml);
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
					
					$("#restAddr").val(addr);
					$("#restNewAddr").val(newAddr);
					$("#restLatitude").val(lat);
					$("#restLongitude").val(lng);
				
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

		marker  = new daum.maps.Marker({
			map : map,
			position : new daum.maps.LatLng(
					${vo.restLatitude}, ${vo.restLongitude})
		});
		
		// 지도 중심좌표 업장으로 변경하기
		function setCenter() {
		    // 이동할 위도 경도 위치를 생성합니다 
		    var moveLatLon = new daum.maps.LatLng(${vo.restLatitude}, ${vo.restLongitude});
		    
		    // 지도 중심을 부드럽게 이동시킵니다
		    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
		    map.setCenter(moveLatLon);            
		}        
		
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
								
								$("#restAddr").val(addr);
								$("#restNewAddr").val(newAddr);
								$("#restLatitude").val(lat);
								$("#restLongitude").val(lng);
							
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