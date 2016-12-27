<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table.tblRankingView {
	     height : 20px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	table.tblRankingView th {
		 font-size: 30pt;
		 text-align: left;
		 vertical-align: middle;
	}
	
	.contArea{display:inline; float:left; width:250px; margin:10px 0 10px 25px; border: solid 1px #e8e8e8;}
	.contArea .restList ul li{display:inline-block; float:left; border-bottom:1px solid #e7e7e7; padding:20px 0; width:100%; }
	.contArea .restList ul li h2{display:block; font-family:굴림, Gulim; font-size:20px; padding:0 0 10px 0; margin-left : 10px;}
	.contArea .restList ul li h2 a:hover{text-decoration:underline;}
	.contArea .restList ul li h2 img{vertical-align:middle; padding-right:5px;}
	.contArea .restList ul li h2 .part{font-weight:normal; font-size:12px; margin:0 0 0 5px;}
	
	.contArea .restList ul li .photoDiv{display:inline-block; float:left; width:250px;}
	.contArea .restList ul li .textDiv{display:inline-block; width:250px; margin-left : 10px;}
	.contArea .restList ul li .textDiv dl dd.summary{line-height:2em;}
	.contArea .restList ul li .textDiv dl dd.summary a:hover{text-decoration:underline;}
</style>

<table class = "tblRankingView">
	<tr>
		<th width = "550px;"><span style = "font-size : 20pt;">최고의 리뷰어가 추천하는 맛집</span></th>
	</tr>
	<tr style = "border: solid 1px black;">
		<th width = "1080px;" ></th>
	</tr>
</table>

<c:forEach var = "rest" items = "${restList}" varStatus="status">
	<div class = "contArea">
		<div class = "restList">
			<ul>
				<li>
					<c:set value="${status.index}" var="index" />
					<c:forEach var = "user" items = "${userList}" varStatus = "userStatus">
						<c:if test="${userStatus.index == index}">
							<h2><img width="50px;" src="<%= request.getContextPath() %>/files/user/${user.userProfile}" />${user.userName}
						</c:if>
					</c:forEach>
					<c:forEach var = "review" items = "${reviewList}" varStatus = "reviewStatus">
						<c:if test="${reviewStatus.index == index}">
							<span style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) -1px 0px;	FLOAT: right;	PADDING-BOTTOM: 0px;	MARGIN-Right: 25px; MARGIN-TOP: 15px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
								<p style="WIDTH:${review.reviewAvgScore * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 1px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
								</p>
							</span> 
						</c:if>
					</c:forEach>
						</h2>
					<div class="photoDiv">
						<div>
							<a href = "<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${rest.restSeq}">
								<img width="248px;" src="<%= request.getContextPath() %>/files/rest/${rest.restImg}" />
							</a>
						</div>
					</div>
					<div class="textDiv" style = "margin-top : 15px; clear:both; ">
						<dl>
							<dd class="summary"><span style = "font-size : 15pt;">${rest.restName}</span><br/><span style = "font-size : 15pt;">${rest.restBgTag}</span></dd>
							<dd class="summary"><span style = "font-size : 8pt;">${rest.restAddr}</span></dd>
						</dl>
					</div>
				</li>
			</ul>
		</div>
	</div>
</c:forEach>