<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table.tblRankingView {
	     width: 100%;
	     height : 20px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	table.tblRankingView th {
		 background-color: silver;
		 border: solid gray 1px;
		 font-size: 13pt;
		 text-align: center;
		 vertical-align: middle;
	}
	
	table.tblRankingView tr {
		border: solid gray 1px;

	}
	
	table.tblRankingView td {
		padding-top : 20px;
		padding-bottom : 20px;
		text-align: center;
		font-size: 10pt;
		vertical-align: middle;
	}
</style>

<script>
	$(document).ready(function(){
		
	});
</script>

<table class = "tblRankingView">
	<tr>
		<th width = "10%" height = "30px;">순위</th>
		<th width = "20%" height = "30px;">유저이미지</th>
		<th width = "30%" height = "30px;">유저아이디</th>
		<th width = "20%" height = "30px;">유저명</th>
		<th width = "10%" height = "30px;">유저등급</th>
	</tr>
</table>

<c:if test="${mapList == null || empty mapList}">
	<table class = "tblRankingView">
		<tr style = "border-left-width: 0px; border-right-width: 0px;">
			<td><span style = "margin-top: 50px; font-size: 20pt; font-weight: bold; ">검색결과가 존재하지 않습니다</span></td>
		</tr>
	</table>
</c:if>

<c:if test="${mapList != null && not empty mapList}">
	<table class = "tblRankingView">
		<c:forEach var = "list" items = "${mapList}" begin="${pageNum*pageBar-10}" end="${pageNum*pageBar-1}">
			<tr style = "border-left-width: 0px; border-right-width: 0px;">
				<td width = "10%" ><span style = "font-size: 15pt; font-weight: bold;">${list.rank}</span></td>
				<td width = "20%" style = "border-left-width: 0px;"><img width = "70px" src="<%= request.getContextPath() %>/files/user/${list.userProfile}" /></td>
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
