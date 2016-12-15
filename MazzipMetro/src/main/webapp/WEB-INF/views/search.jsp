<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="library.jsp" />
<jsp:include page="top.jsp" />
	<script>
        $(document).ready(function() {
        	
        	$("#keyword").focus();
        	$("#keyword").val('${keyword}');
        	
        	goSearch();
        	
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
    		//alert($("#keyword").val());   
       	
    	   if($("#keyword").val().trim().length == 0){
    		   return;
    	   }
    	   
    	   
    	   goRestSearch(1);// 업장 검색 1페이지 요청
    	   goReviewSearch(1);// 리뷰 검색 1페이지 요청
    	   
    	   <%-- searchFrm.action = "<%=request.getContextPath()%>/search.eat";
    	   searchFrm.submit(); --%>
       }
       
       function goRestSearch(pageNo){
    	   //alert(pageNo);
    	   
    	   var srchFrmData = {
    				keyword : $("#keyword").val()
    			  , pageNo : pageNo
    			}
    			
    		    $.ajaxSettings.traditional = true;
    		    $.ajax({
    				url: "<%=request.getContextPath()%>/restSearch.eat",  
    				async: false, 
    				data: srchFrmData,
    				dataType: "html",
    				success: function(data) {
    					$("#restSearchResult").html(data);
    				}
    			});//end of $.ajax()
       }
       
       function goReviewSearch(pageNo){
    	   var srchFrmData = {
   				keyword : $("#keyword").val()
   			  , pageNo : pageNo
   			}
   			
   		    $.ajaxSettings.traditional = true;
   		    $.ajax({
   				url: "<%=request.getContextPath()%>/reviewSearch.eat",  
   				async: false, 
   				data: srchFrmData,
   				dataType: "html",
   				success: function(data) {
   					$("#reviewSearchResult").html(data);
   				}
   			});//end of $.ajax()
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
		<br/> <br/> 
			<!-- 업장 검색 결과 -->
			<div  id="restSearchResult"></div>
			<br/><br/> 
			<!-- 리뷰 검색 결과 -->
			<div id="reviewSearchResult"></div>
			<br/> <br/>
			 	
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

