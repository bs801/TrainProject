<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.time.*, java.time.format.DateTimeFormatter"%>


<%
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTLP");

	ArrayList<LocalTime> arrivalTimes = new ArrayList<LocalTime>();
	ArrayList<LocalTime> departureTimes = new ArrayList<LocalTime>();
	
	ArrayList<String> errors = new ArrayList<String>();
	for(int j=0; j<p.selectedStationList.size(); j++) {
		
		String A = request.getParameter("A"+j);
		int Ad = A.indexOf(':');
		int AH; int AM;
		try{
			if(Ad < 0){
				throw new Exception("is missing ':' delimeter to separate hour and minute");
			}
			try{
				AH = Integer.parseInt(A.substring(0,Ad));
				if(AH < 1 || AH > 12){
					throw new Exception();
				}
				AH = (AH == 12 ? 0 : AH);
			}catch(Exception e){
				throw new Exception(" has invalid hour");
			}
			try{
				AM = Integer.parseInt(A.substring(Ad+1));
				if(AM < 0 || AM > 59){
					throw new Exception();
				}
			}catch(Exception e){
				throw new Exception(" has invalid minute");
			}
		}catch(Exception e){
			errors.add("Arrival time for "+p.selectedStationList.get(j)+" "+e.getMessage());
			p.errors = errors;
			return;
		}
		
		String D = request.getParameter("D"+j);
		int Dd = D.indexOf(':');
		int DH; int DM;
		try{
			if(Dd < 0){
				throw new Exception("is missing ':' delimeter to separate hour and minute");
			}
			try{
				DH = Integer.parseInt(D.substring(0,Dd));
				if(DH < 1 || DH > 12){
					throw new Exception();
				}
				DH = (DH == 12 ? 0 : DH);
			}catch(Exception e){
				throw new Exception(" has invalid hour, must range from 0 to 12");
			}
			try{
				DM = Integer.parseInt(D.substring(Dd+1));
				if(DM < 0 || DM > 59){
					throw new Exception();
				}
			}catch(Exception e){
				throw new Exception(" has invalid minute, must range from 0 to 59");
			}
		}catch(Exception e){
			errors.add("Departure time for "+p.selectedStationList.get(j)+" "+e.getMessage());
			p.errors = errors;
			return;
		}
		
		LocalTime At = LocalTime.of(AH, AM);
		LocalTime Dt = LocalTime.of(DH, DM);
		
		arrivalTimes.add(At); 
		departureTimes.add(Dt);
	}
	
	
	String DA = request.getParameter("DA");
	int DAd = DA.indexOf(':');
	int DAH; int DAM;
	try{
		if(DAd < 0){
			throw new Exception("is missing ':' delimeter to separate hour and minute");
		}
		try{
			DAH = Integer.parseInt(DA.substring(0,DAd));
			if(DAH < 1 || DAH > 12){
				throw new Exception();
			}
			DAH = (DAH == 12 ? 0 : DAH);
		}catch(Exception e){
			throw new Exception(" has invalid hour");
		}
		try{
			DAM = Integer.parseInt(DA.substring(DAd+1));
			if(DAM < 0 || DAM > 59){
				throw new Exception();
			}
		}catch(Exception e){
			throw new Exception(" has invalid minute");
		}
	}catch(Exception e){
		errors.add("Arrival time for "+p.destination+" "+e.getMessage());
		p.errors = errors;
		return;
	}
	LocalTime DATime = LocalTime.of(DAH, DAM);
		
	ArrayList<LocalTime> arrivalTimesREL = new ArrayList<LocalTime>();
	ArrayList<LocalTime> departureTimesREL = new ArrayList<LocalTime>();
	for(int j=0; j<p.selectedStationList.size(); j++){
		arrivalTimesREL.add(p.getDelta(arrivalTimes.get(j)));
		departureTimesREL.add(p.getDelta(departureTimes.get(j)));
	}
	LocalTime DARel = p.getDelta(DATime);
	
	ArrayList<TransitStop> transitStops = new ArrayList<TransitStop>();
	
	
	 //TransitStop(String transitLineName, int reverseLine, int stopID, int stationID, Time arrivalTime, Time departureTime) 
	transitStops.add(new TransitStop(p.transitLineName, 0, 0, p.origin.stationID, Time.valueOf(LocalTime.of(0,0)), Time.valueOf(LocalTime.of(0,0))));
	for(int i=0; i<p.selectedStationList.size(); i++){
		TransitStop ti = new TransitStop(p.transitLineName, 0, i+1, p.selectedStationList.get(i).stationID, Time.valueOf(arrivalTimesREL.get(i)), Time.valueOf(departureTimesREL.get(i)));
		transitStops.add(ti);
	}
	transitStops.add(new TransitStop(p.transitLineName, 0, p.numberOfStops+1, p.destination.stationID, Time.valueOf(DARel), Time.valueOf(DARel)));
	
	LocalTime dur = transitStops.get(transitStops.size()-1).arrivalTime.toLocalTime();
	
	ArrayList<TransitStop> revStops = new ArrayList<TransitStop>();
	//revStops.add(new TransitStop(p.transitLineName, 1, 0, p.destination.stationID, Time.valueOf(LocalTime.of(0,0)), Time.valueOf(LocalTime.of(0,0))));
	
	
	System.out.println("REEEEE "+transitStops.size());
	for(int i=0; i<transitStops.size(); i++){
		System.out.println("A A A "+i);
		int forwardIndex = transitStops.size() - (i+1);
		
		TransitStop forwardStop = transitStops.get(forwardIndex);
		
		LocalTime FAT = forwardStop.arrivalTime.toLocalTime();
		LocalTime FDT = forwardStop.departureTime.toLocalTime();
		
		LocalTime RDT = dur.minusHours(FAT.getHour()).minusMinutes(FAT.getMinute());
		LocalTime RAT = dur.minusHours(FDT.getHour()).minusMinutes(FDT.getMinute());
		
		TransitStop rti = new TransitStop(p.transitLineName, 1, i, forwardStop.stationID, Time.valueOf(RAT), Time.valueOf(RDT));
		revStops.add(rti);
	}
	
	LocalTime ptrTime = transitStops.get(0).arrivalTime.toLocalTime();
	for(int i=1; i<transitStops.size()-1; i++){
		if(!transitStops.get(i).arrivalTime.toLocalTime().isAfter(ptrTime)){
			errors.add("Departure time for "+transitStops.get(i-1)+" must be before arrival time to "+transitStops.get(i));
		}
		if(!transitStops.get(i).departureTime.toLocalTime().isAfter(transitStops.get(i).arrivalTime.toLocalTime())){
			errors.add("Arrival time for "+transitStops.get(i)+" must be before departure time from "+transitStops.get(i-1));
		}
		ptrTime = transitStops.get(i).arrivalTime.toLocalTime();
	}
	if(!transitStops.get(transitStops.size()-1).arrivalTime.toLocalTime().isAfter(ptrTime)){
		errors.add("Departure time for "+transitStops.get(transitStops.size()-1)+" must be before arrival time to "+transitStops.get(transitStops.size()-2));
	}
	
	if(errors.size() > 0){
		System.out.println("RETURNING");
		p.errors = errors;
		response.sendRedirect("NewTransitLine3.jsp");
		return;
	}
	
	//Time 
	
//	LocalDateTime.now().get
	//p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime().toLocalTime();
//	Duration.
	

	
	
	//List<Student> students = ...
	//		Connection con = ...
	Connection con = TrainProject.con;
	
	String insertSqlTL = "INSERT INTO TransitLine VALUES (?, ?, ?, ?, ?)";
	PreparedStatement psT = con.prepareStatement(insertSqlTL);
	psT.setString(1, p.transitLineName);
	psT.setInt(2, 0);
	psT.setFloat(3, p.fare);
	psT.setInt(4, transitStops.size());
	psT.setTime(5, Time.valueOf(dur));
	psT.addBatch();
	
	psT.setString(1, p.transitLineName);
	psT.setInt(2, 1);
	psT.setFloat(3, p.fare);
	psT.setInt(4, transitStops.size());
	psT.setTime(5, Time.valueOf(dur));
	psT.addBatch();
	
	psT.executeBatch();
	
	String insertSql = "INSERT INTO TransitStop VALUES (?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(insertSql);
	for (TransitStop t : transitStops) {
	    pstmt.setString(1, t.transitLineName); //not sure if String or int or long
	    pstmt.setInt(2, t.reverseLine);
	    pstmt.setInt(3, t.stopID);
	    pstmt.setInt(4, t.stationID);
	    pstmt.setTime(5, t.arrivalTime);
	    pstmt.setTime(6, t.departureTime);
	    pstmt.addBatch();
	}
	for (TransitStop t : revStops) {
	    pstmt.setString(1, t.transitLineName); //not sure if String or int or long
	    pstmt.setInt(2, t.reverseLine);
	    pstmt.setInt(3, t.stopID);
	    pstmt.setInt(4, t.stationID);
	    pstmt.setTime(5, t.arrivalTime);
	    pstmt.setTime(6, t.departureTime);
	    pstmt.addBatch();
	}
	pstmt.executeBatch();
	System.out.println("AA");
	

	
	
	
	out.println("CREATION REPORT: <br></br>");
	
	
		LocalDateTime t1 = p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime(); // January 1st 2020 at 1 PM 
		LocalDateTime t2 = t1.plusHours(dur.getHour()).plusMinutes(dur.getMinute()); // Jan 1 2020 3:25
		
	    		
	    ArrayList<Schedule> Schedules = TrainProject.Schedules.getAsList();
		String trainTakenMessage = null;
		
		for(Schedule sc : Schedules){
			if(sc.trainID == p.incompleteSchedule.trainID){
				LocalTime scDuration = sc.getTransitLine().duration.toLocalTime();
				LocalDateTime s1 = sc.scheduleDepartureTime.toLocalDateTime();
				LocalDateTime s2 = s1.plusHours(scDuration.getHour()).plusMinutes(scDuration.getMinute());
				
				
				System.out.println("ComparingA "+t1+" -> "+t2);
				System.out.println("ComparingB "+s1+" -> "+s2);
				/* */
				if((t1.isAfter(s1) && t1.isBefore(s2)) || (t2.isAfter(s1) && t2.isBefore(s2))){
					
					System.out.println("FAIL");
					
					trainTakenMessage = /*errors.add(*/"Train "+p.incompleteSchedule.trainID+" is used by a schedule departing "+s1+" running "+sc.transitLineName/*)*/;
					//p.errors = errors;
					//response.sendRedirect("CreateSchedule.jsp");
					//return;
				} 
			}
		}
		if(trainTakenMessage != null){
			out.println("<h2>ERROR</h2>, COULD NOT CREATE SCHEDULE "+p.transitLineName+" at "+p.incompleteSchedule.scheduleDepartureTime.toString() + "<br></br> " );
			out.println("CREATED TRANSIT LINE  (forward) "+ p.transitLineName+": "+transitStops.get(0)+" -> "+transitStops.get(transitStops.size()-1)  );
			out.println("CREATED TRANSIT LINE  (reverse) "+ p.transitLineName+": "+revStops.get(0)+" -> "+revStops.get(revStops.size()-1) );
		
		} else {
			p.incompleteSchedule.transitLineName = p.transitLineName;
			TrainProject.Schedules.insert(p.incompleteSchedule);
			//p.incompleteSchedule = null;
			
			out.println("CREATED SCHEDULE "+ p.transitLineName+" at "+p.incompleteSchedule.scheduleDepartureTime.toString()  );
			out.println("CREATED (forward) "+ p.transitLineName+": "+transitStops.get(0)+" -> "+transitStops.get(transitStops.size()-1)  );
			out.println("CREATED (reverse) "+ p.transitLineName+": "+revStops.get(0)+" -> "+revStops.get(revStops.size()-1) );
		}
	
	
		
	
	//if(){
		
	//}
	

	
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<form action="CreateSchedule.jsp" method = "POST">
<input type="submit" value="Exit"/>
</form>
</body>
</html>


<%
out.println( "<br></br> " ); out.println( "<br></br> " ); 

out.println("REPORT DETAILS: <br></br>");


if(trainTakenMessage != null){
	out.println("COULD NOT CREATE SCHEDULE "+p.transitLineName+" at "+p.incompleteSchedule.scheduleDepartureTime.toString() + "<br></br> " );
	out.println(trainTakenMessage);
} else {
	out.println("NEW SCHEDULE "+ p.transitLineName+" at "+p.incompleteSchedule.scheduleDepartureTime.toString() + "<br></br> " );
	for(int i=0; i<transitStops.size(); i++){
		LocalTime AT = transitStops.get(i).arrivalTime.toLocalTime();
		LocalDateTime ADT = p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime().plusHours(AT.getHour()).plusMinutes(AT.getMinute());
		String arrString = ( i==0 ? "ORIGIN" : ADT.toString());
		
		LocalTime DT = transitStops.get(i).departureTime.toLocalTime();
		LocalDateTime DDT = p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime().plusHours(DT.getHour()).plusMinutes(DT.getMinute());
		String desString = (  i==transitStops.size()-1 ? "DESTINATION" : DDT.toString());
		
		out.println( "Stop "+i+": " +transitStops.get(i).toString() +": "+ arrString + " - " + desString + "<br></br> " );	
	}
}
out.println( "<br></br> " ); out.println( "<br></br> " ); 

System.out.println("A");
out.println("NEW TRANSIT LINE (FORWARD) "+ p.transitLineName+": "+transitStops.get(0)+" -> "+transitStops.get(transitStops.size()-1) + "<br></br> " );
for(int i=0; i<transitStops.size(); i++){
	out.println( "Stop "+i+": " +transitStops.get(i).toString() +": "+ transitStops.get(i).arrivalTime + " - " + transitStops.get(i).departureTime + "<br></br> " );	
}
out.println( "<br></br> " ); out.println( "<br></br> " ); 


out.println("NEW TRANSIT LINE (REVERSE) "+ p.transitLineName+": "+revStops.get(0)+" -> "+revStops.get(revStops.size()-1) + "<br></br> " );
for(int i=0; i<revStops.size(); i++){
	out.println("Stop "+i+": " +revStops.get(i).toString() +": "+ revStops.get(i).arrivalTime + " - " + revStops.get(i).departureTime + "<br></br> " );	
}

%>