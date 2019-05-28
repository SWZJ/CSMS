<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer cdtopic_id = Integer.valueOf(request.getParameter("id"));
	String cdtopic_opinion = request.getParameter("opinion")==null?"":request.getParameter("opinion");
	CDTopic cdt = new CDTopic().queryCDTopicByID(cdtopic_id);
	
	boolean c = cdt.updateCDTopic(cdt, true, 1, cdtopic_opinion);
	
	//消息概述
	String message_summary = "课题 "+cdt.getName()+" 通过审核";
	//消息内容
	String message_content = "您创建的课题 "+cdt.getName()+" 已成功通过神葳总局的审核！学生已经可以选择您的课题了！<br>&emsp;&emsp;审核意见："+cdtopic_opinion;
	//消息接收者用户ID
	int receiver_id = new Teacher().queryTeacherByID(cdt.getTeacherID()).getUserID();
	//发送消息
	boolean m = mes.sendSingleMessage(1, message_summary, message_content, 1, receiver_id);
	
    if(c){
    	session.setAttribute("message", "通过课题 "+cdt.getName()+" 成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！通过课题 "+cdt.getName()+" 失败！");
	out.print("<script>window.location.href = 'approvedTopic.jsp';</script>");

%>
