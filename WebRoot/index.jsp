<%@ page language="java" import="java.util.*,JZW.*,java.text.DateFormat,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<% 
	User user = (User)session.getAttribute("user");
	/* String password = request.getParameter("password")==null?"":request.getParameter("password");
	if(password.length()!=0){
		user.updateUserPassword(user, password);
	} */
	if(user == null){
		response.sendRedirect("/CSMS/login.jsp");
	}else{
		if(user.getRemember()==true){
			Cookie userIDCookie = new Cookie("userID", String.valueOf(user.getID()));
			userIDCookie.setMaxAge(60*60*12);//记住12小时
			response.addCookie(userIDCookie);
		}
		if(user.getRoot() == 1){
			response.sendRedirect("/CSMS/SWZJ/admin/admin.jsp");
		}else if(user.getRoot() == 0){
			response.sendRedirect("/CSMS/SWZJ/student/student.jsp");
		}else if(user.getRoot() == 9){
			response.sendRedirect("/CSMS/SWZJ/teacher/teacher.jsp");
		}else{
			if(user.getRoot()==520)
			response.sendRedirect("520.jsp");
		}
	}
%>