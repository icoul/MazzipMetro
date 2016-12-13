<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	$(document).ready(function(){
	});
</script>

<c:if test="${mapList == null || empty mapList}">
	<table id = "tblRankingView">
		<tr style = "border-left-width: 0px; border-right-width: 0px;">
			<td><span style = "margin-top: 50px; font-size: 20pt; font-weight: bold; ">검색결과가 존재하지 않습니다</span></td>
		</tr>
	</table>
</c:if>

<c:if test="${mapList != null && not empty mapList}">
	<table id = "tblRankingView">
		<c:forEach var = "list" items = "${mapList}" begin="${pageNum*pageBar-10}" end="${pageNum*pageBar-1}">
			<tr style = "border-left-width: 0px; border-right-width: 0px;">
				<td width = "10%" ><span style = "font-size: 15pt; font-weight: bold;">${list.rank}</span></td>
				<td width = "20%" style = "border-left-width: 0px;"><img width = "70px" src="<%= request.getContextPath() %>/${list.userProfile}" /></td>
				<td width = "30%" class = "tooltip_group tooltipster_top" style = "border-left-width: 0px; font-size : 12pt; font-weight: bold;">${list.userEmail}</td>
				<td width = "20%" style = "border-left-width: 0px; font-size : 12pt;">${list.userName}</td>
				<td width = "10%" style = "border-left-width: 0px;">${list.gradeName}</td>
			</tr>
		</c:forEach>
	</table>
	<div align = "center">
		<table>
			<tr >
				<td style = "font-size : 15pt;">${html}</td>
			</tr>
		</table>	
	</div>
</c:if>
