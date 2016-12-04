<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>image Map 테스트</title>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />
<style>
.tooltip_templates { display: none; }
</style>
<script>
        $(document).ready(function() {
        	//중복호출 방지용
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
						 var metroId = str.substring(str.lastIndexOf('=')+1);
		                 
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
						 var metroId = str.substring(str.lastIndexOf('=')+1);
		                 
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
						 var metroId = str.substring(str.lastIndexOf('=')+1);
		                 
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
						 var metroId = str.substring(str.lastIndexOf('=')+1);
		                 
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
            
            
        });// $(document).ready()
        
</script>

</head>
<body>
<img alt="" src="<%=request.getContextPath() %>/resources/images/metroMap.jpg"  usemap="#mazzipMetroImgMap" style="margin-left: 300px;margin-top: 300px;">
<map id="mazzipMetroImgMap" name="mazzipMetroImgMap">
	<area shape="circle" title="잠실역" 				  coords="521,388,16" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2005" id="2005" name="metroMapArea" data-tooltip-content="#tooltip_content_2005" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="잠실나루역" 			  coords="561,386,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2006" id="2006" name="metroMapArea" data-tooltip-content="#tooltip_content_2006" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="강변역" 				  coords="598,374,16" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2007" id="2007" name="metroMapArea" data-tooltip-content="#tooltip_content_2007" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="구의역" 				  coords="628,358,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2008" id="2008" name="metroMapArea" data-tooltip-content="#tooltip_content_2008" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="건대입구역"	 		  coords="659,333,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2009" id="2009" name="metroMapArea" data-tooltip-content="#tooltip_content_2009" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="성수역" 				  coords="678,299,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2010" id="2010" name="metroMapArea" data-tooltip-content="#tooltip_content_2010" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="뚝섬역" 				  coords="691,261,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2011" id="2011" name="metroMapArea" data-tooltip-content="#tooltip_content_2011" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="한양대역" 				  coords="693,223,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2012" id="2012" name="metroMapArea" data-tooltip-content="#tooltip_content_2012" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="왕십리역" 				  coords="681,185,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2043" id="2043" name="metroMapArea" data-tooltip-content="#tooltip_content_2043" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="상왕십리역" 			  coords="662,150,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2014" id="2014" name="metroMapArea" data-tooltip-content="#tooltip_content_2014" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="신당역" 				  coords="635,122,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2015" id="2015" name="metroMapArea" data-tooltip-content="#tooltip_content_2015" class='tooltip_group tooltipster_right'/>
	<area shape="circle" title="동대문역사문화공원역" coords="603,104,16" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2016" id="2016" name="metroMapArea" data-tooltip-content="#tooltip_content_2016" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="을지로4가역" 			  coords="566,92,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2017" id="2017" name="metroMapArea" data-tooltip-content="#tooltip_content_2017" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="을지로3가역" 			  coords="525,87,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2018" id="2018" name="metroMapArea" data-tooltip-content="#tooltip_content_2018" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="을지로입구역" 		  coords="487,87,14"   href="<%=request.getContextPath()%>/metroMap.eat?metroId=2019" id="2019" name="metroMapArea" data-tooltip-content="#tooltip_content_2019" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="시청역" 				  coords="445,87,14"  	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2020" id="2020" name="metroMapArea" data-tooltip-content="#tooltip_content_2020" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="충정로역" 				  coords="402,86,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2021" id="2021" name="metroMapArea" data-tooltip-content="#tooltip_content_2021" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="아현역" 			  	  coords="361,87,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2022" id="2022" name="metroMapArea" data-tooltip-content="#tooltip_content_2022" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="이대역" 				  coords="321,87,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2023" id="2023" name="metroMapArea" data-tooltip-content="#tooltip_content_2023" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="신촌역" 				  coords="282,85,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2024" id="2024" name="metroMapArea" data-tooltip-content="#tooltip_content_2024" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="홍대역" 				  coords="240,87,16" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2025" id="2025" name="metroMapArea" data-tooltip-content="#tooltip_content_2025" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="합정역" 				  coords="200,87,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2026" id="2026" name="metroMapArea" data-tooltip-content="#tooltip_content_2026" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="당산역" 			      coords="163,91,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2027" id="2027" name="metroMapArea" data-tooltip-content="#tooltip_content_2027" class='tooltip_group tooltipster_top'/>
	<area shape="circle" title="영등포구청역" 		  coords="126,99,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2028" id="2028" name="metroMapArea" data-tooltip-content="#tooltip_content_2028" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="문래역" 				  coords="95,118,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2029" id="2029" name="metroMapArea" data-tooltip-content="#tooltip_content_2029" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="신도림역" 				  coords="69,143,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2030" id="2030" name="metroMapArea" data-tooltip-content="#tooltip_content_2030" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="대림역" 				  coords="48,172,16" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2031" id="2031" name="metroMapArea" data-tooltip-content="#tooltip_content_2031" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="구로디지털단지역" 	  coords="36,207,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2032" id="2032" name="metroMapArea" data-tooltip-content="#tooltip_content_2032" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="신대방역" 				  coords="34,239,15"  	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2033" id="2033" name="metroMapArea" data-tooltip-content="#tooltip_content_2033" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="신림역" 				  coords="38,275,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2034" id="2034" name="metroMapArea" data-tooltip-content="#tooltip_content_2034" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="봉천역" 				  coords="52,308,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2035" id="2035" name="metroMapArea" data-tooltip-content="#tooltip_content_2035" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="서울대입구역"		  	  coords="74,334,15" 	href="<%=request.getContextPath()%>/metroMap.eat?metroId=2036" id="2036" name="metroMapArea" data-tooltip-content="#tooltip_content_2036" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="낙성대역" 				  coords="102,358,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2037" id="2037" name="metroMapArea" data-tooltip-content="#tooltip_content_2037" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="사당역" 				  coords="132,374,14" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2038" id="2038" name="metroMapArea" data-tooltip-content="#tooltip_content_2038" class='tooltip_group tooltipster_left'/>
	<area shape="circle" title="방배역" 				  coords="169,384,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2039" id="2039" name="metroMapArea" data-tooltip-content="#tooltip_content_2039" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="서초역" 			 	  coords="209,387,16" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2040" id="2040" name="metroMapArea" data-tooltip-content="#tooltip_content_2040" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="교대역" 				  coords="245,387,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2041" id="2041" name="metroMapArea" data-tooltip-content="#tooltip_content_2041" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="강남역" 				  coords="282,387,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2042" id="2042" name="metroMapArea" data-tooltip-content="#tooltip_content_2042" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="역삼역" 				  coords="324,386,16" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2001" id="2001" name="metroMapArea" data-tooltip-content="#tooltip_content_2001" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="선릉역" 				  coords="364,386,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2002" id="2002" name="metroMapArea" data-tooltip-content="#tooltip_content_2002" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="삼성역" 				  coords="403,387,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2003" id="2003" name="metroMapArea" data-tooltip-content="#tooltip_content_2003" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="종합운동장역" 		  coords="444,387,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2004" id="2004" name="metroMapArea" data-tooltip-content="#tooltip_content_2004" class='tooltip_group tooltipster_bottom'/>
	<area shape="circle" title="신천역" 				  coords="484,386,15" href="<%=request.getContextPath()%>/metroMap.eat?metroId=2061" id="2061" name="metroMapArea" data-tooltip-content="#tooltip_content_2061" class='tooltip_group tooltipster_bottom'/>
</map>

<div class="tooltip_templates" id="tooltip_templates">
    <span id="tooltip_content_2061">
        <img src="resources/images/irin.png"  width=""/> <br/> <strong>This is the content of my tooltip!</strong>
    </span>
    <div id="tooltip_content_2038">
        <img src="resources/images/irin.png" /> <br/> <strong>This is the content of my tooltip!</strong>
    </div>
    <div id="tooltip_content_2001">
        <img src="resources/images/irin.png" /> <br/> <strong>This is the content of my tooltip!</strong>
    </div>
</div>
<br/> 


</body>
</html>