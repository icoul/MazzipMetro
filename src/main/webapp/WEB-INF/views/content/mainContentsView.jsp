<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	
	table#mainContent{cursor: pointer;}
	
	table td.content{
			 padding-right : 15px;
			 padding-left : 15px;
			 padding-bottom : 15px;
			 }
			 
	
</style>

<table id = "mainContent">
	<tr>
		<td><a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${rvo.restSeq}"><img src = "<%=request.getContextPath()%>/files/content/mainContent_${rvo.restSeq}.jpg"/></a></td>
	</tr>
</table>
