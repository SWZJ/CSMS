<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	String message_summary = request.getParameter("summary");
    String message_content = request.getParameter("content");
    
    Integer sender_id = Integer.valueOf(request.getParameter("sender_id"));
    Integer receiver_id = Integer.valueOf(request.getParameter("receiver_id"));

	if(mes.sendSingleMessage(0, message_summary, message_content, sender_id,receiver_id )){
		session.setAttribute("message", session.getAttribute("lan").equals("en")?"The message was sent successfully!":"消息发送成功！");
	}else{
		session.setAttribute("message", session.getAttribute("lan").equals("en")?"Unknown error encountered! The server may be under maintenance or for some unknown reason! Message sending failed!":"遇到未知错误！可能是服务器正在维护或者其他未知原因！消息发送失败！");
	}
	out.print("<script>window.location.href = \"sentMessage.jsp\";</script>");
%>
