<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식점 상세 페이지</title>

  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.min.css">
  <script src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

 
 
 <script type="text/javascript">
 $(document).ready(function(){
		//alert("${restSeq}");
	 getReviewList();
				
	});

 $(function () {
     
     $('#container').highcharts({
         chart: {
             plotBackgroundColor: null,
             plotBorderWidth: 0,
             plotShadow: false
         },
         title: {
             text: '',
             align: 'center',
             verticalAlign: 'middle',
             y: 40
         },
         tooltip: {
             pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
         },
         plotOptions: {
             pie: {
                 dataLabels: {
                     enabled: true,
                     distance: -50,
                     style: {
                         fontWeight: 'bold',
                         color: 'white',
                         textShadow: '0px 1px 2px black'
                     }
                 },
                 startAngle: -90,
                 endAngle: 90,
                 center: ['50%', '75%']
             }
         },
         series: [{
             type: 'pie',
             name: 'Browser share',
             innerSize: '50%',
             data: [
                 
                 <c:forEach var="map" items="${agelineChartList}" varStatus="status">
                       ['${map.ageline}대',parseInt(${map.percent})],
                  </c:forEach>
                 
                 {
                     name: 'Proprietary or Undetectable',
                     y: 0.2,
                     dataLabels: {
                         enabled: false
                     }
                 }
             ]
         }]
     });
 }); 


$(function () {
    
    /* var dataArr = new Array(); //자바스크립트에서 배열을 선언하는 것
    <c:forEach var="rcd" items="${list}">
       dataArr.push("${rcd.PERCENT}"); //배열속에 값을 넣어주는 것.
    </c:forEach> */
    
     $('#container2').highcharts({
         chart: {
             plotBackgroundColor: null,
             plotBorderWidth: null,
             plotShadow: false,
             type: 'pie'
         },
         title: {
             text: ''
         },
         tooltip: {
             pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
         },
         plotOptions: {
             pie: {
                 allowPointSelect: true,
                 cursor: 'pointer',
                 dataLabels: {
                     enabled: true,
                     format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                     style: {
                         color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                     }
                 }
             }
         },
         series: [{
             name: '성별 구성비율',
             colorByPoint: true,
             data: [/* {
                 name: '남자',
                 y: Number(dataArr[0]) //Number() 함수를 꼭 써야한다.
             }, {
                 name: '여자',
                 y: Number(dataArr[1]),
                 sliced: true,
                 selected: true
             } */
             
             <c:forEach var="map" items="${genderChartList}" varStatus="status" >
                <c:if test="${status.count < genderChartList.size()}">
                {
                     name: '${map.gender}',
                     y: Number(${map.percent})
                     <c:if test="${status.count == genderChartList.size() - 1}">
                     ,
                     sliced: true,
                     selected: true
                     </c:if>
                 }
                <c:if test="${status.count < genderChartList.size()-1}">
                   ,
                </c:if>               
                </c:if>
             </c:forEach>
             
             ]
         }]
     });
 });
 
 function getReviewList(){
	 
	 var form_data = {
			 	StartRno : $("#StartRno").val(),   // 키값 : 밸류값 
			 	EndRno  : $("#EndRno").val(),     // 키값 : 밸류값
			 	restSeq : "${restSeq}"
			}
	 
	 $.ajaxSettings.traditional = true;
	 $.ajax({ 
		 	
			url: "<%= request.getContextPath()%>/ReviewListAjax.eat",  
			method:"get",  	
			data: form_data, 
			dataType: "html",
			success: function(data) {
				
				$("#ReviewListAjax").html(data);
				}
		});//end of $.ajax()
		
	
 }
 </script>
</head>
<body>
	
	
<div class="container">
 <div>
 	 <span style="font-weight:bold; font-size:20px; ">${restvo.restname }</span>
 </div>
 
  <table class="table table-condensed">
      <tr>
        <th>주소</th>
        <th>${restvo.restaddr}</th>
      </tr>
      <tr>
        <th>전화번호</th>
        <td>${restvo.restphone}</td>
      </tr>
      <tr></tr>
  </table>
  

<!-- 음식점 지도 및 로드뷰 표시, 출발지 입력 -->
<div id="mapContainer" style="border:solid 1px gray;padding: 10px;">
	<div id="roadFinder">
		<form action="" name="roadFinderFrm">
			출발지를 입력하세요 : <input  type="text" name="startPoint" id="startPoint"/>
			<button type="button" onclick="goNavigator();">Go!</button>
		</form>
	</div>
	<br/> 
	<div id="map" style="width:100%;height:300px"></div> <!-- 지도를 표시할 div 입니다 -->
	<div id="roadview" style="width:100%;height:300px"></div> <!-- 로드뷰를 표시할 div 입니다 -->
</div>

 <div id="container" style="width: 210px; height: 300px;  "></div>
 <div id="container2" style="width: 210px; height: 300px;  "></div>

	<%-- <h2>${restvo.restname}의 리뷰(${reviewList.size() })</h2> --%>
	
	<div id="ReviewListAjax"></div>
	
	<input type = "hidden" id = "StartRno" value = "1" />
	<input type = "hidden" id = "EndRno" value = "5" />
	
	

</div>
<script>
function goNavigator(){
	var endPoint = $("#startPoint").val().trim();
	
	if(endPoint.length == 0){
		alert('어디서 오실거에요?');
		$("#startPoint").focus();
		return;
	}
	
	var url = "http://map.daum.net/?sName="+$('#startPoint').val()+"&eName=${restvo.restname}"; 
	//url  += "&eX=${restvo.restLatitude}&eY=${restvo.restLongitude}";
	
	var popup = window.open(url,"roadFinder",
    "left=500px, top=100px, width=1000px, height=1000px, menubar=no, status=no, scrollbars=yes ");
	
	
}


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapCenter = new daum.maps.LatLng('${restvo.restlatitude}' , '${restvo.restlongitude}'), // 지도의 중심 좌표
    mapOption = {
        center: mapCenter, // 지도의 중심 좌표
        level: 4 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new daum.maps.Map(mapContainer, mapOption);

var myPosition = new daum.maps.LatLng('${restvo.restlatitude}' , '${restvo.restlongitude}');

// 지도에 올릴 마커를 생성합니다.
var mMarker = new daum.maps.Marker({
    position: myPosition, // 지도의 중심좌표에 올립니다.
    map: map // 생성하면서 지도에 올립니다.
});

// 지도에 올릴 장소명 인포윈도우 입니다.
var mLabel = new daum.maps.InfoWindow({
    position: myPosition, // 지도의 중심좌표에 올립니다.
    content: '<span  style="text-decoration: none; color: navy; font-size: 12px; padding-left :15px;">${restvo.restname}</span>' // 인포윈도우 크기 조정이 어렵다. 우측 공백이 마구 생긴다.
});
mLabel.open(map, mMarker); // 지도에 올리면서, 두번째 인자로 들어간 마커 위에 올라가도록 설정합니다.

var rvContainer = document.getElementById('roadview'); // 로드뷰를 표시할 div

var rv = new daum.maps.Roadview(rvContainer); // 로드뷰 객체 생성
var rc = new daum.maps.RoadviewClient(); // 좌표를 통한 로드뷰의 panoid를 추출하기 위한 로드뷰 help객체 생성 
var rvPosition = new daum.maps.LatLng(${restvo.restlatitude} ,${restvo.restlongitude});

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

 <jsp:include page="../footer.jsp" />

<%--werwerwierjweirjwirj --%>