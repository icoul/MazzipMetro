<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="library.jsp" />

<jsp:include page="top.jsp" />


	<script>
        $(document).ready(function() {
        	
        	$("#keyword").focus();
        	

        	// 실시간 리뷰 애니메이트
            MainReview();
            scrolling();

        	// tooltipster 중복호출 방지용
        	var metroIdArr = [];
        	
        	// tooltipster 활성화 
            $('.tooltipster_top').tooltipster({
            	animation: 'grow',
            	animationDuration: 200,
            	distance : 3,
           	   	delay: 100,
           	   	side: 'top', // 'top', 'bottom', 'right', 'left'
           	   	theme: 'tooltipster-noir',
           	   	trigger: 'hover',
           	 	interactive: true,
	           	content: 'Loading...',
	           	contentAsHTML: true,// if($origin.data('loaded') !== true)) 이 조건식에 걸리지 않는다. 
	           	
	             // 'instance' is basically the tooltip. More details in the "Object-oriented Tooltipster" section.
	            functionBefore: function(instance, helper) {
	                 
		                 var $origin = $(helper.origin);
		              	// metroId 얻어오기
		              	
		                 var str = instance.elementOrigin().toString(); // localhost로 시작하는 href 값이 나오지만, 객체이다.
		                 
						 var metroId = str.substring(str.indexOf("=")+1, str.indexOf("=")+5);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		              	//alert(metroId);
		                 
		                 for (var i = 0; i < metroIdArr.length; i++) {
							if(metroIdArr[i] == metroId)
								return;
						}
		                 
		                 // we set a variable so the data is only loaded once via Ajax, not every time the tooltip opens
		                 if ($origin.data('loaded') !== true) {
							 $.get('<%=request.getContextPath()%>/getBest5RestInMetroMap.eat', "metroId="+metroId, function(data) {

								 //중복 호출을 막기위해 : metroIdArr에 해당 metroId push하
								 metroIdArr.push(metroId);
								 
				                // call the 'content' method to update the content of our tooltip with the returned data.
				                // note: this content update will trigger an update animation (see the updateAnimation option)
				                instance.content(data);

				                // to remember that the data has been loaded
				                $origin.data('loaded', true);
					            },'html');
		                 }
		             }// end of functionBefore
            });
            
            $('.tooltipster_right').tooltipster({
            	animation: 'grow',
            	animationDuration: 200,
            	distance : 3,
           	   	delay: 100,
           	   	side: 'right', // 'top', 'bottom', 'right', 'left'
           	   	theme: 'tooltipster-noir',
           	   	trigger: 'hover',
           	 	interactive: true,
	           	content: 'Loading...',
	           	contentAsHTML: true,
	             // 'instance' is basically the tooltip. More details in the "Object-oriented Tooltipster" section.
	            functionBefore: function(instance, helper) {
	                 
		                 var $origin = $(helper.origin);
		             	 // metroId 얻어오기
		                 var str = instance.elementOrigin().toString(); // localhost로 시작하는 href 값이 나오지만, 객체이다.
		                 var metroId = str.substring(str.indexOf("=")+1, str.indexOf("=")+5);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
		                 for (var i = 0; i < metroIdArr.length; i++) {
							if(metroIdArr[i] == metroId)
								return;
						}
		                 // we set a variable so the data is only loaded once via Ajax, not every time the tooltip opens
		                 if ($origin.data('loaded') !== true) {
							$.ajax({
		                 		url:"<%=request.getContextPath()%>/getBest5RestInMetroMap.eat",
		                 		type :"GET",
		                 		data: "metroId="+metroId,
		                 		dataType:"html",
		                 		success: function(data,status){

									 //중복 호출을 막기위해 : metroIdArr에 해당 metroId push하
									 metroIdArr.push(metroId);
									 
					                // call the 'content' method to update the content of our tooltip with the returned data.
					                // note: this content update will trigger an update animation (see the updateAnimation option)
					                instance.content(data);

					                // to remember that the data has been loaded
					                $origin.data('loaded', true);
		                 		}, //end of success: function(data)
		                 		error: function(request, status, error){
		                 			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		                 		} // end of error: function(request,status,error)
		                 		
		                 	}); //end of $.ajax()
		                 }
		             }// end of functionBefore
            });
            
            
            $('.tooltipster_bottom').tooltipster({
            	animation: 'grow',
            	animationDuration: 200,
            	distance : 3,
           	   	delay: 100,
           	 	side: 'bottom', // 'top', 'bottom', 'right', 'left'
           	   	theme: 'tooltipster-noir',
           	   	trigger: 'hover',
           		interactive: true,
	           	content: 'Loading...',
	           	contentAsHTML: true,
	             // 'instance' is basically the tooltip. More details in the "Object-oriented Tooltipster" section.
	            functionBefore: function(instance, helper) {
	                 
		                 var $origin = $(helper.origin);
		              	// metroId 얻어오기
		                 var str = instance.elementOrigin().toString(); // localhost로 시작하는 href 값이 나오지만, 객체이다.
		                 var metroId = str.substring(str.indexOf("=")+1, str.indexOf("=")+5);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
		                 for (var i = 0; i < metroIdArr.length; i++) {
							if(metroIdArr[i] == metroId)
								return;
						}
		                 // we set a variable so the data is only loaded once via Ajax, not every time the tooltip opens
		                 if ($origin.data('loaded') !== true) {
		                	 $.ajax({
		                 		url:"<%=request.getContextPath()%>/getBest5RestInMetroMap.eat",
		                 		type :"GET",
		                 		data: "metroId="+metroId,
		                 		dataType:"html",
		                 		success: function(data,status){

									 //중복 호출을 막기위해 : metroIdArr에 해당 metroId push하
									 metroIdArr.push(metroId);
									 
					                // call the 'content' method to update the content of our tooltip with the returned data.
					                // note: this content update will trigger an update animation (see the updateAnimation option)
					                instance.content(data);

					                // to remember that the data has been loaded
					                $origin.data('loaded', true);
		                 		}, //end of success: function(data)
		                 		error: function(request, status, error){
		                 			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		                 		} // end of error: function(request,status,error)
		                 		
		                 	}); //end of $.ajax()
		                 }
		             }// end of functionBefore
            });
            
            $('.tooltipster_left').tooltipster({
            	animation: 'grow',
            	animationDuration: 200,
            	distance : 3,
           	   	delay: 100,
           	   	side: 'left', // 'top', 'bottom', 'right', 'left'
           	   	theme: 'tooltipster-noir',
           	   	trigger: 'hover',
           		interactive: true,
	           	content: 'Loading...',
	           	contentAsHTML: true,
	             // 'instance' is basically the tooltip. More details in the "Object-oriented Tooltipster" section.
	            functionBefore: function(instance, helper) {
	                 
		                 var $origin = $(helper.origin);
		             	 // metroId 얻어오기
		                 var str = instance.elementOrigin().toString(); // localhost로 시작하는 href 값이 나오지만, 객체이다.
		                 var metroId = str.substring(str.indexOf("=")+1, str.indexOf("=")+5);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
		                 for (var i = 0; i < metroIdArr.length; i++) {
							if(metroIdArr[i] == metroId)
								return;
						}
		                 // we set a variable so the data is only loaded once via Ajax, not every time the tooltip opens
		                 if ($origin.data('loaded') !== true) {
		                	 $.ajax({
		                 		url:"<%=request.getContextPath()%>/getBest5RestInMetroMap.eat",
		                 		type :"GET",
		                 		data: "metroId="+metroId,
		                 		dataType:"html",
		                 		success: function(data,status){
									 //중복 호출을 막기위해 : metroIdArr에 해당 metroId push하
									 metroIdArr.push(metroId);
									 
					                // call the 'content' method to update the content of our tooltip with the returned data.
					                // note: this content update will trigger an update animation (see the updateAnimation option)
					                instance.content(data);
					                
					                // to remember that the data has been loaded
					                $origin.data('loaded', true);
		                 		}, //end of success: function(data)
		                 		error: function(request, status, error){
		                 			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		                 		} // end of error: function(request,status,error)
		                 		
		                 	}); //end of $.ajax()
		                 }
		             }// end of functionBefore
            });
            
         // bind on start events (triggered on mouseenter)
            $.tooltipster.on('start', function(event) {

                if ($(event.instance.elementOrigin()).hasClass('tooltip_group')) {

                    var instances = $.tooltipster.instances('.tooltip_group'),
                        open = false,
                        duration;

                    $.each(instances, function (i, instance) {

                        if (instance !== event.instance) {

                            // if another instance is already open
                            if (instance.status().open){

                                open = true;

                                // get the current animationDuration
                                duration = instance.option('animationDuration');

                                // close the tooltip without animation
                                instance.option('animationDuration', 0);
                                instance.close();
                                
                                // restore the animationDuration to its normal value
                                instance.option('animationDuration', duration);
                            }
                        }
                    });

                    // if another instance was open
                    if (open) {

                        duration = event.instance.option('animationDuration');

                        // open the tooltip without animation
                        event.instance.option('animationDuration', 0);
                        event.instance.open();
                        
                        // restore the animationDuration to its normal value
                        event.instance.option('animationDuration', duration);

                        // now that we have opened the tooltip, the hover trigger must be stopped
                        event.stop();
                    }
                }
            });
            
            
            $("#keyword").keyup(function(){
        		
    			$.ajax({
    				url:"<%=request.getContextPath()%>/autoComplete.eat",
    				type :"GET",
    				data: "srchType=all&keyword="+$("#keyword").val(),
    				dataType:"json",
    				success: function(data){
    					//alert(data.autoComSource);
    					
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
    							minLength: 0,
    							source : data.cat_autoComSource
    						})						 
    					
    					
    				}, //end of success: function(data)
    				error: function(request, status, error){
    					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
    				} // end of error: function(request,status,error)
    			}); //end of $.ajax()
    			
    			
    		});// end of $("#keyword").keyup
            
        });// $(document).ready()
        
        //등록된 맛집이 없는 경우(지도에러유발) 링크 폐쇄
        function goAlert(metroName){
        	alert(metroName + '에 등록된 맛집이 없습니다.');
        }
        

        function MainReview(){
        	
    	 $.ajax({ 
    			url: "<%= request.getContextPath()%>/MainReviewAjax.eat",  
    			method:"get",  	 
    			dataType: "html",
    			success: function(data) {
    				
    				$("#scroller").html(data);
    				
    				}
    		});//end of $.ajax()
        	
        }// end of MainReview
        
        <%-- function animate(){
        	var $wrapper = $("#woo_scroller table");
        	$wrapper.css({'top':0});
        	
        	var animator =	function(imgblock){
				imgblock.animate({'top':-100}, 5500,
								   function(){
									  imgblock.css({'top':0});
									// $(this).css({'top':550});
									  animator(imgblock); //재귀함수 호출 -> 반복효과
									  // animator($(this));
				                   }
				                 );	
            } // 함수정의
        	animator($wrapper); 
        }
         function MainReview(){
        	
       	 $.ajax({ 
       			url: "<%= request.getContextPath()%>/MainReviewAjax.eat",  
       			method:"get",  	 
       			dataType: "html",
       			success: function(data) {
       				
       				$("#scroller").html(data);
       				
       				}
       		});//end of $.ajax()
           	
           }// end of MainReview --%>
           
           function MainReview(){
               $.ajax({ 
                   url: "<%= request.getContextPath()%>/MainReviewAjax.eat",  
                   method:"get",      
                   dataType: "html",
                   success: function(data) {
                      
                      $("#scroller").html(data);
                      
                      }
                });//end of $.ajax()
                 
              }// end of MainReview
              
              function scrolling(){
                 var $wrapper = $("#scroller");
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
		
			<!-- 검색바 -->
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
			
			<div class="mainBann">
				<img alt="" src="<%=request.getContextPath() %>/resources/images/metroMap.jpg"  usemap="#mazzipMetroImgMap" style="margin-top: 15px;margin-bottom: 15px;">
				<map id="mazzipMetroImgMap" name="mazzipMetroImgMap">
					<area shape="circle" alt="잠실역" 				  	coords="521,388,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2005" id="2005" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="잠실나루역" 			  	coords="561,386,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2006" id="2006" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="강변역" 				  	coords="598,374,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2007" id="2007" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="구의역" 				  	coords="628,358,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2008" id="2008" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="건대입구역"	 		  	coords="659,333,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2009" id="2009" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="성수역" 				  	coords="678,299,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2010" id="2010" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="뚝섬역" 				  	coords="691,261,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2011" id="2011" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="한양대역" 				coords="693,223,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2012" id="2012" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="왕십리역" 				coords="681,185,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2043" id="2043" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="상왕십리역" 			  	coords="662,150,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2014" id="2014" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="신당역" 				  	coords="635,122,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2015" id="2015" name="metroMapArea" class='tooltip_group tooltipster_right'/>
					<area shape="circle" alt="동대문역사문화공원역" coords="603,104,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2016" id="2016" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="을지로4가역" 			coords="566,92,15"   	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2017" id="2017" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="을지로3가역" 			coords="525,87,15"   	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2018" id="2018" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="을지로입구역" 		  	coords="487,87,14"   	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2019" id="2019" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="시청역" 				  	coords="445,87,14"  	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2020" id="2020" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="충정로역" 				coords="402,86,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2021" id="2021" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="아현역" 			  	  	coords="361,87,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2022" id="2022" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="이대역" 				  	coords="321,87,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2023" id="2023" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="신촌역" 				  	coords="282,85,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2024" id="2024" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="홍대역" 				  	coords="240,87,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2025" id="2025" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="합정역" 				  	coords="200,87,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2026" id="2026" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="당산역" 			      	coords="163,91,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2027" id="2027" name="metroMapArea" class='tooltip_group tooltipster_top'/>
					<area shape="circle" alt="영등포구청역" 		  	coords="126,99,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2028" id="2028" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="문래역" 				  	coords="95,118,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2029" id="2029" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="신도림역" 				coords="69,143,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2030" id="2030" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="대림역" 				  	coords="48,172,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2031" id="2031" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="구로디지털단지역" 	  	coords="36,207,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2032" id="2032" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="신대방역" 				coords="34,239,15"  	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2033" id="2033" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="신림역" 				  	coords="38,275,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2034" id="2034" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="봉천역" 				  	coords="52,308,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2035" id="2035" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="서울대입구역"		  	coords="74,334,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2036" id="2036" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="낙성대역" 				coords="102,358,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2037" id="2037" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="사당역" 				  	coords="132,374,14" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2038" id="2038" name="metroMapArea" class='tooltip_group tooltipster_left'/>
					<area shape="circle" alt="방배역" 				  	coords="169,384,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2039" id="2039" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="서초역" 			 	  	coords="209,387,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2040" id="2040" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="교대역" 				  	coords="245,387,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2041" id="2041" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="강남역" 				  	coords="282,387,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2042" id="2042" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="역삼역" 				  	coords="324,386,16" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2001" id="2001" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="선릉역" 				  	coords="364,386,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2002" id="2002" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="삼성역" 				  	coords="403,387,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2003" id="2003" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="종합운동장역" 		  	coords="444,387,15" 	href="javascript:goAlert('종합운동장역');" 														id="2004" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
					<area shape="circle" alt="신천역" 				  	coords="484,386,15" 	href="<%=request.getContextPath() %>/metroMap.eat?metroId=2061" id="2061" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
				</map>
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
		
		<div class="rightCon" id="scroller">
		</div>
		<%-- end of rightCon --%>	

<jsp:include page="footer.jsp" />

