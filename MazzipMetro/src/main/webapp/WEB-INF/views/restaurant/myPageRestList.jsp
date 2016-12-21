<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
* { padding:0; margin:0;}
#colName {height:23px; font-size:13px;}

.tblRestList {border-collapse: collapse; width:100%;}
.tblRestList th {height:50px; padding-top:16px; border-top:1px solid #00bad2; border-bottom:1px solid #c2c2c2; background-color:#fafafa; color:#444; text-align:center; font-size:13px; font-weight:normal;}
.tblRestList td {height:10px; padding-top:16px; padding-bottom:16px; border-bottom:1px solid #e0e0e0; font-size:12px; text-align:center; vertical-align: middle;}
.btnGray {width:63px; height:23px; border:1px solid #6c6c6c; background-color:#777; color:#fff; margin-top: 20px; margin-bottom: 10px; font-size:10px; }
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".collapse").click(function(){
	        $(this).collapse('hide');
	    });
	    
	});
	
	function goRestEdit(restSeq) {
		
		var restEditFrm = document.restEditFrm;
		var url = "<%=request.getContextPath()%>/restEdit.eat";
		var title = "restEdit";
		var status = "left=500px, top=100px, width=600px, height=915px, menubar=no, status=no, scrollbars=yes ";
		var popup = window.open("", title, status); 
		
		restEditFrm.restSeq.value = restSeq;
		restEditFrm.target = title;
		restEditFrm.action = url;
		restEditFrm.method = "post";
		restEditFrm.submit();
	}
	
	function goMenuEdit(restSeq) {
			
			var restEditFrm = document.restEditFrm;
			var url = "<%=request.getContextPath()%>/restMenuEdit.eat";
			var title = "restEdit";
			var status = "left=500px, top=100px, width=1200px, height=800px, menubar=no, status=no, scrollbars=yes ";
			var popup = window.open("", title, status); 
			
			restEditFrm.restSeq.value = restSeq;
			restEditFrm.target = title;
			restEditFrm.action = url;
			restEditFrm.method = "post";
			restEditFrm.submit();
		}
		
	function goDelete(restSeq, userSeq) {
		
		var restEditFrm = document.restEditFrm;
		var url = "<%=request.getContextPath()%>/restDel.eat";
		
		restEditFrm.restSeq.value = restSeq;
		restEditFrm.action = url;
		restEditFrm.method = "post";
		restEditFrm.submit();
	}
	
	function getMenuAjax(restSeq){
		$.ajax({
			url: "restMenuList.eat",  
			method:"POST",
			data: "restSeq="+restSeq,
			dataType: "html",
			success: function(data) {
				$('div	[id=menuList'+restSeq+']').html(data);
			}
				
		});//end of $.ajax()
		
	}
	

</script>
	<%-- subleftCon --%>
		<table class="tblRestList" >
		<c:forEach var="vo" items="${restList}" varStatus="status">
			
			<tr>
				<th style="width: 250px;" >가게명</th>
				<th style="width: 70px;" >등급</th>
				<th style="width: 300px;" >업장대표이미지</th>
				<th style="width: 180px;" >업장등록일자</th>
				<th style="width: 180px;" >업장방문수</th>
				<th style="width: 70px;" >수정하기</th>
			</tr>
			<tr class = "rest" >
				<td data-toggle="collapse" data-target="#menu${status.index}" onClick="getMenuAjax('${vo.restSeq}');">${vo.restName}</td>
				<td data-toggle="collapse" data-target="#menu${status.index}" onClick="getMenuAjax('${vo.restSeq}');">${vo.gradeSeq}</td>
				<td data-toggle="collapse" data-target="#menu${status.index}" onClick="getMenuAjax('${vo.restSeq}');"><img src = "<%=request.getContextPath() %>/files/restaurant/thumb/thumb${vo.restImg}" /></td>
				<td data-toggle="collapse" data-target="#menu${status.index}" onClick="getMenuAjax('${vo.restSeq}');">${vo.restRegDate}</td>
				<td data-toggle="collapse" data-target="#menu${status.index}" onClick="getMenuAjax('${vo.restSeq}');">${vo.restVisitor}</td>
				<td>
					<button class="btnGray" onClick="goRestEdit('${vo.restSeq}');" style="margin-top:0; width:100px;">업장정보수정</button><br/>
					<button class="btnGray" onClick="goMenuEdit('${vo.restSeq}');" style="margin-top:0; width:100px;">메뉴정보수정</button><br/>
					<button class="btnGray" onClick="goDelete('${vo.restSeq}');" style="margin-top:0; width:100px; background-color: #C32020; ">업장삭제</button><br/>
				</td>
			</tr>
			<tr id="menu${status.index}" class="collapse">
			    <td colspan="6">
					<div id = "menuList${vo.restSeq}"></div>
			    </td>
			</tr>
		</c:forEach>
	</table>
	<form name="restEditFrm">
		<input type = "hidden" name = "restSeq" value="${vo.restSeq}" />
	</form>	
	<br/>
	<%-- subrightCon --%>
