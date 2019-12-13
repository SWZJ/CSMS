<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer message_id = Integer.valueOf(request.getParameter("id"));
	Message mes = new Message().queryMessageByID(message_id);
	
    if(mes.deleteMessageByID(message_id)){
    	session.setAttribute("message", session.getAttribute("lan").equals("en")?"Delete message successful!":"删除消息成功！");
	}else
		session.setAttribute("message", session.getAttribute("lan").equals("en")?"Unknown error encountered! The server may be under maintenance or for some unknown reason! Delete message failed!":"遇到未知错误！可能是服务器正在维护或者其他未知原因！删除消息失败！");
	out.print("<script>self.location=document.referrer;</script>");

%>
