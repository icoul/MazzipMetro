<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	
	<c:if test="${result == 0}">
		alert("가게등록에 실패했습니다");
		location.href="index.eat";
	</c:if>
	
	<c:if test="${result != 0}">
		alert("가게등록에 성공했습니다");
		location.href="restAddInfo.eat?restSeq=${restSeq}";
	</c:if>
</script>
