<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
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

<title>My JSP 'Message.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/interface/SendMessage.js" ></script>
<script type="text/javascript">
	function sendMessage() {
		var message = $("message").value;
		SendMessage.addMessage();
	}
	function receiveMessages(messages) {
		/* var chatlog = "";
		for ( var data in messages) {
			chatlog = "<div>" + dwr.util.escapeHtml(messages[data]) + "</div>"
					+ chatlog;
		}
		dwr.util.setValue("list", chatlog, {
			escapeHtml : false
		}); */
		console.log(messages)
	}
</script>
</head>
<body onload="dwr.engine.setActiveReverseAjax(true);">
	input message:
	<input id="message" type="text" />
	<input type="button" value="send" onclick="sendMessage()" />
	<br>
	<div id="list"></div>
</body>
</html>
