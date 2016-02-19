package com.will.fashion.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
	public static Long StringToLong(String datetimes) { 
		SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
		Long longTime = System.currentTimeMillis();
		try {
			Date dt = sdf.parse(datetimes);
			longTime = dt.getTime();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return longTime.longValue();
	}
}
