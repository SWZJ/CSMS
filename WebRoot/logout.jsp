<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>
<%
	//获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	String user_id = request.getParameter("user_id");
    String user_name = request.getParameter("user_name");
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
	new User().getLogger().info("主键ID为 "+user_id+" 的 "+user_name+" 成功注销。");  
	response.sendRedirect("/CSMS/login.jsp");
%>
