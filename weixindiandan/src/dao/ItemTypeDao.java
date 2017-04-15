package dao;
import entity.ItemTypes;
import entity.Items;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import Util.JdbcHelper;

public class ItemTypeDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//返回所有类别
	public List<ItemTypes> getAllItem(){
		List<ItemTypes> itemsTypes = new ArrayList<ItemTypes>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from itemTypes;";
		ResultSet res = null;
		
		try {
			Statement psta = conn.createStatement();
			res = psta.executeQuery(sql);
			while(res.next()){
				ItemTypes type = new ItemTypes();
				type.setItemType(res.getInt("itemType"));
				type.setTypeName(res.getString("typeName"));
				itemsTypes.add(type);
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
		return itemsTypes;
	}
	
	//根据ID返回类别
		public ItemTypes getItemById(int itemType){
			ItemTypes type = new ItemTypes();
			Connection conn = jdbcHelper.getConnection();
			String sql = "select * from itemTypes where itemType = ?;";
			ResultSet res = null;
			
			try {
				PreparedStatement psta = conn.prepareStatement(sql);
				psta.setInt(1, itemType);
				res = psta.executeQuery();
				while(res.next()){
					type.setItemType(res.getInt("itemType"));
					type.setTypeName(res.getString("typeName"));
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
			return type;
		}
}
