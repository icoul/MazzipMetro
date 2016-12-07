<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script>

<style type="text/css">
* { padding:0; margin:0;}
.title {width:250px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; padding-left:20px; font-size:15px;}
input[type=radio] {vertical-align:-3px;}
.coinPopWrap {padding:30px 0 0 20px; font-size:11px;}
.coinPopWrap  li {list-style:none;}
.coinPopWrap  li.first {margin-bottom:10px;}

.btnCoin {width: 58px;
    height: 25px;
    margin-left:10px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
</style>
</head>
<body>
	<h2 class="title">회원 정보 수정 하기</h2>
	<form name="coinCharFrm" action="<%= request.getContextPath() %>/adminUserEditEnd.eat" method="post">
	<div class="coinPopWrap">
		<table class="tblUserList">
			<tr>
				<th style="width: 70px;" >번호</th>
				<th style="width: 80px;" >성명</th>
				<th style="width: 70px;" >등급번호</th>
				<th style="width: 70px;" >이메일</th>
				<th style="width: 70px;" >전화번호</th>
				<th style="width: 70px;" >가입일자</th>
				<th style="width: 70px;" >포인트</th>
				<th style="width: 70px;" >수정/삭제</th>
			</tr>
		
			<tr>
				<td><input type="text" name="userSeq" value="${userSeq}" /></td>
				<td><input type="text" name="userName" value="${userName}" /></td>
				<td><input type="text" name="gradeName" value="${gradeName}" /></td>
				<td><input type="text" name="userEmail" value="${userEmail}" /></td>
				<td><input type="text" name=userPhone value="${userPhone}" /></td>
				<td><input type="text" name="userRegDate" value="${userRegDate}" /></td>
				<td><input type="text" name="userPoint" value="${userPoint}" /></td>
			</tr>
	</table>
	</div>
	</form>
</body>
</html>