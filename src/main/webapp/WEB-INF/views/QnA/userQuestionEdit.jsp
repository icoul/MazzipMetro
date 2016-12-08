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
	$("#qnaInquiry").val("${qnaInquiry}");
	
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
	
function goEditEnd(){
	var editFrm = document.editFrm;
	editFrm.submit();
}
	

</script>
</head>
<body>

			
<div class="container" style="width: 630px; height: 530px;">
	<div class="row">
		<form name="editFrm" action="<%=request.getContextPath() %>/userQuestionEditEnd.eat" method="get">
		<table class="table table-border">
			<tr>
				<th>질문유형</th>
				<td> 
				<select name="qnaInquiry" id="qnaInquiry">
							<option value="회원">회원관련문의</option>
							<option value="사업주">사업주관련문의</option>
							<option value="음식점">음식점문의</option>
							<option value="기타">기타문의</option>
				</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="qnaSubject" id="qnaSubject" value="${qnaSubject }" /></td>
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
					<textarea class="form-control" rows="5" name="qnaComment" id="qnaComment"></textarea>
					<div id="qnaCommentLength"></div>
					
				</td>
			</tr>
			
		</table>
		
		<div align="center">
			<input type="hidden" name="qnaSeq" id="qnaSeq" value="${qnaSeq }" />
			<button type="button" class="btn btn-primary" onClick="javascript:goEditEnd();">수정</button>
			<button type="button" class="btn btn-danger"  onClick="javascript:history.back();">취소</button>
		</div>
		</form>
	</div>
	

	
</div>
</body>
</html>