//用户密码验证JS

function checkUser_password(){
    var field = document.getElementById("user_password").value;
    var spanNode = document.getElementById("user_password_span");
    //密码的规则：必填，6~18位字符，必须包含数字、字母或特殊字符其中两项
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_password\">密码不能为空！</label>";  
        document.getElementById("user_password_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*./\-\+]+$)[a-zA-Z\d!@#$%^&*.\-\+]+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_password\">密码必须包含数字、字母或特殊字符其中两项！</label>";  
	        document.getElementById("user_password_class").className = "form-group has-error";    
	        return false;  
	    }else if(field.length<6||field.length>18){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_password\">密码必须为6~18位字符！</label>";  
	        document.getElementById("user_password_class").className = "form-group has-error";
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("user_password_class").className = "form-group";   
	        return true;  
		}
	}
}