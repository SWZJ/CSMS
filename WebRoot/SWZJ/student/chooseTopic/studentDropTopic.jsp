<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer student_id = Integer.valueOf(request.getParameter("id"));
	Student stu = new Student().queryStudentByID(student_id);
	String cdtopic_name = stu.getCDTopicName();
	
	if(stu.emptyCDTopicByStudentID(student_id)){//删除课题信息时，先将学生表中对应的课题信息置空
		new CDTopic().refreshHeadcountByID(stu.getCdtopicID());
    	session.setAttribute("message", "你已成功退选课题 "+cdtopic_name+" ！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！退选课题 "+cdtopic_name+" 失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/student/chooseTopic/studentChooseTopic.jsp\";</script>");
%>
