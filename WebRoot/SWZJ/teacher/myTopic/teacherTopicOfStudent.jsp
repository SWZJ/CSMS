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
<%@include file="/CommonView/teacherLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
 
    <div class="panel">
        <div class="panel-heading" >
            <h3 class="panel-title">选择了您课题的学生信息</h3>
            <div class="right">
                <a href="/CSMS/SWZJ/teacher/myTopic/studentAdd.jsp"><span class="label label-primary"><i class="fa fa-plus-square"></i>&nbsp;新增学生</span></a>
            </div>
        </div>
        <div class="panel-heading">
			<div class="container-fluid">
				<div class="row">
					<% int cdtopic_id = request.getParameter("cdtopic_id")== null ? 0 : Integer.parseInt(request.getParameter("cdtopic_id")); //课题ID %>
					<div class="col-md-8 col-sm-8 col-lg-8">
				        <form class="form-inline" id="searchForm" role="form" method="get" action="">
				            <div class="form-group">
				            	<span class="panel-title">信息查询&emsp;&emsp;&emsp;&emsp;</span>
				            	<div class="right" style="margin-top:-8px">
				            		<span>课题查询:</span>
				            		<select title="选择课题" id="cdtopic_id" name="cdtopic_id" class="form-control field">
				                    <option value = 0>不限课题</option>
				                    <%
			                        	List<CDTopic> cdtList = new CDTopic().queryByCondition(0, 2, user.getTeacherID(), "");
			                        	for(CDTopic cdtopic:cdtList){
			                        		out.print("<option value=\""+cdtopic.getID()+"\">"+cdtopic.getName()+"</option>");
			                        	}
			                         %>
				                </select>
				                <span class="form-group-btn"><a onclick="searchCDT()" class="btn btn-primary">查询</a></span>
				            	</div>
				                
				            </div>
				            <script type="text/javascript">
								function searchCDT() {
									document.getElementById("searchForm").submit();
								}
							</script>
				        </form>
				    </div>
				    <% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
				    <% if(new CDTopic().queryCDTopicByName(queryStr).size()!=0){cdtopic_id = new CDTopic().queryCDTopicByName(queryStr).get(0).getID();queryStr="";} %>
				    <% if(new CDTopic().queryCDTopicByNumber(queryStr).size()!=0){cdtopic_id = new CDTopic().queryCDTopicByNumber(queryStr).get(0).getID();queryStr="";} %>
			        <div class="col-md-4 col-sm-4 col-lg-4">
						<form role="form" class="form-horizontal" method="get" id="searchCDTopic" action="">
							<div class="input-group">
								<input class="form-control" name="queryStr" type="text" id="queryStr" value="<%=queryStr%>" placeholder="课题编号、名称、关键字或实现技术">
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
					<th>操作</th>
					<th>学号</th>
					<th>姓名</th>
					<th>性别</th>
					<th>年龄</th>
					<th>班级</th>
					<th>专业</th>
					<th>学院</th>
					<th>所选课题名称</th>
					</tr>
				</thead>
				<tbody>
				<%
					Student stu=new Student();
					CDTopic cdt = new CDTopic();
					cdtList = cdt.queryCDTopicByTeacherID(user.getTeacherID());
					int recordCount = 0;   		//记录总数
					if(cdtopic_id==0){
						for(CDTopic cdtopic:cdtList) {
							recordCount += stu.queryByCondition(0,cdtopic.getID(),0,0,0,queryStr).size();
						}
					}else{
						recordCount += stu.queryByCondition(0,cdtopic_id,0,0,0,queryStr).size();
					}
					
					int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
					int start=1;           					//显示开始页
					int end=10;            					//显示结束页
					int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
					int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
					
					Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
					Page = Page<1 ? 1 : Page;						//页码小于1的情况

					List<Student> cutList = new ArrayList<Student>();
					if(cdtopic_id==0){
						for(CDTopic cdtopic:cdtList) {
							cutList.addAll(stu.queryByCondition(0,cdtopic.getID(),0,0,0,queryStr));
						}
					}else{
						cutList.addAll(stu.queryByCondition(0,cdtopic_id,0,0,0,queryStr));
					}

					int count = recordCount;
		        	int head = Page*pageSize-pageSize;
		        	int foot;
		        	if(head == (count/pageSize)*pageSize) {
		        		foot = head+count%pageSize;
		        		cutList =  cutList.subList(head, foot);
		        	}else {
		        		foot = head+pageSize;
		        		cutList =  cutList.subList(head, foot);
		        	}
					for(Student student:cutList) {
						out.print("<tr>");
						out.print("<td>");
						out.print("<a href=\"#\" onclick=\"return confirm('确定要退选 "+student.getName()+" 吗？');\"><span class=\"label label-danger\">退选</span></a>");
						out.print("</td>");
						out.print("<td>"+student.getNum()+"</td>");
						out.print("<td>"+student.getName()+"</td>");
						out.print("<td>"+student.getSex()+"</td>");
						out.print("<td>"+student.getAge()+"</td>");
						out.print("<td>"+student.getClassName()+"</td>");
						out.print("<td>"+student.getMajorName()+"</td>");
						out.print("<td>"+student.getCollegeName()+"</td>");
						out.print("<td>"+student.getCDTopicName()+"</td>");
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
<!-- 选中课题 -->
<script>
	$("#cdtopic_id option").each(function() {
        if($(this).val()=='<%= cdtopic_id %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 选中课题 -->

</body>
</html>
