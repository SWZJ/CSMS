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
<%@include file="/CommonView/adminLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

	<%
		int cdtopic_id = Integer.valueOf(request.getParameter("id"));
		CDTopic cdt = new CDTopic();
		cdt = cdt.queryCDTopicByID(cdtopic_id);
	 %>
     <div class="panel" id="topicDetailPanel">
        <div class="panel-heading">
            <h3 class="panel-title">课题信息详情</h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped table-hover ">
                <tbody>
                <tr>
                    <td>编号</td>
                    <td><%= cdt.getNum() %></td>
                </tr>
                <tr>
                    <td>名称</td>
                    <td><%= cdt.getName() %></td>
                </tr>
                <tr>
                    <td>关键字</td>
                    <td><%= cdt.getKeyword() %></td>
                </tr>
                <tr>
                    <td>实现技术</td>
                    <td><%= cdt.getTechnology() %></td>
                </tr>
                <tr>
                    <td>选题人数</td>
                    <td><%= cdt.getHeadcount() %></td>
                </tr>
                <tr>
                    <td>所属教师</td>
                    <td><%= cdt.getTeacherName() %></td>
                </tr>
                <tr>
                    <td>生效状态</td>
                    <td><%= cdt.getActiveStr() %></td>
                </tr>
                <tr>
                    <td>审核状态</td>
                    <td><%= cdt.getStatusStr() %></td>
                </tr>  
                <tr>
                    <td>审核意见</td>
                    <td><%= cdt.getOpinion() %></td>
                </tr>
                <tr>
                    <td>开题报告</td>
                    <td>
                    <%request.setAttribute("fileNameMap", new ListFile().getFileMap(request, response, "teacher", cdtopic_id, "")); %>
					<!-- 教师上传过开题报告 -->
                    <c:if test="${fileNameMap.size()!=0 }">
						<c:forEach var="me" items="${fileNameMap}" varStatus="statu">
						<!-- 只取最后提交的开题报告 -->
						<c:if test="${statu.last}">
							<c:url value="/servlet/DownLoadServlet" var="downurl">
								<c:param name="filename" value="${me.key}"></c:param>
							</c:url>
							<c:url value="/servlet/DeleteFileServlet" var="deleteurl">
								<c:param name="filename" value="${me.key}"></c:param>
							</c:url>
							<a href="${downurl}&location=topicDetail&branch=teacher&id=<%=cdtopic_id%>" title="下载开题报告">${me.value.trim()}</a>
							<div class="text-right" style="margin-top:-22px;">
		                    	<a href="${deleteurl}&location=topicDetail&branch=teacher&id=<%=cdtopic_id%>" onclick="return confirm('确定要删除该开题报告吗？');"><span class="label label-danger">删除开题报告</span></a>				
							</div>
						</c:if>
						</c:forEach>
					</c:if>
					<!-- 未上传开题报告 -->
					<c:if test="${fileNameMap.size()==0 }">
						未上传开题报告
					</c:if>
                    </td>
                </tr>    
                <tr>
                    <td>添加日期</td>
                    <td><%= cdt.getCreated() %></td>
                </tr>
                <tr>
                    <td>最后修改日期</td>
                    <td><%= cdt.getUpdated() %></td>
                </tr>
                </tbody>
            </table>

            <div class="form-group">
            	<!-- 待审核 -->
      			<c:if test="<%=cdt.getStatus()==0 %>">
      				<div class="text-left">
                    	<a href="javascript:void;" onclick="vetoTopic(<%=cdt.getID() %>);" type="button" class="btn btn-danger"><i class="fa fa-times-circle"></i> 否决</a>
	                </div>
	                <div class="text-center" style="margin-top:-33px">
	                    <a class="btn btn-primary" href="topicAmend.jsp?id=<%= cdtopic_id %>">修改</a>
	                    <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
	                </div>
	                <div class="text-right" style="margin-top:-35px">
	                    <a href="javascript:void;" onclick="passTopic(<%=cdt.getID() %>);" type="button" class="btn btn-success"><i class="fa fa-check-circle"></i> 通过</a>
	                </div>
      			</c:if>
      			<!-- 审核未通过 -->
      			<c:if test="<%=cdt.getStatus()==2 %>">
	                <div class="text-center" style="margin-top:0px">
	                    <a class="btn btn-primary" href="topicAmend.jsp?id=<%= cdtopic_id %>">修改</a>
	                    <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
	                </div>
	                <div class="text-right" style="margin-top:-33px">
	                    <a href="javascript:void;" onclick="passTopic(<%=cdt.getID() %>);" type="button" class="btn btn-success"><i class="fa fa-check-circle"></i> 通过</a>
	                </div>
      			</c:if>
      			<!-- 审核已通过 -->
      			<c:if test="<%=cdt.getStatus()==1 %>">
      				<div class="text-center">
	                    <a class="btn btn-primary" href="topicAmend.jsp?id=<%= cdtopic_id %>">修改</a>
	                    <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
	                </div>
      			</c:if>
            </div>

        </div>
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
<!-- 课题详情框和审核意见框切换 -->
<script>
	function passTopic(id){
		$("#passCdtopic_id").val(id);
		$("#topicDetailPanel").slideToggle();
		$("#passOpinionPanel").slideToggle();
	}
	$("#passBackBtn").click(function(){
		$("#passOpinionPanel").slideToggle();
		$("#topicDetailPanel").slideToggle();
	});
	
	function vetoTopic(id){
		$("#vetoCdtopic_id").val(id);
		$("#topicDetailPanel").slideToggle();
		$("#vetoOpinionPanel").slideToggle();
	}
	$("#vetoBackBtn").click(function(){
		$("#vetoOpinionPanel").slideToggle();
		$("#topicDetailPanel").slideToggle();
	});
</script>

</body>
</html>
