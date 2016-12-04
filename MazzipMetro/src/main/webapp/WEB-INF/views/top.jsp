<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<!-- 다음지도 api를 사용하기 위한 라이브러리 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=07a6ce4a014b94664ec5968dee2fb0d2&libraries=services,clusterer,drawing"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css" />
<title>:::Mazzip Metro:::</title>

<script type="text/javascript">

	$(document).ready(function(){
		
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
			$("#dx_loginFrm").submit();
		});
		
	});// end of ready~~~~~~~~~~~~~~
	
	function goLogin(){
		$("#loginModal").modal();	
	}
	
	function goRegister() {
		
	}
	
	function goLogOut(){
		location.href = "logOut.eat";
	}
	
	
</script>

</head>
<body>
<div id="container">
	<div id="headWrap">	
		<div class="header">
			<h1>Mazzip Metro</h1>
			<ul class="menu">
				<li><a href="#">지도찾기</a></li>	
				<li><a href="#">맛집랭킹</a></li>
				<li><a href="#">리뷰</a></li>
				<li><a href="#">마이페이지</a></li>
				<li><a href="#">문의하기</a></li>&nbsp;&nbsp;&nbsp;&nbsp;
				
			</ul>

			<c:if test="${sessionScope.loginUser.userSeq == null && empty sessionScope.loginUser.userSeq}"> 
			<button type="button" class="btnLogin" onClick="goLogin();" style="margin-left:10px;">로그인</button>
			<button type="button" class="btnLogin">회원가입</button>
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
            <button type="button" class="btn btn-default pull-right" id="btnLoginSubmit" name="btnLoginSubmit">
            <span class="glyphicon glyphicon-off"></span> 로그인</button>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소</button>
        <p><a href="register.eat" style="color:#f4511e">회원가입하기</a></p>
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

