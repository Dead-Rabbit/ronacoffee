package controller;
/*
 * 用来进行罗那咖啡点单系统的controller
 */
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.MapUtil;

import java.util.Map;

import net.sf.json.JSONObject;
import dao.*;
import entity.*;
import imple.*;

public class RonaCoffeeMenu {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	public RonaCoffeeMenu(HttpServletRequest request, HttpServletResponse response,JSONObject userInfo) {
		// TODO Auto-generated constructor stub
		this.request = request;
		this.response = response;
		if(userInfo.has("errcode")){
			if(userInfo.getString("errcode").equals("40029"))
				System.out.println("未知错误");
		}
	}
	public void getInMenu(JSONObject userInfo,String position_longitude,String position_lat) throws ServletException, IOException{
		System.out.println(position_longitude);
		String ifvip = ifVip(userInfo.getString("openid")) ? "true":"false";
		System.out.println(ifvip);
		request.setAttribute("ifVip", ifvip);
		request.setAttribute("shop", "100011");
		request.getRequestDispatcher("/testMenu.jsp").forward(request, response);
	}
	private boolean ifVip(String weichatId){
		UserDao userDao = new UserDao();
		List<Users> user = userDao.getUsersById(weichatId);
		return user.isEmpty() ? false:true;
	}
	private List<Shops> getSortedShops(String position_longitude,String position_lat){
		ShopDao shopDao = new ShopDao();
		List<Shops> shops = shopDao.getAllShop();
		Map<Double, Shops> distences = new HashMap<Double,Shops>();
		for(Shops shop : shops){
			distences.put(MapUtil.Distence(Double.parseDouble(position_longitude),
										Double.parseDouble(position_lat), 
										Double.parseDouble(shop.getShopPosition_longitude()), 
										Double.parseDouble(shop.getShopPosition_lat())
										),shop);
		}
		System.out.println(MapUtil.sortMapByKey(distences));
		return shops;
	}
}
