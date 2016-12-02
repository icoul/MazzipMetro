<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
#colName {height:23px; font-size:13px;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:1200px; text-align:center; height:auto; border-right:1px solid #dbdbdb; padding-bottom:40px;}
.subrightCon .searchWrap {padding:10px 0 20px 0; }

.tblUserList {border-collapse: collapse; width:800px;}
.tblUserList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblUserList td {height:10px; padding-top:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 20px; margin-bottom: 10px; font-size:10px; }
 .txtC {margin:0 auto; width:800px;}
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

</script>


	<div class="subleftCon">
		<h2>회원리스트</h2>
	</div>
	<%-- subleftCon --%>
	<div class="subrightCon">
		<div class="searchWrap">
		<form name="searchFrm" action="<%= request.getContextPath() %>/adminUserList.eat" method="get"> 
			<select name="colName" id="colName">
				<option value="userPhone">휴대폰</option>
				<option value="userEmail">이메일</option>
				<option value="userName">이름</option>
			</select>
			<input type="text" name="search" id="search" size="40px;" style="vertical-align:-2px;" />
			<button class="btnGray" type="button" onClick="goSearch();">검색</button>
		</form>
		</div>
		<div class="txtC">
			<table class="tblUserList">
			<tr>
				<th style="width: 70px;" >번호</th>
				<th style="width: 80px;" >등급</th>
				<th style="width: 70px;" >상호명</th>
				<th style="width: 70px;" >전화번호</th>
				<th style="width: 70px;" >주소</th>
				<th style="width: 70px;" >컨텐츠사용기한</th>
			</tr>
		</div>
		<c:forEach var="vo" items="${list}" varStatus="status"> 
			<tr>
				<td>${vo.restSeq}</td>
				<td>${vo.gradeSeq}</td>
				<td>${vo.restName}</td>
				<td>${vo.restPhone}</td>
				<td>${vo.contentLimit}</td>
			</tr>
		</c:forEach>
	</table>
	<br/>
	
	
	<!-- #75. 페이지바 보여주기 -->
	<div align="center">
		${pagebar}
	</div>
	<br/>
	
	
	</div>
	<%-- subrightCon --%>
<jsp:include page="../footer.jsp" />