<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../top.jsp" /> 
<jsp:include page="../library.jsp" />   
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:1200px; border-right:1px solid #dbdbdb; height:500px;}
.line {border-width:7px; border-style:double; margin-bottom: 40px;}
.control-label {font-size: 14pt;}
.order {font-size:2em;}


#star-five {
   margin: 0px 0;
   position: relative;
   display: block;
   color: black;
   width: 0px;
   height: 0px;
   border-right:  100px solid transparent;
   border-bottom: 70px  solid black;
   border-left:   100px solid transparent;
   -moz-transform:    rotate(35deg);
   -webkit-transform: rotate(35deg);
   -ms-transform:     rotate(35deg);
   -o-transform:      rotate(35deg);
}
#star-five:before {
   border-bottom: 80px solid black;
   border-left: 30px solid transparent;
   border-right: 30px solid transparent;
   position: absolute;
   height: 0;
   width: 0;
   top: -45px;
   left: -65px;
   display: block;
   content: '';
   -webkit-transform: rotate(-35deg);
   -moz-transform:    rotate(-35deg);
   -ms-transform:     rotate(-35deg);
   -o-transform:      rotate(-35deg);

}
#star-five:after {
   position: absolute;
   display: block;
   color: black;
   top: 3px;
   left: -105px;
   width: 0px;
   height: 0px;
   border-right: 100px solid transparent;
   border-bottom: 70px solid red;
   border-left: 100px solid transparent;
   -webkit-transform: rotate(-70deg);
   -moz-transform:    rotate(-70deg);
   -ms-transform:     rotate(-70deg);
   -o-transform:      rotate(-70deg);
   content: '';
}


</style>
    <meta charset="utf-8">
	<title>회원가입</title>
	
	<script type="text/javascript" >
	
	 function goSubmit(){
		
		var registerFrm = document.registerFrm;
		var chkboxArr = document.getElementsByName("userStation");
		var bool = false;
		var count = 0;
		
		for(var i=0; i<chkboxArr.length; i++) {
			bool = chkboxArr[i].checked;
			if(bool == true) {
				count++;
			}
		}
		
		if (count > 3) {
			alert("최대3개만 선택가능합니다.");
		}
		else {
			registerFrm.submit();
		}
		
	} 
	 
	 function emailDuplicateCheck() {
			var registerFrm = document.registerFrm;
			var userEmail = registerFrm.userEmail.value;
			
			if(userEmail.trim()=='') {
				alert("이메일을 입력해주세요.");
				userEmail.focus();
			} else {
				var url = "emailDuplicateCheck.eat?userEmail="+userEmail;
				
				window.open(url,"emailDuplicateCheck",
		                "left=500px, top=100px, width=430px, height=170px, menubar=no, status=no, scrollbars=yes ");
		    }
	 }
	
	
	 $(function() {
         $("#userUpload").on('change', function(){
             readURL(this);
         });
     });

     function readURL(input) {
         if (input.files && input.files[0]) {
         var reader = new FileReader();

         reader.onload = function (e) {
                 $('#userProfile').attr('src', e.target.result);
             }

           reader.readAsDataURL(input.files[0]);
         }
     }
	
	$(document).ready(function() {
		$(".error").hide();
		
		$(".requiredCheck").each(function(){
			$(this).blur(function(){
				var data = $(this).val().trim();
				if(data.length < 1) {
					$(this).next().next().next().show(); 
				    $(":input").attr('disabled', true);
				    $(".form-group").addClass('has-error has-feedback'); 
				    $(this).attr('disabled', false).focus();
				    $("#btnRegister").attr('disabled', true);
				} else {
					$(":input").attr('disabled', false);
					$(".form-group").removeClass('has-error has-feedback'); 
					$(".form-group").addClass('has-success has-feedback'); 
					$("#btnRegister").attr('disabled', false);
				}
			});
		}); // end : requiredCheck
		
		$("#userPw").blur(function(){
			var userPw = $("#userPw").val(); 
			var pattern = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			var bool = pattern.test(userPw);
			
			if(userPw.length > 0 && !bool) {
    			$(":input").attr('disabled', true); 
			    $(this).attr('disabled', false);
			    $(".form-group").addClass('has-error has-feedback'); 
			    $("#btnRegister").attr('disabled', true);
    		} else if(bool) {
    			$(":input").attr('disabled', false); 
    			$(".form-group").removeClass('has-error has-feedback'); 
				$(".form-group").addClass('has-success has-feedback'); 
			    $("#btnRegister").attr('disabled', false);
    		}
		}); // end : userPw
		
		$("#userPw_Confirm").blur(function(){ 
    		var userPw = $("#userPw").val();
    		var userPw_Confirm = $("#userPw_Confirm").val();
    		
    		if(userPw != userPw_Confirm) {
    			$(":input").attr('disabled', true); 
			    $(this).attr('disabled', false);
			    $(".form-group").addClass('has-error has-feedback');
			    $("#userPw").attr('disabled', false);
			    $("#btnRegister").attr('disabled', true);
    		}
    		else{
                $(":input").attr('disabled', false);
                $(".form-group").removeClass('has-error has-feedback'); 
				$(".form-group").addClass('has-success has-feedback'); 
			    $("#btnRegister").attr('disabled', false);
    		}
    		
    	});// end of $("#passwdCheck").blur();
    	
		$("#userEmail").blur(function(){
    		var userEmail = $("#userEmail").val();
    		var pattern = new RegExp(/^[0-9a-zA-Z]([\-.\w]*[0-9a-zA-Z\-_+])*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}$/g); 
    		var bool = pattern.test(userEmail);
    		
    		if(!bool) {
			    $(":input").attr('disabled', true); 
			    $(this).attr('disabled', false);
			    $(".form-group").addClass('has-error has-feedback'); 
			    $("#btnRegister").attr('disabled', true);
    		} else {
    			$(":input").attr('disabled', false); 
    			$(".form-group").removeClass('has-error has-feedback'); 
				$(".form-group").addClass('has-success has-feedback'); 
			    $("#btnRegister").attr('disabled', false);
    		}
    	});// end of $("#email").blur()-----------------
    	
		$("#userPhone").blur(function(){
    		var userPhone = $("#userPhone").val();
    		var pattern = new RegExp(/^[0-9]+$/g);
    		var bool = pattern.test(userPhone);
    		
    		if(!bool) {
    			$(":input").attr('disabled', true); 
			    $(this).attr('disabled', false);
			    $(".form-group").addClass('has-error has-feedback'); 
			    $("#btnRegister").attr('disabled', true);
    		} else {
    			$(this).next().addClass('glyphicon glyphicon-ok form-control-feedback');
    			$(":input").attr('disabled', false); 
    			$(".form-group").removeClass('has-error has-feedback'); 
				$(".form-group").addClass('has-success has-feedback'); 
			    $("#btnRegister").attr('disabled', false);
    		}
    	});// end : userPhone
	}); // end : ready
		  
		    	
		
	
</script>
</head>
<body>
<div class="subleftCon" style="height:1450px;">
	<h2>회원가입</h2>
</div>
<%-- subleftCon --%>
<div class="subrightCon" style="height:auto;">
	<!-- <div align="center" style="height: 100px; width:1200px; margin:0 auto;" >
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-left-radius: 5px; border-bottom-left-radius: 5px; height: 70px; width:300px; border-right:none;">
			<span class="glyphicon glyphicon-pencil order"> 약관동의 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue; height: 70px; width: 300px;">
			<span class="glyphicon glyphicon-pencil order"> 정보입력 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 70px; width: 300px; border-left:none;">
			<span class="glyphicon glyphicon-sort order"> 가입인증 </span>
		</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 5px; border-bottom-right-radius: 5px; height: 70px; width: 300px; border-left:none;">
			<span class="glyphicon glyphicon-home order"> 가입완료 </span>
		</div>
	</div> -->
	<div id="star-five"></div>
<div class="container">
    <form name="registerFrm" class="form-horizontal" action="<%= request.getContextPath() %>/userRegisterEnd.eat" method="post"  id="contact_form" enctype="multipart/form-data" style="background:none;">
		<fieldset>
		<!-- Form Name -->
		<legend style="margin-bottom:20px;">::: 필수입력사항</legend>
		
		<div class="line">
		<div style="margin-top:20px; padding:10px;">
		<div class="form-group">
		  <label class="col-md-3 control-label">이름</label> 
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
				<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
				<input  name="userName" class="form-control requiredCheck input-lg" placeholder="사용자 이름을 입력해주세요"  type="text">
   				<span></span>
		    </div>
			  <span class="error" style="align:right;">사용자이름을 입력해주세요. 필수입력사항입니다.</span>
		  </div>
		</div>
		
		<div class="form-group">
		  <label class="col-md-3 control-label">맛집메트로계정(이메일)</label>  
		  <div class="col-md-7 inputGroupContainer">
		  <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		  <input name="userEmail" id="userEmail" class="form-control input-lg" placeholder="실제 사용하고 계신 이메일을 입력해주세요" type="text">
		  	<span class="input-group-btn">
        		<button class="btn btn-warning btn-lg" type="button" onClick="emailDuplicateCheck();">중복검사</button>
      		</span>
		</div>
			<span class="error" align="right"></span>
		  </div>
		</div>
		
		<div class="form-group">
		<label class="col-md-3 control-label">비밀번호입력</label>
		<div class="col-md-7 inputGroupContainer">
		<div class="input-group">
		<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		<input type="password" class="form-control input-lg requiredCheck" placeholder="최소 : 8글자이상 / 영문 및 특수문자를 포함하여 입력해주세요" name="userPw" id="userPw">
		<span class="error" align="right">비밀번호를 입력해주세요</span>
		<span class="pwError" align="right">최소 : 8글자이상 / 영문 및 특수문자를 포함하여 입력해주세요</span>
		</div>
		<a class="show-password" href="">비밀번호 보기</a>
		<span class="strength"></span>
		
		</div>
		</div>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-3 control-label">비밀번호확인</label>  
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		        <input type="password" placeholder="비밀번호를 확인해주세요" class="form-control input-lg requiredCheck" name="userPw_Confirm" id="userPw_Confirm" autocomplete="off">
		    </div>
		    <span id="pwmatch" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 비밀번호 일치 확인
		</div>
		</div>
		
		<!-- Text input-->
		       
		<div class="form-group" style="overflow:hidden;">
		  <label class="col-md-3 control-label" style="float:left">생년월일</label>  
		    <div class="col-md-7 inputGroupContainer" style=" float:left;">
		    <div class="input-group" style="width:100%;">
		   		 
		        <span class="input-group-addon" ><i class="glyphicon glyphicon-calendar"></i></span>
		  		<div style="overflow:hidden;">
			  		<select id="userYear" name="userYear" style="width:40%;" class="form-control input-lg requiredCheck">
			  			<option value="">년도</option>
						  <script type="text/javascript">
							  var myDate = new Date();
							  var year = myDate.getFullYear();
							  for(var i = year; i > 1900; i--){
								  document.write('<option value="'+i+'">'+i+'</option>');
							  }
							
							  /* if(i >= 2009) {
								 var bool = confirm("본인 생년월일이 맞으신가요?");
							  } */
							  
						  </script>
					</select>
			  		<select id="userMonth" name="userMonth" style="width:30%;" class="form-control input-lg requiredCheck">
			  			<option value="">월</option>
			  			<script type="text/javascript">
			  				for (var j=1; j<=12; j++) {
			  					if (j < 10) {
									document.write('<option value="0'+j+'">0'+j+'</option>');
			  					} else {
			  						document.write('<option value="'+j+'">'+j+'</option>');
			  					}
						  	}
						</script>
			  		</select>
			  		<select id="userDate" name="userDate" style=" width:30%;" class="form-control input-lg requiredCheck">
			  			<option value="">일</option>
			  			<script type="text/javascript">
			  				for (k=1; k<=31; k++) {
			  					if (k < 10) {
									document.write('<option value="0'+k+'">0'+k+'</option>');
			  					} else {
			  						document.write("<option>"+k+'</option>'); 
			  					}
			  				}
			  			</script>
			  		</select> 
		  		</div>
		    </div>
		  </div>
		</div>
		<input type="hidden" name="userSort" value="${userSort}" />
		
		<!-- Text input-->
		       
		<div class="form-group">
		  <label class="col-md-3 control-label">휴대폰번호</label>  
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
		  <input name="userPhone" placeholder="-없이 입력해주세요" class="form-control input-lg requiredCheck" required type="text">
		    </div>
		  </div>
		</div>
	
		<!-- radio checks -->
		 <div class="form-group">
           <label class="col-md-3 control-label">성별</label>
           <div class="col-md-8 inputGroupContainer btn-group" data-toggle="buttons" style="width:400px;">
               <div class="btn btn-primary btn-lg col-md-5">
                   <label>
                       <input type="radio" name="userGender" class="requiredCheck" value="M" /> 남
                   </label>
               </div>
               <div class="btn btn-danger btn-lg col-md-5">
                   <label>
                       <input type="radio" name="userGender" class="requiredCheck" value="F" /> 여
                   </label>
               </div>
           </div>
       </div>
	</div>	
	</div>
		<legend style="margin-bottom:20px;">::: 선택입력사항</legend>
		<div class="line">
		<div style="margin-top:20px; padding:10px;">
		<div class="form-group">
		  <label class="col-md-3 control-label">프로필사진</label>
		  <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		    <span class="input-group-addon"><i class="glyphicon glyphicon-upload"></i></span>  
			<input type='file' id="userUpload" name="attach" />
	        <img id="userProfile" name="userProfile" src="<%= request.getContextPath() %>/resources/images/userNoImg.png" alt="your image" width="150px;" height="150px;"/>
			</div>
		  </div>
		</div>
		
		
		
		
		  
		<div class="form-group">
		  <label class="col-md-3 control-label">선호역(지역)<br>
		  최대 3개까지 선택가능합니다
		  </label>
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		        	<table class ="table table_Station" style="width:730px;">
		        		<tr>
		        			<th> <span class="tablethline">가 </span></th>
		        			<th> <span class="tablethline">나 </span></th>
		        			<th> <span class="tablethline">다 </span></th>
		        			<th> <span class="tablethline">마 </span></th>
		        			<th> <span class="tablethline">바 </span></th>
		        		</tr>
		        		<tr>
		        			<td class="tabletdblock">
					        	<c:forEach var="list" items="${gaList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
							</td>
							<td class="tabletdblock">
								<c:forEach var="list" items="${naList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
							</td>
							<td class="tabletdblock">
								<c:forEach var="list" items="${daList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
							</td>
							<td class="tabletdblock">
								<c:forEach var="list" items="${maList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
							</td>
							<td class="tabletdblock">
								<c:forEach var="list" items="${baList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
							</td>
			   			</tr>
			   			<tr>
			   				<th>사</th>
			   				<th>아</th>
			   				<th>자</th>
			   				<th>차</th>
			   				<th>하</th>
			   			</tr>
			   			<tr>
			   				<td>
			   					<c:forEach var="list" items="${saList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
			   				</td>
			   				<td style="width:16%;">
			   					<c:forEach var="list" items="${aaList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
			   				</td>
			   				<td>
				   				<c:forEach var="list" items="${jaList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
			   				</td>
			   				<td>
			   					<c:forEach var="list" items="${chaList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
			   				</td>
			   				<td>
			   					<c:forEach var="list" items="${haList}">
									<input type="checkbox" id="${list}" value="${list}" name="userStation"><label for = "${list}">${list} </label><br>
								</c:forEach>
			   				</td>
			   			</tr>
					</table>
		  	</div> 
		  </div> 
		</div> 
		</div>
</div>
		
		<!-- Success message -->
		<div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i> Thanks for contacting us, we will get back to you shortly.</div>
		
		<!-- Button -->
		<div class="form-group">
		  <div align = "center" class="col-md-12">
		    <button type="button" id="btnRegister" class="btn btn-default" onClick="goSubmit();">다음단계로<span class="glyphicon glyphicon-send"></span></button>
		  	<button type="button" class="btn btn-default" onClick="javascript:location.href='index.eat'">취소</button>
		  </div>
		</div>
		
		</fieldset>
		</form>
		</div>
		    </div><!-- /.container -->
		      <jsp:include page="../footer.jsp" />

<%--subrightCon --%>
<form name = "emailDuplicatecheckFrm">
	<input type="hidden" name="userEmail">
</form>
</body>
</html>