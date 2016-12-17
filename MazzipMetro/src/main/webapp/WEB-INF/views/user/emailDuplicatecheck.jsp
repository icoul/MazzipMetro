<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />   
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script type="text/javascript">
	/* function goCheckEmailComplete() {
		var completeFrm = document.completeFrm;
		completeFrm.submit();
		
		self.close();
	} */	


</script>


</head>
<body style="margin: 0;">
<div style="background: #FF5400; height: 30px; padding-top: 7px;">
	<span style="font-size:13pt;">&nbsp; ::: 아이디 중복검사</span>
</div>
<div>
	<div align="center" style="vertical-align: middle; padding-top:20px;">
	<c:if test="${result == 1}">
		※ 이미 맛집메트로계정에 사용중인 이메일 입니다. <br><br> 혹시 맛집메트로 회원이시다면 아이디 찾기를 해보세요.
		<div align="center" style="padding-top:20px;">
			<button type="button" class = "btn btn-default" onClick="javascript:self.close();">닫기</button>
		</div>
	</c:if>
	</div>
</div>

<div>
	<div align="center" style="vertical-align: middle;">		
	<c:if test="${result != 1}">
		♬ 맛집메트로계정에 중복되지 않은 이메일 입니다. <br> 사용하실거면 사용하기 버튼을 클릭 해주세요.
		<div align="center" style="padding-top:20px;">
		<%-- <form action="<%= request.getContextPath() %>/userRegisterForm.eat" method="POST" name="completeFrm">
			<input type="hidden" name="checkEmail" value="1">
			<button type="button" class = "btn btn-default" onClick="goCheckEmailComplete();">사용하기</button>
		</form> --%>
		<button type="button" class = "btn btn-default" onClick="javascript:self.close();">사용하기</button>
		</div>
	</c:if>
	</div>
</div>

</body>
</html>



		