<%@page import="org.springframework.web.context.request.SessionScope"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.go.mazzipmetro.vo.UserVO"%> 
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>:::Mazzip Metro:::</title>

<script type="text/javascript"> 
function getLoginUserInfo(){
		
	 	//alert('로그인 정보를 갱신하는 함수를 따로 만들었습니다. 사용자 정보가 바뀌는 경우 이 함수를 호출해 주세요~');
		/* $.getJSON("loginUserInfo.do", function(data){
		
		}); // end of $.getJSON();	 */
		
	}//end of getLoginUserInfo () 
	
	$(document).ready(function(){
		//동현_관리자 dropdown 메뉴용 이벤트
		$(".dropdown").hover(function(){
			$(".dropdown-content").css('display','block');
		}, function(){
			$(".dropdown-content").css('display','none');
		});	
		
		//가고싶다 상단의 배너
		wantGoContentView();

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
					
					// 사용자의 가고싶다 갱신 함수 호출
			  		getUserWantToGo();
					
					// 로그인시 맛집추천을 받았는지 여부 체크해서 업무진행
			  		userRestRecomCheck();
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
		
		
		//SideMenu 활성화 관련 이벤트 
  		$("#mySidenavTrigger").mouseover(function(){
  			$("#mySidenav").css('display',"block");
  			$(this).fadeTo('slow', 0.2);
  		});
  		
  		$("html").click(function(){
  			$("#mySidenav").css('display',"none");
  		});
  	
  		$("#mySidenav").click(function(event){//사이드메뉴를 클릭해도 사라지지 않는다.
  			event.stopPropagation();
  		})
  		
  		$("#mySidenav").mouseleave(function(){//mouseout과 mouseleave의 차이는 자식엘레먼트에 출입여부를 이벤트에 포함시키는냐 아니냐이다.
  			$("#mySidenav").css('display',"none");
  		});
  		
		$("#dx_wantToGo").mouseover(function(){
			$("#mySidenav").css('display',"block");
  		});
  		
		
  		
  		(function($){
	 		 // 자동 완성 keyup 이벤트
	 		 $("#keyword").keyup(function(){
	    		
				$.ajax({
					url:"<%=request.getContextPath()%>/autoComplete.eat",
					type :"GET",
					data: "srchType=all&keyword="+$("#keyword").val(),
					dataType:"json",
					success: function(data){
						//alert(data.autoComSource);
						
						$.widget( "custom.catcomplete", $.ui.autocomplete, {
							      _create: function() {
							        this._super();
							        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
							      },
							      _renderMenu: function( ul, items ) {
							        var that = this,
							          currentCategory = "";
							        $.each( items, function( index, item ) {
							          var li;
							          if ( item.category != currentCategory ) {
							            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
							            currentCategory = item.category;
							          }
							          li = that._renderItemData( ul, item );
							          if ( item.category ) {
							            li.attr( "aria-label", item.category + " : " + item.label );
							          }
							        });// end of  $.each()
							      }
							    });// end of $.widget( "custom.catcomplete", $.ui.autocomplete, {})
							
							$("#keyword").catcomplete({
								delay : 0,
								minLength: 0,
								source : data.cat_autoComSource
							})						 
						
						
					}, //end of success: function(data)
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					} // end of error: function(request,status,error)
				}); //end of $.ajax()
				
				
			});// end of $("#keyword").keyup
 		
  		})(jQuery)	
  		
  		
	});
	
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
	
	$(".myclose").click(function(){
			javascript:history.reload();
	});
	
	function goAsk(){
		<c:if test="${empty sessionScope.loginUser.userSeq}">
			alert("로그인후 문의하실 수 있습니다.");
			goLogin();
			return;		
		</c:if>
		var url = "<%=request.getContextPath()%>/myQna.eat";
		window.open(url, "myQna", "left=350px, top=100px, width=500px, height=400px, status=no, scrollbars=yes");		
	}
	
	//가고싶다에 들어가는 배너 컨텐츠 뷰
   	function wantGoContentView(){
   		$.ajax({
			url : "<%=request.getContextPath()%>/wantGoContentView.eat",
			method : "GET",
			dataType : "html",
			success : function(data){
				$("#wantGoContentView").html(data);
			}
		}); // end of ajax
   	}
	
	// 가고싶다 추가 함수
	function addWantToGo(restSeq){
			
		<c:if test="${empty sessionScope.loginUser}">
		<%  if(request.getParameter("restSeq") != null){
			 session.setAttribute("returnPage", "restaurantDetail.eat?restSeq=" + request.getParameter("restSeq").trim());
		}
		%>
			alert("로그인후 이용해주세요~~");
			return;
		</c:if>
		
		<c:if test="${not empty sessionScope.loginUser}">
		$.ajax({
				url:"<%=request.getContextPath()%>/addWantToGo.eat",
				type :"POST",
				data: "restSeq="+restSeq,
				dataType:"json",
				success: function(data){
							
					alert(data.msg);
					getUserWantToGo();
							
				}, //end of success: function(data)
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error: function(request,status,error)
			}); //end of $.ajax()
		</c:if>	
	}
	
	// 사용자 가고싶다 ajax 호출
	function getUserWantToGo(){
		$.ajax({
			url:"<%=request.getContextPath()%>/getUserWantToGo.eat",
			type :"GET",
			dataType:"html",
			success: function(data){
				
					$("#myWantToGo").html(data);
			
			}, //end of success: function(data)
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			} // end of error: function(request,status,error)
		
		}); //end of $.ajax()

	}
	
	// 가고싶다 삭제 함수
	function goDel(){
  		if($("[name=wantToGoChk]:checked").length == 0){
			alert('삭제할 음식점을 먼저 선택해주세요!');
			return;
		}
		
		//폼전송 : ajax로 대여진행한 후에, 가고싶다 정보 갱신...
		//배열은 변수에 담기
		var wantToGoChkArr = [];
		
		$("[name=wantToGoChk]:checked").each(function(){
			wantToGoChkArr.push($(this).val());
		});
		
		//alert(wantToGoChkArr);
		
		var delWantToGoFrmData = {
				wantToGoChk: wantToGoChkArr 
		}
		
		$.ajax({
			url: "<%=request.getContextPath()%>/delWantToGo.eat", 
			method:"POST",  		 // method
			data: delWantToGoFrmData,
			traditional: true,		 // 배열 데이터 전송용
			dataType: "JSON",        // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
			success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
					alert(data.msg);
					getUserWantToGo();
				}
		});//end of $.ajax()
  	}
  	
	function userRestRecomCheck(){
		// 로그인시 맛집추천을 받아다면, 곧장 리뷰쓰기 창을 띄운다.
  		if(${not empty sessionScope.restRecom}){
  			goReviewAdd('${sessionScope.restRecom}');
  		}
	}
	
	// 로그인시 맛집추천을 받아다면, 곧장 리뷰쓰기 창을 띄운다.
	function goReviewAdd(restSeq){
		
		var bool = confirm('추천받은 맛집에 다녀오셨나요? 리뷰를 쓰시겠습니까?');
		
		if(bool){
			var url = "<%=request.getContextPath()%>/reviewAdd.eat?restSeq="+restSeq;
			var title = "리뷰 작성";
			var status = "left=500px, top=100px, width=600px, height=915px, menubar=no, status=no, scrollbars=yes ";
			var popup = window.open(url, title, status); 			
		} else {
			$.ajax({
				url: "<%=request.getContextPath()%>/delWantToGo.eat", 
				method:"POST",  		 // method
				data: "wantToGoChk="+restSeq,
				traditional: true,		 // 배열 데이터 전송용
				dataType: "JSON",        // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수

						alert(data.msg);
						getUserWantToGo();
					}
			});//end of $.ajax()
		} 
	}
		
		// input 태그 엔터키 refresh 방지
	   	function goButton() {
	   		 if (event.keyCode == 13) {
	   			goSearch();
	   		  	return false;
	   		 }
	   		 return true;
	   	}
		
	    function goSearch(){
	    	   if($("#keyword").val().trim().length == 0){
	    		   return;
	    	   }
	    	   
	    	   searchFrm.action = "<%=request.getContextPath()%>/search.eat";
	    	   searchFrm.submit();
	       }
	    
	    function openWinFaq(src, width, height){
			window.open(src,"팝업창이름(의미없음)", "width=" + width + ", height=" + height + ", left=100px, top=100px, menubar=no, status=no, scrollbars=no");
		}

	       
</script>

</head>
<body>

<%-- 사이드메뉴 트리거용 div 화면 왼쪽--%>
<div id="mySidenavTrigger" style="width: 1px; height: 100%; position:fixed; z-index: 9999; border: solid 0px red;"></div>

<%-- 사이드 메뉴 & 장바구니 --%>
<div id="mySidenav" class="sidenav">
	<div style="height: 100px;" id = "wantGoContentView">
	</div>
		<div style="padding-left: 20px; padding-top: 50px;">
		<br/><br/> 맛집메트로가 제공하는 <span style="color: lime;">가고싶다</span>를 이용해 보세요. <br/><br/> <br/> <br/> 		
		</div>
        <span style="color: #818181; font-size: 22px; font-weight: bold; margin-left: 35px;">가고싶다 </span>카트
  <div id="myWantToGo" style="border: solid 1px #818181;margin: 5px; padding: 5px;" align="center">
  	<br/><br/><span style="color: #818181; text-decoration: underline;">가고 싶은 음식점을 담아보세요.</span><br/><br/> 
  </div>
</div>


<div id="top_container">

	<div id="headWrap">
		<!-- 로그인 정보 : top 맨위 -->
		<c:if test="${sessionScope.loginUser.userSeq == null && empty sessionScope.loginUser.userSeq}">
			<div class="loginWrap">
				<div class="topWrap">
					<div class="loginInfo">
						<button type="button" class="btn btnLogout" data-toggle="modal" data-target="#accountSelectModal"><span class = "logOut">회원가입</span></button>
						<button type="button" class="btn btnLogout" data-target="#loginModal" data-toggle="modal"><span class = "logOut">로그인</span></button>
					</div> 
				</div>
			</div>
		</c:if>	
		
		<c:if test="${sessionScope.loginUser.userSeq != null && not empty sessionScope.loginUser.userSeq}">
			<div class="loginWrap">
				<div class="topWrap">
					<div class="loginInfo">
					 <c:if test="${sessionScope.loginUser.userSort == 0}">
		               <span class="fontDesign" style="font-weight: bold;">${sessionScope.loginUser.userName}</span>
		                <span style="color: #000; font-size:12px; font-stretch:narrower; margin-right:10px; font-weight: bold;">님 환영합니다 </span>
		            </c:if>
		            <c:if test="${sessionScope.loginUser.userSort == 1}">
		               <span class="fontDesign" style="font-weight: bold;">${sessionScope.loginUser.userName}</span>
		               <span style="color: #000; font-size:12px; font-stretch:narrower; margin-right:10px; font-weight: bold;">님 환영합니다 </span>
		            </c:if>
						<span class="btnDesign"> 현재 마일리지 </span> &nbsp;
						<span style="color:#008968; font-size:12px; font-stretch:narrower; margin-right: 10px; font-weight: bold;"><fmt:formatNumber pattern="#,###,###,###">${sessionScope.loginUser.userPoint }</fmt:formatNumber></span>
						<span class="btnDesign"> 등급 </span> &nbsp;
							<c:if test="${sessionScope.loginUser.gradeName eq '흙수저'}">
								<img src="<%=request.getContextPath()%>/resources/images/icoUserGrade01.png" width="8" height="15"> 
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '구리수저'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade02.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '은수저'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade03.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '금수저'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade04.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '다이아수저'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade05.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '달인'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade06.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '신'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoUserGrade07.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '초가집'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade01.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '황토집'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade02.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '기와집'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade03.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '왕궁'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade04.png" width="15" height="15" >
							</c:if>
							<c:if test="${sessionScope.loginUser.gradeName eq '황궁'}">
								<img src="<%= request.getContextPath() %>/resources/images/icoBossGrade05.png" width="15" height="15" >
							</c:if>
		
						
						<span style="color: red; font-size:12px; font-stretch:narrower; font-weight: bold; margin-right: 10px;">${sessionScope.loginUser.gradeName }</span>
						<span class="btnDesign">Exp</span>
						<span style="color: red; font-size:12px; font-stretch:narrower; font-weight: bold; margin-right: 10px;"><fmt:formatNumber pattern="#,###,###,###">${sessionScope.loginUser.userExp }</fmt:formatNumber>  
			
						<c:if test="${sessionScope.loginUser.gradeSeq eq 'UG1'}">
		                  / 200
		               </c:if>
		               <c:if test="${sessionScope.loginUser.gradeSeq eq 'UG2'}">
		                  / 750
		               </c:if>
		               <c:if test="${sessionScope.loginUser.gradeSeq eq 'UG3'}">
		                  / 1200
		               </c:if>
		               <c:if test="${sessionScope.loginUser.gradeSeq eq 'UG4'}">
		                  / 3500
		               </c:if>
		               <c:if test="${sessionScope.loginUser.gradeSeq eq 'UG5'}">
		                  / 5000
		               </c:if>
		               <c:if test="${sessionScope.loginUser.gradeSeq eq 'UG6'}">
		                  / 10000
		               </c:if>
		               </span>
		              
					<c:if test="${sessionScope.loginUser.userSeq != null && not empty sessionScope.loginUser.userSeq}">
						<button type="button" class="btn btnLogout"  onClick="goLogOut();"><span class = "logOut">로그아웃</span></button>
					</c:if>
					</div> 
				</div>
			</div>
		</c:if>	
			<div class="header">
				<h1><a href="<%= request.getContextPath() %>/index.eat" style="text-decoration: none"><img src="<%=request.getContextPath()%>/resources/images/logoMazzipMetro.png" /></a></h1>
				<div style="padding-top: 5px;">
					
				<ul class="menu">
					<li><a><span id="dx_wantToGo">가고싶다</span></a></li>
					<li><a href="<%=request.getContextPath()%>/ranking.eat">맛집랭킹</a></li>
					<li><a href="<%=request.getContextPath()%>/theme.eat">테마검색</a></li>
					
					<!-- 비회원 로그인시(로그인전) -->
					<c:if test="${empty sessionScope.loginUser.userSeq}">
						<li><a href="javascript:goAsk();">문의하기</a></li>
						<li><a href="<%=request.getContextPath()%>/faq.eat">FAQ</a></li>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</c:if>
					<!-- 일반사용자 로그인시 -->
					<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 0}">
						<li><a href="<%=request.getContextPath()%>/userMyPage.eat">마이페이지</a></li>
						<li><a href="javascript:goAsk();">문의하기</a></li>
						<li><a href="<%=request.getContextPath()%>/faq.eat">FAQ</a></li>
					</c:if>
					<!-- 사업주 로그인시 -->
					<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 1}">
						<li><a href="<%=request.getContextPath()%>/userMyPage.eat">마이페이지</a></li>
						<li><a href="javascript:goAsk();">문의하기</a></li>
						<li><a href="<%=request.getContextPath()%>/faq.eat">FAQ</a></li>
					</c:if>
					<!-- 관리자 로그인시 -->
					<c:if test="${not empty sessionScope.loginUser.userSeq && sessionScope.loginUser.userSort == 2}">
						<!-- 관리자 dropdown 메뉴 -->
						<li>
							<div class="dropdown">
						  		<a class="drop_anchor">관리자메뉴</a>
								  <div class="dropdown-content" style="z-index:9999;">
									<a href="<%=request.getContextPath()%>/adminRestManager.eat">업장관리</a>
									<a href="<%=request.getContextPath()%>/adminUserList.eat">회원관리</a>
									<a href="<%=request.getContextPath()%>/adminContentList.eat">컨텐츠관리</a>
									<a href="<%=request.getContextPath()%>/adminQnaList.eat">고객문의내역</a>
								  </div>
							</div>
						</li>
					</c:if>
				</ul>

				</div>
				
				<!-- 검색바 -->
				<div  id="search_div" align="center" style="position: absolute; top: 21px; right: 0; width: 30%;">
				  <form name="searchFrm" id="searchFrm" onsubmit="return false;">
				    <div class="input-group" style="width: 100%;">
				      <input type="text" class="form-control" name="keyword" id="keyword" size="50" placeholder="검색어를 입력하세요!" onkeydown="goButton();" required>
				      <div class="input-group-btn">
				        <button type="button" class="btn btnColor" onclick="goSearch();"><i class="glyphicon glyphicon-search"></i> &nbsp;<span>검색</button>
				      </div>
				    </div>
				  </form>
				</div>
	
				
			</div>
	</div>

	<!-- headWrap -->
	
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
        <p><a data-toggle="modal" data-target="#accountSelectModal" data-dismiss="modal" style="color:#f4511e; cursor: pointer;">회원가입하기</a></p>
        <p>
        <td colspan="2" align="center">
        	<a data-toggle="modal" data-target="#userIdfind" data-dismiss="modal" style="cursor: pointer;">아이디찾기</a> / 
			<a data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" style="cursor: pointer;">비밀번호찾기</a>
		</td>	
		</p>
      </div>
    </div>
    
  </div>
</div><!-- end of Login Modal -->


<!-- 회원가입을 위한 Modal -->
  <div class="modal fade" id="accountSelectModal" role="dialog" style="">
    <div class="modal-dialog  modal-lg">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">회원유형선택</h4>
        </div>
        <div class="modal-body" align="center">
          <a href="<%= request.getContextPath()%>/userRegisterAgree.eat?type=0" class="btn btn-sq-lg btn-info">
              <i style="font-size: 10em;" class="fa fa-user"></i><br><br>
              	<span style="font-size:2em;">개인</span>
		  </a>
		  <a href="<%= request.getContextPath()%>/userRegisterAgree.eat?type=1" style="margin-left: 3%" class="btn btn-sq-lg btn-success">
              <i style="font-size: 10em;" class="fa fa-users"></i><br><br>
              	<span style="font-size:2em;">사업자</span>
            </a>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        </div>
      </div>
      
    </div>
  </div>
  

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
          	<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath() %>/emailFind.eat">
          	</iframe>
          </div>
        </div>
        <div class="modal-footer">
        <button type="submit" class="btn btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소</button>
        <p>
        <td colspan="2" align="center">
			<a data-toggle="modal" data-target="#accountSelectModal" data-dismiss="modal" style="color:#f4511e; cursor: pointer;">회원가입하기</a> /
			<a data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" style="cursor: pointer;">비밀번호찾기</a>
		</td>	
		</p>
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
        <button type="submit" class="btn btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소</button>
        <p>
        <td colspan="2" align="center">
			<a data-toggle="modal" data-target="#accountSelectModal" data-dismiss="modal" style="color:#f4511e; cursor: pointer;">회원가입하기</a> /
			<a data-toggle="modal" data-target="#userIdfind" data-dismiss="modal" style="cursor: pointer;">아이디찾기</a>
		</td>	
		</p>
      </div>
      </div>
      
    </div>
</div>