<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style type="text/css">
#mhStatis {
    height: 400px; 
    min-width: 310px; 
    max-width: 800px;
    margin: 0 auto;
}
.table th,.table td {text-align:center; background:#fafafa;}
</style>
<script type="text/javascript">
<<<<<<< HEAD

var $ = jQuery.noConflict();

 $(function () {
	 Highcharts.chart('mhStatis', {
=======
var $ = jQuery.noConflict();
$(function () {	
    	    Highcharts.chart('mhStatis', {
>>>>>>> 191c5b6528c7eb8e5f221f56514ad12c199d177f
    	chart: {
            type: 'column'
        },
        title: {
            text: '컨텐츠 판매 수입'
        },
        subtitle: {
            text: 'Content sales.'
        },
        xAxis: {
            categories: [
            	'컨텐츠별',
            	 /*<c:forEach var="val" items="${list_statis}" varStatus="status">
                '${val.CONTENTNAME}'
                <c:if test="${status.count < list_statis.size()}">
                ,
                </c:if>
                </c:forEach> */
            ],
            crosshair: true
        },
        yAxis: {
            min: 0,
            labels: {
                format: '{value}원',
                style: {
                   color: Highcharts.getOptions().colors[1]
                }
             },
            title: {
                text: '단위: 원'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table style = "width : 200px;">',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.0f}원</b></td></tr>',
            footerFormat: '</table>',
            shared: true,
            useHTML: true
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [
        	<c:forEach var="val" items="${list_statis}" varStatus="status">
        	{
            name: '${val.CONTENTNAME}',
            data: [Number(${val.CONTENTPRICE})]
	        }
	        <c:if test="${status.count < list_statis.size()}">
	        ,
	        </c:if>
	        </c:forEach>
        ]
    });
}); 



</script>
<table style="width:100%;">
	<tr>
		<td style="width:30%; vertical-align:middle;">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 70px;" >컨텐츠명</th>
						<th style="width: 80px;" >판매량</th>
						<th style="width: 80px;" >판매액</th>
						
					</tr>
				</thead>
				<c:forEach var="list" items="${list_statis}" varStatus="status"> 
				<tbody>
					<tr>
						<td>${list.CONTENTNAME}</td>
						<td>${list.CONTENTSEQ}</td>
						<td><fmt:formatNumber pattern="###,###" value="${list.CONTENTPRICE}" /></td>
					</tr>
				</tbody>	
				</c:forEach>
			</table>
		</td>
		<td style="width:70%;" id="mhStatis">
		</td>
	</tr>
</table>