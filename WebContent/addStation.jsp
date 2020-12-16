<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Station</title>
</head>
<body>
<h1>Add a Station Here</h1>
<%
ArrayList<Station> stations = TrainProject.Stations.getAsList();

int id = stations.get(stations.size()-1).stationID;
%>
The value is preset to the highest available value.
<br></br>
	<form action="" method="POST">
		StationID: <input type="text" name="stationID" value="<%=id+1%>" /> 
		<br></br> 
		Name: <input type="text" name="name" placeholder="Name"/> 
		<br></br> 
		City: <input type="text" name="city" placeholder="City"/> 
		<br></br>
		State: <input type="text" name="state" placeholder="State"/> 
		<br></br>
		<input type="Submit" value="Add" /> 
	</form>
</body>
</html>