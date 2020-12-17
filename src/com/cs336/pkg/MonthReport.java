package com.cs336.pkg;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class MonthReport {
	public static LocalDate my;
	public static String tln;
	public static String username;
	
	public static boolean validdate = false;
	
	public static int MONTHSELECT;
	public static String YEARSELECT;
	
	public static int TLNSELECT;
	public static int CUSTOMERSELECT;
	
	public static ArrayList<String> TLOptions;
	public static ArrayList<String> COptions;
	
	public static ArrayList<String> errors = new ArrayList<String>();
	
	public static String c1;
	public static String c2;
	public static String c3;
	
	public static void setChecked(int c, int nindex) {
		if(c == 0) {
			c1 = "checked"; c2 = ""; c3 = "";
			CUSTOMERSELECT = 0;
			TLNSELECT = 0;
		}
		if(c == 1) {
			c1 = ""; c2 = "checked"; c3 ="";
			CUSTOMERSELECT = nindex;
			TLNSELECT = 0;
		}
		if(c == 2) {
			c1 = ""; c2 = ""; c3 = "checked";
			CUSTOMERSELECT = 0;
			TLNSELECT = nindex;
		}
	}
	
	public static void refreshWithNewDate() {
		
	}
	
	public static void update(HttpServletRequest r) throws SQLException {
		if(r.getParameter("datesubmit") == null && r.getParameter("reportsubmit") == null) {
			tln = null;
			username = null;
			TLOptions = Formatting.getTransitLineNames();
			TLOptions.add(0, "--SELECT TRANSIT LINE--");
			
			COptions = new ArrayList<String>();
			COptions.add("--SELECT CUSTOMER--");
			for(Customer c : TrainProject.Customers.getAsList()) {
				COptions.add(c.username);
			}
			MONTHSELECT = 0;
			YEARSELECT = "";
			setChecked(0, -1);
			validdate = false;
		} 
		if(r.getParameter("datesubmit") != null) {
			int mo = Integer.parseInt(r.getParameter("month"));
			int yy = Integer.parseInt(r.getParameter("year"));
			if(mo == 0) {
				errors.add("Please select a month");
				validdate = false;
				YEARSELECT = "";
				MONTHSELECT = 0;
				return;
			}
			LocalDate temp;
			try {
				temp = LocalDate.of(yy, mo, 1);
			}catch(Exception e) {
				YEARSELECT = "";
				MONTHSELECT = 0;
				errors.add("Please select a valid year");
				validdate = false;
				return;
			}
			validdate = true;
			my = temp;
			MONTHSELECT = my.getMonthValue();
			YEARSELECT = ""+my.getYear();
			//refreshWithNewDate();
		}
		if(r.getParameter("reportsubmit") != null) {
			if(r.getParameter("torc").equals("0")) {
				if(!c1.equals("")) {
					errors.add("Please select to use either the Customer or Transit Line report option. Unselect do-not-use");
				} else {
					setChecked(0, -1);
				}
				return;
			}
			if(r.getParameter("torc").equals("1")) {
				int v = Integer.parseInt(r.getParameter("customerindex"));
				setChecked(1, v);
				if(v == 0) {
					errors.add("Please select a Customer username from the dropdown menu. Unselect --SELECT CUSTOMER--");
					return;
				}
				String u = COptions.get(v);
				Customer c = TrainProject.Customers.get(u);
			}
			if(r.getParameter("torc").equals("2")) {
				int v = Integer.parseInt(r.getParameter("tlnindex"));
				setChecked(2, v);
				if(v == 0) {
					errors.add("Please select a Transit Line Name from the dropdown menu. Unselect --SELECT TRANSIT LINE NAME--");
					return;
				}
				
				String u = TLOptions.get(v);
			}
			
		}
	}
	
}
