<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 编号验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_number.js"></script>
<!-- 姓名验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_name.js"></script>
<!-- 职称验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_position.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var teacher_number = checkTeacher_number();  
		var teacher_name = checkTeacher_name();
		var teacher_position = checkTeacher_position();
		if(teacher_number&&teacher_name&&teacher_position){
			return true;
		}else{  
			return false;  
		}
	} 
</script>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<!-- 导航栏 -->
<% User user = (User)session.getAttribute("user");	List<Message> mesList = new Message().queryMessageOfNew(user.getID(),false);	int messageCount = mesList.size(); %>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="brand">
    	<a href="/CSMS/index.jsp"><img src="/CSMS/public/assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
    </div>
    <div class="container-fluid">
        <div class="navbar-btn">
            <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
        </div>
        <div id="navbar-menu">
        <ul class="nav navbar-nav navbar-right">
	        <li class="dropdown">
		        <a href="#" class="dropdown-toggle icon-menu" data-toggle="dropdown">
		            <i class="lnr lnr-alarm"></i>
		            <span class="badge bg-danger" id="alarm_count"><%= messageCount==0?"":messageCount %></span>
		        </a>
		        <ul class="dropdown-menu notifications" id="message_menu">
<%
	for(int i =0;i < messageCount;i++){
		out.print("<li><a href=\"/CSMS/SWZJ/message/myMessage.jsp?id="+mesList.get(i).getID()+"\" class=\"notification-item\"><span class=\"dot "+mesList.get(i).getType()+"\"></span>"+mesList.get(i).getSummary()+"</a></li>");
	}
	if(messageCount != 0){
		out.print("<li><a href=\"/CSMS/SWZJ/message/myMessage.jsp\" class=\"more\">查看所有通知</a></li>");
	}else{
		out.print("<li><a href=\"#\" class=\"more\">未收到通知</a></li>");
	}
%>
		        </ul>
	    	</li>
	        <li class="dropdown">
	            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	                <img src="/CSMS/public/assets/img/jzw.jpg" class="img-circle" alt="Avatar">
	                <span id="user_昵称">${user.getName()}</span>
	                <i class="icon-submenu lnr lnr-chevron-down"></i>
	            </a>
	            <ul class="dropdown-menu">
	                <li><a href="#"><i class="lnr lnr-user"></i> <span>我的信息</span></a></li>
	                <li><a href="/CSMS/SWZJ/message/myMessage.jsp"><i class="lnr lnr-envelope"></i> <span>Message</span></a></li>
	                <li><a href="#"><i class="lnr lnr-cog"></i> <span>设置</span></a></li>
	                <li><a href="/CSMS/logout.jsp"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
	            </ul>
	        </li>
        </ul>
    	</div>
    </div>
</nav>
<!-- 左侧边栏 -->
<%@include file="/HTML/adminLeftSidebar.html" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">
        
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">新增课题信息填写</h3>
        </div>
        <div class="panel-body">
            <form name="CDTopicForm" class="form-horizontal" role="form" method="post" 
            action="/CSMS/SWZJ/admin/manageInfo/Teacher/teacherDoAdd.jsp" onsubmit="return checkAll()" >
                
                <div class="form-group" id="teacher_number_class">
                    <label for="teacher_number" class="col-sm-2 control-label"><a class="text-danger">*</a>编号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="teacher_number" name="teacher_number" 
                        placeholder="请输入教师编号（全为数字且长度为10）" value="" onblur="checkTeacher_number()">
                        <span id="teacher_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="teacher_name_class">
                    <label for="teacher_name" class="col-sm-2 control-label"><a class="text-danger">*</a>名称</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="teacher_name" name="teacher_name" 
                        placeholder="请输入教师姓名" value="" onblur="checkTeacher_name()">
                        <span id="teacher_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="teacher_position_class">
                    <label for="teacher_position" class="col-sm-2 control-label"><a class="text-danger">*</a>职称</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="teacher_position" name="teacher_position" onblur="checkTeacher_position()">
	                        <option value = "">--请选择教师职称--</option>
	                        <option value = "助教">助教</option>
	                        <option value = "讲师">讲师</option>
	                        <option value = "副教授">副教授</option>
	                        <option value = "教授">教授</option>
	                        <option value = "博士生导师">博士生导师</option>
                        </select>
                        <span id="teacher_position_span"></span>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-6">
                        <button type="submit" class="btn btn-primary">提交</button>
                        <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
                    </div>
                </div>

            </form>
        </div>
    </div>

</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/HTML/foot.html" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/HTML/javaScript.html" %>

</body>
</html>