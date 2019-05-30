//用户密保答案验证JS

function checkUser_answer(){
    var field = document.getElementById("user_answer").value;
    var spanNode = document.getElementById("user_answer_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_answer\">密保答案不能为空！</label>";  
        document.getElementById("user_answer_class").className = "form-group has-error";    
        return false;
	}else{
		var answer = $("#answer").val();
		if(field!=answer){
			spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_answer\">答案错误！</label>";  
	        document.getElementById("user_answer_class").className = "form-group has-error";    
	        return false;
		}else{
			spanNode.innerHTML = "";  
	        document.getElementById("user_answer_class").className = "form-group";   
	        return true;
		}
	}
}