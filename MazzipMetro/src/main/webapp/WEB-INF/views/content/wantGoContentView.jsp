<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<table style = "width: 100%;">
	<tr style = "height : 35px; background-color: #EFEFEF;">
		<td colspan = "2" style = " vertical-align: middle; padding-left : 15px;"><span style = "font-weight: bold;">이 맛집은 어떠신가요? 맛집메트로의 추천!</span></td>
	</tr>	
	<tr>
		<td style = "padding : 5px; padding-left : 15px; width : 25%;">
			<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${vo.restSeq}"><img width = "100px;" src="<%= request.getContextPath() %>/files/rest/${vo.restImg}" /></a>
		</td>
		<td style = "padding-top : 6px; line-height: 26pt;">
			<span style = "font-size: 25pt; font-weight: bold;">${vo.restName}</span><br/>
			<span style = "font-size: 15pt;">${vo.restBgTag}</span>&nbsp;&nbsp;<span style = "font-size: 10pt;">${vo.restMdTag}</span><br/>
			<span style = "font-size: 10pt;">${vo.restContent}</span>
		</td>
	</tr>
	<tr>
		<td style = "border-bottom : solid lightgrey 2px;" colspan = "2"></td>
	</tr>
</table>