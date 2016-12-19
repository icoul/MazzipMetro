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
				$("#statistics").html(data);
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
	.gradeDetail li {float:left; height:130px; padding-right:5px;}
	.gradeDetail li span.icoMaster {display:block; height:87px; width:83px; padding:45px 0 0 13px; font-size:11px; font-weight:bold; background:url(http://localhost:9090/mazzipmetro/resources/images/icoMaster.png) no-repeat;}
	.gradeDetail li span.icoNovice {display:block; height:87px; width:83px;  font-weight:bold; background:url(http://localhost:9090/mazzipmetro/resources/images/icoNovice.png) no-repeat;}
	.gradeDetail li .icoNovice span.title {display:block; width:200px;  padding:24px 0 0 22px; -ms-transform: rotate(-10deg); /* IE 9 */-webkit-transform: rotate(-10deg); /* Chrome, Safari, Opera */  transform: rotate(-10deg); font-size:10px;}
	.gradeDetail li span.icoSkill {display:block; height:87px; width:83px; padding:35px 0 0 28px; font-size:11px; font-weight:bold; background:url(http://localhost:9090/mazzipmetro/resources/images/icoSkilled.png) no-repeat;}
	.gradeDetail li span.detail {display:block; padding-top:10px; font-size:13px; font-weight:bold;}
	.icoSkill {}
	.icoNovice {}
</style>

</head>
<body>
<div class="subleftCon" style="height:auto; font-size:25px;">
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
		<td colspan="6" style="height:130px;">
			<ul class="gradeDetail">
				<li><span class="icoMaster">강남구</span><span class="detail">강남구마스터</span></li>
				<li><span class="icoNovice"><span class="title">강남구</span></span><span class="detail">강남구마스터</span></li>
				<li><span class="icoSkill">강남구</span><span class="detail">강남구마스터</span></li>
				<li><span class="icoMaster">강남구</span><span class="detail">강남구마스터</span></li>
				<li><span class="icoNovice"><span class="title">강남구</span></span><span class="detail">강남구마스터</span></li>
				<li><span class="icoSkill">강남구</span><span class="detail">강남구마스터</span></li>
			</ul>
		</td>
	</tr>
	<tr>
	<td>동별</td>
	<td colspan="6"><img src="<%= request.getContextPath() %>/resources/images/icoMaster.png" width="61px" height="73px"><img src="<%= request.getContextPath() %>/resources/images/icoSkilled.png" width="61px" height="73px"><img src="<%= request.getContextPath() %>/resources/images/icoNovice.png" width="61px" height="73px"><img src="<%= request.getContextPath() %>/resources/images/icoMaster.png" width="61px" height="73px"><img src="<%= request.getContextPath() %>/resources/images/icoSkilled.png" width="61px" height="73px"><img src="<%= request.getContextPath() %>/resources/images/icoNovice.png" width="61px" height="73px"></td>
	</tr>
	<tr>
	<td>역별</td>
	<td colspan="6"><img src="<%= request.getContextPath() %>/resources/images/icoNovice.png" width="61px" height="73px"></td>
	</tr>
	<tr>
	<td>태그별</td>
	<td colspan="6"><img src="<%= request.getContextPath() %>/resources/images/img.png" width="61px" height="83px"></td>
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