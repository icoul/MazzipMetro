<%@page import="com.go.mazzipmetro.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:1200px; border-right:1px solid #dbdbdb; height:500px;}

.coinWrap {padding:30px 0 0 20px; font-size:13px;}
.coinWrap  li.first {width:600px; border-bottom: 1px solid #dbdbdb; margin-bottom:30px; }
.btnCoin {width: 58px;
    height: 25px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
    
.btnPoint {width: 68px;
    height: 30px;
    background: #fff;
    font-size: 10px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #000;
    cursor: pointer;}
 .desc {margin-top:10px; margin-bottom:20px; font-size: 11px;}   
</style>


<script type="text/javascript">

function goCoinBuy(userSeq){
	//코인 결제하기 팝업창 띄우기
	var url = "bossCoinChar.eat?userSeq="+userSeq;
	window.open(url, "bossCoinChar", "left=350px, top=100px, width=350px, height=300px, status=no, scrollbars=yes");		
}

function goBannBuy(userSeq){
	
	var bannFrm = document.bannFrm;
	
	bannFrm.action="bossBannBuy.eat";
	bannFrm.method="POST";
	
	
	var bool = confirm("파워배너 결제하시겠습니까 ?");
	if(bool) {
		//alert("${sessionScope.loginUser.userPoint}");
		bannFrm.submit();
	}
}

function goLinkBuy(userSeq) {
var linkFrm = document.linkFrm;
	
	linkFrm.action="bossLinknBuy.eat";
	linkFrm.method="POST";
	
	
	var bool = confirm("파워링크 결제하시겠습니까 ?");
	if(bool) {
		linkFrm.submit();
	}
	
}


function goRecomBuy(userSeq) {
	var rcomFrm = document.linkFrm;
		
		rcomFrm.action="bossRecomBuy.eat";
		rcomFrm.method="POST";
		
		
		var bool = confirm("추천광고 결제하시겠습니까 ?");
		if(bool) {
			rcomFrm.submit();
		}
		
	}

</script>

<% 
	UserVO vo = (UserVO)session.getAttribute("loginUser");	


%>

	<div class="subleftCon">
		<h2>사업자 코인 충전</h2>
	</div>
	<div class="subrightCon">
		<ul class="coinWrap">
			<li class="first">
				코인 결제하기 : <button class="btnCoin" type="button" onClick="goCoinBuy('${userSeq}');">코인 충전</button>
				<p class="desc"><span style="font-size:12px;">※</span> 코인은 100만원 단위부터 충전 가능합니다.</p>
			</li>
			<li>
				<form name="bannFrm" id="bannFrm" method="post">
					<b>파워배너</b>  : <button class="btnPoint" type="button" name="bannCoin" onClick="goBannBuy('${userSeq}');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 메인페이지에 광고 입니다. (100만 포인트)</p>
					<input type="hidden" name="restSeq" value="${restSeq}" /> 
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
				</form>
				<form name="linkFrm" id="linkFrm" method="post">
					<b>파워링크</b>  : <button class="btnPoint" type="button" name="linkCoin"  onClick="goLinkBuy('${userSeq}');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 검색시 최상위에 따로 보여주는 컨텐츠 입니다.(50만 포인트)</p>
					<input type="hidden" name="restSeq" value="${restSeq}" /> 
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
				</form>
				<form name="rcomFrm" id="rcomFrm" method="post">
					<b>추천광고</b> : <button class="btnPoint" type="button" name="recomCoin" onClick="goRecomBuy('${userSeq}');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 추천메뉴로 보여주는 컨텐츠입니다. (30만 포인트)</p>
					<input type="hidden" name="restSeq" value="${restSeq}" /> 
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
				</form>
			</li>
		</ul>
	</div>

<jsp:include page="../footer.jsp" />