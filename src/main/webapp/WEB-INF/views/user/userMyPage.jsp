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
<style>
.gradeFontSize {color:#008968; font-size:20px; font-stretch:narrower; font-weight: bold; text-align: center;}
.gradeFontThSize {style="color: red; font-size:12px; font-stretch:narrower; font-weight: bold;}
.tableAlign {text-align: center;}
</style>

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
	
});// end of ready

function getCouponList(pageNum){
		
	$.ajax({	
		url:"<%= request.getContextPath() %>/couponList.eat",
	    type:"GET",
	    data : "pageNum="+pageNum,
		datatype:"html", 
		success:function(data){ 
			$("#userInfo").html(data);
		}
	});
}

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


function userRandomBox(){
	$.ajax({	
		url:"<%= request.getContextPath() %>/userRandomBox.eat",
	    type:"GET",
		datatype:"html", 
		success:function(data){ 
			$("#userInfo").html(data);
		}
	});
}

function userCoupon(boxType){
	$.ajax({	
		url:"<%=request.getContextPath() %>/userCoupon.eat",
	    method:"GET",
	    data:"boxType=" + boxType,
	    datatype:"html",
		success:function(data){
			alert(data);
			location.reload();
		}
	});
}

function getMyReviewList(startPageNo){ 
	     
		$.ajax({	
			url:'/mazzipmetro/myReviewList.eat?pageNo='+startPageNo,
		    type:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			},
			error: function(request, status, error){
		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
}// end of myReviewList
	
function getMyQnAList(qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd ,qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaProgress){
		if(Number(qnaRegDayStart)<10){
			qnaRegDayStart = "0"+qnaRegDayStart;
		}

		$.ajax({	
			url:'/mazzipmetro/myQnaList.eat?qnaRegYearStart='+qnaRegYearStart+'&qnaRegMonthStart='+qnaRegMonthStart+'&qnaRegDayStart='+qnaRegDayStart+'&qnaRegYearEnd='+qnaRegYearEnd+'&qnaRegMonthEnd='+qnaRegMonthEnd+'&qnaRegDayEnd='+qnaRegDayEnd+'&qnaInquiry='+qnaInquiry+'&startPageNo='+startPageNo+'&qnaProgress='+qnaProgress,
		    method:"GET",
			datatype:"html", 
			success:function(data){
				alert("getMyQnAList전");
				$("#userInfo").html(data);
				alert("getMyQnAList후");
			}
		});
}// end of getMyQnAList
	
function SgetMyQnAList(qnaRegYearStart, qnaRegMonthStart, qnaRegDayStart, qnaRegYearEnd ,qnaRegMonthEnd, qnaRegDayEnd, qnaInquiry, startPageNo, qnaColName, qnaSearch, qnaProgress){
		$.ajax({	
			url:'/mazzipmetro/myQnaList.eat?qnaRegYearStart='+qnaRegYearStart+'&qnaRegMonthStart='+qnaRegMonthStart+'&qnaRegDayStart='+qnaRegDayStart+'&qnaRegYearEnd='+qnaRegYearEnd+'&qnaRegMonthEnd='+qnaRegMonthEnd+'&qnaRegDayEnd='+qnaRegDayEnd+'&qnaInquiry='+qnaInquiry+'&startPageNo='+startPageNo+'&qnaColName='+qnaColName+'&qnaSearch='+qnaSearch+'&qnaProgress='+qnaProgress,
			method:"GET",
			datatype:"html", 
			success:function(data){ 
				$("#userInfo").html(data);
			}
		});
}// end of getMyQnAList



</script>
<!-- 미현_칭호 붙이기에 쓰이는 css -->
<style type="text/css">
	.gradeDetail {overflow:hidden;}
	.gradeDetail li {float:left; position:relative; height:70px; font-weight:bold;}
	.gradeDetail li span {display:block; padding-left:7px; font-size:8px;} 
	.gradeDetail li.icoMaster {width:57px;  padding-top:25px; background:url(/mazzipmetro/resources/images/icoMaster.png) no-repeat;}
	.gradeDetail li.icoNovice {width:57px; padding-top:18px; background:url(/mazzipmetro/resources/images/icoNovice.png) no-repeat;}
	.gradeDetail li.icoNovice span.twist {-ms-transform: rotate(-10deg); /* IE 9 */-webkit-transform: rotate(-10deg); /* Chrome, Safari, Opera */  transform: rotate(-10deg);}
	.gradeDetail li.icoSkill {width:65px; padding-top:21px; font-size:7px; font-weight:bold; background:url(/mazzipmetro/resources/images/icoSkilled.png) no-repeat;}
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
		
		<td width="13%"><span>등급</span>  <a data-toggle="modal" data-target="#gradeInfoModal" style="cursor: pointer;"><i class="material-icons">help_outline</i></a></td>
		<td width="13%"> ${sessionScope.loginUser.gradeName}
			<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG5' and sessionScope.loginUser.userExp >= 5000}">
				<img style="cursor: pointer;" src="<%= request.getContextPath() %>/files/LevelUp.png" width="45px" height="30px" onclick="javascript:location.href='<%=request.getContextPath() %>/updateUserGrade.eat?gradeSeq=UG6'"/>			
			</c:if>
			<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG6' and sessionScope.loginUser.userExp >= 10000}">
				<img style="cursor: pointer;" src="<%= request.getContextPath() %>/files/LevelUp.png" width="45px" height="30px" onclick="javascript:location.href='<%=request.getContextPath() %>/updateUserGrade.eat?gradeSeq=UG7'"/>
			</c:if>
		 </td>
		
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
		<td><a href="#" onClick = "getCouponList(1);">쿠폰</a></td>
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
		<td><a href="<%= request.getContextPath() %>/couponList.eat">쿠폰</a></td>
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

<!-- 회원가입을 위한 Modal -->
  <div class="modal fade" id="gradeInfoModal" role="dialog" >
    <div class="modal-dialog  modal-lg" style="width:1300px; text-align: center;">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title"><span class="gradeFontSize">회원등급안내</span></h4>
        </div>
        <div class="modal-body" align="center">
          <table class="table tableAlign">
          	<tr style="border-top-width:4px; border-style:double;">
          		<th width="130px" rowspan="2"> 회원등급 </th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade01.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade02.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade03.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade04.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade05.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade06.png"></th>
          		<th width="130px" style="text-align: center"><img src="<%= request.getContextPath() %>/resources/images/icoUserGrade07.png"></th>
          	</tr>
          	<tr style="border-bottom-width:4px; border-style:double;">
          		<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">흙수저</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">구리수저</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">은수저</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">금수저</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">다이아수저</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">달인</th>
				<th style="font-size:14px; font-stretch:narrower; font-weight: bold; text-align: center;">신</th>
          	</tr>
			<tr>	
				<th class="gradeFontThSize">회원등급 조건</th>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">기본등급</td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 200 이상</td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 750 이상</td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 1200 이상</td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 3500 이상</td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 5000 이상 <br> 동,역 마스터 각각 5개씩 + 1500 마일리지 소모 </td>
				<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">EXP 10000 이상 <br> 구 마스터 1개 + 3000 마일리지 소모 </td>
          	</tr>
          	<tr>
          		<th>회원혜택</th>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">-</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">랜덤박스 1개 지급</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">랜덤박스 1개 <br>프리미엄박스 1개 지급</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">프리미엄박스 2개 지급</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">프리미엄박스 6개 지급</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">한달에 프리미엄박스 1개 지급</td>
          		<td style="font-size:12px; font-stretch:narrower; font-weight: bold; text-align: center;">한달에 프리미엄박스 3개 지급</td>
          	</tr>
          </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
      
    </div>
  </div>
</div>
</body>
</html>
<jsp:include page="../footer.jsp" />