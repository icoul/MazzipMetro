<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />

<script type = "text/javascript">
	$(document).ready(function(){
		restRanking();
	});
	
	function restRanking(){
		
		$.ajax({
     		url:"<%=request.getContextPath()%>/restRanking.eat",
     		type :"GET",
     		dataType:"html",
     		success: function(data){
				$("#rankingView").html(data);
     		} //end of success: function(data)
     		
     	}); //end of $.ajax()
	}
	
</script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
	<nav style="padding-left:30px;" class="navbar navbar-default">
	  <div class="container-fluid">
	    <ul align="center" class="nav navbar-nav">
	      <li class="dropdown">
	        <a href="#" onClick = "restRanking();">음식점 랭킹</a>
	      </li>
	      <li class="dropdown">
	        <a href="#">리뷰 작성 랭킹</a>
	      </li>
	      <li class="dropdown">
	        <a href="#">사용자 랭킹</a>
	      </li>
	    </ul>
	  </div>
	</nav>
</div>

<div id = "rankingView">

</div>

</body>
</html>

<jsp:include page="../footer.jsp" />