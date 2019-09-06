<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer receiver_id = Integer.valueOf(request.getParameter("receiver_id"));
	
    if(mes.updateMessageAllReaded(receiver_id)){
    	session.setAttribute("message", session.getAttribute("lan").equals("en")?"Mark all messages as unread success!":"成功标记所有消息为已读！");
	}else
		session.setAttribute("message", session.getAttribute("lan").equals("en")?"Unknown error encountered! The server may be under maintenance or for some unknown reason! Failed to mark all messages as unread!":"遇到未知错误！可能是服务器正在维护或者其他未知原因！标记所有消息为已读失败！");
	out.print("<script>window.location.href = \"myMessage.jsp\";</script>");

%>

