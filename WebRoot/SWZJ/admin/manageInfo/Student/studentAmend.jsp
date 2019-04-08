<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 学号验证JS -->
<script src="/CSMS/ValidateJS/Student/student_number.js"></script>
<!-- 姓名验证JS -->
<script src="/CSMS/ValidateJS/Student/student_name.js"></script>
<!-- 性别验证JS -->
<script src="/CSMS/ValidateJS/Student/student_sex.js"></script>
<!-- 年龄验证JS -->
<script src="/CSMS/ValidateJS/Student/student_age.js"></script>
<!-- 班级验证JS -->
<script src="/CSMS/ValidateJS/Student/student_class.js"></script>
<!-- 专业验证JS -->
<script src="/CSMS/ValidateJS/Student/student_major.js"></script>
<!-- 学院验证JS -->
<script src="/CSMS/ValidateJS/Student/student_college.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var student_number = checkStudent_number();  
		var student_name = checkStudent_name();
		var student_sex = checkStudent_sex();
		var student_age = checkStudent_age();
		var student_class = checkStudent_class();
		var student_major =  checkStudent_major();
		var student_college =  checkStudent_college();
		if(student_number&&student_name&&student_sex&&student_age&&student_class&&student_major&&student_college){
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

	<%
		int student_id = Integer.valueOf(request.getParameter("id"));
		Student stuOld = new Student();
		stuOld = stuOld.queryStudentByID(student_id);
		session.setAttribute("studentOld", stuOld);
	 %>
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">修改学生信息</h3>
        </div>
        <div class="panel-body">
            <form name="studentForm" class="form-horizontal" role="form" method="post" 
            action="/CSMS/SWZJ/admin/manageInfo/Student/studentDoAmend.jsp" onsubmit="return checkAll()" >
                
                <div class="form-group" id="student_number_class">
                    <label for="student_number" class="col-sm-2 control-label"><a class="text-danger">*</a>学号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_number" name="student_number" 
                        placeholder="请输入学生学号（全为数字且长度为11）" value="<%= stuOld.getNum() %>" onblur="checkStudent_number()">
                        <span id="student_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="student_name_class">
                    <label for="student_name" class="col-sm-2 control-label"><a class="text-danger">*</a>姓名</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_name" name="student_name" 
                        placeholder="请输入学生姓名" value="<%= stuOld.getName() %>" onblur="checkStudent_name()">
                        <span id="student_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_sex_class">
                    <label for="student_sex" class="col-sm-2 control-label"><a class="text-danger">*</a>性别</label>
                    <div class="col-sm-8">
                    	&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="男">男</label>
		    			&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="女">女</label>
						&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="未知" onblur="checkStudent_sex()">未知</label>
						<label class="control-label text-danger" for="student_sex">&emsp;</label><br>
						<span id="student_sex_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_age_class">
                    <label for="student_age" class="col-sm-2 control-label"><a class="text-danger"></a>年龄</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_age" name="student_age" 
                        placeholder="请输入学生年龄" value="<%= stuOld.getAge()=="未知"?"":stuOld.getAge() %>" onblur="checkStudent_age()">
                        <span id="student_age_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_class_class">
                    <label for="student_class" class="col-sm-2 control-label"><a class="text-danger">*</a>班级</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="student_class" name="student_class" onblur="checkStudent_class()">
	                        <option value = 0>--请选择所属班级--</option>
	                        <option value = 1>计科17-3BJ</option>
                        </select>
                        <span id="student_class_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_major_class">
                    <label for="student_major" class="col-sm-2 control-label"><a class="text-danger">*</a>专业</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="student_major" name="student_major" onblur="checkStudent_major()">
	                        <option value = 0>--请选择所属专业--</option>
	                        <option value = 1>计算机科学与技术</option>
                        </select>
                        <span id="student_major_span"></span>
                    </div>
                </div>

				<div class="form-group" id="student_college_class">
                    <label for="student_college" class="col-sm-2 control-label"><a class="text-danger">*</a>学院</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="student_college" name="student_college" onblur="checkStudent_college()">
	                        <option value = 0>--请选择所属学院--</option>
	                        <option value = 1>信息学院</option>
                        </select>
                        <span id="student_college_span"></span>
                    </div>
                </div>


                <div class="form-group" id="cdtopic_id_class">
                    <label for="cdtopic_id" class="col-sm-2 control-label"><a class="text-danger"></a>选择课题</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="cdtopic_id" name="cdtopic_id">
	                        <option value = 0>--请选择课题名称--</option>
	                        <%
	                        	CDTopic cdt = new CDTopic();
	                        	List<CDTopic> cdtList = cdt.getCDTopicInfo();
	                        	for(CDTopic cdtopic:cdtList){
	                        		out.print("<option value=\""+cdtopic.getID()+"\">"+cdtopic.getName()+"</option>");
	                        	}
	                         %>
                        </select>
                        <span id="cdtopic_id_span"></span>
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


<!-- 获取性别 -->
<script>
	$("#student_sex[type='radio']").each(function() {
        if($(this).val()=='<%= stuOld.getSex() %>'){
        	$(this).prop('checked',true);
       	}
    });
</script>
<!-- END 获取性别 -->
<!-- 获取班级 -->
<script>
	$("#student_class option").each(function() {
        if($(this).val()=='<%= stuOld.getClassID() %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取班级 -->
<!-- 获取专业 -->
<script>
	$("#student_major option").each(function() {
        if($(this).val()=='<%= stuOld.getMajorID() %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取专业 -->
<!-- 获取学院 -->
<script>
	$("#student_college option").each(function() {
        if($(this).val()=='<%= stuOld.getCollegeID() %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取学院 -->
<!-- 获取选择的课题 -->
<script>
	$("#cdtopic_id option").each(function() {
        if($(this).val()=='<%= stuOld.getCdtopicID() %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取选择的课题 -->

</body>
</html>