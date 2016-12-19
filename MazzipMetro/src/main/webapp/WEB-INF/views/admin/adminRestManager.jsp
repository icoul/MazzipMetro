<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../library.jsp" />
<jsp:include page="../top.jsp" />
	 <style type="text/css">
	    .wrap {position: absolute;left: 0;bottom: 40px;width: 288px;height: 132px;margin-left: -144px;text-align: left;overflow: hidden;font-size: 12px;font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;line-height: 1.5;}
	    .wrap * {padding: 0;margin: 0;}
	    .wrap .info {width: 286px;height: 120px;border-radius: 5px;border-bottom: 2px solid #ccc;border-right: 1px solid #ccc;overflow: hidden;background: #fff;}
	    .wrap .info:nth-child(1) {border: 0;box-shadow: 0px 1px 2px #888;}
	    .info .title {padding: 5px 0 0 10px;height: 30px;background: #eee;border-bottom: 1px solid #ddd;font-size: 18px;font-weight: bold;}
	    .info .close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
	    .info .close:hover {cursor: pointer;}
	    .info .body {position: relative;overflow: hidden;}
	    .info .desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
	    .desc .ellipsis {overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
	    .desc .jibun {font-size: 11px;color: #888;margin-top: -2px;}
	    .info .img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
	    .info:after {content: '';position: absolute;margin-left: -12px;left: 50%;bottom: 0;width: 22px;height: 12px;background: url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	    .info .link {color: #5085BB;}
	 </style>
	 
</head>


<div id="searchFrmContainer" style="position: relative;">
	<div style="float:left; width:200px; height:814px; border-left:1px solid #dbdbdb; border-right:1px solid #dbdbdb; padding:0; margin:0;">
		<h2 style="width:187px; border-bottom:2px solid #000; padding-top:30px;  padding-bottom:5px; text-align:right; font-size:25px;">관리자 <br/> 업장 검색</h2>
	</div>
	<%-- subleftCon --%>
	<div style="float:left; width:1200px;  text-align:center; border-right:1px solid #dbdbdb; padding-bottom:40px; padding-top: 20px;">
		<span style="font-weight: bold; color: orange; text-decoration: underline;">관리자님, 검색조건을 입력후에 검색버튼을 눌러주세요.</span>
		<form id="searchFrm" onsubmit="return false;">
			<br/>
			
			<div class="container" style="width: 80%; margin: auto;" >
				<div class="col-sm-2 col-sm-offset-2">
					<select name="srchType" id="srchType" class="form-control">
						<option value="all">통합검색</option>
						<option value="restName">음식점명 검색</option>
						<option value="metroName">지하철역사 검색</option>
						<option value="dongName">동 검색</option>
						<option value="guName">구 검색</option>
					</select>
				</div>
				<div class="col-sm-7">
					<div class="input-group" >
				      	<input type="text" class="form-control" name="adminKeyword" id="adminKeyword" size="10" placeholder="검색어를 입력하세요!" onkeydown="goButton();">
				      	<div class="input-group-btn">
				        	<button type="button" class="btn btn-default" onclick="getRestaurant();" >검색</button>
				      	</div>
			      	</div>
			    </div>
		    </div> 
			<br/>
			<div class="row" style="width: 80%; margin: auto;" >
				<!-- 지하철 역명 선택 -->
				<div class="col-sm-3 col-sm-offset-2">
				<select name="selMenu_metroName" id="selMenu_metroName" class="form-control" ></select>
				</div>
				
				<!-- 구 이름 선택 -->
				<div class="col-sm-3">
				<select name="selMenu_guName" id="selMenu_guName" class="form-control"></select>
				</div>
				
				<!-- 동이름 선택 -->
				<div class="col-sm-3">
				<select name="selMenu_dongName" id="selMenu_dongName" class="form-control"><option value="dongId">구를 먼저 선택하세요!</option></select>
				</div>
			</div>
			<br/> 
			
			<div align="center">
				<table>
				<tr><th style="border: solid 1px gray; padding: 10px;">대분류</th><td style="border: solid 1px gray; padding: 10px;">
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="한식">한식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="일식">일식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="중식">중식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="양식">양식</label>
				<label class="checkbox-inline"><input type="checkbox" name="restBgTag" value="동남아">동남아</label>
				</td></tr>
				<tr><th style="border: solid 1px gray; padding: 10px;">중분류</th><td style="border: solid 1px gray; padding: 10px;">
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="고기류">고기류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="어폐류">어폐류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="채소류">채소류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="면류">면류</label>
				<label class="checkbox-inline"><input type="checkbox" name="restMdTag" value="밥류">밥류</label>
				</td></tr>
				<tr><th style="border: solid 1px gray; padding: 10px;">관리여부</th><td style="border: solid 1px gray; padding: 10px;">
				<label class="radio-inline"><input type="radio" name="restManager" value="all" checked>전체</label>
				<label class="radio-inline"><input type="radio" name="restManager" value="admin">관리자 관할 음식점</label>
				<label class="radio-inline"><input type="radio" name="restManager" value="notAdmin">업주관리 음식점</label><!-- userSeq가 관리자가 아닌 매장 -->
				</td></tr>
				<tr><th style="border: solid 1px gray; padding: 10px;">삭제여부</th><td style="border: solid 1px gray; padding: 10px;"> 
				<label class="radio-inline"><input type="radio" name="restStatus" value="all" checked>전체</label>
				<label class="radio-inline"><input type="radio" name="restStatus" value="0">이용 가능 음식점</label>
				<label class="radio-inline"><input type="radio" name="restStatus" value="1">삭제된 음식점</label>
				</td></tr>
				</table>
			</div>
		</form>
		<br/> 
		<div id="map" style="width:100%;height:500px;"></div>
	</div>
	
</div>
<%-- subrightCon --%>

<!-- 업장수정차을 post방식으로 열기위한 form --> 
<div id="editFrmDiv">
	<form name="editFrm">
		<input type="hidden" name="restSeq"/>
	</form>
</div>

<script>
	
	$(document).ready(function(){
		//페이지 최초로딩시 등록된 음식점 모두 띄우기
		//getRestaurant();
		
		getGuMetroNameList();
		
		$("#selMenu_guName").change(function(){
			getDongNameList();
		});
		
		// 체크박스 및 라디오 박스의 값이 변할 때 마다 함수 getRestaurant() 호출한다. 사용자 경험을 위해 데이터를 희생하자. 
		$("[name=restBgTag]").change(function(){
			getRestaurant();
		});
		
		$("[name=restMdTag]").change(function(){
			getRestaurant();
		});
		
		$("[name=restManager]").change(function(){
			getRestaurant();
		});
		
		$("[name=restStatus]").change(function(){
			getRestaurant();
		});

		$("#selMenu_metroName").change(function(){
			getRestaurant();
		});
		
		$("#selMenu_guName").change(function(){
			getRestaurant();
		});
		
		$("#selMenu_dongName").change(function(){
			getRestaurant();
		});
		
		
		
		
		var map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
	        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
	        level : 8// 지도의 확대 레벨 
	    });
		
		(function($){
		$("#adminKeyword").keyup(function(){
			
			//alert($("#adminKeyword").val());
			var srchType = $("[name=srchType]").val();
		
			$.ajax({
				url:"<%=request.getContextPath()%>/autoComplete.eat",
				type :"GET",
				data: "srchType="+srchType+"&keyword="+$("#adminKeyword").val(),
				dataType:"json",
				success: function(data){
					//alert(data.cat_autoComSource);
					
					// 카테고리 auto-complete 인경우
					if(data.autoComSource == null){
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
						
						$("#adminKeyword").catcomplete({
							delay : 0,
							source : data.cat_autoComSource
						})						
					} else {// 일반 auto-complete인 경우
						//alert(2);
						$("#adminKeyword").autocomplete({
							source : data.autoComSource
						})	
					}
					
				}, //end of success: function(data)
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error: function(request,status,error)
			}); //end of $.ajax()
			
			
		});// end of $("#adminKeyword").keyup
	})(jQuery)
			
	});
	
	// 업장 수정을 post방식으로 popup창을 연다.
	function goEdit(restSeq) {
		
		var url = "<%=request.getContextPath()%>/adminRestEdit.eat";
		var title = "adminRestEdit";
		var status = "left=500px, top=100px, width=600px, height=915px, menubar=no, status=no, scrollbars=yes ";
		var popup = window.open(url, title, status); 
		
        editFrm.restSeq.value = restSeq;
        editFrm.target = title;
        editFrm.action = url;
        editFrm.method = "post";
        editFrm.submit();
	}
	
	// input 태그 엔터키 refresh 방지
	function goButton() {
		 if (event.keyCode == 13) {
		 	getRestaurant();
		  	return false;
		 }
		 return true;
	}
	
	var map, clusterer;
	
	// 업장 검색 함수
	function getRestaurant(){
	
		//alert( $("#selMenu_metroName").val()+" , "+$("#selMenu_dongName").val()+" , "+$("#selMenu_guName").val());
		//alert($("[name=restTag]:checked").length);
		
		
		var metroId = $("#selMenu_metroName").val()
			, dongId = $("#selMenu_dongName").val()
		    , guId = $("#selMenu_guName").val();	
	
		var restBgTagArr = [], restMdTagArr = [];
	    $("[name=restBgTag]:checked").each(function(i){
	    	//alert($(this).val());
	    	restBgTagArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	    });
	    
	    $("[name=restMdTag]:checked").each(function(i){
	    	//alert($(this).val());
	    	restMdTagArr.push($(this).val());     // 체크된 것만 값을 뽑아서 배열에 push
	    });
		//alert( $("[name=restManager]:checked").val());
		
		var srchFrmData = {
			srchType : $("#srchType").val()
		  , keyword : $("#adminKeyword").val()
		  , dongId : dongId
		  , metroId : metroId
		  , guId : guId
		  , restBgTag : restBgTagArr
		  , restMdTag : restMdTagArr
		  , restManager : $("[name=restManager]:checked").val()
		  , restStatus : $("[name=restStatus]:checked").val()
		}
		
	 
	    // 데이터를 가져오기 위해 jQuery를 사용합니다
	    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	    $.ajaxSettings.traditional = true;
	    $.ajax({
			url: "<%=request.getContextPath()%>/getRestaurantList.eat",  
			//async: false, 
			data: srchFrmData,
			dataType: "json",
			beforeSend:function(){
			   	 //alert('start');
		    	wrapWindowByMask();
		    },
		    complete:function(){
		    	//alert('complete');
		    	closeWindowByMask();
		 
		    }, 
			success: function(data) {
				//alert(data.positions[0].restName);
				
				if(data.positions.length == 0){
					alert('검색된 음식점이 없습니다. 검색조건을 확인해주세요!');
					return;
				}
				
				// 검색조건이 없을 때에는 기존의 마커들을 유지 하기 위햐여 지도 객체를 success 함수 안에 위치 시켰다. 전역변수화
				map = new daum.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
			        center : new daum.maps.LatLng(37.515812, 126.982340), // 지도의 중심좌표 
			        level : 8// 지도의 확대 레벨 
			    });
				
			    
			    // 마커 클러스터러를 생성합니다 
			    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
			    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다 
			    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
			    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다 
			    clusterer = new daum.maps.MarkerClusterer({
			        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			        minLevel: 7, // 클러스터 할 최소 지도 레벨 
			        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다 
			    });
				
			 // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
			    var bounds = new daum.maps.LatLngBounds();    
			    
			    
				var markers = $(data.positions).map(function(i, position) {
	        	//alert(i+" : "+position.lat+", "+position.lng+", "+position.restName);
		        	
				// 마커를 생성합니다
			    var marker = new daum.maps.Marker({
			        position:  new daum.maps.LatLng(position.restLatitude, position.restLongitude)// 마커의 위치
			    });
				
			    // LatLngBounds 객체에 좌표를 추가합니다
			    bounds.extend(marker.getPosition());

				 // 커스텀 오버레이에 표시할 컨텐츠 입니다
				 // 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
				 // 별도의 이벤트 메소드를 제공하지 않습니다 
				 var content = '<div class="wrap">' + 
							             '    <div class="info">' + 
							             '        <div class="title">' + position.restName+ '('+position.restSeq+')'+
							             /* '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +  */
							             '        </div>' + 
							             '        <div class="body">' + 
							             '            <div class="img">' +
							             '                <img src="<%=request.getContextPath()%>/files/'+position.restImg+'" width="73" height="70">' +
							             '           </div>' + 
							             '            <div class="desc"><div class="ellipsis">'; 
							             
				if (position.restBgTag) {
					content += '                <span style="color:#ff6600; font_size: 14px;">'+position.restBgTag+'</span>&nbsp;';
				}		
				if (position.restMdTag) {
					content += '<span style="color:#80b3ff; font_size: 11px;">'+position.restMdTag+'</span>' ;  
				}
					  
							            
					   content += '                </div>'+
					   					 '<div class="ellipsis"><span style="color: #000099; font-weight:bold;">'+position.guName+'</span>&nbsp<span style="color: #b3b3ff; font-weight: bold;">'+position.dongName+'</span></div>' + 
							             '                <div class="jibun ellipsis">'+position.restPhone+'</div>' + 
							             '                <div>마커를 <span style="color:red">클릭</span>해서 음식점 정보를 수정하기</div>' + 
							             '            </div>' + 
							             '        </div>' + 
							             '    </div>' +    
							             '</div>';

					//alert(marker.getPosition());
				 
					// 마커 위에 커스텀오버레이를 표시합니다
				 // 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
				 var overlay = new daum.maps.CustomOverlay({
				     content: content,
				     //map: map, //overlay에는 생성시에 map 옵션 지정하지 말것. 
				     position: marker.getPosition()       

				 }); // end of $(data.positions).map()


				    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
				    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
				    (function(marker, overlay) {
				        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
				        daum.maps.event.addListener(marker, 'mouseover', function() {
				        	overlay.setMap(map);
				        });

				        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
				       daum.maps.event.addListener(marker, 'mouseout', function() {
				        	closeOverlay();
				        }); 
				        
				        
				        // 마커를 클릭하면 해당 업장 상세페이지로 이동한다.
				       daum.maps.event.addListener(marker, 'click', function() {
				    	   	//closeOverlay();
				    	   	goEdit(position.restSeq);
				    	   	
				        }); 
				 
				        
				        // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
				        function closeOverlay() {
				            overlay.setMap(null);     
				        }
				        
				    })(marker, overlay);
		        	
				    return marker;
				    
		        });

		        // 클러스터러에 마커들을 추가합니다
		        clusterer.addMarkers(markers);
				
		        setBounds(bounds);
				}
			    
		});//end of $.ajax()
	    

	    // 마커 클러스터러에 클릭이벤트를 등록합니다 
	    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우 
	    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다 
	    daum.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {

	        // 현재 지도 레벨에서 1레벨 확대한 레벨 
	        var level = map.getLevel()-1;

	        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다 
	        map.setLevel(level, {anchor: cluster.getCenter()});  
	    });
		
	}//end of getRestaurant()
	
	
	//ajax 로딩 이미지 관련
	function wrapWindowByMask() {
		//alert("wrapWindowByMask()");
        //화면의 높이와 너비를 구한다.
        var maskHeight = $(document).height();  
		//var maskWidth = $(document).width();
        var maskWidth = window.document.body.clientWidth;
         
        var mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
        var loadingImg = '';
         
        loadingImg += "<div id='loadingImg' style='position:absolute; left:50%; top:220px; display:none; z-index:10000;'>";
        loadingImg += "<img src='<%=request.getContextPath()%>/resources/images/squares.gif'/>"; 
        loadingImg += "</div>";   
     
        //화면에 레이어 추가 
        $('#map')
            .append(mask)
            .append(loadingImg)
           
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({
                'width' : maskWidth
                , 'height': maskHeight
                , 'opacity' : '0.3'
        });  
     
        //마스크 표시, 로딩중 이미지 표시
        $('#mask').show();    
        $('#loadingImg').show();
    }
	
	function closeWindowByMask() {
		//alert('closeWindowByMask()');
        $('#mask, #loadingImg').hide();
        $('#mask, #loadingImg').remove();   
    } 
	
	function setBounds(bounds) {
	    // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
	    // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
	    map.setBounds(bounds);
	}
	
	// 구이름/지하철이름 셀렉트 메뉴 호출
	function getGuMetroNameList(){
		
		$.ajax({
				url:"<%=request.getContextPath()%>/adminGuMetroNameList.eat",
				type :"GET",
				dataType:"json",
				success: function(data){
							var guNameList = data.guNameList;
							var metroNameList = data.metroNameList;
							
							var guNameHtml = '<option value="guId">구 선택하기</option>';
							var metroNameHtml = '<option value="metroId">지하철 선택하기</option>';
							
							for (var i = 0; i < guNameList.length; i++) {
									guNameHtml += '<option value="'+guNameList[i].guId+'">'+guNameList[i].guName+'</option>';
							}
							
							$("#selMenu_guName").html(guNameHtml);
							
							for (var i = 0; i < metroNameList.length; i++) {
								metroNameHtml += '<option value="'+metroNameList[i].metroId+'">'+metroNameList[i].metroName+'</option>';				
							}
							$("#selMenu_metroName").html(metroNameHtml);
							
				}, //end of success: function(data)
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error: function(request,status,error)
			}); //end of $.ajax()
	}
	
	// 동이름 셀렉트 메뉴 호출
	function getDongNameList(){
		
		$.ajax({
				url:"<%=request.getContextPath()%>/adminDongNameList.eat",
				type :"GET",
				data: "guId="+$("#selMenu_guName").val(),
				dataType:"json",
				success: function(data){
							var dongNameList = data.dongNameList;
							
							var dongNameHtml = '<option value="dongId">동 선택하기</option>';
							
							for (var i = 0; i < dongNameList.length; i++) {
									dongNameHtml += '<option value="'+dongNameList[i].dongId+'">'+dongNameList[i].dongName+'</option>';
							}
							
							$("#selMenu_dongName").html(dongNameHtml);
				}, //end of success: function(data)
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				} // end of error: function(request,status,error)
			}); //end of $.ajax()
	}
    
</script>
<jsp:include page="../footer.jsp" />