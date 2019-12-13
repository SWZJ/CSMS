package servlet.manageInfo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import JZW.User;


@WebServlet("/manageInfo/UserIsExist")
public class UserIsExist extends HttpServlet {
	
	private static final long serialVersionUID = 7942918037570699288L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);  
		String ID = request.getParameter("ID");
		ArrayList<User> userList = new ArrayList<User>();
		User user = new User().queryUserByAccount(ID);
		if(user.getID()!=0)	userList.add(user);
		ArrayList<User> user1 = (ArrayList<User>) new User().queryUserByPhone(ID);
		if(user1.size()!=0)	userList.addAll(user1);
		ArrayList<User> user2 = (ArrayList<User>) new User().queryUserByEmail(ID);
		if(user2.size()!=0)	userList.addAll(user2);
		
		boolean isExist = userList.size()==0?false:true;
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("isExist", isExist);
		map.put("errorMes",session.getAttribute("lan").equals("en")?"The user was not found!":"该用户未找到！");
		map.put("successMes",session.getAttribute("lan").equals("en")?"This account corresponds to multiple users. Please select one":"该账号对应多个用户，请选择一个");
		map.put("userList", userList);
		
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
