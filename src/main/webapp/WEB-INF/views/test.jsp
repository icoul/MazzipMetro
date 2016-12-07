<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/test.js"></script>

<link  href="<%= request.getContextPath() %>/resources/css/cropper.css" rel="stylesheet">
<script src="<%= request.getContextPath() %>/resources/js/cropper.js"></script>

<script>
$(document).ready(function(){
	

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
});
</script>

<style>
/*
    All Credit goes to http://fengyuanchen.github.io/cropper
*/

.cropper-container {
  position: relative;
  overflow: hidden;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;

  -webkit-tap-highlight-color: transparent;
  -webkit-touch-callout: none;
}
.cropper-container img {
  display: block;
  width: 100%;
  min-width: 0 !important;
  max-width: none !important;
  height: 100%;
  min-height: 0 !important;
  max-height: none !important;

  image-orientation: 0deg !important;
}
.cropper-canvas,
.cropper-drag-box,
.cropper-crop-box,
.cropper-modal {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
}
.cropper-drag-box {
  background-color: #fff;
  filter: alpha(opacity=0);
  opacity: 0;
}
.cropper-modal {
  background-color: #000;
  filter: alpha(opacity=50);
  opacity: .5;
}
.cropper-view-box {
  display: block;
  width: 100%;
  height: 100%;
  overflow: hidden;
  outline: 1px solid #69f;
  outline-color: rgba(102, 153, 255, .75);
}
.cropper-dashed {
  position: absolute;
  display: block;
  filter: alpha(opacity=50);
  border: 0 dashed #fff;
  opacity: .5;
}
.cropper-dashed.dashed-h {
  top: 33.33333333%;
  left: 0;
  width: 100%;
  height: 33.33333333%;
  border-top-width: 1px;
  border-bottom-width: 1px;
}
.cropper-dashed.dashed-v {
  top: 0;
  left: 33.33333333%;
  width: 33.33333333%;
  height: 100%;
  border-right-width: 1px;
  border-left-width: 1px;
}
.cropper-face,
.cropper-line,
.cropper-point {
  position: absolute;
  display: block;
  width: 100%;
  height: 100%;
  filter: alpha(opacity=10);
  opacity: .1;
}
.cropper-face {
  top: 0;
  left: 0;
  cursor: move;
  background-color: #fff;
}
.cropper-line {
  background-color: #69f;
}
.cropper-line.line-e {
  top: 0;
  right: -3px;
  width: 5px;
  cursor: e-resize;
}
.cropper-line.line-n {
  top: -3px;
  left: 0;
  height: 5px;
  cursor: n-resize;
}
.cropper-line.line-w {
  top: 0;
  left: -3px;
  width: 5px;
  cursor: w-resize;
}
.cropper-line.line-s {
  bottom: -3px;
  left: 0;
  height: 5px;
  cursor: s-resize;
}
.cropper-point {
  width: 5px;
  height: 5px;
  background-color: #69f;
  filter: alpha(opacity=75);
  opacity: .75;
}
.cropper-point.point-e {
  top: 50%;
  right: -3px;
  margin-top: -3px;
  cursor: e-resize;
}
.cropper-point.point-n {
  top: -3px;
  left: 50%;
  margin-left: -3px;
  cursor: n-resize;
}
.cropper-point.point-w {
  top: 50%;
  left: -3px;
  margin-top: -3px;
  cursor: w-resize;
}
.cropper-point.point-s {
  bottom: -3px;
  left: 50%;
  margin-left: -3px;
  cursor: s-resize;
}
.cropper-point.point-ne {
  top: -3px;
  right: -3px;
  cursor: ne-resize;
}
.cropper-point.point-nw {
  top: -3px;
  left: -3px;
  cursor: nw-resize;
}
.cropper-point.point-sw {
  bottom: -3px;
  left: -3px;
  cursor: sw-resize;
}
.cropper-point.point-se {
  right: -3px;
  bottom: -3px;
  width: 20px;
  height: 20px;
  cursor: se-resize;
  filter: alpha(opacity=100);
  opacity: 1;
}
.cropper-point.point-se:before {
  position: absolute;
  right: -50%;
  bottom: -50%;
  display: block;
  width: 200%;
  height: 200%;
  content: " ";
  background-color: #69f;
  filter: alpha(opacity=0);
  opacity: 0;
}
@media (min-width: 768px) {
  .cropper-point.point-se {
    width: 15px;
    height: 15px;
  }
}
@media (min-width: 992px) {
  .cropper-point.point-se {
    width: 10px;
    height: 10px;
  }
}
@media (min-width: 1200px) {
  .cropper-point.point-se {
    width: 5px;
    height: 5px;
    filter: alpha(opacity=75);
    opacity: .75;
  }
}
.cropper-bg {
  background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAAA3NCSVQICAjb4U/gAAAABlBMVEXMzMz////TjRV2AAAACXBIWXMAAArrAAAK6wGCiw1aAAAAHHRFWHRTb2Z0d2FyZQBBZG9iZSBGaXJld29ya3MgQ1M26LyyjAAAABFJREFUCJlj+M/AgBVhF/0PAH6/D/HkDxOGAAAAAElFTkSuQmCC");
}
.cropper-invisible {
  filter: alpha(opacity=0);
  opacity: 0;
}
.cropper-hide {
  position: fixed;
  top: 0;
  left: 0;
  z-index: -1;
  width: auto!important;
  min-width: 0!important;
  max-width: none!important;
  height: auto!important;
  min-height: 0!important;
  max-height: none!important;
  filter: alpha(opacity=0);
  opacity: 0;
}
.cropper-hidden {
  display: none !important;
}
.cropper-move {
  cursor: move;
}
.cropper-crop {
  cursor: crosshair;
}
.cropper-disabled .cropper-drag-box,
.cropper-disabled .cropper-face,
.cropper-disabled .cropper-line,
.cropper-disabled .cropper-point {
  cursor: not-allowed;
}


/*Main CSS*/

.icon {
  display: inline-block;
  width: 20px;
  height: 20px;
  background-image: url("http://fengyuanchen.github.io/cropper/img/icons.png");
  vertical-align: middle;
}

.icon-move {
  background-position: 0 0;
}

.icon-crop {
  background-position: -30px 0;
}

.icon-zoom-in {
  background-position: -60px 0;
}

.icon-zoom-out {
  background-position: -90px 0;
}

.icon-rotate-left {
  background-position: -120px 0;
}

.icon-rotate-right {
  background-position: -150px 0;
}

.icon-lock {
  background-position: -180px 0;
}

.icon-unlock {
  background-position: -210px 0;
}

.icon-remove {
  background-position: -240px 0;
}

.icon-refresh {
  background-position: -270px 0;
}

.icon-upload {
  background-position: -300px 0;
}

.icon-off {
  background-position: -330px 0;
}

.icon-info {
  background-position: -360px 0;
}

.icon-ok {
  background-position: -390px 0;
}


/* Alerts
 * -------------------------------------------------------------------------- */

.docs-alert {
  display: none;
  position: fixed;
  top: 20px;
  left: 0;
  right: 0;
  height: 0;
  text-align: center;
  opacity: 0.9;
}

.docs-alert .message {
  display: inline-block;
  padding: 5px 10px;
  border-radius: 2px;
  background-color: #aaa;
  color: #fff;
}

.docs-alert .primary {
  background-color: #0074d9;
}

.docs-alert .success {
  background-color: #2ecc40;
}

.docs-alert .info {
  background-color: #39cccc;
}

.docs-alert .warning {
  background-color: #ff851b;
}

.docs-alert .danger {
  background-color: #ff4136;
}

/* Button
 * -------------------------------------------------------------------------- */

.btn-primary {
  border-color: #003973; /* hsb(210, 100%, 45%) */
  background-color: #00468c; /* hsb(210, 100%, 55%) */
}

.btn-primary:hover,
.btn-primary:focus,
.btn-primary:active,
.btn-primary.active,
.btn-primary.active:focus,
.btn-primary.active:hover {
  border-color: #00264d; /* hsb(208, 100%, 10%) */
  background-color: #003366; /* hsb(208, 100%, 40%) */
}


/* Basic style
 * -------------------------------------------------------------------------- */

body {
  overflow-x: hidden;
}


/* Header */

.docs-header {
  border-color: #003973;
  background-color: #00468c;
  color: #fff;
}

.docs-header .navbar-brand {
  color: #eee;
}

.docs-header .navbar-toggle {
  border-color: #003973;
  background-color: #00468c;
}

.docs-header .navbar-toggle:hover,
.docs-header .navbar-toggle:focus {
  border-color: #003366;
  background-color: #003973;
}

.docs-header .navbar-collapse {
  border-color: #003973;
}

.docs-header .navbar-text {
  color: #ddd;
}

.docs-header .navbar-nav > li > a {
  color: #eee;
}


/* Content */

.img-container,
.img-preview {
  background-color: #f7f7f7;
  overflow: hidden;
  width: 100%;
  text-align: center;
}

.img-container {
  min-height: 200px;
  max-height: 466px;
  margin-bottom: 20px;
}

@media (min-width: 768px) {
  .img-container {
    min-height: 466px;
  }
}

.img-container > img {
  max-width: 100%;
}

.docs-preview {
  margin-right: -15px;
  margin-bottom: 10px;
}

.img-preview {
  float: left;
  margin-right: 10px;
  margin-bottom: 10px;
}

.img-preview > img {
  max-width: 100%;
}

.preview-lg {
  width: 263px;
  height: 148px;
}

.preview-md {
  width: 139px;
  height: 78px;
}

.preview-sm {
  width: 69px;
  height: 39px;
}

.preview-xs {
  width: 35px;
  height: 20px;
  margin-right: 0;
}

.docs-data > .input-group {
  margin-bottom: 10px;
}

.docs-data > .input-group > label {
  min-width: 80px;
}

.docs-data > .input-group > span {
  min-width: 50px;
}

.docs-buttons > .btn,
.docs-buttons > .btn-group,
.docs-buttons > .form-control {
  margin-right: 5px;
  margin-bottom: 10px;
}

.docs-toggles > .btn,
.docs-toggles > .btn-group,
.docs-toggles > .dropdown {
  margin-bottom: 10px;
}

.docs-tooltip {
  display: block;
  margin: -6px -12px;
  padding: 6px 12px;
}

.docs-tooltip > .icon {
  margin: 0 -3px;
  vertical-align: top;
}

.tooltip-inner {
  white-space: normal;
}

.btn-upload .tooltip-inner {
  white-space: nowrap;
}

@media (max-width: 400px) {
  .btn-group-crop {
    margin-right: -15px!important;
  }

  .btn-group-crop > .btn {
    padding-left: 5px;
    padding-right: 5px;
  }

  .btn-group-crop .docs-tooltip {
    margin-left: -5px;
    margin-right: -5px;
    padding-left: 5px;
    padding-right: 5px;
  }
}

.docs-options .dropdown-menu {
  width: 100%;
}

.docs-options .dropdown-menu > li {
  padding: 3px 20px;
}

.docs-options .dropdown-menu > li:hover {
  background-color: #f7f7f7;
}

.docs-options .dropdown-menu > li > label {
  display: block;
}

.docs-cropped .modal-body {
  text-align: center;
}

.docs-cropped .modal-body > img,
.docs-cropped .modal-body > canvas {
  max-width: 100%;
}




</style>

</head>
<body>

<div>
  <img id="image" src="picture.jpg">
</div>

</body>
</html>