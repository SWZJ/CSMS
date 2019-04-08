<%@ page language="java" import="java.util.*,JZW.*,java.text.DateFormat,java.text.SimpleDateFormat" pageEncoding="utf-8"%>
<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>

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
	                <li><a href="#"><i class="lnr lnr-envelope"></i> <span>Message</span></a></li>
	                <li><a href="#"><i class="lnr lnr-cog"></i> <span>设置</span></a></li>
	                <li><a href="/CSMS/logout.jsp"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
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
        
<!-- MY SELECTED PROJECT -->
	<% CDTopic cdt = new CDTopic().queryCDTopicByID(new Student().queryStudentByID(user.getStudentID()).getCdtopicID()); %>
	<div class="panel">
		<div class="panel-heading">
			<h3 class="panel-title">您选择的课题</h3>
			<div class="right">
				<button type="button" class="btn-remove"><i class="lnr lnr-cross"></i></button>
			</div>
		</div>
		<%if(cdt.getID()!=0){%>
		<table class="table table-hover">
			<thead>
				<tr>
				<th>操作</th>
				<th>编号</th>
				<th>名称</th>
				<th>关键字</th>
				<th>实现技术</th>
				<th>人员数</th>
				<th>教师</th>
				<th>职称</th>
				<th>生效状态</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<td><a href="#" onclick="return confirm('确定要退选这个课题吗？');"><span class="label label-danger">退选课题</span></a></td>
				<td><%= cdt.getNum() %></td>
				<td><%= cdt.getName() %></td>
				<td><%= cdt.getKeyword() %></td>
				<td><%= cdt.getTechnology() %></td>
				<td><%= cdt.getHeadcount() %></td>
				<td><%= cdt.getTeacherName() %></td>
				<td><%= new Teacher().queryTeacherByID(cdt.getTeacherID()).getPosition() %></td>
				<td><%= cdt.getActiveStr() %></td>
				</tr>
			</tbody>
		</table>
		<%}else{%>
		<div style="text-align: center">
        <h3>你还未选择课题</h3><br>
    	</div>
		<%}%>
	</div>
<!-- END MY SELECTED PROJECT -->
    	
    
    
   	<div class="panel">
   	
		<div class="panel-heading">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-8 col-sm-8 col-lg-8">
						<h3 class="panel-title">可选课题</h3>
					</div>
					<div class="col-md-4 col-sm-4 col-lg-4">
						<form role="form" class="form-horizontal" method="get" action="" id="searchTeacherForm">
							<div class="input-group">
								<input class="form-control" name="teacherName" type="text" placeholder="请输入教师姓名">
								<span class="input-group-btn"><a onclick="searchTeacher()" class="btn btn-primary">搜索</a></span>
							</div>
							<script type="text/javascript">
								function searchTeacher() {
								    document.getElementById("searchTeacherForm").submit();
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
					<th>操作管理</th>
					<th>学号</th>
					<th>姓名</th>
					<th>性别</th>
					<th>年龄</th>
					<th>班级</th>
					<th>专业</th>
					<th>学院</th>
					<th>所选课题名称</th>
					<!-- <th>添加时间</th>
					<th>修改时间</th> -->
					</tr>
				</thead>
				<tbody>
				<%
					Student stu=new Student();
					int recordCount = stu.Count();   		//记录总数
					int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
					int start=1;           					//显示开始页
					int end=10;            					//显示结束页
					int pageCount = recordCount%pageSize==0 ? recordCount/pageSize : recordCount/pageSize+1; 				//计算总页数
					int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
					
					Page = Page<1 ? 1 : Page;						//页码小于1的情况
					Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况

					List<Student> cutList = stu.cutPageData(Page, pageSize);
					for(Student student:cutList) {
						out.print("<tr>");
						out.print("<td>");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentDetail.jsp?id="+student.getID()+"\">详情</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentAmend.jsp?id="+student.getID()+"\">修改</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentDoDelete.jsp?id="+student.getID()+"\" onclick=\"if (confirm('确定要删除这条学生信息吗？') == false) return false;\">删除</a>");
						out.print("<th>"+student.getNum()+"</th>");
						out.print("<th>"+student.getName()+"</th>");
						out.print("<th>"+student.getSex()+"</th>");
						out.print("<th>"+student.getAge()+"</th>");
						out.print("<th>"+student.getClassName()+"</th>");
						out.print("<th>"+student.getMajorName()+"</th>");
						out.print("<th>"+student.getCollegeName()+"</th>");
						out.print("<th>"+student.getCDTopicName()+"</th>");
						/* out.print("<th>"+student.getCreated()+"</th>");
						out.print("<th>"+student.getUpdated()+"</th>"); */
					}
				%>
				</tbody>
			</table>
		</div>
		
		<!-- 选择页码 -->
		<%@include file="/HTML/selectPages.html" %>

	</div>
	
	<div>
		<div class="pull-left">
			<ul class="pagination">
				<% 
					if(pageCount<=end){
						if(Page == 1){
							out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">首页</a></li>",pageSize,1));
						}
						
						end = pageCount;
						
						if(Page>1){
						  out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">&laquo;</a></li>",pageSize,Page-1));
						}
						
						for(int i=start;i<=end;i++){
						  if(i>pageCount) break;
						  String pageinfo=String.format("<li><a href=\"?selectPages=%d&page=%d\">%d</a></li>",pageSize,i,i);
						  if(i==Page){
						    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
						  }
						  out.print(pageinfo);
						}
						
						if(Page<pageCount){
						  out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">&raquo;</a></li>",pageSize,Page+1));
						}
						
						if(Page == pageCount){
							out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">尾页</a></li>",pageSize,pageCount));
						}
						
					}else{
						if(Page == 1){
							out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">首页</a></li>",pageSize,1));
						}
						if(Page>=7){
						  start=Page-5;
						  end=Page+4;
						}
						if(start>(pageCount-10)){
						  start=pageCount-9;
						}
						if(Page>1){
						  out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">&laquo;</a></li>",pageSize,Page-1));
						}
						
						for(int i=start;i<=end;i++){
						  if(i>pageCount) break;
						  String pageinfo=String.format("<li><a href=\"?selectPages=%d&page=%d\">%d</a></li>",pageSize,i,i);
						  if(i==Page){
						    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
						  }
						  out.print(pageinfo);
						}
						
						if(Page<pageCount){
						  out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">&raquo;</a></li>",pageSize,Page+1));
						}
						
						if(Page == pageCount){
							out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\"?selectPages=%d&page=%d\">尾页</a></li>",pageSize,pageCount));
						}
					}
			     %>
			</ul>
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
<!-- SELECT  -->
<script>
   $(document).ready(function(){
       //页面行数改变，刷新页面
       $("#selectPages").change(function(){
           $("#pageNumForm").submit();
       });
   });
</script>
<!-- END SELECT  -->
<!-- GET SELECT PAGES FROM INPUT -->
<script>
	$("#selectPages option").each(function() {
        if($(this).val()=='<%= pageSize %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END GET SELECT PAGES FROM INPUT -->


</body>
</html>