<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

<!-- 编号验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_number.js"></script>
<!-- 名称验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_name.js"></script>
<!-- 关键字验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_keyword.js"></script>
<!-- 实现技术验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_technology.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var cdtopic_number = checkCDTopic_number();  
		var cdtopic_name = checkCDTopic_name();
		var cdtopic_keyword = checkCDTopic_keyword();
		var cdtopic_technology = checkCDTopic_technology();
		if(cdtopic_number&&cdtopic_name&&cdtopic_keyword&&cdtopic_technology){
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
<%@include file="/HTML/teacherLeftSidebar.html" %>

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
            action="/CSMS/SWZJ/teacher/createTopic/teacherCdtopicDoAdd.jsp" onsubmit="return checkAll()" >
                
                <div class="form-group" id="cdtopic_number_class">
                    <label for="cdtopic_number" class="col-sm-2 control-label"><a class="text-danger">*</a>编号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_number" name="cdtopic_number" 
                        placeholder="请输入课题编号（长度为10—12，例如：2019JZW12137）" value="" onblur="checkCDTopic_number()">
                        <span id="cdtopic_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="cdtopic_name_class">
                    <label for="cdtopic_name" class="col-sm-2 control-label"><a class="text-danger">*</a>名称</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_name" name="cdtopic_name" 
                        placeholder="请输入课题名称" value="" onblur="checkCDTopic_name()">
                        <span id="cdtopic_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="cdtopic_keyword_class">
                    <label for="cdtopic_keyword" class="col-sm-2 control-label"><a class="text-danger"></a>关键字</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_keyword" name="cdtopic_keyword" 
                        placeholder="请输入课题关键字" value="" onblur="checkCDTopic_keyword()">
                        <span id="cdtopic_keyword_span"></span>
                    </div>
                </div>
	
                <div class="form-group" id="cdtopic_technology_class">
                    <label for="cdtopic_实现技术" class="col-sm-2 control-label"><a class="text-danger"></a>实现技术</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_technology" name="cdtopic_technology" 
                        placeholder="请输入课题实现技术" value="" onblur="checkCDTopic_technology()">
                        <span id="cdtopic_technology_span"></span>
                    </div>
                </div>

                <div class="form-group" id="teacher_id_class">
                    <label for="teacher_id" class="col-sm-2 control-label"><a class="text-danger"></a>所属教师</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="teacher_id" name="teacher_id" disabled="disabled">
	                        <option value = 0>--请选择所属教师--</option>
	                       	<%
	                        	Teacher tea = new Teacher();
	                        	List<Teacher> teaList = tea.getTeacherInfo();
	                        	for(Teacher teacher:teaList){
	                        		out.print("<option value=\""+teacher.getID()+"\">"+teacher.getName()+"</option>");
	                        	}
	                         %>
                        </select>
                        <span id="teacher_id_span"></span>
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
<!-- 获取所属教师 -->
<script>
	$("#teacher_id option").each(function() {
        if($(this).val()==${user.getTeacherID()}){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取所属教师 -->

</body>
</html>
