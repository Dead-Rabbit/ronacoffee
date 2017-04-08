package Util;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import entity.Shops;

/*
 * 作为经纬度相关计算的工具
 */
public class MapUtil {
	//计算两点之间距离
	public static double Distence(double long1, double lat1, double long2,  
	        double lat2) {  
	    double a, b, R;  
	    R = 6378137; // 地球半径  
	    lat1 = lat1 * Math.PI / 180.0;  
	    lat2 = lat2 * Math.PI / 180.0;  
	    a = lat1 - lat2;  
	    b = (long1 - long2) * Math.PI / 180.0;  
	    double d;  
	    double sa2, sb2;  
	    sa2 = Math.sin(a / 2.0);  
	    sb2 = Math.sin(b / 2.0);  
	    d = 2  
	            * R  
	            * Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(lat1)  
	                    * Math.cos(lat2) * sb2 * sb2));  
	    return d; 
	}
	/**
	 * 使用 Map按key进行排序
	 * @param map
	 * @return
	 */
	public static Map<Double, Shops> sortMapByKey(Map<Double, Shops> map) {
		if (map == null || map.isEmpty()) {
			return null;
		}

		Map<Double, Shops> sortMap = new TreeMap<Double, Shops>();

		sortMap.putAll(map);

		return sortMap;
	}
//	class MapKeyComparator implements Comparator<String>{
//
//		@Override
//		public int compare(Double str1, Shops str2) {
//			
//			return str1.compareTo(str2);
//		}
//	}
	public static void main(String[] args) {
		Map<Double, Shops> map = new HashMap<Double, Shops>();
		Shops one = new Shops();
		Shops two = new Shops();
		Shops three = new Shops();
		one.setShopId("1");
		two.setShopId("2");
		three.setShopId("3");
		map.put(1.0, one);
		map.put(2.4, three);
		map.put(2.0, two);
		for(Double key : map.keySet()){
			System.out.println(key);
		}
		map = MapUtil.sortMapByKey(map);
		for(Double key : map.keySet()){
			System.out.println(key);
		}
	}
}
