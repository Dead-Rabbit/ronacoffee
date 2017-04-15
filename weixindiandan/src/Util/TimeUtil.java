package Util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeUtil {
	public static String getTime(Timestamp timestamp) {
		Date currentTime = timestamp;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String dateString = format.format(currentTime);
		return dateString;
	}
}
