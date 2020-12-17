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

<form action="CustomerLanding.jsp" method="POST">
<input type="Submit" value="Back to Home"/>
</form><br></br>

<h1>Reservations in progress: </h1>
These are reservations which are currently en route (Cannot be cancelled).
<% 
if(now.size() == 0){
	out.println("No reservations are currently in progress<br></br>");
}
for(Reservation r : now){
	out.println(r.toString() + "<br></br>");
}
%>
<h1>Future reservations: </h1>

<form action="vjCancelReservation.jsp" method="POST" >
<%
if(future.size() == 0){
	out.println("You have no future reservations <br></br>");
}
for(Reservation r : future){
	out.println(r.toString());
	%> <input type="Submit" name=<%=r.reservationID%> value="Cancel" /><br></br> <% 
}
%>
</form>
<h1>Past reservations: </h1>
<%
if(past.size() == 0){
	out.println("You have no past reservations <br></br>");
}
for(Reservation r : past){
	out.println(r.toString() + "<br></br>");
}
%>
<h1>Cancelled reservations: </h1>
<%
if(now.size() == 0){
	out.println("You have not cancelled any reservations <br></br>");
}
for(Reservation r : cancelled){
	out.println(r.toString() + "<br></br>");
}
%>
</body>
</html>