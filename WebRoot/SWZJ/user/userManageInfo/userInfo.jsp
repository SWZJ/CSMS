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
<%@include file="/CommonView/userLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->
<%
Student stu = new Student().queryStudentByID(user.getStudentID());
Teacher tea = new Teacher().queryTeacherByID(user.getTeacherID());
%>
     <div class="container-fluid">
        <div class="row">
            <div class="col-md-10 col-md-offset-1">
                <div class="panel panel-default" style="text-align:center">
                    <div class="panel-heading"><p style="margin:3px 0;color:; font-size:28px"><strong style="color:;"><%= user.getName() %></strong>&ensp;的用户信息</p></div>
                    <div class="panel-body">
					<div>
		            <table class="table table-bordered table-striped table-hover ">
		            	<colgroup>
			                <col style="width:50%">
			                <col style="width:50%">
			            </colgroup>
		                <tbody>
		                <tr>
		                    <td>账号</td>
		                    <td><%= user.getAccount() %></td>
		                </tr>
		                <tr>
		                    <td>用户名</td>
		                    <td><%= user.getName() %></td>
		                </tr>
		                <tr>
		                    <td>手机号</td>
		                    <td><%= user.getPhoneHide() %></td>
		                </tr>
		                <tr>
		                    <td>邮箱</td>
		                    <td><%= user.getEmailHide() %></td>
		                </tr>
		                <tr>
		                    <td>用户类型</td>
		                    <td><%= user.getRootName() %></td>
		                </tr>
		                <%if(user.getRoot()==0){ %>
		                <tr>
		                    <td>学号（账号）</td>
		                    <td><%= stu.getNum() %></td>
		                </tr>
		                <tr>
		                    <td>姓名（用户名）</td>
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
		                <%}else if(user.getRoot()==9){ %>
		                <tr>
		                    <td>编号（账号）</td>
		                    <td><%= tea.getNum() %></td>
		                </tr>
		                <tr>
		                    <td>姓名（用户名）</td>
		                    <td><%= tea.getName() %></td>
		                </tr>
		                <tr>
		                    <td>职称</td>
		                    <td><%= tea.getPosition() %></td>
		                </tr>
		                <tr>
		                    <td>拥有课题数量</td>
		                    <td><a href="/CSMS/SWZJ/teacher/myTopic/teacherAllTopic.jsp" target="_blank" title="我的所有课题"><%=tea.getCDTcount() %></a></td>
		                </tr>
		                <%} %>
		                </tbody>
		            </table>
        			</div>
                    </div>
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
