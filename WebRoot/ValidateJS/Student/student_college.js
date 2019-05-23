//学生学院验证JS

function checkStudent_college(){
    var field = document.getElementById("student_college").value;  
    var spanNode = document.getElementById("student_college_span");
	//学院的规则：必选
	if(field == 0){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_college\">学院必须选择！</label>";  
        document.getElementById("student_college_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("student_college_class").className = "form-group has-success";    
        return true;  
	}
}