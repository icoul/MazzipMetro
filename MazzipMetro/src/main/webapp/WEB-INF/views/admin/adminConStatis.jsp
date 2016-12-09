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
            type: 'column',
            options3d: {
                enabled: true,
                alpha: 10,
                beta: 25,
                depth: 70
            }
        },
        title: {
            text: '컨텐츠 판매량'
        },
        subtitle: {
            text: ''
        },
        plotOptions: {
            column: {
                depth: 25
            }
        },
        xAxis: {
            categories: 
            	<c:forEach var="val" items="${list_statis}" varStatus="status">
				        '${val.CONTENTNAME}'
					<c:if test="${status.count < list_statis.size() - 1}">
 								,
				    </c:if>
				</c:forEach>
        },
        yAxis: {
            title: {
                text: '판매량'
            }
        },
        series:   [{
            name: '컨텐츠별',
            data: [
	            	<c:forEach var="val" items="${list_statis}" varStatus="status">
	            	//name: '${val.CONTENTNAME}',
            	 <c:if test="${status.count==list_statis.size()}">
					{
						name: '${val.CONTENTNAME}',
						y: Number(${val.CONTENTPRICE})
						
       					}
						
	 			</c:if> 
	     </c:forEach>]
        }]
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
		<td style="width:70px;" id="mhStatis">
		</td>
	</tr>
</table>



