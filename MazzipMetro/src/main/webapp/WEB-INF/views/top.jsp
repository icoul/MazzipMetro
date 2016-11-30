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
<<<<<<< HEAD
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
=======
	<div id="headerImg">
		1. 이미지/네비게이터
	</div>
	<div id="headerLink">
		<table width="100%" border="0">
		<tr align="right" valign="middle">
		<td>
			<a href="<%=ctxName%>/index.do">HOME</a>&nbsp;|&nbsp;
			<a href="<%=ctxName%>/memberRegister.do">회원가입</a>&nbsp;|&nbsp;
		
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/memberList.do">파이널프로젝트</a>&nbsp;|&nbsp;
			</c:if>
			
			<a href="javascript:goMemberList();">맛집메트로!</a>&nbsp;|&nbsp;
		
			<a href="<%=ctxName%>/memberList.do">다들 파이팅 입니다!</a>&nbsp;|&nbsp;
		
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/memo.do"></a>&nbsp;|&nbsp;
				<a href="<%=ctxName%>/memoList.do"></a>&nbsp;|&nbsp;
			</c:if>
				
			<a href="<%=ctxName%>/mall.do"></a>&nbsp;|&nbsp;
			
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/cartList.do"></a>&nbsp;|&nbsp;
			</c:if>
			
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/orderList.do"></a>&nbsp;|&nbsp;
			</c:if>
			
			<c:if test='${sessionScope.loginuser != null && (sessionScope.loginuser).userid eq "admin"}'>
				<a href="<%=ctxName%>/admin/prodInput.do"></a>&nbsp;|&nbsp;
			</c:if>	
		</td>
		</tr>
		</table>
	</div>
	<div id="headerLine"></div>
	<div id="sideinfo">
		<table width="100%" border="0">
		<tr height="50px">
		<td align="left" valign="middle">
			2. 로그인/Tree/View
			<br/><br/>
<%-- 			<%@ include file="/WEB-INF/login/login.jsp" %> --%>
		</td>
		</tr>
		
		<tr>
		<td>
<%-- 			<%@ include file="/WEB-INF/myshop/categoryList.jsp" %> --%>
		</td>	
		</tr>
		
		<tr height="350px">
		<td align="left" valign="middle" style="padding-left: 20px;">
			내용1<br/>
		</td>
		</tr>
		</table>
>>>>>>> c866be3402640d50fe4dc5d3445c043b32ab569c
	</div>
	
	<div id="content">

