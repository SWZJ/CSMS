package servlet.manageInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import JZW.User;


@WebServlet("/manageInfo/UserResetPassword")
public class UserResetPassword extends HttpServlet {

	private static final long serialVersionUID = -7408583274025324594L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_account = request.getParameter("user_account");
		String user_password = request.getParameter("user_password");
		User user = new User().queryUserByAccount(user_account);
		boolean isOK = user.updateUserPassword(user, user_password);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isOK", isOK);
		map.put("errorMes","重置密码失败！");
		map.put("successMes","重置密码成功！");
		map.put("user", user);
		
		Gson gson = new Gson();
		String json = gson.toJson(map);
		response.setCharacterEncoding("UTF-8");  
		PrintWriter writer = response.getWriter();
		writer.println(json);
		writer.flush();
		writer.close();
	}
 
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}