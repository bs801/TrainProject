<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.time.LocalTime, java.time.LocalDateTime"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

	int h = Integer.parseInt(request.getParameter("hour"));
	int min = Integer.parseInt(request.getParameter("minute"));
	String xm = request.getParameter("xm");
	
	Calendar cal = Calendar.getInstance();
	cal.setLenient(false);
	cal.set(Calendar.YEAR, 2000);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	cal.set(Calendar.HOUR_OF_DAY, h);
	cal.set(Calendar.MINUTE, min);
	cal.set(Calendar.SECOND, 0);
	if(xm.equals("pm")){
		h += 12;
	}

	ArrayList<String> errors = new ArrayList<String>();
	int m = Integer.parseInt(request.getParameter("month"))-1;
	if(m < 0){
		errors.add("Must select a month");
		m = 0;
	}
	
	cal.set(Calendar.MONTH, m);
	int d;
	try{
		d = Integer.parseInt(request.getParameter("day"));
		cal.set(Calendar.DAY_OF_MONTH, d);
		try {
		    cal.getTime();
		}catch (Exception e) {
		  errors.add(d+ " is not a valid day for selected month");
		  cal.set(Calendar.DAY_OF_MONTH, 1);
		}
	}catch(Exception e){
		errors.add("Date must be a number between 1 and 30");
	}
	
	int y;
	try{
		y = Integer.parseInt(request.getParameter("year"));
		cal.set(Calendar.YEAR, y);
		try {
		    cal.getTime();
		}catch (Exception e) {
		  errors.add("Year is not valid");
		}
	}catch(Exception e){
		errors.add("Date must be a number between 2020 and 2030");
	}
	

	int trainID = Integer.parseInt(request.getParameter("trainID"));
    if(trainID == -1){
    	errors.add("Must select a train");
    }
    
    String TLOption = request.getParameter("TLOption"); 
	//int TLOption = Integer.parseInt(request.getParameter("TLOption"));
	if(TLOption.equals("NO_SELECTION")){
		errors.add("Must select a Train Line option");
	}

	if(errors.size() > 0){
		session.setAttribute("CS2", errors);
		response.sendRedirect("CreateSchedule.jsp");
	}
	
	
	
	
	// FINISHED INITIAL ERROR CHECKING 
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Class.forName("com.mysql.jdbc.Driver");
	    
  	
	if(!TLOption.equals("CREATE")){
		
		//USE EXISTING TRANSIT LINE
	    
	    Statement stTL = con.createStatement();
	    ResultSet rsTL = stTL.executeQuery("select * from TransitLine");
	    HashMap<String, Time> TransitLineDurations = new HashMap<String, Time>();
	    while(rsTL.next()){
	    	TransitLineDurations.put(rsTL.getString(1), rsTL.getTime(4));
	    }
		
		char direction = TLOption.charAt(0);
		boolean reverseLine = false;
		if(direction == 'R'){
			reverseLine = true;
		}
		
		String tln = TLOption.substring(1);
		LocalTime tlnDuration = TransitLineDurations.get(tln).toLocalTime();
		
		Timestamp t1 = new Timestamp(cal.getTimeInMillis()); // January 1st 2020 at 1 PM 
		Timestamp t2 = Timestamp.valueOf(t1.toLocalDateTime().plusHours(tlnDuration.getHour()).plusMinutes(tlnDuration.getMinute())); // Jan 1 2020 3:25
		
		LocalDateTime lt1 = t1.toLocalDateTime();
		LocalDateTime lt2 = t2.toLocalDateTime();
		
		Statement stS = con.createStatement();
	    ResultSet rsS = stS.executeQuery("select * from Schedule");
	   
	    		
	    ArrayList<Schedule> Schedules = new ArrayList<Schedule>();
		while(rsS.next()){
			Schedules.add(new Schedule(rsS.getString(1), rsS.getInt(2), rsS.getTimestamp(3), rsS.getInt(4)));
		}
		
		for(Schedule sc : Schedules){
			if(sc.trainID == trainID){
				LocalTime scDelta = TransitLineDurations.get(sc.transitLineName).toLocalTime();
				Timestamp s1 = sc.scheduleDepartureTime;
				Timestamp s2 = Timestamp.valueOf(s1.toLocalDateTime().plusHours(scDelta.getHour()).plusMinutes(scDelta.getMinute()));
				
				LocalDateTime ls1 = s1.toLocalDateTime();
				LocalDateTime ls2 = s2.toLocalDateTime();
				
				if((ls1.isAfter(lt1) && ls2.isBefore(lt1)) || (ls1.isAfter(lt2) && ls2.isBefore(lt2))){
					errors.add("Train "+trainID+" is used by a schedule departing "+ls1+" running "+sc.transitLineName);
					session.setAttribute("CS2", errors);
					response.sendRedirect("CreateSchedule.jsp");

				}
			}
		}
		
		String sql = "INSERT INTO Schedule VALUES(?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, tln);
		ps.setBoolean(2, reverseLine);
		ps.setTimestamp(3, t1);
		ps.setInt(4, trainID);
		ps.executeUpdate();
		
		out.println("Added schedule");
		return;
	}
	
	// CREATE NEW TRANSIT LINE
	
	session.setAttribute("CS2_trainID",trainID);
	session.setAttribute("CS2_SDTCAL",cal);
	session.setAttribute("CS2_STDSTR", (h+":"+m+" "+xm));
	/*
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("select * from station");
	
	ArrayList<Station> stations = new ArrayList<Station>();
	while(rs.next()){
		stations.add(new Station((int) rs.getFloat(1), rs.getString(2), null, null));
	}
	Collections.sort(stations,
	                 new Comparator<Station>() {
	                     public int compare(Station s1, Station s2)
	                     {
	                         return s1.toString().compareTo(s2.toString());
	                     }
	                 }
	);
	session.setAttribute("NTL1", stations);
	
	
	/*
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
    Class.forName("com.mysql.jdbc.Driver");
    
    Statement stTL = con.createStatement();
    ResultSet rsTL = stTL.executeQuery("select * from TransitLine");
    HashMap<String, Time> TransitLineDurations = new HashMap<String, Time>();
    while(rsTL.next()){
    	TransitLineDurations.put(rsTL.getString(1), rsTL.getTime(4));
    }
    
    Statement stS = con.createStatement();
    ResultSet rsS = stS.executeQuery("select * from Schedule");
   
    		
    ArrayList<Schedule> Schedules = new ArrayList<Schedule>();
	while(rsS.next()){
		Schedules.add(new Schedule(rsS.getString(1), rsS.getBoolean(2), rsS.getTimestamp(3), rsS.getInt(4)));
	}
	
	Timestamp timestamp = new Timestamp(cal.getTimeInMillis());
	for(Schedule sc : Schedules){
		if(sc.trainID == trainID){
			if(sc.scheduleStartTime.before(timestamp) 
			Timestamp tD = sc.scheduleStartTime;
			Timestamp tA ;
		}
	}
    */
    
    
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>