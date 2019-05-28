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
<%@include file="/CommonView/teacherLeftSidebar.jsp" %>

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
     <div class="panel">
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
							<a href="${downurl}&location=teacherCDTopicDetail&branch=teacher&id=<%=cdtopic_id%>" title="下载开题报告">${me.value.trim()}</a>
							<div class="text-right" style="margin-top:-22px;">
		                    	<a href="${deleteurl}&location=teacherCDTopicDetail&branch=teacher&id=<%=cdtopic_id%>" onclick="return confirm('确定要删除你的开题报告吗？');"><span class="label label-danger">删除开题报告</span></a>
								<a href="../createTopic/teacherUploadTopic.jsp?id=<%=cdt.getID() %>"><span class="label label-warning">上传开题报告</span></a>
							</div>
						</c:if>
						</c:forEach>
					</c:if>
					<!-- 未上传开题报告 -->
					<c:if test="${fileNameMap.size()==0 }">
						未上传开题报告
	                    <div class="text-right" style="margin-top:-22px">
	                    	<a href="../createTopic/teacherUploadTopic.jsp?id=<%=cdt.getID() %>"><span class="label label-warning">上传开题报告</span></a>
	                    </div>
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
                <div class="col-sm-offset-5 col-sm-6">
                    <a  class="btn btn-primary" href="/CSMS/SWZJ/teacher/myTopic/teacherCdtopicAmend.jsp?id=<%= cdtopic_id %>">修改</a>
                    <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
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

</body>
</html>