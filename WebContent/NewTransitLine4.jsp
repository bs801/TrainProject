<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.time.*, java.time.format.DateTimeFormatter"%>


<%
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTP");

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
		TransitStop ti = new TransitStop(p.transitLineName, 0, i, p.selectedStationList.get(i).stationID, Time.valueOf(arrivalTimesREL.get(i)), Time.valueOf(departureTimesREL.get(i)));
	}
	transitStops.add(new TransitStop(p.transitLineName, 0, p.numberOfStops+1, p.origin.stationID, Time.valueOf(DARel), Time.valueOf(DARel)));
	
	
//	LocalDateTime.now().get
	p.incompleteSchedule.scheduleDepartureTime.toLocalDateTime().toLocalTime();
//	Duration.
	
	
	
String A = "33:07";
String D = request.getParameter("D"+i);
LocalTime At = LocalTime.parse(A, DateTimeFormatter.ofPattern("HH:mm"));
LocalTime AT = LocalTime.parse(D, DateTimeFormatter.ofPattern("HH:mm"));
/*
	int i;
	ArrayList<Station> interStations = (ArrayList<Station>) session.getAttribute("interStations");
	for(i=1; i < interStations.size(); i++){
		
		String A = request.getParameter("A"+i);
		String D = request.getParameter("D"+i);
		LocalTime At = LocalTime.parse(A, DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime AT = LocalTime.parse(D, DateTimeFormatter.ofPattern("HH:mm"));
		int s = Integer.parseInt(v);
		Station newStation = stations.get(s);
		if(interStations.contains(newStation) || newStation.equals(orig_station) || newStation.equals(dest_station)){
			errors.add("Station "+newStation+" was added twice");
			session.setAttribute("NLT_ERRORS", errors);
			response.sendRedirect("NewTransitLineBetween.jsp");
		}
		interStations.add(newStation);
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