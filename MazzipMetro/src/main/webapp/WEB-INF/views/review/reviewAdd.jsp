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
/* ### 테마 테이블 관련 ### */
table#dx_theme {border: solid 1px gray; padding: 10px; border-collapse: collapse;}
table#dx_theme th{text-align: center; height: 20px; padding: 2px;border: solid 1px gray; background-color: #EEEEEE;}
table#dx_theme td{text-align: center; height:  35px; padding: 5px;border: solid 1px gray;}
#theme_icon_single 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_single.png") no-repeat; background-position: center;}
#theme_icon_family 	{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_family.png") no-repeat; background-position-x: center;}
#theme_icon_cost 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_cost.png") no-repeat; background-position-x: center;}	
#theme_icon_luxury 	{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_luxury.png") no-repeat; background-position-x: center;}
#theme_icon_forDrink  {background:url("<%=request.getContextPath()%>/resources/images/theme_icon_forDrink.png") no-repeat; background-position-x: center;}
#theme_icon_night 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_night.png") no-repeat; background-position-x: center;}
#theme_icon_mood 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_mood.png") no-repeat; background-position-x:center;}
#theme_icon_people 	{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_people.png") no-repeat; background-position-x: center;}
/* 체크박스 대신 체크문자 사용하기 */
input[name=theme]{  
    display: none;  
}
/* ex) div + p	  Selects all <p> elements that are placed immediately after <div> elements*/
input[name=theme] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
}
/* unchecked */
input[name=theme]+ label:before {     
    content: ""; 
    display: inline-block;  
    width: 29px;  
    height: 19px;  
    margin-right: 10px;  
    position: relative;  
    left: 0;  
}
/* checked */
input[name=theme]:checked + label:before { 
    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 24px; 
    font-weight:800; 
    color: lime;
    width: 29px;  
    height: 19px; 
    text-align: center;  
    line-height: 22px;  
} 
/* ###태그 테이블 관련 ###*/
table#dx_tag {border: solid 1px gray; padding: 10px; border-collapse: collapse;}
table#dx_tag th{text-align: center;  width: 50px; height: 20px; padding: 2px;border: solid 1px gray; background-color: #EEEEEE; vertical-align: middle; }
table#dx_tag td{text-align: center;  height:  50px;padding: 5px;border: solid 1px gray;}
#tag_icon_korean 		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_korean.png") no-repeat; background-position: center; background-size: 150px;}
#tag_icon_japanese		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_japanese.jpg") no-repeat; background-position: center; background-size: 127px;}
#tag_icon_chinese		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_chinese.png") no-repeat; background-position: center; background-size: 145px;}	
#tag_icon_western 		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_western.png") no-repeat; background-position: center; background-size: 173px;}
#tag_icon_enAsian		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_enAsian.png") no-repeat; background-position: center; background-size: 166px;}
#tag_icon_meet 		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_meet.png") no-repeat; background-position: center; background-size: 80px;}
#tag_icon_fish 			{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_fish.png") no-repeat; background-position: center; background-size: 80px;}
#tag_icon_vege 		{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_vege.png") no-repeat; background-position: center ; background-size: 80px;}	
#tag_icon_rice			{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_rice.png") no-repeat; background-position: center ; background-size: 70px;}
#tag_icon_noodle 	{background:url("<%=request.getContextPath()%>/resources/images/tag_icon_noodle.png") no-repeat; background-position: center 5; background-size: 96px;}
/* 체크박스 대신 체크문자 사용하기 */
input[name=reviewBgTag], input[name=reviewMdTag] {  
    display: none;  
}
/*=== restBgTag=== */
input[name=reviewBgTag] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
}
/* unchecked */
input[name=reviewBgTag]+ label:before {     
    content: ""; 
    display: inline-block;  
    width: 29px;  
    height: 19px;  
    margin-right: 10px;  
    position: relative;  
    left: 0;  
}
/* checked */
input[name=reviewBgTag]:checked + label:before { 
    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 24px; 
    font-weight:800; 
    color: lime;
    width: 29px;  
    height: 19px; 
    text-align: center;  
    line-height: 22px;  
} 
/* ===reviewMdTag=== */
input[name=reviewMdTag] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
}
/* unchecked */
input[name=reviewMdTag]+ label:before {     
    content: ""; 
    display: inline-block;  
    width: 29px;  
    height: 19px;  
    margin-right: 10px;  
    position: relative;  
    left: 0;  
}
/* checked */
input[name=reviewMdTag]:checked + label:before { 
    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 24px; 
    font-weight:800; 
    color: lime;
    width: 29px;  
    height: 19px; 
    text-align: center;  
    line-height: 22px;  
} 
</style>

<script type="text/javascript">
	
	
	//우철_총 평점
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
			$("#total-result").append("총평점 : <span style='color:red;'>"+total+"</span>점");
			$("#inputAvgScore").val(total);
		}
		else
		{
			/* $("#total-result").hide(); */	
		}
		
	}
	
	// 우철_리뷰 쓰기
	function goWrite(event) {
		
		var reviewTitle = $('#reviewTitle').val();
		var reviewContent = $('#reviewContent').val();
		var attach = $('#attach').val();
		var inputAvgScore = $('#inputAvgScore').val();

		 if(attach == null){
			alert("사진은 1장 이상 필수입니다.");
			event.preventDefault();
			} 
		 if(reviewTitle == ""){
			alert("제목은 필수입니다.");
			event.preventDefault();
			}
		 if(inputAvgScore == ""){
			alert("평점은 전부 입력하셔야 합니다.");
			event.preventDefault();
			}
		 if(reviewContent == ""){
			alert("리뷰 내용은 필수입니다.");
			event.preventDefault();
			}
		/* <c:if test="$('#attach').val() == null">
		alert("사진은 1장 이상 필수입니다.");
		event.preventDefault();
		</c:if>
		
		<c:if test="reviewTitle == null">
			alert("제목은 필수입니다.");
			event.preventDefault();
		</c:if>
		
		<c:if test="$('#reviewContent').val() == null">
			alert("리뷰 내용은 필수입니다.");
			event.preventDefault();
		</c:if>
		
		<c:if test="$('#total-result').val() == null">
			alert("평점은 전부 입력하셔야 합니다.");
			event.preventDefault();
		</c:if>	 */
		
		var writeFrm = document.writeFrm;
		writeFrm.submit();
	}
	// 우철_취소버튼
	function goReset() {
		var writeFrm = document.writeFrm;
		writeFrm.reset();
		$("#result").empty();
	}
	
	$(document).ready(function(){
		
		// 우선 모든 테마체크박스를 disabled한다.
		$("[name=reviewBgTag]").attr("disabled", true).next().css('cursor','not-allowed');
		$("[name=reviewMdTag]").attr("disabled", true).next().css('cursor','not-allowed');
		
		//해당 음식점 대분류/중분류에 있는 체크박스는 disabled: false 만들기
		<c:if test="${not empty restBgTagArr}">
		<c:forEach var="restBgTag" items="${restBgTagArr}">
			var restBgTag = '${restBgTag}';
			$("[name=reviewBgTag]").each(function(){
				if(restBgTag == $(this).val())
					$(this).attr('disabled', false).next().css('cursor','pointer');
			});
		</c:forEach>
		</c:if>
		
		//alert("${restMdTagArr}");
		
		<c:if test="${not empty restMdTagArr}">
		<c:forEach var="restMdTag" items="${restMdTagArr}">
			var restMdTag = '${restMdTag}';
			$("[name=reviewMdTag]").each(function(){
				if(restMdTag == $(this).val())
					$(this).attr('disabled', false).next().css('cursor','pointer');
			});
		</c:forEach>
		</c:if>
		
		// 리뷰 제목 글자 수 제한
		$("#reviewTitle").keyup(function(){
			var qnaCommentLength = $("#reviewTitle").val().length;
			
			if(18 < qnaCommentLength){
				alert("입력가능한 글자수는18자 입니다");
				$("#reviewTitle").val("");
			}
		});	
		
		
		$("[name=taste-rating]").click(function(){
			var html = "";
			var taste = $(':radio[name=taste-rating]:checked').val();
			
			var html= taste;
						
			$("#reviewTaste").empty();
			//$("#reviewTaste").append(html+"점");
			$("#inputTaste").val(taste);
			getTotalRating();
		});
		
		// 우철_ 분위기평점
		$("[name=mood-rating]").click(function(){
			
			var html = "";
			var mood = $(':radio[name=mood-rating]:checked').val();
			
			var html= mood;
						
			$("#reviewMood").empty();
			//$("#reviewMood").append(html+"점");
			$("#inputMood").val(mood);
			getTotalRating();
		});
		
		// 우철_ 가격평점
		$("[name=price-rating]").click(function(){
			var html = "";
			var price = $(':radio[name=price-rating]:checked').val();
				
			var html= price;
						
			$("#reviewPrice").empty();
			//$("#reviewPrice").append(html+"점");
			$("#inputPrice").val(price);
			getTotalRating();
		});
		
		// 우철_ 서비스평점
		$("[name=service-rating]").change(function(){
			var html = "";
			var service = $(':radio[name=service-rating]:checked').val();
				
			var html= service;
						
			$("#reviewService").empty();
			//$("#reviewService").append(html+"점");
			$("#inputService").val(service);
			getTotalRating();
		});
		
		
			
		
		// 우철_ 사진넣기
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
					html += "<input type='file' name='attach' id='attach' class='btn btn-default' />";
				}
				
				$("#result").empty();
				$("#result").append(html);	
			}
		});
		
		
		$('#attach').bind('change', function() {
			alert(this.files[0].size);
			});
	});// end of ready
	
</script>

</head>
<body>
	
	
	<div class="container" style="margin-bottom: 50px;">
	
		<h2 style="margin-left: 30px;">${rest.restname} <span style="font-size: 15px;">리뷰 작성하기</span></h2>
		<hr/>
		<div style="float:left; margin-left : 50px; width: 40%;">
			<img src="<%= request.getContextPath() %>/files/rest/${rest.restimg}" width="200px" />
		</div><br/>	
		<div style="float:left; width: 40%;">
			${rest.shortaddr}<br/> <br/> 
			<span style="color:blue">${rest.restbgtag}</span><br/> <br/> 
			<span style="color:skyblue">${rest.restmdtag}</span><br/>
		</div>
	
	 	<%-- >>>> 파일첨부하기 enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	 	
		<div style="clear:both;" align="center">
			<form name="writeFrm" action="<%= request.getContextPath() %>/reviewAddEnd.eat" method="post" enctype="multipart/form-data" >
				<table id="table" class="table table-bordered" style="width: 69%; margin-top: 0px; border: gray 1px solid">
					<tr>
						<th colspan="2">제목<span style="color:red;">*</span></th>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type="text" name="reviewTitle" id="reviewTitle" class="form-control" value="" placeholder="최대 18자"/>
							<input type="hidden" id="reviewHit" name="reviewHit" value="like!"/>
						</td>
					</tr>			
					<tr>
						<th colspan="2">평점<span style="color:red;">*</span></th>
					</tr>
					<tr>
						<td align = "center">
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
						<td align = "center">
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
						<td align = "center">
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
						<td align = "center">
							<!-- 가격평점 td height 조정이 불가한 관계로 임시로 줄바꿈 코드 삽입 -->
							<br/> 
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
							
							
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<!-- <div><span style="font-weight: bold; font-size: 16pt;">총 평점</span></div> -->
							<input type= "hidden" id = "inputAvgScore" name = "reviewAvgScore" value="" />
							<div id="total-result" name="reviewScore" style="font-weight: bold; font-size: 16pt;"></div>
						</td>
					</tr>
					<tr>
						<th colspan="2">리뷰 작성<span style="color:red;">*</span></th>
					</tr>
					<tr>
		            	<td colspan="2"><textarea name="reviewContent" id="reviewContent" class="form-control mylong" rows="5" placeholder="리뷰 내용" value=""></textarea></td>
		         	</tr>
		         	
		         	<%-- 파일첨부 타입 추가하기  --%>
		         	<tr>
		         	<th colspan="2">사진 올리기<span style="color:red;">*</span></th>
		         	</tr>
		         	<tr>
		         		<td colspan="2">
		         		사진갯수 :
		         		<select name="attachNum" id="attachNum" class="form-control" style="width: 33%; display: inline;">
		         			<option value="0">사진을 선택해주세요</option>
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
		         	</table>
		         	
		         	
					
					<!-- 테마 테이블 -->
					<table id="dx_theme" class="table table-bordered"  style="width: 83%; margin-top: 20px;">
						<tr>
							<th colspan="4" style="background-color:rgba(221, 249, 163, 0.38); ">음식점의 테마를 선택하세요.</th> 
			         	</tr>
						<tr><th>혼밥</th><th>가족</th><th>가성비</th><th>고급스러움</th></tr>
						
						<tr>
							<td id="theme_icon_single">
								<input type="checkbox" id="chk_single" name="theme" value="혼밥"/>
								<label for="chk_single"></label>
							</td>
							<td id="theme_icon_family">
								<input type="checkbox" id="chk_family" name="theme" value="가족"/>
								<label for="chk_family"></label>
							</td>
							<td id="theme_icon_cost">
								<input type="checkbox" id="chk_cost" name="theme" value="가성비"/>
								<label for="chk_cost"></label>
							</td>
							<td id="theme_icon_luxury">
								<input type="checkbox" id="chk_luxury" name="theme"  value="고급스러움"/>
								<label for="chk_luxury"></label>
							</td>
							</tr>
							
							<tr><th>술 안주</th><th>야식</th><th>분위기 좋음</th><th>회식</th></tr>
							<tr>
							<td  id="theme_icon_forDrink">
								<input type="checkbox" id="chk_forDrink" name="theme" value="술 안주"/>
								<label for="chk_forDrink"></label>
							</td>
							<td  id="theme_icon_night">
								<input type="checkbox" id="chk_night" name="theme" value="야식"/>
								<label for="chk_night"></label>
							</td>
							<td  id="theme_icon_mood">
								<input type="checkbox" id="chk_mood" name="theme" value="분위기 좋음"/>
								<label for="chk_mood"></label>
							</td>
							<td  id="theme_icon_people">
								<input type="checkbox" id="chk_people" name="theme"  value="회식"/>
								<label for="chk_people"></label>
							</td>
						</tr>
					</table>
					
					
					<!-- 태그 테이블 -->
					<table id="dx_tag" style="width: 83%; margin-top: 20px;">
					<tr>
						<th colspan="5" style="background-color:rgba(221, 249, 163, 0.38); "> 드신 메뉴의 태그를 선택하세요.</th> 
		         	</tr>
		         	<tr>
						<th colspan="5" style="background-color:rgba(221, 249, 163, 0.38); height: 10px; padding:1px; "><span style="font-size: 11px;">대분류 선택</span></th> 
		         	</tr>
					<tr><th>한식</th><th>양식</th><th>일식</th><th>중식</th><th>동남아</th></tr>
					
					<tr>
						<td id="tag_icon_korean">
							<input type="checkbox" id="chk_korean" name="reviewBgTag" value="한식"/>
							<label for="chk_korean"></label>
						</td>
						<td id="tag_icon_western">
							<input type="checkbox" id="chk_western" name="reviewBgTag" value="양식"/>
							<label for="chk_western"></label>
						</td>
						<td id="tag_icon_japanese">
							<input type="checkbox" id="chk_japanese" name="reviewBgTag" value="일식"/>
							<label for="chk_japanese"></label>
						</td>
						<td id="tag_icon_chinese">
							<input type="checkbox" id="chk_chinese" name="reviewBgTag"  value="중식"/>
							<label for="chk_chinese"></label>
						</td>
						<td id="tag_icon_enAsian">
							<input type="checkbox" id="chk_neAsian" name="reviewBgTag"  value="동남아"/>
							<label for="chk_enAsian"></label>
						</td>
						</tr>
						
						<tr>
							<th colspan="5" style="background-color:rgba(221, 249, 163, 0.38); height: 10px; padding:1px; "><span style="font-size: 11px;">중분류 선택</span></th> 
			         	</tr>
						<tr><th>고기류</th><th>어폐류</th><th>채소류</th><th>밥류</th><th>면류</th></tr>
						<tr>
						<td  id="tag_icon_meet">
							<input type="checkbox" id="chk_meet" name="reviewMdTag" value="고기"/>
							<label for="chk_meet"></label>
						</td>
						<td  id="tag_icon_fish">
							<input type="checkbox" id="chk_fish" name="reviewMdTag" value="물고기"/>
							<label for="chk_fish"></label>
						</td>
						<td  id="tag_icon_vege">
							<input type="checkbox" id="chk_vege" name="reviewMdTag" value="채소"/>
							<label for="chk_vege"></label>
						</td>
						<td  id="tag_icon_rice">
							<input type="checkbox" id="chk_rice" name="reviewMdTag"  value="밥"/>
							<label for="chk_rice"></label>
						</td>
						<td  id="tag_icon_noodle">
							<input type="checkbox" id="chk_noodle" name="reviewMdTag"  value="면"/>
							<label for="chk_noodle"></label>
						</td>
					</tr>
					</table>
					
				<input type="hidden" name ="userSeq" value="${sessionScope.loginUser.userSeq}" />
				<input type="hidden" name ="restSeq" value="${restSeq}" />
				<br/>
				
				<button type="button" class="btn btn-default" style="margin-right: 10px;" onClick="goWrite();">쓰기</button>
				<button type="button" class="btn btn-default" style="margin-right: 10px;" onClick="goReset();">취소</button>
				
			
			</form>
		</div>
	</div>
</body>
</html>