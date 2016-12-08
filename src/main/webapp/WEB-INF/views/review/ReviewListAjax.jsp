<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
function btnMore(){
	var Five = 5;
	var EndRno = $("#EndRno").val();
	EndRno = parseInt(EndRno);
	EndRno += Five;
	$("#EndRno").val(EndRno);
	getReviewList();
}//end of btnMore

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
				alert(data.reviewHit);
				$("#"+likeId).val(data.reviewHit+"Hit!");
				
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
				alert(data.reviewHit);
				$("#"+likeId).val(data.reviewHit+"Hit!");
				
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
	
	insert_Liker(reviewSeq, likeId);
	upHit(reviewSeq, likeId);

		
} // end of upAndDownHit

$(document).ready(function(){
	
	
});// end of ready

</script>

<h2>${restvo.restname}의 리뷰(${TotalReviewCount })</h2>
  	
  	<p align="right">
		<button type="button" id="goBottom" onClick="goTopAndBottom();" >아래로</button>
	</p>

<table  class="table table-bordered">
		<tr>
		<th style="text-align:center;">이름</th>
		<th style="text-align:center;">평점</th>
		<th style="text-align:center;">리뷰</th>
		</tr>
	
		
		<c:forEach var="review" items="${reviewList}" varStatus="status">
				
			<tr>
				<td>${review.userName }  <img src="<%= request.getContextPath() %>/files/${review.userProfile}" width="100px" height="100px"/></td>
					<td align="right">
						평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점
					</td>
				<td>
					<section>${review.reviewContent}</section>
					<c:set value = "0" var="flag" />
					
					<c:forEach var="likers" items="${likers}" varStatus="status">
						<c:if test="${likers == review.reviewSeq }">
							<p align="right">
								<input type="button" id="like${status.index}" name="like" value="${review.reviewHit}Hit!" onClick="DownHit('${review.reviewSeq}','like${status.index}');" style="background-color: white; color: black" />
							</p>
							<c:set value = "1" var="flag" />
						</c:if>
					</c:forEach>
						<c:if test="${flag eq 0}">
							<p align="right">
								<input type="button" id="like${status.index}" name="like" value="${review.reviewHit}Hit!" onClick="insertAndUpHit('${review.reviewSeq}','like${status.index}');" />
							</p>
						</c:if>
					
					<section>
						<c:forEach var="reviewImage" items="${reviewImageList}">
							<c:if test="${review.reviewSeq == reviewImage.reviewSeq}">
								<a data-toggle="modal" data-target="#reviewImageDiv${status.index}"  data-dismiss="modal"><img src="<%= request.getContextPath() %>/files/${reviewImage.reviewImg}" width="100px" height="100px"/></a> &nbsp;&nbsp;
							</c:if>
						</c:forEach>
					</section>
				</td>
		
			
			
			<div class="modal  fade" id="reviewImageDiv${status.index}" role="dialog" >
			  <iframe scrolling="no" style=" border: none; width: 100%; height: 600px; " src="<%= request.getContextPath() %>/reviewModal.eat?reviewseq=${review.reviewSeq}&restname=${restvo.restname}&username=${review.userName }&reviewprofile=${review.userProfile}&reviewcontent=${review.reviewContent}&reviewregdate=${review.reviewRegDate}">
			  </iframe>
			  <div >
			   <button type="button" class="btn btn-default myclose" data-dismiss="modal">닫기</button>
			  </div> 
			  
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