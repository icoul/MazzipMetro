<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">

	function userDelete(){
		var result = confirm("정말 회원을 탈퇴하시겠어요?");
		
		if (result) {
			location.href = "<%=request.getContextPath()%>/userDelete.eat";
		}
	}

</script>

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
	          <li><a id="btn_Mazzip" href="javascript:mazzip();">정복한맛집</a></li>
	          <li><a href="#">태그별통계</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">리뷰
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li id="myReviewList"><a href="#">작성리뷰목록</a></li>
	          <li><a href="#">새 댓글</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">개인데이터
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="#">계급표시</a></li>
	          <li><a href="#">마일리지현황</a></li>
	          <li id="userCoupon"><a href="#">쿠폰현황</a></li>
	          <li><a href="#">사용로그</a></li> 
	          <li id="userEdit"><a href="#">개인정보수정 </a></li> 
	          <li id="userAlias"><a href="#">칭호관리</a></li>
	          <li id="userRandomBox"><a href="#">랜덤박스</a></li>
	          <li><a href="#" onClick = "userDelete();">회원탈퇴</a></li>  

	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">문의
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="javascript:goAsk();">문의하기</a></li>
	          <li id="btn_userQna"><a href="#">나의문의내역</a></li>
	            <li ><a href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=회원', '680', '630');">회원 관련문의</a></li><!-- 선택된 페이지 -->
				<li ><a href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=사업주', '680', '580');">사업주 관련문의</a></li>
				<li ><a href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=음식점', '680', '310');">음식점 관련문의</a></li>
				<li ><a href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=기타', '680', '350');">기타 관련문의</a></li>
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
	          <li><a href="<%= request.getContextPath() %>/bossContentList.eat">컨텐츠목록</a></li>
	          <li id="userEdit"><a href="#">개인정보수정 </a></li> 
	          <li><a href="#" onClick = "userDelete();">회원탈퇴</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a class="dropdown-toggle" data-toggle="dropdown" href="#">점포메뉴
	        <span class="caret"></span></a>
	        <ul class="dropdown-menu">
	          <li><a href="<%= request.getContextPath() %>/restAdd.eat">매장등록신청</a></li>
	          <li><a href="<%= request.getContextPath() %>/restList.eat">매장리스트</a></li>
	        </ul>
	      </li>
	      <li class="dropdown">
	        <a href="<%= request.getContextPath() %>/couponList.eat">쿠폰</a>
	      </li>
	      <li class="dropdown">
	        <a href="<%= request.getContextPath() %>/restListStatistics.eat">통계</a>
	      </li>
	    </ul>
	  </div>
</nav>
</c:if>

</body>
</html>