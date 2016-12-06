<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />
<style>
.tooltip_templates { display: none; }
table, th, td {border: solid 1px navy;}
th, td{padding:5px;}

</style>
<script>
	$(document).ready(function() {
		$('.tooltipster').tooltipster({
			animation: 'grow',
			animationDuration: 200,
			distance : 3,
		   	delay: 300,
		   	side: 'left',
		   	interactive: true,
		   	theme: 'tooltipster-noir',
		   	trigger: 'hover'
		 });
		
		// bind on start events (triggered on mouseenter)
		$.tooltipster.on('start', function(event) {

		    if ($(event.instance.elementOrigin()).hasClass('tooltip_group')) {

		        var instances = $.tooltipster.instances('.tooltip_group'),
		            open = false,
		            duration;

		        $.each(instances, function (i, instance) {

		            if (instance !== event.instance) {

		                // if another instance is already open
		                if (instance.status().open){

		                    open = true;

		                    // get the current animationDuration
		                    duration = instance.option('animationDuration');

		                    // close the tooltip without animation
		                    instance.option('animationDuration', 0);
		                    instance.close();
		                    
		                    // restore the animationDuration to its normal value
		                    instance.option('animationDuration', duration);
		                }
		            }
		        });

		        // if another instance was open
		        if (open) {

		            duration = event.instance.option('animationDuration');

		            // open the tooltip without animation
		            event.instance.option('animationDuration', 0);
		            event.instance.open();
		            
		            // restore the animationDuration to its normal value
		            event.instance.option('animationDuration', duration);

		            // now that we have opened the tooltip, the hover trigger must be stopped
		            event.stop();
		        }
		    }
		});
	}); 	
</script>
</head>
<body>
<%-- masterUser 해당역사의 마스터 사용자(리뷰든, alias든)정보가 넘어온다. --%>
<c:if test="${empty places && empty tags && empty masterUser }">관련 정보가 없습니다.</c:if>

<c:if test="${not empty places || not empty tags || not empty masterUser }">
	<!-- 베스트 음식점 정보 -->
	<div style="position:relative; float: left;margin: 10px;" align="center">
		<h3 style="padding-bottom: 5px;"><span style="font-weight: bold;">${metroName}</span> 맛집 베스트5</h3> 
		<table>
		<c:forEach var="vo" items="${places}"  varStatus="status">
			<tr>
				<th style="color: lime">${status.count}</th>
				<c:if test="${status.count%2 != 0 }">
					<td style="background-color: lime;">
				</c:if>
				<c:if test="${status.count%2 == 0 }">
					<td style="background-color: #ccffcc;">
				</c:if>
				
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${vo.restSeq}" data-tooltip-content="#tooltip_content${status.index}" class='tooltipster tooltip_group' style="color:black; text-decoration: none;">
					<span style='font-weight:bold; font-size:18px;'>${vo.restName}</span>
					
					<%-- TagsVO의 변수명은 bgCat, mdCat이다. 헷갈림 주의  --%>
					<c:forEach var="bgTag" items="${tags[status.index].bgCat}" varStatus="vs">
						<span style="color:#0066ff; font-size:14px;">${bgTag}</span>
						<c:if test="${vs.count < tags[status.index].bgCat.size()}">, </c:if>
					</c:forEach>
					<%-- ${tags[status.index].mdCat} List의 size()를 알아내서 , 를 찍는다.--%>
					<c:forEach var="mdTag" items="${tags[status.index].mdCat}" varStatus="vs">
						<span style="color:#3333ff; font-size:12px;">${mdTag}</span>	
						
						<c:if test="${vs.count < tags[status.index].mdCat.size()}">, </c:if>
					</c:forEach>
					</a>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	
	<!-- 베스트 유저 정보 -->
	<div style="position:relative; float: left; margin-left: 20px; margin: 10px;" align="center" >
	<h3 style="padding-bottom: 5px;"><span style="font-weight: bold;">${metroName}</span> 마스터즈 5</h3>  
	<table>
		<c:forEach var="vo" items="${places}"  varStatus="status">
			<tr>
				<th style="color: lime">${status.count}</th>
				<c:if test="${status.count%2 == 0 }">
					<td style="background-color: lime;">
				</c:if>
				<c:if test="${status.count%2 != 0 }">
					<td style="background-color: #ccffcc;">
				</c:if>
					개똥이 ${status.count}
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	
	<div class="tooltip_templates">
	<c:forEach var="vo" items="${places}"  varStatus="status">
	    <div id="tooltip_content${status.index}">
	    	<div id="div_tooltipImg">
	        	<img src="<%=request.getContextPath()%>/files/${vo.restImg}" width="500px;"/>
	        </div>
	        <div style="padding: 5px; width: 500px;">
	        	<strong>${vo.restContent}</strong>
	        </div>
	        <br/> 
	        <c:if test="${not empty adImgList[status.index]}">
		        <c:forEach var="adImg" items="${adImgList[status.index].adImg}" varStatus="num">
		        	<img src="<%=request.getContextPath()%>/files/thumb${adImg}" name="thumbImg" />&nbsp;
		        </c:forEach>
	        </c:if>
	    </div>
	</c:forEach>
	</div>
	
</c:if>
</body>

</body>
</html>
