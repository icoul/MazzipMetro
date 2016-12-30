<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
		<c:if test="${del == 1}">
			alert("리뷰가 삭제 되었습니다.");
			location.href="adminReviewList.eat?pageNo=${pageNo}";
		</c:if>
		
		<c:if test="${del != 1}">
			alert("리뷰가 삭제 되지 않았습니다.");
			history.go(-1);
		</c:if>
	</script>
</body>
</html>