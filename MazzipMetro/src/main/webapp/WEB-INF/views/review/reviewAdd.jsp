<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멀티 파일올리기 및 썸네일 파일 생성하기</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

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


</style>

<script type="text/javascript">
	
	function goWrite() {
		var writeFrm = document.writeFrm;
		writeFrm.submit();
	}
	
	function goReset() {
		var writeFrm = document.writeFrm;
		writeFrm.reset();
		$("#result").empty();	
	}
	
	function goList() {
		var writeFrm = document.writeFrm;
		location.href = "<%= request.getContextPath() %>/list.action";
	}

	
	$(document).ready(function(){
		
		/* $( "#spinner" ).spinner(); */
		
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
					html += "<input type='file' name='attach' class='btn btn-default' />";
				}
				
				$("#result").empty();
				$("#result").append(html);	
			}
		});
		
	});
	
</script>

</head>
<body>

	<div class="container" style="margin-bottom: 50px;">
	<h3 style="width: 60%; padding-top: 20px;">멀티 파일올리기 및 썸네일 파일 생성하기</h3>
	
	 <%-- >>>> 파일첨부하기
	 	  enctype="multipart/form-data" 을 해주어야만 파일첨부가 된다. --%>
	
	<form name="writeFrm" action="<%= request.getContextPath() %>/addEnd.action" method="post" enctype="multipart/form-data" >
		<table id="table" class="table table-bordered" style="width: 60%; margin-top: 50px;">
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" class="form-control myshort"  /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="subject" class="form-control mylong" /></td>
			</tr>
			<tr>
            	<th>내용</th>
            	<td><textarea name="content" class="form-control mylong" rows="5"></textarea></td>
         	</tr>
         	
         	<%-- 파일첨부 타입 추가하기  --%>
         	<tr>
         		<th>파일첨부</th>
         		<td>
         		파일갯수 :
         		<select name="attachNum" id="attachNum" class="form-control" style="width: 13%; display: inline;">
         			<option value="0">0</option>
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
         	<%-- 
         	<tr>
         		<th><label for="spinner">Select a value:</label></th>
         		<td><input id="spinner" name="value"></td>
         	</tr> 
         	--%>
		</table>
		<br/>
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goWrite();">쓰기</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goReset();">취소</button>
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goList();">글목록</button>
	
	</form>
	</div>
</body>
</html>