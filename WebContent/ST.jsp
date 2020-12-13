<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	Schedule s = TrainProject.Schedules.getAsList().get(0);

	Station A = TrainProject.Stations.get(16);
	Station B = TrainProject.Stations.get(14);
	
	LocalDate dt = LocalDate.parse("2020-06-06");
	
	ArrayList<ReservationBuilder> rblist = ReservationBuilderService.getReservationOptions(dt, "Trenton", "Princeton");
	for(ReservationBuilder rb : rblist){
		System.out.println(rb.reservationStops);
		System.out.println("we found a reservation");
	}
	
	
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