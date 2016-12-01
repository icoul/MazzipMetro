<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
	<title>회원가입</title>
	<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<link href="<%= request.getContextPath() %>/resources/css/hb_register_.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn-async.min.js"></script>
	
	
	<script type="text/javascript" >
	
	function checkForm(form)
	  {
	    if(!form.terms.checked) {
	      alert("이용약관에 동의해주시기 바랍니다.");
	      form.terms.focus();
	      return false;
	    }
	    return true;
	  }
	
	</script>
</head>
<body>
<div>
	<div align="center" style="height: 100px; width:604px; margin:0 auto; padding-top:20px;" >
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue; border-top-left-radius: 1em; border-bottom-left-radius: 1em; height: 50px; width:150px; border-right:none;"><span class="glyphicon glyphicon-pencil"></span>약관동의</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 50px; width: 150px;"><span class="glyphicon glyphicon-pencil"></span>정보입력</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-sort"></span>가입인증</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 1em; border-bottom-right-radius: 1em; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-home"></span>가입완료</div>
	</div>
</div>
    
<div class="container">

    <form enctype="multipart/form-data" class="well form-horizontal" action="<%= request.getContextPath() %>/userRegister2.eat" method="post"  id="contact_form" onsubmit="return checkForm(this);">
		<legend>회원약관</legend>
		
		<iframe src="<%= request.getContextPath() %>/resources/htmlfile/agree.html" width="100%" height="300px" class="box" ></iframe>
		
		<input type="hidden" name="userSort" value="${type}" />
		<input type="checkbox" name="terms"> (주)맛집메트로 이용약관에 동의합니다</u></p>
		<p><button type="submit">동의</button></p>
	</form>
</div><!-- /.container -->
    
</body>
</html>