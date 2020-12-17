<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top 5 Reservations</title>
</head>
<body>
	<h1>Insert Date to Sort Reservations By: </h1>
	<form action="topFiveReservations2.jsp" method="POST">
		<input type="date" name="date">
		<input type="submit" value="Sort"/>
	</form>
	<br></br>
	<form action="AdminLanding.jsp" method = "POST">
	<input type="submit" value="Back to Dashboard"/>
	</form> 
</body>
</html>