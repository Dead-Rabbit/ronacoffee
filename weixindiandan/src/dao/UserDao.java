package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
		}
		return users;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//≤‚ ‘≥…π¶
		UserDao dao = new UserDao();
		List<Users> users = dao.getUsersById("asdfweqwe12312jj123k1l21");
		boolean ifSucc = users.isEmpty() ? false:true;
		String ifVip = ifSucc ? "true" : "false";
		System.out.println(ifVip);
	}

}
