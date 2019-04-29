<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
	User user = new User();
	//获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	String user_password = request.getParameter("user_password")==null?"":request.getParameter("user_password");
	Integer user_id = request.getParameter("id")==null?0:Integer.valueOf(request.getParameter("id"));
	if(user_password.equals("")||user_id==0)	return;
	user = user.queryUserByID(user_id);
	
	if(user.updateUserPassword(user, user_password)){
		out.print("<script>alert(\'操作成功！\')</script>");
		out.print("<script>window.location.href = \"/CSMS/login.jsp\";</script>");
	}else{
		out.print("<script>alert(\'遇到未知原因，操作失败！\n请重新操作，若多次报错请联系管理员！\')</script>");
		out.print("<script>history.back(-1);</script>");
	}
%>

