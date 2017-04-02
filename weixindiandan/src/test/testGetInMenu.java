package test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;
import controller.*;
/**
 * Servlet implementation class testGetInMenu
 */
@WebServlet("/testGetInMenu")
public class testGetInMenu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public testGetInMenu() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		JSONObject testUserInfoJson = new JSONObject();
		testUserInfoJson = JSONObject.fromString("{\"openid\":\"asdfweqwe12312jj123k1l21\",\"nickname\":\"??\",\"sex\":1,\"language\":\"zh_CN\",\"city\":\"??\",\"province\":\"??\",\"country\":\"??\",\"headimgurl\":\"http://wx.qlogo.cn/mmopen/P0rSyZjRsLn8rjCaYibaut5o4wPtMvTYH79WlCQXggJ6TNEz2YeHicXz3SpiasfwMLFnvsUdTKEaejIiaBQ1zDphH5OibDf9yQPQO/0\",\"privilege\":[]}");
		System.out.println(testUserInfoJson.getString("openid"));
		RonaCoffeeMenu controller = new RonaCoffeeMenu(request, response, testUserInfoJson);
		controller.getInMenu(testUserInfoJson, "100.20000", "100.20000");
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
