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


</head>
<body>
<div class="subleftCon" style="height:auto; font-size:25px;">
	<h2>My Zone</h2>
</div>
<div align="center" class="subrightCon" style="height:2500px;">
<jsp:include page="../userMyPage_Menubar.jsp" />

<c:if test = "${sessionScope.loginUser.userSort == 0}">
<table class="table">
	<tr>
		<th colspan="6">
		${(sessionScope.loginUser).userName} 님의 정보</th>
	</tr>
	<tr>
		<td rowspan="2">등급</td>
		<td>정복한 맛집</td>
		<td>${reviewCount}</td>
		<td>문의건수(답변완료)</td>
		<td>${qnaCount}</td>
	</tr>
	<tr>
		<td>마일리지</td>
		<td><fmt:formatNumber pattern="###,###" value="${userPoint}" /> POINT</td>
		<td><a href="<%= request.getContextPath()%>/couponList.eat">쿠폰</a></td>
		<td>${coupon}</td>
	</tr>
</table>
<table class = "table">
	
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
		<td><fmt:formatNumber pattern="###,###" value="${userPoint}" /> POINT </td>
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
<div id="userInfo" style="margin-top:60px; position: relative;">
</div>

<div id="statistics">

</div>
</div>
</body>
</html>