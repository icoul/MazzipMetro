<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	// **** 컨텍스트명 알아오기 ****
	String ctxName = request.getContextPath();
    //  /MyWeb 이 리턴된다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script>

<link rel="stylesheet" type="text/css" href="<%=ctxName%>/resources/css/style.css" />
<title>:::HOMEPAGE:::</title>

<script type="text/javascript">
	function goMemberList() {
		<c:if test="${sessionScope.loginuser == null}">
			alert("먼저 로그인 하셔야 합니다.");
		</c:if>
		<c:if test="${sessionScope.loginuser != null}">
		    location.href = "<%=ctxName%>/memberList.do"; 
		</c:if>
	}
</script>

</head>
<body>
<div id="container">
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
				<a href="<%=ctxName%>/memberList.do">회원목록1</a>&nbsp;|&nbsp;
			</c:if>
			
			<a href="javascript:goMemberList();">회원목록2</a>&nbsp;|&nbsp;
		
			<a href="<%=ctxName%>/memberList.do">회원목록3</a>&nbsp;|&nbsp;
		
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/memo.do">한줄메모쓰기</a>&nbsp;|&nbsp;
				<a href="<%=ctxName%>/memoList.do">한줄메모조회</a>&nbsp;|&nbsp;
			</c:if>
				
			<a href="<%=ctxName%>/mall.do">쇼핑몰</a>&nbsp;|&nbsp;
			
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/cartList.do">장바구니</a>&nbsp;|&nbsp;
			</c:if>
			
			<c:if test="${sessionScope.loginuser != null}">
				<a href="<%=ctxName%>/orderList.do">주문내역</a>&nbsp;|&nbsp;
			</c:if>
			
			<c:if test='${sessionScope.loginuser != null && (sessionScope.loginuser).userid eq "admin"}'>
				<a href="<%=ctxName%>/admin/prodInput.do">상품등록[ADMIN]</a>&nbsp;|&nbsp;
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
	</div>
	<div id="content" align="center">
		<table width="100%" border="0">
		<tr height="400px">
		<td align="center" valign="middle">