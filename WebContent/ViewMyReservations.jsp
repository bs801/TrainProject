<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
<%
	String username = "user1"; //(String) session.getAttribute("username");
	
	ArrayList<Reservation> Res = TrainProject.Reservations.getAsList();
	
	System.out.println(Res.get(0).forward_transitLineName);
	
	
	ArrayList<Reservation> now = new ArrayList<Reservation>();
	ArrayList<Reservation> past = new ArrayList<Reservation>();
	ArrayList<Reservation> future = new ArrayList<Reservation>();
	ArrayList<Reservation> cancelled = new ArrayList<Reservation>();
	
	for(Reservation r : Res){
		if(r.username.equalsIgnoreCase(username)){
			if(r.cancelled == 1){
				cancelled.add(r);
				continue;
			}
			if(r.timeOfForwardDeparture().isAfter(LocalDateTime.now())){
				future.add(r);
				continue;
			}
			if(r.roundTrip == 0){
				if(r.timeOfForwardArrival().isAfter(LocalDateTime.now())){
					now.add(r);
					continue;
				} 
			} else {
				if(r.timeOfReturnArrival().isAfter(LocalDateTime.now())){
					now.add(r);
					continue;
				} 
			}
			past.add(r);
		}
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<h2>Reservations in progress: </h2>
These are reservations which are currently en route (Cannot be cancelled).
<% 
for(Reservation r : now){
	out.println(r.toString() + "<br></br>");
}
%>
<h2>Future reservations: </h2>
These are reservations which are currently en route (Cannot be cancelled).
<form action="vjCancelReservation.jsp" method="POST" >
<%
for(Reservation r : future){
	out.println(r.toString() + "<br></br>");
	%> <input type="Submit" name=<%=r.reservationID%> value="Cancel" /> <% 
}
%>
</form>
<h2>Past reservations: </h2>
<%
for(Reservation r : past){
	out.println(r.toString() + "<br></br>");
}
%>
<h2>Cancelled reservations: </h2>
<%
for(Reservation r : cancelled){
	out.println(r.toString() + "<br></br>");
}
%>
</body>
</html>