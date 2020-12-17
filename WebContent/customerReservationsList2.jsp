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
	
	
	for(Reservation r : reservations){
		if(r.forward_transitLineName.equals(transitLine)){
			if(r.forward_scheduleDepartureTime.toString().contains(date)){
				customers.add(r.firstName + " " + r.lastName);
			}
		}
		if(r.return_transitLineName != null){
			if(r.return_transitLineName.equals(transitLine)){
				if(r.return_scheduleDepartureTime.toString().contains(date)){
					customers.add(r.firstName + " " + r.lastName);
				}
			}
		}
	}
	%><h1>List of Customers on Line <%=transitLine%> on <%=date%></h1> <%
	
	for(String s : customers){
		out.println(s + "<br></br>");
	}
	
%>

<form action="customerReservationsList.jsp" method = "POST">
	<input type="submit" value="Back"/>
	</form> 
</body>
</html>