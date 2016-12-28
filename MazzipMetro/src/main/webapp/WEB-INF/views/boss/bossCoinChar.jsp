<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코인 결제</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script>

<script type="text/javascript">
	function goCharge(){
		
		var coinCharFrm = document.coinCharFrm;
		coinCharFrm.submit();
	}	
</script>
<style type="text/css">
* { padding:0; margin:0;}
.title {width:250px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; padding-left:20px; font-size:15px;}
input[type=radio] {vertical-align:-3px;}
.coinPopWrap {padding:30px 0 0 20px; font-size:11px;}
.coinPopWrap  li {list-style:none;}
.coinPopWrap  li.first {margin-bottom:10px;}

.btnCoin {width: 58px;
    height: 25px;
    margin-left:10px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
</style>
</head>
<body>
	<h2 class="title">코인 결제하기</h2>
	<ul class="coinPopWrap">
		<li class="first">
			<input type="radio" value="secrCard" id="secrCard" name="payWay" checked /> <label for="secrCard">신용카드</label>&nbsp;
			<input type="radio" value="checCard" id="checCard" name="payWay" /> <label for="checCard">체크카드</label>&nbsp;
			<input type="radio" value="cashCard" id="cashCard" name="payWay" /> <label for="cashCard">현금</label>&nbsp;
			<input type="radio" value="phoneCard" id="phoneCard" name="payWay" /> <label for="phoneCard">휴대폰결제</label>
			
		</li>
		<li>
			<%-- 돈으로 구매시 Coin 10프로 충전시   --%>
			<form name="coinCharFrm" action="<%= request.getContextPath() %>/bossCoinResiEnd.eat" method="post">	
			코인충전액 : 
			<select name="userPoint" id="userPoint" style="height:25px;"><%--name을 파라미터에 controller로 받으면 나옴 --%>
				<option value="100000"><fmt:formatNumber pattern="###,###" value="100000" /></option>
				<option value="500000"><fmt:formatNumber pattern="###,###" value="500000" /></option>
				<option value="1000000" ><fmt:formatNumber pattern="###,###" value="1000000" /></option>
			</select> 원
			<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
			<button class="btnCoin" type="button" onClick="goCharge();">충전하기</button>
		</form>
		</li>
	</ul>
</body>
</html>