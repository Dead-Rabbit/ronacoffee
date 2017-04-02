package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.sun.corba.se.spi.orbutil.fsm.State;

import entity.Shops;
import entity.Users;
import Util.JdbcHelper;
public class ShopDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//获得所有商店
	public List<Shops> getAllShop(){
		List<Shops> shops = new ArrayList<Shops>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from shops;";
		ResultSet res = null;
		
		try {
			Statement psta = conn.createStatement();
			res = psta.executeQuery(sql);
			while(res.next()){
				Shops shop = new Shops();
				shop.setShopId(res.getString("shopId"));
				shop.setShopName(res.getString("shopName"));
				shop.setShopPosition_longitude(res.getString("shopPosition_longitude"));
				shop.setShopPosition_lat(res.getString("shopPosition_lat"));
				shops.add(shop);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return shops;
	}
	public static void main(String[] args) {
		ShopDao dao = new ShopDao();
		List<Shops> list = dao.getAllShop();
		System.out.println(list.size());
	}
}
