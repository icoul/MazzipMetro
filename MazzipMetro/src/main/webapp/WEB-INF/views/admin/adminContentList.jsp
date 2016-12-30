<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="../library.jsp" />    
<jsp:include page="../top.jsp" />
<style type="text/css">
	#colName {height:23px; font-size:13px;}
	#adminConStatis {margin-top:50px;}
</style>
<script type="text/javascript">
//미현_ ajax로 그래프 불러오기
$(document).ready(function(){
	searchKeep();
	
	$.ajax({
		url: "<%= request.getContextPath() %>/adminConStatis.eat",
		type: "GET",
		datatype: "html", 
		success: function(data){ 
			 $("#adminConStatis").html(data);
                                 
		}                  
	});
});

function goContentSearch() {
	var contentSearchFrm = document.contentSearchFrm;
	
	var search = $("#search").val();
	
	if(search.trim() == "") {
		alert("검색어를 입력하세요!!");
		event.preventDefault();
	}
	
	contentSearchFrm.submit();
	
}


function searchKeep(){
	<c:if test="${not empty colName && not empty search}">  // colname 과 search가 비어있지 않다면   
	   $("#colName").val("${colName}");  // 검색어 컬럼명을 유지시켜 주겠다.
	   $("#search").val("${search}");    // 검색어를 유지시켜 주겠다.
	</c:if>
}

</script>


	<div class="subleftCon" style="height:1000px;">
		<h2>컨텐츠 관리 리스트</h2>
	</div>
	<%-- subleftCon --%>
	<div class="subrightCon" style="height:1000px;">
		<div class="searchWrap">
			<form name="contentSearchFrm" action="<%= request.getContextPath() %>/adminContentList.eat" method="get"> 
				<a href="<%= request.getContextPath() %>/adminContentList.eat" class="btnFafa">목록</a>
				<select name="colName" id="colName">
					<option value="restName">상호명</option>
					<option value="contentName">컨텐츠명</option>
					<option value="restAddr">주소</option>
				</select>
				<input type="text" name="search" id="search" size="40px;" style="height:22px; vertical-align:-1px;" />
				<button class="btnGray" type="button" onClick="goContentSearch();">검색</button>
			</form>
		</div>
		<table class="tblType01" style="width:100%;">
			<tr>
				<th style="width:14%;" >번호</th>
				<th style="width:10%;" >등급</th>
				<th style="width:14%;" >상호명</th>
				<th style="width:14%;" >전화번호</th>
				<th style="width:18%;" >주소</th>
				<th style="width:14%;" >컨텐츠명</th>
				<th style="width:14%;" >컨텐츠사용기한</th>
			</tr>
		<c:forEach var="vo" items="${list}" varStatus="status"> 
			<tr>
				<td>${vo.restSeq}</td>
				<td>${vo.gradeName}</td>
				<td>${vo.restName}</td>
				<td>${vo.restPhone}</td>
				<td>${vo.restAddr}</td>
				<td>${vo.contentName}</td>
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
		
		<div id="adminConStatis"></div>
	
	</div>
	<%-- subrightCon --%>
<jsp:include page="../footer.jsp" />