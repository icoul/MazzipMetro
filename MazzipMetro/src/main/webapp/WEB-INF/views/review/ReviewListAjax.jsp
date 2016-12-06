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
}

function goTopAndBottom(){
	
	 $("#goTop").click(function(){
			document.body.scrollTop = 0;
	 }); 

	 $("#goBottom").click(function(){
		document.body.scrollTop = document.body.scrollHeight;
	 }); 
	
}

</script>

<h2>${restvo.restname}의 리뷰(${TotalReviewCount })</h2>
  	
  	<p align="right">
		<button type="button" id="goBottom" onClick="goTopAndBottom();" >아래로</button>
	</p>

<table  class="table table-bordered">
		
		<c:forEach var="review" items="${reviewList}" varStatus="status">
			<tr>
				<td>${review.userName }  <img src="<%= request.getContextPath() %>/files/${review.userProfile}" width="100px" height="100px"/></td>
				<td>
					<section>${review.reviewContent}</section>
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