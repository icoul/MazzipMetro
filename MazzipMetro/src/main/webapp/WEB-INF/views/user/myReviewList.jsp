<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../top.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.myReviewList {margin:0; border-collapse: collapse; width:100%;}
.myReviewList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.myReviewList td {height:10px; padding-top:16px; padding-bottom:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center; vertical-align: middle;}
</style>

<script type="text/javascript">
	function reviewEdit(reviewSeq) {
		alert(reviewSeq);
		var url = "reviewEdit.eat?reviewSeq="+reviewSeq;
		
		window.open(url, "reviewEdit", "left=500px, top=100px, width=600px, height=915px, menubar=no, status=no, scrollbars=yes ");
	}

	
	function reviewDel(reviewSeq, restName) {
		
	    var bool = confirm(restName + "의 리뷰를 정말로 삭제하시겠습니까?");

	    if(bool) {
	    	var reviewDelFrm = document.reviewDelFrm;
	    	reviewDelFrm.reviewSeq.value = reviewSeq;
	    	reviewDelFrm.action = "reviewDelete.eat";
	    	reviewDelFrm.method = "post";
	    	reviewDelFrm.submit();
	    }
		
	}
	
</script>

	

</head>
<body>
<div class="subleftCon">
		<h2>${sessionScope.loginUser.userName}님의<br> 리뷰목록</h2>
</div>
<div class="subrightCon" align="center" >
<jsp:include page="../userMyPage_Menubar.jsp" />
	<table class="myReviewList" style="margin-top:30px;">
		<tr >
			<th style="text-align: center;">가게명</th>
			<th style="text-align: center;">리뷰제목</th>
			<th style="text-align: center;">리뷰내용</th>
			<th style="text-align: center;">리뷰작성일자</th>
			<th style="text-align: center;">수정 | 삭제</th>
		</tr>
		<c:forEach var="review" items="${myReviewList}" varStatus="status">
		<tr>
			<td style="text-align: center;">${review.restName}</td>
			<td style="text-align: center;">${review.reviewTitle}</td>
			<td style="text-align: center;">${review.reviewContent}</td>
			<td style="text-align: center;">${review.reviewRegdate}</td>
			<td style="text-align: center;"> 
				<div class="btn-group ">
				<button type="button" class="btn btn-default" onClick="reviewEdit('${review.reviewSeq}');">수정</button>
				<button type="button" class="btn btn-danger" onClick="reviewDel('${review.reviewSeq}', ${review.restName});">삭제</button>
				</div>
			</td>
		</tr>
		</c:forEach>
	</table>

<form name="reviewDelFrm">
	<input type="hidden" name="reviewSeq" />
</form>

</div>
</body>
</html>