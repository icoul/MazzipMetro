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

<form name="metroSearchFrm" action="metroSearch.eat" method="get">
	<c:if test="${searchMetro == null}">
		<table>
			<tr>
				<td>
					 지하철 역명 : <input type="text" name="searchVar" id="searchVar" size="15" class="box" />
					 		   <input type="button" value="검색" class="box" onClick="goCheck();" />
					 		   <div id = "display" style = "position : relative; left : 0px; top : 0px;">
									<div id = "displayList" style = "width : 131px; margin-left : 101px; border-top : 0px; border : solid gray 1px;">
										
									</div>
								</div>
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${searchMetro != null}">
		
		<div align="center" style = "margin-left : 15px; margin-top : 50px;">
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