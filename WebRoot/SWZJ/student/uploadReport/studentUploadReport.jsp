<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,fileController.FileManage" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/HTML/head.html" %>

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
	                <li><a href="/CSMS/SWZJ/user/userCenter.jsp" target="_blank"><i class="lnr lnr-user"></i> <span>个人中心</span></a></li>
	                <li><a href="/CSMS/SWZJ/message/myMessage.jsp"><i class="lnr lnr-bubble"></i> <span>Message</span></a></li>
	                <li><a href="/CSMS/SWZJ/user/set/userSet.jsp" target="_blank"><i class="lnr lnr-cog"></i> <span>设置</span></a></li>
	                <li><a href="/CSMS/logout.jsp?user_id=${user.getID()}&user_name=${user.getName()}"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
	            </ul>
	        </li>
        </ul>
    	</div>
    </div>
</nav>
<!-- 左侧边栏 -->
<%@include file="/HTML/studentLeftSidebar.html" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- ERROR TIP -->
<!-- END ERROR TIP -->
     
     <%Student student = new Student().queryStudentByID(user.getStudentID()); %>
     <%int reportCount = new FileManage().fileCount("student", 0, user.getName()); %>
     <div style="padding: 80px 0px;text-align: center">
        <h2>上传我的课题报告</h2><hr>
        <h4><span style="color:red">上传要求：</span>文件名中必须含课题名称、班级、姓名和学号。（例：神葳计划 计科17-3BJ 李浩葳 14172401437）</h4>
        <p><span  style="color:#E308E4">最多上传10篇报告</span>&ensp;&ensp;&ensp;已上传报告数：<%=reportCount %></p>
        <form method="post" action="${pageContext.request.contextPath}/servlet/UploadHandleServlet?branch=student&id=${user.getTeacherID()}" onsubmit="return checkFile()?checkID():false" target="_self" enctype="multipart/form-data">
        	<input type="hidden" name="username" value="${user.getName()}">
            <button type="button" class="btn btn-default" onclick="transferclick()" style="margin: 40px">
                <span class="glyphicon glyphicon-inbox" style="font-size: 100px" title="选择课题报告文件"></span>
            </button>
            <p id="nametarget">请选择上传文件</p>
            <input type="file" name="thesis" id="thesis" accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document" onchange="showfilename()" style="padding: 10px;display:none">
            <button type="submit" class="btn btn-primary" title="上传课题报告">上传</button>
        </form>
    </div>

    <script>
        function transferclick() {
            document.getElementById("thesis").click();
        }

        function showfilename() {
            var file=document.getElementById("thesis");
            var nametarget=document.getElementById("nametarget");
            var filename = "请选择上传文件";
            if(file.files[0] != undefined){
                filename=file.files[0].name;
            }
            nametarget.innerText=filename;
        }
        
		function checkFile(){
			var file=document.getElementById("thesis");
            if(file.files[0] != undefined){
            	var filename=file.files[0].name;
            	var reportCount = '<%=reportCount%>';
            	if(	filename.indexOf('<%=student.getCDTopicName()%>')!=-1&&
            		filename.indexOf('<%=student.getClassName()%>')!=-1&&
            		filename.indexOf('<%=student.getName()%>')!=-1&&
            		filename.indexOf('<%=student.getNum()%>')!=-1&&
            		reportCount<=10){
            		return true;
            	}else{
            		alert("上传文件失败！原因可能有：\n1、文件名不符合要求；\n2、文件名中的课题名称、班级、姓名或学号有误；\n3、上传报告数量已超限。");
            		return false;
            	}  
            }else{
            	alert("上传文件不能为空！");
            	return false;
            }
		}
		
		function checkID(){
			var teacher_id = ${user.getTeacherID()};
			if(teacher_id!=0){
				return true;
			}else{
				alert("你还未选择课题无法上传课题报告！！！");
				return false;
			}
		}
		
    </script>


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