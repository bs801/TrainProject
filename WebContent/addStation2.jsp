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
int stationID = Integer.parseInt(request.getParameter("stationID"));
String name = request.getParameter("name");
String city = request.getParameter("city");
String state = request.getParameter("state");

Station s = new Station(stationID, name, city, state);

TrainProject.Stations.insert(s);

%>
Station added.

</body>
</html>