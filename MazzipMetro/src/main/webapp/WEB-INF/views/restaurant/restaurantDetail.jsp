<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />
<style>
	.contArea{display:inline; float:left; width:38%; margin:10px 0 10px 105px;}
	.contArea .restList ul li{display:inline-block; float:left; border-bottom:1px solid #e7e7e7; padding:20px 0; width:100%; }
	.contArea .restList ul li h2{display:block; font-family:굴림, Gulim; font-size:20px; padding:0 0 10px 0;}
	.contArea .restList ul li h2 a:hover{text-decoration:underline;}
	.contArea .restList ul li h2 img{vertical-align:middle; padding-right:5px;}
	.contArea .restList ul li h2 .part{font-weight:normal; font-size:12px; margin:0 0 0 5px;}
	
	.contArea .restList ul li .photoDiv{float:left; width:55px;}
	.contArea .restList ul li .textDiv{float:right; width:285px;}
	.contArea .restList ul li .textDiv dl dd.summary{background:url('/image/common/img_dot.gif') repeat-x left bottom; padding:30px 0; line-height:1.5em;}
	.contArea .restList ul li .textDiv dl dd.summary a:hover{text-decoration:underline;}
</style>

 <script type="text/javascript">
 $(document).ready(function(){
		//alert("${restSeq}");
	 <c:if test="${not empty restImageList}">
			var adImg =  "${restImageList.get(0)}"; 
			goLargeImgView(adImg);
			
			$(".my_thumbnail").hover(
					function(){
						$(this).addClass("myborder");
					},
					function(){
						$(this).removeClass("myborder");
					}
			);
	</c:if>
		
		getReviewList();
	 

	
	});
 
 (function($){ 

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
                       ['${map.ageLine}대',parseInt(${map.percent})],
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
 }); // end of $(function () {}
 
 })(jQuery);
 
(function($){ 


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
                     y: Number('${map.percent}')
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
 }); // end of $(function () {}
 
})(jQuery)
 
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
 
 
function goLargeImgView(adImg) {
	$.ajax({ 
		url : "getLargeAdImgFilename.eat", 	
		method : "GET",
		data : "adImg=" + adImg,  
				/*
				   전송방식이 get 이든 post 이든 
				   getLargeImgFilename.action?seqfileno=11 처럼 보내게 된다.
				   !! 그리고 중요한 것은 !!!
				   ajax 를 이용한 전송방식에는 
				   url페이지명과  data가 구분되어져 있으므로
				   구분자인 ? 가 필요없다는 것이다.
				   GET 방식에서 ? 의 기능은
				   WAS(톰캣서버)가 어디까지가 응용프로그램 주소이고,
				   어디부터가 데이터인지 구분하기 위한 구분자로 사용되는 것이다.
				   그러므로 ajax 에서는 키1=값1&키2=값2&키3=값3 으로 반복된다.
			   */
		dataType : "JSON",  // 응답은 JSON 타입으로 받아라.
		success: function(data) { // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				// data 는 ajax 요청에 의해 url 페이지 getLargeImgFilename.action 으로 부터 리턴받은 데이터
		   			   
		   $("#largeImg").empty();
		   // <div id="largeImg"> 엘리먼트를 모두 비워서 새로운 데이터를 받을수 있게 해라
		   
		   var html = "";
		   
		   $.each(data, function(key, val){
				html += "<img src='<%=request.getContextPath() %>/resources/images/"+val+"' "+"width='460' height='345' />";    
		   });
				
	   	   /*
	   	    	$.each() 함수는 $(selector).each()와는 다르다.
	   	    	$.each(순회해야할 1개의 객체 또는 배열, function(indexInArray, valueOfElement){ } );
	   	    	배열을 다루는 경우, 콜백함수는 배열의 인덱스와 값을 인자로 갖는다
	   	   */
	   	   $("#largeImg").html(html);   // html을  largeImg 넣어주어라
		
		}, // end of success: function(data) ---------------------
		
		error: function(request, status, error){
	        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    } // end of error: function(request,status,error)
		
	}); // end of $.ajax --------------------
}
 </script>


<div id="restDiv" style="margin: 30px; padding: 10px;">	
	<!-- 음식점 이름 -->
	 <div style="padding: 30px; width: 100%;">
	 	<div style="float: left;">
		 	 <span style="font-weight:bold; font-size:30px; ">${restvo.restname }</span>
	 	</div>
	 	 <div style="float: right;">
		 	 <span style="font-weight:italic; font-size:13px;">방문자수  <span style="color : orange;">${restvo.restVisitor }</span></span>	 	 
	 	 </div>
	 </div>
	 

	 <!-- 음식점 메인 이미지 -->
	 <div id="restMainImge" style="width: 50%; clear:both; float: left; margin-top: 50px; margin-bottom: 30px;" align="center">
	 
	 <div id="largeImg" style="float: left;  border: green solid 0px; width: 100%;">
	 	<c:if test="${empty restImageList}">
	 		<img src='<%=request.getContextPath() %>/resources/images/no_image.jpg' width='460' height='345' />
	 	</c:if>
	</div>  
		
	<div  style="border: red solid 0px; clear:both; float:left; width: 100%;  padding: 20px;">
			<c:forEach var="img" items="${restImageList}" varStatus="status">
				<img src="<%= request.getContextPath() %>/resources/images/${img}" width="70px" height="70px" class="my_thumbnail" style="margin-right: 10px;" onmouseover="goLargeImgView('${img}')" />
			</c:forEach>
	</div>
	 
	 </div>
	 
	 <!-- 음식점 info -->
	 <div id="restInfo" style="width: 50%; float: left;">
	 <div style="float:right;">
	 	<button type="button"  onclick="addWantToGo(${restvo.restseq});" class="btnLogin">가고싶다</button>
	 </div>
	 
	  <table class="table table-condensed" style="margin-top: 50px; width:80%; ">
	      
	      <tr>
	      	<th>업체명</th>
	      	<td>${restvo.restname }</td>
	      </tr>
	      <tr>
	      	<th>대분류/중분류</th>
	      	<td>${restvo.restbgtag} / ${restvo.restmdtag} </td>
	      </tr>
	      <tr>
	        <th>전화번호</th>
	        <td>${restvo.restphone}</td>
	      </tr>
	      <tr>
	        <th>주소</th>
	        <td>${restvo.restaddr}</td>
	      </tr>
	      
	      <tr>
	      	<th>분위기 평점</th>
	      	<td>
	      	
	      	<div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				<p style="WIDTH: ${reviewAvgScore.avgReviewMood * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				</p>
			</div>	
			 &nbsp; ${reviewAvgScore.avgReviewMood }점</td>
	      </tr>	
	      
	      <tr>
	        <th>맛 평점</th>
	        
	       <td>
	        <div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				<p style="WIDTH: ${reviewAvgScore.avgReviewTaste * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				</p>
			</div>	
			
	      	&nbsp;
	      	${reviewAvgScore.avgReviewTaste }점</td>
	      </tr>
	    
	      <tr>
	      	<th>가격평점</th>
	      	<td>
	      	 <div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				<p style="WIDTH: ${reviewAvgScore.avgReviewPrice * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				</p>
			</div>	
			
	      	&nbsp;
	      	${reviewAvgScore.avgReviewPrice }점</td>
	      </tr>
	      	
	     <tr>
	      	<th>서비스 평점</th>
	      	<td>
	      	 <div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				<p style="WIDTH: ${reviewAvgScore.avgReviewService * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				</p>
			</div>	
			
	      	&nbsp;
	      	${reviewAvgScore.avgReviewService }점</td>
	     </tr>
	      
	        <tr>
	      	<th>총 평점</th>
	      	<td>
	      	 <div style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) 0px 0px;	FLOAT: left;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				<p style="WIDTH: ${reviewAvgScore.avgReviewAvgScore * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 0px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
				</p>
			</div>	
			
	      	&nbsp;
	      	${reviewAvgScore.avgReviewAvgScore }점  | ${reviewAvgScore.personCount}명 참여</td>
	     </tr>
	      
	      <tr>
	      	<th>테마</th>
	      	<td>
	      		<c:forEach var="theme" items="${restThemeList}" varStatus="status">
	      			
	      			<c:if test="${status.count <  restThemeList.size() }">
	      				<a href="<%=request.getContextPath()%>/theme.eat?theme=${theme}">${theme} </a>,
	      			</c:if>
	      			
	      			<c:if test="${status.count ==  restThemeList.size() }">
	      				<a href="<%=request.getContextPath()%>/theme.eat?theme=${theme}">${theme}</a>
	      			</c:if>
	      			
	      		</c:forEach>
	      	</td>
	      </tr>
	      
	  </table>
	  </div>
</div>
<br/> <br/> 
<!-- 음식점 메뉴 목록 -->
<c:if test="${menuList != null && not empty menuList}">
<c:forEach var = "list" items = "${menuList}">
<div class = "contArea">
	<div class = "restList">
		<ul>
			<li>
				<h2><span style = "font-size: 18pt;">${list.menuName}</span>&nbsp;&nbsp;&nbsp;<span style = "font-size: 10pt;">${list.menuSort} <c:if test = "${list.menuEvent != null && not empty list.menuEvent}"> / ${list.menuEvent}</c:if></span></h2>
				<div class="photoDiv">
					<div><img width="200px;" src="<%= request.getContextPath() %>/files/menu/${list.menuImg}" /></div>
				</div>
				<div class="textDiv">
					<dl><c:if test="${list.menuSalePrice == 0}" >
							<dd class="add">메뉴가격 : ${list.menuPrice}원</dd>
							<dd class="add"></dd>
						</c:if>
						<c:if test="${list.menuSalePrice != 0}" >
							<dd class="add"><span style = "text-decoration: line-through; ">메뉴가격 : ${list.menuPrice}원</span></dd>
							<dd class="add">세일가격 : <span style = "color : red; font-weight: bold;">${list.menuSalePrice}원</span></dd>
						</c:if>
						<dd class="summary"><span style = "font-size : 12pt;">${list.menuContent}</span></dd>
					</dl>
				</div>
			</li>
		</ul>
	</div>
</div>
</c:forEach>
</c:if>
<!-- 음식점 지도 및 로드뷰 표시, 출발지 입력 -->
<div id="mapContainer" style="border:solid 1px gray;padding: 10px; clear: both; width: 85%;margin: auto;" >
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
<br/> <br/> 

<!-- 차트 div입니다. -->
<div style="width: 85%;">
	<h2 style="margin-left: 220px;">나이별 통계 <span style="margin-left: 432px;">성별 통계</span></h2>
	<div id="container" style="width: 50%; height: 300px; float: left"></div>
	<div id="container2" style="width: 50%; height: 300px; left: 100px;float: left "></div>
</div>
	<%-- <h2>${restvo.restname}의 리뷰(${reviewList.size() })</h2> --%>
	
	
	<div id="ReviewListAjax" style="clear:both;padding-top: 50px; width: 1290px; padding-left: 100px;"></div>
	
	<input type = "hidden" id = "StartRno" value = "1" />
	<input type = "hidden" id = "EndRno" value = "5" />
	

<script>
function goNavigator(){
	var startPoint = $("#startPoint").val().trim();
	//alert(startPoint);
	
	if(startPoint.length == 0){
		alert('어디서 오실거에요?');
		$("#startPoint").focus();
		return;
	}
	
	var url = "http://map.daum.net/?sName="+startPoint+"&eName=${restvo.restname}"; 
	//url  += "&eX=${restvo.restLatitude}&eY=${restvo.restLongitude}";
	
	//alert(url);
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
map.setZoomable(false);
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

 <jsp:include page="../footer.jsp" />