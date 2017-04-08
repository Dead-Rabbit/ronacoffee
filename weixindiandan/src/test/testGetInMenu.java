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
		//�˴���ȡ�û���Ϣ
		JSONObject testUserInfoJson = new JSONObject();
		testUserInfoJson = JSONObject.fromString("{\"openid\":\"asdfweqwe12312jj123k1l21\",\"nickname\":\"??\",\"sex\":1,\"language\":\"zh_CN\",\"city\":\"??\",\"province\":\"??\",\"country\":\"??\",\"headimgurl\":\"http://wx.qlogo.cn/mmopen/P0rSyZjRsLn8rjCaYibaut5o4wPtMvTYH79WlCQXggJ6TNEz2YeHicXz3SpiasfwMLFnvsUdTKEaejIiaBQ1zDphH5OibDf9yQPQO/0\",\"privilege\":[]}");
		
		//�ڴ˴���ȡ�û�����λ��
		String position_longitude = "35.9609059660";
		String position_lat = "120.2479520374";
		
		//�����̵�ҳ��
		RonaCoffeeMenu controller = new RonaCoffeeMenu(request, response);
		if(request.getParameter("shopId")==null){
			//�޲� Ĭ�Ͻ���ҳ��
			controller.getInMenu(testUserInfoJson, position_longitude, position_lat);
		}else{
			//�в� ����ҳ��
			controller.getInMenu(testUserInfoJson, position_longitude, position_lat,request.getParameter("shopId"));
		}
	}
	/** 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request,response);
	}

}
