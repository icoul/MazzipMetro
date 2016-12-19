<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
jQuery.noConflict();

$(function () {	
    $('#hb_tagStatistics').highcharts({
    	chart: {
            type: 'bar'
        },
         title: {
             text: '태그별'
         },
         xAxis: {
             categories: [
				<c:forEach var="val" items="${tagList}" varStatus="status">
				'${val.ALIASID}',
				</c:forEach>
                          ]
         },
         yAxis: {
             min: 0,
             title: {
                 text: '리뷰 평점',
                 align: ''
             },
             labels: {
                 overflow: 'justify'
             }
         },
         tooltip: {
             pointFormat: ''
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
				<c:forEach var="val" items="${tagList}" varStatus="status">
					name: '${val.ALIASID}',
					data: [${val.ALIASNUM}],
				</c:forEach>
         }]
     });
 });


</script>


	
<div style="width:70%; height:400px;  vertical-align:top;"  id="hb_tagStatistics"></div>

