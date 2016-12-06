<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../top.jsp" />

<style>
	table#tblMemberRegister {
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
	
	table#tblMemberRegister tr {
		border: solid gray 1px;

	}
	
	table#tblMemberRegister td {
		padding-left : 20px;
		padding-top : 10px;
		padding-bottom : 10px;
		border: solid gray 1px;
	}
	
</style>

<script src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type = "text/javascript">
	$(document).ready(function(){

		$("#restCheck").click(function(){
			// 팝업창 띄우기
			var name = $("#name").val();
			
			var url = "restCheck.eat?name="+name;
			
			window.open(url,"restCheck",
	        "left=350px, top=100px, width=650px, height=500px, menubar=no, status=no, scrollbars=yes ");
		});
	});
	
	function goRegister(){
		var seq = $("#seq").val();
		var latitude = $("#latitude").val();
		
		if (seq == -1 && latitude == -1) {
			
			alert("업장검색 후 다시 진행해주세요");
			return;
		}
		
		var registerFrm = document.registerFrm;
		registerFrm.submit();
	}
	
</script>

<div style ="margin-top : 20px; background-color : #0E6DAC; border-radius: 6px;">
<span style = "padding-top : 30px; padding-left : 20px; font-size : 25pt; color : white;">업장등록</span>
</div>

<div align="center">
<form name="registerFrm" action="restRegister.eat" method="post" enctype="multipart/form-data">

<input type = "hidden" name = "seq" id = "seq" value="-1" />

<input type = "hidden" name = "latitude" id = "latitude" value="-1" />
<input type = "hidden" name = "longitude" id = "longitude" value="-1" />
<input type = "hidden" name = "metroId" id = "metroId" value="-1" />
<input type = "hidden" name = "dongId" id = "dongId" value="-1" />

<table class = "table" id="tblMemberRegister">
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>업장명</b></td>
		<td width="80%" align="left"><input type="text" name="name" id="name" /> 
			<span id="restCheck">업장검색</span>
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>대표이미지</b></td>
		<td width="80%" align="left">
			<input type="file" name="attach" size="7"/>
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>지번주소</b></td>
		<td width="80%" align="left">
		   <input type="text" name="addr" size="50" maxlength="100" />
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>도로명주소</b></td>
		<td width="80%" align="left">
		   <input type="text" name="newAddr" size="50" maxlength="100" />
		</td>
	</tr>
	<tr>
		<td width="20%" style = "font-size : 14pt;"><b>연락처</b></td>
		<td width="80%" align="left">
		    <input type="text" name="phone" id="phone" size="14" maxlength="14" />
		</td>
	</tr>
	<tr>
		<td height = "40px" colspan="2" align="center" valign="middle">
			<a id="btnRegister" onClick="goRegister();" href = "#" style = "width : 20%;"><span style = "color : black; font-weight : bold; font-size : 14pt;">등록신청</span></a>
		</td>
	</tr>
</table>
</form>
</div>

<jsp:include page="../footer.jsp" />