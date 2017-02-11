<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<h4>"<span style="color: gray">${keyword}</span>" 에 대한 리뷰 검색 결과</h4>
	<hr/> 
	<c:if test="${empty reviewList}">리뷰 검색 결과가 없습니다.</c:if>
	<c:if test="${not empty reviewList}">
		<table>
		<c:forEach var="reviewvo" items="${reviewList}" varStatus="status">
			<tr>
				<td style="padding: 10px;">
					<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${reviewvo.restSeq}" style="color:black; text-decoration: none;">
					<img src="<%=request.getContextPath()%>/files/review/${reviewImageList[status.index]}" width="100px;"/>
					</a>
				</td>
				<td style="padding: 20px;">
					<h5>${reviewvo.reviewTitle}</h5><hr/>  
					${reviewvo.reviewContent} <br/> <br/> 
				</td>
				<td style="padding: 20px;">
					<span style='font-weight:bold; font-size:14px;'>${reviewvo.restName}</span> <br/> 
					<span style="color:#0066ff; font-size:12px;">${reviewvo.reviewBTag}</span> / <span style="color:#3333ff; font-size:10px;">${reviewvo.reviewMTag}</span>
				</td>
				<td align="right">
					평점 : <span style="font-weight:bold; font-size:15pt; color:red;">${reviewvo.reviewAvgScore}</span>점
				</td>
					<%-- <td>
				<c:set value = "0" var="flag" />
					
					<c:forEach var="likers" items="${likers}">
						<c:if test="${likers == review.reviewSeq }">
							<p align="right">
								<input type="button" id="like${status.index}" name="like" value="${review.reviewHit}Hit!" onClick="DownHit('${review.reviewSeq}','like${status.index}');" style="background-color: white; color: black" />
							</p>
							<c:set value = "1" var="flag" />
						</c:if>
					</c:forEach>
					
					
						<c:if test="${flag eq 0}">
							<p align="right">
								<input type="button" id="like${status.index}" name="like" value="${review.reviewHit}Hit!" onClick="insertAndUpHit('${review.reviewSeq}','like${status.index}');" />
							</p>
						</c:if>
					
					<section>
						<c:forEach var="reviewImage" items="${reviewImageList}">
							<c:if test="${review.reviewSeq == reviewImage.reviewSeq}">
								<a data-toggle="modal" data-target="#reviewImageDiv${status.index}"  data-dismiss="modal"><img src="<%= request.getContextPath() %>/files/${reviewImage.reviewImg}" width="100px" height="100px"/></a> &nbsp;&nbsp;
							</c:if>
						</c:forEach>
					</section> 
				</td>--%>
			  
		</c:forEach>
		</table>
	</c:if>
<c:if test="${not empty pageBar }">
<div align="center">
	${pageBar}
</div>
</c:if>
</div>