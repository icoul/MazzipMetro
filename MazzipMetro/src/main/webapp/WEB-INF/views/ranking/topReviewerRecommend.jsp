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
	
	.contArea{display:inline; float:left; width:100%; margin:10px 0 10px 10px;}
	.contArea .restList ul li{display:inline-block; float:left; border-bottom:1px solid #e7e7e7; padding:20px 0; width:100%; }
	.contArea .restList ul li h2{display:block; font-family:굴림, Gulim; font-size:20px; padding:0 0 10px 0;}
	.contArea .restList ul li h2 a:hover{text-decoration:underline;}
	.contArea .restList ul li h2 img{vertical-align:middle; padding-right:5px;}
	.contArea .restList ul li h2 .part{font-weight:normal; font-size:12px; margin:0 0 0 5px;}
	
	.contArea .restList ul li .photoDiv{float:left; width:55px;}
	.contArea .restList ul li .textDiv{float:right; width:585px;}
	.contArea .restList ul li .textDiv dl dd.summary{background:url('/image/common/img_dot.gif') repeat-x left bottom; padding:15px 0; line-height:1.5em;}
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


<div class = "contArea">
	<div class = "restList">
		<ul>
			<li>
				<h2><img width="50px;" src="<%= request.getContextPath() %>/files/user/thumb/thumb${uservo.userProfile}" />${uservo.userName}님의 추천맛집입니다.
					<span style="CLEAR: both;	PADDING-RIGHT: 0px;	PADDING-LEFT: 0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star2.gif) -1px 0px;	FLOAT: right;	PADDING-BOTTOM: 0px;	MARGIN-Right: 470px; MARGIN-TOP: 15px;	WIDTH: 90px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
						<p style="WIDTH: ${reviewvo.reviewAvgScore * 20}%; PADDING-RIGHT:0px;	PADDING-LEFT:0px;	BACKGROUND: url(<%= request.getContextPath() %>/resources/images/icon_star.gif) 1px 0px;	PADDING-BOTTOM: 0px;	MARGIN: 0px;	PADDING-TOP: 0px;	HEIGHT: 18px;">
						</p>
					</span> 
				    <br/><br/> ${reviewvo.reviewContent} 
				    
					</h2>
				<div class="photoDiv" style = "margin-top : 20px;">
					<div><img width="200px;" src="<%= request.getContextPath() %>/files/rest/${restvo.restImg}" /></div>
				</div>
				<div class="textDiv" style = "margin-top : 20px;">
					<dl>
						<dd class="summary"><span style = "font-size : 25pt;">${restvo.restName}</span>.&nbsp;&nbsp;&nbsp;<span style = "font-size : 15pt;">${restvo.restBgTag}</span></dd>
						<dd class="summary"><span style = "font-size : 15pt;">${restvo.restAddr}</span></dd>
						<dd class="summary"><a href = "<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${restvo.restSeq}"><span style = "color : black;">${restvo.restContent}</span></a></dd>
						<dd class="summary">
							<c:forEach var = "image" items = "${adImage}">
								<img width="50px;" src="<%= request.getContextPath() %>/files/rest/thumb/thumb${image}" />&nbsp;
							</c:forEach>
						</dd>
					</dl>
				</div>
			</li>
		</ul>
	</div>
</div>
