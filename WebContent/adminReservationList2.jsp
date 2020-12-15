<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sorting Reservations</title>
</head>
<body>
<h1>Sorting Reservations</h1>
<%

String transitLine = request.getParameter("TransitLine");
String name = request.getParameter("Name");
ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
String dbName = "";


if(!transitLine.equals("0")){
	%><h2>Sorting by Transit Line: <%=transitLine %></h2> <%
	for(Reservation r : reservations){
		if(r.forward_transitLineName.equals(transitLine)){
			out.println(r.toString() + "<br></br>");
		}
	}
	
}

if(!name.equals("0")){
	%><h2>Sorting by Name: <%=name %></h2> <%
	for(Reservation r : reservations){
		dbName = r.firstName + r.lastName;
		if(dbName.equals(name)){
			out.println(r.toString() + "<br></br>");
		}
	}
}

%>
</body>
</html>