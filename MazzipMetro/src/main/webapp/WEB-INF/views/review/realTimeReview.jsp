<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<style>

#woo_scroller {
  overflow:hidden;
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
		
	scrolling();
      
});// end of ready
 
function scrolling(){    

	(function($){
    	var $wrapper = $("#Scroll");
		$wrapper.css({'top':0});
		
		var n = 1;
		var animator  = function(imgblock){
			imgblock.animate({'top':-89.6*n}, 3000,
							function(){
							n++;
							if(n == 9){
								imgblock.css({'top':0});
								n = 1;
							}
							setTimeout(animator($(this)), 1000);
				});
			
		}
		
		// 마우스 호버시 애니메이션을 멈추기
		$wrapper.hover(function(){

			var eventCnt = $wrapper.queue('fx').length;
			// .queue('fx').length 를 통해서 현재 적용된 애니메이션 관련 효과가 몇개인지를 알 수 있다.
			for(var i=0; i<eventCnt; i++) {
				$wrapper.stop(); // 현재 수행중인 애니메이션만 멈추는 stop()메소드
			}
		},function(){
			animator($wrapper); //다시 처음부터 시작되지 않고, 중단된 부분부터 다시 간다.
		});

	})(jQuery)
		
	});// end of ready

 }


</script>
</html>
<div id="woo_scroller"> 

<table  class="table" id = "Scroll">

    
        <c:forEach var="review" items="${reviewList}" varStatus="status">
            <tr>
                <td align="right">
                    	평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점
                </td>
                <td style="border-right:0px;">
                    <a href="<%= request.getContextPath() %>/restaurantDetail.eat?restSeq=${review.restSeq}"><img src="<%= request.getContextPath() %>/files/${review.reviewImg}" width="50px" height="50px"/></a> &nbsp;&nbsp;
                </td>
                <td>    
                    <section style="font-size: 9pt;">
                    ${review.reviewContent}<br/>
                    ${review.restName}&nbsp;<br/>
                    ${review.restAddr}
                <td>
                    <section style="font-size: 9pt;">${review.reviewContent}</section>                    
                    <section>
                    		<a href="<%= request.getContextPath() %>/restaurantDetail.eat?restSeq=${review.restSeq}"><img src="<%= request.getContextPath() %>/files/${review.reviewImg}" width="50px" height="50px"/></a> &nbsp;&nbsp;
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