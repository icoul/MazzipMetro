<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<style type="text/css">
	${demo.css}
	
	table {border: solid gray 1px; border-collapse: collapse;}
	th {background-color: #d0d0d0; font-weight: bold;}
	th,td {border: solid gray 1px; padding: 5px; text-align: center;}
	td.my_total {background-color: #ffff99; font-weight: bold;}
</style>

<script type="text/javascript">

	
	/* 
	var dataArr = new Array(); // 자바스크립트에서 배열을 선언하는 것 
	
	<c:forEach var="rcd" items="${list}">
		dataArr.push("${rcd.PERCENT}"); // 배열속에 값을 넣어주는 것
	</c:forEach> 
	*/
	
$(function () {	
    $('#hb_statistics').highcharts({
    	 chart: {
             plotBackgroundColor: null,
             plotBorderWidth: null,
             plotShadow: false,
             type: 'pie'
         },
         title: {
             text: '우리회사 직원 남녀별 구성 비율'
         },
         tooltip: {
             pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
         },
         plotOptions: {
             pie: {
                 allowPointSelect: true,
                 cursor: 'pointer',
                 dataLabels: {
                     enabled: true,
                     format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                     style: {
                         color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                     }
                 }
             }
         },
         series: [{
             name: '성별 구성비율',
             colorByPoint: true,
             data: [/* {
                 name: '남자',
                 y: Number(dataArr[0])   // Number() 함수를 써야함을 꼭 기억하자!!
             }, {
                 name: '여자',
                 y: Number(dataArr[1]),  // Number() 함수를 써야함을 꼭 기억하자!!
                 sliced: true,
                 selected: true
             } */
             	<c:forEach var="val" items="${genderList}" varStatus="status">
             		<c:if test="${status.count < genderList.size()}">
 						{
 							name: '${val.GENDER}',
 							y: Number(${val.PERCENT})
 							<c:if test="${status.count == genderList.size() - 1}">
 								,
 								sliced: true,
 				                selected: true
 							</c:if>
 						} 
 							<c:if test="${status.count < genderList.size() - 1}">
 								,
 							</c:if>
             		</c:if>
                 </c:forEach>
             
             
             ]
         }]
     });
 });
</script>

<div align="center" style="margin-top: 30px; margin-bottom:30px;">
	<table style="width: 300px;">
		<thead>
			<tr>
				<th>성별</th>
				<th>인원수</th>
				<th>비율(%)</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty genderList}">
				<tr>
					<td colspan="3">데이터가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty genderList}">
				<c:forEach var="rcd" items="${genderList}" varStatus="status"> 
					<c:if test="${status.count < genderList.size()}">
					  <tr>
						 <td>${rcd.GENDER}</td> 
						 <td>${rcd.CNT}</td>    
						 <td>${rcd.PERCENT}</td>
					  </tr>
					</c:if>
					<c:if test="${status.count == list.size()}">
					  <tr>
						 <td class="my_total">${rcd.GENDER}</td> <%-- ${rcd.key명} 여기서 key명은 testdb.xml 파일에서 property="GENDER" 와 property="CNT" 와 property="PERCENT" 로 정해진 key명이다. --%>
						 <td class="my_total">${rcd.CNT}</td>
						 <td class="my_total">${rcd.PERCENT}</td>
					  </tr>
					</c:if>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div id="hb_statistics"></div>	
	










    