<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>고객 문의 내역</title>
<style type="text/css">
	.title-label{font-weight:400;font-size:24px;}
	.navbar-barnd{vertical-align : middle;line-height:45px;}
	.btn-primary.create {margin-top:10px;}
</style>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>  
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.min.css">
  <script src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<div class="container">
	<div class="row">
		<h2> <span class="title-label">고객 문의내역</span>  </h2>
		<span>총 문의건 : 0건 | 접수완료 : 0건 | 답변완료 : 0건</span>
        <nav class="navbar navbar-default query" role="query">
            <div class="container-fluid">
                <table class="table table-bordered">
				      <tr>
				        <th>문의접수일</th>
				        <td colspan="3">
							<select id="qnaRegYearStart">
							
								 <c:set var="year" value="2015" />
						        <c:forEach begin="1" end="85" >
						        	 	<c:set var="year" value="${year+1}" />
						        	<option value="${year}">${year}</option>
						        </c:forEach>
						    </select>
						    년
						    
						    <select id="qnaRegMonthStart">
							
								 <c:set var="month" value="0" />
						        <c:forEach begin="1" end="12" >
						        	 	<c:set var="month" value="${month+1}" />
						        	<option value="${month}">${month}</option>
						        </c:forEach>
						    </select>
						    월
						    
						    <select id="qnaRegDayStart">
							
								 <c:set var="day" value="0" />
						        <c:forEach begin="1" end="31" >
						        	 	<c:set var="day" value="${day+1}" />
						        	<option value="${day}">${day}</option>
						        </c:forEach>
						    </select>
						    일 ~ 
						    
						    <select id="qnaRegYearEnd">
							
								 <c:set var="year" value="2015" />
						        <c:forEach begin="1" end="85" >
						        	 	<c:set var="year" value="${year+1}" />
						        	<option value="${year}">${year}</option>
						        </c:forEach>
						    </select>
						    년
						    
						    <select id="qnaRegMonthEnd">
							
								 <c:set var="month" value="0" />
						        <c:forEach begin="1" end="12" >
						        	 	<c:set var="month" value="${month+1}" />
						        	<option value="${month}">${month}</option>
						        </c:forEach>
						    </select>
						    월
						    
						    <select id="qnaRegDayEnd">
							
								 <c:set var="day" value="0" />
						        <c:forEach begin="1" end="31" >
						        	 	<c:set var="day" value="${day+1}" />
						        	<option value="${day}">${day}</option>
						        </c:forEach>
						    </select>
						</td>
				        
				      </tr>
				 
				      <tr>
				        <th>문의 유형</th>
				        <td>
				         <select id="qnaQuiry">
							<option value="0">문의종류</option>
							<option value="회원">회원관련문의</option>
							<option value="사업주">사업주관련문의</option>
							<option value="음식점">음식점문의</option>
							<option value="기타">기타문의</option>
						  </select>
						</td>
				        
						<th>문의 상세검색</th>
						<td><input type="text"/> &nbsp; <button type="button">조회</button></td>
				      </tr>
				  </table>
                
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
                    <tr>
                        <td>ㄷ</td>
                        <td>ㄷ</td>
                        <td>ㄷ</td>
                        <td>ㄷ</td>
                        <td>ㄷ</td>
                        <td>ㄷ</td>
   						<td> <a class="btn btn-link" href="#">답변완료</a></td>
                    </tr>
                    
                </tbody>
            </table>
        </div>
        <div >
            <ul class="pagination">
                <li><a href="#">«</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">»</a></li>
            </ul>
        </div>
	</div>
</div>
</body>
</html>