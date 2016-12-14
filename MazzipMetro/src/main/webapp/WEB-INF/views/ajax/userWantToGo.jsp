<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty list}]">
<br/><br/><span style="color: #818181; text-decoration: underline;">가고 싶은 음식점을 담아보세요.</span><br/><br/> 
</c:if>
<c:if test="${not empty list}]">
<table style="width: 450px;">
	<c:forEach var="restvo" items="${list}" varStatus="status">
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${restvo.restSeq}" >
					<span style='font-weight:bold; font-size:18px;'>${restvo.restName}</span>
					<span style="color:#0066ff; font-size:14px;">${restvo.restBgTag}</span>
					<span style="color:#3333ff; font-size:12px;">${restvo.restMdTag}</span>
					</a>
			</td>
			<td>
				<a href="javascript:check(${restvo.restSeq})">
					<img src="<%=request.getContextPath()%>/files/${restvo.restImg}" width="100px;">
				</a>
			</td>
		</tr>
	</c:forEach>
</table>

</c:if>