<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

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

<!-- ERROR TIP -->
<% String message = (String)session.getAttribute("message"); %>
<%if(message != null){
	if(message.indexOf("成功") != -1){
		out.print("<div class=\"alert alert-success alert-dismissible\" role=\"alert\">");
		out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
		out.print("<i class=\"fa fa-check-circle\"></i>"+message+"</div>");
	}else{
		out.print("<div class=\"alert alert-danger alert-dismissible\" role=\"alert\">");
		out.print("<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>");
		out.print("<i class=\"fa fa-close\"></i>"+message+"</div>");
	}
}%>
<% session.removeAttribute("message"); %>
<!-- END ERROR TIP -->
        
<% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
    <div class="panel">
        <div class="panel-heading" >
            <div class="container-fluid">
				<div class="row">
					<div class="col-md-8 col-sm-8 col-lg-8">
						<h3 class="panel-title">选择了您的课题的学生的课题报告</h3>
					</div>
					<div class="col-md-4 col-sm-4 col-lg-4">
						<form role="form" class="form-horizontal" method="get" id="searchFile" action="">
							<div class="input-group">
								<input type="hidden" name="location" value="reportOfStudent">
								<input type="hidden" name="branch" value="student">
								<input type="hidden" name="id" value="${user.getTeacherID()}">
								<input class="form-control" name="queryStr" type="text" id="queryStr"
								value="<%=queryStr%>" placeholder="学生姓名、学号、班级或课题关键字">
								<span class="input-group-btn"><a onclick="return searchFile()" class="btn btn-primary">搜索</a></span>
							</div>
							<script type="text/javascript">
								function searchFile() {
									if(document.getElementById("queryStr").value.length != 0){
										document.getElementById("searchFile").submit();
										return true;
									}else{
										return false;
									}
								}
							</script>
						</form>
					</div>
				</div>
			</div>
        </div>
        
		<div class="panel-body">
			<table class="table table-hover">
				<thead>
					<tr>
					<th>操作</th>
					<th>课题报告名称</th>
					<!-- <th></th> -->
					</tr>
				</thead>
				<tbody>
				<!-- 遍历Map集合 -->
				<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
				<c:forEach var="me" items="${fileNameMap}">
				<c:url value="/servlet/DownLoadServlet" var="downurl">
					<c:param name="filename" value="${me.key}"></c:param>
				</c:url>
					<tr>
					<td>
					<%if(queryStr.equals("")==true){%>
						<a href="${downurl}&location=teacherReportOfStudent&branch=student&id=${user.getTeacherID()}">下载</a>
					<%}else{%>
						<a href="${downurl}&location=teacherReportOfStudent&branch=student&id=${user.getTeacherID()}&queryStr=<%=queryStr%>">下载</a>
					<%}%>
					</td>
					<td>${me.value}</td>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		<%-- <!-- 选择页码 -->
		<%@include file="/HTML/selectPages.html" %> --%>

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
