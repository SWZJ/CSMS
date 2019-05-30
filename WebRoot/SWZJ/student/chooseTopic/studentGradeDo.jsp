<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Grade gra = new Grade();
	Message mes = new Message();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer user_id = Integer.valueOf(request.getParameter("id"));
	User user = new User().queryUserByID(user_id);

	double grade_value = Double.valueOf(request.getParameter("grade"));
	String grade_content = request.getParameter("grade_content");
	int grade_user = request.getParameter("grade_anonymity")==null?user_id:-user_id;
	int grade_type = Integer.valueOf(request.getParameter("grade_type"));
	int foreign_id = Integer.valueOf(request.getParameter("foreign_id"));
	
	CDTopic cdt = new CDTopic().queryCDTopicByID(foreign_id);
	
	//消息概述
	String message_summary = "课题 "+cdt.getName()+" 被评分";
	//消息内容
	String message_content = (grade_user==0?"匿名用户":user.getName())+" 给您的课题 "+cdt.getName()+" 给予了 "+grade_value+" 的评分！<br>&emsp;&emsp;评分内容为："+grade_content ;
	//消息接收者用户ID
	int receiver_id = new Teacher().queryTeacherByID(cdt.getTeacherID()).getUserID();
	//发送消息
	boolean m = mes.sendSingleMessage(0, message_summary, message_content, grade_user<0?1:user_id, receiver_id);
	//添加评分
	boolean g = gra.CreateGrade(grade_value, grade_content, grade_user, grade_type, foreign_id);
	//刷新课题的评分
	boolean c = cdt.refreshGradeByID(cdt.getID());
	
    if(m&&g&&c){
    	session.setAttribute("message", "给课题 "+cdt.getName()+" 评分成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！给课题 "+cdt.getName()+" 评分失败！");
	out.print("<script>self.location=document.referrer;</script>");

%>