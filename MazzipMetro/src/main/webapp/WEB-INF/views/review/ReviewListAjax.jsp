<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
#btn_more {
	-moz-box-shadow: 3px 4px 0px 0px #899599;
	-webkit-box-shadow: 3px 4px 0px 0px #899599;
	box-shadow: 3px 4px 0px 0px #899599;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #bab1ba));
	background:-moz-linear-gradient(top, #ededed 5%, #bab1ba 100%);
	background:-webkit-linear-gradient(top, #ededed 5%, #bab1ba 100%);
	background:-o-linear-gradient(top, #ededed 5%, #bab1ba 100%);
	background:-ms-linear-gradient(top, #ededed 5%, #bab1ba 100%);
	background:linear-gradient(to bottom, #ededed 5%, #bab1ba 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#bab1ba',GradientType=0);
	background-color:#ededed;
	-moz-border-radius:15px;
	-webkit-border-radius:15px;
	border-radius:15px;
	border:1px solid #d6bcd6;
	display:inline-block;
	cursor:pointer;
	color:black;
	font-family:Arial;
	font-size:17px;
	padding:7px 25px;
	text-decoration:none;
	text-shadow:0px 1px 0px #e1e2ed;
}
#btn_more:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #bab1ba), color-stop(1, #ededed));
	background:-moz-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background:-webkit-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background:-o-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background:-ms-linear-gradient(top, #bab1ba 5%, #ededed 100%);
	background:linear-gradient(to bottom, #bab1ba 5%, #ededed 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#bab1ba', endColorstr='#ededed',GradientType=0);
	background-color:#bab1ba;
}
#btn_more:active {
	position:relative;
	top:1px;
}

.btn_srollbar {
	-moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
	-webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
	box-shadow:inset 0px 1px 0px 0px #ffffff;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f9f9f9), color-stop(1, #e9e9e9));
	background:-moz-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
	background:-webkit-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
	background:-o-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
	background:-ms-linear-gradient(top, #f9f9f9 5%, #e9e9e9 100%);
	background:linear-gradient(to bottom, #f9f9f9 5%, #e9e9e9 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f9f9f9', endColorstr='#e9e9e9',GradientType=0);
	background-color:#f9f9f9;
	-moz-border-radius:6px;
	-webkit-border-radius:6px;
	border-radius:6px;
	border:1px solid #dcdcdc;
	display:inline-block;
	cursor:pointer;
	color:#666666;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #ffffff;
}
.btn_srollbar:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #e9e9e9), color-stop(1, #f9f9f9));
	background:-moz-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
	background:-webkit-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
	background:-o-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
	background:-ms-linear-gradient(top, #e9e9e9 5%, #f9f9f9 100%);
	background:linear-gradient(to bottom, #e9e9e9 5%, #f9f9f9 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#e9e9e9', endColorstr='#f9f9f9',GradientType=0);
	background-color:#e9e9e9;
}
.btn_srollbar:active {
	position:relative;
	top:1px;
}


input.btn_like {
	width:50px; height:50px;  border:0; background: url('http://localhost:9090/mazzipmetro/resources/images/like.jpg') no-repeat;
}
input.btn_dislike {
	width:50px; height:50px;  border:0; background: url('http://localhost:9090/mazzipmetro/resources/images/unlike.png') no-repeat;
}
</style>
<script type="text/javascript">
function btnMore(){
	var Five = 5;
	var EndRno = $("#EndRno").val();
	EndRno = parseInt(EndRno);
	EndRno += Five;
	$("#EndRno").val(EndRno);
	getReviewList();
}//end of btnMore

// 좋아요 취소
function DownHit(reviewSeq, likeId){
	 $.ajax({ 
		 	
			url: "<%= request.getContextPath()%>/DownHit.eat",
			method:"get",  	
			data: "reviewSeq="+reviewSeq, 
			dataType: "JSON",
			success: function(data) {
				getReviewList();				
				}
		});//end of $.ajax()
} // end of DownHit

// 좋아요 누르기 
function upHit(reviewSeq, likeId){
	 $.ajax({ 
		 	
			url: "<%= request.getContextPath()%>/plusHit.eat",
			method:"get",  	
			data: "reviewSeq="+reviewSeq, 
			dataType: "JSON",
			success: function(data) {
				 swal({
					  title: "좋아요!",
					  imageUrl: "<%= request.getContextPath()%>/resources/images/thumbs-up.jpg"
					});
				getReviewList();
				}
		});//end of $.ajax()
} // end of upHit

// 좋아요 누른사람을 tbl_liker에 넣기
function insert_Liker(reviewSeq, likeId){
	 $.ajax({ 
		 	
			url: "<%= request.getContextPath()%>/insertLiker.eat",
			method:"get",  	
			data: "reviewSeq="+reviewSeq, 
			dataType: "JSON",
			success: function(data) {
								
				}
		});//end of $.ajax()
} // end of insert_Liker

function insertAndUpHit(reviewSeq, likeId){
	
	<c:if test="${UserSeq == null}">
	alert("로그인 후에 이용해주세요.");
	goLogin();
	return;
	</c:if>
	
	<c:if test="${UserSeq != null}">
	insert_Liker(reviewSeq, likeId);
	upHit(reviewSeq, likeId);
	</c:if>
		
} // end of upAndDownHit

function goReviewAdd(restSeq){
	<c:if test="${UserSeq == null}">
	alert("로그인 후에 이용해주세요.");
	goLogin();
	return;
	</c:if>
	
	<c:if test="${UserSeq != null}">
	var url = "<%=request.getContextPath()%>/reviewAdd.eat?restSeq="+restSeq;
	var title = "리뷰 작성";
	var status = "left=500px, top=100px, width=600px, height=915px, menubar=no, status=no, scrollbars=yes ";
	var popup = window.open(url, title, status); 
	</c:if>
	}

$(document).ready(function(){
	
	$("#goTop").click(function(){
		document.body.scrollTop = 0;
 }); 

 $("#goBottom").click(function(){
	document.body.scrollTop = document.body.scrollHeight;
 });
 
});// end of ready

</script>

<h2>${restvo.restname}의 리뷰(${TotalReviewCount })

 <input type="button" id="reviewAdd" name="reviewAdd" value="리뷰쓰기 " onClick="goReviewAdd('${restSeq}');" />

 </h2> 	
  	<p align="right">
		<button type="button" class="btn_srollbar" id="goBottom" >아래로</button>
	</p>

<table class="table" style="width: 80%;">
		
		<c:forEach var="review" items="${reviewList}" varStatus="status">
				
			<tr>
				<td align="center">
					<img class="img-circle" src="<%= request.getContextPath() %>/files/user/${review.userProfile}" width="100px" height="100px"/><br/>
					${review.userName }</br>
					<%-- 평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점 --%>
				</td>
				<td>
					 <span id="revTitle" style="font-weight: bold; font-size: 16pt;">${review.reviewTitle}</span>&nbsp;&nbsp;
				 	 <c:if test="${review.reviewAvgScore < 1}">
					 <img src="<%= request.getContextPath() %>/resources/starability-images/star.png">
					 </c:if> 
					 <c:if test="${((2 == review.reviewAvgScore) or (2 < review.reviewAvgScore)) and (review.reviewAvgScore < 3)}">>
					 <img src="<%= request.getContextPath() %>/resources/starability-images/icoStar2.png">
					 </c:if>
					 <c:if test="${((3 == review.reviewAvgScore) or (3 < review.reviewAvgScore)) and (review.reviewAvgScore < 4)}">
					 <img src="<%= request.getContextPath() %>/resources/starability-images/icoStar3.png">
					 </c:if>
					 <c:if test="${((4 == review.reviewAvgScore) or (4 < review.reviewAvgScore)) and (review.reviewAvgScore < 5)}">
					 <img src="<%= request.getContextPath() %>/resources/starability-images/icoStar4.png">
					 </c:if>
					 <c:if test="${5 == review.reviewAvgScore}">
					 <img src="<%= request.getContextPath() %>/resources/starability-images/icoStar5.png">
					 </c:if>
					 <span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>&nbsp;&nbsp;
					 <span>${review.reviewRegDate }</span>
					 <br/><br/>
					<section>${review.reviewContent}</section>
					
					<c:set value = "0" var="flag" />
					<c:forEach var="likers" items="${likers}">
						<c:if test="${likers == review.reviewSeq }">
							<p align="right">
								<input type="button" class="btn_dislike" id="like${status.index}" name="like" value="" onClick="DownHit('${review.reviewSeq}','like${status.index}');" /><!-- style="background-color: white; color: black" --> 
							</p>
							<c:set value = "1" var="flag" />
						</c:if>
					</c:forEach>
						<c:if test="${flag eq 0}">
							<p align="right">
								<input type="button" class="btn_like" id="like${status.index}" name="like" value="" onClick="insertAndUpHit('${review.reviewSeq}','like${status.index}');" />
							</p>
						</c:if>
					
					
					<section>
						<c:forEach var="reviewImg" items="${reviewImageList[status.index]}">
							<a data-toggle="modal" data-target="#reviewImageDiv${status.index}"  data-dismiss="modal"><img src="<%= request.getContextPath() %>/files/review/${reviewImg}" width="100px" height="100px"/></a> &nbsp;&nbsp;						
						</c:forEach><br/>
					</section>
				</td>
			
		
			
			<div class="modal  fade" id="reviewImageDiv${status.index}" style="margin-top:20px; margin-left:350px; width:80%; " >

			<div style="margin-left:810px;">
			   <a href="#"><img src="<%=request.getContextPath()%>/files/closeButton2.png" width="30px" height="30px" data-dismiss="modal"></a>
			  </div>
			  <iframe scrolling="yes" style=" border: none; width: 70%; height: 600px; " src="<%= request.getContextPath() %>/reviewModal.eat?reviewseq=${review.reviewSeq}&restname=${restvo.restname}&username=${review.userName }&reviewprofile=${review.userProfile}&reviewcontent=${review.reviewContent}&reviewregdate=${review.reviewRegDate}">
			  </iframe>
			   
			  
			</div>
		</c:forEach>
	
	</table>
	
	<div>
	<tr>
		<c:if test="${reviewList.size() < TotalReviewCount}">
			<button style="margin-left: 470px;" type="button" id="btn_more"value="" onClick="btnMore();"> 더보기...</button>
		</c:if>
	</tr>
	</div>
	<p align="right">
		<button style="margin-bottom:20px;" type="button" class="btn_srollbar" id="goTop">TOP</button>
	</p>