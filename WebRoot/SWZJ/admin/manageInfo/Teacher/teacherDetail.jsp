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
		int teacher_id = Integer.valueOf(request.getParameter("id"));
		Teacher tea = new Teacher();
		tea = tea.queryTeacherByID(teacher_id);
	 %>
     <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">教师信息详情</h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped table-hover ">
                <tbody>
                <tr>
                    <td>编号</td>
                    <td><%= tea.getNum() %></td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><%= tea.getName() %></td>
                </tr>
                <tr>
                    <td>职称</td>
                    <td><%= tea.getPosition() %></td>
                </tr>
                <tr>
                    <td>拥有课题数量</td>
                    <td><%= tea.getCDTcount() %></td>
                </tr>    
                <tr>
                    <td>添加日期</td>
                    <td><%= tea.getCreated() %></td>
                </tr>
                <tr>
                    <td>最后修改日期</td>
                    <td><%= tea.getUpdated() %></td>
                </tr>
                </tbody>
            </table>

            <div class="form-group">
                <div class="col-sm-offset-5 col-sm-6">
                    <a  class="btn btn-primary" href="/CSMS/SWZJ/admin/manageInfo/Teacher/teacherAmend.jsp?id=<%= teacher_id %>">修改</a>
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