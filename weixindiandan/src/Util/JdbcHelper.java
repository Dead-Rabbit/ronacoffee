package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class JdbcHelper {
    public static final String url = "jdbc:mysql://localhost/ronacoffee?autoReconnect=true&useSSL=false";  
    public static final String name = "com.mysql.jdbc.Driver";  
    public static final String user = "root";  
    public static final String password = "UPCwzx1409040216"; 
    
    public JdbcHelper(){
    	try {  
            Class.forName(name);//指定连接类型  
        } catch (Exception e) {  
            e.printStackTrace();  
        } 
    }
    public Connection getConnection(){
        Connection conn = null;  
        try {
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//获取连接 
        return conn;
    }
    public boolean closeConn(Connection conn){
    	boolean ifSucc = false;
    	try {
			conn.close();
			ifSucc = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return ifSucc;
    }
    public static void main(String[] args) {
		JdbcHelper one = new JdbcHelper();
		Connection conn = one.getConnection();
		
		String sql = "select * from users";
		ResultSet res = null;
		try {
			Statement sta = conn.createStatement();
			res = sta.executeQuery(sql);
			while(res.next()){
				System.out.println("获取weichatId : " + res.getString("weichatId"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
