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
		                        message: '이름을 입력해주세요.'
		                    }
		                }
		            },
		            userEmail: {
		                validators: {
		                    notEmpty: {
		                        message: '이메일을 입력해주세요.'
		                    },
		                    emailAddress: {
		                        message: '이메일형식에 맞지 않습니다.'
		                    }
		                }
		            },
		            userPhone: {
		                validators: {
		                    notEmpty: {
		                        message: '전화번호를 입력해주세요.'
		                    },
		                    phone: {
		                        country: 'CN',
		                        message: '전화번호를 입력해주세요.'
		                    }
		                }
		            },
		            userPw: {
		                validators: {
		                     stringLength: {
		                        min: 8,
		                        max: 15,
		                        message : '8글자 이상 15글자 이하의 비밀번호를 입력해주세요.'
		                    },
		                    notEmpty: {
		                        message: '비밀번호를 입력해주세요.'
		                    }
		                }
		            },
		            city: {
		                validators: {
		                     stringLength: {
		                        min: 4,
		                    },
		                    notEmpty: {
		                        message: 'Please supply your city'
		                    }
		                }
		            },
		            state: {
		                validators: {
		                    notEmpty: {
		                        message: 'Please select your state'
		                    }
		                }
		            },
		            zip: {
		                validators: {
		                    notEmpty: {
		                        message: 'Please supply your zip code'
		                    },
		                    zipCode: {
		                        country: 'US',
		                        message: 'Please supply a vaild zip code'
		                    }
		                }
		            },
		            comment: {
		                validators: {
		                      stringLength: {
		                        min: 10,
		                        max: 200,
		                        message:'Please enter at least 10 characters and no more than 200'
		                    },
		                    notEmpty: {
		                        message: 'Please supply a description of your project'
		                    }
		                    }
		                }
		            }
		        })
		        .on('success.form.bv', function(e) {
		            $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
		                $('#contact_form').data('bootstrapValidator').resetForm();

		            // Prevent form submission
		            e.preventDefault();

		            // Get the form instance
		            var $form = $(e.target);

		            // Get the BootstrapValidator instance
		            var bv = $form.data('bootstrapValidator');

		            // Use Ajax to submit form data
		            $.post($form.attr('action'), $form.serialize(), function(result) {
		                console.log(result);
		            }, 'json');
		        });
		    
		    
		    
		    $('#userPw').on('propertychange change keyup paste input', function() {
		        var password = $(this).val();
		        var passwordScore = zxcvbn(password)['score'];
		        
		        var updateMeter = function(width, background, text) {
		          $('.password-background').css({"width": width, "background-color": background});
		          $('.strength').text('안전성: ' + text).css('color', background);
		        }
		        
		        if (passwordScore === 0) {
		          if (password.length === 0) {
		            updateMeter("0%", "#ffa0a0", "none");
		          } else {
		            updateMeter("20%", "#ffa0a0", "very weak");
		          }
		        }
		        if (passwordScore == 1) updateMeter("40%", "#ffb78c", "weak");
		        if (passwordScore == 2) updateMeter("60%", "#ffec8b", "medium");
		        if (passwordScore == 3) updateMeter("80%", "#c3ff88", "strong");
		        if (passwordScore == 4) updateMeter("100%", "#ACE872", "very strong"); // Color needs changing
		        
		      });
		      
		      $('.show-password').click(function(event) {
		        event.preventDefault();
		        if ($('#password').attr('type') === 'password') {
		          $('#password').attr('type', 'text');
		          $('.show-password').text('Hide password');
		        } else {
		          $('#password').attr('type', 'password');
		          $('.show-password').text('Show password');
		        }
		      });
		});
	
	
	
	</script>
</head>
<body>
	<div align="center" style="height: 100px; width:100%; border: 2px solid red; margin: auto; padding:1em;">
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-left-radius: 1em; border-bottom-left-radius: 1em; height: 50px; width:150px; border-right:none;"><span class="glyphicon glyphicon-pencil"></span>약관동의</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; background-color:blue;  height: 50px; width: 150px;"><span class="glyphicon glyphicon-pencil"></span>정보입력</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-sort"></span>가입인증</div>
		<div align="center" style="padding: 1em; float:left; border: 2px solid; border-top-right-radius: 1em; border-bottom-right-radius: 1em; height: 50px; width: 150px; border-left:none;"><span class="glyphicon glyphicon-home"></span>가입완료</div>
	</div>
    <a href="#" class="btn btn-lg btn-primary"> </a>
    <a href="#" class="btn btn-lg btn-primary"><span class=""></span> 가입인증</a>
    <a href="#" class="btn btn-lg btn-primary"><span class=""></span> 가입완료</a>
    </label>
    
    <div class="container">

    <form class="well form-horizontal" action=" " method="post"  id="contact_form">
		<fieldset>
		
		<!-- Form Name -->
		<legend>맛집메트로계정 정보입력</legend>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-3 control-label" >이름</label> 
		    <div class="col-md-5 inputGroupContainer">
		    <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
		  <input  name="userName" placeholder="사용자이름" class="form-control"  type="text">
		    </div>
		  </div>
		</div>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-3 control-label">맛집메트로계정(이메일)</label>  
		  <div class="col-md-5 inputGroupContainer">
		  <div class="input-group">
		  <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
		  <input name="userEmail" placeholder="E-Mail Address" class="form-control"  type="text">
		</div>
		  </div>
		</div>
		
		<!-- Text input-->
		 
		<!-- <div class="form-group">
		  <label class="col-md-4 control-label">비밀번호입력</label>  
		    <div class="col-md-4 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		  		<input name="userPw" placeholder="비밀번호입력" class="form-control"  type="text">
		    </div>
		</div>
		</div> -->
		
		<div class="form-group">
            <label for="password">Password</label>
            <input type="password" class="form-control" id="userPw" placeholder="Password">
            <div class="password-background"></div>
            <a class="show-password" href="">Show password</a>
            <span class="strength"></span>
          </div>
		
		<!-- Text input-->
		
		<div class="form-group">
		  <label class="col-md-3 control-label">비밀번호확인</label>  
		    <div class="col-md-5 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
		  <input name="userPw_confirm" placeholder="정확하게 입력해주세요" class="form-control"  type="text">
		    </div>
		</div>
		</div>
		
		<!-- Text input-->
		       
		<div class="form-group">
		  <label class="col-md-3 control-label">생년월일</label>  
		    <div class="col-md-2 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-birthday-cake"></i></span>
		  		<select id="year" name="year">
				  <script type="text/javascript">
				  var myDate = new Date();
				  var year = myDate.getFullYear();
				  for(var i = year; i > year; i--){
					  document.write('<option value="'+i+'">'+i+'</option>');
				  }
				  </script>
				</select> 
		  		<span style="float:left;">-</span>
		  		<div class="col-md-2">
		  		<select name="userBirthday" style="float:left;" class="form-control" width="5%">
		  			
		  		</select> 
		  		</div>
		  		<div class="col-md-2">
		  		<span style="float:left;">-</span>
		  		<select name="userBirthday" style="float:left;" class="form-control" width="5%">
		  			
		  		</select> 
		  		</div>
		    </div>
		  </div>
		</div>
		
		<!-- Text input-->
		       
		<div class="form-group">
		  <label class="col-md-3 control-label">휴대폰번호</label>  
		    <div class="col-md-5 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
		  <input name="userPhone" placeholder="-없이 입력바랍니다" class="form-control" type="text">
		    </div>
		  </div>
		</div>
		
		<!-- radio checks -->
		 <div class="form-group">
           <label class="col-md-3 control-label">성별</label>
           <div class="col-md-5">
               <div class="radio">
                   <label>
                       <input type="radio" name="gender" value="M" /> 남
                   </label>
               </div>
               <div class="radio">
                   <label>
                       <input type="radio" name="gender" value="F" /> 여
                   </label>
               </div>
           </div>
       </div>
		
		<!-- Text area -->
		  
		<div class="form-group">
		  <label class="col-md-3 control-label">선호역(지역)<br>
		  최대 3개까지 선택가능합니다
		  </label>
		    <div class="col-md-6 inputGroupContainer">
		    <div class="input-group">
		        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
		        	가 <br>
		        	<input type="checkbox"> 강남역
					<input type="checkbox"> 강변역
					<input type="checkbox"> 건대입구역 <br>
					<input type="checkbox"> 교대역
					<input type="checkbox"> 구로디지털단지역
					<input type="checkbox"> 구의역 <p><br>
					
					나 <br>
					<input type="checkbox"> 낙성대역 <p>
					
					다 <br>
					<input type="checkbox"> 당산역
					<input type="checkbox"> 대림역
					<input type="checkbox"> 교대역 <br>
					<input type="checkbox"> 동대문역사문화공원역
					<input type="checkbox"> 뚝섬역 <p>

					마 <br>
					<input type="checkbox">	문래역 <p>
					 
					바 <br>       	
		        	<input type="checkbox"> 방배역
					<input type="checkbox"> 봉천역 <p>
					
					사 <br>		        	
					<input type="checkbox"> 삼성역 
					<input type="checkbox"> 상왕십리역
					<input type="checkbox"> 서울대입구역 <br>
					<input type="checkbox"> 서초역
					<input type="checkbox"> 선릉역
					<input type="checkbox"> 성수역 <br>
					<input type="checkbox"> 시청역
					<input type="checkbox"> 신당역
					<input type="checkbox"> 신대방역 <br>
					<input type="checkbox"> 신도림역
					<input type="checkbox"> 신림역
					<input type="checkbox"> 신천역 
					<input type="checkbox"> 신촌역 <p>
					
					아 <br>		        	
					<input type="checkbox">	아현역
					<input type="checkbox"> 역삼역
					<input type="checkbox"> 영등포구청역 <br>
					<input type="checkbox"> 왕십리역
					<input type="checkbox"> 을지로3가역
					<input type="checkbox"> 을지로4가역 <br>
					<input type="checkbox"> 을지로입구역
					<input type="checkbox"> 이대역 <p>
					
					자 <br>
					<input type="checkbox"> 잠실역
					<input type="checkbox"> 잠실나루역
					<input type="checkbox"> 종합운동장역 <p>
					
					차 <br>
					<input type="checkbox"> 충정로역 <p>
					
					하 <br>
					<input type="checkbox"> 한양대역
					<input type="checkbox"> 합정역
					<input type="checkbox"> 홍대입구역
					
					
					
							        	
		  </div>
		  </div>
		</div>
		
		<!-- Success message -->
		<div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i> Thanks for contacting us, we will get back to you shortly.</div>
		
		<!-- Button -->
		<div class="form-group">
		  <label class="col-md-4 control-label"></label>
		  <div class="col-md-4">
		    <button type="submit" class="btn btn-warning" >Send <span class="glyphicon glyphicon-send"></span></button>
		  </div>
		</div>
		
		</fieldset>
		</form>
		</div>
		    </div><!-- /.container -->
    
</body>
</html>