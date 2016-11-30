<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<title>ㅋㅋㅋ멀티 파일올리기 및 썸네일 파일 생성하기</title>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

  <style>
  .carousel-inner > .item > img,
  .carousel-inner > .item > a > img {
      width: 70%;
      margin: auto;
  }
  
  .myborder {
	border: navy solid 1px;
  }
  

  </style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$(".my_thumbnail").hover(
				function(){
					$(this).addClass("myborder");
				},
				function(){
					$(this).removeClass("myborder");
				}
		);
				
	});		
	
</script>

</head>
<body>


  
  
  <div class="container" align="left">
  <br>
  <div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 75%;">
    <!-- Indicators -->
    <ol class="carousel-indicators">
      <c:forEach var="avo" items="${reviewImageList}" varStatus="status">
      	<c:if test="${status.index == 0}">
      		<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
      	</c:if>
      	<c:if test="${status.index > 0}">
      		<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
      	</c:if>
      </c:forEach>
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner" role="listbox">
	  <c:forEach var="image" items="${reviewImageList}" varStatus="status">
	  	  <c:if test="${status.index == 0}">
	  	  	<div class="item active">
	  	  </c:if>
	  	  <c:if test="${status.index > 0}">
	  	  	<div class="item">
	  	  </c:if>
	  	  
	  	  
	  	  	<div id="largeImg" align="center" style="border: green solid 0px; width: 45%; padding: 2%; margin: 2% auto;">
				<img src="<%= request.getContextPath() %>/resources/images/${image.reviewimg}" width="200px" height="200px">
	      	</div>
	      	</div>
	  </c:forEach>
    </div>  <%-- end of <div class="carousel-inner" role="listbox"> --%>

    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
  </div> <%-- end of <div id="myCarousel" class="carousel slide" data-ride="carousel"> --%>
  
  <div align="center" style="border: red solid 0px; width: 80%; margin: auto; padding: 20px;">
		<c:forEach var="image" items="${reviewImageList}" varStatus="status">
			<img src="<%= request.getContextPath() %>/resources/images/${image.reviewthumbimg}" class="my_thumbnail" style="margin-right: 10px;" data-target="#myCarousel" data-slide-to="${status.index}" />
		</c:forEach>
	</div>
</div>
	

<div class="container" align="right">
	<table class="table">
		<tr>
			<th>${restname}</th>
		</tr>
		
		<tr>
			<td>
				<p> <img  class="img-circle" src="<%= request.getContextPath() %>/resources/images/${reviewprofile }" width="50px" height="50px"/>${username}</p>
				<p>${reviewcontent }</p>
				<p>${reviewregdate }</p>
			</td>
		</tr>
	</table>
</div>


</body>
</html>