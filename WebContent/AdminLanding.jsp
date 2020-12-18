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


<body>
	<p>Edit Information For Customer Representative</p>
	<form action="editCustomerRepresentative.jsp" method = "POST">
		<input type="submit" value="Edit Customer Representatives"/>
	</form> 
	<br></br>
	<p>Monthly Report</p>
	<form action="MonthlyReporting.jsp" method = "POST">
	<input type="submit" value="Monthly Sales Metrics"/>
	<br></br>
	This page can be used to (after selection of a month/year)<br></br>
	- Show the total revenue<br></br>
	- List the best customer<br></br>
	- List the top 5 most active transit lines<br></br>
	
	- Show the revenue obtained through a specific customer or transit line<br></br>
	- Show the reservations made by/for a specific customer or transit line<br></br>
	
	(All these metrics are per the month selected)<br></br>
	<br></br>
	</form>
	
	
	<p>Log Out</p>
	<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log Out"/>
	</form>
	
</body>
</html>