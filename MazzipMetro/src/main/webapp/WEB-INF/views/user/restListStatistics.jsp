<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
#colName {height:23px; font-size:13px;}
.subrightCon .searchWrap {padding-top:10px; text-align:center;}

.tblRestList {margin:0; border-collapse: collapse; width:100%;}
.tblRestList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblRestList td {height:10px; padding-top:16px; padding-bottom:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center; vertical-align: middle;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 20px; margin-bottom: 10px; font-size:10px; }
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	function statistics(restSeq) {
		$.ajax({
			url:"<%=request.getContextPath()%>/Statistics.eat",
			type :"GET",
			data: "restSeq="+restSeq,
			dataType:"html",
			success: function(data){
				$("#hb_container").html(data);
			}
		});
	}
</script>
<div class="subleftCon"  style="height:1000px;">
<h2>매장별 통계</h2>
</div>
	<div class="subrightCon" style="height:1000px;">
	<jsp:include page="../userMyPage_Menubar.jsp" />
		<table class="tblRestList">
		<tr>
			<th style="width: 20%;">가게명</th>
			<th style="width: 20%;">업장대표이미지</th>
			<th style="width: 20%;">지번주소</th>
			<th style="width: 20%;">소속지하철</th>
			<th style="width: 20%;" >업장등록일자</th>
		</tr>
		
		<c:forEach var="vo" items="${restList}" varStatus="status"> 
			<tr>
				<td><a href="javascript:statistics('${vo.restSeq}')">${vo.restName}</a></td>
				<td><img src = "<%=request.getContextPath() %>/files/thumb${vo.restImg}" /></td>
				<td>${vo.restAddr}</td>
				<td>${vo.metroName}</td>
				<td>${vo.restRegDate}</td>
			</tr>
		</c:forEach>
	</table>
	 <div id="hb_container" style="width: 100%;"></div>
	</div>
	<%-- subrightCon --%>
<jsp:include page="../footer.jsp" />