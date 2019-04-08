//课题编号验证JS

function checkCDTopic_number(){
    var field = document.getElementById("cdtopic_number").value;  
    var spanNode = document.getElementById("cdtopic_number_span");  
    //编号的规则： 必填，数字字母和-，长度为为10-12
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_number\">编号不能为空！</label>";  
        document.getElementById("cdtopic_number_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([0-9]|[a-zA-Z]|[-])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_number\">编号不符合规则！</label>";  
	        document.getElementById("cdtopic_number_class").className = "form-group has-error";    
	        return false; 
		}else if(field.length < 10){  
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_number\">编号长度过短！</label>";  
	        document.getElementById("cdtopic_number_class").className = "form-group has-error";    
	        return false;   
	    }else if(field.length > 12){  
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_number\">编号长度超限！</label>";  
	        document.getElementById("cdtopic_number_class").className = "form-group has-error";    
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("cdtopic_number_class").className = "form-group";   
	        return true;  
		}
	}
}