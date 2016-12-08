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
	<script type="text/javascript">
		<c:if test="${n == 1}">
			alert("회원가입 성공");
			/* 글목록을 보여주는 페이지로 이동 */
			location.href="<%= request.getContextPath() %>/index.eat";			
		</c:if>
		
		<c:if test="${n != 1}">
			alert("회원가입 실패");
			/* 글목록을 보여주는 페이지로 이동 */
			location.href="<%= request.getContextPath() %>/userRegister.eat";	
		</c:if>
	</script>
</body>
</html>