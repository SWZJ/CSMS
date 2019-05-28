<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	CDTopic cdt = new CDTopic();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer cdtopic_id = Integer.valueOf(request.getParameter("id"));
	cdt = cdt.queryCDTopicByID(cdtopic_id);
	Teacher tea = new Teacher().queryTeacherByID(cdt.getTeacherID());

	Message mes = new Message();
    //消息概述
	String message_summary = "课题 "+cdt.getName()+" 重新申请了审核";
	//消息内容
	String message_content = "教师 "+tea.getName()+" 重新申请了课题 "+cdt.getName()+" 给管理员审核。";
	//消息发送者用户ID
	int sender_id = 1;//系统消息
	//消息接收者用户ID
	int receiver_id = 2;//管理员
	//发送消息
	boolean m = mes.sendSingleMessage(4, message_summary, message_content, sender_id, receiver_id);

    if(cdt.updateCDTopic(cdt, cdt.getActive(), 0, cdt.getOpinion())){
    	session.setAttribute("message", "课题 "+cdt.getName()+" 申请审核成功！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！课题 "+cdt.getName()+" 申请审核失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherWaitAuditTopic.jsp\";</script>");

%>
