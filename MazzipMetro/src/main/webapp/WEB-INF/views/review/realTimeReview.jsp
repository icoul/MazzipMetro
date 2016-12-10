<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

$(document).ready(function(){
	
	scrolling();
      
});// end of ready
 
function scrolling(){    

    var $wrapper = $("#Scroller");
    $wrapper.css({'top':0});
    
    var animator =   function(imgblock){
     imgblock.animate({'top':-100}, 5500,
                    function(){
                      imgblock.css({'top':0});
                      animator(imgblock); //재귀함수 호출 -> 반복효과
                        }
                      );   
     } // 함수정의
     
    animator($wrapper);
 }
</script>


<table  class="table table-bordered" id = "Scroll">
    
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
            </tr>
        </c:forEach>
</table>
    
