package com.cs336.pkg;

import java.time.LocalDate;
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
	public static String displayTime(LocalDate t) {
		int m = t.getMonthValue();
		String mo = (m < 10 ? "0"+m : ""+m);
		int d = t.getDayOfMonth();
		String dd = (d < 10 ? "0"+d : ""+d);
		int y = t.getYear();
		return mo+"/"+dd+"/"+y;
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
	public static String getDiscount(float f) {
		if(f < 0.01) {
			return "N/A - Adult";
		}
		if(f < 0.26) {
			return "Children's discount";
		}
		if(f < 0.36) {
			return "Senior's discount";
		}
		return "Disability discount";
	}
	
	public static boolean sameMonth(LocalDate monthyear, LocalDateTime t) {
		
		int last = 28;
		
		while(true) {
			boolean b = false;
			try{
				last++;
				LocalDate.of(monthyear.getYear(), monthyear.getMonthValue(), last);
			}catch(java.time.DateTimeException e){
				last--;
				break;
			}
			if(b) {
				break;
			}
		}
		LocalDate A = LocalDate.of(monthyear.getYear(),  monthyear.getMonthValue(), 1);
		LocalDate B = LocalDate.of(monthyear.getYear(),  monthyear.getMonthValue(), last);
		
		LocalDate X = t.toLocalDate();
		
		boolean p1 = X.isBefore(A);
		boolean p2 = X.isAfter(B);
		
		return !p1 && !p2;
		
	}
}
