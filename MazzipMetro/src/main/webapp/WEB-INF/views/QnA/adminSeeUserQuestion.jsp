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
			
			if(200 < qnaCommentLength){
				alert("입력가능한 글자수는 200자 입니다");
				$("#qnaComment").val("");
			}
			
			if(0 < qnaCommentLength && qnaCommentLength <= 200){
				$("#qnaCommentLength").text(qnaCommentLength + "자 입력");
			}else{
				$("#qnaCommentLength").text("");
			}
			
		});	
		
	});
	
	function goRegister(){
		
		var qnaSubject = $("#qnaSubject").val();
		var qnaComment = $("#qnaComment").val();
		
		if(qnaSubject.trim().length == 0){
			alert("제목을 입력해주세요");
			return;
		}
		
		if(qnaComment.trim().length == 0){
			alert("내용을 입력해주세요");
			return;
		}
		
		var qnaRegisterFrm = document.qnaRegisterFrm;
		qnaRegisterFrm.submit();
	}
	
</script>
</head>
<body>

			
<div class="container" style="width: 630px; height: 530px;">
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>질문유형</th>
				<td>${qnaInquiry} 문의</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${qnaSubject}</td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td>${qnaRegDate}</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${userName}</td>
			</tr>
			<tr>
				<th>처리상태</th>
				<td> <span  style="color:red">${qnaProgress }</span></td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="height:150px;">
						${qnaContent}
					</div>
					
				</td>
			</tr>
		</table>
	</div>
	
	<c:if test="${qnaProgress eq '접수완료'}">
	<div class="row">
		<h2> <span class="title-label">답변하기</span>  </h2>
		<form name="qnaRegisterFrm" action="<%=request.getContextPath() %>/adminAnswerRegister.eat" method="post">
			<table class="table table-border">
				
				<tr>
					<th>답변제목</th>
					<td>
						<input name="qnaSubject" id="qnaSubject" type="text"/> <input type="text" name="qnaSeq" value="${qnaSeq}"/>
					</td>
				</tr>
				<tr> 
					<th>답변내용<br>(200자입력가능)</th>
					<td>
						<textarea class="form-control" rows="5" name="qnaComment" id="qnaComment"></textarea>
						<div id="qnaCommentLength"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</c:if>
	<div align="center">
		<c:if test="${qnaProgress eq '접수완료'}">
			<button class="btn btn-primary" type="button" onClick="javascript:goRegister();">답변하기</button>
		</c:if>
		<button class="btn btn-danger" type="button" onClick="javascript:self.close();">닫기</button>
	</div>
	
</div>
</body>
</html>