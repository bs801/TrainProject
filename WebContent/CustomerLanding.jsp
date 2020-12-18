<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<% if(session.getAttribute("username") == null) {
	response.sendRedirect("LoginPages/CustomerLogin.jsp");
	return;
}
 %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1><font size ="8" color="black" face = "courier" >Home Page</font></h1>


	<p>Reserve New Tickets</p>
	<form action="MakeReservation.jsp" method = "POST">
	<input type="submit" value="Reserve a Trip"/>
	</form><br></br>
	
	<p>View Reservation History / Cancel Reservation</p>
	<form action="ViewMyReservations.jsp" method = "POST">
	<input type="submit" value="View My Reservations"/>
	</form><br></br>
	
	<p>Q&A Forum</p>
	<form action="forum.jsp" method = "POST">
	<input type="submit" value="Ask a Question!"/>
	</form> <br></br>
	<p>Log Out</p>
	<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log Out"/>
	</form>
	
	
	
	
</body>
</html>