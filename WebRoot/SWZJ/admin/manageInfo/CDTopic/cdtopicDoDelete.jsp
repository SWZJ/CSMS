<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer cdtopic_id = Integer.valueOf(request.getParameter("id"));
	
	CDTopic cdt = new CDTopic();
	new Student().refreshCDTopicID(cdtopic_id);//删除课题信息时，先将学生表中对应的课题信息置空
    if(cdt.deleteCDTopic(cdtopic_id)){
    	session.setAttribute("message", cdt.getName()+" 的信息删除成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+cdt.getName()+" 的信息删除失败！");
	out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicInfo.jsp\";</script>");

%>