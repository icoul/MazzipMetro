<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<style>
/*상속된 css 초기화 */
table#tbl_wantGoContentView td {vertical-align: middle;}
</style>
<table id="tbl_wantGoContentView" style = "width: 100%;">
	<tr style = "height : 35px; background-color: #EFEFEF;">
		<td colspan = "2" style = " vertical-align: middle; padding-left : 15px;"><span style = "font-weight: bold;">이 맛집은 어떠신가요? 맛집메트로의 추천!</span></td>
	</tr>	
	<tr>
		<td style = "padding : 5px; padding-left : 15px; width : 25%; " rowspan="2">
			<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${vo.restSeq}"><img width = "100px;" src="<%= request.getContextPath() %>/files/rest/${vo.restImg}" /></a>
		</td>
		<td style="padding-top: 5px;padding-right: 9px;">
			<!-- 동현_가고싶다 카트 상단의 content view에 가고싶다 버튼 추가 -->
			<button type="button"  onclick="addWantToGo(${vo.restSeq});" class="btnLogin">가고싶다</button>
		</td>
	</tr>
	<tr>	
		<td style = "padding-top : 6px; line-height: 26pt;">
			<a href="<%=request.getContextPath()%>/restaurantDetail.eat?restSeq=${vo.restSeq}" style="color:black; text-decoration: none;">			
			<span style = "font-size: 25pt; font-weight: bold;">${vo.restName}</span><br/>
			<span style = "font-size: 15pt;">${vo.restBgTag}</span>&nbsp;&nbsp;<span style = "font-size: 10pt;">${vo.restMdTag}</span><br/>
			<span style = "font-size: 10pt;">${vo.restContent}</span>
			</a>
		</td>
	</tr>
	<tr>
		<td style = "border-bottom : solid lightgrey 2px;" colspan = "2"></td>
	</tr>
</table>