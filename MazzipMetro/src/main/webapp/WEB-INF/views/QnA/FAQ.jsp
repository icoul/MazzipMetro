<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../library.jsp" />	
<jsp:include page="../top.jsp" />
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">

	
</script>
</head>
<body>

<div class="subleftCon" style="font-size:25px; height: 1100px;">
	<h2>고객센터</h2>
</div>

<div align="center" class="subrightCon"  style="height:1100px;">
		<ul class="nav navbar-nav">
			<li class="dropdown"><a  class="dropdown-toggle" href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=회원', '680', '630');">회원 관련문의</a> </li>
			<li class="dropdown"><a  class="dropdown-toggle" href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=사업주', '680', '580');">사업주 관련문의</a></li>
			<li class="dropdown"><a class="dropdown-toggle"  href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=음식점', '680', '310');">음식점 관련문의</a></li>
			<li class="dropdown"><a class="dropdown-toggle"  href="" onClick="javascript:openWinFaq('<%=request.getContextPath() %>/faqListByType.eat?faqType=기타', '680', '350');">기타 관련문의</a></li>
		</ul>
	<table class="table table-striped" style="width:1150px; height:500px; margin-left: 25px;">
		<thead>
			<tr><th>자주하는 질문</th></tr>
		</thead>
		<tbody>
			<c:forEach var="vo" items="${faqList }" varStatus="status">
				<tr>
					<td height="26"><font color="#CC0000">${vo.faqType } 관련</font> &nbsp;
					<img src="<%=request.getContextPath() %>/resources/images/list_line.gif" width="1" height="8">&nbsp;
						<a onClick="javascript:openWin('<%=request.getContextPath() %>/faqDetail.eat?faqSeq=${vo.faqSeq}');">${vo.faqQuestion}</a>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

</body>
</html>
<jsp:include page="../footer.jsp" />
