<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>
<!-- 密保问题验证JS -->
<script src="/CSMS/ValidateJS/User/user_question.js"></script>
<!-- 密保答案验证JS -->
<script>
function checkUser_answer(){
	if($("#user_answer").val().length==0){
		$("#user_answer_span").html("<label class=\"control-label text-danger\" for=\"user_answer\">答案不能为空！</label>");
		$("#user_answer_class").attr("class","form-group has-error");
		return false;
	}else{
		return true;
	}
}
</script>
<!-- 表单验证 -->
<script>
	function checkAll(){
		var user_question = checkUser_question();  
		var user_answer = checkUser_answer();  
		if(user_question&&user_answer){
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
     
     <div class="container">
		<div class="col-md-8 col-md-offset-2" style="padding: 50px 0px 0 0px;">
			<div class="panel panel-default" style="text-align:center; vertical-align:middel;">
				<div class="panel-heading">
					<h3 class="panel-title">设置密保问题</h3>
				</div>
				<div class="panel-body">

					<form id="newForm" class="form-horizontal" method="post" action="setQuestionDo.jsp?id=<%=user.getID()%>" onsubmit="return checkAll();">
					<%if(user.getQuestion()==null||user.getQuestion().length()==0){ %>
						<h4>填写密保问题和答案</h4><hr>
	
						<div class="form-group" id="user_question_class">
							<label for="user_question" class="col-sm-2 control-label"><a class="text-danger">*</a>问题</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_question" name="user_question" maxlength="40" placeholder="请输入密保问题（不超过40字）" value=""
								 onchange="checkUser_question()" oninput="Inputing(document.getElementById('user_question_span'),document.getElementById('user_question_class'))">
								<span id="user_question_span"></span>
							</div>
						</div>
					
						<br>
						<div class="form-group" id="user_answer_class">
							<label for="user_answer" class="col-sm-2 control-label"><a class="text-danger">*</a>答案</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user_answer" name="user_answer" maxlength="20" placeholder="请输入答案（不超过20字）" value=""
								onchange="checkUser_answer()" oninput="Inputing(document.getElementById('user_answer_span'),document.getElementById('user_answer_class'))">
								<span id="user_answer_span"></span>
							</div>
						</div>
					
						<br>
						<div class="form-group">
							<button type="submit" class="btn btn-primary">设置密保问题</button>
						</div>
					<%}else{ %>
						<h4>您已经设置了密保问题</h4><hr>
						<br>
						<div class="form-group">
							<a href="updateQuestion.jsp" title="转到密保问题修改页面" type="button" class="btn btn-primary">密保问题修改</a>
						</div>
					<%} %>
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

</body>
</html>
