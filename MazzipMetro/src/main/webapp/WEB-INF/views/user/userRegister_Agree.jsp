<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <jsp:include page="../library.jsp" />  
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
		.order {font-size:20px;}
		.btnAgree {width:300px;}
	</style>	
</head>
<body>
<div class="subleftCon">
<h2>회원가입</h2>
</div>
<div class="subrightCon">

<div>
	<!-- <div align="center" style="height: 100px; width:900px; margin:0 auto; padding-top:20px; margin-bottom:20px;" >
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue; border-top-left-radius: 5px; border-bottom-left-radius: 5px; height: 60px; width:250px; border-right:none;">
			<i class="material-icons" style="font-size:20px;">assignment_turned_in 약관동의</i><span>  </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 60px; width: 250px;">
			<i class="material-icons" style="font-size:20px;"> 정보입력</i> <span></span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 5px; border-bottom-right-radius: 5px; height: 60px; width: 250px; border-left:none;">
			<i class="material-icons" style="font-size:20px;">done 가입완료 </i><span >  </span>
		</div>
	</div> -->
	<div class="row form-group">
        <div class="col-xs-12">
            <ul class="nav nav-pills nav-justified thumbnail setup-panel">
                <li class="active"><a href="#step-1">
                    <h4 class="list-group-item-heading">약관동의</h4>
                    <p class="list-group-item-text">First step description</p>
                </a></li>
                <li class="disabled"><a href="#step-2">
                    <h4 class="list-group-item-heading">정보입력</h4>
                    <p class="list-group-item-text">Second step description</p>
                </a></li>
                <li class="disabled"><a href="#step-3">
                    <h4 class="list-group-item-heading">가입완료</h4>
                    <p class="list-group-item-text">Third step description</p>
                </a></li>
            </ul>
        </div>
	</div>
</div>
    
<div class="container" style="width:1100px;">
    <form enctype="multipart/form-data" action="<%= request.getContextPath() %>/userRegisterForm.eat" method="post"  id="contact_form" onsubmit="return checkForm(this);">
		<span class="order">서비스이용약관</span>
		<iframe src="<%= request.getContextPath() %>/resources/htmlfile/agree1.html" width="1060px;" height="200px" class="well" style="padding:0px;"></iframe>
		<div align="right" style="margin-right:10px;">
			<input type="checkbox" name="check1" id="agree1"><label for="agree1"> (주)맛집메트로 서비스이용약관에 동의합니다 </label><br><br>
		</div>
		<br>
		<span class="order">개인정보 취급방침</span>
		<iframe src="<%= request.getContextPath() %>/resources/htmlfile/agree2.html" width="1060px;" height="200px" class="well" style="padding:0px;"></iframe>
		<div align="right" style="margin-right:10px;">
			<input type="checkbox" name="check2" id="agree2"><label for="agree2"> (주)맛집메트로 개인정보취급방침에 동의합니다 </label><br><br>
		</div>
		<div align="right" >
		<button type="submit" class="btn btn-default btn-lg" >다음단계로</button></div>
		<input type="hidden" name="userSort" value="${type}" />
	</form>
</div><!-- /.container -->
</div>  
</body>
 <jsp:include page="../footer.jsp" />
</html>