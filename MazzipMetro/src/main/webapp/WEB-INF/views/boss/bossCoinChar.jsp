<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코인 결제</title>
<jsp:include page="../library.jsp" />  




<script type="text/javascript">

	//실제 지불 방식 코딩 시작
	$( document ).ready(function() {
		/* 동현_카카오페이 결제용 */
		IMP.init('imp92791497'); 
	});

	function goCharge(){
		
		/* 동현_카카오페이 결제용 */
		/* IMP.request_pay({
		    pg : 'kakao', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명: 포인트충전',
		    amount : $("#userPoint").val(),
		    buyer_email : '${sessionScope.loginUser.userEmail}',
		    buyer_name : '${sessionScope.loginUser.userName}',
		    buyer_tel : '${sessionScope.loginUser.userPhone}'
		}, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다. 사용자 포인트 충전을 요청합니다.\n';
		        msg +='------------------------------------------------------\n';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		        msg += '\n결제 금액 : ' + rsp.paid_amount;
		        msg += '\n카드 승인번호 : ' + rsp.apply_num;
		        msg +='\n------------------------------------------------------';
		        alert(msg);
		        
		        var coinCharFrm = document.coinCharFrm;
		        coinCharFrm.userPoint.value = $("#userPoint").val()*100;
		        alert('coinCharFrm.userPoint.value = '+coinCharFrm.userPoint.value);
				coinCharFrm.submit();
		        
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        alert(msg);
		    }
		});// end of IMP.request_pay() */
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
				<option value="1000"><fmt:formatNumber pattern="###,###" value="100000" /></option>
				<option value="5000"><fmt:formatNumber pattern="###,###" value="500000" /></option>
				<option value="10000" ><fmt:formatNumber pattern="###,###" value="1000000" /></option>
			</select> 원
			<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
			<button class="btnCoin" type="button" onClick="goCharge();">충전하기</button>
		</form>
		</li>
	</ul>
</body>
</html>