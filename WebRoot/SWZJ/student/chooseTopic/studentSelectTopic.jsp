<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer student_id = Integer.valueOf(request.getParameter("id"));
	Integer cdtopic_id = Integer.valueOf(request.getParameter("cdtopic_id"));
	Student stu = new Student();
	String cdtopic_name = new CDTopic().queryCDTopicByID(cdtopic_id).getName();
	
	if(stu.selectCDTopicByStudentID(student_id,cdtopic_id)){
		new CDTopic().refreshHeadcountOfAll();
    	session.setAttribute("message", "你已成功选择课题 "+cdtopic_name+" ！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！选择课题 "+cdtopic_name+" 失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/student/chooseTopic/studentChooseTopic.jsp\";</script>");
%>
