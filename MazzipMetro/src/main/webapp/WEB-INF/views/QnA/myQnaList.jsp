<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>나의 문의내역</title>
<style type="text/css">
	.title-label{font-weight:400;font-size:24px;}
	.navbar-barnd{vertical-align : middle;line-height:45px;}
	.btn-primary.create {margin-top:10px;}
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.min.css">
  <script src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${not empty qnaSearch}">
			$("#qnaColName").val("${qnaColName}");
			$("#qnaSearch").val("${qnaSearch}");
		</c:if>		
		
		<c:if test="${not empty qnaInquiry}">
		$("#qnaInquiry").val("${qnaInquiry}");
		</c:if>
	});



	function goSearchFrm(){
		var qnaSearchFrm = document.qnaSearchFrm;
		qnaSearchFrm.submit();
	}
</script>
</head>
<body>
<div class="container">
	<div class="row">
		<h2> <span class="title-label">나의 문의내역</span>  </h2>
		<span>총 문의건 : ${totalCount}건 | 접수완료 : ${registerQnaCount}건 | 답변완료 : ${answerQnaCount}건</span>
        <nav class="navbar navbar-default query" role="query">
            <div class="container-fluid">
          	 <form name="qnaSearchFrm" style="display:inline;" action="<%=request.getContextPath()%>/myQnaList.eat" method="get">
                <table class="table table-bordered">
				      <tr>
				        <th>문의접수일</th>
				        <td colspan="3">
							<select name="qnaRegYearStart">
								<c:forEach var="year" items="${yearList}">
									<option value="${year}">${year}</option>
								</c:forEach>
							
								<%--  <c:set var="year" value="2015" />
						        <c:forEach begin="1" end="85" >
						        	 	<c:set var="year" value="${year+1}" />
						        	<option value="${year}">${year}</option>
						        </c:forEach> --%>
						    </select>
						    년
						    
						    <select name="qnaRegMonthStart">
						    	${stringMonthSelect}
						    
								<%--  <c:set var="month" value="0" />
						        <c:forEach begin="1" end="12" >
						        	 	<c:set var="month" value="${month+1}" />
									<option value="${month}">${month}</option>
						        </c:forEach> --%>
						    </select>
						    월
						    
						    <select name="qnaRegDayStart">
							
								<%--  <c:set var="day" value="0" />
						        <c:forEach begin="1" end="31" >
						        	 	<c:set var="day" value="${day+1}" />
						        	<option value="${day}">${day}</option>
						        </c:forEach> --%>
						    </select>
						    일 ~ 
						    
						    <select name="qnaRegYearEnd">
							
								<%--  <c:set var="year" value="2015" />
						        <c:forEach begin="1" end="85" >
						        	 	<c:set var="year" value="${year+1}" />
						        	<option value="${year}">${year}</option>
						        </c:forEach> --%>
						    </select>
						    년
						    
						    <select name="qnaRegMonthEnd">
							
								<%--  <c:set var="month" value="0" />
						        <c:forEach begin="1" end="12" >
						        	 	<c:set var="month" value="${month+1}" />
						        	<option value="${month}">${month}</option>
						        </c:forEach> --%>
						    </select>
						    월
						    
						    <select name="qnaRegDayEnd">
							
							<%-- 	 <c:set var="day" value="0" />
						        <c:forEach begin="1" end="31" >
						        	 	<c:set var="day" value="${day+1}" />
						        	<option value="${day}">${day}</option>
						        </c:forEach> --%>
						    </select>
						</td>
				        
				      </tr>
				 
				      <tr>
				      	 
				        <th>문의 유형</th>
				        <td>
				         <select name="qnaInquiry" id="qnaInquiry">
				         	<option value="전체">문의유형</option>
							<option value="회원">회원관련문의</option>
							<option value="사업주">사업주관련문의</option>
							<option value="음식점">음식점문의</option>
							<option value="기타">기타문의</option>
						  </select>
						</td>
				        
						<th>문의 상세검색</th>
						<td> 
						<select name="qnaColName" id="qnaColName">
							<option value="userName">이름</option>
							<option value="qnaSubject">제목</option>
						 </select> 
						  <input name="qnaSearch" id="qnaSearch" type="text"/> &nbsp; <button type="button" onClick="javascript:goSearchFrm();">조회</button>
						  </td>
						  
				      </tr>
				   
				  </table>
                </form>
            </div>
        </nav>
        
        <div class="table-responsive col-md-12">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>NO</th>
                        <th>글쓴이</th>
                        <th>문의종류</th>
                        <th>문의제목</th>
                        <th>문의일</th>
                        <th>답변일</th>
                        <th>처리상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty myQnaList }">
                    	<c:forEach var="map" items="${myQnaList}" varStatus="status">
	                    	<tr>
		                        <td>${map.rno }</td>
		                        <td>${map.userName }</td>
		                        <td>${map.qnaInquiry } 문의</td>
		                        <td>${map.qnaSubject }</td>
		                        <td>${map.qnaRegDate }</td>
		                        <td>${map.qnaAnswerDate }</td>
		   						<td><a class="btn btn-link" href="#">${map.qnaProgress }</a></td>
		                    </tr>
                    	</c:forEach>
                    </c:if>
                    
                </tbody>
            </table>
        </div>
        
        <div >
            ${pageBar}
        </div>
	</div>
</div>
</body>
</html>