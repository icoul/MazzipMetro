<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
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
			<p>${vo.faqType } 관련 문의</p>
			
			<table class="table">
			    <tr class="info">
			        <th><span style="color:red; ">Q.</span>${vo.faqQuestion }</th>
			    </tr>
			    
			    <tr>
			        <td>&nbsp;&nbsp;<span style="color:red; ">A.</span>${vo.faqAnswer }</td>
			    </tr>
			</table>
			<hr>
		</div>
		
		<div class="row" align="center">
			<button class="btn btn-danger" type="button" onclick="javascript:self.close();">닫기</button>
		</div>
	</div>
</body>
</html>