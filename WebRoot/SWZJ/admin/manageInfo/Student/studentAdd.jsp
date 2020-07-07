<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<!-- 学号验证JS -->
<script src="/CSMS/ValidateJS/Student/student_number.js"></script>
<!-- 姓名验证JS -->
<script src="/CSMS/ValidateJS/Student/student_name.js"></script>
<!-- 性别验证JS -->
<script src="/CSMS/ValidateJS/Student/student_sex.js"></script>
<!-- 年龄验证JS -->
<script src="/CSMS/ValidateJS/Student/student_age.js"></script>
<!-- 班级验证JS -->
<script src="/CSMS/ValidateJS/Student/student_class.js"></script>
<!-- 专业验证JS -->
<script src="/CSMS/ValidateJS/Student/student_major.js"></script>
<!-- 学院验证JS -->
<script src="/CSMS/ValidateJS/Student/student_college.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var student_number = checkStudent_number();  
		var student_name = checkStudent_name();
		var student_sex = checkStudent_sex();
		var student_age = checkStudent_age();
		var student_class = checkStudent_class();
		var student_major =  checkStudent_major();
		var student_college =  checkStudent_college();
		if(student_number&&student_name&&student_sex&&student_age&&student_class&&student_major&&student_college){
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
<%@include file="/CommonView/adminLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">
  
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">新增学生信息填写</h3>
        </div>
        <div class="panel-body">
            <form name="studentForm" class="form-horizontal" role="form" method="post" 
            action="/CSMS/SWZJ/admin/manageInfo/Student/studentDoAdd.jsp" onsubmit="return checkAll()" >
                
                <div class="form-group" id="student_number_class">
                    <label for="student_number" class="col-sm-2 control-label"><a class="text-danger">*</a>学号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_number" name="student_number" 
                        placeholder="请输入学生学号（全为数字且长度为11）" value="" onchange="checkStudent_number()"
                        oninput="Inputing(document.getElementById('student_number_span'),document.getElementById('student_number_class'))">
                        <span id="student_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="student_name_class">
                    <label for="student_name" class="col-sm-2 control-label"><a class="text-danger">*</a>姓名</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_name" name="student_name" 
                        placeholder="请输入学生姓名" value="" onchange="checkStudent_name()"
                        oninput="Inputing(document.getElementById('student_name_span'),document.getElementById('student_name_class'))">
                        <span id="student_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_sex_class">
                    <label for="student_sex" class="col-sm-2 control-label"><a class="text-danger">*</a>性别</label>
                    <div class="col-sm-8">
                    	&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="男" onchange="checkStudent_sex()">男</label>
		    			&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="女" onchange="checkStudent_sex()">女</label>
						&emsp;<label><input id="student_sex" type="radio" name="student_sex" value="未知" onchange="checkStudent_sex()">未知</label>
						<label class="control-label text-danger" for="student_sex">&emsp;</label><br>
						<span id="student_sex_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="student_age_class">
                    <label for="student_age" class="col-sm-2 control-label"><a class="text-danger"></a>年龄</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="student_age" name="student_age" 
                        placeholder="请输入学生年龄" value="" onchange="checkStudent_age()"
                        oninput="Inputing(document.getElementById('student_age_span'),document.getElementById('student_age_class'))">
                        <span id="student_age_span"></span>
                    </div>
                </div>
                

                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-6">
                        <button type="submit" class="btn btn-primary" id="addBtn">提交</button>
                        <a class="btn btn-primary" href="#" onClick="history.back(-1)">返回</a>
                    </div>
                </div>

            </form>
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
<!-- 判断学号是否存在 -->
<script>
	$(document).ready(function() {
		function IsNumExist(){
			$.ajax({
				type:"post",
				url:"/CSMS/manageInfo/StudentIsNumExist",
				datatype: "json",
				async:false,
				data:{
					"student_number":$("#student_number").val(),
				},
				success:function(result) {
					if(checkStudent_number()==false)	return;
					var r = JSON.parse(result);
					if(r.isExist==true){//学号已存在
						$("#student_number_span").html("<label class=\"control-label text-danger\" for=\"student_number\">"+r.errorMes+"</label>")
						$("#student_number_class").attr("class","form-group has-error"); 
					}else{//学号不存在。
						$("#student_number_span").html("")
						$("#student_number_class").attr("class","form-group has-success");
					}
				},
				error:function(){
					alert("回调出错！");
				}
			});
		}
		$("#addBtn").click(IsNumExist);
		$("#student_number").change(IsNumExist);
	});
</script>

</body>
</html>