package Util;
import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import net.sf.json.*;
public class AuthUtil {
	//²âÊÔ¹«ÖÚºÅ APPID ºÍ APPSECRET
	public static final String APPID = "wx80e157d4c2dfc1db";
	public static final String APPSECRET = "5817b07451a0e8363c563790cfa52c87";
	public static JSONObject doGetJson(String url) throws ClientProtocolException, IOException{
		JSONObject jsonObject = null;
		DefaultHttpClient client = new DefaultHttpClient();
		HttpGet httpGet = new HttpGet(url);

		HttpResponse res = client.execute(httpGet);
		HttpEntity entity = res.getEntity();
		if(entity != null){
			String result = EntityUtils.toString(entity,"utf-8");
			jsonObject = JSONObject.fromObject(result);
		}
		httpGet.releaseConnection();
		return jsonObject;
	}
}
