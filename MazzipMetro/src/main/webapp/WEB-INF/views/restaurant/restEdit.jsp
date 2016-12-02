<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
#colName {height:23px; font-size:13px;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:797px; height:auto; border-right:1px solid #dbdbdb; padding-bottom:40px;}
.subrightCon .searchWrap {padding-top:10px; text-align:center;}

.tblRestList {margin:30px 0 0 50px; border-collapse: collapse; width:700px;}
.tblRestList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblRestList td {height:10px; padding-top:16px; padding-bottom:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center; vertical-align: middle;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 20px; margin-bottom: 10px; font-size:10px; }
</style>
<script type="text/javascript">
$(document).ready(function(){
	
});

function goRestDel(){
	var restDelFrm = document.restDelFrm;
	
	restDelFrm.submit();
}

</script>


	<div class="subleftCon">
		<h2>업장리스트</h2>
	</div>
	<%-- subleftCon --%>
	<div class="subrightCon">
		<table class="tblRestList">
		<tr>
			<th style="width: 80px;" >가게명</th>
			<th style="width: 70px;" >등급</th>
			<th style="width: 70px;" >업장대표이미지</th>
			<th style="width: 70px;" >업장등록일자</th>
			<th style="width: 70px;" >업장방문수</th>
			<th style="width: 70px;" >삭제</th>
		</tr>
		
		<c:forEach var="vo" items="${restList}" varStatus="status"> 
			<tr>
				<td><a href = "<%= request.getContextPath()%>/restEditEnd.eat?restSeq=${vo.restSeq}">${vo.restName}</a></td>
				<td>${vo.gradeSeq}</td>
				<td><img src = "<%=request.getContextPath() %>/files/thumb${vo.restImg}" /></td>
				<td>${vo.restRegDate}</td>
				<td>${vo.restVisitor}</td>
				<td>
					<form name="restDelFrm"  action="<%= request.getContextPath() %>/restDel.eat" method="post">
						<button class="btnGray" onClick="goRestDel();" style="margin-top:0; width:40px;">삭제</button>
						<input type = "hidden" name = "restSeq" value="${vo.restSeq}" />
					</form>		
				</td>
			</tr>
		</c:forEach>
	</table>
	<br/>
	</div>
	<%-- subrightCon --%>
<jsp:include page="../footer.jsp" />