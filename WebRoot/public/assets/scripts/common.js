//全局JS函数

//正在输入（去除提示信息）
function Inputing(spanNode,classNode){
	spanNode.innerHTML="";
	classNode.className="form-group";
}

//邮箱隐藏
function HideEmail(email){
	if (String (email).indexOf ('@') > 0) {
        let newEmail, str = email.split('@'), _s = '';

        if (str[0].length > 4) {
            _s = str[0].substr (0, 4);
            for (let i = 0; i < str[0].length - 4; i++) {
                _s += '*';
            }
        } else {
            _s = str[0].substr (0, 1);
            for (let i = 0; i < str[0].length - 1; i++) {
                _s += '*';
            }
        }
        newEmail = _s + '@' + str[1];
        return newEmail;
    } else {
        return email;
    }
}

//手机号隐藏
function HidePhone(phone){
	let newPhone = '';
　　if (phone.length > 7) {
		newPhone=phone.substr(0, 3) + '****' + phone.substr(7);
        return newPhone;
    } else {
        return phone;
    }
}

//获取URL参数
function GetUrlParam(paraName) {
　　var url = document.location.toString();
　　var arrObj = url.split("?");
　　if (arrObj.length > 1) {
　　　　var arrPara = arrObj[1].split("&");
　　　　var arr;
　　　　for (var i = 0; i < arrPara.length; i++) {
　　　　　　arr = arrPara[i].split("=");
　　　　　　if (arr != null && arr[0] == paraName) {
　　　　　　　　return arr[1];
　　　　　　}
　　　　}
　　　　return "";
　　}
　　else {
　　　　return "";
　　}
}

//改变页码
$(document).ready(function(){
	//页面行数改变，刷新页面
	$("#selectPages").change(function(){
		$("#pageNumForm").submit();
	});
});
$("#selectPages option").each(function(){
	if($(this).val()==GetUrlParam("selectPages")){
		$(this).prop('selected',true);
	}
});
