<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>

<!-- 编号验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_number.js"></script>
<!-- 名称验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_name.js"></script>
<!-- 关键字验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_keyword.js"></script>
<!-- 实现技术验证JS -->
<script src="/CSMS/ValidateJS/CDTopic/cdtopic_technology.js"></script>

<!-- 表单验证 -->
<script>
	function checkAll(){
		var cdtopic_number = checkCDTopic_number();  
		var cdtopic_name = checkCDTopic_name();
		var cdtopic_keyword = checkCDTopic_keyword();
		var cdtopic_technology = checkCDTopic_technology();
		if(cdtopic_number&&cdtopic_name&&cdtopic_keyword&&cdtopic_technology){
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
 
    <%
		int cdtopic_id = Integer.valueOf(request.getParameter("id"));
		CDTopic cdtOld = new CDTopic();
		cdtOld = cdtOld.queryCDTopicByID(cdtopic_id);
		session.setAttribute("cdtopicOld", cdtOld);
	 %>
    <div class="panel">
        <div class="panel-heading">
            <h3 class="panel-title">修改课题信息</h3>
        </div>
        <div class="panel-body">
            <form name="CDTopicForm" class="form-horizontal" role="form" method="post" action="/CSMS/SWZJ/admin/manageInfo/CDTopic/cdtopicDoAmend.jsp" onsubmit="return checkAll()" >
                <input type="hidden" name="_token" value="lyGZwiU0GA6BPKKRIX9f8DSzkNptSO17ftcyrUlV">
                
                <div class="form-group" id="cdtopic_number_class">
                    <label for="cdtopic_number" class="col-sm-2 control-label"><a class="text-danger">*</a>编号</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_number" name="cdtopic_number" 
                        placeholder="请输入课题编号" value="<%= cdtOld.getNum() %>" onchange="checkCDTopic_number()"
                        oninput="Inputing(document.getElementById('cdtopic_number_span'),document.getElementById('cdtopic_number_class'))">
                        <span id="cdtopic_number_span"></span>
                    </div>
                </div>

                <div class="form-group" id="cdtopic_name_class">
                    <label for="cdtopic_name" class="col-sm-2 control-label"><a class="text-danger">*</a>名称</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_name" name="cdtopic_name" 
                        placeholder="请输入课题名称" value="<%= cdtOld.getName() %>" onchange="checkCDTopic_name()"
                        oninput="Inputing(document.getElementById('cdtopic_name_span'),document.getElementById('cdtopic_name_class'))">
                        <span id="cdtopic_name_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="cdtopic_keyword_class">
                    <label for="cdtopic_keyword" class="col-sm-2 control-label"><a class="text-danger"></a>关键字</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_keyword" name="cdtopic_keyword" 
                        placeholder="请输入课题关键字" value="<%= cdtOld.getKeyword() %>" onchange="checkCDTopic_keyword()"
                        oninput="Inputing(document.getElementById('cdtopic_keyword_span'),document.getElementById('cdtopic_keyword_class'))">
                        <span id="cdtopic_keyword_span"></span>
                    </div>
                </div>
	
                <div class="form-group" id="cdtopic_technology_class">
                    <label for="cdtopic_technology" class="col-sm-2 control-label"><a class="text-danger"></a>实现技术</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="cdtopic_technology" name="cdtopic_technology" 
                        placeholder="请输入课题实现技术" value="<%= cdtOld.getTechnology() %>" onchange="checkCDTopic_实现技术()"
                        oninput="Inputing(document.getElementById('cdtopic_technology_span'),document.getElementById('cdtopic_technology_class'))">
                        <span id="cdtopic_technology_span"></span>
                    </div>
                </div>

                <div class="form-group" id="teacher_id_class">
                    <label for="teacher_id" class="col-sm-2 control-label"><a class="text-danger"></a>所属教师</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="teacher_id" name="teacher_id">
	                        <option value = 0>--请选择所属教师--</option>
	                        <%
	                        	Teacher tea = new Teacher();
	                        	List<Teacher> teaList = tea.getTeacherInfo();
	                        	for(Teacher teacher:teaList){
	                        		out.print("<option value=\""+teacher.getID()+"\">"+teacher.getName()+"</option>");
	                        	}
	                         %>
                        </select>
                        <span id="teacher_id_span"></span>
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
<!-- 获取所属教师 -->
<script>
	$("#teacher_id option").each(function() {
        if($(this).val()=='<%= cdtOld.getTeacherID() %>'){
        	$(this).prop('selected',true);
       	}
    });
</script>
<!-- 判断编号是否存在 -->
<script>
	$(document).ready(function() {
		function IsNumExist(){
			$.ajax({
				type:"post",
				url:"/CSMS/manageInfo/CDTopicIsNumExist",
				datatype: "json",
				async:false,
				data:{
					"cdtopic_number":$("#cdtopic_number").val(),
				},
				success:function(result) {
					if(checkCDTopic_number()==false)	return;
					var r = JSON.parse(result);
					if(r.isExist==true&&$("#cdtopic_number").val()!='<%=cdtOld.getNum()%>'){//编号已存在且不为当前编号
						$("#cdtopic_number_span").html("<label class=\"control-label text-danger\" for=\"cdtopic_number\">"+r.errorMes+"</label>")
						$("#cdtopic_number_class").attr("class","form-group has-error"); 
					}else{//编号不存在。
						$("#cdtopic_number_span").html("")
						$("#cdtopic_number_class").attr("class","form-group has-success");
					}
				},
				error:function(){
					alert("回调出错！");
				}
			});
		}
		$("#amendBtn").click(IsNumExist);
		$("#cdtopic_number").change(IsNumExist);
	});
</script>

</body>
</html>