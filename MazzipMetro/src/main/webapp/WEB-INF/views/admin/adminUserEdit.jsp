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
input[type=text] {width:130px;}
.title {width:250px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; padding-left:20px; font-size:15px;}
.coinPopWrap {padding:30px 0 0 20px; font-size:11px;}
.btnCoin {width: 68px;
    height: 25px;
    margin-left:10px;
    margin-top:15px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
 .tblAduser td {height:25px;}   
    
</style>
<script type="text/javascript">
goUserEdit(userSeq){
	var userEditFrm = document.userEditFrm;
	
	$("[name=userSeq]").prop('disabled', false);
	$("[name=userName]").prop('disabled', false);
	$("[name=gradeName]").prop('disabled', false);
	
	userEditFrm.submit();
}
</script>
</head>
<body>
	<h2 class="title">회원 정보 수정 하기</h2>
	<form name="userEditFrm" action="<%= request.getContextPath() %>/adminUserEditEnd.eat" method="post">
	<div class="coinPopWrap">
		<table class="tblAduser">
			<tr>
				<td><b>번호</b> :</td><td> ${userinfoMap.USERSEQ}</td>
			</tr>
			<tr>	
				<td><b>성명</b> :</td><td>${userinfoMap.USERNAME}</td>
			</tr>
			<tr>
				<td><b>등급번호</b> :</td><td>${userinfoMap.GRADENAME}</td>
			</tr>
			<tr>
				<td><b>이메일 </b>:</td><td><input type="text" name="userEmail" value="${userinfoMap.USEREMAIL}" /></td>
			</tr>
			<tr>
				<td><b>전화번호</b> :</td><td><input type="text" name="userPhone" value="${userinfoMap.USERPHONE}" /></td>
			</tr>
			<tr>	
				<td><b>포인트</b> :</td><td><input type="text" name="userPoint" value="${userinfoMap.USERPOINT}" /></td>
			</tr>
			<tr>	
				<td colspan="2" align="center">
					<button class="btnCoin" onClick="goUserEdit('${userinfoMap.USERSEQ}');">수정</button>
					<input type="hidden" name="userSeq" value="${userinfoMap.USERSEQ}" />
				</td>
			</tr>
	</table>
	</div>
	</form>
</body>
</html>