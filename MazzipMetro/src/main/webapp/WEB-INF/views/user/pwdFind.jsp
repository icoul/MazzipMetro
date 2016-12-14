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
	
			$("#div_findResult").hide();
		
		$("#btnFind").click(function(){
			var pwdFindFrm = document.pwdFindFrm;
			pwdFindFrm.action = "<%= request.getContextPath() %>/pwdFind.eat";
			pwdFindFrm.method = "POST";
			pwdFindFrm.submit();
		});
		
		var userid = "${userid}";
		var email = "${email}";
		
		if(method == "POST" && userid != "" && email != "" ) {
			$("#userid").val(userid);
			$("#email").val(email);
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
	<div id="div_userid" align="center">
		<span style="color: blue; font-size: 12pt;">이메일</span><br/>
		<input type="text" name="userEmail" class="form-control" id="email" size="15" placeholder="ID" required />
	</div>
	
	<div id="div_email" align="center">
		<span style="color: blue; font-size: 12pt;">핸드폰번호</span><br/>
		<input type="text" name="userPhone" class="form-control" id="userid" size="15" placeholder="abc@def.com" required />
	</div>
	
	<div id="div_findResult" align="center">
		<c:if test="${n == 1}">
			<div>
				인증코드가 ${email}로 발송되었습니다.<br/>
				인증코드를 입력해주세요<br/>
				<input type="text" name="input_confirmCode" id="input_confirmCode" required />
				<button type="button" class="btn btn-info" id="btnConfirmCode" >인증하기</button>
			</div>
		</c:if>	
		
		<c:if test="${n != 1}">
			<div id = "div_certi">
				<div class="alert alert-danger" style="width: 100%;">
		    		<strong>잘못된 정보! 혹은 미입력! </strong> <br>
			 	 혹시 가입한 정보를 미입력하셨나요?<br>
				 개인정보를 입력하셨다면 <br> 회원가입시 입력한 개인정보와 다릅니다. <br>
				 회원가입시 입력한 회원아이디와 이메일로 입력해주세요
			  	</div>
			</div>
		</c:if>
		
			
	</div>
	
	<div id="div_btnFind" align="center">
		<button type="button" class="btn btn-success" id="btnFind">찾기</button>
	</div>

</form>




  