<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 기본 jquery 라이브러리 -->
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>

<!-- 부트스트랩 라이브러리 -->
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>

<!-- 동현_다음지도 api를 사용하기 위한 라이브러리 -->
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=4fee53b7de3bea2949e43b9bafc300a3&libraries=services,clusterer,drawing"></script>

<!-- 동현_메트로맵 tooltip을 위한 라이브러리 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/tooltipster/dist/js/tooltipster.bundle.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/tooltipster.bundle.min.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/tooltipster/dist/css/plugins/tooltipster/sideTip/themes/tooltipster-sideTip-noir.min.css" />

<!-- 동현_검색어 자동완성을 위한 jquery-ui 라이브러리 -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui.css">
<script src="<%= request.getContextPath() %>/resources/jquery-ui/jquery-ui.js"></script>

<!-- 미현_전체페이지 css -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/main.css" />

<!-- 은석_레스토랑 디테일.jsp에서 차트를 이용하기 위한 라이브러리 추가 -->
<link  rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/js/highcharts.js">
<link  rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/js/modules/exporting.js">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/highcharts.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/modules/exporting.js"></script> 

<!-- 한별_회원가입 css -->
<link href="<%= request.getContextPath() %>/resources/css/hb_register_.css" rel="stylesheet">

<!-- 한별_회원가입 유효성 검사용 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.3/js/bootstrapValidator.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/zxcvbn/1.0/zxcvbn-async.min.js"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.6.2/js/bootstrap-select.min.js"></script>