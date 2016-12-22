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
	
	// 메뉴 데이터 전송
	function goMenuEdit(){
		
		var num = $("#addMenuNum").val();
		var regexp = /[^[0-9]/gi;
		
		if (num == 0) {
			alert("최소 1개 이상의 메뉴를 작성해야 등록이 가능합니다.");
			return;
		}
		
		for (var i = 0; i < num; i++) {
			var menuName = $(".menuName"+i).val();
			var menuContent = $(".menuContent"+i).val();
			var menuPrice = $(".menuPrice"+i).val();
			var menuSalePrice = $(".menuSalePrice"+i).val();
			
			if (menuName == "") {
				alert("메뉴명을 작성해주세요");
				return;
			}
			
			if (menuContent == "") {
				alert("메뉴설명을 작성해주세요");
				return;
			}
			
			if (menuPrice == "") {
				alert("메뉴가격을 작성해주세요");
				return;
			}
			
			if(regexp.test(menuPrice)){
				alert(menuPrice);
				alert("메뉴가격은 숫자만 입력가능합니다");
				return;
			}
			
			if(regexp.test(menuSalePrice)){
				alert("세일가격은 숫자만 입력가능합니다");
				return;
			}
		}
		
		var registerFrm = document.registerFrm;
		registerFrm.submit();
	}
	
	// 태그에 체크하기
	function eventChecked(){
		
		<c:forEach var = "list" items = "${menuList}" varStatus="status" >
			$("input:checkbox[id='${list.menuEvent}${status.index}']").prop("checked",true);
			$(".${list.menuSort}${status.index}").val("${list.menuSort}");
		</c:forEach>
		
	}
	
	// 테이블 삭제(추가메뉴)
	function menuDel(divId){
		$("#"+divId+" tr").remove();
		$("#"+divId).remove();
	}
	
	// 테이블 삭제(기존메뉴)
	function menuHide(divId, menuStatus){
		$("#"+divId).hide();
		$("#"+menuStatus).val("1");
		
	}
	
	// 이미지 삭제
	function imageHide(status){
		$("#menuImg"+status).val("");
		$("#menuImgFile"+status).val("");
		$(".currImg"+status).hide();
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

	function showCurrImg(index){
		
		$(".currImg"+index).show();
		
		var preview = document.querySelector(".currImg"+index);
		var file = document.querySelector("#menuImgFile"+index).files[0];	

	    var reader = new FileReader();
	
	    reader.addEventListener("load", function () {
	        preview.src = reader.result;
	      }, false);
	
	      if (file) {
	        reader.readAsDataURL(file);
	      }
	}
	
	function menuAdd(){
		var num = $("#addMenuNum").val();
		var html = "";
		
			html += "<div align ='center' id = 'div"+num+"'>"
			html += "<input type = \"hidden\" name = \"menuImg\" value = \"\" />"
			html += "<input type = 'hidden' name = 'restSeq' value = '${restSeq}' />"
			html += "<input type = 'hidden' name = 'menuSeq' value = '0' />"
			html += "<input type = 'hidden' name = 'menuStatus' value = '0' />"
			html += "<table class = 'table'>"
			html += "<tr>"
			html += "<th style = 'border : solid 1px black; background-color: grey;' colspan= '6'></th>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴명</b></td>"
			html += "<td class = 'lcontent' align='left'>"
			html += "<input type='text' class=\"menuName"+num+"\" name=\"menuName\" id=\"menuName"+num+"\" value=\"\" /></td>"
			html += "<td style = 'font-size : 11pt;'><b>한 줄 설명</b></td>"
			html += "<td class = 'rcontent' align='left' colspan = '3'>"
			html += "<input type='text' class=\"menuContent"+num+"\" name=\"menuContent\" id=\"menuContent"+num+"\" value=\"\" size = '65'/></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴가격</b></td>"
			html += "<td class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
			html += "<input type='text' class=\"menuPrice"+num+"\" name=\"menuPrice\" id=\"menuPrice"+num+"\" value=\"\" /></td>"
			html += "<td style = 'font-size : 11pt;' rowspan='2'><b>메뉴이미지</b></td>"
			html += "<td class = 'rcontent' id='addImg' rowspan='2' style = 'padding-left : 40px; border-right-width: 0px; position : relative; font-size: 10pt; text-align: left;'><img src=\"<%=request.getContextPath() %>/files/menu/noImage.jpg\" class=\"currImg"+num+"\" width='100px;' /></td>"	
			html += "<td class = 'lcontent' style = 'border-left-width: 0px; vertical-align: middle;' rowspan='2'><input type='file' name='attach' id = \"menuImgFile"+num+"\" onchange = \"showCurrImg('"+num+"');\" /></td>"
			html += "<td class = 'lcontent' style = 'border-left-width: 0px; vertical-align: middle;' rowspan='2'><button type = 'button' onClick = \"imageHide("+num+");\">이미지 삭제</button></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>세일가격</b></td>"
			html += "<td class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
			html += "<input type='text' class=\"menuSalePrice"+num+"\" name=\"menuSalePrice\" id=\"menuSalePrice"+num+"\" value = '0' /></td>"
			html += "</tr>"
			html += "<tr class = 'tr'>"
			html += "<td style = 'font-size : 11pt;'><b>메뉴분류</b></td>"
			html += "<td class = 'lcontent' align='left'>"
			html += "<select name = \"menuSort\" style = 'width: 100px; height: 25px; font-size: 12pt;'>"
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
			num++;
			$("#addMenuNum").val(num);
	}
	
</script>


<div align="center">
<form name="registerFrm" action="restMenuEditEnd.eat" method="post" enctype="multipart/form-data">
<div>
	<table>
		<tr>
			<td style = "padding : 20px;" height = "40px" colspan="2" align="center" valign="middle">
				<button type = "button" onClick = "menuAdd()">메뉴추가</button>
				<input type = "hidden" id = "addMenuNum" name = "addMenuNum" value = "${menuList.size()}" />
			</td>
		</tr>
	</table>
</div>
<c:forEach var="list" items = "${menuList}" varStatus="status" >
	<div align ="center" >
		<input type = "hidden" name = "menuImg" id = "menuImg${status.index}" value = "${list.menuImg}" />
		<input type = "hidden" name = "restSeq" value = "${restSeq}" />
		<input type = "hidden" name = "menuSeq" value = "${list.menuSeq}" />
		<input type = "hidden" name = "menuStatus" id = "menuStatus${status.index}" value = "0" />
		<table class = "table" id = "div${status.index}" >
		<tr>
			<th style = "border : solid 1px black; background-color: grey;" colspan= "6"></th>
		</tr>
		<tr class = "tr">
			<td style = "font-size : 11pt;"><b>메뉴명</b></td>
			<td class = "lcontent" align="left">
				<input type="text" class="menuName${status.index} " name="menuName" id="menuName" value = "${list.menuName}" /></td>
			<td style = 'font-size : 11pt;'><b>한 줄 설명</b></td>
			<td class = "rcontent" align="left" colspan = '3'>
				<input type="text" class="menuContent${status.index} " name="menuContent" id="menuContent" size = "65" value = "${list.menuContent}" /></td>
		</tr>
		<tr class = "tr">
			<td style = 'font-size : 11pt;'><b>메뉴가격</b></td>
			<td class = "lcontent" align='left' style = "vertical-align: middle;">
			<input type='text' class="menuPrice${status.index} " name="menuPrice" id="menuPrice" value = "${list.menuPrice}" /></td>
			<td style = 'font-size : 11pt;' rowspan="2"><b>메뉴이미지</b></td>
			<td class = "rcontent" id="addImg" rowspan="2" style = "padding-left : 40px; border-right-width: 0px; position : relative; font-size: 10pt; text-align: left;"><img src="<%=request.getContextPath() %>/files/menu/thumb/thumb${list.menuImg}" class="currImg${status.index}" width="100px;" /></td>	
				<td class = "lcontent" style = "border-left-width: 0px; vertical-align: middle;" rowspan="2"><input type="file" name="attach" id = "menuImgFile${status.index}" value = "" onchange = "showCurrImg(${status.index});" /></td>
		</tr>
		<tr class = "tr">
			<td style = 'font-size : 11pt;'><b>세일가격</b></td>
			<td class = "lcontent" align='left' style = "vertical-align: middle;">
			<input type='text' class="menuSalePrice${status.index}" name="menuSalePrice" id="menuSalePrice" value = "${list.menuSalePrice}" /></td>
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
				<button type = "button" onClick = "menuHide('div${status.index}', 'menuStatus${status.index}');">메뉴삭제</button>
				<button type = "button" onClick = "imageHide(${status.index});">이미지 삭제</button>
			</td>
		</tr>
		</table>
	</div>
	</c:forEach>
<div id = "addMenu">
</div>

<div>
	<table>
		<tr>
			<td height = "40px" colspan="2" align="center" valign="middle">
				<a id="btnRegister" onClick="goMenuEdit();" href = "#" style = "width : 20%;"><span style = "color : black; font-weight : bold; font-size : 14pt;">등록신청</span></a>
			</td>
		</tr>
	</table>
</div>

</form>
</div>

