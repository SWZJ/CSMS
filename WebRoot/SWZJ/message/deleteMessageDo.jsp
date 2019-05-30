<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer message_id = Integer.valueOf(request.getParameter("id"));
	Message mes = new Message().queryMessageByID(message_id);
	
    if(mes.deleteMessageByID(message_id)){
    	session.setAttribute("message", "Delete message successful!");
	}else
		session.setAttribute("message", "Unknown error encountered! The server may be under maintenance or for some unknown reason! Delete message failed!");
	out.print("<script>self.location=document.referrer;</script>");

%>
