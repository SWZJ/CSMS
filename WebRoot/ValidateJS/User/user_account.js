//用户账号验证JS

function checkUser_account(){
    var field = document.getElementById("user_account").value;
    var spanNode = document.getElementById("user_account_span");
    //账号的规则：必填，6~18位字符，只能包含英文字母、数字、下划线
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_account\">账号不能为空！</label>";  
        document.getElementById("user_account_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([_]|[0-9a-zA-Z])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_account\">账号只能包含英文字母、数字、下划线！</label>";  
	        document.getElementById("user_account_class").className = "form-group has-error";    
	        return false;  
	    }else if(field.length<6||field.length>18){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_account\">账号必须为6~18位字符！</label>";  
	        document.getElementById("user_account_class").className = "form-group has-error";
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("user_account_class").className = "form-group";   
	        return true;  
		}
	}
}