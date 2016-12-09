<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.go.mazzipmetro.vo.UserVO"%> 
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 기본 jquery 라이브러리 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>

<!-- 부트스트랩 라이브러리 -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<!-- 동현_다음지도 api를 사용하기 위한 라이브러리 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=07a6ce4a014b94664ec5968dee2fb0d2&libraries=services,clusterer,drawing"></script>

<!-- 동현_메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />

<!-- 동현_검색어 자동완성을 위한 jquery-ui 라이브러리 -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui.css">
<script src="<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui.js"></script>

<!-- 미현_전체페이지 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css" />

<!-- 은석_레스토랑 디테일.jsp에서 차트를 이용하기 위한 라이브러리 추가 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/modules/exporting.js"></script>

<!-- 한별_회원가입 css -->
<link href="<%= request.getContextPath() %>/resources/css/hb_register_.css" rel="stylesheet">

<!-- 한별_회원가입 유효성 검사용 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn-async.min.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>

<title>:::Mazzip Metro:::</title>

<script type="text/javascript"> 

function getLoginUserInfo(){
		
	 	//alert('로그인 정보를 갱신하는 함수를 따로 만들었습니다. 사용자 정보가 바뀌는 경우 이 함수를 호출해 주세요~');
		$.getJSON("loginUserInfo.do", function(data){
		
		}); // end of $.getJSON();	
		
	}//end of getLoginUserInfo () 

	
	$(document).ready(function(){
		//생성된 쿠키를 사용하기 위한 자바코드
		<%
		  		UserVO loginUser = (UserVO)session.getAttribute("loginUser");	

		  		// 1.로그인을 하지 않은 경우
		  		if(loginUser == null){ // Not Logged In
		  		
			  		Cookie[] cookies = request.getCookies();
			  		//쿠키는 쿠키의 이름별로 여러개 저장되어 있으므로,
			  		//배열 타입으로 가져와서, 원하는 쿠키의 이름과 일치하는 것을 뽑는다.(반복문을 통해 비교할 것.)
			  		
			  		String cookieKey = ""; 
			  		String cookieValueId = "";
			  		String cookieValuePwd = "";
			  		boolean isRememberId = false;
			  		boolean isRememberPwd = false;
			  		
			  		if(cookies != null){
			  			for(Cookie c: cookies){
			  				cookieKey = c.getName();//쿠키의 이름을 꺼내오는 메소드
			  				
		 	 	 			System.out.println("cookieKey : "+c.getName()); 
		 	 	 			System.out.println("cookieValue :"+c.getValue()); 
			  				
			  				if(cookieKey.equals("rememberId")){
			  					String id_value = URLDecoder.decode(c.getValue(), "UTF-8");
			  					//System.out.println(id_value);
		%>
								<%-- document.getElementById("dx_userId").value = "<%=id_value%>"; --%>
								
								$("#dx_userId").val('<%=id_value%>'); 
								$("#dx_rememberId").prop('checked',true);
								
								
		<%
//		 	  					cookieValueId = c.getValue();//쿠키의 value 값을 리턴하는 메소드
//		 	  					isRememberId = true;
			  					continue;
			  				}
			  				
			  				if(cookieKey.equals("rememberPwd")){
		%>
								$("#dx_password").val('<%=c.getValue()%>');
								$("#dx_rememberPwd").prop('checked',true);
		<%	  					
//		 	  					cookieValuePwd = c.getValue();//쿠키의 value 값을 리턴하는 메소드
//		 	  					isRememberPwd = true;
			  					continue;
			  				}
			  				
			  				if(cookieKey.equals("autoLogin")){
		%>				
								loginSubmit();
		<%	  				
			  				}
			  			}//end of for(Cookie c: cookies) 
			  				
			  		}//end of if(cookies != null) 
		  		
		  		} else {//로그인한 상태
		%>  			
					getLoginUserInfo();
		<%  		
		  		}
		%>
		
		
		
		
		//Login 모달창 폼 전송하기
		$("#btnLoginSubmit").click(function(){
			var dx_userId = $("#dx_userId").val().trim();
			var dx_password = $("#dx_password").val().trim();
			if(dx_password.length == 0 || dx_userId.length == 0){
				alert('아이디와 비밀번호를 입력해주세요.');
				return;
			}
			$("#dx_userId").val(dx_userId);
			$("#dx_password").val(dx_password);
			loginSubmit();
		});
		
	});// end of ready~~~~~~~~~~~~~~
	function loginSubmit(){
		$("#dx_loginFrm").submit();
	}
	
	function goLogin(){
		var $modal = $('#loginModal');
    	$modal.modal();
	}
	
	function goLogOut(){
		location.href = "logOut.eat";
	}
	
	function goRegister(){
		location.href = "<%=request.getContextPath()%>/accountSelect.eat";
	}
	
	function goAsk(){
		<c:if test="${empty sessionScope.loginUser.userSeq}">
			alert("로그인후 문의하실 수 있습니다.");
			goLogin();
			return;		
		</c:if>

		var url = "<%=request.getContextPath()%>/myQna.eat";
		window.open(url, "myQna", "left=350px, top=100px, width=500px, height=400px, status=no, scrollbars=yes");		
	}
	
</script>

</head>
<body>
<div id="container">
	<div id="headWrap">	
		<div class="header">
			<h1><a href="<%= request.getContextPath() %>/index.eat" style="color: black; text-decoration: none">Mazzip Metro</a></h1>
			<ul class="menu">
				<!-- 비회원 로그인시(로그인전) -->
				<c:if test="${empty sessionScope.loginUser.userSeq}">
					<li><a href="#">맛집랭킹</a></li>
					<li><a href="javascript:goAsk();">문의하기</a></li>
					<li><a href="<%=request.getContextPath()%>/faq.eat">자주하는 질문</a></li>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<!-- 일반사용자 로그인시 -->
				<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 0}">
					<li><a href="#">맛집랭킹</a></li>
					<li><a href="<%=request.getContextPath()%>/userMyPage.eat">마이페이지</a></li>
					<li><a href="javascript:goAsk();">문의하기</a></li>
					<li><a href="<%=request.getContextPath()%>/myQnaList.eat">나의 문의내역</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<!-- 사업주 로그인시 -->
				<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 1}">
					<li><a href="#">맛집랭킹</a></li>
					<li><a href="<%=request.getContextPath()%>/userMyPage.eat">마이페이지</a></li>
					<li><a href="javascript:goAsk();">문의하기</a></li>
					<li><a href="<%=request.getContextPath()%>/myQnaList.eat">나의 문의내역</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<!-- 관리자 로그인시 -->
				<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 2}">
					<li><a href="#">맛집랭킹</a></li>
					<li><a href="<%=request.getContextPath()%>/adminRestManager.eat">업장관리</a></li>
					<li><a href="<%=request.getContextPath()%>/adminUserList.eat">회원관리</a></li>
					<li><a href="<%=request.getContextPath()%>/adminQnaList.eat">고객문의내역</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				
			</ul>

			<c:if test="${sessionScope.loginUser.userSeq == null && empty sessionScope.loginUser.userSeq}"> 
			<button class="btnLogin" data-target="#loginModal" data-toggle="modal">모달출력버튼</button><br/>
			<button type="button" class="btnLogin" onclick="goRegister();">회원가입</button>
			</c:if>
			<c:if test="${sessionScope.loginUser.userSeq != null && not empty sessionScope.loginUser.userSeq}">
			${sessionScope.loginUser.userName} 님 환영합니다. 
			현재 마일리지: <span style="color:gold">${sessionScope.loginUser.userPoint }</span>
			<button type="button" class="btnLogin" onClick="goLogOut();">로그아웃</button>
			</c:if>

		</div>
	</div>
	
	<div id="content">
	
<!-- Login Modal -->
<div class="modal fade" id="loginModal" role="dialog">
  <div class="modal-dialog">
  
    <!-- Login Modal content-->
    <div class="modal-content">
      <div class="modal-header" style="padding:35px 50px;">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4><span class="glyphicon glyphicon-lock"></span> 로그인</h4>
      </div>
      <div class="modal-body" style="padding:40px 50px;">
        <form role="form" id="dx_loginFrm" name="dx_loginFrm" action="login.eat" method="post">
          <div class="form-group">
            <label for="dx_userId"><span class="glyphicon glyphicon-user"></span> ID</label>
            <input type="text" class="form-control" id="dx_userId" name="dx_userId" placeholder="ID를 입력하세요">
          </div>
          <div class="form-group">
            <label for="dx_password"><span class="glyphicon glyphicon-eye-open"></span> Password</label>
            <input type="password" class="form-control" id="dx_password" name="dx_password" placeholder="비밀번호를 입력하세요">
          </div>
          <div class="checkbox">
            <label><input type="checkbox" id="dx_rememberId" name="dx_rememberId">아이디 저장</label>&nbsp;&nbsp;
            <label><input type="checkbox" id="dx_rememberPwd" name="dx_rememberPwd">비밀번호 저장</label>
            <label><input type="checkbox" id="dx_autoLogin" name="dx_autoLogin">자동로그인</label>
            <button type="button" class="btn btn-default pull-right" id="btnLoginSubmit" name="btnLoginSubmit">
            <span class="glyphicon glyphicon-off"></span> 로그인</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소</button>
        <p><a href="javascript:goRegister();" style="color:#f4511e">회원가입하기</a></p>
        <p>
        <td colspan="2" align="center">
        	<a data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a> / 
			<a data-toggle="modal" data-target="#passwdFind" data-dismiss="modal">비밀번호찾기</a>
		</td>	
		</p>
      </div>
    </div>
    
  </div>
</div><!-- end of Login Modal -->

<%-- ****** 아이디 찾기 Modal ******* --%> 
<div class="modal fade" id="userIdfind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" align="center">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">아이디 찾기</h4>
        </div>
        <div class="modal-body" style="height: 300px; width: 100%;">
          <div id="idFind">
          	<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath() %>/idFind.eat">
          	</iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>



<%-- ****** 비밀번호 찾기 Modal ******* --%> 
<div class="modal fade" id="passwdFind" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content" align="center">
        <div class="modal-header">
          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 찾기</h4>
        </div>
        <div class="modal-body" style="height: 400px; width: 100%;">
          <div id="pwFind">
          	<iframe style="border: none; width: 100%; height: 350px;" src="<%= request.getContextPath() %>/pwdFind.eat">
          	</iframe>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
</div>

