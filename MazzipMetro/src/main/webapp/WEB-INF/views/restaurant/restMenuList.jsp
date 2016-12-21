<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<div align="center">
	<c:if test="${menuList != null && not empty menuList}">
	<c:forEach var="list" items = "${menuList}" >
		<table class = "tblRestList">
			<div style ="margin-top : 20px; background-color : #0E6DAC; border-radius: 6px;" align ="left">
				<div>
				<table class = 'table'>
				<tr>
					<td width='10%' style = 'font-size : 11pt;'><b>메뉴명</b></td>
					<td width='25%' align='left'>${list.menuName}</td>
					<td width='10%' style = 'font-size : 11pt;'><b>한 줄 설명</b></td>
					<td width='45%' align='left' colspan = '3'>${list.menuContent}</td>
				</tr>
				<tr>
					<td width='10%' style = 'font-size : 11pt;'><b>메뉴이미지</b></td>
					<td><img src = "<%=request.getContextPath() %>/files/thumb${list.menuImg}" /></td>
					<td width='10%' style = 'font-size : 11pt;'><b>메뉴가격</b></td>
					<td width='15%' align='left'>${list.menuPrice}</td>
					<td width='10%' style = 'font-size : 11pt;'><b>세일가격</b></td>
					<td width='15%' align='left'>${list.menuSalePrice}</td>
				</tr>
				<tr>
					<td width='10%' style = 'font-size : 11pt;'><b>메뉴분류</b></td>
					<td width='25%' align='left'>${list.menuSort}</td>
					<td width='10%' style = 'font-size : 11pt;'><b>메뉴이벤트</b></td>
					<td width='45%' align='left' colspan = '3' style = 'font-size : 11pt;'>${list.menuEvent}</td>
				</tr>
				</table>
				</div>
			</div>
		</table>
	</c:forEach>
	</c:if>
	<c:if test="${menuList == null || empty menuList}">
		등록된 메뉴가 존재하지 않습니다
	</c:if>
	<br/>
</div>