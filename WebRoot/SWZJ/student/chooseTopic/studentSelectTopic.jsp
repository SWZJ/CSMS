<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer student_id = request.getParameter("id")==null?0:Integer.valueOf(request.getParameter("id"));
	Integer cdtopic_id = request.getParameter("cdtopic_id")==null?0:Integer.valueOf(request.getParameter("cdtopic_id"));
	Student stu = new Student().queryStudentByID(student_id);
	CDTopic cdt = new CDTopic().queryCDTopicByID(cdtopic_id);
	
	//消息概述
	String message_summary = "课题 "+cdt.getName()+" 被选中";
	//消息内容
	String message_content = "您的课题 "+cdt.getName()+" 已成功被学生 "+stu.getName()+" 选中！";
	//消息发送者用户ID
	int sender_id = 1;//系统消息
	//消息接收者用户ID
	int receiver_id = new Teacher().queryTeacherByID(cdt.getTeacherID()).getUserID();
	//发送消息
	boolean m = mes.sendSingleMessage(4, message_summary, message_content, sender_id, receiver_id);
	
	if(stu.selectCDTopicByStudentID(student_id,cdtopic_id)){
		new CDTopic().refreshHeadcountOfAll();
    	session.setAttribute("message", "你已成功选择课题 "+cdt.getName()+" ！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！选择课题 "+cdt.getName()+" 失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/student/chooseTopic/studentChooseTopic.jsp\";</script>");
%>