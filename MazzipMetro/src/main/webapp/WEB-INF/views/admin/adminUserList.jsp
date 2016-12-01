<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
#colName {height:23px; font-size:13px;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:797px; border-right:1px solid #dbdbdb; padding-bottom:40px;}
.subrightCon .searchWrap {padding-top:10px; text-align:center;}

.tblUserList {margin:30px 0 0 30px; border-collapse: collapse; width:700px;}
.tblUserList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblUserList td {height:10px; padding-top:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 20px; margin-bottom: 10px; font-size:10px; }
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
		<!-- #63. 글검색 폼 추가하기 : 제목, 내용, 글쓴이로 검색하도록 한다. -->
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
		<table class="tblUserList">
		<tr>
			<th style="width: 70px;" >번호</th>
			<th style="width: 80px;" >성명</th>
			<th style="width: 70px;" >등급번호</th>
			<th style="width: 70px;" >이메일</th>
			<th style="width: 70px;" >전화번호</th>
			<th style="width: 70px;" >가입일자</th>
			<th style="width: 70px;" >포인트</th>
			<th style="width: 70px;" >삭제</th>
		</tr>
		
		<c:forEach var="vo" items="${list}" varStatus="status"> 
			<tr>
				<td>${vo.userSeq}</td>
				<td>${vo.userName}</td>
				<td>${vo.gradeSeq}</td>
				<td>${vo.userEmail}</td>
				<td>${vo.userPhone}</td>
				<td>${vo.userRegDate}</td>
				<td>${vo.userPoint}</td>
				<td>
					<form name="userDelFrm"  action="<%= request.getContextPath() %>/adminUserDel.eat" method="post">
						<button class="btnGray" onClick="goUserDel" style="margin-top:0; width:40px;">삭제</button>
						<input type="hidden" name="userSeq" value="${vo.userSeq}" />
					</form>		
				</td>
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