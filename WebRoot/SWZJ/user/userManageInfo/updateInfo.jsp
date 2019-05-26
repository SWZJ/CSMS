<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>
<!-- 用户账号验证JS -->
<script src="/CSMS/ValidateJS/User/user_account.js"></script>
<!-- 用户名验证JS -->
<script src="/CSMS/ValidateJS/User/user_name.js"></script>
<!-- 管理员表单验证JS -->
<script>
	function checkAdminAll(){
		var user_account = checkUser_account();  
		var user_name = checkUser_name();
		if(user_account&&user_name){
			return true;
		}else{  
			return false;  
		}
	} 
</script>
<!-- 性别验证JS -->
<script src="/CSMS/ValidateJS/Student/student_sex.js"></script>
<!-- 年龄验证JS -->
<script src="/CSMS/ValidateJS/Student/student_age.js"></script>
<!-- 学生表单验证JS -->
<script>
	function checkStudentAll(){
		var user_account = checkUser_account();  
		var user_name = checkUser_name();
		var student_sex = checkStudent_sex();
		var student_age = checkStudent_age();
		if(user_account&&user_name&&student_sex&&student_age){
			return true;
		}else{  
			return false;  
		}
	}
</script>
<!-- 教师表单验证JS -->
<script>
	function checkTeacherAll(){
		var user_account = checkUser_account();  
		var user_name = checkUser_name();
		if(user_account&&user_name){
			return true;
		}else{  
			return false;  
		}
	} 
</script>

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
     <div class="container">
		<div class="col-md-8 col-md-offset-2" style="padding: 50px 0px 0 0px;">
			<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
				<div class="panel-heading">
					<h3 class="panel-title">修改信息</h3>
				</div>
				<div class="panel-body">
				<!-- 管理员信息修改 -->
				<%if(user.getRoot()==1){ %>
					<form id="form" class="form-horizontal" role="form" method="post" action="updateInfoDo.jsp" onsubmit="return checkAdminAll()">
						<input type="hidden" name="id" value="<%=user.getID() %>">
						<br>
						<div class="form-group" id="user_account_class">
							<label for="user_account" class="col-sm-2 control-label"><a class="text-danger"></a>账号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_account" name="user_account" disabled="disabled"
								placeholder="账号（6~18位字符,只能包含英文字母、数字、下划线）" value="<%=user.getAccount() %>" onchange="checkUser_account()" 
								oninput="Inputing(document.getElementById('user_account_span'),document.getElementById('user_account_class'))">
								<span id="user_account_span"></span>
							</div>
						</div>
						<br>
						<div class="form-group" id="user_name_class">
							<label for="user_name" class="col-sm-2 control-label"><a class="text-danger"></a>用户名</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_name" name="user_name" 
								placeholder="用户名（只能为汉字、字母或数字，长度为2-5）" value="<%=user.getName() %>" onchange="checkUser_name()" 
								oninput="Inputing(document.getElementById('user_name_span'),document.getElementById('user_name_class'))">
								<span id="user_name_span"></span>
							</div>
						</div>
						<br>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">修改信息</button>
						</div>
	
					</form>
				<%} %>
				<!-- 学生信息修改 -->
				<%if(user.getRoot()==0){ %>
					<form id="form" class="form-horizontal" role="form" method="post" action="updateInfoDo.jsp" onsubmit="return checkStudentAll()">
						<input type="hidden" name="id" value="<%=user.getID() %>">
						<br>
						<div class="form-group" id="user_account_class">
							<label for="user_account" class="col-sm-2 control-label"><a class="text-danger"></a>账号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_account" name="user_account" disabled="disabled"
								placeholder="账号（6~18位字符,只能包含英文字母、数字、下划线）" value="<%=user.getAccount() %>" onchange="checkUser_account()" 
								oninput="Inputing(document.getElementById('user_account_span'),document.getElementById('user_account_class'))">
								<span id="user_account_span"></span>
							</div>
						</div>

						<div class="form-group" id="user_name_class">
							<label for="user_name" class="col-sm-2 control-label"><a class="text-danger"></a>用户名</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_name" name="user_name" 
								placeholder="用户名——学生姓名（只能为汉字、字母或数字，长度为2-5）" value="<%=user.getName() %>" onchange="checkUser_name()" 
								oninput="Inputing(document.getElementById('user_name_span'),document.getElementById('user_name_class'))">
								<span id="user_name_span"></span>
							</div>
						</div>
							
						<div class="form-group" id="student_sex_class">
		                    <label for="student_sex" class="col-sm-2 control-label"><a class="text-danger"></a>性别</label>
		                    <div class="col-sm-9">
		                    	&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="男">男</label>
				    			&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="女">女</label>
								&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="未知" onchange="checkStudent_sex()">未知</label>
								<label class="control-label text-danger" for="student_sex">&emsp;</label><br>
								<span id="student_sex_span"></span>
		                    </div>
		                </div>
		                
		                <div class="form-group" id="student_age_class">
		                    <label for="student_age" class="col-sm-2 control-label"><a class="text-danger"></a>年龄</label>
		                    <div class="col-sm-9">
		                        <input type="text" class="form-control" id="student_age" name="student_age" 
		                        placeholder="请输入学生年龄" value="<%= stu.getAge()=="未知"?"":stu.getAge() %>" onchange="checkStudent_age()"
		                        oninput="Inputing(document.getElementById('student_age_span'),document.getElementById('student_age_class'))">
		                        <span id="student_age_span"></span>
		                    </div>
		                </div>
		                
		                <div class="form-group" id="student_class_class">
		                    <label for="student_class" class="col-sm-2 control-label"><a class="text-danger"></a>班级</label>
		                    <div class="col-sm-9">
		                         <input type="text" class="form-control" value="<%=stu.getClassName() %>" disabled="disabled">
		                    </div>
		                </div>
		                
		                <div class="form-group" id="student_major_class">
		                    <label for="student_major" class="col-sm-2 control-label"><a class="text-danger"></a>专业</label>
		                    <div class="col-sm-9">
		                        <input type="text" class="form-control" value="<%=stu.getMajorName() %>" disabled="disabled">
		                    </div>
		                </div>
		
						<div class="form-group" id="student_college_class">
		                    <label for="student_college" class="col-sm-2 control-label"><a class="text-danger"></a>学院</label>
		                    <div class="col-sm-9">
		                        <input type="text" class="form-control" value="<%=stu.getCollegeName() %>" disabled="disabled">
		                    </div>
		                </div>
		                
						<div class="form-group">
							<button type="submit" class="btn btn-primary">修改信息</button>
						</div>
					</form>
				<%} %>
				<!-- 教师信息修改 -->
				<%if(user.getRoot()==9){ %>
					<form id="form" class="form-horizontal" role="form" method="post" action="updateInfoDo.jsp" onsubmit="return checkTeacherAll()">
						<input type="hidden" name="id" value="<%=user.getID() %>">
						<br>
						<div class="form-group" id="user_account_class">
							<label for="user_account" class="col-sm-2 control-label"><a class="text-danger"></a>账号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_account" name="user_account" disabled="disabled"
								placeholder="账号（6~18位字符,只能包含英文字母、数字、下划线）" value="<%=user.getAccount() %>" onchange="checkUser_account()" 
								oninput="Inputing(document.getElementById('user_account_span'),document.getElementById('user_account_class'))">
								<span id="user_account_span"></span>
							</div>
						</div>
						<br>
						<div class="form-group" id="user_name_class">
							<label for="user_name" class="col-sm-2 control-label"><a class="text-danger"></a>用户名</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_name" name="user_name" 
								placeholder="用户名——教师姓名（只能为汉字、字母或数字，长度为2-5）" value="<%=user.getName() %>" onchange="checkUser_name()" 
								oninput="Inputing(document.getElementById('user_name_span'),document.getElementById('user_name_class'))">
								<span id="user_name_span"></span>
							</div>
						</div>
						<br>
						<div class="form-group" id="teacher_position_class">
		                    <label for="teacher_position_class" class="col-sm-2 control-label"><a class="text-danger"></a>职称</label>
		                    <div class="col-sm-9">
		                         <input type="text" class="form-control" value="<%=tea.getPosition() %>" disabled="disabled">
		                    </div>
		                </div>
		                <br>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">修改信息</button>
						</div>
					</form>
				<%} %>
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
<!-- 获取性别 -->
<script>
	$("#student_sex[type='radio']").each(function() {
        if($(this).val()=='<%= stu.getSex() %>'){
        	$(this).prop('checked',true);
       	}
    });
</script>
<!-- END 获取性别 -->

</body>
</html>