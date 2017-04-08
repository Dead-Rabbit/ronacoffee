package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entity.Users;
import Util.*;
public class UserDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	public List<Users> getUsersById(String weichatId){
		List<Users> users = new ArrayList<Users>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from users where weichatId = ?";
		ResultSet res = null;
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, weichatId);
			res = psta.executeQuery();
			while(res.next()){
				Users user = new Users();
				user.setWeichatId(res.getString("weichatId"));
				user.setVipExpiryDate(res.getString("vipExpiryDate"));
				user.setShellEdOut(res.getInt("shellEdOut"));
				user.setShopId(res.getString("shopId"));
				users.add(user);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				conn.close();
				res.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return users;
	}
	/*
	 * 用来增加用户
	 */
	public boolean addUser(){
		boolean ifSucc = false;
		return ifSucc;
	}
	/*
	 * 判断用户是否存在，通过 weichatId
	 */
	public boolean ifExist(String weichatId){
		boolean ifSucc = false;
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from users where weichatId = ?";
		ResultSet res = null;
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, weichatId);
			res = psta.executeQuery();
			while(res.next()){
				ifSucc = true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				res.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ifSucc;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//测试成功
		UserDao dao = new UserDao();
		String openid = "asdfweqwe12312jj123k1l21";
		List<Users> users = dao.getUsersById(openid);
		boolean ifSucc = users.isEmpty() ? false:true;
		String ifVip = ifSucc ? "true" : "false";
		System.out.println(dao.ifExist(openid));
	}

}
