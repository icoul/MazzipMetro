<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>image Map 테스트</title>
</head>
<body>
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