<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">


<link rel="shortcut icon" href="resources/favicon.ico" />
<link href='http://fonts.googleapis.com/css?family=Vollkorn:700italic'
	rel='stylesheet' type='text/css'>

<title>HydroCloud</title>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta name="keywords"
	content="HydroCloud, hydrology, stream gauges, USGS, data" />
<meta http-equiv="description" content="This is my page">

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- jQuery, Bootstrap, Knockout, D3 -->
<script src="lib/jquery/jquery-2.0.2.js"></script>
<link href="lib/bootstrap/css/bootstrap.css" rel="stylesheet">
<script src="lib/bootstrap/js/bootstrap.js"></script>
<script src='lib/knockout-3.0.0.js'></script>
<script src="lib/d3/d3.min.js"></script>

<!-- My mapping files here. -->
<!--    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCxmwq7svGGXSeaXHsxfW27LDaXytc3nBY"></script> -->

<!-- 	<script src="http://ditu.google.cn/maps/api/js?key=AIzaSyCxmwq7svGGXSeaXHsxfW27LDaXytc3nBY"></script> -->


<!--     <script src="src/index-drawMap.js"></script> -->

<script src="src/index-drawMap.js"></script>
<script src="src/points-sample-data.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=Sj4GdvLlELGHB70KMMd5FNZbSLl1qpHg"></script>

<!-- my graphing stuff here -->
<script src="src/graph-flowduration.js"></script>
<script src="src/graph-scatterChart.js"></script>

<!-- Local Storage functions -->
<script src="src/requestData.js"></script>
<script src="src/dataProviders.js"></script>
<script src="src/local-storage.js"></script>

<!-- viewModel -->
<script src="src/viewModel.js"></script>
<script src="src/initialize.js"></script>


<!-- Gitter Sidecar -->
<script>
      ((window.gitter = {}).chat = {}).options = {
        room: 'HydroCloud-app/Lobby',
        activationElement: false
      };
    </script>
<script src="https://sidecar.gitter.im/dist/sidecar.v1.js" async defer></script>



<!-- My styles here -->
<style>
body { /*bootstrap sets the navbar height at 50px.*/
	padding-top: 50px;
	padding-bottom: 50px;
	background-color: lightgray;
}
/*for google maps*/
html,body,#carousel-example-generic,.carousel-inner,.item {
	height: 100%;
}

#brand {
	font-family: 'Vollkorn', serif;
	font-style: italic;
	font-size: 24pt;
	color: white;
	text-shadow: 3px 3px 10px #aaf;
}

/*for carousel indicators */
.carousel-indicators {
	position: absolute;
	bottom: -50px;
	color: #666;
}

.carousel-indicators :hover {
	color: #bbb;
}

.carousel-indicators .active {
	height: 20px;
	width: 40px;
	background-color: transparent;
	color: white;
}

.carousel-indicators li { /*override default behavior*/
	text-indent: 0px;
	height: 20px;
	width: 40px;
	border-style: none;
	margin: 0;
	font-size: 20px;
}

/*for my bottom button bar*/
#button-bar {
	position: absolute;
	bottom: 0px;
	height: 50px;
	width: 100%;
}

#button-bar a {
	font-size: 30px;
	color: #bbb;
	bottom: 0px;
}

#button-bar a span {
	vertical-align: middle;
}

#legend-btn {
	color: white;
	background-color: #444;
	border-color: #444;
}

#legend-btn.active {
	color: black;
	background-color: #aaa;
}

#legend-modal {
	position: absolute;
	top: 80px;
	right: 30px;
	padding: 5px;
	background-color: silver;
	border: 1px solid black;
	z-index: 50;
	/*display: none;*/
}

#help_div {
	padding: 10px;
}

#help_directions li {
	padding-bottom: 1em;
}

#stats_div {
	padding: 10px;
}

.v-scroll {
	overflow-y: auto;
}

/*For graphs*/
svg {
	font: 10px sans-serif;
}

.axisTitle {
	font: 14px serif;
}

.Title {
	font: 20px serif;
}

.subTitle {
	font: 12px serif;
}

path {
	fill: none;
	stroke-width: 2;
}

/* keep the .filled selector for filled hydrographs.*/
.filled {
	fill: skyblue;
}

path:hover {
	stroke: red;
}

.axis path,.axis line {
	fill: none;
	stroke: #000;
	shape-rendering: crispEdges;
}

.bar rect {
	fill: lightskyblue;
	shape-rendering: crispEdges;
}

.bar text {
	fill: black;
}

.brush .extent {
	stroke: #fff;
	fill-opacity: .125;
	shape-rendering: crispEdges;
}

svg .dataNotice {
	font: 30px sans-serif;
	fill: gray;
}
</style>
<!-- Respond.js让不支持css3 Media Query的浏览器包括IE6-IE8等其他浏览器支持查询。 -->
<!-- html5shiv.js 解决ie9以下浏览器对html5新增标签的不识别，并导致CSS不起作用的问题。 -->
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
	<!-- 导航栏 -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"> </span> <span class="icon-bar"> </span> <span
					class="icon-bar"> </span>
			</button>
			<a id="brand" class="navbar-brand" href="#">HydroCloud</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav navbar-right">
				<li data-target="#carousel-example-generic" data-slide-to="0">
					<a href="#" data-bind="click: map">Map</a>
				</li>
				<li class="dropdown" data-target="#carousel-example-generic"
					data-slide-to="1"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown">Graph <b class="caret"> </b> </a>
					<ul class="dropdown-menu">
						<li><a href="#" data-bind="click: scatter">Hydrograph</a>
						</li>
						<li><a href="#" data-bind="click: flow">Flow Duration</a>
						</li>
						<li class="divider"></li>
						<li><a href="#" data-bind="click: toggleLegend">Show
								Legend</a>
						</li>
					</ul>
				</li>
				<li data-target="#carousel-example-generic" data-slide-to="2">
					<a href="#">Stats</a>
				</li>
				<li data-target="#carousel-example-generic" data-slide-to="3">
					<a href="#"><strong>?</strong> </a>
				</li>
				<li><a href="#"
					class="js-gitter-toggle-chat-button glyphicon glyphicon-comment"></a>
				</li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container-fluid --> </nav>
	<!-- 底部箭头 -->
	<div id="button-bar" class="navbar-inverse">
		<a href="#carousel-example-generic" data-slide="prev"
			data-bind="click: slide" class="pull-left"> <span
			class="glyphicon glyphicon-chevron-left"> </span> </a>
		<div class="pull-right">
			<button id="legend-btn" class="btn"
				data-bind="click: toggleLegend, css: { active: showLegend}">
				<span class="glyphicon glyphicon-list-alt"> </span>
			</button>
			<a href="#carousel-example-generic" data-slide="next"
				data-bind="click: slide" class=""> <span
				class="glyphicon glyphicon-chevron-right"></span> </a>
		</div>
	</div>
	<!-- 图例 -->
	<div id="legend-modal" data-bind="visible: showLegend">
		<div class="modal-header">
			<button type="button" class="close" id="legend-modal-dismiss"
				data-bind="click: toggleLegend" aria-hidden="true">&times;
			</button>
			<h3 class="modal-title" id="myModalLabel">Legend</h3>
		</div>
		<div>
			<p>Click on a point to read its name and load its data.</p>
			<p>
				<b>Sites:</b>
			</p>
			<ol data-bind="foreach: viewModel.siteDict">
				<li><span data-bind="text: $data.name"></span>
				</li>
			</ol>
		</div>
	</div>
	<!-- 轮播图内容 -->
	<!-- Main Carousel Content -->
	<div id="carousel-example-generic" class="carousel slide"
		data-interval="false">

		<!-- Indicators This is a built-in set of js and css that goes with the Bootstrap Carousel. Can't mess with it too much. -->
		<ol class="carousel-indicators" id="bottom-nav">
			<li data-target="#carousel-example-generic" data-slide-to="0"
				class="active" data-bind="click: map"><span
				class="glyphicon glyphicon-globe"> </span>
			</li>
			<li data-target="#carousel-example-generic" data-slide-to="1"><span
				class="glyphicon glyphicon-stats"> </span>
			</li>
			<li data-target="#carousel-example-generic" data-slide-to="2"><span
				class="glyphicon glyphicon-th-list"> </span>
			</li>
			<li data-target="#carousel-example-generic" data-slide-to="3"><span
				class="glyphicon glyphicon-question-sign"> </span>
			</li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner">

			<div class="item" id="map_div"></div>

			<div class="item" id="graph_div"></div>

			<div class="item v-scroll  active" id="stats_div">
				<h3>Site Statistics</h3>
				<!-- <p>
					<span data-bind="text: viewModel.dataArray().length"> </span> sites
					selected
				</p>
				<div class="table-responsive">
					<table class="table">
              <thead>
                <tr>
                  <th>Site Name</th><th>Site ID</th><th>Watershed area (km<sup>2</sup>)</th><th>% Impervious</th>
                </tr>
              </thead>
              <tbody data-bind="foreach: viewModel.siteDict">
                <tr>
                  <td data-bind="text: $data.name"></td>
                  <td data-bind="text: $data.id"></td>
                  <td data-bind="text: $data.area"></td>
                  <td data-bind="text: $data.impervious"></td>
                </tr>
              </tbody>
            </table> --><input type="button" value="send" onclick="onPageLoad()" />
					<table class="table">
						<thead>
							<tr>
								<th>遥测站地址</th>
								<th>时间</th>
								<th>地下水瞬时埋深(m)</th>
								<th>瞬时水温 (<sup>o</sup>C)</th>
								<th>电压和电压值</th>
							</tr>
						</thead>
						<tbody data-bind="foreach: viewModel.timingPacketData">
							<tr>
								<td data-bind="text: $data.headRemoteAddress"></td>
								<td data-bind="text: $data.transmitTime"></td>
								<td data-bind="text: $data.underWaterInstantDepth"></td>
								<td data-bind="text: $data.instantWaterTemp"></td>
								<td data-bind="text: $data.powerVoltage"></td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>

			<div class="item v-scroll" id="help_div">

				<h2>HydroCloud Instructions</h2>
				<ul id="help_directions" class="list-unstyled">
					<li><span class="glyphicon glyphicon-globe"></span> <strong>Map:</strong>
						The mapping page. This page defaults to a Google Maps interface
						using the topographic maps as a background and the current NEXRAD
						precipitation image as the foreground. Points represent USGS
						stream gages. By clicking on a point, the stream discharge and
						precipitation data for that site will be loaded into the system,
						where it can be viewed on the graphing page. Clicking on a point
						will also open a dialog box giving supplementary information about
						the site, including the name and ID# of the stream gage.</li>
					<li><span class="glyphicon glyphicon-stats"></span> <strong>Graph:</strong>
						The graphing page. There are two graphs available:
						<ul>
							<li><strong>Hydrograph(水位图):</strong> Stream discharge,
								measured in cubic meters per second (cms) is plotted on a
								logarithmic Y axis. Time is plotted on the X axis. The tooltip
								displays the discharge and the name of the stream
								gage.(以立方公尺每秒钟(cms)测量的水流量，Y轴用对数表示。X轴表示时间。提示文本显示水流量的排放和名称)</li>
							<li><strong>Flow Duration(流持续):</strong> a plot of all
								stream discharge measurements in cms ordered by size, from
								largest to smallest. Stream discharge is plotted on the y axis
								in a logarithmic scale in scientific notation, so that "1e+2"
								equals 100 cms and "4e+3" = 4000
								cms.(一种按大小排序的cms的所有水流量测量图，从最大到最小。在科学表示法中，以对数绘制的y轴水流量，因此“1e +
								2”等于100厘米，“4e + 3”= 4000 cms。)</li>
						</ul>
					</li>
					<li><span class="glyphicon glyphicon-th-list"> </span> <strong>Stats:</strong>
						The site statistics page. This lists each site that has been
						selected in the map view, along with some simple site statistics,
						including the USGS site # and the area of the watershed in square
						miles.</li>
					<li><span class="glyphicon glyphicon-question-sign"> </span> <strong>Help:</strong>
						Takes you to this page.</li>
					<li><span class="glyphicon glyphicon-comment"> </span> <strong>Chat:</strong>
						Opens a chat sidebar where you can ask for help or post your
						comments.</li>
					<li><span class="glyphicon glyphicon-list-alt"> </span> <strong>Legend:</strong>
						Toggles the legend box, which will float over the current page.
						The legend lists all of the selected sites. Selected sites with no
						stream gage data will be listed here, but will not appear in the
						graph view.</li>
				</ul>

				<h3>Description of the HydroCloud project</h3>
				<p>HydroCloud is a web-based, mobile-friendly tool for visually
					browsing hydrology data. Martin Roberge and Michael McGuire are the
					principal investigators for this project, which has been generously
					supported with a seed grant from the TU School of Emerging
					Technology.</p>
				<h3>Use us as a resource!</h3>
				<p>
					HydroCloud is easy to <a
						href="https://github.com/mroberge/HydroCloud/wiki/Embed-HydroCloud">embed</a>
					in your website, or you can <a
						href="https://github.com/mroberge/HydroCloud/wiki/Add-a-hydrograph-to-your-website">use
						our hydrograph</a> to plot your own data!
				</p>
				<p>
					We've created lots of <a
						href="https://github.com/mroberge/HydroCloud">tutorials</a> that
					explain how to use us as a resource.
				</p>
				<h3>Contributors Welcome!</h3>
				<p>
					Do you have an <a
						href="https://github.com/mroberge/HydroCloud/issues">idea</a> for
					improving this website? Do you have a <a
						href="http://mroberge.github.io/HydroCloud/station-list.html">dataset</a>
					that you would like to <a
						href="https://github.com/mroberge/HydroCloud/wiki/Adding-More-Data-Providers">add</a>
					to our collection? Come <a
						href="https://github.com/mroberge/HydroCloud">join us on
						GitHub!</a>
				</p>
				<p>
					<strong><em>~~<a
							href="https://github.com/mroberge/HydroCloud/wiki/Contribute-to-HydroCloud">bug
								reports & pull requests welcome</a>~~</em> </strong>
				</p>
				<p>
					Visit our GitHub repository: <a
						href="https://github.com/mroberge/HydroCloud">https://github.com/mroberge/HydroCloud</a>
				</p>
				<h3>Data Sources</h3>
				<small>
					<p>HydroCloud thanks the following data providers:</p>
					<ul>
						<li>Base maps & associated data services
							<ul>
								<li>Street map, terrain map, map data: ©2017 Google</li>
								<li>Satellite Base Map: Google Imagery ©2017 TerraMetrics</li>
								<li>Google Street View ©2017 Google</li>
							</ul>
						</li>
						<li>NEXRAD imagery © 2001-2017 Iowa State University Iowa
							Environmental Mesonet</li>
						<li>Stream discharge data providers (<a
							href="station-list.html">list of stations</a>)
							<ul>
								<li>US discharge and station data courtesy of the U.S.
									Geological Survey</li>
								<li>German discharge and station data ©2017 <a
									href="http://www.pegelonline.wsv.de">Wasserstraßen- und
										Schifffahrtsverwaltung des Bundes</a></li>
								<li>UK sites use Environment Agency flood and river level
									data from the <a
									href="http://environment.data.gov.uk/flood-monitoring/doc/reference">real-time
										data API (Beta)</a></li>
							</ul>
						</li>
						<li><a
							href="https://water.usgs.gov/lookup/getspatial?gagesII_Sept2011">GAGES-II</a>
							station data ©2011 James Falcone</li>
					</ul> </small>
			</div>
		</div>

	</div>

	<script>
      initialize();
    </script>
	<script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
                (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
              m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-73178522-2', 'auto');
      ga('send', 'pageview');

    </script>
	<script type="text/javascript" src="dwr/engine.js"></script>
	<script type="text/javascript" src="dwr/util.js"></script>
	<script type="text/javascript" src="dwr/interface/timingPacket.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){       
		//这个方法用来启动该页面的ReverseAjax功能
		dwr.engine.setActiveReverseAjax(true);
		//设置在页面关闭时，通知服务端销毁会话
		dwr.engine.setNotifyServerOnPageUnload(true);
		//设置DWR调用服务出错时，不打印(alert)调试信息 
		dwr.engine.setErrorHandler(function() {       
		 //    
		});
		onPageLoad();
	});
	function onPageLoad(){       
		timingPacket.getAllPackets(function(data){
			var l = data.length;
			for(var i=0;i<l;i++){
				viewModel.timingPacketData.push(data[i]);
			}
		});
	}
</script>

</body>
</html>
