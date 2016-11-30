<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 크기 통일되게 맞추기</title>

<style>
    body, button { font-family: 맑은 고딕; font-size: 11pt; text-decoration: none; }

   li { float: left; margin-right: 50px; list-style: none; }
   li > div { border: solid 3px blue; }
   
   /* 아래 세 줄이 중요한 스타일임 */
   div.aspect_1_1 { width: 180px; height: 180px; }
   div.aspect_4_3 { width: 200px; height: 175px; }
   div.aspect_4_5 { width: 180px; height: 200px; }
   
   .clearfix:after {
      content: " ";
      visibility: hidden;
      display: block;
      height: 0;
      clear: both;
   }
</style> 

<script type="text/javascript">
   window.onload = function() {
     var divs = document.querySelectorAll('li > div');
     for (var i = 0; i < divs.length; ++i) {
       var div = divs[i];
       var divAspect = div.offsetHeight / div.offsetWidth;
       div.style.overflow = 'hidden';
       
       var img = div.querySelector('img');
       var imgAspect = img.height / img.width;

       if (imgAspect <= divAspect) {
         // 이미지가 div보다 납작한 경우 세로를 div에 맞추고 가로는 잘라낸다
         var imgWidthActual = div.offsetHeight / imgAspect;
         var imgWidthToBe = div.offsetHeight / divAspect;
         var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2)
         img.style.cssText = 'width: auto; height: 100%; margin-left: '
                         + marginLeft + 'px;'
       } else {
         // 이미지가 div보다 길쭉한 경우 가로를 div에 맞추고 세로를 잘라낸다
         img.style.cssText = 'width: 100%; height: auto; margin-left: 0;';
       }
     }
     
     var btn = document.querySelector('#btnToggleOverflow');
     btn.onclick = function() {
       var val = divs[0].style.overflow == 'hidden' ? 'visible' : 'hidden';
       for (var i = 0; i < divs.length; ++i)
         divs[i].style.overflow = val;
     };
   };
</script>
</head>
<body>
<h1>이미지의 가로세로비를 유지하면서 틀 안에 맞추기</h1>

<h2>세로로 긴 이미지 맞추기</h2>
<ul class="clearfix">

   <c:forEach var="image" items="${imageList}">
   <li>
       <p>1:1 비율</p>
       <div class="aspect_1_1"><img src="<%=request.getContextPath() %>/resources/images/${image.orgFileName}"></div>
     </li>
     <li>
       <p>4:3 비율</p>
       <div class="aspect_4_3"><img src="<%=request.getContextPath() %>/resources/images/${image.orgFileName}"></div>
     </li>
     <li>
       <p>4:5 비율</p>
       <div class="aspect_4_5"><img src="<%=request.getContextPath() %>/resources/images/${image.orgFileName}"></div>
     </li>
     <br><br>
   </c:forEach>
</ul>
<button id="btnToggleOverflow" type="button">이미지 자름 토글</button>


</body>
</html>