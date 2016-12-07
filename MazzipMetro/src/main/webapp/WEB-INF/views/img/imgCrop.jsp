<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="no-js">
	<head>
		<meta charset="UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
		<meta name="viewport" content="width=device-width, initial-scale=1"> 
		<title>Image Resizing with Canvas</title>
		<meta name="description" content="Learn how to resize images using JavaScript and the HTML5 Canvas element using controls, commonly seen in photo editing applications." />
		<meta name="keywords" content="canvas, javascript, HTML5, resizing, images" />
		<meta name="author" content="Codrops" />
		<link rel="shortcut icon" href="../favicon.ico">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/imgTest/css/normalize.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/imgTest/css/demo.css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/imgTest/css/component.css" />
		
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
		<link  href="<%=request.getContextPath() %>/resources/dist/cropper.css" rel="stylesheet">
		<script src="<%=request.getContextPath() %>/resources/dist/cropper.js"></script>
		<!--[if IE]>
  		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		
		<script type="text/javascript">
		$('#image').cropper({
			  aspectRatio: 16 / 9,
			  crop: function(e) {
			    // Output the result data for cropping image.
			    console.log(e.x);
			    console.log(e.y);
			    console.log(e.width);
			    console.log(e.height);
			    console.log(e.rotate);
			    console.log(e.scaleX);
			    console.log(e.scaleY);
			  }
			});
		</script>
		
		<style type="text/css">
		/* Limit image width to avoid overflow the container */
		img {
		  max-width: 100%; /* This rule is very important, please do not ignore this! */
		}
		</style>
	</head>
	<body>
	
		<!-- Wrap the image or canvas element with a block element (container) -->
		<div>
		  <img id="image" src="http://d.pr/i/qk2H">
		</div>
		
		
		<div class="container">
			<!-- Top Navigation -->
			<div class="codrops-top clearfix">
				<a class="codrops-icon codrops-icon-prev" href="http://tympanus.net/Development/WobblySlideshowEffect/"><span>Previous Demo</span></a>
				<span class="right"><a class="codrops-icon codrops-icon-drop" href="http://tympanus.net/codrops/?p=20603"><span>Back to the Codrops Article</span></a></span>
			</div>
			<div class="content">
				<header class="codrops-header">
					<h1>Image Resizing &amp; Cropping <br /><span>with Canvas</span></h1>
				</header>
				<div class="component">
					<div class="overlay">
						<div class="overlay-inner">
						</div>
					</div>
					<!-- This image must be on the same domain as the demo or it will not work on a local file system -->
					<!-- http://en.wikipedia.org/wiki/Cross-origin_resource_sharing -->
					<img class="resize-image" src="<%=request.getContextPath() %>/resources/imgTest/img/image.jpg" alt="image for resizing">
					<button class="btn-crop js-crop">Crop<img class="icon-crop" src="<%=request.getContextPath() %>/resources/imgTest/img/crop.svg"></button>
				</div>
				<div class="a-tip">
					<p><strong>Hint:</strong> hold <span>SHIFT</span> while resizing to keep the original aspect ratio.</p>
				</div>
				<p>Image by <a href="https://www.flickr.com/photos/janoma/4492768410">Alejandro Mallea</a></p>
			</div><!-- /content -->
			
		</div> <!-- /container -->
		<%-- <script src="<%=request.getContextPath() %>/resources/imgTest/js/jquery-2.1.1.min.js"></script>
		<script src="<%=request.getContextPath() %>/resources/imgTest/js/component.js"></script> --%>
	</body>
</html>