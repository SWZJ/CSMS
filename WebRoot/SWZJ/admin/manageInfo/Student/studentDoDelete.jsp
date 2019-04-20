<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Student stu = new Student();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer student_id = Integer.valueOf(request.getParameter("id"));
	String student_name = stu.queryStudentByID(student_id).getName();
	
    if(stu.deleteStudentByID(student_id)){
    	new CDTopic().refreshHeadcountOfAll();//刷新所有课题的选课人数
		session.setAttribute("message", student_name+" 的信息删除成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+student_name+" 的信息删除失败！");
	out.print("<script>window.location.href = \"/CSMS/SWZJ/admin/manageInfo/Student/studentInfo.jsp\";</script>");
    
%>