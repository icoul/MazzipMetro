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
<script type="text/javascript">
		<c:if test="${result == 1}">
			alert("회원탈퇴 되었습니다. \n그동안 맛집메트로를 이용해주셔서 감사합니다.");
			/* 글목록을 보여주는 페이지로 이동 */
			location.href="<%= request.getContextPath() %>/index.eat";			
		</c:if>
		
		<c:if test="${result != 1}">
			alert("회원탈퇴 되지 않았습니다. \n앞으로도 많은 이용 부탁드립니다.");
			/* 글목록을 보여주는 페이지로 이동 */
			location.href="<%= request.getContextPath() %>/userMyPage.eat";	
		</c:if>
	</script>
</div>
</body>
</html>