<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,java.net.URLDecoder" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<%@include file="/CommonView/navbar.jsp" %>
<!-- 左侧边栏 -->
<%@include file="/CommonView/adminLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

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
	<%@include file="/CommonView/selectPages.jsp" %>
	<!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %>

	</div>

</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>
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