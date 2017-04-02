package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

import Util.JdbcHelper;
import entity.*;
public class PriceDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//根据店铺获取相应价格表
	public List<Prices> getPriceByShop(Shops shop){
		List<Prices> prices = new ArrayList<Prices>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from prices where shopId = ?;";
		ResultSet res = null;
		
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, shop.getShopId());
			res = psta.executeQuery();
			while(res.next()){
				Prices price = new Prices();
				price.setItemId(res.getString("itemId"));
				price.setShopId(res.getString("shopId"));
				price.setPrice(res.getFloat("price"));
				prices.add(price);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return prices;
	}
	public static void main(String[] args) {
		PriceDao dao = new PriceDao();
		Shops shop = new Shops();
		shop.setShopId("100011");
		List<Prices> list = dao.getPriceByShop(shop);
		for(Prices one : list){
			System.out.println(one.getPrice());
		}
	}
}
