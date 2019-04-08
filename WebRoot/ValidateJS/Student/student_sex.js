//学生性别验证JS

function checkStudent_sex(){
    var field = document.getElementsByName("student_sex");  
    var spanNode = document.getElementById("student_sex_span");  
    //性别的规则：必填
	var flag = 0;
	for (var i=0;i<field.length;i++){
		if (field.item(i).checked == true){
			flag = 1;break;
		}
	}
	if (!flag){
		//不符合规则
        spanNode.innerHTML = "<label class=\"control-label text-danger\" for=\"student_sex\">性别必须选择！</label>";  
        document.getElementById("student_sex_class").className = "form-group has-error";    
        return false;
	}else{
		//符合规则
        spanNode.innerHTML = "";  
        document.getElementById("student_sex_class").className = "form-group"; 
        return true;  
	}
}