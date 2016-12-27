<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty commentCommentListJSON }">
	${commentCommentListJSON}
</c:if>

<c:if test="${empty commentCommentListJSON }">
<%
  String groupNo = (String)request.getAttribute("groupNo"); 
%> 
 [{"agoHour":"","agoDay":"","agoMinute":"","commentSeq":"","fk_seq":"","userName":"","groupNo":"<%= groupNo%>","depthNo":"","userProfile":"","content":"","commentCount":""}] 
	
</c:if>
