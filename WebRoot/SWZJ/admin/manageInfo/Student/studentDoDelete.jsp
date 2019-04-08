<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer student_id = Integer.valueOf(request.getParameter("id"));
	
	Student stu = new Student();
    if(stu.deleteStudentByID(student_id)){
    	new CDTopic().refreshHeadcountOfAll();//刷新所有课题的选课人数
		session.setAttribute("message", stu.getName()+" 的信息删除成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+stu.getName()+" 的信息删除失败！");
	out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/Student/studentInfo.jsp\";</script>");
    
%>