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
<!-- 导航栏 -->
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
            <h3 class="panel-title">课题信息管理</h3>
            <div class="right">
                <a href="/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicAdd.jsp"><span class="label label-primary"><i class="fa fa-plus-square"></i>&nbsp;新增课题</span></a>
            </div>
        </div>
        <div class="panel-heading">
			<div class="container-fluid">
				<div class="row">
					<div class="col-md-2 col-sm-2 col-lg-2">
						<h3 class="panel-title">信息查询</h3>
					</div>
					<% int teacher_id = request.getParameter("teacher_id")== null ? 0 : Integer.parseInt(request.getParameter("teacher_id")); //教师ID %>
					<div class="col-md-5 col-sm-5 col-lg-5">
				        <form class="form-inline" id="searchForm" role="form" method="get" action="">
				            <div class="form-group right">
				            	<span>教师查询:</span>
				                <select title="选择教师" id="teacher_id" name="teacher_id" class="form-control field">
				                	<option value = 0>不限教师</option>
			                       	<%
			                        	Teacher tea = new Teacher();
			                        	List<Teacher> teaList = tea.getTeacherInfo();
			                        	for(Teacher teacher:teaList){
			                        		out.print("<option value=\""+teacher.getID()+"\">"+teacher.getName()+"</option>");
			                        	}
			                         %>
				                </select>
				                <span class="form-group-btn"><a onclick="searchTeacher()" class="btn btn-primary">查询</a></span>
				            </div>
				            <script type="text/javascript">
								function searchTeacher() {
									document.getElementById("searchForm").submit();
								}
							</script>
				        </form>
				    </div>
				    <% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
				    <% if(new Teacher().queryTeacherByName(queryStr).size()!=0){teacher_id = new Teacher().queryTeacherByName(queryStr).get(0).getID();queryStr="";} %>
			        <div class="col-md-5 col-sm-5 col-lg-5">
						<form role="form" class="form-horizontal" method="get" id="searchCDTopic" action="">
							<div class="input-group">
								<input class="form-control" name="queryStr" type="text" id="queryStr" value="<%=queryStr%>" placeholder="课题编号、名称、关键字、实现技术或教师姓名">
								<input type="hidden" name="teacher_id" value="<%=request.getParameter("teacher_id")== null ? 0 : Integer.parseInt(request.getParameter("teacher_id"))%>">
								<input type="hidden" name="selectPages" value="<%=request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages"))%>">
								<span class="input-group-btn"><a onclick="return searchCDTopic()" class="btn btn-primary">搜索</a></span>
							</div>
							<script type="text/javascript">
								function searchCDTopic() {
									if(document.getElementById("queryStr").value.length != 0){
										document.getElementById("searchCDTopic").submit();
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
					<th>编号</th>
					<th>名称</th>
					<th>关键字</th>
					<!-- <th>实现技术</th> -->
					<th>人员数</th>
					<th>所属教师</th>
					<th>生效状态</th>
					<!-- <th>添加时间</th>
					<th>修改时间</th> -->
					</tr>
				</thead>
				<tbody>
				<%
					CDTopic cdt=new CDTopic();
					/* cdt.refreshHeadcountOfAll();//刷新所有课题的人员数 */
					int recordCount = cdt.queryByCondition(0,2,teacher_id,queryStr).size();   	//记录总数
					int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
					int start=1;           					//显示开始页
					int end=10;            					//显示结束页
					int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
					int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
					
					Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
					Page = Page<1 ? 1 : Page;						//页码小于1的情况

					List<CDTopic> cutList = cdt.cutPageData(Page,pageSize,0,2,teacher_id,queryStr);
					for(CDTopic cdtopic:cutList) {
						out.print("<tr>");
						out.print("<td>");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicDetail.jsp?id="+cdtopic.getID()+"\">详情</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicAmend.jsp?id="+cdtopic.getID()+"\">修改</a>&ensp;");
						out.print("<a href=\"/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicDoDelete.jsp?id="+cdtopic.getID()+"\" onclick=\"if (confirm('确定要删除这个课题吗？') == false) return false;\">删除</a>");
						out.print("</td>");
						out.print("<td>"+cdtopic.getNum()+"</td>");
						out.print("<td>"+cdtopic.getName()+"</td>");
						out.print("<td>"+cdtopic.getKeyword()+"</td>");
						/* out.print("<td>"+cdtopic.getTechnology()+"</td>"); */
						out.print("<td>"+cdtopic.getHeadcount()+"</td>");
						out.print("<td>"+cdtopic.getTeacherName()+"</td>");
						out.print("<td>"+cdtopic.getActiveStr()+"</td>");
						/* out.print("<td>"+cdtopic.getCreated()+"</td>");
						out.print("<td>"+cdtopic.getUpdated()+"</td>"); */
					}
				%>
				</tbody>
			</table>
		</div>
		
		<!-- 选择页码 -->
		<%@include file="/CommonView/selectPages.jsp" %>

	</div>
	
	<!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %>

</div>
<!-- END MAIN CONTENT -->
</div>
<!-- END 内容区域 -->

<!-- 页尾 -->
<%@include file="/CommonView/foot.jsp" %>
</div><!-- END WRAPPER -->
<!-- Javascript -->
<%@include file="/CommonView/javaScript.jsp" %>
<!-- 选中教师 -->
<script>
	$("#teacher_id option").each(function() {
        if($(this).val()=='<%= teacher_id %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 选中教师 -->

</body>
</html>
