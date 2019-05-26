<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer user_id = request.getParameter("id")==""?0:Integer.valueOf(request.getParameter("id"));
	String user_name = request.getParameter("user_name");
	User user = new User().queryUserByID(user_id);
	boolean isOK = false;
	switch(user.getRoot()){
		case 1:{
			user.updateUserName(user, user_name);
			isOK = true;
			break;
		}
		case 0:{
			Student stu = new Student().queryStudentByID(user.getStudentID());
			String student_sex = request.getParameter("student_sex");
	    	Integer student_age = request.getParameter("student_age")==""?0:Integer.valueOf(request.getParameter("student_age"));
			user.updateUserName(user, user_name);
			stu.updateStudent(stu, stu.getNum(), user_name, student_sex, student_age, stu.getClassID(), stu.getMajorID(), stu.getCollegeID(), stu.getCdtopicID(), new Date());
			isOK = true;
			break;
		}
		case 9:{
			Teacher tea = new Teacher().queryTeacherByID(user.getTeacherID());
			user.updateUserName(user, user_name);
			tea.updateTeacher(tea, tea.getNum(), user_name, tea.getPosition(), new Date());
			isOK = true;
			break;
		}
		default:{
			request.getSession().invalidate();
			return;
		}
	}
    if(isOK==true){
    	session.setAttribute("message", "修改用户信息成功！");
	}else
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！修改用户信息失败！");
	out.print("<script>window.location.href = \"/CSMS/SWZJ/user/userManageInfo/userInfo.jsp\";</script>");

%>
