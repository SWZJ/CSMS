//学生专业验证JS

function checkStudent_major(){
    var field = document.getElementById("student_major").value;  
    var spanNode = document.getElementById("student_major_span");
	//专业的规则：必选
	if(field == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_major\">专业必须选择！</label>";  
        document.getElementById("student_major_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("student_major_class").className = "form-group";    
        return true;  
	}
}