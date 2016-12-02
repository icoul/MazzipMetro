<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>image Map 테스트</title>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />
<style>
.tooltip_templates { display: none; }
</style>
<script>
        $(document).ready(function() {
        	
            $('.tooltipster').tooltipster({
            	animation: 'grow',
           	   	delay: 200,
           	   	theme: 'tooltipster-noir',
           	   	trigger: 'hover'
            });
        });

</script>

</head>
<body>
<img alt="" src="<%=request.getContextPath() %>/resources/images/metroMap.jpg"  usemap="#mazzipMetroImgMap">
<map id="mazzipMetroImgMap" name="mazzipMetroImgMap">
	<area shape="circle" alt="잠실역" title="잠실역 맛집" coords="521,388,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2005" target="" />
	<area shape="circle" alt="잠실나루역" title="" coords="561,386,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2006" target="" />
	<area shape="circle" alt="강변역" title="" coords="598,374,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2007" target="" />
	<area shape="circle" alt="구의역" title="" coords="628,358,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2008" target="" />
	<area shape="circle" alt="건대입구역" title="" coords="659,333,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2009" target="" />
	<area shape="circle" alt="성수역" title="" coords="678,299,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2010" target="" />
	<area shape="circle" alt="뚝섬역" title="" coords="691,261,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2011" target="" />
	<area shape="circle" alt="한양대역" title="" coords="693,223,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2012" target="" />
	<area shape="circle" alt="왕십리역" title="" coords="681,185,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2043" target="" />
	<area shape="circle" alt="상왕십리역" title="" coords="662,150,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2014" target="" />
	<area shape="circle" alt="신당역" title="" coords="635,122,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2015" target="" />
	<area shape="circle" alt="동대문역사문화공원역" title="" coords="603,104,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2016" target="" />
	<area shape="circle" alt="을지로4가역" title="" coords="566,92,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2017" target="" />
	<area shape="circle" alt="을지로3가역" title="" coords="525,87,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2018" target="" />
	<area shape="circle" alt="을지로입구역" title="" coords="487,87,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2019" target="" />
	<area shape="circle" alt="시청역" title="" coords="445,87,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2020" target="" />
	<area shape="circle" alt="충정로역" title="" coords="402,86,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2021" target="" />
	<area shape="circle" alt="아현역" title="" coords="361,87,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2022" target="" />
	<area shape="circle" alt="이대역" title="" coords="321,87,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2023" target="" />
	<area shape="circle" alt="신촌역" title="" coords="282,85,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2024" target="" />
	<area shape="circle" alt="홍대역" title="" coords="240,87,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2025" target="" />
	<area shape="circle" alt="합정역" title="" coords="200,87,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2026" target="" />
	<area shape="circle" alt="당산역" title="" coords="163,91,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2027" target="" />
	<area shape="circle" alt="영등포구청역" title="" coords="126,99,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2028" target="" />
	<area shape="circle" alt="문래역" title="" coords="95,118,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2029" target="" />
	<area shape="circle" alt="신도림역" title="" coords="69,143,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2030" target="" />
	<area shape="circle" alt="대림역" title="" coords="48,172,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2031" target="" />
	<area shape="circle" alt="구로디지털단지역" title="" coords="36,207,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2032" target="" />
	<area shape="circle" alt="신대방역" title="" coords="34,239,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2033" target="" />
	<area shape="circle" alt="신림역" title="" coords="38,275,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2034" target="" />
	<area shape="circle" alt="봉천역" title="" coords="52,308,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2035" target="" />
	<area shape="circle" alt="서울대입구역" title="" coords="74,334,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2036" target="" />
	<area shape="circle" alt="낙성대역" title="" coords="102,358,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2037" target="" />
	<area shape="circle" alt="사당역" title="" coords="132,374,14" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2038" target="" />
	<area shape="circle" alt="방배역" title="" coords="169,384,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2039" target="" />
	<area shape="circle" alt="서초역" title="" coords="209,387,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2040" target="" />
	<area shape="circle" alt="교대역" title="" coords="245,387,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2041" target="" />
	<area shape="circle" alt="강남역" title="" coords="282,387,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2042" target="" />
	<area shape="circle" alt="역삼역" title="" coords="324,386,16" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2001" target="" />
	<area shape="circle" alt="선릉역" title="" coords="364,386,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2002" target="" />
	<area shape="circle" alt="삼성역" title="" coords="403,387,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2003" target="" />
	<area shape="circle" alt="종합운동장역" title="" coords="444,387,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2004" target="" />
	<area shape="circle" alt="신천역" title="" coords="484,386,15" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2061" target="" />
</map>
<br/> 

<img alt="" src="<%=request.getContextPath() %>/resources/images/imgMapTest.jpg" usemap="#imgmap2016121115856">
<map id="imgmap2016121115856" name="imgmap2016121115856">
	<area shape="circle" alt="이대역" title="" coords="664,171,32" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2023" target="_self" />
	<area shape="circle" alt="역삼역" title="" coords="668,788,31" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2001" target="_self" />
	<area shape="circle" alt="신당역" title="" coords="1303,245,30" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2015" target="_self" />
</map>

<br/> 
<img alt="" src="<%=request.getContextPath() %>/resources/images/imgMapTest.jpg"  width="1000px;" usemap="#imgmap2016121115855">
<map id="imgmap2016121115855" name="imgmap2016121115855">
	<area shape="circle" alt="이대역" title="" coords="664,171,32" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2023" target="_self" />
	<area shape="circle" alt="역삼역" title="" coords="668,788,31" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2001" target="_self" />
	<area shape="circle" alt="신당역" title="" coords="1303,245,30" href="<%=request.getContextPath()%>/restaurantInMetro.eat?metroId=2015" target="_self" />
</map>




</body>
</html>