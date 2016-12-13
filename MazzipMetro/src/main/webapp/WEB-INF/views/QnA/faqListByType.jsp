<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function(){	
	});
	
	
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container" style="margin:15px;">
		<div class="row">
			<img src="<%=request.getContextPath() %>/resources/images/FAQ_titleIMG.gif" />
			<hr>
		</div>
		
		<div class="row">
			<p>${faqType } 관련 문의</p>
			
			<table class="table" >
				<c:forEach var="vo" items="${faqList}" varStatus="status">
				    <tr class="info" id="faqQuestion${status.count }">
				        <th ><span style="color:red; ">Q.</span><a href="<%=request.getContextPath()%>/faqListByType.eat?faqType=${faqType}&count=${status.count}" >${vo.faqQuestion }</a></th>

				    </tr>
				    
				 <c:if test="${status.count eq count }">
                    <tr>
                        <th>&nbsp;&nbsp;<span style='color:red; '>A.</span>${vo.faqAnswer } </th>
                    </tr>
                 </c:if>

				 </c:forEach>
			</table>
			<hr>
		</div>
		
		<div class="row" align="center">
			<button class="btn btn-danger" type="button" onclick="javascript:self.close();">닫기</button>
		</div>
	</div>
	
	
</body>
</html>