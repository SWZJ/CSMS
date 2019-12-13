<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer receiver_id = Integer.valueOf(request.getParameter("receiver_id"));
	
    if(mes.updateMessageAllReaded(receiver_id)){
    	session.setAttribute("message", "Mark all messages as unread success!");
	}else
		session.setAttribute("message", "Unknown error encountered! The server may be under maintenance or for some unknown reason! Failed to mark all messages as unread!");
	out.print("<script>window.location.href = \"myMessage.jsp\";</script>");

%>

