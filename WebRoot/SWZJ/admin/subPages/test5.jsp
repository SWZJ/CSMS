<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'test5.jsp' starting page</title>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
	  <div style="text-align:center">
		<h1>节奏葳的测试页面</h1><hr>
		<input id="username" name="username" value=""><br><br>
		<input id="id" name="id" value=""><br><br>
		<button id="btn">测试</button>
		
	  </div>
   
    <!-- Javascript -->
	<%@include file="/CommonView/javaScript.jsp" %>
	<script>
	$(document).ready(function() {
		$("#btn").click(function(){
		$.ajax({
			type:"post",
			url:"/CSMS/Aja",
			datatype: "json", 
			data:{
				"username":$("#username").val(),
				"id":$("#id").val(),
			},
			success:function(data) {
				alert(data);
				//var rr = eval('('+data+')');
				var rr = JSON.parse(data);
				$("#id").val(rr.username);
				alert("成功回调！");
			},
			error:function(data){
				alert("回调出错！");
			}
			
		});
		
		});
	});
	</script>
  </body>
</html>
