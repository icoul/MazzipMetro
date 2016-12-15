<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 칭호 목록</title>

<script type="text/javascript">
	$(document).ready(function() {

	});
	
	function goUpdate(){
		alert("dd");
	}
	
</script>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="table-responsive col-md-3">
				<table class="table table-striped table-hover" style="width:250px; height: 350px;">
					<thead>
						<tr></tr>
						<tr>
							<th>구이름</th>
							<th>칭호명</th>
							<th>방문 수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="map" items="${userGuAliasList}" varStatus="stauts">
							<tr>
								<td>${map.guName}</td>
								<td>${map.aliasName}</td>
								<td>${map.aliasNum}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<div class="table-responsive col-md-3">
				<table class="table table-striped table-hover" style="width:250px; height: 350px;">
					<thead>
						<tr></tr>
						<tr>
							<th>동이름</th>
							<th>칭호명</th>
							<th>방문 수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="map" items="${userDongAliasList}" varStatus="stauts">
							<tr>
								<td>${map.dongName}</td>
								<td>${map.aliasName}</td>
								<td>${map.aliasNum}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		
			<div class="table-responsive col-md-3">
				<table class="table table-striped table-hover" style="width:250px; height: 350px;">
					<thead>
						<tr></tr>
						<tr>
							<th>역 이름</th>
							<th>칭호명</th>
							<th>방문 수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="map" items="${userMetroAliasList}" varStatus="stauts">
							<tr>
								<td>${map.metroName}</td>
								<td>${map.aliasName}</td>
								<td>${map.aliasNum}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<div class="table-responsive col-md-3">
				<table class="table table-striped table-hover" style="width:250px; height: 350px;">
					<thead>
						<tr></tr>
						<tr>
							<th>음식점 태그</th>
							<th>칭호명</th>
							<th>방문 수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="map" items="${userRestTagAliasList}" varStatus="stauts">
							<tr>	
								<td>${map.aliasId}</td>
								<td>${map.aliasName}</td>
								<td>${map.aliasNum}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row" >
			<div class="col-md-12">
				<button type="button" name="updateUG6" id="updateUG6" onClick="javascript:location.href='<%=request.getContextPath() %>/updateUserGrade.eat?gradeSeq=UG6'">달인 등급업</button>
				<button type="button" name="updateUG7" id="updateUG7" onClick="javascript:location.href='<%=request.getContextPath() %>/updateUserGrade.eat?gradeSeq=UG7'">신 등급업</button>
			</div>
		</div>
	</div>
</body>
</html>