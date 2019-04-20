<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
	Teacher tea = new Teacher();
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer teacher_id = Integer.valueOf(request.getParameter("id"));
	String teacher_name = tea.queryTeacherByID(teacher_id).getName();
	
    if(new CDTopic().emptyTeacherByTeacherID(teacher_id)&&tea.deleteTeacherByID(teacher_id)){
    	session.setAttribute("message", teacher_name+" 的信息删除成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！ "+teacher_name+" 的信息删除失败！");
	out.print("<script>window.location.href = \"/CSMS/SWZJ/admin/manageInfo/Teacher/teacherInfo.jsp\";</script>");

%>