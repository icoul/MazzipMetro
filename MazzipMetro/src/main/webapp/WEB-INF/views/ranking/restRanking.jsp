<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table#tblRankingView {
	     width: 100%;
	     height : 20px;
	     border: solid gray 1px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	table#tblRankingView th {
		 background-color: silver;
		 border: solid gray 1px;
		 font-size: 13pt;
		 text-align: center;
	}
	
	table#tblRankingView tr {
		border: solid gray 1px;

	}
	
	table#tblRankingView td {
		padding-top : 10px;
		padding-bottom : 10px;
		border: solid gray 1px;
		text-align: center;
	}
</style>

<script type = "text/javascript">
	$(document).ready(function(){
		goRestRanking();
	});
	
	function metroSearch(){
		var url = "metroSearch.eat";
		
		window.open(url,"metroSearch",
        "left=350px, top=100px, width=370px, height=200px, location=no, menubar=no, status=no, scrollbars=yes");
	}
	
	function dongSearch(){
		var url = "dongSearch.eat";
		
		window.open(url,"dongSearch",
        "left=350px, top=100px, width=370px, height=200px, location=no, menubar=no, status=no, scrollbars=yes");
	}
	
	function goRestRanking(){
		
		var bgTagArr = new Array();
		var length = $("input:checkbox[class=bgTag]").checked();
		alert("length");
		for (var i = 0; i < array.length; i++) {
			
		}

		$.ajaxSettings.traditional = true;
		var form_data = {
				metroId : $("#metroId").val(),   // 키값 : 밸류값 
				dongId  : $("#dongId").val(),     // 키값 : 밸류값
				regDate : $("#regDate").val(),
				bgTag	: $(".bgTag").val(),
				mdTag	: $(".mdTag").val()
			}
		
		$.ajax({
			url : "<%=request.getContextPath()%>/restRankingEnd.eat",
			method : "POST",
			data : form_data,
			dataType : "html",
			success : function(data){
				$("#rankingview").html(data);
			}
		}); // end of ajax
	}
	
</script>

<form name = "rankingViewFrm">
<div align = "center">

	<table id = "tblRankingView">
		<tr>
			<th>지하철역</th>
			<th>지역</th>
			<th>기간</th>
			<th colspan="2">태그명</th>
			<th style = "background-color: white; vertical-align: middle;" rowspan="2">
				<button type = "button" onClick="goRestRanking();">검색</button>
			</th>
		</tr>
		<tr>
			<td width="10%" style = "table-layout: fixed;">
				<a id="metroName" href="#" onClick="metroSearch();"><span style = "text-decoration: underline;">역 검색</span></a>
				<input type="text" name="metroId" id="metroId" value="" />
			</td>
			<td width="10%"  style = "table-layout: fixed;">
				<a id="dongName" href="#" onClick="dongSearch();"><span style = "text-decoration: underline;">지역 검색</span></a>
				<input type="text" name="dongId" id="dongId" value="" />
			</td>
			<td width="10%"  style = "table-layout: fixed;">
				<select name = "regDate" id = "regDate">
					<option value="0">없음</option>
					<option value="7">최근 일주일</option>
					<option value="30">최근 한 달</option>
					<option value="90">최근 세 달</option>
					<option value="365">최근 일 년</option>
				</select>
			</td>
			<td>
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="korea" value="한식" /><label for="korea">한식</label>&nbsp;&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="japan" value="양식" /><label for="japan">양식</label>&nbsp;&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="china" value="일식" /><label for="china">일식</label>&nbsp;&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="europe" value="중식" /><label for="europe">중식</label>&nbsp;&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="india" value="동남아" /><label for="india">동남아</label>
			</td>
			<td>
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="meet" value="고기류" /><label for="meet">고기류</label>&nbsp;&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="fish" value="어폐류" /><label for="fish">어폐류</label>&nbsp;&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="vegetable" value="채소류" /><label for="vegetable">채소류</label>&nbsp;&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="rice" value="밥류" /><label for="rice">밥류</label>&nbsp;&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="noodle" value="면류" /><label for="noodle">면류</label>
			</td>
	</table>
</div>
</form>
<div id = "rankingview">

</div>
