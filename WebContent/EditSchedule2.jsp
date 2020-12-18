<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
<!DOCTYPE html>
<%

if(session.getAttribute("ES2") != null){
	out.println((ArrayList<String>) session.getAttribute("ES2")+"<br></br>");
}

boolean am = true;
	int h = Integer.parseInt(request.getParameter("hour"));
	h = (h == 12 ? 0 : h);
	int min = Integer.parseInt(request.getParameter("minute"));
	String xm = request.getParameter("xm");
	System.out.println("MIN IS "+min);
	
	
	String date = request.getParameter("date");
	ArrayList<String> errors = new ArrayList<String>();
	LocalDate departureDate = null;
	try{
		departureDate = LocalDate.parse(date);
	}catch(Exception e){
		errors.add("Please enter valid date");
		response.sendRedirect("EditSchedule2.jsp");
		return;
	}
	
	
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

	//int m = Integer.parseInt(request.getParameter("month"))-1;
	int m = departureDate.getMonthValue()-1;
	if(m < 0){
		errors.add("Must select a month");
		m = 0;
	}
	
	cal.set(Calendar.MONTH, m);
	
	int d = departureDate.getDayOfMonth();
	try{
	//	d = Integer.parseInt(request.getParameter("day"));
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
	
	int y = departureDate.getYear();
	try{
		//y = Integer.parseInt(request.getParameter("year"));
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
    	response.sendRedirect("EditSchedule.jsp");
		return;
    }
    
    Schedule sce = (Schedule) session.getAttribute("editSc");
 
	LocalDateTime t1 = (new Timestamp(cal.getTimeInMillis())).toLocalDateTime(); // January 1st 2020 at 1 PM 
	LocalDateTime t2 = t1.plusHours(sce.getTransitLine().duration.toLocalTime().getHour()).plusMinutes(sce.getTransitLine().duration.toLocalTime().getMinute()); // Jan 1 2020 3:25
	
	
    ArrayList<Schedule> Schedules = TrainProject.Schedules.getAsList();
  
	
	for(Schedule sc : Schedules){
		if(sc == sce){
			System.out.println("FOUND THE MATCH");
			continue;
		}
		if(sc.trainID == trainID){
			
			
			LocalTime scDuration = sc.getTransitLine().duration.toLocalTime();
			LocalDateTime s1 = sc.scheduleDepartureTime.toLocalDateTime();
			LocalDateTime s2 = s1.plusHours(scDuration.getHour()).plusMinutes(scDuration.getMinute());
			
			
		//	System.out.println("ComparingA "+t1+" -> "+t2);
		//	System.out.println("ComparingB "+s1+" -> "+s2);
			
			if((t1.isAfter(s1) && t1.isBefore(s2)) || (t2.isAfter(s1) && t2.isBefore(s2))){
				errors.add("Train "+trainID+" is used by a schedule departing "+s1+" running "+sc.transitLineName);
				response.sendRedirect("EditSchedule.jsp");
				return;
			}
		}
		if(sc.transitLineName.equals(sce.transitLineName) && sc.reverseLine == sce.reverseLine && sc.scheduleDepartureTime.toLocalDateTime().isEqual(sce.scheduleDepartureTime.toLocalDateTime())){
			errors.add("Another schedule is using this departure time + transit line combination");
			response.sendRedirect("EditSchedule.jsp");
			return;
		}
	}
	
	Schedule ns = new Schedule(sce.transitLineName, sce.reverseLine, Timestamp.valueOf(t1), trainID);
	
	if(t1.isEqual(sce.scheduleDepartureTime.toLocalDateTime())){
		
		if(trainID == sce.trainID){
			errors.add("No changes were made");
			response.sendRedirect("EditSchedule.jsp");
			return;
		} else {
			TrainProject.Schedules.update(sce, ns);
			
			ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
			for(Reservation r : reservations){
				r.updateTrain(sce, ns);
			}
			System.out.println("TRIAN CHANGES MAIND");	
		}
		
	} else {
		System.out.println("UPDATE THAT DB BRUH");
		TrainProject.Schedules.update(sce, ns);
	}
	
	if(t1.isBefore(LocalDateTime.now())){
		errors.add("Schedule must have a departure date/time that is after the present time");
		response.sendRedirect("EditSchedule.jsp");
		return;
	}
	
	
	
	//Schedule newSchedule = new Schedule(TL.transitLineName, TL.reverseLine, new Timestamp(cal.getTimeInMillis()), trainID);
	//TrainProject.Schedules.insert(newSchedule);
	
//	System.out.println("Added schedule");
//	out.println("CREATED SCHEDULE "+ newSchedule.transitLineName+" at "+newSchedule.scheduleDepartureTime.toString()  );
//	tns = newSchedule;
    
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form action="ScheduleMain.jsp" method = "POST">
<input type="submit" value="Cancel"/>
</form>

</body>
</html>