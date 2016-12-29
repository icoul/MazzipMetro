<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
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
  
  input.report {
	  border:0; width:30px; height:30px; background: url('http://localhost:9090/mazzipmetro/resources/images/icosiren.png') no-repeat;
	  border-radius: 10px;
}

  </style>

<script type="text/javascript">
	var lenNew = 5;

	$(document).ready(function(){
		
		 
		$("#btntotalCommentCount").hide();
		$("#btnRomanceCountNEW").hide();
		
		if(parseInt($("#totalCommentCount").text()) == 0) {
			  $("#spanMoreComment").hide();
			  $("#resultComments").html("<span style='text-align: center;'>등록된 댓글이 없습니다.</span>");
		  }
		
		var revImgSeq =  ${reviewImageList.get(0).revImgSeq}; 
		goLargeReviewImgView(revImgSeq);
		
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
		
		//텍스트에어리어에서 ctrl + enter을 누르면 줄바꿈을 시켜준다
		$("#reviewComment").keydown(function (e) {
		    if (e.keyCode === 13 && e.ctrlKey) {
		        $(this).val(function(i,val){
		            return val + "\n";
		        });
		    }
		});
		
		$("#spanMoreComment").bind("click", function() {
			getReviewComment( "${reviewseq}", parseInt($(btnMoreComment).val()));
		});
		
		getReviewComment("${reviewseq}", parseInt($("#totalCommentCount").text()) - lenNew + 1); 
	});		

	function loginCheck(userSeq){
		if(userSeq == ""){
			alert("로그인을 해주세요");
			document.getElementById("reviewComment").value = "";
		}
	}
	
	
	
	function getReviewComment(previewSeq, start){ //댓글 더보기
			var userName = $("#userName").val();
			var userProfile = $("#userProfile").val();
			$.getJSON("getReviewComment.eat?reviewSeq="+previewSeq + "&start="+start+"&len="+lenNew ,function(data){
				var html = "";
				var html2 = "";
				var count = 0;

				
				$.each(data, function(entryIndex, entry){
					
					html += "<div class='media'>";	
					
				    html += "<a class='media-left' > <img class='img-circle' src='<%=request.getContextPath() %>/files/user/" + entry.userProfile + "' width='70px' height='70px'> </a>"; 

					html += "<div class='media-body'>";
					html += "<input type='hidden' name='commentSeq' id='commentSeq"+ entry.commentSeq +"' value='"+ entry.commentSeq +" '/>"
					html += "<h4 class='media-heading user_name'>" + entry.userName +"</h4> " +entry.content +".";
					
					if(Number(entry.agoDay) > 0){
						html += "<p class='pull-right'> <small>" + entry.agoDay +"일 전 </small> </p>";	
					}else if(Number(entry.agoHour) > 0 && Number(entry.agoHour) < 24){
						html += "<p class='pull-right'> <small>" + entry.agoHour +"시간 전 </small> </p>";	
					}else if(Number(entry.agoMinute) > 0 && Number(entry.agoMinute) < 60){
						html += "<p class='pull-right'> <small>" + entry.agoMinute +"분전 </small> </p>";
					}else if(Number(entry.agoMinute) == 0){
						html += "<p class='pull-right'> <small> 방금 </small> </p>";
					}
					
					if(userName != "" && userName != entry.userName){
						html += "  <small ><a  id='commentLink" + entry.groupNo + "' style='cursor:pointer;' onClick='goComment(" + entry.groupNo + ");'>한줄댓글</a></small>";	
					}
					

					if(userName == entry.userName){
						userProfile = entry.userProfile;
						html +=	"  <small><a onClick='deleteReviewComment("+ previewSeq +","+ entry.commentSeq + ");'>삭제</a></small>";
					}
					
					if(entry.commentCount > 0){ //댓글의 갯수가 1개이상이면 댓글 더보기 버튼이 생긴다.
						html += "<br> <a style='cursor:pointer;' id='commentMore"+ entry.commentSeq +"' onClick='commentMoreView(" + entry.commentSeq + "," + entry.groupNo +");'>댓글 "+ entry.commentCount +"개 더보기</a>";
					}
					html += "<div class='comments-list' style='margin-top:30px; ' id='resultComments"+ entry.groupNo +"' > </div>"; //원댓글에 댓글이 달리며 이 div에 댓글을 넣어준다. 
					 
					html += "</div>";
					html += "</div>";

					html += "<div class='media' style='display:none;'  id='commentComment" + entry.groupNo + "'>";
					html += "<a class='media-left' > <img class='img-circle' src='<%=request.getContextPath() %>/files/user/" + userProfile + "'  width='70px' height='70px'> </a>";
					html += "<div class='media-body'>";
					html += "<h4 class='media-heading user_name'>" + userName +"</h4>";                                                                                  
					html += "<input type='text' id='commentContent" + entry.groupNo +"' onkeypress='insertCommentComment(event, "+previewSeq+","+ entry.commentSeq +","+ entry.groupNo +","+ entry.depthNo +");' /> "; 
					
					html += "</div>";
					html += "</div>";
					
					count++;
				});
				
				html2 += "<small>(" + (parseInt($("#commentCountNEW").text()) + count) + ")</small>";
				$("#resultComments").prepend(html);    //여기서는 append를 해줘야한다 왜냐하면 더보기버튼을 클릭하면 start와 lenNew의 범위에 따라서 쿼리가 실행되기 때문에 댓글의 전체를 가져오는게 아니라 일부분만 가져와서 추가하는것이기 때문에 append를 쓴다
				$("#resultCommentsCount").html(html2);
				
				  //>>>>>> 더보기 버튼의 value 속성에 값을 지정해주기 (중요!!!!!) <<<<<<<<
				  $("#btnMoreComment").val(parseInt(start) - lenNew);
				  
				
				  $("#commentCountNEW").text( parseInt($("#commentCountNEW").text()) + count );
				  //더보기 버튼의 비활성 처리
				  //-> count와 totalCout가 일치하는 경우 비활성
				  if (parseInt($("#commentCountNEW").text()) == parseInt($("#totalCommentCount").text())) {
					  $("#spanMoreComment").hide();
				  }else{
					  $("#spanMoreComment").show();
				  }
					
			}
		);
	}
	 
	function commentMoreView(commentSeq,groupNo){ // 댓글의 댓글 더보기 , 원댓글번호
 		var userName = $("#userName").val();
 		
 		$.getJSON("commentMoreView.eat?commentSeq="+commentSeq+"&groupNo="+groupNo ,function(data){
			var html = "";
			var html2 = "";

			$.each(data, function(entryIndex, entry){
				if(entry.commentSeq != ""){
					
				html += "<div class='media' style='width:610px;' >";	
				
			    html += "<a class='media-left' > <img class='img-circle' src='<%=request.getContextPath() %>/files/user/" + entry.userProfile + "' width='70px' height='70px'> </a>"; 

				html += "<div class='media-body'>";
				html += "<input type='hidden' name='commentSeq' id='commentSeq"+ entry.commentSeq +"' value='"+ entry.commentSeq +" '/>"
				html += "<h4 class='media-heading user_name'>" + entry.userName +"</h4> " +entry.content +".";
				
				if(Number(entry.agoDay) > 0){
					html += "<p class='pull-right'>  <small>" + entry.agoDay +"일 전 </small> </p>";	
				}else if(Number(entry.agoHour) > 0 && Number(entry.agoHour) < 24){
					html += "<p class='pull-right'> <small>" + entry.agoHour +"시간 전 </small> </p>";	
				}else if(Number(entry.agoMinute) > 0 && Number(entry.agoMinute) < 60){
					html += "<p class='pull-right'> <small>" + entry.agoMinute +"분 전 </small> </p>";
				}else if(Number(entry.agoMinute) == 0){
					html += "<p class='pull-right'> <small> 방금 </small> </p>";
				}
				
				if(userName == entry.userName){
					userProfile = entry.userProfile;
					html +=	"  <small><a onClick='deleteCommentComment("+entry.commentSeq + "," + entry.fk_seq + "," + entry.groupNo + ");'>삭제</a></small>";
				}
				
				html += "</div>";
				html += "</div>";
				}//end of if
				
			});
			$("#resultComments"+groupNo).empty();
			$("#resultComments"+groupNo).append(html); //댓글의 댓글을 불러올때는 전체를 불러오기때문에  html()을쓰거나 append()를 써도 상관없다 위에 empty를 해주고있기 때문에

		}
	);
 		$("#commentMore"+commentSeq).hide();	
	}
	
	function insertReviewComment(previewSeq, userSeq, e){ //댓글 달기
		var reviewComment = $("#reviewComment").val();
		
			if(userSeq == ""){
				alert("로그인을 해주세요");
				$("#reviewComment").val("");
			}else{
				if(e.keyCode == 13){
					if(reviewComment.length < 1 || reviewComment.trim() == ""){
						alert("댓글을 입력해주세요");
						$("#reviewComment").val("");
					}else{
						var form_data = {reviewSeq : previewSeq ,          
							    comment : reviewComment        
						    };
			
						$.ajax({
							url: "insertReviewComment.eat",   // action 에 해당하는 URL 속성값
							method:"POST",                 // method
							data: form_data,               // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
							dataType:"json",
							success: function(data) {          // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
								$("#reviewComment").val("");
								$("#resultComments").empty();
								$("#commentCountNEW").text("0");
								
								
								$.each(data, function(key, val){
									
									if(key == "reviewCommentTotalCount") {
											$("#totalCommentCount").text(val+"");
										}// end of  if(key == "name")
									}//end of function(key, val)
								);//end of $.each(data, function(key, val));
								if(parseInt($("#totalCommentCount").text()) <= lenNew){
									getReviewComment(previewSeq,1);
								}else if(parseInt($("#totalCommentCount").text()) > lenNew){
									getReviewComment(previewSeq,parseInt($("#totalCommentCount").text()) - lenNew + 1);	
								}
								
								
							}//end of success:function(data)
						}); //end of $.ajax
					}//end of else  
				}//end of if(e.keyCode == 13)
			}//end of else
		
	}//end of  insertReviewComment
	
	 function insertCommentComment(e, reviewSeq1, commentSeq1, groupNo1, depthNo1){//댓글에 댓글 달기
		var commentContent = $("#commentContent"+groupNo1).val();
				if(e.keyCode == 13){
					if(commentContent.length < 1 || commentContent.trim() == ""){
						alert("댓글을 입력해주세요");
						$("#commentContent"+groupNo1).val("");
					}else{
						var form_data = {reviewSeq : reviewSeq1,
							    comment : commentContent,
							    commentSeq : commentSeq1,
								groupNo	: 	groupNo1,
								depthNo : depthNo1
						    };
			
						$.ajax({
							url: "insertReviewComment.eat",   // action 에 해당하는 URL 속성값
							method:"POST",                 // method
							data: form_data,               // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
							success: function() {          // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
								goComment(groupNo1);
								$("#commentContent"+groupNo1).val("");
								commentMoreView(commentSeq1, groupNo1);
							         }
						});
					}  
				}
	} 
	
 	function deleteReviewComment(reviewSeq1, commentSeq1){ //댓글삭제
 		var form_data = {commentSeq : commentSeq1,
 				reviewSeq : reviewSeq1,
		    };

		$.ajax({
			url: "deleteReviewComment.eat",   // action 에 해당하는 URL 속성값
			method:"POST",                 // method
			data: form_data,               // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			dataType:"json",
			success: function(data) {          // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				$("#resultComments").empty();
				$("#commentCountNEW").text("0");
				
				
				$.each(data, function(key, val){
					if(key == "reviewCommentTotalCount") {
							$("#totalCommentCount").text(val+"");
						}// end of  if(key == "name")
					}//end of function(key, val)
				);//end $.each
				if(0 < parseInt($("#totalCommentCount").text()) && parseInt($("#totalCommentCount").text()) <= lenNew){
					getReviewComment(reviewSeq1,1);
				}else if(parseInt($("#totalCommentCount").text()) > lenNew){
					getReviewComment(reviewSeq1,parseInt($("#totalCommentCount").text()) - lenNew + 1);	
				}else if(parseInt($("#totalCommentCount").text()) == 0){
					$("#resultCommentsCount").empty();
					$("#resultComments").html("<span style='text-align: center;'>등록된 댓글이 없습니다.</span>");
				}
			 }//end of success: function(data)
		});//end of $.ajax
 	}//end of deleteReviewComment
 	
 	function deleteCommentComment(commentSeq1,fk_seq1,groupNo){ //댓글의 댓글을 삭제
 		var form_data = {commentSeq : commentSeq1,
 				fk_seq : fk_seq1
		    };

		$.ajax({
			url: "deleteReviewComment.eat",   // action 에 해당하는 URL 속성값
			method:"POST",                 // method
			data: form_data,               // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			success: function() {          // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				commentMoreView(fk_seq1,groupNo);
			         }
		});
 	}
 	
 	function goComment(groupNo1){
 		var comment = document.getElementById("commentComment"+groupNo1);
 			
 			if(comment.style.display == "none")
 				comment.style.display = "block";
 			else
 				comment.style.display = "none";
 		}
 	
 	 function openWinFaq(src, width, height){
			window.open(src,"팝업창이름(의미없음)", "width=" + width + ", height=" + height + ", left=100px, top=100px, menubar=no, status=no, scrollbars=no");
		}
 	
 	 
 	function goLargeReviewImgView(revImgSeq) {
 		$.ajax({ 
 			url : "getLargeReviewImageName.eat", 	
 			method : "GET",
 			data : "revimgseq=" + revImgSeq,  
 					/*
 					   전송방식이 get 이든 post 이든 
 					   getLargeImgFilename.action?seqfileno=11 처럼 보내게 된다.
 					   !! 그리고 중요한 것은 !!!
 					   ajax 를 이용한 전송방식에는 
 					   url페이지명과  data가 구분되어져 있으므로
 					   구분자인 ? 가 필요없다는 것이다.
 					   GET 방식에서 ? 의 기능은
 					   WAS(톰캣서버)가 어디까지가 응용프로그램 주소이고,
 					   어디부터가 데이터인지 구분하기 위한 구분자로 사용되는 것이다.
 					   그러므로 ajax 에서는 키1=값1&키2=값2&키3=값3 으로 반복된다.
 				   */
 			dataType : "JSON",  // 응답은 JSON 타입으로 받아라.
 			success: function(data) { // 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
 					// data 는 ajax 요청에 의해 url 페이지 getLargeImgFilename.action 으로 부터 리턴받은 데이터
 			   			   
 			   $("#largeImg").empty();
 			   // <div id="largeImg"> 엘리먼트를 모두 비워서 새로운 데이터를 받을수 있게 해라
 			   
 			   var html = "";
 			   
 			   $.each(data, function(key, val){
 					html += "<img src='<%=request.getContextPath() %>/files/review/"+val+"' "+"width='460' height='345' />";    
 			   });
 					
 		   	   /*
 		   	    	$.each() 함수는 $(selector).each()와는 다르다.
 		   	    	$.each(순회해야할 1개의 객체 또는 배열, function(indexInArray, valueOfElement){ } );
 		   	    	배열을 다루는 경우, 콜백함수는 배열의 인덱스와 값을 인자로 갖는다
 		   	   */
 		   	   $("#largeImg").html(html);   // html을  largeImg 넣어주어라
 			
 			}, // end of success: function(data) ---------------------
 			
 			error: function(request, status, error){
 		        alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
 		    } // end of error: function(request,status,error)
 			
 		}); // end of $.ajax --------------------
 	}
 	 
</script>

</head>
<body>

<div class="container" align="center">
	<div id="largeImg" style="float: left;  border: green solid 0px; width: 100%; margin-top:20px; margin-bottom:20px;"> 
	</div>  
		
	<div align="center" style="border: red solid 0px; width: 80%; margin: auto; padding: 20px; ">
		<c:forEach var="map" items="${reviewImageList}" varStatus="status">
			<img src="<%= request.getContextPath() %>/files/review/thumb/thumb${map.reviewImg}" class="my_thumbnail" style="margin-right: 10px;" onmouseover="goLargeReviewImgView('${map.revImgSeq}')" />
		</c:forEach>
	</div>
</div>
	

<div class="container">
	<table class="table">
		<tr>
			
			<th>${restName} <input type="button" style="float: right;" class="report" onClick="openWinFaq('<%=request.getContextPath() %>/report.eat', '500','400' );" /></th>
			
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
					<div style="margin-bottom:20px;">
						
						<span style="cursor: pointer; color: blue;" id="spanMoreComment" >댓글 더보기...</span>	
						
						<input id="btnMoreComment" type="hidden"  value="">
						<button type="button" id="btntotalCommentCount">TotalNEWCount : <span id="totalCommentCount">${reviewCommentTotalCount}</span></button>
						<button type="button" id="btnRomanceCountNEW">Count : <span id="commentCountNEW">0</span></button>
					</div>
					
					<div class="comments-list" id="resultComments">	
					</div>
					
				<hr>
						<div class="tab-pane fade in active" id="service-one">
							<div class="row" style="margin-top:20px;">
								<div class="col-md-12">
										
										<table>
											<tr>
												<td></td>
												<td>
														<div class="media" >
															<a class="media-left" > <img class="img-circle" src="<%=request.getContextPath() %>/files/user/${(sessionScope.loginUser.userProfile)}"  width="70px" height="70px"> </a>
															<div class="media-body">
																<br>
																<textarea id="reviewComment" cols="80" rows="1"  name="reviewComment" title="댓글 입력창" onkeypress="javascript:insertReviewComment('${reviewseq}', '${(sessionScope.loginUser.userSeq)}', event);"  onclick="javascript:loginCheck('${(sessionScope.loginUser.userSeq)}' );"></textarea>
																<div id="reviewCommentLength">
																</div>  
															</div>
														</div>
												
													<input type="hidden" id="userName" value="${(sessionScope.loginUser.userName)}" />
													<input type="hidden" id="userProfile" value="${(sessionScope.loginUser.userProfile)}" />
												</td>
											</tr>
											
									</table>
										<br><br>
								</div>
							</div>
						
						</div>
					</div>
				
	</div>
			
			
</div>


</body>
</html>