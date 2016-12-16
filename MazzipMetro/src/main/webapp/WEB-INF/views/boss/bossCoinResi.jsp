<%@page import="com.go.mazzipmetro.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<jsp:include page="../top.jsp" />
<jsp:include page="../library.jsp" />
<style type="text/css">
* { padding:0; margin:0;}
input[type=radio] {vertical-align:-2px;}
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {font-size:20px;  width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
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
$(document).ready(function(){
	var restSeqArr = document.getElementsByName("restSeq");
	alert($("#restSeq").checked.value());
});

function goCoinBuy(userSeq){
	//코인 결제하기 팝업창 띄우기
	var url = "bossCoinChar.eat?userSeq="+userSeq;
	window.open(url, "bossCoinChar", "left=350px, top=100px, width=350px, height=300px, status=no, scrollbars=yes");		
}

function goBannBuy(userSeq,restSeq,contentType){
	var cnt =0;
	var chkboxArr = document.getElementsByName("restSeq");
	
	 var selectContentType = document.getElementById("selectContentType");
	 selectContentType.value = contentType;
	
	for(var i=0; i<chkboxArr.length; i++) {
		if(chkboxArr[i].checked == true) { //체크되었습니까.?
			cnt++;
			alert(cnt);
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
		
		var bool = confirm("파워배너 결제하시겠습니까 ?");
		if(bool) {
			bannFrm.submit();
		}
	}
}

/* function goLinkBuy(userSeq,restSeq) {
	var chkboxArr = document.getElementsByName("restSeq");
	var cnt =0;
	
	for(var i=0; i<chkboxArr.length; i++) {
		if(chkboxArr[i].checked == true) { //체크되었습니까.?
			cnt++;
			//alert(cnt);
		} else {//체크가 안된 것은 구매하기를 해주면 안된다.
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
	} else {//적어도 1개 이상은 체크가 된 경우
		
		var linkFrm = document.linkFrm;
		linkFrm.action="bossLinknBuy.eat";
		linkFrm.method="POST";
		
		var bool = confirm("파워링크 결제하시겠습니까 ?");
		if(bool) {
			linkFrm.linkRestSeq.value = $("#bannFrm [name=restSeq]").val();
			//alert("linkFrm.linkRestSeq.value ="+linkFrm.linkRestSeq.value);
			linkFrm.submit();
			
		}
	}
}


function goRecomBuy(userSeq,restSeq) {
	var chkboxArr = document.getElementsByName("restSeq");
	var cnt =0;
	
	for(var i=0; i<chkboxArr.length; i++) {
		if(chkboxArr[i].checked == true) { //체크되었습니까.?
			cnt++;
			//alert(cnt);
		} else {//체크가 안된 것은 구매하기를 해주면 안된다.
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
	} else {//적어도 1개 이상은 체크가 된 경우
	
	var rcomFrm = document.rcomFrm;
		rcomFrm.action="bossRecomBuy.eat";
		rcomFrm.method="POST";
		
		
		var bool = confirm("추천광고 결제하시겠습니까 ?");
		if(bool) {
			rcomFrm.recomRestSeq.value = $("#bossInfo [name=restSeq]").val();
			alert("rcomFrm.recomRestSeq.value ="+rcomFrm.recomRestSeq.value);
			rcomFrm.submit();
			
		}
	} */


</script>

	<div class="subleftCon">
		<h2>사업자 코인 충전</h2>
	</div>
	<div class="subrightCon">
	<jsp:include page="../userMyPage_Menubar.jsp" />
		<ul class="coinWrap">
			<li class="first">
				코인 결제하기 : <button class="btnCoin" type="button" onClick="goCoinBuy('${userSeq}');">코인 충전</button>
				<p class="desc"><span style="font-size:12px;">※</span> 코인은 100만원 단위부터 충전 가능합니다.</p>
			</li>
			<li>
				<form name="bannFrm" id="bannFrm" method="post" style="margin-top:20px;">
					<div id="bossInfo" style="overflow:hidden; margin-bottom:20px;">
					<!-- 사업장 정보 -->
						<b>사업장 선택</b> :&nbsp;&nbsp;
						<c:forEach var="vo" items="${list}" varStatus="status">
							<input type="radio" name="restSeq" id="restSeq${status.count}" value="${vo.RESTSEQ}" /><label for="restSeq${status.count}">${vo.RESTNAME}</label>&nbsp;
						</c:forEach>
					</div>
				<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" />
				
					<b>파워배너</b>  : <button class="btnPoint" type="button" name="bannCoin" onClick="goBannBuy('${userSeq}','${restSeq}', 'banner');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 메인페이지에 광고 입니다. (100만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" />
					<input type="hidden" name="contentType1" id="linkRestSeq" value="banner" />  
				
				
					<b>파워링크</b>  : <button class="btnPoint" type="button" name="linkCoin"  onClick="goBannBuy('${userSeq}','${restSeq}', 'link');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 검색시 최상위에 따로 보여주는 컨텐츠 입니다.(50만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
					<input type="hidden" name="contentType2" id="linkRestSeq" value="link" /> 				
				
				
					<b>추천광고</b> : <button class="btnPoint" type="button" name="recomCoin" onClick="goBannBuy('${userSeq}','${restSeq}','rcom');">포인트 결제</button>
					<p class="desc"><span style="font-size:12px;">※</span> 추천메뉴로 보여주는 컨텐츠입니다. (30만 포인트)</p>
					<input type="hidden" name="userSeq"  value="${sessionScope.loginUser.userSeq}" /> 
					<input type="hidden" name="userPoint" value="${sessionScope.loginUser.userPoint}" /> 
					<input type="hidden" name="contentType3"  id="recomRestSeq" value="rcom" /> 
					
					<input type="hidden" name="selectContentType"  id="selectContentType" value="" />	
				</form>
			</li>
		</ul>
	</div>

<jsp:include page="../footer.jsp" />