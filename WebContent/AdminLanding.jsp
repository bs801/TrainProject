<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<h1><font size ="7" color="black" face = "courier">ADMIN DASHBOARD</font></h1>

<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log out"/>
</form> <br></br>

<body>


	
	<form action="editCustomerRepresentative.jsp" method = "POST">
		<input type="submit" value="Edit Customer Representatives"/>
	</form> 

	<p>Sale Report</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Produce A List Of Reservation</p>
	<form action="adminReservationsList.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Produce A List Of Revenue</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Best Customer</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Best 5 most active Transit Line</p>
	<form action="topFiveReservations.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Log Out</p>
	<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log Out"/>
	</form>
	
</body>
</html>