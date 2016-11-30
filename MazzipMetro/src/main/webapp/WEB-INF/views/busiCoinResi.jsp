<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:797px; border-right:1px solid #dbdbdb; height:500px;}

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
	var url = "coinChar.eat?userSeq="+userSeq;
	window.open(url, "coinChar", "left=350px, top=100px, width=350px, height=300px, status=no, scrollbars=yes");		
}

function goBannBuy(userSeq){
	
	var bannFrm = document.bannFrm;
	
	bannFrm.action="bannBuy.eat";
	bannFrm.method="POST";
	
	
	var bool = confirm("결제하시겠습니까 ?");
	if(bool) {
		bannFrm.submit();
	}
}



</script>
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
					<input type="hidden" name="userSeq" <%-- value="${vo.userSeq}" --%>  value="13" /> 
					<input type="hidden" name="restSeq" <%-- value="${vo.restSeq}" --%>  value="727" /> 
					<input type="hidden" name="contentSeq" <%-- value="${vo.restSeq}" --%>  value="727" /> 
				</form>
			
					<b>파워링크</b>  : <button class="btnPoint" type="button" name="linkCoin"  onClick="goBannBuy('${userSeq}');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 검색시 최상위에 따로 보여주는 컨텐츠 입니다.(50만 포인트)</p>
			
					<b>추천광고</b> : <button class="btnPoint" type="button" name="rcomCoin" onClick="goBannBuy('${userSeq}');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 추천메뉴로 보여주는 컨텐츠입니다. (30만 포인트)</p>
			</li>
		</ul>
	</div>

</div>
	<%-- end of content --%>
</div>
<%-- end of container --%>

<jsp:include page="footer.jsp" />