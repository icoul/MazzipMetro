<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../library.jsp" />
<style>
	#div_name {
			width: 70%;
			height: 15%;
			margin-bottom: 5%;
			margin-left: 10%;
			position: relative;
		}
		
	#div_mobile {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_findResult {
			width: 70%;
			height: 15%;
			margin-bottom: 5%;
			margin-left: 10%;
			position: relative;
		}
		
	#div_btnFind {
			width: 70%;
			height: 15%;
			margin-bottom: 5%;
			margin-left: 10%;
			position: relative;
		}				

</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		var method = "${method}";
	//	alert("method : " + method);
	
		if(method == "GET") {
			$("#div_findResult").hide();
		}
		
		$("#btnFind").click(function(){
			var idFindFrm = document.idFindFrm;
			idFindFrm.action = "<%= request.getContextPath() %>/emailFind.eat";
			idFindFrm.method = "POST";
			idFindFrm.submit();
		});
		
		var name = "${name}";
		var mobile = "${mobile}";
		
		if(name != "" && mobile != "" ) {
			$("#name").val(name);
			$("#mobile").val(mobile);
			$("#div_findResult").show();
		}
	
	});	
</script>

<form name="idFindFrm">
	<table style="width:100%;">
		<tr>
			<th style="width:70%;">
				<table>
					<tr>
						<th>성명</th>
					</tr>
					<tr>
						<th><input type="text" name="name" class="form-control" id="name" size="50" required /></th>
					</tr>
					<tr><th><br></th></tr>
					<tr>
						<th>핸드폰번호</th>
					</tr>
					<tr>
						<th><input type="text" name="mobile" class="form-control" id="mobile" size="50" placeholder="-없이 입력하세요" required /></th>
					</tr>
				</table>
			</th>
			<th style="width:25%; padding-left:5%; vertical-align: middle;" align="center">
				<button type="button" class="btn btn-success btn-lg" id="btnFind">찾기</button>
			</th>
		</tr>
		<tr>
		 <th colspan="2" style="font-size:20px; width:100%; height:150px; padding-left:30%; vertical-align: middle;" align="center">
		 	${userid}
		 </th>
		</tr>
	</table>


	

	<%-- <div id="div_name">
		<span style="font-size: 12pt;">성명</span><br/>
		<input type="text" name="name" class="form-control" id="name" size="15" placeholder="홍길동" required />
	</div>
	
	<div id="div_mobile">
		<span style="font-size: 12pt;">휴대전화</span><br/>
		<input type="text" name="mobile" class="form-control" id="mobile" size="15" placeholder="-없이 입력하세요" required />
	</div>
	
	<div id="div_findResult">
		<span style="color: red; font-size: 16pt; font-weight: bold;">${userid}</span><br/>
	</div>
	
	<div id="div_btnFind">
		<button type="button" class="btn btn-success" id="btnFind">찾기</button>
	</div> --%>

</form>




  