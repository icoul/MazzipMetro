<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style type="text/css">
	table  th {background: #FAFAFA; text-align:center;}
	table  td {text-align:center;}
	.btnClass {height:40px; background:#fff; font-size:15px; border:1px solid #000; border-radius:2px; color:#000; cursor:pointer; padding:5px;}
</style>
	
<script type="text/javascript">
jQuery.noConflict();

$(function () {	
    $('#hb_statistics_Gender').highcharts({
    	 chart: {
             plotBackgroundColor: null,
             plotBorderWidth: null,
             plotShadow: false,
             type: 'pie'
         },
         title: {
             text: '남녀 비율'
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
             name: '남녀비율',
             colorByPoint: true,
             data: [
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
 
 
$(function () {
    $('#hb_statistics_AgeLine').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: 0,
            plotShadow: false
        },
        title: {
            text: '',
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
            name: '연령대별 비율',
            innerSize: '50%',
            data: [
                
                <c:forEach var="val" items="${ageList}" varStatus="status">
         		<c:if test="${status.count < ageList.size()}">
						[
							'${val.AGELINE}',
							Number(${val.PERCENT})
							<c:if test="${status.count == ageList.size() - 1}">
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
 

 
$(function () {
    $('#hb_statistics_ReviewCount').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: '날짜별 리뷰수 통계'
        },
        xAxis: {
            categories: [
			<c:forEach var="val" items="${reviewCount}" varStatus="status">
                         '${val.REGDATE}',
            </c:forEach>
                         ]
        },
        yAxis: {
            min: 0,
            title: {
                text: '리뷰 수',
                align: ''
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: true
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },
        series: [{
        <c:forEach var="val" items="${reviewCount}" varStatus="status">
        	name: '${val.REGDATE}',
            data: [${val.CNT}],
		</c:forEach>
        }]
    });
});
 
 
 
 
 
 
$(function () {	
    $('#hb_statistics_ReviewGrade').highcharts({
    	chart: {
            type: 'bar'
        },
         title: {
             text: '리뷰평점'
         },
         xAxis: {
             categories: [
                          '리뷰평점'
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
				<c:forEach var="val" items="${reviewGrade}" varStatus="status">
					name: '리뷰평점',
					data: [${val.GRADE}]
				</c:forEach>
         }]
     });
 });

$(document).ready(function(){
	$("#table_Gender").hide();
//	$("#table_Gender").hide();
	$("#table_AgeLine").hide();
	$("#table_ReviewCount").hide();
	$("#table_ReviewGrade").hide();
//	$("#table_Gender").hide();
	
//	$("#btn_restGrade").mouseover(function(){
//		 $("#table_Gender").show();
//	});
	 
	$("#btn_Gender").mouseover(function(){
		 $("#table_Gender").show();
		 $("#table_AgeLine").hide();
		 $("#table_ReviewCount").hide();
		 $("#table_ReviewGrade").hide();
	});
	
	$("#btn_AgeLine").mouseover(function(){
		 $("#table_AgeLine").show();
		 $("#table_Gender").hide();
		 $("#table_ReviewCount").hide();
		 $("#table_ReviewGrade").hide();
	});
	
	$("#btn_ReviewCount").mouseover(function(){
		 $("#table_ReviewCount").show();
		 $("#table_Gender").hide();
		 $("#table_AgeLine").hide();
		 $("#table_ReviewGrade").hide();
	});
	
	$("#btn_ReviewGrade").mouseover(function(){
		 $("#table_ReviewGrade").show();
		 $("#table_Gender").hide();
		 $("#table_AgeLine").hide();
		 $("#table_ReviewCount").hide();
		 
	});
	
//	$("#btn_ViewsCount").mouseover(function(){
//		 $("#table_Gender").show();
//	});
});
 

</script>


<table style="width:100%; height:100px; margin-top:30px;">
	<tr>
		<td>
			<button type="button" class="btnClass" id="btn_restGrade">매장등급</button> &nbsp;
			<button type="button" class="btnClass" id="btn_Gender">남녀비율</button> &nbsp;
			<button type="button" class="btnClass" id="btn_AgeLine">성별비율</button> &nbsp;
			<button type="button" class="btnClass" id="btn_ReviewCount">날짜별리뷰수</button> &nbsp;
			<button type="button" class="btnClass" id="btn_ReviewGrade">리뷰점수에따른평점</button> &nbsp;
			<button type="button" class="btnClass" id="btn_ViewsCount">조회수</button>
		</td>
	</tr>
</table>

<%-- 성별 비율 --%>
<table style="width:100%; height:389px;" id="table_Gender">
	<tr>
		<td style="width:30%; height:100px; vertical-align:middle;" align="center">
			<table style="width:90%; margin-left: 5%" class="table" align="center">
				<thead>
					<tr align="center">
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
							<c:if test="${status.count == genderList.size()}">
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
		</td>
		<td  valign="top" style="width:70%; height:100px;  vertical-align:top;"  id="hb_statistics_Gender"></td>
	</tr>
</table>

<%-- 나이별 비율 --%>
<table style="width:100%; height:389px;" id="table_AgeLine">
	<tr>
		<td style="width:30%; height:100px; vertical-align:middle;" align="center">
			<table style="width:90%; margin-left: 5%" class="table" align="center">
				<thead>
					<tr align="center">
						<th>나이별</th>
						<th>인원수</th>
						<th>비율(%)</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty ageList}">
						<tr>
							<td colspan="3">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty ageList}">
						<c:forEach var="rcd" items="${ageList}" varStatus="status"> 
							<c:if test="${status.count < ageList.size()}">
							  <tr>
								 <td>${rcd.AGELINE} 대</td> 
								 <td>${rcd.CNT}</td>    
								 <td>${rcd.PERCENT}</td>
							  </tr>
							</c:if>
							<c:if test="${status.count == ageList.size()}">
							  <tr>
								 <td class="my_total">${rcd.AGELINE}</td> <%-- ${rcd.key명} 여기서 key명은 testdb.xml 파일에서 property="GENDER" 와 property="CNT" 와 property="PERCENT" 로 정해진 key명이다. --%>
								 <td class="my_total">${rcd.CNT}</td>
								 <td class="my_total">${rcd.PERCENT}</td>
							  </tr>
							</c:if>
						</c:forEach>
					</c:if>
				</tbody>
			</table> 
		</td>
		<td  valign="top" style="width:70%; height:100px;  vertical-align:top;"  id="hb_statistics_AgeLine"></td>
	</tr>
</table>

<%-- 리뷰수 비율 --%>
<table style="width:100%; height:389px;" id="table_ReviewCount">
	<tr>
		<td style="width:30%; height:100px; vertical-align:middle;" align="center">
			<table style="width:90%; margin-left: 5%" class="table" align="center">
				<thead>
					<tr align="center">
						<th>날짜별</th>
						<th>리뷰수</th>
						<th>비율(%)</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty reviewCount}">
						<tr>
							<td colspan="3">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty reviewCount}">
						<c:forEach var="rcd" items="${reviewCount}" varStatus="status"> 
							<c:if test="${status.count < reviewCount.size()}">
							  <tr>
								 <td>${rcd.REGDATE}</td> 
								 <td>${rcd.CNT}</td>    
								 <td>${rcd.PERCENT}</td>
							  </tr>
							</c:if>
							<c:if test="${status.count == reviewCount.size()}">
							  <tr>
								 <td class="my_total">${rcd.REGDATE}</td> <%-- ${rcd.key명} 여기서 key명은 testdb.xml 파일에서 property="GENDER" 와 property="CNT" 와 property="PERCENT" 로 정해진 key명이다. --%>
								 <td class="my_total">${rcd.CNT}</td>
								 <td class="my_total">${rcd.PERCENT}</td>
							  </tr>
							</c:if>
						</c:forEach>
					</c:if>
				</tbody>
			</table> 
		</td>
		<td  valign="top" style="width:70%; height:100px;  vertical-align:top;"  id="hb_statistics_ReviewCount"></td>
	</tr>
</table>

<%-- 리뷰평점 비율 --%>
<table style="width:100%; height:389px;" id="table_ReviewGrade">
	<tr>
		<td style="width:30%; height:100px; vertical-align:middle;" align="center">
			<table style="width:90%; margin-left: 5%" class="table" align="center">
				<thead>
					<tr align="center">
						<th>리뷰수</th>
						<th>리뷰평점</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty reviewGrade}">
						<tr>
							<td colspan="3">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty reviewGrade}">
						<c:forEach var="rcd" items="${reviewGrade}" varStatus="status"> 
							<c:if test="${status.count < reviewGrade.size()}">
							  <tr>
								 <td>${rcd.REVIEWCOUNT}</td> 
								 <td>${rcd.GRADE}</td>    
							  </tr>
							</c:if>
							<c:if test="${status.count == reviewGrade.size()}">
							  <tr>
								 <td>${rcd.REVIEWCOUNT}</td> <%-- ${rcd.key명} 여기서 key명은 testdb.xml 파일에서 property="GENDER" 와 property="CNT" 와 property="PERCENT" 로 정해진 key명이다. --%>
								 <td>${rcd.GRADE}</td>
							  </tr>
							</c:if>
						</c:forEach>
					</c:if>
				</tbody>
			</table> 
		</td>
		<td  valign="top" style="width:70%; height:100px;  vertical-align:top;"  id="hb_statistics_ReviewGrade"></td>
	</tr>
</table>	










    