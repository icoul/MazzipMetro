<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="background: #FF5400; margin-top:0px; padding-top:0px;">
<span>::: 아이디 중복검사</span>
</div>
<div>
	<c:if test="${result == 1}">
		※ 이미 맛집메트로계정에 사용중인 이메일 입니다. <br><br> 혹시 맛집메트로 회원이시다면 아이디 찾기를 해보세요.
		
		<div align="center">
			<button type="button" onClick="javascript:self.close();">닫기</button>
		</div>
	</c:if>
</div>

<div>		
	<c:if test="${result != 1}">
		맛집메트로계정에 중복되지 않은 이메일 입니다. <br> 사용하실거면 사용하기 버튼을 클릭 해주세요.
		<div align="center">
			<button type="button" onClick="javascript:self.close();">사용하기</button>
		</div>
	</c:if>
</div>

</body>
</html>

			 