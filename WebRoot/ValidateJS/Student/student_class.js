//学生班级验证JS

function checkStudent_class(){
    var field = document.getElementById("student_class").value;  
    var spanNode = document.getElementById("student_class_span");
	//班级的规则：必选
	if(field == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_class\">班级必须选择！</label>";  
        document.getElementById("student_class_class").className = "form-group has-error";
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("student_class_class").className = "form-group has-success";    
        return true;
	}
}