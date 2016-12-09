<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script> 

<title>사업자의 통계페이지</title>
 <script type="text/javascript">
	$(document).ready(function(){
		
		$.getJSON("jsonChap7RankShow.do", function(data){
					 // data => ajax 요청에 의해 서버로 부터 리턴받은 데이터.
			$("#displayRank").empty();   // <div id="displayRank"> 엘리먼트를 모두 비워서 새 데이터를 채울 준비를 한다.
			
			// $.each() 함수는 $(selector).each()와는 다르다.
			// $.each(순회해야할 collection 또는 배열, callback(indexInArray, valueOfElement) );
			// 배열을 다루는 경우에는, 콜백 함수는 인덱스와 값을 인자로 갖는다.
			// 만약 map 형태의 집합을 다루게 되면 key와 value의 쌍으로 동작한다.
			
			var html = "<table class='table table-hover' align='center' width='250px' height='180px'>";
			html += "<tr>";
			html += "<th>등수</th>";
			html += "<th>제품명</th>";
			html += "<th>주문량합계</th>";
			html += "</tr>";
			
			$.each(data, function(entryIndex, entry){  
			html += "<tr>";
			html += "<td class='mynumber'>";
			html += "<span class='myrank'>" + entry.rank + "</span>";
			html += "</td>";
			html += "<td>";
			html += ""+ entry.jepumname;
			html += "</td>";
			html += "<td class='mynumber'>";
			html += ""+ entry.totalqty;
			html += "</td>";
			html += "</tr>";
			});
			
			html += "</table>";
			
			$("#displayRank").html(html);
			
			});
							
				});
 
 </script>
</head>
<body>
	<table style="border:solid 1px red;">
			<tr>
				<th>가게명</th>
				<th>전화번호</th>
				<th>가게이미지</th>
				<th>가게주소</th>
				<th>가게 등록일</th>
			</tr>
		<c:forEach var="vo" items="${restaurantList}">
			<tr>
				<td>${vo.restName}</td>
				<td>${vo.restPhone}</td>
				<td><img src="<%= request.getContextPath()%>/resources/images/${vo.restImg}"/></td>
				<td>${vo.restAddr }</td>
				<td>${vo.restRegDate }</td>
				<td><a href="">리뷰통계보기</a></td>
			</tr>
		</c:forEach>
		
		
	</table>
	
	<br/><br/>
	
	<div id="reviewStats">
		<table style="border:solid 1px red;">
			<tr>
				<th>작성된 리뷰수</th>
				<th>삭제된 리뷰수</th>
			</tr>
			<tr>
				<td></td>
				<td></td>
			</tr>
		</table>
	</div>
</body>
</html>