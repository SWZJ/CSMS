<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
	Teacher tea = new Teacher();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String teacher_number = request.getParameter("teacher_number");
    if(tea.isExist_number(teacher_number)){
    	out.print("<script>alert(\"新增教师信息失败！\\n编号 "+teacher_number+" 已存在！\");window.history.back(-1);</script>");
    }else{
    	String teacher_name = request.getParameter("teacher_name");
    	String teacher_position = request.getParameter("teacher_position");
	    Date created_at = new Date();
		
		if(tea.CreateTeacher(teacher_number, teacher_name,teacher_position, created_at)){
			tea.refreshCDTopicCountByID(tea.getID());
			session.setAttribute("message", teacher_name+" 的信息添加成功！");
		}else{
			session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+teacher_name+" 的信息添加失败！");
		}
		out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/Teacher/teacherInfo.jsp\";</script>");
    }
%>
