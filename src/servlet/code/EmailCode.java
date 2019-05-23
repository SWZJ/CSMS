package servlet.code;

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



@WebServlet("/code/EmailCode")
public class EmailCode extends HttpServlet {

	private static final long serialVersionUID = -3783511636417306998L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String user_account = request.getParameter("user_account");
		User user = new User().queryUserByAccount(user_account);
		
		String code = User.getEmailCode();
		boolean isSend = false;
		try {
			isSend = user.sendEmailCode(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isSend", isSend);
		map.put("code",code);
		map.put("errorMes","验证码发送失败！原因可能是发送过于频繁或次数超限。");
		map.put("successMes","验证码已成功发送到邮箱"+user.getEmailHide()+"！请注意查收。");
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
