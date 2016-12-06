<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test = "${sessionScope.loginUser.userSort == 0}">
	<nav style="padding-left:30px;" class="navbar navbar-default">
	  <div class="container-fluid">
	    <ul align="center" class="nav navbar-nav">
	     <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">맛집<span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">정복한맛집</a></li>
	          <li><a href="#">태그별통계</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">리뷰
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">작성리뷰목록</a></li>
	          <li><a href="#">새 댓글</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">개인데이터
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">계급표시</a></li>
	          <li><a href="#">마일리지현황</a></li>
	          <li><a href="#">쿠폰현황</a></li>
	          <li><a href="#">사용로그</a></li> 
	          <li id="userEditBtn"> <a href="#">개인정보수정 </a></li> 
	          <li><a href="#">회원탈퇴</a></li>  
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">문의
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="javascript:goAsk();">문의하기</a></li>
	          <li id="userQnaBtn"><a href="#">나의문의내역</a></li>
	        </ul>
	      </li>
	    </ul>
	  </div>
	</nav>
</c:if>
<c:if test = "${sessionScope.loginUser.userSort == 1}">
<nav style="padding-left:30px;" class="navbar navbar-default">
	  <div class="container-fluid">
	    <ul align="center" class="nav navbar-nav">
	     <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">사업자메뉴<span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="<%= request.getContextPath() %>/bossCoinResi.eat">포인트구매</a></li>
	          <li><a href="#">개인정보수정</a></li>
	          <li><a href="#">회원탈퇴</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">점포메뉴
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">매장등록신청</a></li>
	          <li><a href="#">매장리스트</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">통계</a>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">컨텐츠
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">컨텐츠구매</a></li>
	          <li><a href="#">컨텐츠목록</a></li>
	        </ul>
	      </li>
	    </ul>
	  </div>
</nav>
</c:if>

</body>
</html>