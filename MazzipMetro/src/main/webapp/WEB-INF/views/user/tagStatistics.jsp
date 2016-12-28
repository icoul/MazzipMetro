<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
jQuery.noConflict();

$(function () {	
    $('#hb_tagStatistics_Bg').highcharts({
    	 chart: {
             plotBackgroundColor: null,
             plotBorderWidth: null,
             plotShadow: false,
             type: 'pie'
         },
         title: {
             text: '대분류별'
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
             name: '대분류',
             colorByPoint: true,
             data: [
             	<c:forEach var="val" items="${tagList_Bg}" varStatus="status">
             		<c:if test="${status.count < tagList_Bg.size()}">
 						{
 							name: '${val.ALIASID}',
 							y: Number(${val.ALIASNUM})
 							<c:if test="${status.count == tagList_Bg.size()}">
 								,
 								sliced: true,
 				                selected: true
 							</c:if>
 						} 
 							<c:if test="${status.count < tagList_Bg.size()}">
 								,
 							</c:if>
             		</c:if>
                 </c:forEach>
             ]
         }]
     });
 });

$(function () {
    $('#hb_tagStatistics_Md').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: '중분류별',
            align: 'center',
            verticalAlign: 'middle',
            y: 40
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                dataLabels: {
                    enabled: true,
                    distance: -50,
                    style: {
                        fontWeight: 'bold',
                        color: 'white',
                        textShadow: '0px 1px 2px black'
                    }
                },
                startAngle: -90,
                endAngle: 90,
                center: ['50%', '75%']
            }
        },
        series: [{
            type: 'pie',
            name: '중분류',
            innerSize: '50%',
            data: [
                
                <c:forEach var="val" items="${tagList_Md}" varStatus="status">
         		<c:if test="${status.count < tagList_Md.size()}">
						[
							'${val.ALIASID}',
							Number(${val.ALIASNUM})
							<c:if test="${status.count == tagList_Md.size() - 1}">
								,
							</c:if>
						],
         		</c:if>
             </c:forEach>
                
                
                {
                    name: 'Proprietary or Undetectable',
                    y: 0.2,
                    dataLabels: {
                        enabled: false
                    }
                }
            ]
        }]
    });
});


</script>


<div width="100%">-
<div style="float:left; width:50%; height:400px;  vertical-align:top;"  id="hb_tagStatistics_Bg"></div>
<div style="float:left; width:50%; height:400px;  vertical-align:top;"  id="hb_tagStatistics_Md"></div>
</div>