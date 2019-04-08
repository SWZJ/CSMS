//课题关键字验证JS

function checkCDTopic_keyword(){
    var field = document.getElementById("cdtopic_keyword").value;  
    var spanNode = document.getElementById("cdtopic_keyword_span");  
    //关键字的规则：选填，汉字字母数字和空格和、，长度不超过20
	if(field.length == 0){
        //可不填
        spanNode.innerHTML = "";  
        document.getElementById("cdtopic_keyword_class").className = "form-group";    
        return true;  
	}else{
		var reg = /^([\u0391-\uFFE5]|[0-9a-zA-Z]|[、 ])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_keyword\">关键字输入不符合规则！</label>";  
	        document.getElementById("cdtopic_keyword_class").className = "form-group has-error";       
	        return false;  
	    }else if(field.length > 20){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"cdtopic_keyword\">关键字输入长度超限！</label>";  
	        document.getElementById("cdtopic_keyword_class").className = "form-group has-error";     
	        return false;  
	    }else{
			//符合规则
	        spanNode.innerHTML = "";  
	        document.getElementById("cdtopic_keyword_class").className = "form-group";    
	        return true;  
		}
	}
}