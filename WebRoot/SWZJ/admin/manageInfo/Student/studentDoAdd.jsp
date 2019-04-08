<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

<%
	Student stu = new Student();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String student_number = request.getParameter("student_number");
    if(stu.isExist_number(student_number)){
    	out.print("<script>alert(\"新增学生信息失败！\\n学号 "+student_number+" 已存在！\");window.history.back(-1);</script>");
    }else{
    	String student_name = request.getParameter("student_name");
	    String student_sex = request.getParameter("student_sex");
	    Integer student_age = request.getParameter("student_age")==""?0:Integer.valueOf(request.getParameter("student_age"));
	    Integer class_id = Integer.valueOf(request.getParameter("student_class")); 	
	    Integer major_id = Integer.valueOf(request.getParameter("student_major"));
	    Integer college_id = Integer.valueOf(request.getParameter("student_college"));
	    Integer cdtopic_id = Integer.valueOf(request.getParameter("cdtopic_id"));
	    Date created_at = new Date();
		
		if(stu.CreateStudent(student_number, student_name, student_sex, student_age, class_id, major_id, college_id, cdtopic_id, created_at)){
			new CDTopic().refreshHeadcountByID(cdtopic_id);//刷新课题的选题总人数
			session.setAttribute("message", student_name+" 的信息添加成功！");
		}else{
			session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+student_name+" 的信息添加失败！");
		}
		out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/Student/studentInfo.jsp\";</script>");
    }
%>
