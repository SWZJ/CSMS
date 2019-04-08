<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer teacher_id = Integer.valueOf(request.getParameter("id"));
	
	Teacher tea = new Teacher();
    if(tea.deleteTeacherByID(teacher_id)){
    	session.setAttribute("message", tea.getName()+" 的信息删除成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+tea.getName()+" 的信息删除失败！");
	out.print("<script>window.location = \"/CSMS/SWZJ/admin/manageInfo/Teacher/teacherInfo.jsp\";</script>");

%>