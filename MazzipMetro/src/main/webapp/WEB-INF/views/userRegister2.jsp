<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
	 <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	 <script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>
	<jsp:include page="top.jsp" />
	
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
		
		  
		    $('#contact_form').bootstrapValidator({
		        // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
		        feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
		        },
		        fields: {
		            userName: {
		                validators: {
		                        stringLength: {
		                        min: 2,
		                        message: '한글자 이상 입력해주세요'
		                    	},
		                        notEmpty: {
		                        message: '이름은 필수입력사항이니 입력해주세요.'
		                    	}
		                }
		            },
		            userEmail: {
		                validators: {
		                    notEmpty: {
		                        message: '이메일은 필수입력사항이니 입력해주세요.'
		                    },
		                    emailAddress: {
		                        message: '이메일형식에 맞지 않습니다.'
		                    }
		                }
		            },
		            userStation: {
		                validators: {
		                    choice: {
		                        max: 3,
		                        message: 'Please choose 2 - 4 programming languages you are good at'
		                    }
		                }
		            },
		            userPw: {
		                validators: {
		                    notEmpty: {
		                        message: '사용하실 비밀번호를 입력해주세요.'
		                    }
		                }
		            },
		            userPhone: {
		                validators: {
		                    notEmpty: {
		                        message: '전화번호는 필수입력사항이니 입력해주세요.'
		                    },
		                    phone: {
		                        country: 'CN',
		                        message: '전화번호 형식에 맞지 않습니다. 정확한 전화번호를 입력해주세요.'
		                    }
		                }
		            },
		            userYear: {
		                validators: {
		                    notEmpty: {
		                        message: '생년월일은 필수사항이니 선택해주세요'
		                    }
		                }
		            },
		            userMonth: {
		                validators: {
		                    notEmpty: {
		                        message: '&nbsp;'
		                    }
		                }
		            },
		            userDate: {
		                validators: {
		                    notEmpty: {
		                        message: '&nbsp;'
		                    }
		                }
		            },
		            
		            userGender: {
		                validators: {
		                    notEmpty: {
		                        message: '성별은 필수선택사항이니 선택해주세요'
		                    }
		                }
		            }
		            
		            }
		        })
		        .on('success.form.bv', function(e) {
		            $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
		                $('#contact_form').data('bootstrapValidator').resetForm();

		            e.preventDefault();
		            var $form = $(e.target);
		            var bv = $form.data('bootstrapValidator');
		            $.post($form.attr('action'), $form.serialize(), function(result) {
		                console.log(result);
		            }, 'json');
		        });
		    
		    
		    
		    $('#userPw').on('propertychange change keyup paste input', function() {
		        var password = $(this).val();
		        var passwordScore = zxcvbn(password)['score'];
		        
		        var updateMeter = function(width, background, text) {
		          $('.strength').text('안전성: ' + text).css('color', background);
		        }
		        
		        if (passwordScore === 0) {
		          if (password.length === 0) {
		            updateMeter("0%", "#ffa0a0", "none");
		          } else {
		            updateMeter("20%", "#ffa0a0", "매우 약함");
		          }
		        }
		        
		        if (passwordScore == 1) updateMeter("40%", "#ffb78c", "약함");
		        if (passwordScore == 2) updateMeter("60%", "#ffec8b", "중간");
		        if (passwordScore == 3) updateMeter("80%", "#c3ff88", "강함");
		        if (passwordScore == 4) updateMeter("100%", "#ACE872", "매우 강함"); // Color needs changing
		        
		      });
		      
		      $('.show-password').click(function(event) {
		        event.preventDefault();
		        if ($('#userPw').attr('type') === 'password') {
		          $('#userPw').attr('type', 'text');
		          $('.show-password').text('비밀번호 감추기');
		        } else {
		          $('#userPw').attr('type', 'password');
		          $('.show-password').text('비밀번호 보기');
		        }
		      });
		      
		      $("input[type=password]").keyup(function(){
		    	  	var ucase = new RegExp("[A-Z]+");
		    		var lcase = new RegExp("[a-z]+");
		    		var num = new RegExp("[0-9]+");
		    		
		    		if($("#userPw").val().length >= 8){
		    			$("#8char").removeClass("glyphicon-remove");
		    			$("#8char").addClass("glyphicon-ok");
		    			$("#8char").css("color","#00A41E");
		    		}else{
		    			$("#8char").removeClass("glyphicon-ok");
		    			$("#8char").addClass("glyphicon-remove");
		    			$("#8char").css("color","#FF0004");
		    		}
		    		
		    		if(ucase.test($("#userPw").val())){
		    			$("#ucase").removeClass("glyphicon-remove");
		    			$("#ucase").addClass("glyphicon-ok");
		    			$("#ucase").css("color","#00A41E");
		    		}else{
		    			$("#ucase").removeClass("glyphicon-ok");
		    			$("#ucase").addClass("glyphicon-remove");
		    			$("#ucase").css("color","#FF0004");
		    		}
		    		
		    		if(lcase.test($("#userPw").val())){
		    			$("#lcase").removeClass("glyphicon-remove");
		    			$("#lcase").addClass("glyphicon-ok");
		    			$("#lcase").css("color","#00A41E");
		    		}else{
		    			$("#lcase").removeClass("glyphicon-ok");
		    			$("#lcase").addClass("glyphicon-remove");
		    			$("#lcase").css("color","#FF0004");
		    		}
		    		
		    		if(num.test($("#userPw").val())){
		    			$("#num").removeClass("glyphicon-remove");
		    			$("#num").addClass("glyphicon-ok");
		    			$("#num").css("color","#00A41E");
		    		}else{
		    			$("#num").removeClass("glyphicon-ok");
		    			$("#num").addClass("glyphicon-remove");
		    			$("#num").css("color","#FF0004");
		    		}
		    	  
		    	  if($("#userPw").val() == $("#password2").val()){
		    			$("#pwmatch").removeClass("glyphicon-remove");
		    			$("#pwmatch").addClass("glyphicon-ok");
		    			$("#pwmatch").css("color","#00A41E");
		    		}else{
		    			$("#pwmatch").removeClass("glyphicon-ok");
		    			$("#pwmatch").addClass("glyphicon-remove");
		    			$("#pwmatch").css("color","#FF0004");
		    		}
		      });
		      
		});
	
		
	
	</script>
</head>
<body>
<div class="subleftCon" style="height:1450px;">
	<h2>맛집메트로계정 정보입력</h2>
</div>
<%-- subleftCon --%>
<div class="subrightCon" style="height:auto;">
	<div align="center" style="height: 100px; width:604px; margin:0 auto; padding-top:20px;" >
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-left-radius: 1em; border-bottom-left-radius: 1em; height: 50px; width:150px; border-right:none;"><span class="glyphicon glyphicon-pencil"></span>약관동의</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue;  height: 50px; width: 150px;"><span class="glyphicon glyphicon-pencil"></span>정보입력</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-sort"></span>가입인증</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 1em; border-bottom-right-radius: 1em; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-home"></span>가입완료</div>
	</div>
    
<div class="container">
    <form name="registerFrm" class="well form-horizontal" action="<%= request.getContextPath() %>/userRegisterEnd.eat" method="post"  id="contact_form" enctype="multipart/form-data" style="width:700px; background:none;">
		<fieldset>
		<!-- Form Name -->
		<legend>필수입력사항</legend>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-4 control-label" >이름</label> 
		    <div class="col-md-7 inputGroupContainer">
		    <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		  <input  name="userName" placeholder="사용자이름" class="form-control"  type="text">
		    </div>
		  </div>
		</div>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-4 control-label">맛집메트로계정(이메일)</label>  
		  <div class="col-md-7 inputGroupContainer">
		  <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		  <input name="userEmail" placeholder="사용자 이메일" class="form-control"  type="text">
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
		<span class="strength"></span>
		<div class="row">
		<div class="col-sm-7">
		<span id="8char" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 8글자 이상 입력<br>
		<span id="ucase" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 한글자 이상 대문자 입력
		</div>
		<div class="col-sm-7">
		<span id="lcase" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 한글자 이상 소문자 입력<br>
		<span id="num" class="glyphicon glyphicon-remove" style="color:#FF0004;"></span> 한글자 이상 숫자 입력 <br>
		
		
		</div>
		</div>
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
		
		<!-- Text input-->
		       
		<div class="form-group" style="overflow:hidden;">
		  <label class="col-md-4 control-label" style="float:left">생년월일</label>  
		    <div class="col-md-7 inputGroupContainer" style=" float:left;">
		    <div class="input-group" style="width:100%;">
		   		 
		        <span class="input-group-addon" ><i class="glyphicon glyphicon-birthday-cake"></i></span>
		  		<div style="overflow:hidden;">
			  		<select id="userYear" name="userYear" style="width:40%;" class="form-control">
			  			<option value="">년도</option>
						  <script type="text/javascript">
							  var myDate = new Date();
							  var year = myDate.getFullYear();
							  for(var i = year; i > 1900; i--){
								  document.write('<option value="'+i+'">'+i+'</option>');
							  }
						  </script>
					</select>
			  		<select id="userMonth" name="userMonth" style="width:30%;" class="form-control">
			  			<option value="">월</option>
			  			<script type="text/javascript">
			  				for (var j=1; j<=12; j++) {
								document.write('<option value="'+j+'">'+j+'</option>');
						  	}
						</script>
			  		</select>
			  		<select id="userDate" name="userDate" style=" width:30%;" class="form-control">
			  			<option value="">일</option>
			  			<script type="text/javascript">
			  				for (k=1; k<=31; k++) {
			  					document.write("<option>"+k+'</option>'); 
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
		
		
		<!-- radio checks -->
		 <div class="form-group">
           <label class="col-md-3 control-label">성별</label>
           <div class="col-md-5">
               <div class="radio">
                   <label>
                       <input type="radio" name="userGender" value="M" /> 남
                   </label>
               </div>
               <div class="radio">
                   <label>
                       <input type="radio" name="userGender" value="F" /> 여
                   </label>
               </div>
           </div>
       </div>
		
		<button type="button">선택사항</button>
		
		
		<!-- Text area -->
		
		<!-- Tab panes -->
		
		<!-- <div class="form-group">
			<label class="col-md-3 control-label">선호역(지역)<br>
		  											최대 3개까지 선택가능합니다
		  	</label>
		    <div class="col-md-6 inputGroupContainer">
		    	<div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
            	<div class="tab-content faq-cat-content">
                	<div class="tab-pane active in fade" id="faq-cat-1">
                    	<div class="panel-group" id="accordion-cat-1">
                        	<div class="panel panel-default panel-faq">
                            	<div class="panel-heading">
                                	<a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-1">
                                    	<h4 class="panel-title">
                                        	가
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    	</h4>
                                	</a>
                            	</div>
                            	<div id="faq-cat-1-sub-1" class="panel-collapse collapse">
                                	<div class="panel-body">
                                    	<div class="row form-group">
                                        	<div class="col-sm-4"> <label for = "kangnam">강남역</label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="kangnam" value="강남" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                         
                                         <div class="row form-group">
                                        	<div class="col-sm-4"><label for = "gangbyeon">강변역</label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="gangbyeon" value="강변" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
             
             
                                         <div class="row form-group">
                                        	<div class="col-sm-4"><label for = "geondaeibgu">건대입구역</label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="geondaeibgu" value="건대입구" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
             
             
                                         <div class="row form-group">
                                        	<div class="col-sm-4"> <label for = "gyodae">교대역 </label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="gyodae"  value="교대" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
             
                                         <div class="row form-group">
                                        	<div class="col-sm-4"> <label for = "gulodijiteoldanji"> 구로디지털단지역 </label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="gulodijiteoldanji" value="구로디지털단지" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                         
                                         <div class="row form-group">
                                        	<div class="col-sm-4"> <label for = "guui">구의역</label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="guui" value="구의" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                </div>
                            </div>
                        </div>
		
				<div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	나
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   <div class="row form-group">
                                        	<div class="col-sm-4"> <label for = "nagseongdae"> 낙성대역 </label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="nagseongdae" value="guui" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                   
                                </div>
                            </div>
                        </div>
                
                
                <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-3">
                                    <h4 class="panel-title">
                                       		다
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-3" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                      <div class="col-sm-5"> <label for = "dangsan"> 당산역 </label>  </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="dangsan" value="dangsan" name="userStation">  선택
                                          		</label>
                                         		</div>
                                         </div>
                                         
                                         <div class="row form-group">
                                        	<div class="col-sm-5"> <label for = "daelim"> 대림역 </label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="daelim" value="daelim" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                         
                                         <div class="row form-group">
                                        	<div class="col-sm-5"><label for = "dongdaemunpark">동대문역사문화공원역 </label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="dongdaemunpark" value="dongdaemunpark" name="userStation">선택
                                          		</label>
                                         		</div>
                                		</div>
                                		
                                		<div class="row form-group">
                                        	<div class="col-sm-5"> <label for = "ttugseom">뚝섬역 </label> </div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="ttugseom" value="ttugseom" name="userStation">  선택
                                          		</label>
                                         		</div>
                                         </div>
                            </div>
                        </div>
                     </div>
                
       <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-4">
                                    <h4 class="panel-title">
                                       	마
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-4" class="panel-collapse collapse">
                                <div class="panel-body">
                                   <div class="row form-group">
                                        	<div class="col-sm-4">  <label for = "munlae">문래역 </label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="munlae" value="munlae" name="userStation"> 선택
                                          		</label>
                                         		</div>
                                         </div>
                                   
                                </div>
                            </div>
                        </div>
                        
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-5">
                                    <h4 class="panel-title">
                                       	바
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-5" class="panel-collapse collapse">
                                <div class="panel-body">
                                   <div class="row form-group">
                                        	<div class="col-sm-4">   <label for = "bangbae">방배역</label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="bangbae" value="bangbae" name="userStation">  선택
                                          		</label>
                                         		</div>
                                         </div>
                                         
                                         <div class="row form-group">
                                        	<div class="col-sm-4">   <label for = "bongcheon">봉천역 </label></div>  
                                         		<div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          		<label class="btn btn-default btn-sm">
                                            	<input type="checkbox" id="bongcheon" value="bongcheon" name="userStation">  선택
                                          		</label>
                                         		</div>
                                         </div>
                                   
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	사
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	아
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	자
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	차
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	하
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="panel panel-default panel-faq">
                            <div class="panel-heading">
                                <a data-toggle="collapse" data-parent="#accordion-cat-1" href="#faq-cat-1-sub-2">
                                    <h4 class="panel-title">
                                       	나
                                        <span class="pull-right"><i class="glyphicon glyphicon-plus"></i></span>
                                    </h4>
                                </a>
                            </div>
                            <div id="faq-cat-1-sub-2" class="panel-collapse collapse">
                                <div class="panel-body">
                                   
                                   <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                 
                                 <div class="row form-group">
                                        <div class="col-sm-2">Fever</div>  
                                         <div class=" col-sm-3 btn-group" data-toggle="buttons">
                                          <label class="btn btn-primary btn-sm  active">
                                            <input type="checkbox" autocomplete="off" checked>Yes
                                          </label>
                                          <label class="btn btn-primary btn-sm">
                                            <input type="checkbox" autocomplete="off">No
                                          </label>
                                         </div>
                                 </div>
                                </div>
                            </div>
                        </div>         -->
		
		
		
		
		
		
		
		  
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
		</div>
		    </div><!-- /.container -->
</div>
<%--subrightCon --%>
</body>
</html>