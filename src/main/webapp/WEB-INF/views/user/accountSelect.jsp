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
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/hb_register.css">
    
    <jsp:include page="../top.jsp"></jsp:include>
    
    
    <link href="<%= request.getContextPath() %>/resources/css/hb_register_.css" rel="stylesheet">
    <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<style>
.subleftCon {float:left; width:200px; height:500px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;}
.subleftCon h2 {width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right;}
.subrightCon {float:left; width:1200px; border-right:1px solid #dbdbdb; height:500px;}

</style>

</head>


<script type="text/javascript">
	function goUserRegister() {
		opener.document.location.href="<%= request.getContextPath()%>/userRegister.eat";
		self.close();
	}
	
</script>
<body>
<!-- <a href="#" onClick="goUserRegister();">  -->
<%-- <a href="<%= request.getContextPath()%>/userRegister.eat">
	<div align="center" style="background-color: red; width:30%; margin-left:10%; height:50%; float:left; margin-top:10%;" >
	<i align="center" style="font-size: 10em; color:blue;" class="glyphicon glyphicon glyphicon-user"></i> <br>
	<span style="font-size: 5em; color:blue;">개인</span>
	</div>
</a> --%>

<div class="subleftCon">
<h2>회원유형선택</h2>
</div>
<div class="subrightCon" style="padding:7%">
<a href="<%= request.getContextPath()%>/userRegister1.eat?type=0" class="btn btn-sq-lg btn-info">
              <i style="font-size: 10em;" class="fa fa-user"></i><br><br>
              	<span style="font-size:2em;">개인</span>
</a>
<a href="<%= request.getContextPath()%>/userRegister1.eat?type=1" style="margin-left: 3%" class="btn btn-sq-lg btn-success">
              <i style="font-size: 10em;" class="fa fa-user"></i><br><br>
              	<span style="font-size:2em;">사업자</span>
            </a>
</div>
<%-- <a href="<%= request.getContextPath()%>/userRegister.eat">
	<div align="center" style="background-color: blue; width:30%; margin-left:20%; height:50%; margin-right:10%; float:left; margin-top:10%;" >
	<i align="center" style="font-size: 10em; color:red;" class="fa fa-female"></i><span class=""></span><i class="icon-large icon-search"></i>
	<span style="font-size: 5em; color:red;">사업자</span>
	</div>
</a> --%>
<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>