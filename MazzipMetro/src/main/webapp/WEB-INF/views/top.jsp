<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/4.3.0/zxcvbn.js"></script>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/segmented-controls.css">
    <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
 <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</head>
<body>
	<a data-toggle="modal" data-target="#userIdfind" class="btn btn-primary" data-dismiss="modal">아이디찾기</a>
<%-- ****** 아이디 찾기 Modal ******* --%> 
	<div class="modal fade" id="userIdfind" role="dialog"> <!-- data-target="#userIdfind" == id(userIdfind)값은 mapping 시켜줘야함 -->
	    <div class="modal-dialog">
	    
	      <!-- Modal content-->
	      <div class="modal-content" align="center">
	        <div class="modal-header">
	          <button type="button" class="close myclose" data-dismiss="modal">&times;</button>
	          <h4 class="modal-title">아이디 찾기</h4>
	        </div>
	        <div class="modal-body" style="height: 300px; width: 100%;">
	          <div id="idFind">
	          	<iframe style="border: none; width: 100%; height: 280px;" src="<%= request.getContextPath()%>/userSelect.eat">
	          	
	          	</iframe>
	          </div>
	        </div>
	        <div class="modal-footer">
	          <button type="button" class="btn btn-default myclose" data-dismiss="modal">Close</button>
	        </div>
	      </div>
	      
	    </div>
	  </div>
	
</body>
</html>