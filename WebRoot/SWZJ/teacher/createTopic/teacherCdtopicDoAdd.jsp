<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
	CDTopic cdt = new CDTopic();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String cdtopic_number = request.getParameter("cdtopic_number");
    if(cdt.isExist_number(cdtopic_number)){
    	out.print("<script>alert(\"新增课题信息失败！\\n编号 "+cdtopic_number+" 已存在！\");window.history.back(-1);</script>");
    }else{
	    String cdtopic_name = request.getParameter("cdtopic_name");
	    String cdtopic_keyword = request.getParameter("cdtopic_keyword");
	    String cdtopic_technology = request.getParameter("cdtopic_technology");
	    Integer teacher_id = Integer.valueOf(request.getParameter("teacher_id"));
	    Teacher tea = new Teacher().queryTeacherByID(teacher_id);

	    Message mes = new Message();
	    //消息概述
		String message_summary = "课题 "+cdtopic_name+" 新增,等待审核";
		//消息内容
		String message_content = "教师 "+tea.getName()+" 新增了课题 "+cdtopic_name+"，等待管理员审核。";
		//消息发送者用户ID
		int sender_id = 1;//系统消息
		//消息接收者用户ID
		int receiver_id = 2;//管理员
		//发送消息
		boolean m = mes.sendSingleMessage(4, message_summary, message_content, sender_id, receiver_id);
		
		if(cdt.createCDTopic(cdtopic_number, cdtopic_name, cdtopic_keyword, cdtopic_technology, teacher_id, new Date())){
			new Teacher().refreshCDTopicCountByID(teacher_id);//刷新教师拥有的课题总数
			session.setAttribute("message", "新增课题 "+cdtopic_name+" 成功！");
		}else{
			session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！新增课题 "+cdtopic_name+" 失败！");
		}
		out.print("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherAllTopic.jsp\";</script>");
    }
%>
