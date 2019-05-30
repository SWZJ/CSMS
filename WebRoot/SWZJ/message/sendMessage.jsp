<%if(session.getAttribute("user") == null){response.sendRedirect("/CSMS/login.jsp");return;}%>
<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<!-- 头部 -->
<%@include file="/CommonView/head.jsp" %>
<!-- Receiver验证 -->
<script>
function checkReceiverEmpty(){
	var receiver = $("#receiver").val();
	if(receiver.length==0){
		$("#receiver_span").html("<label class=\"control-label text-danger\" for=\"receiver\">The receiver cannot be empty!</label>");
		$("#receiver_class").attr("class","form-group has-error");
		return false;
	}else{
		return true;
	}
}
</script>
<!-- Summary验证 -->
<script>
function checkSummary(){
	var field = $("#summary").val();
    var spanNode = $("#summary_span");
	if(field.length == 0){
		//不符合规则
        spanNode.html("<label class=\"control-label text-danger\" for=\"summary\">The Summary cannot be empty!</label>");
        $("#summary_class").attr("class","form-group has-error");
        return false;
	}else{
		spanNode.html();
		$("#summary_class").attr("class","form-group");
        return true;  
	}
}
</script>
<!-- Content验证 -->
<script>
function checkContent(){
	var field = $("#content").val();
    var spanNode = $("#content_span");
	if(field.length == 0){
		//不符合规则
        spanNode.html("<label class=\"control-label text-danger\" for=\"content\">The Content cannot be empty!</label>");
        $("#content_class").attr("class","form-group has-error");
        return false;
	}else{
		spanNode.html();
		$("#content_class").attr("class","form-group");
        return true;  
	}
}
</script>
<!-- 表单验证 -->
<script>
function checkAll(){
	var receiver = checkReceiverEmpty()&&$("#receiver_id").val()!=null;
	var summary = checkSummary();
	var content = checkContent();
	if(receiver&&summary&&content){
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
<%@include file="/CommonView/messageLeftSidebar.jsp" %>

<!-- 内容区域 -->
<div class="main">
<!-- MAIN CONTENT -->
<div class="main-content">

<!-- INFO TIP -->
<%@include file="/CommonView/infoTip.jsp" %>
<!-- END INFO TIP -->

	<div class="panel">
    
        <div class="panel-heading" >
            <h3 class="panel-title">Send Message</h3>
            <div class="right">
                <a href="/CSMS/SWZJ/message/myMessage.jsp"><span class="label label-primary"><i class="fa fa-comment"></i>&nbsp;My Message</span></a>
            </div>
        </div>
        
		<div class="panel-body" style="text-align:center; vertical-align:middel;">
			<form class="form-horizontal" role="form" method="post" action="sendMessageDo.jsp" onsubmit="return checkAll()">
				<input type="hidden" name="sender_id" value="<%=user.getID()%>">
				
				<div class="form-group" id="receiver_class">
                    <label for="receiver" class="col-sm-2 control-label"><a class="text-danger"></a>Receiver</label>
                    <div class="col-sm-8">
                    	<div class="input-group">
	                        <input type="text" class="form-control" id="receiver" name="receiver" onkeypress="if(event.keyCode==13) {testBtn.click();return false;}"
	                        placeholder="Please enter the receiver's account number, mobile phone number or email address" value="" onchange="testBtn.click()"
	                        oninput="Inputing(document.getElementById('receiver_span'),document.getElementById('receiver_class'));$('#receiver_id_class').hide(500);$('#receiver_id').empty();">
	                        <span class="input-group-btn"><button class="btn btn-primary" type="button" id="testBtn">Testing Receiver</button></span>
                        </div>
                        <span id="receiver_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="receiver_id_class" style="display:none">
                    <label for="receiver_id" class="col-sm-2 control-label"><a class="text-danger"></a>Select Receiver</label>
                    <div class="col-sm-8">
                        <select class="form-control" id="receiver_id" name="receiver_id">
                        </select>
                        <span id="receiver_id_span"></span>
					</div>
                </div>

                <div class="form-group" id="summary_class">
                    <label for="summary" class="col-sm-2 control-label"><a class="text-danger"></a>Summary</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="summary" name="summary" maxlength="30"
                        placeholder="Please enter the message summary(No more than 30 words)" value="" onchange="checkSummary()"
                        oninput="Inputing(document.getElementById('summary_span'),document.getElementById('summary_class'))">
                        <span id="summary_span"></span>
                    </div>
                </div>
                
                <div class="form-group" id="content_class">
                    <label for="content" class="col-sm-2 control-label"><a class="text-danger"></a>Content</label>
                    <div class="col-sm-8">
                    	<textarea class="form-control" placeholder="Please enter the message content(No more than 500 words)" maxlength="500" 
                    	style="height:150px;resize: none;" id="content" name="content" onchange="checkContent()"
                        oninput="Inputing(document.getElementById('content_span'),document.getElementById('content_class'))"></textarea>
                        <span id="content_span"></span>
                    </div>
                </div>
                
				<div class="form-group">
                	<button type="submit" class="btn btn-primary" id="SendBtn">Send Message Now</button>
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
<script>
$("#testBtn").click(function(){
	//判断接收者是否存在
	if(checkReceiverEmpty()==false)	return;
	$.ajax({
		type:"post",
		url:"/CSMS/manageInfo/UserIsExist",
		datatype: "json",
		async:false,
		data:{
			"ID":$("#receiver").val(),
		},
		success:function(result) {
			var r = JSON.parse(result);
			if(r.isExist==true){//用户存在
				var userList = r.userList;
				var receiver = $("#receiver_id");
				receiver.empty();
				for(var i in userList){
					receiver.append("<option value='"+userList[i].user_id+"'>"+userList[i].user_name+"</option>");
				}
				$("#receiver_id_class").show(500);
			}else{//用户不存在
				$("#receiver_span").html("<label class=\"control-label text-danger\" for=\"receiver\">"+r.errorMes+"</label>");
				$("#receiver_class").attr("class","form-group has-error");
				return;
			}
		},
		error:function(){
			alert("回调出错！");
		}
	});	
})
</script>

</body>
</html>