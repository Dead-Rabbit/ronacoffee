package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import entity.*;
import Util.*;

public class ItemDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//返回所有商品
	public List<Items> getAllItem(){
		List<Items> items = new ArrayList<Items>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from items;";
		ResultSet res = null;
		
		try {
			Statement psta = conn.createStatement();
			res = psta.executeQuery(sql);
			while(res.next()){
				Items item = new Items();
				item.setItemId(res.getString("itemId"));
				item.setItemName(res.getString("itemName"));
				item.setDescription(res.getString("description"));
				items.add(item);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return items;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ItemDao dao = new ItemDao();
		List<Items> list = dao.getAllItem();
		for(Items item : list){
			System.out.println(item.getDescription());
		}
	}

}
