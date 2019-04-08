<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

<%
	Teacher tea = new Teacher();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Teacher teaOld = (Teacher)session.getAttribute("teacherOld");
    String teacher_number = request.getParameter("teacher_number");
    if(teaOld.isExist_number(teacher_number)&&!teacher_number.equals(teaOld.getNum())){
    	out.print("<script>alert(\"修改教师失败！\\n编号 "+teacher_number+" 已存在！\");window.history.back(-1);</script>");
    }else{
    	String teacher_name = request.getParameter("teacher_name");
    	String teacher_position = request.getParameter("teacher_position");
	    Date updated_at = new Date();

		if(tea.updateTeacher(teaOld, teacher_number, teacher_name, teacher_position, updated_at)){
			/* tea.refreshCDTopicCountByID(teaOld.getID());//刷新拥有课题总数 */
			session.setAttribute("message", teacher_name+" 的信息修改成功！");
		}else{
			session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+teacher_name+" 的信息修改失败！");
		}
		out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/Teacher/teacherInfo.jsp\";</script>");
		session.removeAttribute("teacherOld");
    }
%>

