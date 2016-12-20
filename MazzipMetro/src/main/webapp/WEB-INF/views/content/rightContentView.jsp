<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style>
	td {line-height: 15pt;}
</style>
<table style = "width : 100%;" >
<c:forEach var="list" items="${rvoList}">
		<tr>
			<td style = "width : 30%; padding : 5px; padding-left : 15px;">
				<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}"><img width = "80px;" src="<%= request.getContextPath() %>/files/restaurant/${list.restImg}" /></a>
			</td>
			<td style = "padding-top : 6px; line-height: 20pt;">
				<span style = "font-size: 15pt; font-weight: bold;">${list.restName}</span><br/>
				<span style = "font-size: 12pt;">${list.restBgTag}</span><br/>
				<span style = "font-size: 10pt;">${list.restMdTag}</span>
			</td>
		</tr>
		<tr style = "width : 100%;" >
			<td style = "border-bottom : solid lightgrey 2px;" colspan = "2"></td>
		</tr>
</c:forEach>
</table>