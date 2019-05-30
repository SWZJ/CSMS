//学生学号验证JS

function checkStudent_number(){
    var field = document.getElementById("student_number").value;
    var spanNode = document.getElementById("student_number_span");
    //学号的规则： 必填，必须全为数字，长度为11
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_number\">学号不能为空！</label>";  
        document.getElementById("student_number_class").className = "form-group has-error";    
        return false;
	}else{
		var reg = /^([0-9])+$/;
	    if(!reg.test(field)){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_number\">学号必须全为数字！</label>";  
	        document.getElementById("student_number_class").className = "form-group has-error";    
	        return false;  
	    }else if(field.length != 11){
	        //不符合规则
	        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_number\">学号长度必须为11！</label>";  
	        document.getElementById("student_number_class").className = "form-group has-error";
	        return false;  
	    }else{
			//符合规则
			if(spanNode.innerHTML.indexOf("success")!=-1)	return true;
			else if(spanNode.innerHTML.indexOf("danger")!=-1)	return false;
			else{
				spanNode.innerHTML = "";
		        document.getElementById("student_number_class").className = "form-group has-success";
		        return true;  
			}
		}
	}
}