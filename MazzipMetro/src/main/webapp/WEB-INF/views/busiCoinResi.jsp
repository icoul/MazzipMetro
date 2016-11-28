<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="top.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {padding-top:30px; text-align:center;}
.subrightCon {float:left; width:797px; border-right:1px solid #dbdbdb; height:500px;}

.coinWrap {padding:30px 0 0 20px;}
.btnCoin {width: 58px;
    height: 25px;
    background: #000;
    font-size: 9px;
    border: 1px solid #000;
    border-radius: 2px;
    color: #fff;
    cursor:pointer;
    }
</style>
<script type="text/javascript">

function goCoinBuy(userSeq){
	//팝업창 띄우기
	var url = "coinChar.eat?userSeq="+userSeq;
	window.open(url, "coinChar", "left=350px, top=100px, width=650px, height=500px, status=no, scrollbars=yes");		
}



</script>
<div class="subleftCon">
	<h2>사업자 코인 충전</h2>
</div>
<div class="subrightCon">
	<div class="coinWrap">
			코인구매하기 : <button class="btnCoin" type="button" onClick="goCoinBuy('${vo.userSeq}');">코인 구매</button>
			<input type="text" name="userSeq" value="${vo.userSeq}" />	
	</div>
</div>


<jsp:include page="footer.jsp" />