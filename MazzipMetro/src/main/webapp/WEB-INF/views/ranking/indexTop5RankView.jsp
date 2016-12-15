<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style>
	td {line-height: 15pt;}
</style>
<table>
	<tr>  
<c:forEach var="list" items="${mapList}" begin="0" end="4" >
			<td style = "padding : 5px;">
				<img width = "136px;" src="<%= request.getContextPath() %>/${list.restImg}" /><br/>
				<span style = "font-size: 10pt; font-weight: bold;">${list.restName}</span><br/>
				<span style = "font-size: 10pt;">${list.restBgTag}</span><br/>
				<span style = "font-size: 8pt;">${list.restMdTag}</span>
			</td>
</c:forEach>
	</tr>
</table>