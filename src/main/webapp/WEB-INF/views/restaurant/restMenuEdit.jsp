<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 기본 jquery 라이브러리 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>

<!-- 부트스트랩 라이브러리 -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<style>
	.table{
			border : solid 1px black;
			padding-right : 10px;
			padding-left : 10px;
			margin : 20px;
			width : 85%;
			}
	
	.lcontent {
			border : solid 1px black;
			padding : 10px;
			width : 80px;
	}
	
	.rcontent {
			border : solid 1px black;
			padding : 10px;
	}
</style>

<script type = "text/javascript">
 
	$(document).ready(function(){
		eventChecked();
	});
	
	// 태그에 체크하기
	function eventChecked(){
		
		<c:forEach var = "list" items = "${menuList}" varStatus="status" >
			$("input:checkbox[id='${list.menuEvent}${status.index}']").prop("checked",true);
			$(".${list.menuSort}${status.index}").val("${list.menuSort}");
		</c:forEach>
		
	}
	
	// 테이블 삭제
	function menuDel(divId){
		$("#"+divId+" tr").remove(); 
	}
	
	// 메뉴 이벤트를 1개만 선택 가능하도록 한 함수
	function oneCheckbox(ckbox, name){

		var ckboxName = name
		var ckboxArr = document.getElementsByName(ckboxName);
			
		for (var i = 0; i < ckboxArr.length; i++) {
			
			if (ckboxArr[i] != ckbox) {
				ckboxArr[i].checked = false;
			}
		}
	} 

	function showCurrImg(input){
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			
			reader.onload = function(e){
				$("#currImg").attr('src', e.target.result);
			}
			
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function menuAdd(){
		var num = $("#addMenuNum").val();
		num++;
		var html = "";
		
			html += "<div align ='center' id = 'div"+num+"'>"
			html += "<input type = 'hidden' name = 'menuSeq' value = '0' />"
			html += "<table class = 'table'>"
			html += "<tr>"
			html += "<th style = 'border : solid 1px black; background-color: grey;' colspan= '6'></th>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴명</b></td>"
			html += "<td class = 'lcontent' align='left'>"
			html += "<input type='text' class='menuName' name='menuName' id='menuName' /></td>"
			html += "<td style = 'font-size : 11pt;'><b>한 줄 설명</b></td>"
			html += "<td class = 'rcontent' align='left' colspan = '3'>"
			html += "<input type='text' class='menuContent' name='menuContent' id='menuContent' size = '65'/></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴가격</b></td>"
			html += "<td class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
			html += "<input type='text' class='menuPrice' name='menuPrice' id='menuPrice'/></td>"
			html += "<td style = 'font-size : 11pt;' rowspan='2'><b>메뉴이미지</b></td>"
			html += "<td class = 'rcontent' id='addImg' rowspan='2' style = 'padding-left : 40px; border-right-width: 0px; position : relative; font-size: 10pt; text-align: left;'><img src=\"\" id='currImg' width='100px;' /></td>"	
			html += "<td class = 'lcontent' style = 'border-left-width: 0px; vertical-align: middle;' rowspan='2'><input type='file' name='menuImgFile' onchange = 'showCurrImg(event);' /></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>세일가격</b></td>"
			html += "<td class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
			html += "<input type='text' class='menuSalePrice' name='menuSalePrice' id='menuSalePrice' value = '0' /></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴분류</b></td>"
			html += "<td class = 'lcontent' align='left'>"
			html += "<select name = 'menuSort' style = 'width: 100px; height: 25px; font-size: 12pt;'>"
			html += "<option value='식사류'>식사류</option>"
			html += "<option value='음료'>음료</option>"
			html += "<option value='디저트'>디저트</option>"
			html += "<option value='기타'>기타</option>"
			html += "</select>"
			html += "</td>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴이벤트</b></td>"
			html += "<td class = 'rcontent' align='left' colspan = '3' style = 'font-size : 11pt;'>"
			html += "<input type = 'checkbox' name = \"menuEvent"+num+"\" id=\"신메뉴"+num+"\" value = \"신메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+num+"');\" /><label for=\"신메뉴"+num+"\">신메뉴</label>&nbsp;"
			html += "<input type = 'checkbox' name = \"menuEvent"+num+"\" id=\"간판메뉴"+num+"\" value = \"간판메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+num+"');\" /><label for=\"간판메뉴"+num+"\">간판메뉴</label>&nbsp;"
			html += "<input type = 'checkbox' name = \"menuEvent"+num+"\" id=\"기간한정"+num+"\" value = \"기간한정\" onClick=\"oneCheckbox(this, 'menuEvent"+num+"');\" /><label for=\"기간한정"+num+"\">기간한정</label>&nbsp;"
			html += "<input type = 'checkbox' name = \"menuEvent"+num+"\" id=\"계절한정"+num+"\" value = \"계절한정\" onClick=\"oneCheckbox(this, 'menuEvent"+num+"');\" /><label for=\"계절한정"+num+"\">계절한정</label>&nbsp;"
			html += "<input type = 'checkbox' name = \"menuEvent"+num+"\" id=\"이벤트메뉴"+num+"\" value = \"이벤트메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+num+"');\" /><label for=\"이벤트메뉴"+num+"\">이벤트메뉴</label>"
			html += "</td>"
			html += "</tr>"
			html += "<tr align='center'>"
			html += "<td colspan='6'>"
			html += "<button type = 'button' onClick = \"menuDel('div"+num+"');\">메뉴삭제</button>"
			html += "</td>"
			html += "</tr>"
			html += "</table>"
			html += "</div>"
				
			$("#addMenu").append(html); 
			
			html = "";
			
			$("#addMenuNum").val(num);
	}
		
	
	
</script>


<div align="center">
<form name="registerFrm" action="restAddInfoEnd.eat?restSeq=${restSeq}" method="post" enctype="multipart/form-data">
<div>
	<button type = "button" onClick = "menuAdd()">메뉴추가</button>
	<input type = "hidden" id = "addMenuNum" value = "${menuList.size()}" />
</div>
<c:forEach var="list" items = "${menuList}" varStatus="status" >
	<div align ="center" id = "div${status.index}">
		<input type = "hidden" name = "menuSeq" value = "${menuSeq}" />
		<table class = "table" >
		<tr>
			<th style = "border : solid 1px black; background-color: grey;" colspan= "6"></th>
		</tr>
		<tr class = "tr">
			<td style = "font-size : 11pt;"><b>메뉴명</b></td>
			<td class = "lcontent" align="left">
				<input type="text" class="menuName" name="menuName" id="menuName" value = "${list.menuName}" /></td>
			<td style = 'font-size : 11pt;'><b>한 줄 설명</b></td>
			<td class = "rcontent" align="left" colspan = '3'>
				<input type="text" class="menuContent" name="menuContent" id="menuContent" size = "65" value = "${list.menuContent}" /></td>
		</tr>
		<tr class = "tr">
			<td style = 'font-size : 11pt;'><b>메뉴가격</b></td>
			<td class = "lcontent" align='left' style = "vertical-align: middle;">
			<input type='text' class="menuPrice" name="menuPrice" id="menuPrice" value = "${list.menuPrice}" /></td>
			<td style = 'font-size : 11pt;' rowspan="2"><b>메뉴이미지</b></td>
			<td class = "rcontent" id="addImg" rowspan="2" style = "padding-left : 40px; border-right-width: 0px; position : relative; font-size: 10pt; text-align: left;"><img src="<%=request.getContextPath() %>/files/thumb${list.menuImg}" id="currImg" width="100px;" /></td>	
				<td class = "lcontent" style = "border-left-width: 0px; vertical-align: middle;" rowspan="2"><input type='file' name='menuImgFile' onchange = "showCurrImg(event);" /></td>
		</tr>
		<tr class = "tr">
			<td style = 'font-size : 11pt;'><b>세일가격</b></td>
			<td class = "lcontent" align='left' style = "vertical-align: middle;">
			<input type='text' class="menuSalePrice" name="menuSalePrice" id="menuSalePrice" value = "${list.menuSalePrice}" /></td>
		</tr>
		<tr class = "tr">
			<td style = 'font-size : 11pt;'><b>메뉴분류</b></td>
			<td class = "lcontent" align='left'>
				<select name = 'menuSort' class = "${list.menuSort}${status.index}" style = 'width: 100px; height: 25px; font-size: 12pt;'>
					<option value="식사류">식사류</option>
					<option value="음료">음료</option>
					<option value="디저트">디저트</option>
					<option value="기타">기타</option>
				</select>
			</td>
			<td style = 'font-size : 11pt;'><b>메뉴이벤트</b></td>
			<td class = "rcontent" align='left' colspan = '3' style = 'font-size : 11pt;'>
				<input type = 'checkbox' name = "menuEvent${status.index}" id="신메뉴${status.index}" value = "신메뉴" onClick="oneCheckbox(this, 'menuEvent${status.index}');" /><label for="신메뉴${status.index}">신메뉴</label>&nbsp;
				<input type = 'checkbox' name = "menuEvent${status.index}" id="간판메뉴${status.index}" value = "간판메뉴" onClick="oneCheckbox(this, 'menuEvent${status.index}');" /><label for="간판메뉴${status.index}">간판메뉴</label>&nbsp;
				<input type = 'checkbox' name = "menuEvent${status.index}" id="기간한정${status.index}" value = "기간한정" onClick="oneCheckbox(this, 'menuEvent${status.index}');" /><label for="기간한정${status.index}">기간한정</label>&nbsp;
				<input type = 'checkbox' name = "menuEvent${status.index}" id="계절한정${status.index}" value = "계절한정" onClick="oneCheckbox(this, 'menuEvent${status.index}');" /><label for="계절한정${status.index}">계절한정</label>&nbsp;
				<input type = 'checkbox' name = "menuEvent${status.index}" id="이벤트메뉴${status.index}" value = "이벤트메뉴" onClick="oneCheckbox(this, 'menuEvent${status.index}');" /><label for="이벤트메뉴${status.index}">이벤트메뉴</label>
			</td>
		</tr>
		<tr align="center">
			<td colspan="6">
				<button type = "button" onClick = "menuDel('div${status.index}');">메뉴삭제</button>
			</td>
		</tr>
		</table>
	</div>
	</c:forEach>
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

