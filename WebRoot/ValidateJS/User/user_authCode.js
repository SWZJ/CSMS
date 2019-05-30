//用户授权码验证JS

function checkUser_authCode(){
    var field = document.getElementById("user_authCode").value;  
    var spanNode = document.getElementById("user_authCode_span");  
	//授权码的规则：选填，
	var authCode = "x24q1%44322R16Z";
    if(field.length!=0&&field!=authCode){
        //输入授权码但不正确
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"user_authCode\">授权码有误！请仔细核对神葳总局给予的授权码！</label>";  
        document.getElementById("user_authCode_class").className = "form-group has-error";
        return false;   
    }else if(field==authCode){
		//输入授权码正确
        spanNode.innerHTML = "<label class=\"control-label text-success\" for=\"user_authCode\">授权码正确！你现在可以注册成为超级管理员啦！</label>"; 
        document.getElementById("user_authCode_class").className = "form-group has-success";    
        return true;  
	}else{
		//未输入授权码
        spanNode.innerHTML = "";  
        document.getElementById("user_authCode_class").className = "form-group";    
        return true;  
	}
}