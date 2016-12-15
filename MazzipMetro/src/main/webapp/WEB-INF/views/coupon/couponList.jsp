<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />

<style>
	.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
	.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
	.subrightCon {float:left; width:70%; height:auto; border-right:1px solid #dbdbdb; padding-bottom:40px;}
	.subrightCon .searchWrap {padding-top:10px; text-align:center;}
	
	.table {
	     width: 100%;
	     height : 20px;
	     border: solid gray 1px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	th#th {
		 background-color: silver;
		 font-size: 13pt;
	}
	
	.table tr {
		border: solid gray 1px;
		vertical-align : middle;
	}
	
	.table td {
		padding-left : 20px;
		padding-top : 10px;
		padding-bottom : 10px;
		border: solid gray 1px;
		vertical-align : middle;
	}
	
	.table td.couponBuy {
		padding-left : 20px;
		padding-top : 10px;
		padding-bottom : 10px;
		border: solid gray 1px;
		vertical-align : middle;
		border-left-width: 0px;
		border-right-width: 0px;
	}
	
</style>

<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type = "text/javascript">
	$(document).ready(function(){
		$("#couponNum").change(function(){
			getBuyResult();
		});
	});
	
	function goNextPage(pageNum){
		location.href = "<%=request.getContextPath()%>/couponList.eat?pageNum="+pageNum;
	}
	
	function getBuyResult(){
				
		var userPoint = "${loginUser.userPoint}";
		var couponNum = $("#couponNum").val();
		
		var needPoint = couponNum*1000;
		var remainPoint = userPoint-couponNum*1000;
		var html = "";
		
		$("#needPointView").text(needPoint+" 포인트");
		
		if (remainPoint < 0) {
			html += "<span style = 'color:red; font-weight:bold;'>"+remainPoint+"</span> 포인트"
		}
		if (remainPoint > 0) {
			html += "<span style = 'color:blue; font-weight:bold;'>"+remainPoint+"</span> 포인트"
		}
		
		$("#remainPointView").html(html);
		$("#remainPoint").val(remainPoint);
	}
	
	function couponBuy(){
		
		var remainPoint = $("#remainPoint").val();
		var myRest = $("#myRest").val();
		var couponNum = $("#couponNum").val();
		
		if (myRest == "-1") {
			alert("맛집을 선택해주세요");
			document.preventDefault();
		}
		
		if (couponNum == "0") {
			alert("쿠폰 갯수를 선택해주세요");
			document.preventDefault();
		}
		
		if (remainPoint < 0) {
			alert("포인트가 부족합니다");
			document.preventDefault();
		}
		
		var couponBuyFrm = document.couponBuyFrm;
		couponBuyFrm.submit();
		
	}
	
</script>

<div class="subleftCon" style="height:auto; font-size:25px;">
<h2>쿠폰</h2>
</div>

<div class="subrightCon" style="height:2500px;">
<jsp:include page="../userMyPage_Menubar.jsp" />


	<c:if test="${couponList == null || empty couponList}">
		<table class = "table">
			<tr style = "border-left-width: 0px; border-right-width: 0px; background-color: lightgrey;">
				<td class="couponBuy" colspan = "5" align="left" style = "font-size : 15pt;">쿠폰 리스트</td>
			</tr>
			<tr>
				<td width="80%" colspan="4" align="center">
					쿠폰이 존재하지 않습니다
				</td>
			</tr>
		</table>
	</c:if>
	
	<c:if test="${couponList != null && not empty couponList && (userSort == 0 || userSort == 2)}">
		<table class = "table">
			<tr>
				<th width="20%" style = "font-size : 14pt;"><b>쿠폰번호</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>발행 맛집명</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>쿠폰 발행일</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>유효기간</b></th>
			</tr>
			<c:forEach var="list" items="${couponList}" begin="${pageNum*pageBar-pageBar}" end="${pageNum*pageBar-1}">
				<tr>
					<td width="20%" align="center">${list.couponSeq}</td>
					<td width="20%" align="center"><a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">${list.restName}</a></td>
					<td width="20%" align="center">${list.couponRegDate}</td>
					<td width="20%" align="center">${list.couponExpiryDate}</td>
				</tr>
			</c:forEach>
			<tr>
				<td>${html}</td>
			</tr>
		</table>
	</c:if>
	
	<c:if test="${couponList != null && not empty couponList && userSort == 1}">
		<table class = "table">
			<tr>
				<th width="20%" style = "font-size : 14pt;"><b>쿠폰번호</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>발행 맛집명</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>쿠폰 발행일</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>유효기간</b></th>
				<th width="20%" style = "font-size : 14pt;"><b>쿠폰상태</b></th>
			</tr>
			<c:forEach var="list" items="${couponList}" begin="${pageNum*pageBar-pageBar}" end="${pageNum*pageBar-1}">
				<tr>
					<td width="20%" align="center">${list.couponSeq}</td>
					<td width="20%" align="center"><a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">${list.restName}</a></td>
					<td width="20%" align="center">${list.couponRegDate}</td>
					<td width="20%" align="center">${list.couponExpiryDate}</td>
					<td width="20%" align="center">
						<c:if test="${list.couponStatus == 0}" >발매완료</c:if>
						<c:if test="${list.couponStatus == 1}" ><span style = "color : blue; font-weight: bold;">유저획득완료</span></c:if>
						<c:if test="${list.couponStatus == 2}" ><span style = "color : red; font-weight: bold;">사용완료</span></c:if>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td>${html}</td>
			</tr>
		</table>
	</c:if>
<form name="couponBuyFrm" action="couponBuy.eat" method="post">	
	<table class = "table">
		<tr style = "border-left-width: 0px; border-right-width: 0px; background-color: lightgrey;">
			<td class="couponBuy" colspan = "7" align="left" style = "font-size : 15pt;">쿠폰 발행</td>
		</tr>
		<tr style = "border-left-width: 0px; border-right-width: 0px; height : 50px;">
			<td width="10%" class="couponBuy" style = "font-size : 12pt;"><b>맛집 선택</b></td>
			<td width="15%" class="couponBuy" style = "font-size : 12pt;">
				<select name="myRest" id="myRest">
						<option value="-1">맛집을 선택해주세요</option>
					<c:forEach var="list" items="${restList}">
						<option value="${list.restSeq},${list.metroId}">${list.restName}</option>
					</c:forEach>
				</select>
			</td>
			<td width="3%" class="couponBuy" style = "font-size : 12pt; padding-right : 40px;"><b>|</b></td>
			<td width="10%" class="couponBuy" style = "font-size : 12pt;"><b>발행매수</b></td>
			<td width="15%" class="couponBuy" style = "font-size : 12pt;">
				<select name="couponNum" id="couponNum">
					<option value="0">갯수를 선택해주세요</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
			</td>
			<td width="3%" class="couponBuy" style = "font-size : 12pt; padding-right : 40px;"" align = "center"><b>|</b></td>
			<td width="15%" class="couponBuy" style = "font-size : 12pt;">
				<button type = "button" onClick="couponBuy();" ><b>쿠폰 발행</b></button>
			</td>
		</tr>
		<tr style = "border-left-width: 0px; border-right-width: 0px;">
			<td class="couponBuy" colspan = "1"></td>
			<td class="couponBuy" style = "padding-left : 250px;" colspan = "3">
				보유 포인트 : <b>${loginUser.userPoint}</b> 포인트
				<input type="hidden" name = userPoint value="${loginUser.userPoint}" />
			</td>
			<td class="couponBuy" colspan = "1">
				필요 포인트 : <span id="needPointView"></span>
			</td>
			<td class="couponBuy" colspan = "2">
				잔액 : <span id="remainPointView"></span>
				<input type="hidden" id = remainPoint value="" />
			</td>
		</tr>
	</table>
	
</form>
</div>

<jsp:include page="../footer.jsp" />