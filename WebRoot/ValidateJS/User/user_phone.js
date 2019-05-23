//用户手机号验证JS

function checkUser_phone(){
    var field = document.getElementById("user_phone").value;
    var spanNode = document.getElementById("user_phone_span");
    //手机号的规则： 必填，手机号标准
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">手机号不能为空！</label>";  
        document.getElementById("user_phone_class").className = "form-group has-error";    
        return false;
	}else{
		/*var reg = /^[1]([3-9])[0-9]{9}$/;*/
		var reg = /^[1](([3][0-9])|([4][5-9])|([5][0-3,5-9])|([6][5,6])|([7][0-8])|([8][0-9])|([9][1,8,9]))[0-9]{8}$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_phone\">手机号输入不规范！</label>";  
	        document.getElementById("user_phone_class").className = "form-group has-error";    
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("user_phone_class").className = "form-group has-success";   
	        return true;  
		}
	}
}

//手机验证码验证
function checkPhoneCode(){
    var field = document.getElementById("phonecode").value;
    var spanNode = document.getElementById("phonecode_span");
	if(field.length == 0){
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"phonecode\">验证码不能为空！</label>";  
        document.getElementById("phonecode_class").className = "form-group has-error";    
        return false;
	}else{
		var phonecode = $("#phone_code").val();
		if(phonecode!=null&&field!=phonecode){
			spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"phonecode\">验证码错误！</label>";  
	        document.getElementById("phonecode_class").className = "form-group has-error";   
	        return false;
		}else{
			spanNode.innerHTML = "";
	        document.getElementById("phonecode_class").className = "form-group";   
	        return true;
		}
	}
}