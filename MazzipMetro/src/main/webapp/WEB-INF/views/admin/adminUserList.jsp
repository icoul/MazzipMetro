<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />    
<jsp:include page="../top.jsp" />
<style type="text/css">
	#colName {height:23px; font-size:13px;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	searchKeep();
	
	
});

function goSearch() {
	var searchFrm = document.searchFrm;
	
	var search = $("#search").val();
	
	if(search.trim() == "") {
		alert("검색어를 입력하세요!!");
	}
	else{
		searchFrm.submit();
	}
}


function searchKeep(){
	<c:if test="${not empty colName && not empty search}">  // colname 과 search가 비어있지 않다면   
	   $("#colName").val("${colName}");  // 검색어 컬럼명을 유지시켜 주겠다.
	   $("#search").val("${search}");    // 검색어를 유지시켜 주겠다.
	</c:if>
}

function goUserDel(userSeq){
	var userDelFrm = document.userDelFrm;
	
	userDelFrm.action="adminUserDel.eat";
	userDelFrm.method="post";
	userDelFrm.submit();
}

function goUserEdit(userSeq){
	var url = "adminUserEdit.eat?userSeq="+userSeq;
	window.open(url, "adminUserEdit", "left=350px, top=100px, width=350px, height=300px, status=no, scrollbars=yes");
}

</script>


	<div class="subleftCon">
		<h2>회원리스트</h2>
	</div>
	<%-- subleftCon --%>
	<div class="subrightCon">
		<div class="searchWrap">
		<form name="searchFrm" action="<%= request.getContextPath() %>/adminUserList.eat" method="get"> 
			<a href="<%= request.getContextPath() %>/adminUserList.eat" class="btnFafa">목록</a>
			<select name="colName" id="colName">
				<option value="userPhone">전화번호</option>
				<option value="userEmail">이메일</option>
				<option value="userName">회원명</option>
			</select>
			<input type="text" name="search" id="search" size="40px;" style="vertical-align:-2px;" />
			<button class="btnGray" type="button" onClick="goSearch();">검색</button>
		</form>
		</div>
		<div class="txtC">
			<table class="tblType01">
			<tr>
				<th style="width: 70px;" >번호</th>
				<th style="width: 80px;" >성명</th>
				<th style="width: 70px;" >등급번호</th>
				<th style="width: 70px;" >이메일</th>
				<th style="width: 70px;" >전화번호</th>
				<th style="width: 70px;" >가입일자</th>
				<th style="width: 70px;" >포인트</th>
				<th style="width: 70px;" >수정/삭제</th>
			</tr>
		
		<c:forEach var="vo" items="${list}" varStatus="status"> 
			<tr>
				<td>${vo.userSeq}</td>
				<td>${vo.userName}</td>
				<td>${vo.gradeName}</td>
				<td>${vo.userEmail}</td>
				<td>${vo.userPhone}</td>
				<td>${vo.userRegDate}</td>
				<td>${vo.userPoint}</td>
				<td>
					<button class="btnGray" onClick="goUserEdit('${vo.userSeq}');" style="margin-top:0; width:40px;">수정</button>
					<input type="hidden" name="userSeq" value="${vo.userSeq}" />
					<form name="userDelFrm"  action="<%= request.getContextPath() %>/adminUserDel.eat" method="post">
						<button class="btnGray" onClick="goUserDel();" style="margin-top:0; width:40px;">삭제</button>
						<input type="hidden" name="userSeq" value="${vo.userSeq}" />
						<input type="hidden" name="pageNo" value="${pageNo}"/>
					</form>		
				</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	<br/>
	<!-- #75. 페이지바 보여주기 -->
	<div align="center">
		
		${pagebar}
	</div>
	<br/>
	
	
	</div>
	<%-- subrightCon --%>
<jsp:include page="../footer.jsp" />