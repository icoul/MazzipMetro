<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
		
		.table {
		     width: 100%;
		     height : 20px;
		     border: solid gray 1px;
		     border-collapse: collapse;
		     margin-top: 30px;
		     margin-bottom: 10px;
		     border-left-width: 0px;
		     border-right-width: 0px;
		}
		
		th#th {
			 background-color: silver;
			 font-size: 13pt;
		}
		
		.table tr {
			border: solid gray 1px;
			vertical-align : middle;
			border-left-width: 0px;
		    border-right-width: 0px;
		}
		
		.table td {
			padding-left : 20px;
			padding-top : 10px;
			padding-bottom : 10px;
			border: solid gray 1px;
			vertical-align : middle;
			border-left-width: 0px;
		    border-right-width: 0px;
		}
		
		.table td.couponBuy {
			padding-left : 20px;
			padding-top : 10px;
			padding-bottom : 10px;
			border: solid gray 1px;
			vertical-align : middle;
			border-left-width: 0px;
			border-right-width: 0px;
		}
		
</style>


<c:if test="${couponList == null || empty couponList}">
	<table class = "table">
		<tr style = "border-left-width: 0px; border-right-width: 0px; background-color: lightgrey;">
			<td class="couponBuy" colspan = "5" align="left" style = "font-size : 15pt;">쿠폰 리스트</td>
		</tr>
		<tr>
			<td width="80%" colspan="4" align="center">
				쿠폰이 존재하지 않습니다
			</td>
		</tr>
	</table>
</c:if>

<c:if test="${couponList != null && not empty couponList}">
	<table class = "table">
		<tr>
			<th width="20%" style = "text-align : center; font-size : 14pt;"><b>쿠폰번호</b></th>
			<th width="20%" style = "text-align : center; font-size : 14pt;"><b>발행 맛집명</b></th>
			<th width="20%" style = "text-align : center; font-size : 14pt;"><b>쿠폰 발행일</b></th>
			<th width="20%" style = "text-align : center; font-size : 14pt;"><b>유효기간</b></th>
			<th width="20%" style = "text-align : center; font-size : 14pt;"><b>쿠폰상태</b></th>
		</tr>
		<c:forEach var="list" items="${couponList}" begin="${pageNum*pageBar-pageBar}" end="${pageNum*pageBar-1}">
			<tr>
				<td width="20%" align="center">${list.couponSeq}</td>
				<td width="20%" align="center"><a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">${list.restName}</a></td>
				<td width="20%" align="center">${list.couponRegDate}</td>
				<td width="20%" align="center">${list.couponExpiryDate}</td>
				<td width="20%" align="center">
					<c:if test="${list.couponStatus == 1}" ><span style = "color : blue; font-weight: bold;">사용가능</span></c:if>
					<c:if test="${list.couponStatus == 2}" ><span style = "color : red; font-weight: bold;">사용완료</span></c:if>
					<c:if test="${list.couponStatus == 3}" ><span style = "color : red; font-weight: bold;">기한초과</span></c:if>
				</td>
			</tr>
		</c:forEach>
		<tr style = "border-bottom-width: 0px;">
			<td colspan = "5" align="center">${html}</td>
		</tr>
	</table>
</c:if>
