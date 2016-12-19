<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
jQuery.noConflict();

jQuery.noConflict();

jQuery(document).ready(function($) {
	    $('#hb_tagStatistics').highcharts({
        chart: {
            type: 'funnel',
            marginRight: 100
        },
        title: {
            text: '연령대 비율',
            x: -50
        },
        plotOptions: {
            series: {
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b> ({point.y:,.0f})',
                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black',
                    softConnector: true
                },
                neckWidth: '30%',
                neckHeight: '25%'

            }
        },
        legend: {
            enabled: false
        },
        series: [{
            name: '연령대',
            data: [
               <c:forEach var="val" items="${tagList}" varStatus="status">
               <c:if test="${status.count < tagList.size()}">
               			['${val.ALIASID}', Number(${val.ALIASNUM})]
               		<c:if test="${status.count < tagList.size() - 1}">
               		,
               		</c:if>
               </c:if>
               </c:forEach>
            ]
        }]
    });
});

</script>
<<<<<<< HEAD
<div style="width:70%; height:400px;  vertical-align:top;"  id="hb_tagStatistics"> lll시험용시험용</div>
=======


	
<div style="width:70%; height:400px;  vertical-align:top;"  id="hb_tagStatistics"></div>

>>>>>>> 30d8baae44b2037cd3023ddf8fa8631eb59dbac9
