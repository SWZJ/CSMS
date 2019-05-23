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
                    <td>人员数</td>
                    <td><%= cdt.getHeadcount() %></td>
                </tr>
                <tr>
                    <td>所属教师</td>
                    <td><%= cdt.getTeacherName() %></td>
                </tr>
                <tr>
                    <td>是否生效</td>
                    <td><%= cdt.getActiveStr() %></td>
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
                    <a  class="btn btn-primary" href="/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicAmend.jsp?id=<%= cdtopic_id %>">修改</a>
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