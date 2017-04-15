package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.util.Date;

import com.mysql.fabric.xmlrpc.base.Data;
import com.sun.corba.se.spi.orbutil.fsm.State;

import Util.*;
import entity.*;
public class WorkOrderDao {
	JdbcHelper jdbcHelper = new JdbcHelper();
	
	//插入新的工单
	public boolean createNewWorkOrder(WorkOrders workOrder){
		boolean ifSucc = false;

		Connection conn = jdbcHelper.getConnection();
		String sql = "insert into ronacoffee.workOrder(orderId,weichatId,shopId,itemId,price,ifBalance,token,createTime) "
				+ "value(?,?,?,?,?,?,?,?);";
		Date date = new Date();
		Timestamp tt=new Timestamp(date.getTime());
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, workOrder.getOrderId());
			psta.setString(2, workOrder.getWeichatId());
			psta.setString(3, workOrder.getShopId());
			psta.setString(4, workOrder.getItemIds());
			psta.setFloat(5, workOrder.getPrice());
			psta.setBoolean(6, workOrder.getIfBalance());
			psta.setString(7, workOrder.getToken());
			psta.setTimestamp(8, tt);
			
			psta.executeUpdate();
			ifSucc = true;
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ifSucc;
	}
	//获得用户对应所有工单
	public List<WorkOrders> getWordOrderByOpenId(String weichatId){
		List<WorkOrders> list = new ArrayList<WorkOrders>();
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from ronacoffee.workOrder where weichatId = ? order by orderId+0 DESC;";
		ResultSet res = null;
		try {
			PreparedStatement psta = conn.prepareStatement(sql);
			psta.setString(1, weichatId);
			res = psta.executeQuery();
			
			while(res.next()){
				WorkOrders workOrder = new WorkOrders();
				workOrder.setOrderId(res.getString("orderId"));
				workOrder.setWeichatId(res.getString("weichatId"));
				workOrder.setShopId(res.getString("shopId"));
				workOrder.setItemIds(res.getString("itemId"));
				workOrder.setPrice(res.getFloat("price"));
				workOrder.setIfBalance(res.getBoolean("ifBalance"));
				workOrder.setToken(res.getString("token"));
				workOrder.setCreateTime(res.getTimestamp("createTime"));
				list.add(workOrder);
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
		return list;
	}
	//获得用户对应所有工单
		public List<WorkOrders> getWordOrderByOrder(String orderId){
			List<WorkOrders> list = new ArrayList<WorkOrders>();
			Connection conn = jdbcHelper.getConnection();
			String sql = "select * from ronacoffee.workOrder where orderId = ? order by orderId+0 DESC;";
			ResultSet res = null;
			try {
				PreparedStatement psta = conn.prepareStatement(sql);
				psta.setString(1, orderId);
				res = psta.executeQuery();
				
				while(res.next()){
					WorkOrders workOrder = new WorkOrders();
					workOrder.setOrderId(res.getString("orderId"));
					workOrder.setWeichatId(res.getString("weichatId"));
					workOrder.setShopId(res.getString("shopId"));
					workOrder.setItemIds(res.getString("itemId"));
					workOrder.setPrice(res.getFloat("price"));
					workOrder.setIfBalance(res.getBoolean("ifBalance"));
					workOrder.setToken(res.getString("token"));
					workOrder.setCreateTime(res.getTimestamp("createTime"));
					list.add(workOrder);
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
			return list;
		}
	public String getNewOrderId(){
		String res = "1000000";
		
		Connection conn = jdbcHelper.getConnection();
		String sql = "select * from ronacoffee.workOrder order by orderId+0 DESC;";
		ResultSet result = null;
		try {
			Statement psta = conn.createStatement();
			result = psta.executeQuery(sql);
			while(result.next()){
				int orderInt = Integer.parseInt(result.getString("orderId"))+1;
				res = ""+orderInt;
				break;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				result.close();
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return res;
	}
	
	public String getNewToken(){
		String res = "10000001";
		return res;
	}
	public static void main(String[] args) {
		WorkOrderDao dao = new WorkOrderDao();
		/*WorkOrders workOrder = new WorkOrders();
		workOrder.setOrderId("1000000001");
		workOrder.setWeichatId("asdfweqwe12312jj123k1l21");
		workOrder.setShopId("100011");
		workOrder.setItemIds("100-100-101;100-100-102;100-100-103;100-100-104;100-100-105");
		workOrder.setPrice(100.0f);
		workOrder.setIfBalance(false);
		workOrder.setToken("20");
		if(dao.createNewWorkOrder(workOrder)){
			System.out.println("succ");
		}else{
			System.out.println("false");
		}*/
		String weichatId = "asdfweqwe12312jj123k1l21";
		List<WorkOrders> list = dao.getWordOrderByOpenId(weichatId);
		for(WorkOrders order : list){
			System.out.println(order.getCreateTime());
		}
	}
}
