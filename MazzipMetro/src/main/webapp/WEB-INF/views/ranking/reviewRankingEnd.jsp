<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	$(document).ready(function(){
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
	                 
					 alert(metroId);
		                 
	                 // we set a variable so the data is only loaded once via Ajax, not every time the tooltip opens
	                 if ($origin.data('loaded') !== true) {
						 $.get('<%=request.getContextPath()%>/dd.eat', function(data) {

							 //중복 호출을 막기위해 : metroIdArr에 해당 metroId push하
							 
			                // call the 'content' method to update the content of our tooltip with the returned data.
			                // note: this content update will trigger an update animation (see the updateAnimation option)
			                instance.content(data);

			                // to remember that the data has been loaded
			                $origin.data('loaded', true);
				            },'html');
	                 }
	             }// end of functionBefore
        });
	});
</script>

<c:if test="${mapList == null || empty mapList}">
	<table id = "tblRankingView">
		<tr style = "border-left-width: 0px; border-right-width: 0px;">
			<td><span style = "margin-top: 50px; font-size: 20pt; font-weight: bold; ">검색결과가 존재하지 않습니다</span></td>
		</tr>
	</table>
</c:if>

<c:if test="${mapList != null && not empty mapList}">
	<table id = "tblRankingView">
		<c:forEach var = "list" items = "${mapList}" begin="${pageNum*pageBar-10}" end="${pageNum*pageBar-1}">
			<tr style = "border-left-width: 0px; border-right-width: 0px;">
				<td width = "10%" ><span style = "font-size: 15pt; font-weight: bold;">${list.rank}</span></td>
				<td width = "20%" style = "border-left-width: 0px;"><img width = "70px" src="<%= request.getContextPath() %>/${list.userProfile}" /></td>
				<td width = "30%" class = "tooltip_group tooltipster_top" style = "border-left-width: 0px; font-size : 12pt; font-weight: bold;">${list.userEmail}</td>
				<td width = "20%" style = "border-left-width: 0px; font-size : 12pt;">${list.userName}</td>
				<td width = "10%" style = "border-left-width: 0px;">${list.gradeName}</td>
			</tr>
		</c:forEach>
	</table>
	<div align = "center">
		<table>
			<tr >
				<td style = "font-size : 15pt;">${html}</td>
			</tr>
		</table>	
	</div>
</c:if>
