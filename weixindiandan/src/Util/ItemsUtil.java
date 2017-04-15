package Util;

import java.util.Iterator;

import org.eclipse.jdt.internal.compiler.batch.Main;

import dao.UserDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ItemsUtil {
	//分解数据库中items内容
	public static JSONArray getItemsFItemsId(String itemId){
		JSONArray res = new JSONArray();
		String[] items = itemId.split(";");
		for(String item : items){
			JSONObject oneItem = new JSONObject();
			System.out.println(item);
			String[] values = item.split("\\+");
			oneItem.put("itemId", values[0]);
			oneItem.put("number", values[1]);
			oneItem.put("price", values[2]);
			res.put(oneItem);
		}
		return res;
	}
	public static String getItemsFJson(JSONArray array,String splitC,String openId){
		String res = "";
		UserDao userDao = new UserDao();
		String useType = userDao.ifExist(openId)?"vipPrice":"price";
		Iterator<Object> it = array.iterator();
		int addTime = 0;
		while (it.hasNext()) {
			JSONObject oneItem = (JSONObject) it.next();
			if(oneItem.getInt("number") > 0){
				if(addTime > 0){
					res += splitC;
				}
				res += oneItem.getString("itemId") + "+";
				res += oneItem.getString("number") + "+";
				res += oneItem.getString(useType);
				addTime ++;
			}
		}
		return res;
	}
	public static void main(String[] args) {
		String itemId = "100-100-100+1+80.5;100-100-101+1+72";
		ItemsUtil.getItemsFItemsId(itemId);
	}
}
