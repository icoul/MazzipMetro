<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>Insert title here</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">
  <%-- <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/bootstrap.css"> --%>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/bootstrap.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/star_rating.js"></script>
  <%-- 
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/JqueryUI/styles/jquery-ui.css">
  <script src="<%= request.getContextPath() %>/resources/JqueryUI/uijs/jquery-ui.js"></script> 
  --%>

	

<style type="text/css">

#colorstar { color: #ee8b2d;}
.badForm {color: #FF0000;}
.goodForm {color: #00FF00;}
.evaluation { margin-left:30px;}

</style>
<body>
<section>
<div class="container">
        <h2>Evaluation<small> Description </small></h2>
</div>
<div class="container">
    
    <h3>[Name] Lorem Ipsum</h3>
    <div class="row lead evaluation">
        <div id="colorstar" class="starrr ratable" ></div>
        <span id="count">0</span> star(s) - <span id="meaning"> </span>
            
        
            <div class='indicators' style="display:none">
                <div id='textwr'>What went wrong?</div>
                <input id="rate[]" name="rate[]" type="text" placeholder="" class="form-control input-md" style="display:none;">
                <input id="rating[]" name="rating[]" type="text" placeholder="" class="form-control input-md rateval" style="display:none;">
                
                <span class="button-checkbox">
                <button type="button" class="btn criteria" data-color="info">Punctuallity</button>
                 <input type="checkbox" class="hidden"  />
                </span>
                <span class="button-checkbox">
                <button type="button" class="btn criteria" data-color="info">Assistance</button>
                 <input type="checkbox" class="hidden"  />
                </span>
                <span class="button-checkbox">
                <button type="button" class="btn criteria" data-color="info">Knowledge</button>
                 <input type="checkbox" class="hidden"  />
                </span>
            </div>
            
        
	</div>
    
    
    
    <h3>[Name] Lorem Ipsum</h3>
    <div class="row lead evaluation">
        <div id="colorstar" class="starrr ratable" ></div>
        <span id="count">0</span> star(s) - <span id="meaning"> </span>
            
        
            <div class='indicators' style="display:none"> 
             <div id='textwr'>What went wrong?</div>
            <input id="rate[]" name="rate[]" type="text" placeholder="" class="form-control input-md" style="display:none;">
            <input id="rating[]" name="rating[]" type="text" placeholder="" class="form-control input-md rateval"  style="display:none;">
        
                <span class="button-checkbox">
                <button type="button" class="btn" data-color="info">Punctuallity</button>
                 <input type="checkbox" class="hidden"  />
                </span>
                <span class="button-checkbox">
                <button type="button" class="btn" data-color="info">Assistance</button>
                 <input type="checkbox" class="hidden"  />
                </span>
                <span class="button-checkbox">
                <button type="button" class="btn" data-color="info">Knowledge</button>
                 <input type="checkbox" class="hidden"  />
                </span>
            </div>
            
        
    </div>
    
</div>



</section>

</body>
</html>