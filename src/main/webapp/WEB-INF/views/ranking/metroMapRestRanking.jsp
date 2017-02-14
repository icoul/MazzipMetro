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
	
	.contArea{display:inline-block; width:77%; margin:10px 0 0 0;}
	/*-- [dep] .contArea .restList{display:inline-block; float:left; width:725px; margin:-25px 0 0 0;}	//-- mainSec02로 대체 */
	.contArea .restList ul li{display:inline-block; float:left; border-bottom:1px solid #e7e7e7; padding:20px 0; width:100%; }
	.contArea .restList ul li h2{display:block; font-size:20px; padding:0 0 10px 0; vertical-align: middle;}
	.contArea .restList ul li h2 a{vertical-align: baseline;}
	.contArea .restList ul li h2 a:hover{text-decoration:underline;}
	.contArea .restList ul li h2 img{vertical-align:middle; padding-right:5px;}
	.contArea .restList ul li h2 .part{font-weight:normal; font-size:12px; margin:0 0 0 5px;}
	
	.contArea .restList ul li .photoDiv{float:left; width:135px;}
	.contArea .restList ul li .photoDiv .zoom{float:left; margin:2px 0 0 0;}
	.contArea .restList ul li .photoDiv .zoom img{width:202px; height:195px; vertical-align:top;}
	.contArea .restList ul li .photoDiv ul.thumbList{float:right; display:inline-block; margin:-2px 0 0 0; width:125px;}
	.contArea .restList ul li .photoDiv ul.thumbList li{float:left; width:59px; border-bottom:none; padding:2px 2px 0 0;}
	.contArea .restList ul li .photoDiv ul.thumbList li img{width:55px; height:55px; vertical-align:top;}
	.contArea .restList ul li .photoDiv ul.thumbList li a{border:2px solid #FFF; display:block;}
	.contArea .restList ul li .photoDiv ul.thumbList li a:hover{border:2px solid #ff7800;}
	.contArea .restList ul li .textDiv{float:right; width:775px;}
	.contArea .restList ul li .textDiv dl dd.add{background:url('/image/common/img_dot.gif') repeat-x left bottom; padding:3px 0 10px 0;}
	.contArea .restList ul li .textDiv dl dd.summary{background:url('/image/common/img_dot.gif') repeat-x left bottom; padding:10px 0; line-height:1.5em;}
	.contArea .restList ul li .textDiv dl dd.summary a:hover{text-decoration:underline;}
	.contArea .restList ul li .textDiv dl dd.etc{padding:10px 0 0 0;}
	.contArea .restList ul li .textDiv dl dd.etc .rmd{float:left; margin:5px 0 0 0;}
	.contArea .restList ul li .textDiv dl dd.etc .rmd .num{color:#ce2a07;}
	.contArea .restList ul li .textDiv dl dd.etc .cpn{float:left; margin:5px 0 0 5px;}
	.contArea .restList ul li .textDiv dl dd.etc .cpn .num{color:#ce2a07;}
	.contArea .restList ul li .textDiv dl dd.etc .btn{float:right;}
	.contArea .restList ul li .textDiv dl dd.etc .btn img{margin:0 0 0 5px;}
</style>

<table class = "tblRankingView">
	<tr>
		<th width = "550px;">리뷰어가 선택한 맛집랭킹</th>
	</tr>
	<tr style = "border: solid 1px black;">
		<th width = "1080px;" ></th>
	</tr>
</table>

<c:if test="${mapList == null || empty mapList}">
	<table class = "tblRankingView">
		<tr style = "border-left-width: 0px; border-right-width: 0px;">
			<td><span style = "margin-top: 50px; font-size: 20pt; font-weight: bold; ">검색결과가 존재하지 않습니다</span></td>
		</tr>
	</table>
</c:if>

<c:if test="${mapList != null && not empty mapList}">
<div class = "contArea">
<div class = "restList">
	<ul>
		<c:forEach var = "list" items = "${mapList}">
			<li>
				<h2>${list.rank}등. <a href = "<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}">${list.restName}</a>. ${list.restBgTag}</h2>
				<div class="photoDiv">
					<div><img width="100px;" height="100px;" src="<%= request.getContextPath() %>/files/rest/thumb/thumb${list.restImg}" /></div>
				</div>
				<div class="textDiv">
					<dl>
						<dd class="add">${list.restAddr} / ${list.metroName}</dd>
						<dd class="summary"><a href = "<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${list.restSeq}"><span style = "color : black;">${list.restContent}</span></a></dd>
					</dl>
				</div>
			</li>
			<div></div>	
		</c:forEach>
		</ul>
		</div>
		</div>
	<div align = "center" style = "margin-top : 20px; margin-bottom : 30px;">
		<table>
			<tr>
				<td style = "font-size : 15pt;">${html}</td>
			</tr>
		</table>	
	</div>
</c:if>
