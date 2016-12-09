<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<jsp:include page="../top.jsp" />
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function openWin(src){
		window.open(src,"팝업창이름(의미없음)", "width=" + 680 + ", height=" + 440 + ", left=100px, top=100px, menubar=no, status=no, scrollbars=no");
	}
	
</script>
</head>
<body>

<div class="container"  style="margin-top:20px;">
	<div class="row">
		<div class="col-sm-3" >
	          <div ><a href="<%=request.getContextPath() %>/faq.eat"><img src="<%=request.getContextPath() %>/resources/images/menu_title.gif" alt="고객센터" border="0" /></a></div>
	          <ul class="list-group" style="width: 170px; height=70px;">
	            <li class="list-group-item"><a href="" onClick="javascript:openWin('<%=request.getContextPath() %>/faqListByType.eat?faqType=회원');">회원 관련문의</a></li><!-- 선택된 페이지 -->
				<li class="list-group-item"><a href="" onClick="javascript:openWin('<%=request.getContextPath() %>/faqListByType.eat?faqType=사업주');">사업주 관련문의</a></li>
				<li class="list-group-item"><a href="" onClick="javascript:openWin('<%=request.getContextPath() %>/faqListByType.eat?faqType=음식점');">음식점 관련문의</a></li>
				<li class="list-group-item"><a href="" onClick="javascript:openWin('<%=request.getContextPath() %>/faqListByType.eat?faqType=기타');">기타 관련문의</a></li>
	          </ul>
	    </div>
	
		<div class="col-sm-4" >
			<table class="table table-striped" style="width:800px; height:500px; ">
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
		
	</div>
</div>
</body>
</html>
<jsp:include page="../footer.jsp" />
