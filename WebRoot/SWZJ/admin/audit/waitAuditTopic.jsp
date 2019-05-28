<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

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
	<% String queryStr = request.getParameter("queryStr")== null ? "" : request.getParameter("queryStr"); //搜索字段 %>
	<%
		CDTopic cdt=new CDTopic();
		int recordCount = cdt.queryByCondition(0,2,0,0,queryStr).size();   		//记录总数
		int pageSize = request.getParameter("selectPages")==null ? 10 : Integer.parseInt(request.getParameter("selectPages")); //每页记录数
		int start=1;           					//显示开始页
		int end=10;            					//显示结束页
		int pageCount = recordCount%pageSize==0 ? (recordCount/pageSize==0?1:recordCount/pageSize) : recordCount/pageSize+1;	//计算总页数
		int Page = request.getParameter("page")==null ? 1 : Integer.parseInt(request.getParameter("page"));		//获取当前页面的页码
		
		Page = Page>pageCount ? pageCount : Page;		//页码大于最大页码的情况
		Page = Page<1 ? 1 : Page;						//页码小于1的情况

		List<CDTopic> cutList = cdt.cutPageData(Page,pageSize,0,2,0,0,"created_at","ASC",queryStr);
		request.setAttribute("cutList", cutList);
	%>
	
    <div class="panel" id="waitAuditPanel">
        <div class="panel-heading" >
            <h3 class="panel-title">待审核课题</h3>
        </div>
        <div class="panel-heading">
			<div class="container-fluid">
				<div class="row">
					<% int cdtopic_id = request.getParameter("cdtopic_id")== null ? 0 : Integer.parseInt(request.getParameter("cdtopic_id")); //课题ID %>
					<div class="col-md-8 col-sm-8 col-lg-8">
				        <form class="form-inline" id="searchForm" role="form" method="get" action="">
				            <div class="form-group">
				            	<span class="panel-title">信息查询&emsp;&emsp;&emsp;&emsp;</span>
				            </div>
				        </form>
				    </div>
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
					<th>操作管理</th>
					<th>课题编号</th>
					<th>课题名称</th>
					<th>关键字</th>
					<th>实现技术</th>
					<th>所属教师</th>
					<th>提交时间</th>
					<!-- <th>修改时间</th> -->
					</tr>
				</thead>
				<tbody>
				
				<c:forEach var="cdt" items="${cutList}" varStatus="floor">
					<tr>
					<td>
					<a href="javascript:void;" onclick="passTopic(this.type);" type="${cdt.getID()}"><span class="label label-success"><i class="fa fa-check-circle"></i> 通过</span></a>
					<a href="javascript:void;" onclick="vetoTopic(this.type);" type="${cdt.getID()}"><span class="label label-danger"><i class="fa fa-times-circle"></i> 否决</span></a>
					<a href="topicDetail.jsp?id=${cdt.getID() }"><span class="label label-primary"><i class="fa fa-sticky-note-o"></i> 详情</span></a>
					</td>
					<td>${cdt.getNum() }</td>
					<td>${cdt.getName() }</td>
					<td>${cdt.getKeyword() }</td>
					<td>${cdt.getTechnology() }</td>
					<td>${cdt.getTeacherName() }</td>
					<td>${cdt.getCreated() }</td>
					<%-- <td>${cdt.getUpdated() }</td> --%>
					</tr>
				</c:forEach>

				</tbody>
			</table>
		</div>
		
	<!-- 选择页码 -->
	<%@include file="/CommonView/selectPages.jsp" %>
	<!-- 分页 -->
	<%@include file="/CommonView/pagination.jsp" %>

	</div>
	<!-- 通过课题 -->
	<div class="container" id="passOpinionPanel" style="display:none">
		<div class="col-md-8 col-md-offset-2" style="padding: 110px 0px 0 0px;">
			<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
				<div class="panel-heading">
					<h3 class="panel-title">填写审核意见</h3>
				</div>
				<div class="panel-body">
					<form id="form" class="form-horizontal" role="form" method="post" action="passTopic.jsp">
						<input type="hidden" name="id" id="passCdtopic_id" value="">
						<div class="form-group">
							<div style="padding: 30px 100px 20px 100px;">
			                    <textarea class="form-control" placeholder="填写审核意见(可不填)" name="opinion" id="opinion"
					    		maxlength="500" style="height:150px;resize: none;"></textarea>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-success"><i class="fa fa-check-circle"></i> 通过</button>
							<button type="button" class="btn btn-primary" id="passBackBtn"><i class="fa fa-undo"></i> 返回</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 否决课题 -->
	<div class="container" id="vetoOpinionPanel" style="display:none">
		<div class="col-md-8 col-md-offset-2" style="padding: 110px 0px 0 0px;">
			<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
				<div class="panel-heading">
					<h3 class="panel-title">填写审核意见</h3>
				</div>
				<div class="panel-body">
					<form id="form" class="form-horizontal" role="form" method="post" action="vetoTopic.jsp">
						<input type="hidden" name="id" id="vetoCdtopic_id" value="">
						<div class="form-group">
							<div style="padding: 30px 100px 20px 100px;">
			                    <textarea class="form-control" placeholder="填写审核意见(可不填)" name="opinion" id="opinion"
					    		maxlength="500" style="height:150px;resize: none;"></textarea>
							</div>
						</div>
						<div class="form-group">
							<button type="submit" class="btn btn-danger"><i class="fa fa-times-circle"></i> 否决</button>
							<button type="button" class="btn btn-primary" id="vetoBackBtn"><i class="fa fa-undo"></i> 返回</button>
						</div>
					</form>
				</div>
			</div>
		</div>
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
<!-- 待审框和审核意见框切换 -->
<script>
	function passTopic(id){
		$("#passCdtopic_id").val(id);
		$("#waitAuditPanel").slideToggle();
		$("#passOpinionPanel").slideToggle();
	}
	$("#passBackBtn").click(function(){
		$("#passOpinionPanel").slideToggle();
		$("#waitAuditPanel").slideToggle();
	});
	
	function vetoTopic(id){
		$("#vetoCdtopic_id").val(id);
		$("#waitAuditPanel").slideToggle();
		$("#vetoOpinionPanel").slideToggle();
	}
	$("#vetoBackBtn").click(function(){
		$("#vetoOpinionPanel").slideToggle();
		$("#waitAuditPanel").slideToggle();
	});
</script>

</body>
</html>
