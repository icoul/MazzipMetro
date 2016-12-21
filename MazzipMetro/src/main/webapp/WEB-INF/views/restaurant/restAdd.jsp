<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />
<style>
	
	table#tblMemberRegister {
	     width: 100%;
	     height : 20px;
	     border-collapse: collapse;
	     border-top : solid 3px #43A5AE;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	th#th {
		 background-color: silver;
		 font-size: 13pt;
	}
	
	tr.content{
		border: solid gray 1px;
		border-left-width: 0px;
		border-right-width: 0px;
		vertical-align: middle;
	}
	
	td.subject{
		background-color: #EFEFEF;
		font-weight : bold;
		font-family: 헤드라인;
		
	}
	
	table#tblMemberRegister td {
		padding-left : 20px;
		padding-top : 10px;
		padding-bottom : 10px;
		vertical-align: middle;
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
		
		var restBgTag = $(".restBgTag:checked").length;
		var restMdTag = $(".restMdTag:checked").length;
		
		if (seq == -1 && latitude == -1) {
			
			alert("업장검색 후 다시 진행해주세요");
			return;
		}
		
		if (restBgTag < 1 || restMdTag < 1) {
			alert("태그는 최소 1개 이상 선택해주세요");
			return;
		}
		
		var registerFrm = document.registerFrm;
		registerFrm.submit();
	}
	
	function returnIndex(){
		location.href = "<%=request.getContextPath()%>/userMyPage.eat";
	}
	
</script>

<div class="subleftCon" style="height:1500px; font-size:25px;">
	<h2>업장 등록</h2>
</div>
<div  class="subrightCon" style="height:auto;">
<jsp:include page="../userMyPage_Menubar.jsp" />
<form name="registerFrm" action="restRegister.eat" method="post" enctype="multipart/form-data">

<input type = "hidden" name = "seq" id = "seq" value="-1" />

<input type = "hidden" name = "latitude" id = "latitude" value="-1" />
<input type = "hidden" name = "longitude" id = "longitude" value="-1" />
<input type = "hidden" name = "metroId" id = "metroId" value="-1" />
<input type = "hidden" name = "dongId" id = "dongId" value="-1" />

<div style = "padding-left : 15px; margin-top : 30px; ">
	<span style = "font-weight : bold; font-size : 15pt;">자신의 업장을 등록하여 맛집메트로의 혜택을 누려보세요</span>
</div>
<table class = "table" id="tblMemberRegister">
	<tr class = "content">
		<td width="20%" class="subject" style = "font-size : 14pt;">업장명</td>
		<td width="80%" align="left">
			<input type="text" name="name" id="name" />&nbsp;&nbsp;&nbsp;
			<button type ="button" class="btn btn-default"><span id="restCheck" style = "font-family : 헤드라인; font-weight : bold; font-size : 10pt;">업장검색</span></button>
		</td>
	</tr>
	<tr class = "content">
		<td width="20%" class="subject" style = "font-size : 14pt;">대표이미지</td>
		<td width="80%" align="left">
			<input type="file" name="attach" size="7"/>
		</td>
	</tr>
	<tr>
		<td width="20%" class="subject" style = "font-size : 14pt;">지번주소</td>
		<td width="80%" align="left">
		   <input type="text" name="addr" size="50" maxlength="100" />
		</td>
	</tr>
	<tr class = "content">
		<td width="20%" class="subject" style = "font-size : 14pt;">도로명주소</td>
		<td width="80%" align="left">
		   <input type="text" name="newAddr" size="50" maxlength="100" />
		</td>
	</tr>
	<tr class = "content">
		<td width="20%" class="subject" style = "font-size : 14pt;">연락처</td>
		<td width="80%" align="left">
		    <input type="text" name="phone" id="phone" size="18" maxlength="14" placeholder="010-1111-1111" />
		</td>
	</tr>
	<tr class = "content">
		<td width="20%" class="subject" rowspan="2" style = "font-size : 14pt; vertical-align: middle;" >태그</td>
		<td width="80%" align="left">
		   <input type = "checkbox" class = "restBgTag" name = "restBgTag" id="korea" value="한식" /><label for="korea">한식</label>&nbsp;&nbsp;
		   <input type = "checkbox" class = "restBgTag" name = "restBgTag" id="japan" value="양식" /><label for="japan">양식</label>&nbsp;&nbsp;
		   <input type = "checkbox" class = "restBgTag" name = "restBgTag" id="china" value="일식" /><label for="china">일식</label>&nbsp;&nbsp;
		   <input type = "checkbox" class = "restBgTag" name = "restBgTag" id="europe" value="중식" /><label for="europe">중식</label>&nbsp;&nbsp;
		   <input type = "checkbox" class = "restBgTag" name = "restBgTag" id="india" value="동남아" /><label for="india">동남아</label>
		</td>
	</tr>
	<tr>
		<td width="80%" align="left">
			<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="meet" value="고기류" /><label for="meet">고기류</label>&nbsp;&nbsp;
			<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="fish" value="어폐류" /><label for="fish">어폐류</label>&nbsp;&nbsp;
			<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="vegetable" value="채소류" /><label for="vegetable">채소류</label>&nbsp;&nbsp;
			<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="rice" value="밥류" /><label for="rice">밥류</label>&nbsp;&nbsp;
			<input type = "checkbox" class = "restMdTag" name = "restMdTag" id="noodle" value="면류" /><label for="noodle">면류</label>
		</td>
	</tr>
	<tr>
		<td height = "40px" colspan="2" align="center" valign="middle">
			
				<button type ="button" class="btn btn-default" onClick="goRegister();">
					<span style = "font-family : 헤드라인; font-weight : bold; font-size : 14pt;">등록신청</span>
				</button>&nbsp;&nbsp;
				<button type ="button" class="btn btn-default" onClick="returnIndex();">
					<span style = "font-family : 헤드라인; font-weight : bold; font-size : 14pt;">취소</span>
				</button>
		</td>
	</tr>
</table>
</form>
</div>

<jsp:include page="../footer.jsp" />