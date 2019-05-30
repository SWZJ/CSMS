//用户密保问题验证JS

function checkUser_question(){
    var field = document.getElementById("user_question").value;
    var spanNode = document.getElementById("user_question_span");
    //密保问题的规则：必填
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_question\">密保问题不能为空！</label>";  
        document.getElementById("user_question_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("user_question_class").className = "form-group";   
        return true;  
	}
}