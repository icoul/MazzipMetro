<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<title>회원가입</title>
	<jsp:include page="../top.jsp" />
	
	<script type="text/javascript" >
	
	function checkForm(form)
	  {
	    if(!form.check1.checked) {
	      alert("서비스이용약관에 동의해주시기 바랍니다.");
	      form.check1.focus();
	      return false;
	    } else if (!form.check2.checked) {
    	  alert("개인정보취급방침에 동의해주시기 바랍니다.");
	      form.check2.focus();
	      return false;
	    }
	    return true;
	  }
	</script>

	<style type="text/css">
		.order {font-size:2em;}
		.btnAgree {width:300px;}
	</style>	
</head>
<body>
<div class="subleftCon">
<h2>회원가입</h2>
</div>
<div class="subrightCon">

<div>
	<div align="center" style="height: 100px; width:1200px; margin:0 auto;" >
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue; border-top-left-radius: 5px; border-bottom-left-radius: 5px; height: 70px; width:300px; border-right:none;">
			<span class="glyphicon glyphicon-pencil order"> 약관동의 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 70px; width: 300px;">
			<span class="glyphicon glyphicon-pencil order"> 정보입력 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 70px; width: 300px; border-left:none;">
			<span class="glyphicon glyphicon-sort order"> 가입인증 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 5px; border-bottom-right-radius: 5px; height: 70px; width: 300px; border-left:none;">
			<span class="glyphicon glyphicon-home order"> 가입완료 </span>
		</div>
	</div>
</div>
    
<div class="container" style="width:1200px;">
    <form enctype="multipart/form-data" action="<%= request.getContextPath() %>/userRegisterForm.eat" method="post"  id="contact_form" onsubmit="return checkForm(this);">
		<span class="order">서비스이용약관</span>
		<iframe src="<%= request.getContextPath() %>/resources/htmlfile/agree1.html" width="1170px;" height="200px"></iframe>
		<div align="right">
			<input type="checkbox" name="check1" id="agree1"><label for="agree1"> (주)맛집메트로 서비스이용약관에 동의합니다 </label><br><br>
		</div>
		<br>
		<span class="order">개인정보 취급방침</span>
		<iframe src="<%= request.getContextPath() %>/resources/htmlfile/agree2.html" width="1170px;" height="200px"></iframe>
		<div align="right">
			<input type="checkbox" name="check2" id="agree2"><label for="agree2"> (주)맛집메트로 개인정보취급방침에 동의합니다 </label><br><br>
		</div>
		<div align="right"><button type="submit" class="btn btn-default btn-lg" >다음단계로</button></div>
		<input type="hidden" name="userSort" value="${type}" />
	</form>
</div><!-- /.container -->
</div>  
</body>
 <jsp:include page="../footer.jsp" />
</html>