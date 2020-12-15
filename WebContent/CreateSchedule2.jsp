<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.time.LocalTime, java.time.LocalDateTime"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	boolean am = true;
	int h = Integer.parseInt(request.getParameter("hour"));
	h = (h == 12 ? 0 : h);
	int min = Integer.parseInt(request.getParameter("minute"));
	String xm = request.getParameter("xm");
	System.out.println("MIN IS "+min);
	LocalTime XMTime = LocalTime.of(h, min);
	if(xm.equals("pm")){
		am = false;
		h += 12;
	}
	Calendar cal = Calendar.getInstance();
	cal.setLenient(false);
	cal.set(Calendar.YEAR, 2000);
	cal.set(Calendar.DAY_OF_MONTH, 1);
	cal.set(Calendar.HOUR_OF_DAY, h);
	cal.set(Calendar.MINUTE, min);
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);

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
	if(TLOption.equals("NO_SELECTION")){
		errors.add("Must select a Train Line option");
	}

	
	
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTLP");
	
	System.out.println("ERRORS ARE "+errors.size());
	if(errors.size() > 0){
		p.errors = errors;
		response.sendRedirect("CreateSchedule.jsp");
		return;
	}
	
	    
  	Schedule tns = null;
  	TransitLine TL = null;
	if(!TLOption.equals("CREATE")){
		
		//USE EXISTING TRANSIT LINE
	    
		int selectedIndex = Integer.parseInt(TLOption);
		TL = TrainProject.TransitLines.getAsList().get( selectedIndex ); 
		
		LocalTime duration = TL.duration.toLocalTime();
	
		LocalDateTime t1 = (new Timestamp(cal.getTimeInMillis())).toLocalDateTime(); // January 1st 2020 at 1 PM 
		
		if(t1.isBefore(LocalDateTime.now())){
			errors.add("Schedule must have a departure date/time that is after the present time");
		}
		
		LocalDateTime t2 = t1.plusHours(duration.getHour()).plusMinutes(duration.getMinute()); // Jan 1 2020 3:25
		
	    		
	    ArrayList<Schedule> Schedules = TrainProject.Schedules.getAsList();
	
		
		for(Schedule sc : Schedules){
			if(sc.trainID == trainID){
				LocalTime scDuration = sc.getTransitLine().duration.toLocalTime();
				LocalDateTime s1 = sc.scheduleDepartureTime.toLocalDateTime();
				LocalDateTime s2 = s1.plusHours(scDuration.getHour()).plusMinutes(scDuration.getMinute());
				
				
			//	System.out.println("ComparingA "+t1+" -> "+t2);
			//	System.out.println("ComparingB "+s1+" -> "+s2);
				
				if((t1.isAfter(s1) && t1.isBefore(s2)) || (t2.isAfter(s1) && t2.isBefore(s2))){
					errors.add("Train "+trainID+" is used by a schedule departing "+s1+" running "+sc.transitLineName);
					p.errors = errors;
					response.sendRedirect("CreateSchedule.jsp");
					return;
				}
			}
		}
		Schedule newSchedule = new Schedule(TL.transitLineName, TL.reverseLine, new Timestamp(cal.getTimeInMillis()), trainID);
		TrainProject.Schedules.insert(newSchedule);
		
		System.out.println("Added schedule");
		out.println("CREATED SCHEDULE "+ newSchedule.transitLineName+" at "+newSchedule.scheduleDepartureTime.toString()  );
		tns = newSchedule;
	} else {
	
	// CREATE NEW TRANSIT LINE
		
		p.xmIsAM = am;
		p.XMTime = XMTime;
		p.incompleteSchedule = new Schedule(null, 0, new Timestamp(cal.getTimeInMillis()), trainID);

		if(p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime().isBefore(LocalDateTime.now())){
			errors.add("Schedule have a departure date/time that is after the present time");
		}
		int hh = h;
		if(hh > 12){
			hh = hh-12;
		}
		p.originDepartureTime =  (hh+":"+(min < 10 ? "0" : "")+min+" "+xm);
		response.sendRedirect("NewTransitLine.jsp");
		return;
	}
	
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form>
<input type = "Submit" value="Exit">
</form>
</body>
</html>


<%
out.println("NEW SCHEDULE "+ tns.transitLineName+" at "+tns.scheduleDepartureTime.toString() + "<br></br> " );
for(int i=0; i<TL.getTransitStops().size(); i++){
	LocalTime AT = TL.getTransitStops().get(i).arrivalTime.toLocalTime();
	LocalDateTime ADT = tns.scheduleDepartureTime.toLocalDateTime().plusHours(AT.getHour()).plusMinutes(AT.getMinute());
	String arrString = ( i==0 ? "ORIGIN" : ADT.toString());
	
	LocalTime DT =  TL.getTransitStops().get(i).departureTime.toLocalTime();
	LocalDateTime DDT = tns.scheduleDepartureTime.toLocalDateTime().plusHours(DT.getHour()).plusMinutes(DT.getMinute());
	String desString = ( i==TL.getTransitStops().size()-1 ? "DESTINATION" : ADT.toString());
	
	out.println( "Stop "+i+": " + TL.getTransitStops().get(i).toString() +": "+ arrString + " - " + desString + "<br></br> " );	
}
%>