<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
		ArrayList<Station> stations = TrainProject.Stations.getAsList();

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Schedules For A Given Station</title>
</head>
<body>
<h1><font size ="7" color="black" face = "courier">All Schedules For A Station</font></h1>
<form action="trainScheduleForAStation2.jsp" method="POST">
	Station
	<select name="objectA">
		<% for(int i=0; i<stations.size(); i++){ %>
			<option value=<%=i%>><%=stations.get(i)%></option>
		<% } %>
	</select>
	<input type="radio" name="rt" value="0"/>Origin
	<input type="radio" name="rt" value="1"/>Destination
	<br></br>
	
	<input type="submit" value="Continue"/>
	
	
</form>


</body>
</html>