<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>QnA/문의하기</title>
<style type="text/css">
	.title-label{font-weight:400;font-size:24px;}
	.navbar-barnd{vertical-align : middle;line-height:45px;}
	.btn-primary.create {margin-top:10px;}
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.min.css">
  <script src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#qnaComment").keyup(function(){
			var qnaCommentLength = $("#qnaComment").val().length;
			
			if(10 < qnaCommentLength){
				alert("입력가능한 글자수는 10자 입니다");
				$("#qnaComment").val("");
			}
			
			if(0 < qnaCommentLength && qnaCommentLength <= 10){
				$("#qnaCommentLength").text(qnaCommentLength + "자 입력");
			}else{
				$("#qnaCommentLength").text("");
			}
			
		});	
		
		
	});
	
	function goRegister(){
		var qnaRegisterFrm = document.qnaRegisterFrm;
		qnaRegisterFrm.submit();
	}
	
</script>
</head>
<body>
<div class="container">
	<div class="row">
		<h2> <span class="title-label">MazzipMetro에 문의하기</span>  </h2>
		<form name="qnaRegisterFrm" action="<%=request.getContextPath() %>/myQnaRegister.eat" method="post">
			<table class="table table-border">
				<tr>
					<th>문의종류</th>
					<td>
						 <select name="qnaQuiry" id="qnaQuiry">
							<option value="회원">회원관련문의</option>
							<option value="사업주">사업주관련문의</option>
							<option value="음식점">음식점문의</option>
							<option value="기타">기타문의</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>문의제목</th>
					<td>
						<input name="qnaSubject" type="text"/> <input type="hidden" name="userSeq" value="${userSeq}"/>
					</td>
				</tr>
				<tr> 
					<th>문의내용<br>(10자입력가능)</th>
					<td>
						<textarea class="form-control" rows="5" name="qnaComment" id="qnaComment"></textarea>
						<div id="qnaCommentLength"></div>
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<button class="btn btn-primary" type="button" onClick="javascript:goRegister();">문의하기 등록</button>
			<button class="btn btn-danger" type="button">입력취소</button>
		</div>
	</div>
	
</div>
</body>
</html>