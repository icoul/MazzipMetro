<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
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
input[type=text] {width:120px;}
.coinPopWrap {padding:30px 0 0 20px; font-size:11px;}
.coinPopWrap  li {list-style:none;}
.coinPopWrap  li.first {margin-bottom:10px;}

.btnCoin {width: 68px;
    height: 25px;
    margin-left:10px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
.tblUserList td {height:23px;}
</style>
<script type="text/javascript">
goUserEdit(userSeq){
	var userEditFrm = document.userEditFrm;
	
	userEditFrm.action="adminUserEditEnd.eat";
	userEditFrm.method="post";
	userEditFrm.submit();
}
</script>
</head>
<body>
	<h2 class="title">회원 정보 수정 하기</h2>
	<form name="editEditFrm" action="<%= request.getContextPath() %>/adminUserEditEnd.eat" method="post">
	<div class="coinPopWrap">
		<table class="tblUserList">
			<tr>
				<td>아이디 :</td>
				<td>
					${userinfoMap.USEREMAIL}
					<input type="hidden" name="userSeq" value="${userinfoMap.USERSEQ}" />
				</td>
			</tr>
			<c:if test="${userinfoMap.GRADENAME !=null && not empty userinfoMap.GRADENAME}">
				<tr>
					<td>등급 :</td><td>${userinfoMap.GRADENAME}</td>
				</tr>
			</c:if>
			<tr>
				<td>성명 :</td><td><input type="text" name="userName" value="${userinfoMap.USERNAME}" /></td>
			</tr>
			<tr>
				<td>전화번호 :</td><td><input type="text" name="userPhone" value="${userinfoMap.USERPHONE}" /></td>
			</tr>
			<tr>
				<td>포인트 :</td><td><input type="text" name="userPoint" value="${userinfoMap.USERPOINT}" /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" style="height:50px;">
					<form name="userEditFrm"  action="<%= request.getContextPath() %>/adminUserEditEnd.eat" method="post">
						<button class="btnCoin" onClick="goUserEdit('${userinfoMap.userSeq}');" style="margin-top:0;">수정</button>
					</form>
				</td>
			</tr>	
	</table>
	</div>
	</form>
</body>
</html>