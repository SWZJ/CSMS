//用户密保答案验证JS

function checkUser_answer(){
    var field = document.getElementById("user_answer").value;
    var spanNode = document.getElementById("user_answer_span");
    //密保答案的规则：必填
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_answer\">密保答案不能为空！</label>";  
        document.getElementById("user_answer_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("user_answer_class").className = "form-group";   
        return true;
	}
}