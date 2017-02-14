<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>리뷰목록</title>
<style type="text/css">
.myReviewList {margin:0; border-collapse: collapse; width:100%;}
.myReviewList th {height:50px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.myReviewList td {height:10px; padding-top:16px; padding-bottom:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center; vertical-align: middle;}
</style>

<script type="text/javascript">
			
	function adminReviewDel(reviewSeq, restName) {
			
		    var bool = confirm(restName + "의 리뷰를 정말로 삭제하시겠습니까?");
	    	 
			if(bool) {
				var adminReviewDeleteFrm = document.adminReviewDeleteFrm;
				adminReviewDeleteFrm.reviewSeq.value = reviewSeq;
				adminReviewDeleteFrm.action = "adminReviewDelete.eat";
				adminReviewDeleteFrm.method = "POST";
				adminReviewDeleteFrm.submit();
				
				
			} // end of if
			
		}// end of reviewDel
		
</script>

</head>
<body>
<div class="subleftCon">
<h2>리뷰관리</h2>
</div>
<div class="subrightCon" align="center" >

<form name = "adminReviewDeleteFrm"> 
	<input type ="hidden" name = "reviewSeq" value="${review.REVIEWSEQ}">
	<input type="hidden" name="pageNo" value="${pageNo}" />
	<table class="myReviewList" style="margin-top:30px; width:100%;">
		<tr >
			<th style="text-align: center; width:20%;">가게명</th>
			<th style="text-align: center; width:20%;">작성자<br>[작성자이메일]</th>
			<th style="text-align: center; width:20%;">리뷰제목</th>
			<th style="text-align: center; width:20%;">리뷰작성일자</th>
			<th style="text-align: center; width:20%;">삭제</th>
		</tr>
		<c:forEach var="review" items="${adminReviewList}" varStatus="status">
		<tr>
			<td style="text-align: center;">${review.RESTNAME}</td>
			<td style="text-align: center;">${review.USERNAME}<br><span style="color:#888888;">[${review.USEREMAIL}]</span></td>
			<td style="text-align: center;">${review.REVIEWTITLE}</td>
			<td style="text-align: center;">${review.REVIEWREGDATE}</td>
			<td style="text-align: center;"> 
				<button type="button" class="btn btn-danger" onClick="adminReviewDel('${review.REVIEWSEQ}', '${review.RESTNAME}');">삭제</button>
			</td>
		</tr>
		</c:forEach>
	</table>
</form>
		${pageBar}

</div>
</body>
</html>