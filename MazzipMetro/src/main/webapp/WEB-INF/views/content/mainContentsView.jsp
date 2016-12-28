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
		<td><img src = "<%=request.getContextPath()%>/files/content/mainContent_${rvo.restSeq}.jpg"/></td>
	</tr>
</table>
