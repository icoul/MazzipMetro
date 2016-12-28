<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<!-- 메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />

<style>
/* 체크박스 대신 체크문자 사용하기 */
input[name=wantToGoChk] {  
    display: none;  
}

/* ex) div + p	  Selects all <p> elements that are placed immediately after <div> elements*/
input[name=wantToGoChk] + label{
    display: inline-block;  
    cursor: pointer;  
    position: relative;  
    padding-left: 25px;  
    margin-right: 15px;  
}

/* unchecked */
input[name=wantToGoChk]+ label:before {     

    content: ""; 
    display: inline-block;  
    width: 29px;  
    height: 18px;  
    margin-right: 10px;  
    position: absolute;  
    left: 0;  
}

/* checked */
input[name=wantToGoChk]:checked + label:before { 

    content: "\2713";  /* 체크모양 */
    text-shadow: 1px 1px 1px rgba(0, 0, 0, .2);  
    font-size: 34px; 
    font-weight:800; 
    color: red;
    width: 29px;  
    height: 18px; 
    text-align: center; 
    line-height: 20px;  
    left: 93px;
    top: 1px;

} 

</style>

<script>
$(document).ready(function(){
	
	/* td를 클릭해도 checkbox가 체크되도록 하자 */	
	$(".td_wantToGo").click(function(){
		
		var bool = $(this).find("input:checkbox").prop("checked");
		if(bool){
			$(this).find("input:checkbox").prop("checked",false);
		} else {
			$(this).find("input:checkbox").prop("checked", true);
		}
		wantToGoChkCheck();
		
	});

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
		
		wantToGoChkCheck();
	});
	
}); // end of $(document).ready()

//가고싶다 삭제 함수
function goDel(){
	if($("[name=wantToGoChk]:checked").length == 0){
		alert('삭제할 음식점을 먼저 선택해주세요!');
		return;
	}
	
	//폼전송 : ajax로 대여진행한 후에, 가고싶다 정보 갱신...
	//배열은 변수에 담기
	var wantToGoChkArr = [];
	
	$("[name=wantToGoChk]:checked").each(function(){
		wantToGoChkArr.push($(this).val());
		
		// 가고싶다 상단 배너 별 active 클래스 제거
		if($(this).val() == "<%=session.getAttribute("reference_restSeq_wantToGo")%>"){
				$("#btn_restDetailWantToGo").removeClass("active");
			}
		// 업장상세 페이지 별 active 클래스 제거
		if($(this).val() == "<%=session.getAttribute("restSeq_wantToGoContentView")%>"){
			$("#btn_wantToGo_contentView").removeClass("active");
		}
	
		
	});
	
	//alert(wantToGoChkArr);
	
	var delWantToGoFrmData = {
			wantToGoChk: wantToGoChkArr 
	}
	
	$.ajax({
		url: "<%=request.getContextPath()%>/delWantToGo.eat", 
		method:"POST",  		 // method
		data: delWantToGoFrmData,
		traditional: true,		 // 배열 데이터 전송용
		dataType: "JSON",        // 위의 URL 페이지로 사용자가 보내는 ajax 요청 데이터.
		success: function(data) {// 데이터 전송이 성공적으로 이루어진 후 처리해줄 callback 함수
				alert(data.msg);
				sendUserWantToGoChk_reset();
				getUserWantToGo();
			}
	});//end of $.ajax()
	
}

function wantToGoChkCheck() {
	if($("[name=wantToGoChk]").length == $("[name=wantToGoChk]:checked").length){
		$("#btnSelectAll").hide();
		$("#btnSelectNone").show();		
	}else {
		$("#btnSelectAll").show();
		$("#btnSelectNone").hide();		
	} 
	
	sendUserWantToGoChk();
}
//모두 선택 버튼
function selectAll(){
	// 자바 1.6버젼이후로 defaultChecked, defautlSelected 에 대해서는 prop속성을 사용해야한다.
	$("[name=wantToGoChk]").prop('checked', true);
	
	
	$("[name=wantToGoChk]").each(function(){
		var imgId = 'img_'+$(this).attr('id').substring(4);              
	    var markId ='mark_'+$(this).attr('id').substring(4);
	   /*  $("#"+imgId).css('opacity', '0.3');
	    $("#"+markId).show(); */
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
	    /* $("#"+imgId).css('opacity', '1');
	    $("#"+markId).hide(); */
	});
	$("#btnSelectNone").hide();
	$("#btnSelectAll").show();
	
	sendUserWantToGoChk();
}

function sendUserWantToGoChk(){
	
	var userWantToGoChk = [];
	
	$("[name=wantToGoChk]:checked").each(function(){
		userWantToGoChk.push($(this).val());
	});
	//alert('sendUserWantToGoChk 실행 : '+userWantToGoChk);
	
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

// 선택 삭제후 리셋용
function sendUserWantToGoChk_reset(){
	
	var userWantToGoChk = [];
	
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
		<button type="button" onclick="mazzipMetroPick();" class="btn btn-default btn-xs">못고르겠어요ㅠㅜ 맛집 메트로가 골라주세요!</button>
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
			
			<td class="td_wantToGo" style="cursor: pointer; margin-bottom: 5px; background-position: center; background-repeat: no-repeat; background-size: 100px; ; background-image: url('<%=request.getContextPath()%>/files/rest/${restvo.restImg}');">
					<input type="checkbox" id="chk_${restvo.restSeq}" name="wantToGoChk"  style="display: none;" value="${restvo.restSeq}"/>
					<label for="chk_${restvo.restSeq}"></label>
					
				<%-- <div style="position: relative; height: 110px;">
					<input type="checkbox" id="chk_${restvo.restSeq}" name="wantToGoChk"  style="display: none;" value="${restvo.restSeq}"/>
					<label for="chk_${restvo.restSeq}">
						<img class="marked" id="mark_${restvo.restSeq}" src="<%=request.getContextPath()%>/resources/images/marked.png" style="position: absolute; left:20%; top: 20%; width: 50px;" >
						<img id="img_${restvo.restSeq}" src="<%=request.getContextPath()%>/files/rest/${restvo.restImg}" style="position: absolute; width: 100px;" class='tooltipster tooltip_group' title="사진을 클릭해서 선택하세요!">
					</label>
				</div> --%>
			</td>
		</tr>
	</c:forEach>
</table>

</c:if>