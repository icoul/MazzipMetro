<%@page import="com.go.mazzipmetro.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {font-size:20px;  width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:1200px; border-right:1px solid #dbdbdb; height:500px;}
.tblUserList {border-collapse: collapse; width:100%; text-aign:center; margin-bottom:20px;}
.tblUserList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblUserList td {height:50px; padding-top:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center;}
</style>


<script type="text/javascript">
</script>

<div class="subleftCon">
	<h2>컨텐츠구매목록</h2>
</div>
<div class="subrightCon">
	<jsp:include page="../userMyPage_Menubar.jsp" />
	<form name="userOnefrm" action="bossCoinList.eat" method="GET">
	<table class="tblUserList">
			<tr>
				<th style="width: 80px;" >등급</th>
				<th style="width: 70px;" >상호명</th>
				<th style="width: 70px;" >전화번호</th>
				<th style="width: 70px;" >주소</th>
				<th style="width: 70px;" >컨텐츠명</th>
				<th style="width: 70px;" >컨텐츠사용기한</th>
			</tr>
			<c:if test="${list != null && not empty list}">
				<c:forEach var="vo" items="${list}" varStatus="status"> 
					<tr>
						<td>${vo.gradeName}</td>
						<td>${vo.restName}</td>
						<td>${vo.restPhone}</td>
						<td>${vo.restAddr}</td>
						<td>${vo.contentName}</td>
						<td>${vo.contentLimit}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${list == null || empty list}">
				<tr>
					<td colspan="6">데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table> 
		<br/>
			<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
		</form>
		<!-- #75. 페이지바 보여주기 -->
		<c:if test="${list  != null && not empty list}">
			<div align="center">
				${pagebar}
			</div>
			<br/>
		</c:if>
</div>

<jsp:include page="../footer.jsp" />