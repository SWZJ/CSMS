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
		int student_id = Integer.valueOf(request.getParameter("id"));
		Student stu = new Student();
		stu = stu.queryStudentByID(student_id);
	 %>
     <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">学生信息详情</h3>
        </div>
        <div class="panel-body">
            <table class="table table-bordered table-striped table-hover ">
                <tbody>
                <tr>
                    <td>学号</td>
                    <td><%= stu.getNum() %></td>
                </tr>
                <tr>
                    <td>姓名</td>
                    <td><%= stu.getName() %></td>
                </tr>
                <tr>
                    <td>性别</td>
                    <td><%= stu.getSex() %></td>
                </tr>
                <tr>
                    <td>年龄</td>
                    <td><%= stu.getAge() %></td>
                </tr>
                <tr>
                    <td>所属班级</td>
                    <td><%= stu.getClassName() %></td>
                </tr>
                <tr>
                    <td>所学专业</td>
                    <td><%= stu.getMajorName() %></td>
                </tr>
                 <tr>
                    <td>所属学院</td>
                    <td><%= stu.getCollegeName() %></td>
                </tr>
                <tr>
                    <td>所选课题名称</td>
                    <td><%= stu.getCDTopicName() %></td>
                </tr>     
                <tr>
                    <td>添加日期</td>
                    <td><%= stu.getCreated() %></td>
                </tr>
                <tr>
                    <td>最后修改日期</td>
                    <td><%= stu.getUpdated() %></td>
                </tr>
                </tbody>
            </table>

            <div class="form-group">
                <div class="col-sm-offset-5 col-sm-6">
                    <a  class="btn btn-primary" href="/CSMS/SWZJ/admin/manageInfo/Student/studentAmend.jsp?id=<%= student_id %>">修改</a>
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