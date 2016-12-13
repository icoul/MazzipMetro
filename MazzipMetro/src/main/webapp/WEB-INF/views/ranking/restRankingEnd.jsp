<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<c:forEach var = "list" items = "${mapList}">
	업장명 : ${list.restname}<br/>
	업장명 : ${list.metroid}<br/>
	업장명 : ${list.dongid}<br/>
	업장명 : ${list.rank}<br/>
	업장명 : ${list.count}<br/>
</c:forEach>