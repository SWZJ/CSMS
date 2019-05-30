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


@WebServlet("/manageInfo/UserIsAccountExist")
public class UserIsAccountExist extends HttpServlet {

	private static final long serialVersionUID = -3717182250087350119L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_account = request.getParameter("user_account");
		User user = new User().queryUserByAccount(user_account);
		boolean isExist = user.isExist_account(user_account);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isExist", isExist);
		map.put("errorMes","账号 "+user_account+" 已被注册！");
		map.put("successMes","该账号可被注册！");
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
