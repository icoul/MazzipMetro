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
	
	restList();
	
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

function restList(){
	$.ajax({	
		url:"<%= request.getContextPath() %>/myPageRestList.eat",
	    type:"GET",
		datatype:"html", 
		success:function(data){ 
			$("#restList").html(data);
		}
	});
}

</script>
<!-- 미현_칭호 붙이기에 쓰이는 css -->
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
	.aliasOn {cursor:pointer;}
	.aliasInfo {display:none; width:100px; margin-top:5px; padding:10px; font-size:11px; color:#666; border:1px solid #048a6a;}
	.aliasOn:hover .aliasInfo{display:block;}
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
		<td rowspan="2" colspan="2" align="center" width="22%">
			<c:if test="${sessionScope.loginUser.gradeName eq '흙수저'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade01.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '구리수저'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade02.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '은수저'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade03.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '금수저'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade04.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '다이아수저'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade05.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '달인'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade06.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '신'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade07.png">
			</c:if>
		</td>
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
	<%-- <c:if test="${userGuAliasList !=null or userDongAliasList !=null or userMetroAliasList !=null or userRestTagAliasList !=null}"> --%>
	<c:if test="${not empty userGuAliasList or not empty userDongAliasList or not empty userMetroAliasList or not empty userRestTagAliasList}">
		<tr>
			<td rowspan="4" width="11%">획득한 칭호 
				<span class="aliasOn"><img src="<%= request.getContextPath() %>/resources/images/icoQuest.png">
					<ul class="aliasInfo">
						<li>입문자 &nbsp;&nbsp;<img src="<%= request.getContextPath() %>/resources/images/icoNovice.png" width="20" height="20"></li>
						<li>숙련자 &nbsp;&nbsp;<img src="<%= request.getContextPath() %>/resources/images/icoSkilled.png" width="20" height="20"></li>
						<li>마스터 &nbsp;&nbsp;<img src="<%= request.getContextPath() %>/resources/images/icoMaster.png" width="15" height="15"></li>
					</ul>
				</span>
				
			</td>
			<td width="11%">구별</td>
			<td colspan="6">
				<ul class="gradeDetail">
					<c:forEach var="map" items="${userGuAliasList}" varStatus="stauts">
						<c:if test="${map.aliasName eq '마스터'}">
							<li class="icoMaster"><span>${map.guName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '입문자'}">
							<li class="icoNovice"><span class="twist">${map.guName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '숙련자'}">
							<li class="icoSkill"><span>${map.guName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</td>
		</tr>
		<tr>
			<td>동별</td>
			<td colspan="6">
				<ul class="gradeDetail">
					<c:forEach var="map" items="${userDongAliasList}" varStatus="stauts">
						<c:if test="${map.aliasName eq '마스터'}">
							<li class="icoMaster"><span>${map.dongName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '입문자'}">
							<li class="icoNovice"><span class="twist">${map.dongName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '숙련자'}">
							<li class="icoSkill"><span>${map.dongName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</td>
		</tr>
		<tr>
			<td>역별</td>
			<td colspan="6">
				<ul class="gradeDetail">
					<c:forEach var="map" items="${userMetroAliasList}" varStatus="stauts">
						<c:if test="${map.aliasName eq '마스터'}">
							<li class="icoMaster"><span>${map.metroName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '입문자'}">
							<li class="icoNovice"><span class="twist">${map.metroName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '숙련자'}">
							<li class="icoSkill"><span>${map.metroName}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</td>
		</tr>
		<tr>
			<td>태그별</td>
			<td colspan="6">
				<ul class="gradeDetail">
					<c:forEach var="map" items="${userRestTagAliasList}" varStatus="stauts">
						<c:if test="${map.aliasName eq '마스터'}">
							<li class="icoMaster"><span>${map.aliasId}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '입문자'}">
							<li class="icoNovice"><span class="twist" style="padding-left:15px;">${map.aliasId}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
						<c:if test="${map.aliasName eq '숙련자'}">
							<li class="icoSkill"><span style="padding-left:18px;">${map.aliasId}</span><span class="detail">${map.aliasName}</span></li>
						</c:if>
					</c:forEach>
				</ul>
			</td>
		</tr>
		</c:if>
</table>
</c:if>

<c:if test = "${sessionScope.loginUser.userSort == 1}">
<table class="table">
	<tr>
		<th colspan="8">
		${(sessionScope.loginUser).userName} 님의 정보</th>
	</tr>
	<tr>
		<td rowspan="2" colspan="2" align="center" width="22%">
			<c:if test="${sessionScope.loginUser.gradeName eq '초가집'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade01.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '황토집'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade02.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '기와집'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade03.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '왕궁'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade04.png">
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeName eq '황궁'}">
				<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade05.png">
			</c:if>
		</td>
		
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

<div id = "restList">

</div>
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