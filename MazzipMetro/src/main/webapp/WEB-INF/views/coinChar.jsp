<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코인충전하자</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script>

<script type="text/javascript">
	function goCharge(){
		
		var coinCharFrm = document.coinCharFrm;
		coinCharFrm.submit();
	}	
</script>
</head>
<body>
	<form name="coinCharFrm" action="<%= request.getContextPath() %>/busiCoinResiEnd.eat" method="get">
		<%-- 돈으로 구매시 Coin 10프로 충전시   --%>
		코인충전액 : 
		<select name="userPoint" id="userPoint"><%--name을 파라미터에 controller로 받으면 나옴 --%>
			<option value="100000"><fmt:formatNumber pattern="###,###" value="1000000" /></option>
			<option value="500000"><fmt:formatNumber pattern="###,###" value="5000000" /></option>
			<option value="1000000" ><fmt:formatNumber pattern="###,###" value="10000000" /></option>
		</select>
		<input type="hidden" name="userSeq" <%-- value="${userSeq}" --%> value="7" /> 
		<button type="button" onClick="goCharge();">충전하기</button>
	</form>
</body>
</html>