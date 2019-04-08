<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>


<!DOCTYPE HTML>
<html>
  <head>
    <title>报告上传结果</title>
  </head>
  
  <body>
  	<script>
  		/* alert('${message}'); */
  		<% session.setAttribute("message",request.getAttribute("message")); %>
  		window.location = "${pageContext.request.contextPath}/servlet/ListFileServlet?location=myReport&branch=student&id=${user.getTeacherID()}&queryStr=${user.getName()}";
  	</script>
  </body>
</html>