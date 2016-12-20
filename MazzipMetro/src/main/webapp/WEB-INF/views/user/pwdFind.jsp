<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />

<style>
	#div_userid {
			width: 70%;
			height: 15%;
			margin-bottom: 5%;
			margin-left: 10%;
			position: relative;
		}
		
	#div_email {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	
	#div_certi {
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
			top:50px;
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
		
		if(method == "POST") {
			$("#div_findResult").hide();
		}
		
		$("#btnFind").click(function(){
			var pwdFindFrm = document.pwdFindFrm;
			pwdFindFrm.action = "<%= request.getContextPath() %>/pwdFind.eat";
			pwdFindFrm.method = "POST";
			pwdFindFrm.submit();
		});
		
		var userEmail = "${userEmail}";
		var userPhone = "${userPhone}";
		
		if(userEmail != "" && userPhone != "" ) {
			$("#userEmail").val(userEmail);
			$("#userPhone").val(userPhone);
		}
		
		
		$("#btnConfirmCode").click(function(){
			
			if( $("#input_confirmCode").val() == "${certificationCode}" ) {
				alert("인증되었습니다.");
				
				var pwdFindFrm = document.pwdFindFrm;
				pwdFindFrm.action = "<%= request.getContextPath() %>/pwdConfirm.eat";
				pwdFindFrm.method = "POST";
				pwdFindFrm.submit();
			}
			else{
				alert("인증키값을 다시 입력하세요.");
				$("#input_confirmCode").val("");
			}
			
		});
	
	});	
</script>

<form name="pwdFindFrm">
<table style="width:100%">
	<tr>
		<th style="width:70%">
			<table>
				<tr>
					<th>이메일</th>
				</tr>
				<tr>
					<th><input type="text" name="userEmail" class="form-control" id="userEmail" size="50" required /></th>
				</tr>
				<tr><th><br></th></tr>
				<tr>
					<th>핸드폰번호</th>
				</tr>
				<tr>
					<th><input type="text" name="userPhone" class="form-control" id="userPhone" size="50" required /></th>
				</tr>
			</table>
		</th>
		<th style="width:25%; padding-left:5%; vertical-align: middle;" align="center">
				<button type="button" class="btn btn-default btn-lg" id="btnFind">찾기</button>
		</th>
	</tr>
	<tr>
		<th colspan="2" style="font-size:20px; width:100%; height:150px; vertical-align: middle;" align="center">
			<c:if test="${n == 1}">
				인증코드가 ${userEmail}로 발송되었습니다.<br/>
				인증코드를 입력해주세요<br/>
				<input type="text" name="input_confirmCode" id="input_confirmCode" required />
				<button type="button" class="btn btn-info" id="btnConfirmCode" >인증하기</button>
			</c:if>
			<c:if test="${n < 1}">
				<div class="alert alert-danger" style="font-size:13px;">
		    		<strong>잘못된 정보! 혹은 미입력! </strong> <br>
					 	 혹시 가입한 정보를 미입력하셨나요?<br>
						 평소 사용하던 개인정보를 입력하셨다면 <br> 회원가입시 입력한 개인정보와 다릅니다. <br>
						 회원가입시 입력한 회원이메일과 핸드폰번호로 입력해주세요
			  	</div>
		</c:if>
		</th>
	</tr>
</table>


	<%-- <div id="div_userid" align="center">
		<span style="color: blue; font-size: 12pt;">이메일</span><br/>
		<input type="text" name="userEmail" class="form-control" id="userEmail" size="15" required />
	</div>
	
	<div id="div_email" align="center">
		<span style="color: blue; font-size: 12pt;">핸드폰번호</span><br/>
		<input type="text" name="userPhone" class="form-control" id="userPhone" size="15" required />
	</div>
	
	<div id="div_findResult" align="center">
		<c:if test="${n == 1}">
			<div>
				인증코드가 ${userEmail}로 발송되었습니다.<br/>
				인증코드를 입력해주세요<br/>
				<input type="text" name="input_confirmCode" id="input_confirmCode" required />
				<button type="button" class="btn btn-info" id="btnConfirmCode" >인증하기</button>
			</div>
		</c:if>	
		
		<c:if test="${n < 1}">
			<div id = "div_certi">
				<div class="alert alert-danger" style="width: 100%;">
		    		<strong>잘못된 정보! 혹은 미입력! </strong> <br>
			 	 혹시 가입한 정보를 미입력하셨나요?<br>
				 평소 사용하던 개인정보를 입력하셨다면 <br> 회원가입시 입력한 개인정보와 다릅니다. <br>
				 회원가입시 입력한 회원이메일과 핸드폰번호로 입력해주세요
			  	</div>
			</div>
		</c:if>
		
			
	</div>
	
	<div id="div_btnFind" align="center">
		<button type="button" class="btn btn-success" id="btnFind">찾기</button>
	</div>
 --%>
</form>




  