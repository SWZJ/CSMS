<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<!-- 编号验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_number.js"></script>
<!-- 姓名验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_name.js"></script>
<!-- 职称验证JS -->
<script src="/CSMS/ValidateJS/Teacher/teacher_position.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var teacher_number = checkTeacher_number();  
		var teacher_name = checkTeacher_name();
		var teacher_position = checkTeacher_position();
		if(teacher_number&&teacher_name&&teacher_position){
			return true;
		}else{  
			return false;  
		}
	} 
</script>

</head>

<body>
<div id="wrapper"><!-- WRAPPER -->
<%@include file="/CommonView/navbar.jsp" %>
<!-- 左侧边栏 -->
<%@include file="/CommonView/adminLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

	<%
		int teacher_id = Integer.valueOf(request.getParameter("id"));
		Teacher teaOld = new Teacher();
		teaOld = teaOld.queryTeacherByID(teacher_id);
		session.setAttribute("teacherOld", teaOld);
	 %>
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">修改教师信息</h3>
        </div>
        <div class="panel-body">
            <form name="CDTopicForm" class="form-horizontal" role="form" method="post" 
            action="/CSMS/SWZJ/admin/manageInfo/Teacher/teacherDoAmend.jsp" onsubmit="return checkAll()" >
                
                <div class="form-group" id="teacher_number_class">
                    <label for="teacher_number" class="col-sm-2 control-label"><a class="text-danger">*</a>编号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="teacher_number" name="teacher_number" 
                        placeholder="请输入教师编号（全为数字且长度为10）" value="<%= teaOld.getNum() %>" onchange="checkTeacher_number()"
                        oninput="Inputing(document.getElementById('teacher_number_span'),document.getElementById('teacher_number_class'))">
                        <span id="teacher_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="teacher_name_class">
                    <label for="teacher_name" class="col-sm-2 control-label"><a class="text-danger">*</a>名称</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="teacher_name" name="teacher_name" 
                        placeholder="请输入教师姓名" value="<%= teaOld.getName() %>" onchange="checkTeacher_name()"
                        oninput="Inputing(document.getElementById('teacher_name_span'),document.getElementById('teacher_name_class'))">
                        <span id="teacher_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="teacher_position_class">
                    <label for="teacher_position" class="col-sm-2 control-label"><a class="text-danger">*</a>职称</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="teacher_position" name="teacher_position" onchange="checkTeacher_position()">
	                        <option value = "">--请选择教师职称--</option>
	                        <option value = "助教">助教</option>
	                        <option value = "讲师">讲师</option>
	                        <option value = "副教授">副教授</option>
	                        <option value = "教授">教授</option>
	                        <option value = "博士生导师">博士生导师</option>
                        </select>
                        <span id="teacher_position_span"></span>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-6">
                        <button type="submit" class="btn btn-primary" id="amendBtn">提交</button>
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
<!-- 获取职称 -->
<script>
	$("#teacher_position option").each(function() {
        if($(this).val()=="<%= teaOld.getPosition() %>"){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- END 获取职称 -->
<!-- 判断编号是否存在 -->
<script>
	$(document).ready(function() {
		function IsNumExist(){
			$.ajax({
				type:"post",
				url:"/CSMS/manageInfo/TeacherIsNumExist",
				datatype: "json",
				async:false,
				data:{
					"teacher_number":$("#teacher_number").val(),
				},
				success:function(result) {
					if(checkTeacher_number()==false)	return;
					var r = JSON.parse(result);
					if(r.isExist==true&&$("#teacher_number").val()!='<%=teaOld.getNum()%>'){//编号已存在且不为当前编号
						$("#teacher_number_span").html("<label class=\"control-label text-danger\" for=\"teacher_number\">"+r.errorMes+"</label>")
						$("#teacher_number_class").attr("class","form-group has-error"); 
					}else{//编号不存在。
						$("#teacher_number_span").html("")
						$("#teacher_number_class").attr("class","form-group has-success");
					}
				},
				error:function(){
					alert("回调出错！");
				}
			});
		}
		$("#amendBtn").click(IsNumExist);
		$("#teacher_number").change(IsNumExist);
	});
</script>

</body>
</html>