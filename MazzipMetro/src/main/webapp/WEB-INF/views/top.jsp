<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css" />
<title>:::Mazzip Metro:::</title>

</head>
<body>
<div id="container">
	<div id="headWrap">
		<div class="header">
			<h1>Mazzip Metro</h1>
			<ul class="menu">
				<li><a href="#">지하철호선 별  맛집  </a></li>
				<li><a href="#">맛집 랭킹 </a></li>
				<li><a href="#">QNA</a></li>
			</ul>
			<button type="button" class="btnLogin">로그인</button>
		</div>
	</div>
	
	<div id="content">
	