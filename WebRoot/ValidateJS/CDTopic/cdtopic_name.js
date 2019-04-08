//课题名称验证JS

function checkCDTopic_name(){
    var field = document.getElementById("cdtopic_name").value;  
    var spanNode = document.getElementById("cdtopic_name_span");  
    //名称的规则：必填，只能为汉字、字母或数字，长度为不超过25
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_name\">名称不能为空！</label>";  
        document.getElementById("cdtopic_name_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([\u0391-\uFFE5]|[0-9a-zA-Z])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_name\">名称输入不符合规则！</label>";  
	        document.getElementById("cdtopic_name_class").className = "form-group has-error";
	        return false;  
	    }else if(field.length > 25){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_name\">名称输入长度超限！</label>";  
	        document.getElementById("cdtopic_name_class").className = "form-group has-error";     
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("cdtopic_name_class").className = "form-group";    
	        return true;  
		}
	}
}