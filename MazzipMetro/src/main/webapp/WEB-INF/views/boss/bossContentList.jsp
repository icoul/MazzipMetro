<%@page import="com.go.mazzipmetro.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />   
<jsp:include page="../top.jsp" />

<script type="text/javascript">
</script>

<div class="subleftCon">
	<h2>컨텐츠구매목록</h2>
</div>
<div class="subrightCon">
	<jsp:include page="../userMyPage_Menubar.jsp" />
	<form name="userOnefrm" action="bossCotentList.eat" method="GET">
	<table class="tblType01" style="width:100%;">
			<tr>
				<th style="width:10%;" >등급</th>
				<th style="width:10%;" >상호명</th>
				<th style="width:20%;" >전화번호</th>
				<th style="width:20%;" >주소</th>
				<th style="width:20%;" >컨텐츠명</th>
				<th style="width:20%;" >컨텐츠사용기한</th>
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