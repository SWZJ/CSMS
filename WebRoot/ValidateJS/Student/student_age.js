//学生年龄验证JS

function checkStudent_age(){
    var field = document.getElementById("student_age").value;  
    var spanNode = document.getElementById("student_age_span");  
	//年龄的规则：选填，只能为数字，长度为2-5
	var reg = /^[0-9]*$/;
    if(!reg.test(field)){
        //不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_age\">年龄不符合规则！</label>";  
        document.getElementById("student_age_class").className = "form-group has-error";
        return false;  
    }else if(!(field >= 0&&field <= 150)){
        //不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_age\">年龄输入有误！</label>";  
        document.getElementById("student_age_class").className = "form-group has-error";     
        return false;  
    }else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("student_age_class").className = "form-group has-success";    
        return true;  
	}
}