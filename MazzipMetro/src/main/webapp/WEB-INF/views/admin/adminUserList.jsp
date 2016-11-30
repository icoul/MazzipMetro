<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:797px; border-right:1px solid #dbdbdb; height:500px;}

table, th, td {border: solid gray 1px;}
#table {margin:30px 0 0 20px; border-collapse: collapse; width: 750px;}
#table th, #table td {padding: 5px;}
#table th {background-color: #dddddd;}
  
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

</script>
	<div class="subleftCon">
		<h2>회원리스트</h2>
	</div>
	<div class="subrightCon">
		<table id="table">
		<tr>
			<th style="width: 70px;" >번호</th>
			<th style="width: 150px;" >성명</th>
			<th style="width: 70px;" >등급번호</th>
			<th style="width: 70px;" >이메일</th>
			<th style="width: 70px;" >전화번호</th>
			<th style="width: 70px;" >가입일자</th>
			<th style="width: 70px;" >포인트</th>
		</tr>
		
		<c:forEach var="vo" items="${list}" varStatus="status"> 
			<tr>
				<td align="center">${vo.userSeq}</td>
				<td>${vo.userName}</td>
				<td>${vo.gradeSeq}</td>
				<td>${vo.userEmail}</td>
				<td>${vo.userPhone}</td>
				<td align="center">${vo.userRegDate}</td>
				<td align="center">${vo.userPoint}</td>
			</tr>
		</c:forEach>
	</table>
	<br/>
	
	
	<!-- #75. 페이지바 보여주기 -->
	<div align="center" style="width:400px; margin-left: 100px; margin-right: auto;">
		${pagebar}
	</div>
	<br/>
	
	<!-- #63. 글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. -->
	<form name="searchFrm" action="<%= request.getContextPath() %>/adminUserList.eat" method="get"> 
		<select name="colName" id="colName">
			<option value="userPhone">휴대폰</option>
			<option value="userEmail">이메일</option>
			<option value="userName">이름</option>
		</select>
		<input type="text" name="search" id="search" size="40px;" />
		<button type="button" onClick="goSearch();">검색</button>
	</form>
	</div>
<jsp:include page="../footer.jsp" />