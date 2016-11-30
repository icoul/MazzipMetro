<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../top.jsp" />

<style>
	table {
	     width: 100%;
	     height : 20px;
	     border: solid gray 1px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	th#th {
		 background-color: silver;
		 font-size: 13pt;
	}
	
	table tr {
		border: solid gray 1px;

	}
	
	table td {
		padding-left : 15px;
		padding-top : 10px;
		padding-bottom : 10px;
		border: solid gray 1px;
	}
	
</style>

<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type = "text/javascript">
	$(document).ready(function(){
		
		$("#popular0").change(function(){
			alert("");
			/* alert($(".menuEvent1").is(":checked"));
			$(this).is(":checked") = true; */
		});
		
		$("#fileNum").change(function(){
			
			$("#fileAttach").empty();
			
			var num = $(this).val();
			var html= "<input type='file' name='attach' size='7'/><br/><br/>"
			for (var i = 0; i < num; i++) {
				$("#fileAttach").append(html);
			}
		});
		
		$("#menuNum").change(function(){
			
			$("#addMenu").empty();
			
			var num = $(this).val();
			var html = "";
			
			for (var i = 0; i < num; i++) {
				
					html +=  "<table class = 'table'>"
					html += "<tr>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>메뉴명</b></td>"
					html +=	"<td width='25%' align='left'><input type='text' name='menuName' />" 
					html +=	"</td>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>한 줄 설명</b></td>"
					html +=	"<td width='45%' align='left' colspan = '3'>"
					html +=	"<input type='text' name='menuContent' style = 'width: 450px;' /> "
					html +=	"</td>"
					html +=	"</tr>"
					html +=	"<tr>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>메뉴이미지</b></td>"
					html +=	"<td width='25%' align='left'><input type='file' name='menuImg'/> "
					html +=	"</td>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>메뉴가격</b></td>"
					html +=	"<td width='15%' align='left'>"
					html +=	"<input type='text' name='menuPrice' style = 'width: 100px;' />&nbsp;원"
					html +=	"</td>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>세일가격</b></td>"
					html +=	"<td width='15%' align='left'>"
					html +=	"<input type='text' name='menuSalePrice' style = 'width: 100px;' />&nbsp;원" 
					html +=	"</td>"
					html +=	"</tr>"
					html +=	"<tr>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>메뉴분류</b></td>"
					html +=	"<td width='25%' align='left'>"
					html +=	"<select name = 'menuSort' style = 'width: 100px; height: 25px; font-size: 12pt;'>"
					html +=	"<option value='식사류'>식사류</option>"
					html +=	"<option value='음료'>음료</option>"
					html +=	"<option value='디저트'>디저트</option>"
					html +=	"<option value='기타'>기타</option>"
					html +=	"</select>"
					html +=	"</td>"
					html +=	"<td width='10%' style = 'font-size : 11pt;'><b>메뉴이벤트</b></td>"
					html +=	"<td width='45%' align='left' colspan = '3' style = 'font-size : 11pt;'>"
					html +=	"<select name = 'menuEvent' style = 'width: 100px; height: 25px; font-size: 12pt;'>"
					html +=	"<option value='신메뉴'>신메뉴</option>"
					html +=	"<option value='간판메뉴'>간판메뉴</option>"
					html +=	"<option value='기간한정'>기간한정</option>"
					html +=	"<option value='계절한정'>계절한정</option>"
					html +=	"<option value='이벤트메뉴'>이벤트메뉴</option>"
					html +=	"</select>"
					html += "</td>"
					html += "</tr>"
					html += "</table>";
					
				$("#addMenu").append(html);
				
				html = "";
			}//end of for
		});
		
	});
	
	function goRegister(){

		var registerFrm = document.registerFrm;
		registerFrm.submit();
	}
	
</script>

<div style ="margin-top : 20px; background-color : #0E6DAC; border-radius: 6px;">
<span style = "padding-top : 30px; padding-left : 20px; font-size : 25pt; color : white;">업장등록</span>
</div>

<div align="center">
<form name="registerFrm" action="addRestaurantInfoEnd.eat" method="post" enctype="multipart/form-data">

<table class = "table">
	<tr>
		<td width="20%" style = "font-size : 14pt; vertical-align: middle;"><b>소개글</b></td>
		<td width="80%" align="left">
			<textarea name="content" id="content" style = "width : 97%; height: 200px;"></textarea>
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>소개이미지</b></td>
		<td width="80%" align="left">
			<select name = "fileNum" id = "fileNum" style = "width: 50px; height: 25px; font-size: 12pt;">
				<option value="0">0</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
			&nbsp;&nbsp; 업로드 할 이미지 갯수를 선택해주세요
			<br/>
			<br/>	
			<div id = "fileAttach">
			
			</div>
		</td>
	</tr>
	<tr>
		<td width="20%" rowspan="2" style = "font-size : 14pt; vertical-align: middle;" ><b>태그</b></td>
		<td width="80%" align="left">
		   <select name = "bgCat" id = "bgCat" style = "width: 100px; height: 25px; font-size: 12pt;">
		   		<option value="한식">한식</option>
		   		<option value="양식">양식</option>
		   		<option value="일식">일식</option>
		   		<option value="중식">중식</option>
		   		<option value="동남아">동남아</option>
		   </select>
		</td>
	</tr>
	<tr>
		<td width="80%" align="left">
			<input type = "checkbox" name = "mgCat" id="meet" value="meet" /><label for="meet">고기류</label>&nbsp;&nbsp;
			<input type = "checkbox" name = "mgCat" id="fish" value="fish" /><label for="fish">어폐류</label>&nbsp;&nbsp;
			<input type = "checkbox" name = "mgCat" id="vegetable" value="vegetable" /><label for="vegetable">채소류</label>&nbsp;&nbsp;
			<input type = "checkbox" name = "mgCat" id="rice" value="rice" /><label for="rice">밥류</label>&nbsp;&nbsp;
			<input type = "checkbox" name = "mgCat" id="noodle" value="noodle" /><label for="noodle">면류</label>
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt; vertical-align: middle;"><b>테마</b></td>
		<td width="80%" align="left">
		</td>
	</tr>
</table>

<div style ="margin-top : 20px; background-color : #0E6DAC; border-radius: 6px;" align ="left">
<span style = "padding-top : 30px; padding-left : 20px; font-size : 25pt; color : white;">메뉴추가</span>
</div>
<br/>
<span style = "padding-left : 20px; font-size : 15pt; color : black;" >추가할 메뉴의 갯수를 입력해주세요</span>
<select id="menuNum" style = "padding-left : 35px; width: 100px; height: 25px; font-size: 12pt;">
	<option value="0">0</option>
	<option value="1">1</option>
	<option value="2">2</option>
	<option value="3">3</option>
	<option value="4">4</option>
	<option value="5">5</option>
	<option value="6">6</option>
	<option value="7">7</option>
	<option value="8">8</option>
	<option value="9">9</option>
	<option value="10">10</option>
</select>

<div id = "addMenu">
</div>

<table>
	<tr>
		<td height = "40px" colspan="2" align="center" valign="middle">
			<a id="btnRegister" onClick="goRegister();" href = "#" style = "width : 20%;"><span style = "color : black; font-weight : bold; font-size : 14pt;">등록신청</span></a>
		</td>
	</tr>
</table>

</form>
</div>

<jsp:include page="../footer.jsp" />