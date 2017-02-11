<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script type="text/javascript">
	alert("${msg}");
	location.href="${loc}";
	//자바스크립트에서 페이지의 이동은 location.href="이동해야할 페이지명"
	self.close(); //팝업창 닫기
	opener.location.reload(true);//부모창 새로고침
</script>