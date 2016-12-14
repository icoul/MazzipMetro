<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="../top.jsp" />
<jsp:include page="../library.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
a:hover {color:#000; text-decoration:none;}
#colName {height:23px; font-size:13px;}
.subleftCon {float:left; width:200px; height:1000px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right; font-size:18px;}
.subrightCon {float:left; width:1200px; text-align:center; height:1000px; border-right:1px solid #dbdbdb; padding-bottom:40px;}
.subrightCon .searchWrap {padding:10px 0 20px 0; }

.tblUserList {border-collapse: collapse; width:100%; text-aign:center;}
.tblUserList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblUserList td {height:50px; padding-top:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 16px; margin-bottom: 10px; font-size:10px; }
.btnFafa {width:63px; height:23px; display:inline-block; margin:0 15px 0; line-height:23px; border:1px solid #6c6c6c; background:#fafafa; color:#000; font-size:10px;}
#adminConStatis {margin-top:50px;}
</style>
<script type="text/javascript">
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
		<h2>컨텐츠 관리 리스트</h2>
	</div>
	<%-- subleftCon --%>
	<div class="subrightCon">
		<div class="searchWrap">
			<form name="searchFrm" action="<%= request.getContextPath() %>/adminConList.eat" method="get"> 
				<a href="<%= request.getContextPath() %>/adminConList.eat" class="btnFafa">목록</a>
				<select name="colName" id="colName">
					<option value="restName">상호명</option>
					<option value="contentName">컨텐츠명</option>
					<option value="restAddr">주소</option>
				</select>
				<input type="text" name="search" id="search" size="40px;" style="height:22px; vertical-align:-1px;" />
				<button class="btnGray" type="button" onClick="goSearch();">검색</button>
			</form>
		</div>
		<table class="tblUserList">
			<tr>
				<th style="width: 70px;" >번호</th>
				<th style="width: 80px;" >등급</th>
				<th style="width: 70px;" >상호명</th>
				<th style="width: 70px;" >전화번호</th>
				<th style="width: 70px;" >주소</th>
				<th style="width: 70px;" >컨텐츠명</th>
				<th style="width: 70px;" >컨텐츠사용기한</th>
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