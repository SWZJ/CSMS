<%@page import="java.sql.*"%>
<%@ page language="java" import="java.util.*,JZW.*,java.util.Date" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

<%
	CDTopic cdt = new CDTopic();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	CDTopic cdtOld = (CDTopic)session.getAttribute("cdtopicOld");
    String cdtopic_number = request.getParameter("cdtopic_number");
    if(cdtOld.isExist_number(cdtopic_number)&&!cdtopic_number.equals(cdtOld.getNum())){
    	out.print("<script>alert(\"修改课题失败！\\n编号 "+cdtopic_number+" 已存在！\");window.history.back(-1);</script>");
    }else{
    	String cdtopic_name = request.getParameter("cdtopic_name");
	    String cdtopic_keyword = request.getParameter("cdtopic_keyword");
	    String cdtopic_technology = request.getParameter("cdtopic_technology");
	    Integer teacher_id = Integer.valueOf(request.getParameter("teacher_id"));
	    Date updated_at = new Date();

		if(cdt.updateCDTopic(cdtOld, cdtopic_number, cdtopic_name, cdtopic_keyword, cdtopic_technology, teacher_id, updated_at)){
			new Teacher().refreshCDTopicCountOfAll();//刷新教师拥有的课题总数
			session.setAttribute("message", "修改课题 "+cdtopic_name+" 成功！");
		}else{
			session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！修改课题 "+cdtopic_name+" 失败！");
		}
		out.print("<script>window.location = \"/CSMS/SWZJ/teacher/myTopic/allTopic.jsp\";</script>");
		session.removeAttribute("cdtopicOld");
    }
%>
