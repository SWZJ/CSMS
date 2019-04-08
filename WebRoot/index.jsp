<%@ page language="java" import="java.util.*,JZW.*,java.text.DateFormat,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<% 
	User user = (User)session.getAttribute("user");
	if(user == null){
		response.sendRedirect("/CSMS/login.jsp");
	}else{
		if(user.getRoot() == 1){
			response.sendRedirect("/CSMS/SWZJ/admin/admin.jsp");
		}else if(user.getRoot() == 0){
			response.sendRedirect("/CSMS/SWZJ/student/student.jsp");
		}else if(user.getRoot() == 9){
			response.sendRedirect("/CSMS/SWZJ/teacher/teacher.jsp");
		}else{
			//response.sendRedirect("/CSMS/login.jsp");
			response.sendRedirect("/CSMS/SWZJ/admin/admin.jsp");
		}
	}
%>