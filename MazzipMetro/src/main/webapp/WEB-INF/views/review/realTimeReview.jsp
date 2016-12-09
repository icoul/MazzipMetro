<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <!-- 기본 jquery 라이브러리 -->

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<style>

#woo_scroller {
  position:relative;
  height:400px;
  width:350px;
  
  
  left:50px;
  /* margin-left:50px; */
  /* border:1px solid red; */
}

#woo_scroller table {border:0px; position:relative;  height:400px;
  width:350px; }

</style>

<script type="text/javascript">



$(document).ready(function(){
    
	
	// 함수호출
    
});// end of ready


	
	
 		             


</script>
</html>
<div id="woo_scroller"> 



<table  class="table table-bordered" >
    
        <c:forEach var="review" items="${reviewList}" varStatus="status">
                
            <tr>
                <td align="right">
                    	평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점
                </td>
                <td>
                    <section style="font-size: 9pt;">${review.reviewContent}</section>                    
                    <section>
                     <c:if test="${review.reviewSeq == reviewImageList.reviewSeq }"> 
                            <a href="<%= request.getContextPath() %>/restaurantDetail.eat?restSeq=${review.restSeq}"><img src="<%= request.getContextPath() %>/files/${reviewImageList[status.index].reviewImg}" width="50px" height="50px"/></a> &nbsp;&nbsp;
                     </c:if>         
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

</div>