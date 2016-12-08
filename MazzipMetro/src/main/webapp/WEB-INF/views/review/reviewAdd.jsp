<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 올리기</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <%-- <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/bootstrap.css"> --%>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/starability-all.min.css">
  <%-- 
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/JqueryUI/styles/jquery-ui.css">
  <script src="<%= request.getContextPath() %>/resources/JqueryUI/uijs/jquery-ui.js"></script> 
  --%>

	

<style type="text/css">
	/* table, th, td, input, textarea {border: solid gray 1px;}
	
	#table {border-collapse: collapse;
	 		width: 600px;
	 		}
	#table th, #table td{padding: 5px;} */
	#table th{width: 120px; background-color: #EEEEEE; text-align: center; vertical-align: middle;}
	#table td{width: 480px;}
	.mylong {width: 470px;}
	.myshort {width: 120px;} 
	

</style>

<script type="text/javascript">

	function getTotalRating(){
		
		var total;
				
		var taste = $(':radio[name=taste-rating]:checked').val()
		var mood = $(':radio[name=mood-rating]:checked').val()
		var price = $(':radio[name=price-rating]:checked').val()
		var service = $(':radio[name=service-rating]:checked').val()
		if (taste != null && mood != null && price != null && service != null) {
			
			 taste = parseInt($(':radio[name=taste-rating]:checked').val());
			 mood = parseInt($(':radio[name=mood-rating]:checked').val());
			 price = parseInt($(':radio[name=price-rating]:checked').val());
			 service = parseInt($(':radio[name=service-rating]:checked').val());
			
			total = (taste + mood + price + service) / 4
			total = total.toFixed(1);
							
			
			$("#total-result").empty();
			$("#total-result").append(total+"점");
			$("#inputAvgScore").val(total);
		}
		else
		{
			/* $("#total-result").hide(); */	
		}

		
	}

	function goWrite() {
		var writeFrm = document.writeFrm;
		writeFrm.submit();
	}

	function goReset() {
		var writeFrm = document.writeFrm;
		writeFrm.reset();
		$("#result").empty();
	}

	function goList() {
		var writeFrm = document.writeFrm;
		location.href = "<%= request.getContextPath() %>/list.action";
	}

	
	$(document).ready(function(){
		
		
		$("[name=taste-rating]").click(function(){
			var html = "";
			var taste = $(':radio[name=taste-rating]:checked').val();
			
			var html= taste;
						
			$("#reviewTaste").empty();
			$("#reviewTaste").append(html+"점");
			$("#inputTaste").val(taste);
			getTotalRating();
		});
		

		
		$("[name=mood-rating]").click(function(){
			
			var html = "";
			var mood = $(':radio[name=mood-rating]:checked').val();
			
			var html= mood;
						
			$("#reviewMood").empty();
			$("#reviewMood").append(html+"점");
			$("#inputMood").val(mood);
			getTotalRating();
		});
		

		
		$("[name=price-rating]").click(function(){
			var html = "";
			var price = $(':radio[name=price-rating]:checked').val();
				
			var html= price;
						
			$("#reviewPrice").empty();
			$("#reviewPrice").append(html+"점");
			$("#inputPrice").val(price);
			getTotalRating();
		});
		
		
		$("[name=service-rating]").change(function(){
			var html = "";
			var service = $(':radio[name=service-rating]:checked').val();
				
			var html= service;
						
			$("#reviewService").empty();
			$("#reviewService").append(html+"점");
			$("#inputService").val(service);

			getTotalRating();
		});
		
		
			
		
		
		$("#attachNum").bind("change", function(){
		
			var html = "";
			
			var attachNumVal = $("#attachNum").val();
			
			if(attachNumVal == "0") {
				$("#result").empty();
				return;
			}
			else
			{
				for(var i=0; i<parseInt(attachNumVal); i++) {
					html += "<br/>";
					html += "<input type='file' name='attach' class='btn btn-default' />";
				}
				
				$("#result").empty();
				$("#result").append(html);	
			}
		});
		
	});
	
</script>

</head>
<body>

	<div class="container" style="margin-bottom: 50px;">
	<h3 style="width: 60%; padding-top: 20px;">리뷰 작성</h3>
	
	 <%-- >>>> 파일첨부하기
	 	  enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	
	<form name="writeFrm" action="<%= request.getContextPath() %>/reviewAddEnd.eat" method="post" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 60%; margin-top: 50px; border: gray 1px solid">
			<tr>
				<th>제목</th>
			</tr>
			<tr>
				<td align="center">
					<input type="text" name="reviewTitle" />
					<input type="hidden" id="reviewHit" name="reviewHit" value="like!"/>
				</td>
			</tr>			
			<tr>
				<th>평점</th>
			</tr>
			<tr>
				<td>
				    &nbsp;&nbsp;
					<form id="rating1" class="taste">
					  <fieldset class="starability-growRotate">
					    <legend>분위기 평점 </legend>
					    <input type="radio" id="rate5" name="mood-rating" value="5" class="mood-rating" />
					    <label for="rate5" title="Amazing">5 stars</label>
					    <input type="radio" id="rate4" name="mood-rating" value="4" class="mood-rating" />
					    <label for="rate4" title="Very good">4 stars</label>
					    <input type="radio" id="rate3" name="mood-rating" value="3" class="mood-rating" />
					    <label for="rate3" title="Average">3 stars</label>
					    <input type="radio" id="rate2" name="mood-rating" value="2" class="mood-rating" />
					    <label for="rate2" title="Not good">2 stars</label>
					    <input type="radio" id="rate1" name="mood-rating" value="1" class="mood-rating" />
					    <label for="rate1" title="Terrible">1 star</label>
					  </fieldset>
					</form>
					<div id="reviewMood" name="reviewMood"></div>
					<input type= "hidden" id = "inputMood" name = "reviewMood" value="" />
					
				</td>
			</tr>
			<tr>
				
				<td>
				     &nbsp;&nbsp;
					<form id="rating1" class="taste">
					  <fieldset class="starability-growRotate">
					    <legend>맛 평점 </legend>
					    <input type="radio" id="rate15" name="taste-rating" value="5" class="taste-rating"/>
					    <label for="rate15" title="Amazing">5 stars</label>
					    <input type="radio" id="rate14" name="taste-rating" value="4" class="taste-rating"/>
					    <label for="rate14" title="Very good">4 stars</label>
					    <input type="radio" id="rate13" name="taste-rating" value="3" class="taste-rating"/>
					    <label for="rate13" title="Average">3 stars</label>
					    <input type="radio" id="rate12" name="taste-rating" value="2" class="taste-rating"/>
					    <label for="rate12" title="Not good">2 stars</label>
					    <input type="radio" id="rate11" name="taste-rating" value="1" class="taste-rating"/>
					    <label for="rate11" title="Terrible">1 star</label>
					  </fieldset>
					</form>
					<div id="reviewTaste" name="reviewTaste"></div>
					<input type= "hidden" id = "inputTaste" name = "reviewTaste" value="" />
				</td>
			</tr>
			<tr>
				<td>
				      &nbsp;&nbsp;
					<form>
					  <fieldset class="starability-growRotate">
					    <legend>가격 평점</legend>
					    <input type="radio" id="rate25" name="price-rating" value="5" class="price-rating"/>
					    <label for="rate25" title="Amazing">5 stars</label>
					    <input type="radio" id="rate24" name="price-rating" value="4" class="price-rating"/>
					    <label for="rate24" title="Very good">4 stars</label>
					    <input type="radio" id="rate23" name="price-rating" value="3" class="price-rating"/>
					    <label for="rate23" title="Average">3 stars</label>
					    <input type="radio" id="rate22" name="price-rating" value="2" class="price-rating"/>
					    <label for="rate22" title="Not good">2 stars</label>
					    <input type="radio" id="rate21" name="price-rating" value="1" class="price-rating"/>
					    <label for="rate21" title="Terrible">1 star</label>
					  </fieldset>
					</form>
					<div id="reviewPrice" name="reviewPrice"></div>
					<input type= "hidden" id = "inputPrice" name = "reviewPrice" value="" />
				</td>
			</tr>
			<tr>
				
				<td>
				    &nbsp;&nbsp;
					<form>
					  <fieldset class="starability-growRotate">
					    <legend>서비스 평점</legend>
					    <input type="radio" id="rate35" name="service-rating" value="5" class="tatal-rating"/>
					    <label for="rate35" title="Amazing">5 stars</label>
					    <input type="radio" id="rate34" name="service-rating" value="4" class="tatal-rating"/>
					    <label for="rate34" title="Very good">4 stars</label>
					    <input type="radio" id="rate33" name="service-rating" value="3" class="tatal-rating"/>
					    <label for="rate33" title="Average">3 stars</label>
					    <input type="radio" id="rate32" name="service-rating" value="2" class="tatal-rating"/>
					    <label for="rate32" title="Not good">2 stars</label>
					    <input type="radio" id="rate31" name="service-rating" value="1" class="tatal-rating"/>
					    <label for="rate31" title="Terrible">1 star</label>
					  </fieldset>
					</form>
					<div id="reviewService" name="reviewService"> </div><br/><br/>
					<input type= "hidden" id = "inputService" name = "reviewService" value="" />
					
					<div><span style="font-weight: bold; font-size: 16pt;">총 평점</span></div>
					<input type= "hidden" id = "inputAvgScore" name = "reviewAvgScore" value="" />
					<div id="total-result" name="reviewScore" style="font-weight: bold; font-size: 16pt;"></div>
				</td>
			</tr>
			<tr>
				<th>리뷰 작성</th>
			</tr>
			<tr>
            	<td><textarea name="reviewContent" class="form-control mylong" rows="5" placeholder="리뷰 내용"></textarea></td>
         	</tr>
         	
         	<%-- 파일첨부 타입 추가하기  --%>
         	<tr>
         	<th>사진 올리기</th>
         	</tr>
         	<tr>
         		<td>
         		사진갯수 :
         		<select name="attachNum" id="attachNum" class="form-control" style="width: 13%; display: inline;">
         			<option value="0">0</option>
         			<option value="1">1</option>
         			<option value="2">2</option>
         			<option value="3">3</option>
         			<option value="4">4</option>
         			<option value="5">5</option>
         		</select>
         		<br/>
         		<div id="result"></div>
         		</td>
         	</tr>
         	         	
         	<tr>
         		<th>가격별 테마</th>
         	</tr>
         	<tr align="center">	
         		<td>
         		<input type="checkbox" value="single" />혼밥&nbsp;&nbsp;
         		<input type="checkbox" value="family" />가족&nbsp;&nbsp;
         		<input type="checkbox" value="cost" />가성비&nbsp;&nbsp;
         		<input type="checkbox" value="luxury" />고급스러움<br/>
         		<input type="checkbox" value="drink" />술 안주&nbsp;&nbsp;
         		<input type="checkbox" value="night" />야식&nbsp;&nbsp;
         		<input type="checkbox" value="feel" />분위기 좋음&nbsp;&nbsp;
         		<input type="checkbox" value="party" />회식&nbsp;
         		</td>
         	
         	
         	</tr>
         	
		</table>
		
		<input type="text" name ="userSeq" value="${sessionScope.loginUser.userSeq}" />
		<input type="text" name ="restSeq" value="${restSeq}" />
		<br/>
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goWrite();">쓰기</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goReset();">취소</button>
		
	
	</form>
	</div>
</body>
</html>