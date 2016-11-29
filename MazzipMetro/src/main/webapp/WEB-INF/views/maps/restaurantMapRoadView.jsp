<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>업장 상세페이지에 쓰일 지도, 로드뷰</title>
    <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=07a6ce4a014b94664ec5968dee2fb0d2"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/bootstrap/bootstrap.css">
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/bootstrap.js"></script>
    <style type="text/css">
    .modal.modal-wide .modal-dialog {
	  width: 90%;
	}
	.modal-wide .modal-body {
	  overflow-y: auto;
	}
	
	body {width: 90%;margin-left: 5%;}
	#tallModal .modal-body p { margin-bottom: 900px }
    </style>
    
    <script type="text/javascript">
 	// when .modal-wide opened, set content-body height based on browser height; 200 is appx height of modal padding, modal title and button bar

    $(".modal-wide").on("show.bs.modal", function() {
      var height = $(window).height() ;
      $(this).find(".modal-body").css("max-height", height);
    }); 
    </script>
</head>
<body>
<div id="map" style="width:100%;height:300px"></div> <!-- 지도를 표시할 div 입니다 -->
<div id="roadview" style="width:100%;height:300px"></div> <!-- 로드뷰를 표시할 div 입니다 -->
<br/> 
<br/> 
<div id="roadFinder">
	<form action="" name="roadFinderFrm">
		출발지를 입력하세요 : <input  type="text" name="startPoint" id="startPoint"/>
		<button type="button" onclick="goNavigator();">Go!</button>
	</form>
</div>



<h1>Bootstrap 3 Variable-Width Modal</h1>
<p>I wanted to override the default Bootstrap modal so it's variable-width, and height-optimized.</p>
<p>Add "modal-wide" to the main modal div, and adjust the width in the CSS. In this example, I'm using 90%.</p>
<p>Since I'm using jQuery to set the max-height of the content area based on the browser dimensions, the modal will be only as tall as necessary, and will provide a scrollbar if needed.</p>

<a data-toggle="modal" href="#tallModal" class="btn btn-primary">Wide, Tall Content</a>
<div id="tallModal" class="modal modal-wide fade">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title">Modal title</h4>
      </div>
      <div class="modal-body">
        <iframe style="border: none; width: 100%; height: 380px;" src="http://map.daum.net/?sName=&eName=${mapVO. restName}"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">

	$(document).ready(function(){
	
		
	});//end of $(document).ready()
	

</script>
<script>
function goNavigator(){
	var endPoint = $("#startPoint").val().trim();
	
	if(endPoint.length == 0){
		alert('출발지를 입력하세요!');
		$("#startPoint").focus();
		return;
	}
	
	var url = "http://map.daum.net/?sName="+$('#startPoint').val()+"&eName=${mapVO.restName}"; 
	//url  += "&eX=${mapVO.restLatitude}&eY=${mapVO.restLongitude}";
	
	var popup = window.open(url,"roadFinder",
    "left=500px, top=100px, width=1000px, height=1000px, menubar=no, status=no, scrollbars=yes ");
	
	
}


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapCenter = new daum.maps.LatLng('${mapVO.restLatitude}' , '${mapVO.restLongitude}'), // 지도의 중심 좌표
    mapOption = {
        center: mapCenter, // 지도의 중심 좌표
        level: 4 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption);

var myPosition = new daum.maps.LatLng('${mapVO.restLatitude}' , '${mapVO.restLongitude}');

// 지도에 올릴 마커를 생성합니다.
var mMarker = new daum.maps.Marker({
    position: myPosition, // 지도의 중심좌표에 올립니다.
    map: map // 생성하면서 지도에 올립니다.
});

// 지도에 올릴 장소명 인포윈도우 입니다.
var mLabel = new daum.maps.InfoWindow({
    position: myPosition, // 지도의 중심좌표에 올립니다.
    content: '<a href="" style="text-decoration: none;"><span style="color:navy; font-size : 12px;">${mapVO.restName} (으)로 가는 길찾기</span></a> ' // 인포윈도우 내부에 들어갈 컨텐츠 입니다.
});
mLabel.open(map, mMarker); // 지도에 올리면서, 두번째 인자로 들어간 마커 위에 올라가도록 설정합니다.

var rvContainer = document.getElementById('roadview'); // 로드뷰를 표시할 div

var rv = new daum.maps.Roadview(rvContainer); // 로드뷰 객체 생성
var rc = new daum.maps.RoadviewClient(); // 좌표를 통한 로드뷰의 panoid를 추출하기 위한 로드뷰 help객체 생성 
var rvPosition = new daum.maps.LatLng(${mapVO.restLatitude} ,${mapVO.restLongitude});

rc.getNearestPanoId(rvPosition, 50, function(panoid) {
    rv.setPanoId(panoid, rvPosition);//좌표에 근접한 panoId를 통해 로드뷰를 실행합니다.
});

// 로드뷰 초기화 이벤트
daum.maps.event.addListener(rv, 'init', function() {

    // 로드뷰에 올릴 마커를 생성합니다.
    var rMarker = new daum.maps.Marker({
        position: myPosition,
        map: rv //map 대신 rv(로드뷰 객체)로 설정하면 로드뷰에 올라갑니다.
    });
    rMarker.setAltitude(2); //마커의 높이를 설정합니다. (단위는 m입니다.)
    rMarker.setRange(50); //마커가 보일 수 있는 범위를 설정합니다. (단위는 m입니다.)

    // 로드뷰에 올릴 장소명 인포윈도우를 생성합니다.
    /* var rLabel = new daum.maps.InfoWindow({
        content: '내가 일하는 곳'
    });
    rLabel.setRange(50); //마커가 보일 수 있는 범위를 설정합니다. (단위는 m입니다.)
    rLabel.open(rv, rMarker); // open시 마커를 넣어주면, 마커의 altitude와 position값을 모두 따라 갑니다.
 */
    // 로드뷰 마커가 중앙에 오도록 로드뷰의 viewpoint 조정합니다.
    var projection = rv.getProjection(); // viewpoint(화면좌표)값을 추출할 수 있는 projection 객체를 가져옵니다.
    
    // 마커의 position과 altitude값을 통해 viewpoint값(화면좌표)를 추출합니다.
    var viewpoint = projection.viewpointFromCoords(rMarker.getPosition(), rMarker.getAltitude());
    rv.setViewpoint(viewpoint); //로드뷰에 뷰포인트를 설정합니다.
});
</script>
</body>
</html>