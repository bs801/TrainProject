<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	ReservationBuilder rbf = (ReservationBuilder) session.getAttribute("selectedBuilder");
	if(rbf.returnBuilder != null){
		out.println(((ArrayList<String>) session.getAttribute("mr5errors")));
	} else {
		if(((String) session.getAttribute("rt")).equals("1")){
			int i=0;
			for(i=0; i<rbf.candidateReturnBuilders.size(); i++){
				if(request.getParameter(""+i+"") != null){
					break;
				}
			}
			rbf.returnBuilder = rbf.candidateReturnBuilders.get(i);
		}
	}
		
	float disc = Float.parseFloat((String) session.getAttribute("disc"));
	float total = rbf.fare;
	if(rbf.returnBuilder != null){
		total = total + (rbf.returnBuilder.fare * (1-disc));
	}
	System.out.println("PRE RES");
	Reservation newRes = new Reservation(
			-1,
			0,
			rbf.schedule.transitLineName,
			rbf.schedule.reverseLine,
			rbf.schedule.scheduleDepartureTime,
			rbf.schedule.trainID,
			rbf.fare * (1-disc),

			(rbf.returnBuilder != null ? 1 : 0),
			
			(rbf.returnBuilder != null ? rbf.returnBuilder.schedule.transitLineName : null),
			(rbf.returnBuilder != null ? rbf.returnBuilder.schedule.reverseLine : -1),
			(rbf.returnBuilder != null ? rbf.returnBuilder.schedule.scheduleDepartureTime : null),
			(rbf.returnBuilder != null ? rbf.returnBuilder.schedule.trainID : -1),
			(rbf.returnBuilder != null ? rbf.returnBuilder.fare : -1),
			
			rbf.getOrigin().getStation().stationID,
			rbf.getDestination().getStation().stationID,
			
			Timestamp.valueOf(LocalDateTime.now()),
			disc,
			total,
			
			null, null, null
		);
	session.setAttribute("mr4",newRes);
	System.out.println("AFTER RES");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

%>
<br></br>
	<h4><%=rbf.getOrigin().toString()+" at "+Formatting.displayTime(rbf.getOrigin().departureTime)
	+" --> "+rbf.getDestination().toString()+" at "+Formatting.displayTime(rbf.getDestination().arrivalTime)%></h4>
	TransitLine: <%=rbf.schedule.transitLineName%> <br></br>
	Train: <%=TrainProject.Trains.get(rbf.schedule.trainID)%> <br></br> 
	Route: <%
 	for(int i=0; i<rbf.reservationStops.size()-1; i++){
 %> <%=rbf.reservationStops.get(i).getStation()+" - "%> <%
 	}
 %> <%=rbf.reservationStops.get(rbf.reservationStops.size()-1).getStation()%>
	<br></br>Fare: <%=Formatting.getFare(rbf.fare * (1-disc))%>
	
	<br></br><%
			if(rbf.returnBuilder != null){
		%>
		<h4><%=rbf.returnBuilder.getOrigin().toString()+" at "+Formatting.displayTime(rbf.returnBuilder.getOrigin().departureTime)
		+" --> "+rbf.returnBuilder.getDestination().toString()+" at "+Formatting.displayTime(rbf.returnBuilder.getDestination().arrivalTime)%></h4>
		TransitLine: <%=rbf.returnBuilder.schedule.transitLineName%> <br></br>
		Train: <%=TrainProject.Trains.get(rbf.returnBuilder.schedule.trainID)%> <br></br> 
		Route: <%
 	for(int i=0; i<rbf.returnBuilder.reservationStops.size()-1; i++){
 %> <%=rbf.returnBuilder.reservationStops.get(i).getStation()+" - "%> <%
 	}
 %> <%=rbf.returnBuilder.reservationStops.get(rbf.returnBuilder.reservationStops.size()-1).getStation()%>
		<br></br>Fare: <%=Formatting.getFare(rbf.returnBuilder.fare * (1-disc))%>
		
	<%}%>

	<br></br>
	
	<br></br>
	Total Fare: <%=total%> 

<form action="MakeReservation5.jsp" method="POST">
Enter in the passenger's name:
	<input type="text" name="Title" placeholder="Mr."/>
	<input type="text" name="firstName" placeholder="John"/>
	<input type="text" name="lastName" placeholder="Smith"/>
	<br></br>
	
Confirm this reservation:
<input type="Submit" value="Confirm Reservation"/>
</form>
<br></br>
<form action="" method="POST">
<input type="Submit" value="Cancel"/>
</form>
</body>
</html>