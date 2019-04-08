//课题实现技术验证JS

function checkCDTopic_technology(){
    var field = document.getElementById("cdtopic_technology").value;  
    var spanNode = document.getElementById("cdtopic_technology_span");  
    //课题实现技术的规则：选填，汉字字母数字，长度不超过25
	if(field.length == 0){
		//可不填
        spanNode.innerHTML = "";  
        document.getElementById("cdtopic_technology_class").className = "form-group";    
        return true;  
	}else{
		var reg = /^([\u0391-\uFFE5]|[0-9a-zA-Z])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_technology\">实现技术输入不符合规则！</label>";  
	        document.getElementById("cdtopic_technology_class").className = "form-group has-error";
	        return false;  
	    }else if(field.length > 25){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_technology\">实现技术输入长度超限！</label>";  
	        document.getElementById("cdtopic_technology_class").className = "form-group has-error";     
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("cdtopic_technology_class").className = "form-group";    
	        return true;  
		}
	}
}