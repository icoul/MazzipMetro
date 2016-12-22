<%@page import="com.go.mazzipmetro.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<jsp:include page="../library.jsp" />  
<jsp:include page="../top.jsp" />

<style type="text/css">
input[type=radio] {vertical-align:-2px;}
</style>


<script type="text/javascript">
//미현_코인 결제하기 팝업창 띄우기
function goCoinBuy(userSeq){
	var url = "bossCoinChar.eat?userSeq="+userSeq;
	window.open(url, "bossCoinChar", "left=350px, top=100px, width=350px, height=300px, status=no, scrollbars=yes");		
}

//미현_컨텐츠 구매
function goBannBuy(userSeq,restSeq,contentType){
	var cnt =0;
	var chkboxArr = document.getElementsByName("restSeq");
	
	 var selectContentType = document.getElementById("selectContentType");
	 selectContentType.value = contentType;
	
	for(var i=0; i<chkboxArr.length; i++) {
		if(chkboxArr[i].checked == true) { //체크되었습니까.?
			cnt++;
			//alert(cnt);
		}
		else {//장바구니에서 체크가 안된 제품은 주문하기를 해주면 안된다.
			  //서브밋 대상에서 제외시키면 된다.
			  chkboxArr[i].disabled = true;
		}// end of ------------------------------
	}
	if(cnt==0){ //모두 체크가 안된경우
		alert("주문하실 사업장 하나 이상 선택하세요!!");
		for(var i=0; i<chkboxArr.length; i++){
			//활성화 하여라.
			chkboxArr[i].disabled = false;
		}
		return;
	}
	else {//적어도 1개 이상은 체크가 된 경우
		var bannFrm = document.bannFrm;
		bannFrm.action="bossBannBuy.eat";
		bannFrm.method="POST";
		
		var bool = confirm("컨텐츠 구매 하시겠습니까 ?");
		if(bool) {
			bannFrm.submit();
		}
	}
}
</script>

	<div class="subleftCon" style="height:900px;">
		<h2>사업자 코인 충전</h2>
	</div>
	<div class="subrightCon" style="height:900px;">
	<jsp:include page="../userMyPage_Menubar.jsp" />
		<ul class="coinWrap">
			<li class="first">
				<dl class="coinDetail">
					<dt><span class="point">01</span> 코인 결제하기</dt>
					<dd>
						<p class="desc">컨텐츠를 구매하시려면 코인을 결제하셔야 합니다.<br/><span style="font-size:12px;">※</span> 코인은 100만원 단위부터 충전 가능합니다.<br/>(코인금액에 10% 포인트 충전)</p>
						<button class="btnCoin" type="button" onClick="goCoinBuy('${userSeq}');">포인트 충전</button>
					</dd>
				</dl>
			</li>
			<form name="bannFrm" id="bannFrm" method="post" style="margin-top:20px;">
				<li>
					<dl id="bossInfo"  class="coinDetail coinBg02" style="margin-bottom:20px;">
					<!-- 사업장 정보 -->
						<dt><span class="point">02</span> 사업장 선택하기</dt>
						<dd>
							<p class="desc">사업자가 가지고 있는 사업장을 선택하세요.<br/>※ 사업장은 한곳만 선택 가능합니다. </p>
						<c:forEach var="vo" items="${list}" varStatus="status">
							<input type="radio" name="restSeq" id="restSeq${status.count}" value="${vo.RESTSEQ}" /><label for="restSeq${status.count}">${vo.RESTNAME}</label>&nbsp;
						</c:forEach>
						</dd>
					</dl>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" />
				</li>
				<li style="height:90px; border-bottom:0; margin-bottom:0;">
					<dl class="coinDetail coinBg03" >
						<dt><span class="point">03</span> 컨텐츠 구입하기</dt>
						<dd>파워배너,파워링크,추천광고를 구입한다.</dd>
					</dl>
				</li>
				<li class="last">
					<b>파워배너</b>  :&nbsp; <button class="btnCoin" type="button" name="bannCoin" onClick="goBannBuy('${userSeq}','${restSeq}', 'banner');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 메인페이지에 광고 입니다. (100만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" />
					<input type="hidden" name="contentType1" id="linkRestSeq" value="banner" />  
				
					<b>파워링크</b>  :&nbsp; <button class="btnCoin" type="button" name="linkCoin"  onClick="goBannBuy('${userSeq}','${restSeq}', 'link');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 검색시 최상위에 따로 보여주는 컨텐츠 입니다.(50만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
					<input type="hidden" name="contentType2" id="linkRestSeq" value="link" /> 				
				
					<b>추천광고</b> :&nbsp; <button class="btnCoin" type="button" name="recomCoin" onClick="goBannBuy('${userSeq}','${restSeq}','rcom');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 추천메뉴로 보여주는 컨텐츠입니다. (30만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
					<input type="hidden" name="contentType3"  id="recomRestSeq" value="rcom" /> 
				</li>
				<input type="hidden" name="selectContentType"  id="selectContentType" value="" />	
			</form>
		</ul>
	</div>

<jsp:include page="../footer.jsp" />