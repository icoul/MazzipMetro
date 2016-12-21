<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="library.jsp" />
<jsp:include page="top.jsp" />
<style>
	.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
	.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
	.map_wrap {position:relative;width: 1000px;height:500px;}
	#menu_wrap {position: absolute;top:30;left:725;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
	.bg_white {background:#fff;}
	#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
	#menu_wrap .option{text-align: center;}
	#menu_wrap .option p {margin:10px 0;}  
	#menu_wrap .option button {margin-left:5px;}
	#placesList li {list-style: none;}
	#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
	#placesList .item span {display: block;margin-top:4px;}
	#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	#placesList .item .info{padding:10px 0 10px 55px;}
	#placesList .info .gray {color:#8a8a8a;}
	#placesList .info .jibun {padding-left:26px;background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
	#placesList .info .tel {color:#009900;}
	#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
	#placesList .item .marker_1 {background-position: 0 -10px;}
	#placesList .item .marker_2 {background-position: 0 -56px;}
	#placesList .item .marker_3 {background-position: 0 -102px}
	#placesList .item .marker_4 {background-position: 0 -148px;}
	#placesList .item .marker_5 {background-position: 0 -194px;}
	#placesList .item .marker_6 {background-position: 0 -240px;}
	#placesList .item .marker_7 {background-position: 0 -286px;}
	#placesList .item .marker_8 {background-position: 0 -332px;}
	#placesList .item .marker_9 {background-position: 0 -378px;}
	#placesList .item .marker_10 {background-position: 0 -423px;}
	#placesList .item .marker_11 {background-position: 0 -470px;}
	#placesList .item .marker_12 {background-position: 0 -516px;}
	#placesList .item .marker_13 {background-position: 0 -562px;}
	#placesList .item .marker_14 {background-position: 0 -608px;}
	#placesList .item .marker_15 {background-position: 0 -654px;}
	
	/* 동현 사용자 마커 */ 
	#placesList .item .usermarkerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(<%=request.getContextPath()%>/resources/images/img_marker_user.png) no-repeat;}
	#placesList .item .usermarker_1 {background-position: 0 -10px;}
	#placesList .item .usermarker_2 {background-position: 0 -56px;}
	#placesList .item .usermarker_3 {background-position: 0 -102px}
	#placesList .item .usermarker_4 {background-position: 0 -148px;}
	#placesList .item .usermarker_5 {background-position: 0 -194px;}
	#placesList .item .usermarker_6 {background-position: 0 -240px;}
	#placesList .item .usermarker_7 {background-position: 0 -286px;}
	#placesList .item .usermarker_8 {background-position: 0 -332px;}
	#placesList .item .usermarker_9 {background-position: 0 -378px;}
	#placesList .item .usermarker_10 {background-position: 0 -423px;}
	#placesList .item .usermarker_11 {background-position: 0 -470px;}
	#placesList .item .usermarker_12 {background-position: 0 -516px;}
	#placesList .item .usermarker_13 {background-position: 0 -562px;}
	#placesList .item .usermarker_14 {background-position: 0 -608px;}
	#placesList .item .usermarker_15 {background-position: 0 -654px;}
	
	#placesList .bgc {background-color: lime;}
	#pagination {margin:10px auto;text-align: center;}
	#pagination a {display:inline-block;margin-right:0px;}
	#pagination .on {font-weight: bold; cursor: default;color:#777;}
	/* #realReview {position:absolute; right:184px; height:40px; font-size: 25pt; font-weight: bold;} */
</style>
  
<script>
        $(document).ready(function() {
        	

        	// 실시간 리뷰 
        	MainReview();
        	
        	goRestRanking("1");

        	
        	// metroMap area 클릭시 이벤트 생성
        	$("[name=metroMapArea]").click(function(){
        		//종합운동장역은 map 에러가 나므로 지도를 호출하지 않는다.
        		if($(this).attr('id')==2004){alert('종합운동장역에 등록된 맛집이 없습니다.'); return;}
        		
        		searchByMetro(1, $(this).attr("id"));
        		
        		var title = "<h2 style='width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right; font-size:25px;'>"+$(this).attr('alt')+"<br/>맛집리스트 </h2>";
        		 $("#title_metroName").html(title);
        	});
        	
        	
   		 	// 페이지 최초로딩시 지하철역명 출력하기
   		 	var areaIdArr = $("[name=metroMapArea]");
   		 	areaIdArr.each(function(){
   		 		if(${metroId} == $(this).attr('id')){
   		 			var title = "<h2 style='width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right; font-size:25px;''>"+$(this).attr('alt')+"<br/>맛집리스트 </h2>";
   	   		 		$("#title_metroName").html(title);		
   		 		}
   		 	});
   		 
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
						 var metroId = str.substring(30, 34);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
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
		                 var metroId = str.substring(30, 34);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
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
		                 var metroId = str.substring(30, 34);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
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
		                 var metroId = str.substring(30, 34);//시작index, 끝나는 index  : javascript: searchByMetro(1, '2005')
		                 
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
            
            
        });//  $(document).ready()
        
        
//////////////////////////////////우철 실시간 리뷰 추가 ////////////////////////////////////////////////        
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
//////////////////////////////////////////////////////////////////////////////////////////////////        
</script>  
<div class="leftCon">
	<div class="mainBann">
	
	<img alt="" src="<%=request.getContextPath() %>/resources/images/metroMap.jpg"  usemap="#mazzipMetroImgMap" style="margin-top: 15px;margin-bottom: 15px;">
	<map id="mazzipMetroImgMap" name="mazzipMetroImgMap">
		<area shape="circle" alt="잠실역" 				  	coords="617,452,20" 	href="javascript: searchByMetro(1, '2005')" id="2005" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="잠실나루역" 			  	coords="661,450,19" 	href="javascript: searchByMetro(1, '2006')" id="2006" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="강변역" 				  	coords="704,440,19" 	href="javascript: searchByMetro(1, '2007')" id="2007" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="구의역" 				  	coords="745,419,17" 	href="javascript: searchByMetro(1, '2008')" id="2008" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="건대입구역"	 		  	coords="775,386,19" 	href="javascript: searchByMetro(1, '2009')" id="2009" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="성수역" 				  	coords="800,349,18" 	href="javascript: searchByMetro(1, '2010')" id="2010" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="뚝섬역" 				  	coords="814,302,18" 	href="javascript: searchByMetro(1, '2011')" id="2011" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="한양대역" 				coords="817,255,17" 	href="javascript: searchByMetro(1, '2012')" id="2012" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="왕십리역" 				coords="802,212,18" 	href="javascript: searchByMetro(1, '2043')" id="2043" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="상왕십리역" 			  	coords="784,173,17" 	href="javascript: searchByMetro(1, '2014')" id="2014" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="신당역" 				  	coords="747,137,15" 	href="javascript: searchByMetro(1, '2015')" id="2015" name="metroMapArea" class='tooltip_group tooltipster_right'/>
		<area shape="circle" alt="동대문역사문화공원역" coords="713,113,15" 	href="javascript: searchByMetro(1, '2016')" id="2016" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="을지로4가역" 			coords="668,99,17"   	href="javascript: searchByMetro(1, '2017')" id="2017" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="을지로3가역" 			coords="621,95,17"   	href="javascript: searchByMetro(1, '2018')" id="2018" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="을지로입구역" 		  	coords="573,97,18"   	href="javascript: searchByMetro(1, '2019')" id="2019" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="시청역" 				  	coords="526,97,18"  	href="javascript: searchByMetro(1, '2020')" id="2020" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="충정로역" 				coords="478,97,18" 	href="javascript: searchByMetro(1, '2021')" id="2021" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="아현역" 			  	  	coords="430,97,18" 	href="javascript: searchByMetro(1, '2022')" id="2022" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="이대역" 				  	coords="381,96,18" 	href="javascript: searchByMetro(1, '2023')" id="2023" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="신촌역" 				  	coords="333,97,17" 	href="javascript: searchByMetro(1, '2024')" id="2024" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="홍대역" 				  	coords="283,98,18" 	href="javascript: searchByMetro(1, '2025')" id="2025" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="합정역" 				  	coords="238,96,17" 	href="javascript: searchByMetro(1, '2026')" id="2026" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="당산역" 			      	coords="193,103,17" 	href="javascript: searchByMetro(1, '2027')" id="2027" name="metroMapArea" class='tooltip_group tooltipster_top'/>
		<area shape="circle" alt="영등포구청역" 		  	coords="150,111,15" 	href="javascript: searchByMetro(1, '2028')" id="2028" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="문래역" 				  	coords="116,134,18" 	href="javascript: searchByMetro(1, '2029')" id="2029" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="신도림역" 				coords="83,165,17" 	href="javascript: searchByMetro(1, '2030')" id="2030" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="대림역" 				  	coords="59,200,17" 	href="javascript: searchByMetro(1, '2031')" id="2031" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="구로디지털단지역" 	  	coords="45,239,17" 	href="javascript: searchByMetro(1, '2032')" id="2032" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="신대방역" 				coords="40,280,16"  	href="javascript: searchByMetro(1, '2033')" id="2033" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="신림역" 				  	coords="47,322,18" 	href="javascript: searchByMetro(1, '2034')" id="2034" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="봉천역" 				  	coords="63,361,17" 	href="javascript: searchByMetro(1, '2035')" id="2035" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="서울대입구역"		  	coords="88,392,15" 	href="javascript: searchByMetro(1, '2036')" id="2036" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="낙성대역" 				coords="125,418,17" 	href="javascript: searchByMetro(1, '2037')" id="2037" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="사당역" 				  	coords="160,441,16" 	href="javascript: searchByMetro(1, '2038')" id="2038" name="metroMapArea" class='tooltip_group tooltipster_left'/>
		<area shape="circle" alt="방배역" 				  	coords="203,451,17" 	href="javascript: searchByMetro(1, '2039')" id="2039" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="서초역" 			 	  	coords="244,455,17" 	href="javascript: searchByMetro(1, '2040')" id="2040" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="교대역" 				  	coords="293,455,18" 	href="javascript: searchByMetro(1, '2041')" id="2041" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="강남역" 				  	coords="337,455,17" 	href="javascript: searchByMetro(1, '2042')" id="2042" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="역삼역" 				  	coords="382,455,17" 	href="javascript: searchByMetro(1, '2001')" id="2001" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="선릉역" 				  	coords="432,454,18" 	href="javascript: searchByMetro(1, '2002')" id="2002" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="삼성역" 				  	coords="477,455,17" 	href="javascript: searchByMetro(1, '2003')" id="2003" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="종합운동장역" 		  	coords="524,455,17" 	href="javascript: searchByMetro(1, '2004')" id="2004" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
		<area shape="circle" alt="신천역" 				  	coords="573,454,18" 	href="javascript: searchByMetro(1, '2061')" id="2061" name="metroMapArea" class='tooltip_group tooltipster_bottom'/>
	</map>
</div>
</div>

<%-- end of leftCon --%>
		
<div class="rightCon">
	<div class="realTimeAppra">
		<div id="realReview" ><img style="width: 50px; height: 50px;" src="<%= request.getContextPath() %>/resources/images/pizza.png">&nbsp;실시간 리뷰&nbsp;<img style="width: 50px; height: 50px;" src="<%= request.getContextPath() %>/resources/images/hamburger.png"></div>
		<div id="Scroller" class="Scroller"></div>
	</div>
</div>
<%-- end of rightCon --%>	

<br/> 

	<!-- 해당역사 안내 -->
	<br/> 
	<div id="title_metroName" style="clear: both; float:left;"></div>
	
	
	<!-- 사용자 마커 안내 -->
	<div style="float:left; padding-left: 550px;padding-top: 90px;padding-bottom: 10px;" >
	<table >
		<tr>
			<td >
			<div style="width: 36px; height:45px; background-image: url('<%=request.getContextPath()%>/resources/images/img_marker_user.png'); background-position: initial;">
			</div>
			</td >
			<td style="vertical-align: bottom;"><span style="font-size: 12px;">사용자가 <br/> 정복한 맛집</span></td>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
			<td>
			<div style="width: 36px; height:45px; background-image: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'); background-position: left top;" >
			</div>
			</td>
			<td style="vertical-align: bottom;"><span style="font-size: 12px;">사용자가 <br/> 정복해야할  맛집</span></td>
		</tr>
	</table>
	</div>
	<br/> <br/> <br/> 
	
	<!-- 지도 섹션 -->
	<div class="map_wrap"  style="clear:both;">
	    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	
		<div id="menu_wrap" class="bg_white">
	        <ul id="placesList"></ul>
	        <div id="pagination"></div>
	    </div>
	</div>

<div class="rankingView">

</div>

<script type="text/javascript">

	$(document).ready(function(){
	
		searchByMetro(1, '${metroId}');
		
	});//end of $(document).ready()

</script>
<script>
function goRestRanking(pageNum){
	
	var form_data = {
			
			pageNum : pageNum,
			metroId : "${metroId}",   // 키값 : 밸류값 
			dongId  : "",     // 키값 : 밸류값
			regDate : "0",
		}
	
	$.ajax({
		url : "<%=request.getContextPath()%>/metroMapRestRanking.eat",
		method : "GET",
		data : form_data,
		dataType : "html",
		success : function(data){
			$(".rankingView").html(data);
		}
	}); // end of ajax
}


function searchByMetro(reqPage, metroId){
	var pageNo = reqPage;
	
	$.ajax({
		url:"<%=request.getContextPath()%>/searchByMetro.eat",
		type :"GET",
		data: "metroId="+metroId+"&pageNo="+pageNo,
		dataType:"json",
		success: function(data,status){
			//alert(status); //검색조건에 해당하는 행이 없어도 succeed이다ㅠㅜ
			
			// 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data.places, data.tagList, data.userPlaces);

	        // 페이지 번호를 표출합니다
	        $("#pagination").html(data.pageBar);
	        
	        //alert(data.userPlaces);
			
		}, //end of success: function(data)
		error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		} // end of error: function(request,status,error)
		
	}); //end of $.ajax()
	
}//end of searchByMetro()

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 
map.setZoomable(false);

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places, tags, userPlaces) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(places[i].restLatitude, places[i].restLongitude),
        	marker, itemEl;
        
        var userConquest = false;
        
        if (userPlaces != null) {
	        for (var j = 0; j< userPlaces.length; j++) {
				if (places[i].restSeq == userPlaces[j] ) {
					userConquest = true;
				}
			}			
		} // end of  if (userPlaces != null)
        
        if (userConquest) {
        	marker = addUserMarker(placePosition, i);
        	 itemEl = getUserListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다(사용자 정복)
		} else {
            marker = addMarker(placePosition, i);
            itemEl = getListItem(i, places[i], marker); // 검색 결과 항목 Element를 생성합니다
		}

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title, seq) {
            daum.maps.event.addListener(marker, 'mouseover', function(event) {
                displayInfowindow(marker, title);
                var dx = document.getElementById('div'+seq);
                dx.classList.add('bgc');
                
            });

            daum.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
                var dx = document.getElementById('div'+seq);
                dx.classList.remove('bgc');
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
                var dx = document.getElementById('div'+seq);
                dx.classList.add('bgc');
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
                var dx = document.getElementById('div'+seq);
                dx.classList.remove('bgc');
            };
            
            daum.maps.event.addListener(marker, 'click', function() {
            	location.href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq="+seq;
            });

            itemEl.onclick =  function () {
            	location.href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq="+seq;
            };
            
        })(marker, places[i].restName, places[i].restSeq);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info" id="div'+places.restSeq+'">' +
                '   <h5>' + places.restName + '</h5>';
    if (places.restBgTag) {
    	itemStr += '<span style="color:blue; display: inline;">'+places.restBgTag+'</span>&nbsp;';

	}
    if (places.restMdTag) {
    	itemStr += '<span style="color:orange; display: inline; font-size: 12px;">'+places.restMdTag+'</span>';
    }
    
    if (places.restNewAddr) {
        itemStr += '    <span>' + places.restNewAddr + '</span>' +
                    '   <span class="jibun gray">' +  places.restAddr  + '</span>';
    } else {
        itemStr += '    <span>' +  places.restAddr + '</span>'; 
    }
           
    if(places.restPhone){
      itemStr += '  <a href="tel:'+places.restPhone+'"><span class="tel">' + places.restPhone  + '</span></a>' + '</div>';               	
    }

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

//검색결과 항목을 Element로 반환하는 함수입니다(사용자 정복)
function getUserListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="usermarkerbg usermarker_' + (index+1) + '"></span>' +
                '<div class="info" id="div'+places.restSeq+'">' +
                '   <h5>' + places.restName + '</h5>';
    if (places.restBgTag) {
    	itemStr += '<span style="color:blue; display: inline;">'+places.restBgTag+'</span>&nbsp;';

	}
    if (places.restMdTag) {
    	itemStr += '<span style="color:orange; display: inline; font-size: 12px;">'+places.restMdTag+'</span>';
    }
    
    if (places.restNewAddr) {
        itemStr += '    <span>' + places.restNewAddr + '</span>' +
                    '   <span class="jibun gray">' +  places.restAddr  + '</span>';
    } else {
        itemStr += '    <span>' +  places.restAddr + '</span>'; 
    }
           
    if(places.restPhone){
      itemStr += '  <a href="tel:'+places.restPhone+'"><span class="tel">' + places.restPhone  + '</span></a>' + '</div>';               	
    }

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

//사용자 마커를 생성하고 지도 위에 사용자 마커를 표시하는 함수입니다
function addUserMarker(position, idx, title) {
	//alert('addUserMarker');
    var imageSrc = '<%=request.getContextPath()%>/resources/images/img_marker_user.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
</script>

<jsp:include page="footer.jsp" />