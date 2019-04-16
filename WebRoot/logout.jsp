<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>
<%
	//注销删除所有Cookie和Session
	Cookie[] cookies = request.getCookies();
	if (cookies != null) {
		for (int i = 0; i < cookies.length; i++) {
			if ("userID".equals(cookies[i].getName())) {
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
			}
		}
	}
	request.getSession().invalidate();
	response.sendRedirect("/CSMS/login.jsp");
%>
