<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="library.jsp" />
<jsp:include page="top.jsp" />

<style>
table#dx_theme {border: solid 1px gray; padding: 10px;}
table#dx_theme th{text-align: center; width: 100px; height: 25px;padding: 5px;border: solid 1px gray;}
table#dx_theme td{text-align: center; width: 100px; height:  50px;padding: 10px;border: solid 1px gray; cursor: pointer;}


#theme_icon_single 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_single.png") no-repeat; background-position: center}
#theme_icon_family 	{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_family.png") no-repeat; background-position: center 5}
#theme_icon_cost 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_cost.png") no-repeat; background-position: center 5}	
#theme_icon_luxury 	{ background:url("<%=request.getContextPath()%>/resources/images/theme_icon_luxury.png") no-repeat; background-position: center 5}
#theme_icon_forDrink { background:url("<%=request.getContextPath()%>/resources/images/theme_icon_forDrink.png") no-repeat; background-position: center 5}
#theme_icon_night 		{ background:url("<%=request.getContextPath()%>/resources/images/theme_icon_night.png") no-repeat; background-position: center 5}
#theme_icon_mood 		{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_mood.png") no-repeat; background-position:center 5}
#theme_icon_people 	{background:url("<%=request.getContextPath()%>/resources/images/theme_icon_people.png") no-repeat; background-position: center 5}


/* 체크박스 대신 체크문자 사용하기 */
input[name=themeChk] {  
    display: none;  
}

/* ex) div + p	  Selects all <p> elements that are placed immediately after <div> elements*/
input[name=themeChk] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
}

/* unchecked */
input[name=themeChk]+ label:before {     

    content: ""; 
    display: inline-block;  
    width: 29px;  
    height: 18px;  
    margin-right: 10px;  
    position: absolute;  
    left: 0;  
}

/* checked */
input[name=themeChk]:checked + label:before { 

    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 53px; 
    font-weight:800; 
    color: red;
    width: 29px;  
    height: 18px; 
    text-align: center; 
    line-height: 1px;  

} 



</style>
<script>
$(document).ready(function(){
	
	/* td를 클릭해도 checkbox가 체크되도록 하자 */	
	$("#dx_theme td").click(function(){
		var bool = $(this).find("input:checkbox").prop("checked");
		if(bool){
			$(this).find("input:checkbox").prop("checked",false);
		} else {
			$(this).find("input:checkbox").prop("checked", true);
		}
		
		goThemeSearch(1);
		
	});
	
	getGuMetroNameList();
	
	// 마크표시를 안보이게 하는데, display, visibility등은 실제 클릭이벤트를 만들수 없기 때문에, opacity로 제어한다.
	$(".marked").css('opacity',0);
	
	// 받아온 테마 데이터가 있다면...
	//alert("${theme}");
	
	$("input:checkbox[name=themeChk]").each(function(){
		
		if($(this).val() == '${theme}'){
			$(this).prop('checked',true);
			 var markId ='mark_'+$(this).attr('id').substring(4);
			 $("#"+markId).css('opacity',1);
		}
	});
	
	<c:if test="${not empty theme}">
		//alert('not empty theme');
		goThemeSearch(1);
	</c:if>
	
	// 셀렉트 메뉴의 값이 바뀌면 함수를 호출한다.
	$("#selMenu_guName").change(function(){
		getDongNameList();
		goThemeSearch(1);
	});
	
	$("#selMenu_dongName").change(function(){
		if($("[name=themeChk]:checked").length == 0){
			alert("테마를 선택해주세요.");
			return;		
		}
		goThemeSearch(1);
	});
	
	$("#selMenu_metroName").change(function(){
		if($("[name=themeChk]:checked").length == 0){
			alert("테마를 선택해주세요.");
			return;		
		}
		goThemeSearch(1);
	});
	
	// 테마를 선택하면 체크이미지를 보여준다.
	/* $("[name=themeChk]").click(function(){
		
		//alert($(this).is('checked'));// 클릭하자마자는 false를 리턴한다. 이 메소드가 끝나면, true가 되는걸까?
		
		var chkId = 'chk_'+$(this).attr('id').substring(4); 
		 var markId ='mark_'+$(this).attr('id').substring(4);
		//alert(markId);
		
		if( $(this).is(':checked')) {
         	$("#"+markId).css('opacity',1);
		} else {
			$("#"+markId).css('opacity',0);
	    } 
		
	}); */
	
	// 사용자가 체크박스 값을 달리하면 바로 함수 호출한다.
	$("[name=themeChk]").change(function(){
		//alert($('form[name=themeFrm]').serialize());
		goThemeSearch(1);
		
	});
	
	
});// end of $(document).ready

function goThemeSearch(pageNo){
	//alert($("[name=themeChk]:checked").length);
	
	if($("[name=themeChk]:checked").length == 0){
		$("#themeResult").html('<p style="margin-top: 100px; font-size: 20px; font-weight: bold;"> 원하시는 테마를 선택해주세요.');
		return;		
	}
	
	// data 를 $('form[name=themeFrm]').serialize() 를 통해 전송한다. 배열은 checked값만 전송한다.
	$.ajax({
		url: "<%=request.getContextPath()%>/themeSearch.eat", 
		method:"GET",  		 // method
		data: $('form[name=themeFrm]').serialize()+"&pageNo="+pageNo,
		traditional: true,		 // 배열 데이터 전송용
		dataType: "html",        // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
		success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
			$("#themeResult").html(data);
			}
	});//end of $.ajax()
}

//동이름 셀렉트 메뉴 호출
function getDongNameList(){
	
	$.ajax({
			url:"<%=request.getContextPath()%>/adminDongNameList.eat",
			type :"GET",
			data: "guId="+$("#selMenu_guName").val(),
			dataType:"json",
			success: function(data){
						var dongNameList = data.dongNameList;
						
						var dongNameHtml = '<option value="dongId">동 선택하기</option>';
						
						for (var i = 0; i < dongNameList.length; i++) {
								dongNameHtml += '<option value="'+dongNameList[i].dongId+'">'+dongNameList[i].dongName+'</option>';
						}
						
						$("#selMenu_dongName").html(dongNameHtml);
			}, //end of success: function(data)
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} // end of error: function(request,status,error)
		}); //end of $.ajax()
}

//구이름/지하철이름 셀렉트 메뉴 호출
function getGuMetroNameList(){
	
	$.ajax({
			url:"<%=request.getContextPath()%>/adminGuMetroNameList.eat",
			type :"GET",
			dataType:"json",
			success: function(data){
						var guNameList = data.guNameList;
						var metroNameList = data.metroNameList;
						
						var guNameHtml = '<option value="guId">구 선택하기</option>';
						var metroNameHtml = '<option value="metroId">지하철 선택하기</option>';
						
						for (var i = 0; i < guNameList.length; i++) {
								guNameHtml += '<option value="'+guNameList[i].guId+'">'+guNameList[i].guName+'</option>';
						}
						
						$("#selMenu_guName").html(guNameHtml);
						
						for (var i = 0; i < metroNameList.length; i++) {
							metroNameHtml += '<option value="'+metroNameList[i].metroId+'">'+metroNameList[i].metroName+'</option>';				
						}
						$("#selMenu_metroName").html(metroNameHtml);
						
			}, //end of success: function(data)
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} // end of error: function(request,status,error)
		}); //end of $.ajax()
}
</script>

<div id="themeBox" style="padding: 30px;" align="center">
	<h2>테마별 검색</h2>
	<br/> 

	<form name="themeFrm">
		<table id="dx_theme">
			<tr><th>혼밥</th><th>가족</th><th>가성비</th><th>고급스러움</th><th>술 안주</th><th>야식</th><th>분위기 좋음</th><th>회식</th></tr>
			<tr>
				<td id="theme_icon_single">
					<input type="checkbox" id="chk_single" name="themeChk" value="혼밥"/>
					<label for="chk_single"></label>
				</td>
				<td id="theme_icon_family">
					<input type="checkbox" id="chk_family" name="themeChk" value="가족"/>
					<label for="chk_family"></label>
				</td>
				<td id="theme_icon_cost">
					<input type="checkbox" id="chk_cost" name="themeChk" value="가성비"/>
					<label for="chk_cost"></label>
				</td>
				<td id="theme_icon_luxury">
					<input type="checkbox" id="chk_luxury" name="themeChk"  value="고급스러움"/>
					<label for="chk_luxury"></label>
				</td>
				<td  id="theme_icon_forDrink">
					<input type="checkbox" id="chk_forDrink" name="themeChk" value="술 안주"/>
					<label for="chk_forDrink"></label>
				</td>
				<td  id="theme_icon_night">
					<input type="checkbox" id="chk_night" name="themeChk" value="야식"/>
					<label for="chk_night"></label>
				</td>
				<td  id="theme_icon_mood">
					<input type="checkbox" id="chk_mood" name="themeChk" value="분위기 좋음"/>
					<label for="chk_mood"></label>
				</td>
				<td  id="theme_icon_people">
					<input type="checkbox" id="chk_people" name="themeChk"  value="회식"/>
					<label for="chk_people"></label>
				</td>
			</tr>
		</table>
		
		<br/> <br/>
		<div class="container" style="width: 80%; margin: auto;" >
			<div class="row" style="width: 80%; margin: auto;" >
				<!-- 지하철 역명 선택 -->
				<div class="col-sm-3 col-sm-offset-2">
				<select name="selMenu_metroName" id="selMenu_metroName" class="form-control" ></select>
				</div>
				
				<!-- 구 이름 선택 -->
				<div class="col-sm-3">
				<select name="selMenu_guName" id="selMenu_guName" class="form-control"></select>
				</div>
				
				<!-- 동이름 선택 -->
				<div class="col-sm-3">
				<select name="selMenu_dongName" id="selMenu_dongName" class="form-control"><option value="dongId">동 선택하기(구를 먼저 선택)</option></select>
				</div>
			</div>
		</div> 
		
		
		
	</form>
	
	<div id="themeResult" style="min-height: 500px; margin: auto;">
	
		<p style="margin-top: 100px; font-size: 20px; font-weight: bold;"> 원하시는 테마를 선택해주세요.
	</div>
</div>




<jsp:include page="footer.jsp" />