package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;

import Util.JdbcHelper;
import entity.*;
public class PriceDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//根据店铺获取相应价格表
	public List<Prices> getPriceByShopId(String shopId){
		List<Prices> prices = new ArrayList<Prices>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from prices where shopId = ?;";
		ResultSet res = null;
		
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, shopId);
			res = psta.executeQuery();
			while(res.next()){
				Prices price = new Prices();
				price.setItemId(res.getString("itemId"));
				price.setShopId(res.getString("shopId"));
				price.setPrice(res.getFloat("price"));
				price.setVipPrice(res.getFloat("vipPrice"));
				price.setSign(res.getString("sign"));
				prices.add(price);
			}
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				res.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return prices;
	}
	public static void main(String[] args) {
		PriceDao dao = new PriceDao();
		List<Prices> list = dao.getPriceByShopId("100011");
		for(Prices one : list){
			System.out.println(one.getSign());
		}
	}
}
