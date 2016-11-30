<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="str" items="${list}" varStatus="status">
	${str}
	<c:if test="${status.count < list.size() }">,</c:if>
</c:forEach>