//用户邮箱验证

function checkUser_email(){
    var field = document.getElementById("user_email").value;
    var spanNode = document.getElementById("user_email_span");
    //邮箱的规则：必填，邮箱正则表达式
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_email\">邮箱不能为空！</label>";  
        document.getElementById("user_email_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_email\">邮箱格式有误！</label>";  
	        document.getElementById("user_email_class").className = "form-group has-error";    
	        return false;
	    }/*else if(field.length<6||field.length>18){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_email\">该邮箱已被注册！</label>";  
	        document.getElementById("user_email_class").className = "form-group has-error";
	        return false;  
	    }*/else{
			//符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-success\" for=\"user_email\">该邮箱可被绑定！</label>";  
	        document.getElementById("user_email_class").className = "form-group has-success";   
	        return true;
		}
	}
}