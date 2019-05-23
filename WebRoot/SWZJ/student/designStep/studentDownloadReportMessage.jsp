<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>


<!DOCTYPE HTML>
<html>
  <head>
    <title>报告操作结果</title>
  </head>
  
  <body>
  	<script>
  		/* alert('${message}'); */
  		<% session.setAttribute("message",request.getAttribute("message")); %>
  		window.location.href = "/CSMS/servlet/ListFileServlet?location=studentMyReport&branch=student&id=0&queryStr=${user.getName()}";
  	</script>
  </body>
</html>
