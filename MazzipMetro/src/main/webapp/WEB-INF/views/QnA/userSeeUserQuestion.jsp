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
		
		
		
	});
	
	
</script>
</head>
<body>

			
<div class="container" style="width: 630px; height: 530px;">
	<div class="row">
		<table class="table table-border">
			<tr>
				<th>질문유형</th>
				<td>${userQuestion.qnaInquiry} </td>
			</tr>
			<tr>
				<th>제목</th>
				<td>${userQuestion.qnaSubject}</td>
			</tr>
			<tr>
				<th>등록일자</th>
				<td>${userQuestion.qnaRegDate}</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>${userName}</td>
			</tr>
			<tr>
				<th>처리상태</th>
				<td> <span  style="color:red">${userQuestion.qnaProgress }</span></td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="height:150px;">
						${userQuestion.qnaContent}
					</div>
					
				</td>
			</tr>
		</table>
		
		<div align="center">	
			<c:if test="${userQuestion.qnaProgress eq '접수완료'}">                                                                                                                                             
				<button type="button" class="btn btn-primary"  onClick="javascript:location.href='<%=request.getContextPath() %>/userQuestionEdit.eat?qnaSeq=${qnaSeq }&userName=${userName}&qnaInquiry=${userQuestion.qnaInquiry}&qnaSubject=${userQuestion.qnaSubject}&qnaRegDate=${userQuestion.qnaRegDate }&qnaProgress=${userQuestion.qnaProgress }'">수정</button>
			</c:if>
			<button class="btn btn-danger" type="button" onClick="javascript:self.close();">닫기</button>
		</div>
	</div>
	

	
</div>
</body>
</html>