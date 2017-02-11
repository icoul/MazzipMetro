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
					url : "<%=request.getContextPath()%>/metroKeyUp.eat",
					method : "GET",
					data : "metroName=" + searchVar,
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
		var metroSearchFrm = document.metroSearchFrm;
		metroSearchFrm.submit();
	}
	
	function setMetro(metroName){
		var rankingViewFrm = opener.document.rankingViewFrm;
		
		rankingViewFrm.metroId.value = $("#metroId").val();
		$(opener.document).find("#metroName").text(metroName);
		
		self.close();
	}
	
</script>

<meta charset="UTF-8">
<title>지하철 역 검색</title>
</head>
<body>
<div style="background: #008968; height: 30px; padding-top: 7px;">
	<span style="font-size:13pt; color:#fff;">&nbsp; ::: 지하철 역명 검색</span>
</div>
<div align="center" style="margin-top:4px;">
(예). 2호선 : 낙성대, 잠실나루, 뚝섬 .. 등 등
</div>
<form name="metroSearchFrm" action="metroSearch.eat" method="get">
	<c:if test="${searchMetro == null}">
		<div style="margin-top:15px;">
			<div align="center">
				<input type="text" class="form-control" name="searchVar" id="searchVar" style="width:250px; margin-left: 28px; float:left;"/> &nbsp;
				<input type="button" value="검색" style="float:left; margin-left:5px;" class="btn btn-default" onClick="goCheck();" />
			</div>
			<div id = "display" style = "clear:both; position : relative; margin-left:40px; top : 0px;">
				<div id = "displayList" style = "top : 2px;"></div>
		    </div>
		</div>
	</c:if>
	<c:if test="${searchMetro != null}">
		<div align="center" style="margin-top:15px;">
			<span style = "font-size : 12pt; font-weight: bold;">
				<span style = "color:red;">"${searchVar}"</span>의 검색결과입니다.<br/> 원하는 역명을 선택해주세요.
			</span>
			<br/>
			<br/>
			<c:forEach var="searchMetro" items="${searchMetro}">
				<span style = "font-size : 12pt;">
				<a href="#" onClick = "setMetro('${searchMetro.metroName}');">${searchMetro.metroName}</a>
				<input type="hidden" name="metroId" id="metroId" value="${searchMetro.metroId}" />
				</span><br/><br/>
			</c:forEach>
		</div>
	</c:if>
</form>
</body>
</html>