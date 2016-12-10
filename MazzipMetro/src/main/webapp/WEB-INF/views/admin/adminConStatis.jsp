<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 


<style type="text/css">
#mhStatis {
    height: 400px; 
    min-width: 310px; 
    max-width: 800px;
    margin: 0 auto;
}
</style>
<script type="text/javascript">
$(function () {
    $('#mhStatis').highcharts({
    	chart: {
            type: 'column'
        },
        title: {
            text: 'Monthly Average Rainfall'
        },
        subtitle: {
            text: 'Source: WorldClimate.com'
        },
        xAxis: {
            categories: [
            	<c:forEach var="val" items="${list_statis}" varStatus="status">
                '${val.CONTENTNAME}'
                <c:if test="${status.count < list_statis.size()}">
                ,
                </c:if>
                </c:forEach>
            ],
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Rainfall (mm)'
            }
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
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
		<td style="width:30%; vertical-align:top;">
			<table class="table">
				<tr>
					<th style="width: 70px;" >컨텐츠명</th>
					<th style="width: 80px;" >판매량</th>
					
				</tr>
			<c:forEach var="list" items="${list_statis}" varStatus="status"> 
				<tr>
					<td>${list.CONTENTNAME}</td>
					<td>${list.CONTENTPRICE}</td>
				</tr>
			</c:forEach>
			</table>
		</td>
		<td style="width:70%;" id="mhStatis">
		</td>
	</tr>
</table>



