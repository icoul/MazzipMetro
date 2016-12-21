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
	<hr/> 
		<table style = "border : solid red 1px; width: 700px; ">
		<c:forEach var="list" items="${rvoList }">
			<tr >
				<td style="width : 100px; padding: 10px; height: 120px;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}" style="color:black; text-decoration: none;">
					<img src="<%=request.getContextPath()%>/files/restaurant/${list.restImg}" width="100px"/>
					</a>
				</td>
				<td style="vertical-align: middle; padding: 10px;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}" style="color:black; text-decoration: none;">
					<span style='font-weight:bold; font-size:18px;'>${list.restName}</span>
					<span style="color:#0066ff; font-size:14px;">${list.restBgTag}</span>
					<span style="color:#3333ff; font-size:12px;">${list.restMdTag}</span>
					</a>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>
