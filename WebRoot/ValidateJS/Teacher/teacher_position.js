//教师职称验证JS

function checkTeacher_position(){
    var field = document.getElementById("teacher_position").value;  
    var spanNode = document.getElementById("teacher_position_span");
	//职称的规则：必选
	if(field.length == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"teacher_position\">专业必须选择！</label>";  
        document.getElementById("teacher_position_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("teacher_position_class").className = "form-group";    
        return true;  
	}
}