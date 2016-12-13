<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
				<td width = "15%" style = "border-left-width: 0px;"><img src="<%= request.getContextPath() %>/thumb${list.restImg}" /></td>
				<td width = "35%" style = "border-left-width: 0px; text-align: left; font-size : 12pt; font-weight: bold;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">
						<span style = "color : black;">${list.restName}</span>
					</a>
				</td>
				<td width = "20%" style = "border-left-width: 0px; font-size : 12pt;">${list.restBgTag}</td>
				<td width = "10%" style = "border-left-width: 0px;">${list.metroName}</td>
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
