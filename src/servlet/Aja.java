package servlet;

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

@WebServlet("/Aja")
public class Aja extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5180828260287369091L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String id = request.getParameter("id");
		//System.out.println(id);
		/*try {
			studio = dao.getCustomerById(Integer.parseInt(id));
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		Gson gson = new Gson();
		Map<String,Object> map = new HashMap<String,Object>();
		//添加两个普通节点
		map.put("id",id);
		map.put("username",username);
		map.put("a","1");
		map.put("b",2);
		User user = new User();
		user.setAccount("asdfaf");
		user.setStudentID(5);
		map.put("user",user);
		
		String json = gson.toJson(map);
		response.setCharacterEncoding("UTF-8");  
		PrintWriter writer = response.getWriter();
		/*writer.append("sadfas "+user);*/
		/*String json = "{"
				+ "'user':'"+user+"'"
				+ "}";*/
		writer.println(json);
		writer.flush();
		writer.close();
	}
 
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
