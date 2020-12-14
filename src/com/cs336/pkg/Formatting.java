package com.cs336.pkg;

import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Locale;

public class Formatting {
	
	public static String displayTime(LocalDateTime t) {
		int h = t.getHour();
		String XM = "AM";
		if(h > 12) { 
			XM = "PM";
			h = h - 12;
		}
		if(h == 0) {
			h = 12;
		}
		int min = t.getMinute();
		String mins = (min < 10 ? "0"+min : ""+min);
		int m = t.getMonthValue();
		String mo = (m < 10 ? "0"+m : ""+m);
		int d = t.getDayOfMonth();
		String dd = (d < 10 ? "0"+d : ""+d);
		int y = t.getYear();
		return h+":"+mins+" "+XM+" on "+mo+"/"+dd+"/"+y;
	}
	
	public static String getFare(float f) {
		int r = (int) f;
		String floatversion = f+"";
		//System.out.println(floatversion);
		String intversion = r+"";
		//System.out.println("FLOAT STUFF"+floatversion.substring(intversion.length(), intversion.length()+3));
		intversion += floatversion.substring(intversion.length(), intversion.length()+2);
		//System.out.println("intv at this stage "+intversion);
		if(floatversion.length() > intversion.length() + 2) {
			intversion += floatversion.substring(intversion.length(), intversion.length()+1);
		} else {
			intversion += "0";
		}
		return "$"+intversion;
	}
	
}
