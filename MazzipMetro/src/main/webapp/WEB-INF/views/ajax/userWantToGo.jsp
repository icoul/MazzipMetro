<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />

<script>
$(document).ready(function(){
	
	$(".marked").hide();

	// 분명 String[] 타입으로 세션에 담았지만, 문자열 객체로 전달되었고, 배열이 아니다.....
	<c:if test="${not empty sessionScope.userWantToGoChk}">
	var userWantToGoChk = '${sessionScope.userWantToGoChk[0]}'.split(',');
	
	//alert('${sessionScope.userWantToGoChk[0]}');
	//alert("userWantToGoChk[0] = "+userWantToGoChk[0]+" ,userWantToGoChk[1]="+userWantToGoChk[1]);
	
	for (var i = 0; i < userWantToGoChk.length; i++) {
		$("[name=wantToGoChk]").each(function(){
			
			if($(this).val() == userWantToGoChk[i]){
				var imgId = 'img_'+$(this).val();       
			    var markId ='mark_'+$(this).val();
			    
				$(this).attr('checked', true);
				$("#"+imgId).css('opacity', '0.3');
		        $("#"+markId).show();
			}
		});
		
	}
	</c:if>
	
	// 가고싶다 최초 오픈시 모두 선택되지 않았다면, 모두선택버튼을 보여준다.
	//alert($("[name=wantToGoChk]").length+' ' + $("[name=wantToGoChk]:checked").length);
	
	if($("[name=wantToGoChk]").length == $("[name=wantToGoChk]:checked").length){
		$("#btnSelectAll").hide();
		$("#btnSelectNone").show();		
	}else {
		$("#btnSelectAll").show();
		$("#btnSelectNone").hide();		
	}  
	
	/* $('input:checkbox').click(function(){    
		
		if($("[name=wantToGoChk]").length == $("[name=wantToGoChk]:checked").length){
			$("#btnSelectAll").hide();
			$("#btnSelectNone").show();		
		}else {
			$("#btnSelectAll").show();
			$("#btnSelectNone").hide();		
		} 
	
	    var imgId = 'img_'+$(this).attr('id').substring(4);              
	    var markId ='mark_'+$(this).attr('id').substring(4);
	    
	    //alert(imgId);
	    if( $(this).is(':checked')) {
	          $("#"+imgId).css('opacity', '0.3');
	          $("#"+markId).show();
	        } else {
	           $("#"+imgId).css('opacity', '1');
	           $("#"+markId).hide();
	         }             
	}); */
	
	$('.tooltipster').tooltipster({
		animation: 'grow',
		animationDuration: 200,
		distance : 3,
	   	delay: 0,
	   	side: 'left',
	   	interactive: true,
	   	theme: 'tooltipster-noir',
	   	trigger: 'hover'
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
	
	// 페이지 이동시 체크박스가 해제되는 것을 방지하기 위해서 session을 이용한다.
	$("[name=wantToGoChk]").change(function(){
		
		if($("[name=wantToGoChk]").length == $("[name=wantToGoChk]:checked").length){
			$("#btnSelectAll").hide();
			$("#btnSelectNone").show();		
		}else {
			$("#btnSelectAll").show();
			$("#btnSelectNone").hide();		
		} 
	
	    var imgId = 'img_'+$(this).attr('id').substring(4);              
	    var markId ='mark_'+$(this).attr('id').substring(4);
	    
	    if( $(this).is(':checked')) {
          $("#"+imgId).css('opacity', '0.3');
          $("#"+markId).show();
        } else {
           $("#"+imgId).css('opacity', '1');
           $("#"+markId).hide();
         } 
		
		sendUserWantToGoChk();
		
	});
	
}); // end of $(document).ready()


//모두 선택 버튼
function selectAll(){
	// 자바 1.6버젼이후로 defaultChecked, defautlSelected 에 대해서는 prop속성을 사용해야한다.
	$("[name=wantToGoChk]").prop('checked', true);
	
	
	$("[name=wantToGoChk]").each(function(){
		var imgId = 'img_'+$(this).attr('id').substring(4);              
	    var markId ='mark_'+$(this).attr('id').substring(4);
	    $("#"+imgId).css('opacity', '0.3');
	    $("#"+markId).show();
	});
	$("#btnSelectAll").hide();
	$("#btnSelectNone").show();
	
	sendUserWantToGoChk();
}

//모두 선택 버튼 해제
function selectNone(){
	$("[name=wantToGoChk]").prop('checked', false);
	
	$("[name=wantToGoChk]").each(function(){
		var imgId = 'img_'+$(this).attr('id').substring(4);              
	    var markId ='mark_'+$(this).attr('id').substring(4);
	    $("#"+imgId).css('opacity', '1');
	    $("#"+markId).hide();
	});
	$("#btnSelectNone").hide();
	$("#btnSelectAll").show();
	
	sendUserWantToGoChk();
}

function sendUserWantToGoChk(){
	//alert(1);
	
	var userWantToGoChk = [];
	
	$("[name=wantToGoChk]:checked").each(function(){
		userWantToGoChk.push($(this).val());
	});
	
	$.ajax({
		url: "<%=request.getContextPath()%>/userWantToGoChk.eat", 
		method:"GET",  		 // method
		data: "userWantToGoChk="+userWantToGoChk,
		traditional: true,		 // 배열 데이터 전송용
		success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
			//alert(2);
			}
	});//end of $.ajax()
}

// 결정장애용, 맛집메트로 대리 추천...
function mazzipMetroPick () {
	if($("[name=wantToGoChk]:checked").length < 2){
		alert("후보 음식점을 두개이상 선택하세요.");
		return;
	}
	
	alert('음...저희가 드리는 추천은요....');
	
	var mazzipMetroPickArr = [];
	
	$("[name=wantToGoChk]:checked").each(function(){
		mazzipMetroPickArr.push($(this).val());
	});
	
	var num = mazzipMetroPickArr.length;
	
	var result = Math.floor(Math.random() * num+0);//mazzipMetroPickArr 배열의 random index값 반환
	
	var mazzipMetroRecom = $("#recommdation_"+mazzipMetroPickArr[result]).text();
	
	var bool;
	
	var mazzipMetroPick = setTimeout(function() {
		bool = confirm(mazzipMetroRecom+"에 가서 한번 드셔보시겠습니까?");
		
		if(bool){
		//alert(mazzipMetroPickArr[result]);
			$.ajax({
				url: "<%=request.getContextPath()%>/mazzipMetroPick.eat", 
				method:"POST",  		 // method
				data: "restSeq="+mazzipMetroPickArr[result],
				dataType: "JSON",        // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
				success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수

						alert(data.msg);
						getUserWantToGo();
					}
			});//end of $.ajax()
		}
	}, 3000);

	
}


</script>


<c:if test="${empty list}">
<br/><br/><span style="color: #818181; text-decoration: underline;">가고 싶은 음식점을 담아보세요.</span><br/><br/> 
</c:if>

<c:if test="${not empty list}">
<table style="width: 450px;position: relative; border: solid gray 0px;">
<tr>
	<td style="padding: 30px; width: 60%;">
		<button type="button" onclick="mazzipMetroPick();" class="btn btn-default btn-xs">못고르겠어요ㅠㅜ 맛집 메트로가 골라주세요!</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</td>
	<td align="center" style="width: 35%;">
		<button type="button" id="btnSelectAll" onclick="selectAll();" class="btn btn-default btn-xs" style="border:1px solid gray;">모두선택</button>
		<button type="button" id="btnSelectNone" onclick="selectNone();" class="btn btn-default btn-xs" style="border:1px solid gray;">모두선택해제</button>
		<button type="button" onclick="goDel();" class="btn btn-danger btn-xs">선택삭제</button>
	</td>
</tr>

	<c:forEach var="restvo" items="${list}" varStatus="status">
		<tr>
			<td>
				<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${restvo.restSeq}"  style="color:black; text-decoration: none;">
					<span style='font-weight:bold; font-size:18px;' id="recommdation_${restvo.restSeq}">${restvo.restName}</span> <br/> 
					<span style="color:#0066ff; font-size:14px;">${restvo.restBgTag}</span> <br/> 
					<span style="color:#3333ff; font-size:12px;">${restvo.restMdTag}</span>
				</a>
			</td>
			<td>
				<div style="position: relative; height: 110px;">
					<input type="checkbox" id="chk_${restvo.restSeq}" name="wantToGoChk"  style="display: none;" value="${restvo.restSeq}"/>
					<label for="chk_${restvo.restSeq}">
						<img class="marked" id="mark_${restvo.restSeq}" src="<%=request.getContextPath()%>/resources/images/marked.png" style="position: absolute; left:20%; top: 20%; width: 50px;" >
						<img id="img_${restvo.restSeq}" src="<%=request.getContextPath()%>/files/rest/${restvo.restImg}" style="position: absolute; width: 100px;" class='tooltipster tooltip_group' title="사진을 클릭해서 선택하세요!">
					</label>
				</div>
			</td>
		</tr>
	</c:forEach>
</table>

</c:if>