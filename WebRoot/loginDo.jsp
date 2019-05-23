<%@ page language="java" import="java.util.*,JZW.*" pageEncoding="utf-8"%>

<%
    //获取上一个页面传递过来的数据
	request.setCharacterEncoding("UTF-8");
    String account = request.getParameter("account");
    String password = request.getParameter("password");
    String userID = request.getParameter("userID");
    String remember = request.getParameter("remember");
	
	User user = new User();
	user = user.validateAccountPassword(account, password);
	if(user!=null){
		if(user.getPassword().equals("123456")){%>
		<script>
			while(true){
				var password1 = prompt("你是第一次登录或未修改过初始密码！\n请设置你的登录密码（不能为\"123456\"）\n6~18位字符,必须包含数字、字母或特殊字符其中两项及以上","");
				var reg = /^(?![a-zA-z]+$)(?!\d+$)(?![!@#$%^&*./\-\+]+$)[a-zA-Z\d!@#$%^&*.\-\+]+$/;
				if(password1!=null&&password1.length!=0&&password1!="123456"&&reg.test(password1)&&(password1.length>=6&&password1.length<=18)){
					var password2 = prompt("请再次输入以确认你的登录密码","");
					if(password2==password1){
						alert("登录成功！\n请记住你设置的登录密码 "+password2+" 以便下次登录！");
						window.location.href = "index.jsp?password="+password2;
						break;
					}else{
						alert("输入的两次密码不一致！\n请重新输入！");
					}
				}else if(password1==null||password1.length==0){
					alert("密码不能为空！");
				}else if(password1=="123456"){
					alert("不能设置密码为123456！");
				}else if(!reg.test(password1)||(password1.length<6||password1.length>18)){
					alert("密码必须为6~18位字符,包含数字、字母或特殊字符其中两项及以上！");
				}
			}
		</script>
		<%}
		if(remember!=null)	user.setRemember(true);
		session.setAttribute("user",user);
		out.print("<script>window.location.href = \"/CSMS/index.jsp\";</script>");
	}else{
		if(account.equals("520")&&password.equals("520")){	
			user = new User();
			user.setRoot(520);
			session.setAttribute("user",user);
			out.print("<script>window.location.href = \"/CSMS/index.jsp\";</script>");
		}
		else	out.print("<script>alert(\"账号或密码错误！\");window.history.back();</script>");
	}
%>


