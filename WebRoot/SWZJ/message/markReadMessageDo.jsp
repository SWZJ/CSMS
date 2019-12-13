<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer message_id = Integer.valueOf(request.getParameter("id"));
	Message mes = new Message().queryMessageByID(message_id);
	
    if(mes.updateMessageOfReaded(true)){
    	session.setAttribute("message", session.getAttribute("lan").equals("en")?"Marks the message as read success!":"成功标记消息为已读！");
	}else
		session.setAttribute("message", session.getAttribute("lan").equals("en")?"Unknown error encountered! The server may be under maintenance or for some unknown reason! Failed to mark the message as read!":"遇到未知错误！可能是服务器正在维护或者其他未知原因！标记消息为已读失败！");
	out.print("<script>self.location=document.referrer;</script>");

%>