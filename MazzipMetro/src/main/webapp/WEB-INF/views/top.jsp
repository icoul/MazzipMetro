<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
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
				<li><a href="#">지도찾기</a></li>	
				<li><a href="#">맛집랭킹</a></li>
				<li><a href="#">리뷰</a></li>
				<li><a href="#">마이페이지</a></li>
				<li><a href="#">문의하기</a></li>
			</ul>
			<button type="button" class="btnLogin">로그인</button>
		</div>
	</div>
	
	<div id="content">
	