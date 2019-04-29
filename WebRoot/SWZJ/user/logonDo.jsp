<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>

<%
	User user = new User();
	Teacher tea = new Teacher();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String user_account = request.getParameter("user_account");
    if(user.isExist_account(user_account)||new Student().isExist_number(user_account)){
    	out.print("<script>alert(\"用户注册失败！\\n账号 "+user_account+" 已存在！\");window.history.back(-1);</script>");
    }else{
    	String user_password = request.getParameter("user_password");
	    String user_name = request.getParameter("user_name");
	    String user_authCode = request.getParameter("user_authCode");
	    Date created_at = new Date();
	    
	    int user_root = user_authCode.length()==0?9:1;
	    String user_root_name = user_authCode.length()==0?"教师":"超级管理员";
	    if(user_root==9){
	    	tea.CreateTeacher(user_account, user_name, "助教", created_at);
	    }
	    int teacher_id = tea.queryTeacherByNumber(user_account).getID();
		
		if(user.creatUser(user_account, user_password, user_name, user_root, user_root_name, 0, teacher_id, created_at)){
			out.print("<script>alert(\"注册成功！您注册的用户权限为："+user_root_name+"\");</script>");
		}else{
			out.print("<script>alert(\"遇到未知错误！可能是服务器正在维护或者其他未知原因！注册失败！\");</script>");
		}
		out.print("<script>window.location.href = \"/CSMS/login.jsp\";</script>");
    }
%>