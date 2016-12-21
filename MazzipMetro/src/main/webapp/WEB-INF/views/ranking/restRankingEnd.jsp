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
		vertical-align: middle;
	}
	
	table.tblRankingView td {
		padding-top : 20px;
		padding-bottom : 20px;
		text-align: center;
		font-size: 10pt;
		vertical-align: middle;
	}
</style>

<table class = "tblRankingView">
	<tr>
		<th width = "10%" height = "30px;">순위</th>
		<th width = "50%" height = "30px;">음식점명</th>
		<th width = "18%" height = "30px;">업종</th>
		<th width = "12%" height = "30px;">역명</th>
		<th width = "10%" height = "30px;">지역명</th>
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
		<c:forEach var = "list" items = "${mapList}">
			<tr style = "border-left-width: 0px; border-right-width: 0px;">
				<td width = "10%" ><span style = "font-size: 15pt; font-weight: bold;">${list.rank}</span></td>
				<td width = "15%" style = "border-left-width: 0px;"><img src="<%= request.getContextPath() %>/files/restaurant/thumb/thumb${list.restImg}" /></td>
				<td width = "35%" style = "border-left-width: 0px; text-align: left; font-size : 12pt; font-weight: bold;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">
						<span style = "color : black;">${list.restName}</span>
					</a>
				</td>
				<td width = "18%" style = "border-left-width: 0px; font-size : 12pt;">${list.restBgTag}</td>
				<td width = "12%" style = "border-left-width: 0px;">${list.metroName}</td>
				<td width = "10%" style = "border-left-width: 0px;">${list.dongName}</td>
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
