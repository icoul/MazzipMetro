<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
ul.pagination {
    display: inline-block;
    padding: 0;
    margin: 0;
}

ul.pagination li {display: inline;}

ul.pagination li a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
}

ul.pagination li a.active {
    background-color: gray;
    color: white;
}

ul.pagination li a:hover:not(.active) {background-color: #ddd;}
</style>
<div>
<h4>업장 검색 결과</h4>
	<hr/> 
	<c:if test="${empty restList}">업장 검색 결과가 없습니다.</c:if>
	<c:if test="${not empty restList}">
		<table>
		<c:forEach var="restvo" items="${restList }">
			<tr >
				<td style="padding: 10px;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${restvo.restSeq}" style="color:black; text-decoration: none;">
					<img src="<%=request.getContextPath()%>/files/${restvo.restImg}" width="100px;"/>
					</a>
				</td>
				<td style="vertical-align: middle; padding: 10px;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${restvo.restSeq}" style="color:black; text-decoration: none;">
					<span style='font-weight:bold; font-size:18px;'>${restvo.restName}</span>
					<span style="color:#0066ff; font-size:14px;">${restvo.restBgTag}</span>
					<span style="color:#3333ff; font-size:12px;">${restvo.restMdTag}</span>
					</a>
				</td>
			</tr>
		</c:forEach>
		</table>
	</c:if>
</div>
<br/> 
<c:if test="${not empty pageBar }">
<div align="center">
	${pageBar}
</div>
</c:if>