<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="library.jsp" />
<jsp:include page="top.jsp" />
	<script>
        $(document).ready(function() {
        	
        	$("#keyword").focus();
        	$("#keyword").val('${keyword}');
        	MainReview();
        	
        	$("#keyword").keyup(function(){
    		
    			$.ajax({
    				url:"<%=request.getContextPath()%>/autoComplete.eat",
    				type :"GET",
    				data: "srchType=all&keyword="+$("#keyword").val(),
    				dataType:"json",
    				success: function(data){
    					//alert(data.autoComSource);
    					
    						//alert(1);
    						$.widget( "custom.catcomplete", $.ui.autocomplete, {
    						      _create: function() {
    						        this._super();
    						        this.widget().menu( "option", "items", "> :not(.ui-autocomplete-category)" );
    						      },
    						      _renderMenu: function( ul, items ) {
    						        var that = this,
    						          currentCategory = "";
    						        $.each( items, function( index, item ) {
    						          var li;
    						          if ( item.category != currentCategory ) {
    						            ul.append( "<li class='ui-autocomplete-category'>" + item.category + "</li>" );
    						            currentCategory = item.category;
    						          }
    						          li = that._renderItemData( ul, item );
    						          if ( item.category ) {
    						            li.attr( "aria-label", item.category + " : " + item.label );
    						          }
    						        });// end of  $.each()
    						      }
    						    });// end of $.widget( "custom.catcomplete", $.ui.autocomplete, {})
    						
    						$("#keyword").catcomplete({
    							delay : 0,
    							source : data.cat_autoComSource
    						})						
    					
    					
    				}, //end of success: function(data)
    				error: function(request, status, error){
    					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				} // end of error: function(request,status,error)
    			}); //end of $.ajax()
    			
    			
    		});// end of $("#keyword").keyup
        	
        });// $(document).ready()
      
        	
      function MainReview(){
        $.ajax({ 
            url: "<%= request.getContextPath()%>/MainReviewAjax.eat",  
            method:"get",      
            dataType: "html",
            success: function(data) {
               
               $("#Scroller").html(data);
               
               }
         });//end of $.ajax()
          
       }// end of MainReview
       
       function goSearch(){
    	   if($("#keyword").val().trim().length == 0){
    		   return;
    	   }
    	   
    	   searchFrm.action = "<%=request.getContextPath()%>/search.eat";
    	   searchFrm.submit();
       }
       
   	// input 태그 엔터키 refresh 방지
   	function goButton() {
   		 if (event.keyCode == 13) {
   			goSearch();
   		  	return false;
   		 }
   		 return true;
   	}
       
       


       
</script> 
		
		<div id="leftCon">
			<div  id="search_div" align="center">
			<br/> 
			  <form name="searchFrm" id="searchFrm" onsubmit="return false;">
			    <div class="input-group" style="width: 100%;">
			      <input type="text" class="form-control" name="keyword" id="keyword" size="50" placeholder="검색어를 입력하세요!" onkeydown="goButton();" required>
			      <div class="input-group-btn">
			        <button type="button" class="btn" onclick="goSearch();">검색</button>
			      </div>
			    </div>
			  </form>
			</div>
			<br/> <br/> 
			<div id="restSearchResult">
				<h4>업장 검색 결과</h4>
				<hr/> 
				<c:if test="${empty restList}">업장 검색 결과가 없습니다.</c:if>
				<c:if test="${not empty restList}">
					<table>
					<c:forEach var="restvo" items="${restList }">
						<tr >
							<td style="padding: 10px;">
								<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${vo.restSeq}" style="color:black; text-decoration: none;">
								<img src="<%=request.getContextPath()%>/files/${restvo.restImg}" width="150px;"/>
								</a>
							</td>
							<td style="vertical-align: middle; padding: 10px;">
								<span style='font-weight:bold; font-size:18px;'>${restvo.restName}</span>
								<span style="color:#0066ff; font-size:14px;">${restvo.restBgTag}</span>
								<span style="color:#3333ff; font-size:12px;">${restvo.restMdTag}</span>
							</td>
						</tr>
					</c:forEach>
					</table>
				</c:if>
			</div>
			<br/><br/> 
			<div id="reviewSearchResult">
				<h4>리뷰 검색 결과</h4>
				<hr/> 
				<c:if test="${empty reviewList}">리뷰 검색 결과가 없습니다.</c:if>
				<c:if test="${not empty reviewList}">
					<table>
					<c:forEach var="review" items="${reviewList}" varStatus="status">
				
			<tr>
				<td>${review.userName }  <img src="<%= request.getContextPath() %>/files/user/${review.userProfile}" width="100px" height="100px"/></td>
					<td align="right">
						평점<span style="font-weight:bold; font-size:15pt; color:red;">${review.reviewAvgScore}</span>점
					</td>
				<td>
					<section>${review.reviewContent}</section>
					<%-- <c:set value = "0" var="flag" />
					
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
					</section> --%>
				</td>
			  
			</div>
		</c:forEach>
					</table>
				</c:if>
			</div>
			
			<%-- <div class="promBann">
				<img src="<%= request.getContextPath() %>/resources/images/imgProBanner01.jpg" border="0" />
			</div>
			<div class="localRankCon" style="margin-top:30px;">
				<img src="<%= request.getContextPath() %>/resources/images/imgTest03.png" border="0" width="731" />
			</div>
			
			<div class="reconCon">
				<h2>지하철 추천 맛집</h2>
				<img src="<%= request.getContextPath() %>/resources/images/imgTest02.jpg" border="0" />
			</div> --%>
		</div>
		<%-- end of leftCon --%>
		
		<div class="rightCon" id="Scroller"></div>
		<%-- end of rightCon --%>	

<jsp:include page="footer.jsp" />

