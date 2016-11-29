<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="top.jsp" />
		<div id="leftCon">
			<div class="mainBann">
				<img src="<%= request.getContextPath() %>/resources/images/imgMetroMap01.jpg" border="0" width="731" />
			</div>
			<div class="promBann">
				<img src="<%= request.getContextPath() %>/resources/images/imgProBanner01.jpg" border="0" />
			</div>
			<div class="localRankCon" style="margin-top:30px;">
				<img src="<%= request.getContextPath() %>/resources/images/imgTest03.png" border="0" width="731" />
			</div>
			
			<div class="reconCon">
				<h2>지하철 추천 맛집</h2>
				<img src="<%= request.getContextPath() %>/resources/images/imgTest02.jpg" border="0" />
			</div>
		</div>
		<%-- end of leftCon --%>
		
		<div id="rightCon">
			<div class="realTimeAppra" style="margin-top:20px;">
				<img src="<%= request.getContextPath() %>/resources/images/imgTest01.png" border="0" />
			</div>
			<div>
				<img src="<%= request.getContextPath() %>/resources/images/imgTest04.jpg" border="0" width="269" />
			</div>
		</div>
		<%-- end of rightCon --%>	
	</div>
	<%-- end of content --%>
</div>
<%-- end of container --%>

<jsp:include page="footer.jsp" />
