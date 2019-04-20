<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>


<!DOCTYPE HTML>
<html>
  <head>
    <title>报告下载出错</title>
  </head>
  
  <body>
  	<script>
  		/* alert('${message}'); */
  		<% session.setAttribute("message",request.getAttribute("message")); %>
  		window.location.href = "${pageContext.request.contextPath}/servlet/ListFileServlet?location=studentMyReport&branch=student&id=0&queryStr=${user.getName()}";
  	</script>
  </body>
</html>
