<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML>
<html>
  <head>
    <title>报告下载结果</title>
  </head>
  
  <body>
  	<script>
  		/* alert('${message}'); */
  		<% session.setAttribute("message",request.getAttribute("message")); %>
  		window.location.href = "${pageContext.request.contextPath}/servlet/ListFileServlet?location=teacherReportOfStudent&branch=student&id=${ user.getTeacherID() }";
  	</script>
  </body>
</html>