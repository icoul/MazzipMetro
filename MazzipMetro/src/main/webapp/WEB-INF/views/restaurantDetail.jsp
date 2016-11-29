<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식점 상세 페이지</title>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.min.css">
  <script src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts.js"></script>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/modules/exporting.js"></script>
 	
 
 <script type="text/javascript">
 $(document).ready(function(){
		
		
				
	});
 
 $(function () {
		
	    $('#container').highcharts({
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
	            name: 'Browser share',
	            innerSize: '50%',
	            data: [
	                
	                <c:forEach var="map" items="${agelineChartList}" varStatus="status">
	                		['${map.ageline}대',parseInt(${map.percent})],
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
		
		/* var dataArr = new Array(); //자바스크립트에서 배열을 선언하는 것
		<c:forEach var="rcd" items="${list}">
			dataArr.push("${rcd.PERCENT}"); //배열속에 값을 넣어주는 것.
		</c:forEach> */
		
	    $('#container2').highcharts({
	        chart: {
	            plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false,
	            type: 'pie'
	        },
	        title: {
	            text: ''
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
	                y: Number(dataArr[0]) //Number() 함수를 꼭 써야한다.
	            }, {
	                name: '여자',
	                y: Number(dataArr[1]),
	                sliced: true,
	                selected: true
	            } */
	            
	            <c:forEach var="map" items="${genderChartList}" varStatus="status" >
	            	<c:if test="${status.count < genderChartList.size()}">
	            	{
	                    name: '${map.gender}',
	                    y: Number(${map.percent})
	                    <c:if test="${status.count == genderChartList.size() - 1}">
	                    ,
	                    sliced: true,
	                    selected: true
	                    </c:if>
	                }
	            	<c:if test="${status.count < genderChartList.size()-1}">
	            		,
	            	</c:if>            	
	            	</c:if>
	            </c:forEach>
	            
	            ]
	        }]
	    });
	});
 </script>
</head>
<body>
	
	
<div class="container">
 <div>
 	 <span style="font-weight:bold; font-size:20px; ">${restvo.restname }</span>
 </div>
 
  <table class="table table-condensed">
      <tr>
        <th>주소</th>
        <th>${restvo.restaddr}</th>
      </tr>
      <tr>
        <th>전화번호</th>
        <td>${restvo.restphone}</td>
      </tr>
      <tr></tr>
  </table>

<div id="container" style="width: 210px; height: 300px;  "></div>
<div id="container2" style="width: 210px; height: 300px;  "></div>

	<h2>${restvo.restname}의 리뷰(${reviewList.size() })</h2>
	
	<table  class="table table-bordered">
		
		<c:forEach var="review" items="${reviewList}" varStatus="status">
			<tr>
				<td>${review.username }  <img src="<%= request.getContextPath() %>/resources/images/${review.userprofile}" width="100px" height="100px"/></td>
				<td>
					<section>${review.reviewcontent}</section>
					<section>
						<c:forEach var="reviewImage" items="${reviewImageList}">
							<c:if test="${review.reviewseq == reviewImage.reviewseq}"> 
								<a data-toggle="modal" data-target="#reviewImageDiv${status.index}"  data-dismiss="modal"><img src="<%= request.getContextPath() %>/resources/images/${reviewImage.reviewimg}" width="100px" height="100px"/></a> &nbsp;&nbsp;
							</c:if>
						</c:forEach>
					</section>
				</td>
			</tr>
			
			<%-- <div class="modal fade" id="reviewImageDiv${status.index}" role="dialog" >
			 <div class="modal-dialog modal-lg">
			    <!-- Modal content-->
			    <div class="modal-content" align="center" >
			      <div class="modal-header">
			        <button type="button" class="close myclose" data-dismiss="modal">&times;</button> X버튼
			       		<h4 class="modal-title"></h4>
			      </div>
			      <div class="modal-body" style="height: 600px; width: 100%;">
			        <div id="reviewImage">
			       <iframe scrolling="no" style=" border: none; width: 100%; height: 600px; " src="<%= request.getContextPath() %>/reviewModal.eat?reviewseq=${review.reviewseq}">
				          </iframe> 
				          </div>
				   </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default myclose" data-dismiss="modal">닫기</button>
				        </div>
				      </div>
				 </div>
			</div> --%>
			
			<div class="modal  fade" id="reviewImageDiv${status.index}" role="dialog" >
			  <iframe scrolling="no" style=" border: none; width: 100%; height: 600px; " src="<%= request.getContextPath() %>/reviewModal.eat?reviewseq=${review.reviewseq}&restname=${restvo.restname}&username=${review.username }&reviewprofile=${review.userprofile}&reviewcontent=${review.reviewcontent}&reviewregdate=${review.reviewregdate}">
			  </iframe>
			  <div >
			   <button type="button" class="btn btn-default myclose" data-dismiss="modal">닫기</button>
			  </div> 
			  
			</div>
		</c:forEach>
		
	</table>

</div>



</body>
</html>



<%--werwerwierjweirjwirj --%>