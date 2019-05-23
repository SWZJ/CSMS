<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*,fileController.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<!-- 导航栏 -->
<%@include file="/CommonView/navbar.jsp" %>
<!-- 左侧边栏 -->
<%@include file="/CommonView/studentLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
        
<% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
    <div class="panel">
        <div class="panel-heading" >
            <div class="container-fluid">
				<div class="row">
					<div class="col-md-8 col-sm-8 col-lg-8">
						<h3 class="panel-title">您提交过的课题报告</h3>
					</div>
					<div class="col-md-4 col-sm-4 col-lg-4">
						<form role="form" class="form-horizontal" method="get" id="searchFile" action="">
							<div class="input-group">
								<input class="form-control" name="queryStr" type="text" id="queryStr" disabled="disabled"
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
					<th>&ensp;文件操作</th>
					<th>课题报告名称</th>
					<!-- <th></th> -->
					</tr>
				</thead>
				<tbody>
				<!-- 遍历Map集合 -->
				<%ListFile list = new ListFile();list.getFileMap(request, response, "student", 0, user.getName()); %>
				<% int teacher_id = new CDTopic().queryCDTopicByID(new Student().queryStudentByID(user.getStudentID()).getCdtopicID()).getTeacherID(); user.setTeacherID(teacher_id); %>
				<c:forEach var="me" items="${fileNameMap}">
				<c:url value="/servlet/DownLoadServlet" var="downurl">
					<c:param name="filename" value="${me.key}"></c:param>
				</c:url>
				<c:url value="/servlet/DeleteFileServlet" var="deleteurl">
					<c:param name="filename" value="${me.key}"></c:param>
				</c:url>
					<tr>
						<td>
							<a href="${downurl}&location=studentMyReport&branch=student&id=${user.getTeacherID()}">下载</a>&ensp;
							<a href="${deleteurl}&location=studentMyReport&branch=student&id=${user.getTeacherID()}" onclick="return confirm('确定要删除这个课题报告吗？')">删除</a>
						</td>
						<td>${me.value}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		
		<!-- 选择页码 -->
		<%@include file="/CommonView/selectPages.jsp" %>

	</div>
	
	<!-- 分页 -->
	<%-- <%@include file="/CommonView/pagination.jsp" %> --%>
	
</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>

</body>
</html>
