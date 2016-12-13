<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	table#tblRankingView {
	     width: 100%;
	     height : 20px;
	     border-collapse: collapse;
	     margin-top: 30px;
	     margin-bottom: 10px;
	}
	
	table#tblRankingView th {
		 background-color: silver;
		 border: solid gray 1px;
		 font-size: 13pt;
		 text-align: center;
		 vertical-align: middle;
	}
	
	table#tblRankingView tr {
		border: solid gray 1px;

	}
	
	table#tblRankingView td {
		padding-top : 20px;
		padding-bottom : 20px;
		text-align: center;
		font-size: 10pt;
	}
</style>

<script type = "text/javascript">
	$(document).ready(function(){
		goRestRanking("1");
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
	
	function goReset(){
		$("input[name='bgTag']:checked").each(function(){
			$(this).prop("checked", false);
		});
		
		$("input[name='mdTag']:checked").each(function(){
			$(this).prop("checked", false);
		});
		
		$("#metroId").val("");
		$("#metroName").html("<span style = 'text-decoration: underline;'>역 검색</span>");
		
		$("#dongId").val("");
		$("#dongName").html("<span style = 'text-decoration: underline;'>지역 검색</span>");
		
		$("#regDate").val("0");
	}
	
	function goRestRanking(pageNum){
		
		var bgTagArr = new Array();
		$("input[name='bgTag']:checked").each(function(){
			bgTagArr.push($(this).val());
		});
		
		var mdTagArr = new Array();
		$("input[name='mdTag']:checked").each(function(){
			mdTagArr.push($(this).val());
		});

		$.ajaxSettings.traditional = true;
		var form_data = {
				
				pageNum : pageNum,
				metroId : $("#metroId").val(),   // 키값 : 밸류값 
				dongId  : $("#dongId").val(),     // 키값 : 밸류값
				regDate : $("#regDate").val(),
				bgTag	: bgTagArr,
				mdTag	: mdTagArr
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
				<input type = "button" onClick="goRestRanking('1');" style = "width : 70px; font-size : 11pt; margin-left : 10px; margin-right : 10px; " value = "검색"><br/>
				<input type = "button" onClick="goReset();" style = "width : 70px; font-size : 11pt; margin-left : 10px; margin-right : 10px; margin-top : 10px;" value = "초기화">
			</th>
		</tr>
		<tr>
			<td width="10%" style = "table-layout: fixed; border: solid gray 1px;">
				<a id="metroName" href="#" onClick="metroSearch();"><span style = "text-decoration: underline;">역 검색</span></a>
				<input type="hidden" name="metroId" id="metroId" value="" />
			</td>
			<td width="10%"  style = "table-layout: fixed; border: solid gray 1px;">
				<a id="dongName" href="#" onClick="dongSearch();"><span style = "text-decoration: underline;">지역 검색</span></a>
				<input type="hidden" name="dongId" id="dongId" value="" />
			</td>
			<td width="12%"  style = "table-layout: fixed; border: solid gray 1px;">
				<select name = "regDate" id = "regDate" >
					<option value="0">없음</option>
					<option value="7">최근 일주일</option>
					<option value="30">최근 한 달</option>
					<option value="90">최근 세 달</option>
					<option value="365">최근 일 년</option>
				</select>
			</td>
			<td width="29%" style = "border: solid gray 1px;">
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="korea" value="한식" /><label for="korea">한식</label>&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="japan" value="양식" /><label for="japan">양식</label>&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="china" value="일식" /><label for="china">일식</label>&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="europe" value="중식" /><label for="europe">중식</label>&nbsp;
			   <input type = "checkbox" class = "bgTag" name = "bgTag" id="india" value="동남아" /><label for="india">동남아</label>
			</td>
			<td width="31%" style = "border: solid gray 1px;">
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="meet" value="고기류" /><label for="meet">고기류</label>&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="fish" value="어폐류" /><label for="fish">어폐류</label>&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="vegetable" value="채소류" /><label for="vegetable">채소류</label>&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="rice" value="밥류" /><label for="rice">밥류</label>&nbsp;
				<input type = "checkbox" class = "mdTag" name = "mdTag" id="noodle" value="면류" /><label for="noodle">면류</label>
			</td>
	</table>
</div>
</form>
<div>
	<table id = "tblRankingView">
		<tr>
			<th width = "10%" height = "30px;">순위</th>
			<th width = "50%" height = "30px;">음식점명</th>
			<th width = "20%" height = "30px;">업종</th>
			<th width = "10%" height = "30px;">역명</th>
			<th width = "10%" height = "30px;">지역명</th>
		</tr>
	</table>
</div>
<div id = "rankingview">

</div>
