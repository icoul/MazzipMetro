<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />
<!DOCTYPE html>
<html>
<head>

<style>
	table {margin-left : 25px;
		   margin-top : 80px;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$("#displayList").hide();
		
		$("#searchVar").keyup(function(){
			
			var searchVar = $("#searchVar").val();
			if (searchVar != "") {
				$.ajax({
					url : "<%=request.getContextPath()%>/dongKeyUp.eat",
					method : "GET",
					data : "dongName=" + searchVar,
					dataType : "html",
					success : function(data){
						if (data != null) {
							$("#displayList").empty();
							$("#displayList").show();
							$("#displayList").html(data);
						}
					}
				}); // end of ajax
			}
			
			if (searchVar == "") {
				$("#displayList").hide();
				$("#displayList").empty();
			}
		});
	});
	
	function wordChoice(name){
		$("#searchVar").val(name);
		$("#displayList").empty();
		$("#displayList").hide();
	}
	
	function goCheck(){
		var dongSearchFrm = document.dongSearchFrm;
		dongSearchFrm.submit();
	}
	
	function setDong(dongName){
		var rankingViewFrm = opener.document.rankingViewFrm;
		
		rankingViewFrm.dongId.value = $("#dongId").val();
		$(opener.document).find("#dongName").text(dongName);
		
		self.close();
	}
	
</script>

<meta charset="UTF-8">
<title>지역 검색</title>
</head>
<body>
<div style="background: #008968; height: 30px; padding-top: 7px;">
	<span style="font-size:13pt; color:#fff;">&nbsp; ::: 동명 검색</span>
</div>
<div align="center" style="margin-top:4px;">
(예). 동명 : 성북동, 신림동, 방배동 .. 등 등
</div>
<form name="dongSearchFrm" action="dongSearch.eat" method="get">
	<c:if test="${searchDong == null}">
		<div style="margin-top:15px;">
				<div align="center">
		 			<input type="text" class="form-control" name="searchVar" id="searchVar" style="width:250px; margin-left: 28px; float:left;" />
	     			<input type="button" style="float:left; margin-left:5px;" value="검색" class="btn btn-default" onClick="goCheck();" />
	     		</div>
			<div id = "display" style = "clear:both; position : relative; margin-left:40px; top : 0px;">
				<div id = "displayList" style = "top : 2px;"></div>
		    </div>
		</div>
	</c:if>
	<c:if test="${searchDong != null}">
		<div align="center" style="margin-top:15px;">
			<span style = "font-size : 12pt; font-weight: bold;">
				<span style = "color:red;">"${searchVar}"</span>의 검색결과입니다.<br/> 원하는 역명을 선택해주세요.
			</span>
			<br/>
			<br/>
			<c:forEach var="searchDong" items="${searchDong}">
				<span style = "font-size : 12pt;">
				<a href="#" onClick = "setDong('${searchDong.dongName}');">${searchDong.dongName}</a>
				<input type="hidden" name="dongId" id="dongId" value="${searchDong.dongId}" />
				</span><br/><br/>
			</c:forEach>
		</div>
	</c:if>
</form>
</body>
</html>