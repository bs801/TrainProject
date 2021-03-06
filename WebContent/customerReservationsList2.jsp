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
	//String transitLine = request.getParameter("TransitLine");
	int v = Integer.parseInt(request.getParameter("TransitLine"));
	if(v == 0){
		response.sendRedirect("customerReservationsList.jsp");
		return;
	}
	String transitLine = ((ArrayList<String>) session.getAttribute("CRL")).get(v-1);
	
	String date = request.getParameter("date");
	LocalDate dc = LocalDate.parse(date);
	
	ArrayList<String> customers = new ArrayList<String>();
	
	ArrayList<Reservation> reservations = TrainProject.Reservations.getUncancelledList();
	System.out.println(reservations);
	ArrayList<Reservation> customerReservations = new ArrayList<Reservation>();
	
	Customer c = null;
	
	for(Reservation r : reservations){

		if(r.forward_transitLineName.equals(transitLine)){
			if(Formatting.sameDate(dc, r.forward_scheduleDepartureTime.toLocalDateTime())){
				System.out.println(dc+" matched "+r.forward_scheduleDepartureTime.toLocalDateTime());
				//customers.add(r.firstName + " " + r.lastName);
				customerReservations.add(r);
				c = TrainProject.Customers.get(r.username);
				customers.add(r.username + ", " + c.firstName + " " + c.lastName);
				continue;
			} else {
				System.out.println(dc+" no NOo matched "+r.forward_scheduleDepartureTime.toLocalDateTime());
			}
		}
		if(r.return_transitLineName != null){
			if(r.return_transitLineName.equals(transitLine)){
				if(Formatting.sameDate(dc, r.return_scheduleDepartureTime.toLocalDateTime())){
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
	<br></br>
<form action="RepresentativeLanding.jsp" method = "POST">
	<input type="submit" value="Back to Dashboard"/>
	</form> 
</body>
</html>