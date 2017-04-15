package servlet;

import java.awt.List;
import java.io.IOException;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.ItemsUtil;
import dao.UserDao;
import dao.WorkOrderDao;
import entity.WorkOrders;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class WorkOrderServlet
 */
@WebServlet("/WorkOrderServlet")
public class WorkOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public WorkOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		JSONObject getJson = new JSONObject();
		getJson = JSONObject.fromString(request.getParameter("sendInput"));
		WorkOrderDao workDao = new WorkOrderDao();
		System.out.println(getJson);
		switch(getJson.get("type").toString()){
			case "userUpload":
				JSONObject json = getJson.getJSONObject("content");
				WorkOrders workOrder = new WorkOrders();
				workOrder.setOrderId(workDao.getNewOrderId());
				workOrder.setWeichatId(json.getString("openid"));
				workOrder.setShopId(json.getString("shopId"));
				workOrder.setItemIds(ItemsUtil.getItemsFJson(json.getJSONArray("items") , ";" , json.getString("openid")));
				workOrder.setPrice(getPrice(json));
				workOrder.setIfBalance(false);
				workOrder.setToken(workDao.getNewToken());
				
				if(workDao.createNewWorkOrder(workOrder)){
					System.out.println("create succ and id is :" + workOrder.getOrderId());
					String link = "./showOrderDetails.jsp?orderId=" + workOrder.getOrderId() + "&weichatId=" + json.getString("openid");
					request.getRequestDispatcher(link).forward(request, response);
				}else{
					System.out.println("create false");
				}
				//System.out.println(workOrder.getItemIds());
			break;
		}
	}
	
	
	private Float getPrice(JSONObject json){
		float totalMoney = 0.0f;
		UserDao userDao = new UserDao();
		String useType = userDao.ifExist(json.getString("openid"))?"vipPrice":"price";
		
		JSONArray array = json.getJSONArray("items");
		Iterator<Object> it = array.iterator();
		while (it.hasNext()) {
			JSONObject oneItem = (JSONObject) it.next();
			totalMoney += oneItem.getInt("number") * oneItem.getDouble(useType);
		}
		System.out.println("totalMoney:" + totalMoney);
		return totalMoney;
	}

}
