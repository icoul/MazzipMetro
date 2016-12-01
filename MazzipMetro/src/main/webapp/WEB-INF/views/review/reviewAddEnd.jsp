<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기 완료 페이지</title>
</head>
<body>
	<script type="text/javascript">
		<c:if test="${result == 1}">
			alert("글쓰기 성공!!");
			window.opener.location.reload();
			window.close();
			// 글목록을 보여주는 페이지로 이동
		</c:if>
		
		<c:if test="${result != 1}">
			alert("글쓰기 실패!!");
			window.opener.location.reload();
			window.close();  
			// 글목록을 보여주는 페이지로 이동
		</c:if>
	</script>
</body>
</html>



