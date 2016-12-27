<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style>
	td {line-height: 15pt;}
</style>
<table style = "width : 100%; " >
		<tr>
			<th colspan = "2">오늘의 맛집</th>
		</tr>
		<tr style = "width : 100%;" >
			<td style = "border-bottom : solid black 2px;" colspan = "2"></td>
		</tr>
<c:forEach var="list" items="${rvoList}">
		<tr style = "border : solid 1px #f3f3f3;">
			<td style = "width : 30%; padding : 5px; padding-left : 15px; padding-top : 15px;">
				<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}"><img width = "80px;" src="<%= request.getContextPath() %>/files/rest/${list.restImg}" /></a>
			</td>
			<td style = "padding-top : 6px; line-height: 20pt;">
				<span style = "font-size: 15pt; font-weight: bold;">${list.restName}</span><br/>
				<span style = "font-size: 12pt;">${list.restBgTag}</span><br/>
				<span style = "font-size: 10pt;">${list.restMdTag}</span>
			</td>
		</tr>
		<tr style = "width : 90%;" >
			<td style = "border-bottom : solid lightgrey 2px;" colspan = "2"></td>
		</tr>
</c:forEach>
</table>