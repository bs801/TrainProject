<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<%
/*
	ArrayList<Train> trains = TrainProject.Trains.getAsList();

	for(Train t : trains){
		out.println("<br></br>"+t.toString()+"<br></br>");
	}
	*/
	
	ArrayList<TransitLine> tls = TrainProject.TransitLines.getAsList();
	
	for(TransitLine t : tls){
		
		out.println("<br></br>"+t+"<br></br>");
		
		ArrayList<TransitStop> stops = t.getTransitStops();
		
		for(TransitStop s : stops){
			
			out.println("<br></br>"+s);
		}
	}
	
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>