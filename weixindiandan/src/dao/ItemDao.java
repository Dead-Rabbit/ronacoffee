package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
				item.setItemType(res.getInt("itemType"));
				item.setDescription(res.getString("description"));
				items.add(item);
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
		return items;
	}
	//根据商品ID获取商品
	public Items getItemById(String itemId){
		Items item = new Items();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from items where itemId = ?";
		ResultSet res = null;
		
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1,itemId);
			res = psta.executeQuery();
			while(res.next()){
				item.setItemId(res.getString("itemId"));
				item.setItemName(res.getString("itemName"));
				item.setItemType(res.getInt("itemType"));
				item.setDescription(res.getString("description"));
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
		return item;
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
