<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>QnA/신고하기</title>
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
				alert("입력가능한 글자수는200자 입니다");
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
		var qnaRegisterFrm = document.qnaRegisterFrm;
		qnaRegisterFrm.submit();
	}
	
</script>
</head>
<body>
<div class="container" style="width: 90%">
	<div class="row">
		<h2> <span class="title-label">MazzipMetro에 신고하기</span>  </h2>
		<form name="qnaRegisterFrm" action="<%=request.getContextPath() %>/myQnaRegister.eat" method="post" style="margin-bottom:50px;">
			<table class="table table-border">
				<tr>
					<th>신고종류</th>
					<td>
						 <select name="qnaQuiry" id="qnaQuiry" style="height:30px;">
							<option value="음식점신고">음식점신고</option>
							<option value="리뷰신고">리뷰신고</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>신고제목</th>
					<td>
						<input name="qnaSubject" type="text"/> <input type="hidden" name="userSeq" value="${userSeq}"/>
					</td>
				</tr>
				<tr> 
					<th>신고내용<br>(200자입력가능)</th>
					<td>
						<textarea class="form-control" rows="5" name="qnaComment" id="qnaComment" placeholder="신고하려는 음식점의 이름과 리뷰작성자의 이름을 꼭 입력해주세요!!"></textarea>
						<div id="qnaCommentLength"></div>
					</td>
				</tr>
			</table>
		</form>
		
		<div align="center" >
			<button class="btn btn-primary" type="button" onClick="javascript:goRegister();">신고 등록</button>
			<button class="btn btn-danger" type="button" onClick="javascript:self.close();">취소</button>
		</div>
	</div>
	
</div>
</body>
</html>