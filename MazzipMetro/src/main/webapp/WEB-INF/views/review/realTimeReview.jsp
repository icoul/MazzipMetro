<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">


$(document).ready(function(){
    
    
});// end of ready

</script>


<table  class="table table-bordered" id="Scroller">
    
        <c:forEach var="review" items="${reviewList}" varStatus="status">
                
            <tr>
                <td>${review.userName }  <img src="<%= request.getContextPath() %>/files/${review.userProfile}" width="100px" height="100px"/></td>
                <td align="right">
                    평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점(${review.restSeq})
                </td>
                <td>
                    <section>${review.reviewContent}</section>                    
                    <section>
                        <c:forEach var="reviewImage" items="${reviewImageList}">
                            <c:if test="${review.reviewSeq == reviewImage.reviewSeq}">
                                <a href="<%= request.getContextPath() %>/restaurantDetail.eat?restSeq=${review.restSeq}"><img src="<%= request.getContextPath() %>/files/${reviewImage.reviewImg}" width="100px" height="100px"/></a> &nbsp;&nbsp;
                            </c:if>
                        </c:forEach>
                    </section>
                </td>
        
            
            
            <%-- <div class="modal  fade" id="reviewImageDiv${status.index}" role="dialog" >
              <iframe scrolling="no" style=" border: none; width: 100%; height: 600px; " src="<%= request.getContextPath() %>/reviewModal.eat?reviewseq=${review.reviewSeq}&restname=${restvo.restname}&username=${review.userName }&reviewprofile=${review.userProfile}&reviewcontent=${review.reviewContent}&reviewregdate=${review.reviewRegDate}">
              </iframe>
              <div >
               <button type="button" class="btn btn-default myclose" data-dismiss="modal">닫기</button> 
              </div> 
              
            </div>--%>
            </tr>
        </c:forEach>
</table>
    
