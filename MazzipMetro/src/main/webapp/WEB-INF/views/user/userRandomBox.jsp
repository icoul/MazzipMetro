<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 랜덤박스</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<ul>
				   <li><img src="<%=request.getContextPath() %>/resources/images/box2.png" width="150px;" height="150px;" /></li>
				   <li><br>보유갯수 : ${randomBoxCount}</li>
				   <li><br><button class="button" type="button" onClick="javascript:location.href='<%=request.getContextPath() %>/userCoupon.eat?boxType=random'">개봉하기</button></li>
				</ul>
			</div>
			
			<div class="col-md-6">
				<ul>
				   <li><img src="<%=request.getContextPath() %>/resources/images/box1.png" width="150px;" height="150px;" /></li>
				   <li><br>보유갯수 :${premiumRandomBoxCount}</li>
				   <li><br><button class="button" type="button" onClick="javascript:location.href='<%=request.getContextPath() %>/userCoupon.eat?boxType=premium'">개봉하기</button></li>
				</ul>
			</div>
			
		</div>
	</div>
</body>
</html>