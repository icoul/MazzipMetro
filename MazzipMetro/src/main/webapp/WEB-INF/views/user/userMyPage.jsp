<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>

<script type="text/javascript">

$(document).ready(function(){
	
	
	$("#btn_Mazzip").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/userRestMap.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#btn_userQna").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/myQnaList.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#btn_tagStatistics").click(function(){
		$.ajax({
			url:"<%= request.getContextPath() %>/tagStatistics.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#userCoupon").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/couponList.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});

	$("#userAlias").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/userAliasList.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#userEdit").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/userEdit.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#myReviewList").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/myReviewList.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
	
	$("#userRandomBox").click(function(){
		$.ajax({	
			url:"<%= request.getContextPath() %>/userRandomBox.eat",
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
	});
});

</script>
<style type="text/css">
	.gradeDetail {overflow:hidden;}
	.gradeDetail li {float:left; position:relative; height:70px; font-weight:bold;}
	.gradeDetail li span {display:block; padding-left:7px; font-size:8px;} 
	.gradeDetail li.icoMaster {width:57px;  padding-top:25px; background:url(http://localhost:9090/mazzipmetro/resources/images/icoMaster.png) no-repeat;}
	.gradeDetail li.icoNovice {width:57px; padding-top:18px; background:url(http://localhost:9090/mazzipmetro/resources/images/icoNovice.png) no-repeat;}
	.gradeDetail li.icoNovice span.twist {-ms-transform: rotate(-10deg); /* IE 9 */-webkit-transform: rotate(-10deg); /* Chrome, Safari, Opera */  transform: rotate(-10deg);}
	.gradeDetail li.icoSkill {width:65px; padding-top:21px; font-size:7px; font-weight:bold; background:url(http://localhost:9090/mazzipmetro/resources/images/icoSkilled.png) no-repeat;}
	.gradeDetail li.icoSkill span {padding-left:14px;}
	.gradeDetail li span.detail {position:absolute; width:50px; left:8px; bottom:0; padding-left:0; font-size:9px;}
</style>

</head>
<body>
<div class="subleftCon" style="height:1500px; font-size:25px;">
	<h2>My Zone</h2>
</div>
<div  class="subrightCon" style="height:auto;">
<jsp:include page="../userMyPage_Menubar.jsp" />

<c:if test = "${sessionScope.loginUser.userSort == 0}">
<table class="table">
	<tr>
		<th colspan="8">
		${(sessionScope.loginUser).userName} 님의 정보</th>
	</tr>
	<tr>
		<td rowspan="2" colspan="2" align="center" width="22%"><img src="<%= request.getContextPath() %>/resources/images/img.png" width="50px" height="50px"></td>
		<td width="13%">등급 </td>
		<td width="13%"> ${sessionScope.loginUser.gradeName} </td>
		
		<td width="13%">정복한 맛집</td>
		<td width="13%">${reviewCount}</td>
		<td width="13%">문의건수(답변완료)</td>
		<td width="13%">${qnaCount}</td>
	</tr>
	<tr>
		<td width="13%">Exp </td>
		<td> <span style="color: red;"><fmt:formatNumber pattern="#,###,###,###">${sessionScope.loginUser.userExp }</fmt:formatNumber>  
					
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG1'}">
						/ 200
					</c:if>
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG2'}">
						/ 750
					</c:if>
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG3'}">
						/ 1200
					</c:if>
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG4'}">
						/ 3500
					</c:if>
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG5'}">
						/ 5000
					</c:if>
					<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG6'}">
						/ 10000
					</c:if>
					</span>
		</td>
		<td width="">마일리지</td>
		<td><fmt:formatNumber pattern="###,###" value="${userPoint}" /></td>
		<td><a href="<%= request.getContextPath()%>/couponList.eat">쿠폰</a></td>
		<td>${coupon}</td>
	</tr>
	<tr>
		<td rowspan="4" width="11%">획득한 칭호</td>
		<td width="11%">구별</td>
		<td colspan="6">
			<ul class="gradeDetail">
				<li class="icoMaster"><span>강남구</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">서초구</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>성동구</span><span class="detail">숙련자</span></li>
				<li class="icoMaster"><span>영등포구</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">강북구</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>동작구</span><span class="detail">숙련자</span></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>동별</td>
		<td colspan="6">
			<ul class="gradeDetail">
				<li class="icoMaster"><span>역삼동</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">일원동</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>삼성동</span><span class="detail">숙련자</span></li>
				<li class="icoMaster"><span>서초동</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">대치동</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>압구정동</span><span class="detail">숙련자</span></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>역별</td>
		<td colspan="6">
			<ul class="gradeDetail">
				<li class="icoMaster"><span>강남역</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">서울역</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>교대역</span><span class="detail">숙련자</span></li>
				<li class="icoMaster"><span>서초역</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">선릉역</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>성수역</span><span class="detail">숙련자</span></li>
			</ul>
		</td>
	</tr>
	<tr>
		<td>태그별</td>
		<td colspan="6">
			<ul class="gradeDetail">
				<li class="icoMaster"><span>고기</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">물고기</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>야채</span><span class="detail">숙련자</span></li>
				<li class="icoMaster"><span>동남아</span><span class="detail">마스터</span></li>
				<li class="icoNovice"><span class="twist">양식</span><span class="detail">초보자</span></li>
				<li class="icoSkill"><span>중식</span><span class="detail">숙련자</span></li>
			</ul>
		</td>
	</tr>
</table>
</c:if>

<c:if test = "${sessionScope.loginUser.userSort == 1}">
<table class="table">
	<tr>
		<th colspan="4">
		${(sessionScope.loginUser).userName} 님의 정보</th>
	</tr>
	<tr>
		<td>포인트</td>
		<td><fmt:formatNumber pattern="###,###" value="${userPoint}" /></td>
		<td>매장수</td>
		<td>${restCount}</td>
	</tr>
	<tr>
		<td>유효한 컨텐츠 수</td>
		<td>${effectContent}</td>
		<td><a href="<%= request.getContextPath()%>/couponList.eat">쿠폰</a></td>
		<td>${coupon}</td>
	</tr>
	
</table>
</c:if>
<div id="userInfo" style="margin-top:60px; position: relative; height:auto;">
</div>

<div id="statistics">

</div>

<div style="height:160px;">
</div>

</div>
</body>
</html>
<jsp:include page="../footer.jsp" />