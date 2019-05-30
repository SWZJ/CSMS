//用户用户名验证JS

function checkUser_name(){
    var field = document.getElementById("user_name").value;
    var spanNode = document.getElementById("user_name_span");
    //用户名的规则： 必填，只能为汉字、字母或数字，长度为2-5
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_name\">用户名不能为空！</label>";  
        document.getElementById("user_name_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([\u0391-\uFFE5]|[0-9a-zA-Z])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_name\">用户名不符合规则！</label>";  
	        document.getElementById("user_name_class").className = "form-group has-error";    
	        return false;  
	    }else if(field.length<2||field.length>5){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_name\">用户名长度非法！！</label>";  
	        document.getElementById("user_name_class").className = "form-group has-error";
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("user_name_class").className = "form-group";   
	        return true;  
		}
	}
}