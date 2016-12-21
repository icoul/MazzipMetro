<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
input.btn_like {
	width:50px; height:50px;  border:0; background: url('http://localhost:9090/mazzipmetro/resources/images/like.jpg') no-repeat;
}
input.btn_dislike {
	width:50px; height:50px;  border:0; background: url('http://localhost:9090/mazzipmetro/resources/images/dislike.png') no-repeat;
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



// 위로, 아래로 버튼
function goTopAndBottom(){
	
	 $("#goTop").click(function(){
			document.body.scrollTop = 0;
	 }); 

	 $("#goBottom").click(function(){
		document.body.scrollTop = document.body.scrollHeight;
	 }); 
}// end of goTopAndBottom

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
	
	
});// end of ready

</script>

<h2>${restvo.restname}의 리뷰(${TotalReviewCount })

 <input type="button" id="reviewAdd" name="reviewAdd" value="리뷰쓰기 " onClick="goReviewAdd('${restSeq}');" />

 </h2> 	
  	<p align="right">
		<button type="button" id="goBottom" onClick="goTopAndBottom();" >아래로</button>
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
					 <span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span><br/><br/>
					
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
							<a data-toggle="modal" data-target="#reviewImageDiv${status.index}"  data-dismiss="modal"><img src="<%= request.getContextPath() %>/files/${reviewImg}" width="100px" height="100px"/></a> &nbsp;&nbsp;						
						</c:forEach><br/>
						<p align="right">${review.reviewRegDate }</p>
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
			<button type="button" id="btnMore" value="" onClick="btnMore();"> 더보기...</button>
		</c:if>
	</tr>
	<p align="right">
		<button type="button" id="goTop" onClick="goTopAndBottom();" >TOP</button>
	</p>
		
	</div>