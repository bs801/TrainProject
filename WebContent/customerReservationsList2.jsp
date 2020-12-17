<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String transitLine = request.getParameter("TransitLine");
	String date = request.getParameter("date");
	
	ArrayList<String> customers = new ArrayList<String>();
	
	ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
	ArrayList<Reservation> customerReservations = new ArrayList<Reservation>();
	
	Customer c = null;
	
	for(Reservation r : reservations){
		if(r.forward_transitLineName.equals(transitLine)){
			if(r.forward_scheduleDepartureTime.toString().contains(date)){
				//customers.add(r.firstName + " " + r.lastName);
				customerReservations.add(r);
				c = TrainProject.Customers.get(r.username);
				customers.add(r.username + ", " + c.firstName + " " + c.lastName);
				
			}
		}
		if(r.return_transitLineName != null){
			if(r.return_transitLineName.equals(transitLine)){
				if(r.return_scheduleDepartureTime.toString().contains(date)){
					customerReservations.add(r);
					c = TrainProject.Customers.get(r.username);
					customers.add(r.username + ", " + c.firstName + " " + c.lastName);
				}
			}
		}
	}
	%><h1>List of Customers on Line <%=transitLine%> on <%=date%></h1> <%
	
	for(String s : customers){
		out.println(s + "<br></br>");
	}
	
	out.println("<br></br>");
	out.println("<br></br>");
	out.println("---------------------");
	
	%><h1>Reservations: </h1> <%
	
	for(String s: customers){
		%><h2><%=s%>:</h2><%
		for(Reservation r : customerReservations){
			if(s.contains(r.username)){
				%><blockquote><%=r.toString()%></blockquote><%
			}
		}
	}
	
%>

<form action="customerReservationsList.jsp" method = "POST">
	<input type="submit" value="Back"/>
	</form> 
</body>
</html>