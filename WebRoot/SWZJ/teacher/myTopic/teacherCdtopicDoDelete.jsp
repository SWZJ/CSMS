<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
	Integer cdtopic_id = Integer.valueOf(request.getParameter("id"));
	
	CDTopic cdt = new CDTopic().queryCDTopicByID(cdtopic_id);
    Teacher tea = new Teacher().queryTeacherByID(cdt.getTeacherID());
    Message mes = new Message();
	//消息概述
	String message_summary = "课题 "+cdt.getName()+" 被删除";
	//消息内容
	String message_content = "你选择的课题 "+cdt.getName()+" 被其所属教师 "+tea.getName()+" 删除了,请留意。";
	//消息发送者用户ID
	int sender_id = 1;//系统消息
	//消息接收者用户ID
	List<Student> stuList = new Student().queryStudentByCDTopic(cdtopic_id);
	ArrayList<Integer> receiver_list = new ArrayList<Integer>();
	for(Student stu:stuList) {
		if(stu.getUserID()!=1)
			receiver_list.add(stu.getUserID());
	}
	//发送消息
	mes.sendMoreMessage(4, message_summary, message_content, sender_id, receiver_list);
		
    if(new Student().emptyCDTopicByCDTopicID(cdtopic_id)&&new Grade().deleteGradeByCDTopicID(cdtopic_id)&&cdt.deleteCDTopic(cdtopic_id)){//删除课题信息时，先将学生表中对应的课题信息置空+所有课题评分数据
    	new Teacher().refreshCDTopicCountOfAll();//刷新教师拥有的课题总数
    	session.setAttribute("message", "删除课题 "+cdt.getName()+" 成功！");
	}else{
		session.setAttribute("message", "遇到未知错误！可能是服务器正在维护或者其他未知原因！删除课题 "+cdt.getName()+" 失败！");
	}
	out.print("<script>window.location.href = \"/CSMS/SWZJ/teacher/myTopic/teacherAllTopic.jsp\";</script>");
    
%>