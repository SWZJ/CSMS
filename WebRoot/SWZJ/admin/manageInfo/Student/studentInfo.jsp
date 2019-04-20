<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

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
	                <li><a href="/CSMS/logout.jsp?user_id=${user.getID()}&user_name=${user.getName()}"><i class="lnr lnr-exit"></i> <span>注销</span></a></li>
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

    <div class="panel">
    
        <div class="panel-heading" >
            <h3 class="panel-title">学生信息管理</h3>
            <div class="right">
                <a href="/CSMS/SWZJ/admin/manageInfo/Student/studentAdd.jsp"><span class="label label-primary"><i class="fa fa-plus-square"></i>&nbsp;新增学生</span></a>
            </div>
        </div>
		<div class="panel-heading">
			<div class="container-fluid">
				<div class="row">
					<% int coolege_id = request.getParameter("coolege_id")== null ? 0 : Integer.parseInt(request.getParameter("coolege_id")); //学院ID %>
					<% int major_id = request.getParameter("major_id")== null ? 0 : Integer.parseInt(request.getParameter("major_id")); //专业ID %>
					<% int class_id = request.getParameter("class_id")== null ? 0 : Integer.parseInt(request.getParameter("class_id")); //班级ID %>
					<div class="col-md-8 col-sm-8 col-lg-8">
				        <form class="form-inline" id="searchForm" role="form" method="post" action="">
				            <div class="form-group">
				            	<span class="panel-title">信息查询&emsp;&emsp;</span>
				            	<span>学院:</span>
				                <select title="选择学院" id="college_id" name="college_id" class="form-control field">
				                    <option value="">信息学院</option>
				                </select>
				                <span>专业:</span>
				                <select title="选择专业" id="major_id" name="major_id" class="form-control field">
				                    <option value="">计算机科学与技术</option>
				                </select>
				                <span>班级:</span>
				                <select title="选择班级" id="class_id" name="class_id" class="form-control field">
				                    <option value="">计科17-3BJ</option>
				                </select>
				                <span class="form-group-btn"><a onclick="return search()" class="btn btn-primary">查询</a></span>
				            </div>
				        </form>
				    </div>
				    <% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
				    <%-- <% if(new College().queryCollegeByName(queryStr).size()!=0){college_id = new College().queryCollegeByName(queryStr).get(0).getID();} %>
				    <% if(new Major().queryMajorByName(queryStr).size()!=0){major_id = new Major().queryMajorByName(queryStr).get(0).getID();} %>
				    <% if(new CLass().queryCLassByName(queryStr).size()!=0){class_id = new CLass().queryCLassByName(queryStr).get(0).getID();queryStr="";} %> --%>
			        <div class="col-md-4 col-sm-4 col-lg-4">
						<form role="form" class="form-horizontal" method="get" id="searchStudent" action="">
							<div class="input-group">
								<input class="form-control" name="queryStr" type="text" id="queryStr" value="<%=queryStr%>" placeholder="学生学号、姓名或关键字">
								<input type="hidden" name="college_id" value="<%=request.getParameter("college_id")== null ? 0 : Integer.parseInt(request.getParameter("college_id"))%>">
								<input type="hidden" name="major_id" value="<%=request.getParameter("major_id")== null ? 0 : Integer.parseInt(request.getParameter("major_id"))%>">
								<input type="hidden" name="class_id" value="<%=request.getParameter("class_id")== null ? 0 : Integer.parseInt(request.getParameter("class_id"))%>">
								<input type="hidden" name="selectPages" value="<%=request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages"))%>">
								<span class="input-group-btn"><a onclick="return searchStudent()" class="btn btn-primary">搜索</a></span>
							</div>
							<script type="text/javascript">
								function searchStudent() {
									if(document.getElementById("queryStr").value.length != 0){
										document.getElementById("searchStudent").submit();
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
					int recordCount = stu.queryByCondition(0,0,0,0,0,queryStr).size();   		//记录总数
					int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
					int start=1;           					//显示开始页
					int end=10;            					//显示结束页
					int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
					int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
					
					Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
					Page = Page<1 ? 1 : Page;						//页码小于1的情况

					List<Student> cutList = stu.cutPageData(Page, pageSize,0,0,0,0,0,queryStr);
					for(Student student:cutList) {
						out.print("<tr>");
						out.print("<td>");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentDetail.jsp?id="+student.getID()+"\">详情</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentAmend.jsp?id="+student.getID()+"\">修改</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/Student/studentDoDelete.jsp?id="+student.getID()+"\" onclick=\"if (confirm('确定要删除这条学生信息吗？') == false) return false;\">删除</a>");
						out.print("</td>");
						out.print("<td>"+student.getNum()+"</td>");
						out.print("<td>"+student.getName()+"</td>");
						out.print("<td>"+student.getSex()+"</td>");
						out.print("<td>"+student.getAge()+"</td>");
						out.print("<td>"+student.getClassName()+"</td>");
						out.print("<td>"+student.getMajorName()+"</td>");
						out.print("<td>"+student.getCollegeName()+"</td>");
						out.print("<td>"+student.getCDTopicName()+"</td>");
						/* out.print("<td>"+student.getCreated()+"</td>");
						out.print("<td>"+student.getUpdated()+"</td>"); */
					}
				%>
				</tbody>
			</table>
		</div>
		
		<!-- 选择页码 -->
		<%session.setAttribute("queryStr", queryStr);%>
		<%@include file="/HTML/selectPages.html" %>
		<%session.removeAttribute("queryStr");%>

	</div>
	
	<div>
		<div class="pull-left">
			<ul class="pagination">
				<% 
					String url = request.getRequestURI() + "?";
					if(request.getQueryString()!=null){
						url = request.getRequestURI() + "?" + URLDecoder.decode(request.getQueryString(),"utf-8") +"&";
					}
					if(url.indexOf("page")!=-1){
						int pageLen = 6+(Page+"").length();
						url = url.substring(0, url.length()-pageLen);
					}
					if(pageCount<=end){
						if(Page == 1){
							out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\""+url+"page=%d\">首页</a></li>",1));
						}
						
						end = pageCount;
						
						if(Page>1){
						  out.print(String.format("<li><a href=\""+url+"page=%d\">&laquo;</a></li>",Page-1));
						}
						
						for(int i=start;i<=end;i++){
						  if(i>pageCount) break;
						  String pageinfo=String.format("<li><a href=\""+url+"page=%d\">%d</a></li>",i,i);
						  if(i==Page){
						    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
						  }
						  out.print(pageinfo);
						}
						
						if(Page<pageCount){
						  out.print(String.format("<li><a href=\""+url+"page=%d\">&raquo;</a></li>",Page+1));
						}
						
						if(Page == pageCount){
							out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\""+url+"page=%d\">尾页</a></li>",pageCount));
						}
						
					}else{
						if(Page == 1){
							out.print(String.format("<li class=\"disabled\"><a>首页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\""+url+"page=%d\">首页</a></li>",1));
						}
						if(Page>=7){
						  start=Page-5;
						  end=Page+4;
						}
						if(start>(pageCount-10)){
						  start=pageCount-9;
						}
						if(Page>1){
						  out.print(String.format("<li><a href=\""+url+"page=%d\">&laquo;</a></li>",Page-1));
						}
						
						for(int i=start;i<=end;i++){
						  if(i>pageCount) break;
						  String pageinfo=String.format("<li><a href=\""+url+"page=%d\">%d</a></li>",i,i);
						  if(i==Page){
						    pageinfo=String.format("<li class=\"active\"><span>%d</span></li>",i);
						  }
						  out.print(pageinfo);
						}
						
						if(Page<pageCount){
						  out.print(String.format("<li><a href=\""+url+"page=%d\">&raquo;</a></li>",Page+1));
						}
						
						if(Page == pageCount){
							out.print(String.format("<li class=\"disabled\"><a>尾页</a></li>"));
						}else{
							out.print(String.format("<li><a href=\""+url+"page=%d\">尾页</a></li>",pageCount));
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
<%-- <!-- 选中学院 -->
<script>
	$("#cdtopic_id option").each(function() {
        if($(this).val()=='<%= college_id %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 选中学院 -->
<!-- 选中专业 -->
<script>
	$("#cdtopic_id option").each(function() {
        if($(this).val()=='<%= major_id %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 选中专业 -->
<!-- 选中班级 -->
<script>
	$("#cdtopic_id option").each(function() {
        if($(this).val()=='<%= class_id %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 选中班级 --> --%>


</body>
</html>