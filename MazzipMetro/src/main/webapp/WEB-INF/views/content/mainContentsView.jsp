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
<script type = "text/javascript">
	$(document).ready(function(){
		$("#mainContent").click(function(){
			location.href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${rvo.restSeq}";
		});
	});
</script>

<table id = "mainContent">
	<tr>
		<td width = "50px;" rowspan="3"><img src = "<%=request.getContextPath()%>/files/restaurant/${rvo.restImg}" width="200px" /></td>
		<td width = "10px;" rowspan="3" style = "border-right:solid lightgrey 3px;"></td>
		<td class = "content" width = "400px;" style = "height : 50px; padding-top : 10px; "><span style = "font-size: 35pt; font-weight: bold; font-family: 맑은고딕">${rvo.restName}</span>&nbsp;${rvo.restBgTag}</td>
	</tr>
	<tr>
		<td class = "content">${rvo.restContent}</td>
	</tr>
	<c:if test="${adImage != null && not empty adImage}">
		<tr align = "right">
			<c:forEach var="list" items="${adImage}">
				<td class = "content" ><img src = "<%=request.getContextPath()%>/${list}" width="50px" /></td>
			</c:forEach>
		</tr>
	</c:if>
</table>

