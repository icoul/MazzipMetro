<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${metro != null}"> 
	<c:forEach var="list" items="${metro}" varStatus="status"> 
		<div style = "margin-top:4px; margin-bottom:4px;">
			<a href = "javascript:wordChoice('${list.metroName}')">
				${list.metroName}
			</a>
		</div>	
	</c:forEach>	
</c:if>