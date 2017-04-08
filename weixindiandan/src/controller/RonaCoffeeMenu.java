package controller;
/*
 * �����������ǿ��ȵ㵥ϵͳ��controller
 */
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javafx.scene.effect.Light.Distant;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Util.MapUtil;

import java.util.Map;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import dao.*;
import entity.*;
import imple.*;

public class RonaCoffeeMenu {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	//�л�Ա������������̣�
	public RonaCoffeeMenu(HttpServletRequest request, HttpServletResponse response,JSONObject userInfo) {
		// TODO Auto-generated constructor stub
		this.request = request;
		this.response = response;
		if(userInfo.has("errcode")){
			if(userInfo.getString("errcode").equals("40029"))
				System.out.println("δ֪����");
		}
	}
	//�޻�Ա�������������items��Ϣ��
	public RonaCoffeeMenu(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated constructor stub
		this.request = request;
		this.response = response;
	}
	public void getInMenu(JSONObject userInfo,String position_longitude,String position_lat) throws ServletException, IOException{
		System.out.println(position_longitude);
		String ifvip = ifVip(userInfo.getString("openid")) ? "true":"false";
		System.out.println(ifvip);
		request.setAttribute("weichatId", userInfo.get("openid"));//��Ա��ID��
		request.setAttribute("ifVip", ifvip);//�Ƿ�ΪVIP
		List<Shops> shopList = getSortedShops(position_longitude,position_lat);
		request.setAttribute("shops", shopList);//��ȡ�̵�����
//		request.setAttribute("items",  );
		//����Ĭ���̵�
		String defalShopId = shopList.get(0).getShopId();
		request.setAttribute("shopId", defalShopId);
		request.getRequestDispatcher("./diancan.jsp").forward(request, response);
	}
	public void getInMenu(JSONObject userInfo,String position_longitude,String position_lat,String shopId) throws ServletException, IOException{
		System.out.println(position_longitude);
		String ifvip = ifVip(userInfo.getString("openid")) ? "true":"false";
		System.out.println(ifvip);
		request.setAttribute("weichatId", userInfo.get("openid"));//��Ա��ID��
		request.setAttribute("ifVip", ifvip);//�Ƿ�ΪVIP
		List<Shops> shopList = getSortedShops(position_longitude,position_lat);
		request.setAttribute("shops", shopList);//��ȡ�̵�����
//		request.setAttribute("items",  );
		//�����̵�
		request.setAttribute("shopId", shopId);
		request.getRequestDispatcher("./diancan.jsp").forward(request, response);
	}
	//�Ƿ���VIP��Ա
	private boolean ifVip(String weichatId){
		UserDao userDao = new UserDao();
		List<Users> user = userDao.getUsersById(weichatId);
		return user.isEmpty() ? false:true;
	}
	//���������̵꣨������
	private List<Shops> getSortedShops(String position_longitude,String position_lat){
		//��ȡ�����̵�
		ShopDao shopDao = new ShopDao();
		List<Shops> shops = shopDao.getAllShop();
		List<Shops> newShops = new ArrayList<Shops>();
		Map<Double, Shops> distance = new HashMap<Double,Shops>();
		//����λ�þ��벢��
		for(Shops shop : shops){
			distance.put(MapUtil.Distence(Double.parseDouble(position_longitude),
										Double.parseDouble(position_lat), 
										Double.parseDouble(shop.getShopPosition_longitude()), 
										Double.parseDouble(shop.getShopPosition_lat())
										),shop);
		}
		//��������
		distance = MapUtil.sortMapByKey(distance);
		for(Double key : distance.keySet()){
			newShops.add(distance.get(key));
		}
		return newShops;
	}
	//��ȡ�̵��Ӧ������Ʒ������Price���е�˳������JSON��ʽ
	public JSONArray getPricesByShopId(String shopId){
		JSONArray res = new JSONArray();
		PriceDao priceDao = new PriceDao();
		
		List<Prices> prices = priceDao.getPriceByShopId(shopId);
		System.out.println(prices);
		for(Prices price : prices){
			JSONObject oneJson = new JSONObject();
			oneJson.put("item", getOneItemFList(price.getItemId()));
			oneJson.put("price", price.getPrice());
			oneJson.put("vipPrice", price.getVipPrice());
			oneJson.put("sign", price.getSign());
			res.put(oneJson);
		}
		return res;
	}
	//��ȡ�̵��Ӧ������Ʒ������Price���е�˳������JSON��ʽ
		public JSONObject getItemAPricesByShopId(String shopId){
			JSONObject res = new JSONObject();
			PriceDao priceDao = new PriceDao();
			
			List<Prices> prices = priceDao.getPriceByShopId(shopId);
			System.out.println(prices);
			for(Prices price : prices){
				JSONObject oneJson = new JSONObject();
				oneJson.put("itemId", getOneItemFList(price.getItemId()).getItemId());
				oneJson.put("price", price.getPrice());
				oneJson.put("vipPrice", price.getVipPrice());
				oneJson.put("number", 0);
				res.put("items", oneJson);
			}
			res.put("ifVip", "false");
			return res;
		}
	private Items getOneItemFList(String itemId){
		ItemDao itemDao = new ItemDao();
		List<Items> items = itemDao.getAllItem();
		for(Items item : items){
			if(itemId.equals(item.getItemId())){
				return item;
			}
		}
		return null;
	}
}
