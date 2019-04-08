<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	String student_id = request.getParameter("id");
    
   
%>
