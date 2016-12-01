<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
	<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<link href="<%= request.getContextPath() %>/resources/css/hb_register_.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn-async.min.js"></script>
	 <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	 <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>

</head>
<body>


<form name="registerFrm" class="well form-horizontal" action="<%= request.getContextPath() %>/userRegisterEnd.eat" method="post"  id="contact_form" enctype="multipart/form-data" style="width:700px; background:none;">
		<fieldset>
		<!-- Form Name -->
		<legend> ${sessionScope.loginUser.userName}님의 정보수정</legend>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-4 control-label">맛집메트로계정(이메일)</label>  
		  <div class="col-md-7 inputGroupContainer">
		  <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		  <input name="userEmail" class="form-control" value="${sessionScope.loginUser.userEmail}" type="text" readonly="readonly">
		</div>
		  </div>
		</div>
		
		<!-- Text input-->
		
		<div class="form-group">
			<label class="col-md-4 control-label">비밀번호입력</label>
				<div class="col-md-7 inputGroupContainer">
					<div class="input-group">
						<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
						<input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호 입력" autocomplete="off">
					</div>
					<a class="show-password" href="">비밀번호 보기</a>
				</div>
		</div>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-4 control-label">비밀번호확인</label>  
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		        <input type="password" class="form-control" name="password2" id="password2" placeholder="Repeat Password" autocomplete="off">
		        
		  <!-- <input name="userPw_confirm" id="userPw_confirm" placeholder="정확하게 입력해주세요" class="form-control"  type="text"> -->
		    </div>
		    <span id="pwmatch" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 비밀번호 일치 확인
		</div>
		</div>
		
		<input type="hidden" name="userSort" value="${userSort}" />
		
		<!-- Text input-->
		       
		<div class="form-group">
		  <label class="col-md-4 control-label">휴대폰번호</label>  
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
		  <input name="userPhone" placeholder="-없이 입력바랍니다" class="form-control" type="text">
		    </div>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-4 control-label">프로필사진</label>
		  <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		    <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>  
			<input type='file' id="userUpload" name="attach" />
	        <img id="userProfile" name="userProfile" src="<%= request.getContextPath() %>/resources/images/userNoImg.png" alt="your image" width="150px;" height="150px;"/>
			</div>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-3 control-label">선호역(지역)<br>
		  최대 3개까지 선택가능합니다
		  </label>
		    <div class="col-md-6 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
		        	<p>
		        	가 <br>
		        	<c:forEach var="list" items="${gaList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
		   			</p>
		   			
		   			<p>
					나 <br>
					<c:forEach var="list" items="${naList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					다 <br>
					<c:forEach var="list" items="${daList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					마 <br>
					<c:forEach var="list" items="${maList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					바 <br>   
					<c:forEach var="list" items="${baList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					사 <br>		        	
					<c:forEach var="list" items="${saList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					아 <br>		        	
					<c:forEach var="list" items="${aaList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					자 <br>
					<c:forEach var="list" items="${jaList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					<p>
					차 <br>
					<c:forEach var="list" items="${chaList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					
					
					<p>
					하 <br>
					<c:forEach var="list" items="${haList}">
						<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
					</c:forEach>
					</p>
					
					
					        	
		  </div> 
		  </div> 
		</div> 
		
		
		<!-- Success message -->
		<div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i> Thanks for contacting us, we will get back to you shortly.</div>
		
		<!-- Button -->
		<div class="form-group">
		  <label class="col-md-4 control-label"></label>
		  <div class="col-md-4">
		    <button type="button" class="btn btn-warning" onClick="goSubmit();">Send<span class="glyphicon glyphicon-send"></span></button>
		  </div>
		</div>
		
		</fieldset>
		</form>




</body>
</html>