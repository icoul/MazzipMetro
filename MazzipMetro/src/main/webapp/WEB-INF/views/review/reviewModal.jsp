<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<title>ㅋㅋㅋ멀티 파일올리기 및 썸네일 파일 생성하기</title>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

  <style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  
  .myborder {
	border: navy solid 1px;
  }
  

  </style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$(".my_thumbnail").hover(
				function(){
					$(this).addClass("myborder");
				},
				function(){
					$(this).removeClass("myborder");
				}
		);
		
		$("#reviewComment").keyup(function(){
			var reviewCommentLength = $("#reviewComment").val().length;
			
			if(50 < reviewCommentLength){
				alert("입력가능한 글자수는 50자 입니다");
				$("#reviewComment").val("");
			}
			
			if(0 < reviewCommentLength && reviewCommentLength <= 50){
				$("#reviewCommentLength").text(reviewCommentLength + "자 입력");
			}else{
				$("#reviewCommentLength").text("");
			}
			
			
			
		});
		
		
		getReviewComment("${reviewseq}");
	});		
	
	function loginCheck(userSeq){
		if(userSeq == ""){
			alert("로그인을 해주세요");
			document.getElementById("reviewComment").value = "";
		}
	}
	
function getReviewComment(previewSeq){
			var userName = $("#userName").val();
			var userProfile = $("#userProfile").val();
			$.getJSON("getReviewComment.eat?reviewSeq="+previewSeq ,function(data){
				var html = "";
				var html2 = "";
				var count = 0;

				
				$("#resultComments").empty();
				$.each(data, function(enrtyIndex, entry){
						
					html += "<div class='media'>";
					
					if(Number(entry.agoDay) > 0){
						html += "<p class='pull-right'> <small>" + entry.agoDay +"일 전 </small> </p>";	
					}else if(Number(entry.agoHour) > 0 && Number(entry.agoHour) < 24){
						html += "<p class='pull-right'> <small>" + entry.agoHour +"시간 전 </small> </p>";	
					}else if(Number(entry.agoMinute) > 0 && Number(entry.agoMinute) < 60){
						html += "<p class='pull-right'> <small>" + entry.agoMinute +"분전 </small> </p>";
					}else if(Number(entry.agoMinute) == 0){
						html += "<p class='pull-right'> <small> 방금 </small> </p>";
					}
					

				    html += "<a class='media-left' href='#'> <img src='<%=request.getContextPath() %>/files/user/" + entry.userProfile + "' width='70px' height='70px'> </a>"; 

					html += "<div class='media-body'>";
					html += "<input type='hidden' name='commentSeq' id='commentSeq"+ entry.commentSeq +"' value='"+ entry.commentSeq +" '/>"
					html += "<h4 class='media-heading user_name'>" + entry.userName +"</h4> " +entry.content +".";
					
					if(userName != null){
						html += "  <small ><a href='#' id='commentLink" + enrtyIndex + "' onClick='goComment(" + enrtyIndex + ");'>한줄댓글</a></small>";	
						
						if(userName == entry.userName){
							userProfile = entry.userProfile;
							html +=	"  <small><a href='javascript:deleteReviewComment("+entry.commentSeq + ");'>삭제</a></small>";
						}
					}
					
					 		
					html += "</div>";
					html += "</div>";
					
					
					html += "<div class='media' style='display:none;' id='commentComment" + enrtyIndex + "'>";
					html += "<a class='media-left' href='#'> <img src='<%=request.getContextPath() %>/files/user/" + userProfile + "' width='70px' height='70px'> </a>";
					html += "<div class='media-body'>";
					html += "<h4 class='media-heading user_name'>" + userName +"</h4> <input type='text' /> ";
					
					
					html += "</div>";
					html += "</div>";
					
					
					count++;
				});
				
				html2 += "<small>(" + count + ")</small>";
				
				$("#resultComments").html(html);
				$("#resultCommentsCount").html(html2);
			}
		);
		}
	 
	function insertReviewComment(previewSeq, userSeq, e){
		var reviewComment = $("#reviewComment").val();
		
			if(userSeq == ""){
				alert("로그인을 해주세요");
				reviewComment.value = "";
			}else{
				if(e.keyCode == 13){
					if(reviewComment.length < 1 || reviewComment.trim() == ""){
						alert("댓글을 입력해주세요");
						reviewComment.value = "";
					}else{
						var form_data = {reviewSeq : previewSeq ,          
							    comment : reviewComment        
						    };
			
						$.ajax({
							url: "insertReviewComment.eat",   // action 에 해당하는 URL 속성값
							method:"POST",                 // method
							data: form_data,               // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
							success: function() {          // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
								reviewComment.value = "";
								getReviewComment(previewSeq);
							         }
						});
					}  
				}
			}
		
	} 
	
	function goComment(index){
	var comment =	document.getElementById("commentComment"+index)/* .style.display = "block" */;
		
		if(comment.style.display == "none")
			comment.style.display = "block";
		else
			comment.style.display = "none";
	}
	
</script>

</head>
<body>


  
  
<div class="container" align="center">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 75%;">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <c:forEach var="avo" items="${reviewImageList}" varStatus="status">
      	<c:if test="${status.index == 0}">
      		<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
      	</c:if>
      	<c:if test="${status.index > 0}">
      		<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
      	</c:if>
      </c:forEach>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
	  <c:forEach var="image" items="${reviewImageList}" varStatus="status">
	  	  <c:if test="${status.index == 0}">
	  	  	<div class="item active">
	  	  </c:if>
	  	  <c:if test="${status.index > 0}">
	  	  	<div class="item">
	  	  </c:if>
	  	  
	  	  
	  	  	<div id="largeImg" align="center" style="border: green solid 0px; width: 45%; padding: 2%; margin: 2% auto;">
				<img src="<%= request.getContextPath() %>/files/${image.reviewImg}" width="200px" height="200px">
	      	</div>
	      	</div>
	  </c:forEach>
    </div>  <%-- end of <div class="carousel-inner" role="listbox"> --%>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div> <%-- end of <div id="myCarousel" class="carousel slide" data-ride="carousel"> --%>
  
  <div align="center" style="border: red solid 0px; width: 80%; margin: auto; padding: 20px;">
		<c:forEach var="image" items="${reviewImageList}" varStatus="status">
			<img src="<%= request.getContextPath() %>/files/thumb${image.reviewImg}" class="my_thumbnail" style="margin-right: 10px;" data-target="#myCarousel" data-slide-to="${status.index}" />
		</c:forEach>
	</div>
</div>
	

<div class="container">
	<table class="table">
		<tr>
			<th>${restName}</th>
		</tr>
		
		<tr>
			<td>
				<p> <img  class="img-circle" src="<%= request.getContextPath() %>/files/user/${reviewProfile}" width="50px" height="50px"/>${userName}</p>
				<p>${reviewContent }</p>
				<p>${reviewRegDate }</p>
			</td>
		</tr>
	
	</table>
	

	<div class="col-md-12 product-info">
					<ul id="myTab" class="nav nav-tabs nav_tabs">
						<li class="active"><a href="#service-one" data-toggle="tab">댓글<span id="resultCommentsCount"></span></a></li>	
					</ul>
				
				<div id="myTabContent" class="tab-content" style="margin-top:10px;">
					<div class="comments-list" id="resultComments" style="margin-bottom:100px;">
						
					</div>
				<hr>
						<div class="tab-pane fade in active" id="service-one">
	
							<div class="row" style="margin-top:100px; position:fixed; bottom: 0px;">
								<div class="col-md-12">
										
										<table>
											<tr>
												<td></td>
												<td>
													<textarea id="reviewComment" cols="90" rows="2" name="reviewComment" title="댓글 입력창" onkeypress="javascript:insertReviewComment('${reviewseq}', '${(sessionScope.loginUser.userSeq)}', event);"  onclick="javascript:loginCheck('${(sessionScope.loginUser.userSeq)}' );"></textarea>
													<div id="reviewCommentLength"></div>
													<input type="hidden" id="userName" value="${(sessionScope.loginUser.userName)}" />
													<input type="hidden" id="userProfile" value="${(sessionScope.loginUser.userProfile)}" />
												</td>
											</tr>
											<tr>
												<td></td>
												<td>
													<div class="cbox_desc_area"></div>
												</td>
												<td></td>
											</tr>
									</table>
										
								</div>
							</div>
						
						</div>
					</div>
				
	</div>
			
			
</div>


</body>
</html>