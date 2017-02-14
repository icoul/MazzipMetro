<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../library.jsp" /> 
<jsp:include page="../top.jsp" />

<style>
	.table{
			padding-right : 10px;
			padding-left : 10px;
			margin : 20px;
			width : 85%;
			position : relative;
			}
	table.table tr td{vertical-align: middle;	}
	
	.lcontent {
			padding : 10px;
			width : 150px;
	}
	
	.rcontent {
			padding : 10px;
	}
	
</style>

<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type = "text/javascript">
	$(document).ready(function(){
		
		$("#fileAdd").click(function(){
			
			var fileIdNum = $("#fileIdNum").val();
			var limit = $("[name=attach]").length;
			var num = $("#fileNum").val();
			
			var limitNum = Number(limit) + Number(num);
			
			if (limit == 5 || limitNum > 5) {
				alert("파일은 5개까지만 등록 가능합니다");
				return;
			}
			
			var html = "<div id = 'file"+fileIdNum+"'><table = 'table'><tr><td><input type='file' name='attach' size='7'/></td>"
				html += "<td><button type = 'button' onClick = \"fileDel('file"+fileIdNum+"');\">이미지 삭제</button><br/></td></tr></table><br/></div>"
				
			for (var i = 0; i < num; i++) {
				$("#fileAttach").append(html);
				fileIdNum++;
			}
				
			$("#fileIdNum").val(fileIdNum);
		});
		
		$("#menuNum").change(function(){
			
			var count = $("#addMenuCount").val();
			var num = $(this).val();
			
			var menuNum = Number(count) + Number(num);
			
			var html = "";
			
			for (var i = count; i < menuNum; i++) {
					
					html += "<input type = 'hidden' name = 'restSeq' value = \"${restSeq}\" />"
					html += "<table class = 'table' id = 'table"+i+"'>"
					html += "<tr>"
						html += "<th style = 'border : solid 1px black; background-color: grey;' colspan= '7'></th>"
					html += "</tr>"
					html += "<tr class = 'tr'>"
						html += "<td width='10%' style = 'font-size : 11pt;'><b>메뉴명</b></td>"
						html += "<td class = 'lcontent' align='left'>"
							html += "<input type='text' class=\"menuName"+i+"\" name=\"menuName\" id=\"menuName"+i+"\" value=\"\" /></td>"
						html += "<td width='12%' style = 'font-size : 11pt;'><b>한 줄 설명</b></td>"
						html += "<td class = 'rcontent' align='left' colspan = '3'>"
							html += "<input type='text' class=\"menuContent"+i+"\" name=\"menuContent\" id=\"menuContent"+i+"\" value=\"\" size = '65'/></td>"
					html += "</tr>"
					html += "<tr class = 'tr'>"
						html += "<td width='40px' style = 'font-size : 11pt;'><b>메뉴가격</b></td>"
						html += "<td width='40px' class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
							html += "<input type='text' class=\"menuPrice"+i+"\" name=\"menuPrice\" id=\"menuPrice"+i+"\" value=\"\" /></td>"
						html += "<td width='40px' style = 'font-size : 11pt;' rowspan='2'><b>메뉴이미지</b></td>"
						html += "<td width='100px' height='150px' id='addImg' rowspan='2' ><img src=\"<%=request.getContextPath() %>/files/menu/thumb/thumbnoImage.jpg\" class=\"currImg"+i+"\" width='100px;' height='100px;' />"
						html += "</td>"
						html += "<td width='100px' style = ' vertical-align: middle;' rowspan='2'><input type='file' name='menuImgFile' id = \"menuImgFile"+i+"\" onchange = \"showCurrImg('"+i+"');\" /></span></td>"
						html += "<td width='120px' style = ' vertical-align: middle;' rowspan='2'><button type = 'button' onClick = \"imageHide("+i+");\">이미지 삭제</button></td>"
					html += "</tr>"
					html += "<tr class = 'tr'>"
						html += "<td width='40px' style = 'font-size : 11pt;'><b>세일가격</b></td>"
						html += "<td width='40px' class = 'lcontent' align='left' style = 'vertical-align: middle;'>"
							html += "<input type='text' class=\"menuSalePrice"+i+"\" name=\"menuSalePrice\" id=\"menuSalePrice"+i+"\" value = '0' /></td>"
					html += "</tr>"
					html += "<tr class = 'tr'>"
						html += "<td width='40px' style = 'font-size : 11pt;'><b>메뉴분류</b></td>"
						html += "<td width='40px' class = 'lcontent' align='left'>"
							html += "<select name = \"menuSort\" style = 'width: 100px; height: 25px; font-size: 12pt;'>"
							html += "<option value='식사류'>식사류</option>"
							html += "<option value='음료'>음료</option>"
							html += "<option value='디저트'>디저트</option>"
							html += "<option value='기타'>기타</option>"
							html += "</select>"
						html += "</td>"
						html += "<td width='40px' style = 'font-size : 11pt;'><b>메뉴이벤트</b></td>"
						html += "<td width='40px' class = 'rcontent' align='left' colspan = '3' style = 'font-size : 11pt;'>"
							html += "<input type = 'checkbox' name = \"menuEvent"+i+"\" id=\"신메뉴"+i+"\" value = \"신메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+i+"');\" /><label for=\"신메뉴"+i+"\">신메뉴</label>&nbsp;&nbsp;"
							html += "<input type = 'checkbox' name = \"menuEvent"+i+"\" id=\"간판메뉴"+i+"\" value = \"간판메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+i+"');\" /><label for=\"간판메뉴"+i+"\">간판메뉴</label>&nbsp;&nbsp;"
							html += "<input type = 'checkbox' name = \"menuEvent"+i+"\" id=\"기간한정"+i+"\" value = \"기간한정\" onClick=\"oneCheckbox(this, 'menuEvent"+i+"');\" /><label for=\"기간한정"+i+"\">기간한정</label>&nbsp;&nbsp;"
							html += "<input type = 'checkbox' name = \"menuEvent"+i+"\" id=\"계절한정"+i+"\" value = \"계절한정\" onClick=\"oneCheckbox(this, 'menuEvent"+i+"');\" /><label for=\"계절한정"+i+"\">계절한정</label>&nbsp;&nbsp;"
							html += "<input type = 'checkbox' name = \"menuEvent"+i+"\" id=\"이벤트메뉴"+i+"\" value = \"이벤트메뉴\" onClick=\"oneCheckbox(this, 'menuEvent"+i+"');\" /><label for=\"이벤트메뉴"+i+"\">이벤트메뉴</label>"
						html += "</td>"
					html += "</tr>"
					html += "<tr>"
						html += "<td width='40px' colspan='5' align='center'><button type = 'button' class='btn btn-default' onClick = \"menuDel('table"+i+"');\">메뉴삭제</button></td>"
					html += "</tr>"
					html += "</table>"
					
				$("#addMenu").append(html);
				$("#addMenuCount").val(menuNum);
				
				html = "";
			}//end of for
		});
		
	});
	
	// 업장 소개 이미지 삭제
	function fileDel(fileId){
		$("#"+fileId).remove();
	}
	
	// 메뉴 삭제
	function menuDel(tableId){
		$("#"+tableId+" tr").remove();
		$("#"+tableId).remove();
	}
	
	// 메뉴 이미지 삭제
	function imageHide(status){
		$("#menuImgFile"+status).val("");
		$(".currImg"+status).hide();
	}
	
	// 체크박스 1개만 체크 되도록
	function oneCheckbox(ckbox, name){

		var ckboxName = name
		var ckboxArr = document.getElementsByName(ckboxName);
			
		for (var i = 0; i < ckboxArr.length; i++) {
			
			if (ckboxArr[i] != ckbox) {
				ckboxArr[i].checked = false;
			}
		}
	} 
	
	// 업로드하면 바로 이미지가 보이도록
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
	
	// 등록
	function goRegister(){
		
		var content = $(".content").val();
		var menuNum = $("#menuNum").val();
		var menuName = $(".menuName").val();
		var menuContent = $(".menuContent").val();
		var menuPrice = $(".menuPrice").val();
		var menuSalePrice = $(".menuSalePrice").val();
		
		if (content == "") {
			alert("소개글을 작성해주세요");
			return;
		}
		
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
		
		var registerFrm = document.registerFrm;
		registerFrm.submit();
	}
	
</script>

<div class="subleftCon" style="height:auto; font-size:25px;">
<h3>추가 정보 등록</h3>
</div>

<div class="subrightCon" style="height:2500px;">
<jsp:include page="../userMyPage_Menubar.jsp" />
<form name="registerFrm" action="restAddInfoEnd.eat?restSeq=${restSeq}" method="post" enctype="multipart/form-data">

<table class = "table">
	<tr>
		<td width="20%" style = "font-size : 14pt; vertical-align: middle;"><b>소개글</b></td>
		<td width="80%" align="left">
			<textarea class = "content" name="content" id="content" style = "width : 97%; height: 200px;"></textarea>
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>소개이미지</b></td>
		<td width="80%" align="left">
			<select name = "fileNum" id = "fileNum" style = "width: 50px; height: 25px; font-size: 12pt;">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>
			&nbsp;&nbsp;<button type = "button" id = "fileAdd" class='btn btn-default'>추가</button> &nbsp;&nbsp;업로드 할 이미지 갯수를 선택해주세요
			<input type = "hidden" id = "fileIdNum" value = "0" />
			<br/>
			<br/>	
			<div id = "fileAttach">
			
			</div>
		</td>
	</tr>
</table>

<br/>
<table>
	<tr>
		<td style = "width : 400px; vertical-align: middle;"><span style = "padding-left : 20px; font-size : 15pt; color : black;" >추가할 메뉴의 갯수를 입력해주세요</span></td>
		<td style = "width : 50px; vertical-align: middle;"><select name = "menuNum" id="menuNum" style = "padding-left : 35px; width: 100px; height: 25px; font-size: 12pt;">
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
		</td>
		<td style = "width : 100px; vertical-align: middle;"><button type = "button" class="btn btn-default pull-right" onClick="goRegister();">등록신청</button></td>
	</tr>
</table>


<div id = "addMenu">
</div>
<input type = "hidden" id = "addMenuCount" value = "0" />

</form>
</div>

<jsp:include page="../footer.jsp" />