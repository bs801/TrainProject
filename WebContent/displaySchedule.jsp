<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
System.out.println("UP FRONT");
	CSNTLPipeline p = (CSNTLPipeline) session.getAttribute("CSNTLP");
	if(p == null){
		p = new CSNTLPipeline();
		session.setAttribute("CSNTLP", p);
	}
	out.println(p.getErrors());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Schedule Search</title>
</head>
<body>
<h1>Schedule Search</h1>
<form action="displaySchedule2.jsp" method="POST">
	<%
	
	String temp;
	/*
		First get an arraylist of all of the transitlines/corridors(will do this later, first get it working for one specific corridor)
		Then get an arraylist of origin stations for that transitline and 
			an arraylist of destination stations for that transitline
		Then get the stops between the two stations
	
	
	*/
	
    //ArrayList<TransitLine> transitLines = TrainProject.TransitLines.getAsList();
	ArrayList<TransitStop> origins = TrainProject.TransitLines.get("ASDF", 0).getTransitStops();
	ArrayList<TransitStop> destinations = TrainProject.TransitLines.get("ASDF", 0).getTransitStops();
	String test = TrainProject.TransitStops.get("ASDF", 0, 0).toString();
	/*for(TransitStop s : origins){
		out.println(s.toString());
	}*/
	/*out.println(test);
	for(TransitStop s : destinations){
		if(s.toString() == test){
			out.println("TRUE");
		}
		else{
			out.println("False");
		}
	}*/
	%>
	
	Origin
	<select name="origin">
		<% for(TransitStop s : origins){ 
			temp = s.toString();
		%>
			<option value=<%=""+temp.replaceAll("\\s", "")+""%>><%=s%></option>
		<% } %>
	</select>
	<br></br>
	Destination
	<select name="destination">
		<% for(TransitStop s : destinations){ 
			temp = s.toString();
		%>
			<option value=<%=""+temp.replaceAll("\\s", "")+""%>><%=s%></option>
		<% } %>
	</select>
	<br></br>
	Date
	<input type="date" name="date">
	<br></br>
	<input type="submit" value="Continue"/> 
</form>
</body>
</html>