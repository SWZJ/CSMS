<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	CDTopic cdt = new CDTopic();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer cdtopic_id = Integer.valueOf(request.getParameter("id"));
	String cdtopic_name = cdt.queryCDTopicByID(cdtopic_id).getName();
		
    if(new Student().emptyCDTopicByCDTopicID(cdtopic_id)&&cdt.deleteCDTopic(cdtopic_id)){//删除课题信息时，先将学生表中对应的课题信息置空
    	new Teacher().refreshCDTopicCountOfAll();//刷新教师拥有的课题总数
    	session.setAttribute("message", "删除课题 "+cdtopic_name+" 成功！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！删除课题 "+cdtopic_name+" 失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherAllTopic.jsp\";</script>");
    
%>