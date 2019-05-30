<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer user_id = Integer.valueOf(request.getParameter("id"));
	String user_question = request.getParameter("user_question");
	String user_answer = request.getParameter("user_answer");
	User user = new User().queryUserByID(user_id);
	
    if(user.updateUserQuestionAnswer(user, user_question, user_answer)){
    	session.setAttribute("message", "设置密保问题成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！设置密保问题失败！");
	out.print("<script>window.location.href = \"/CSMS/SWZJ/user/userCenter.jsp\";</script>");

%>

