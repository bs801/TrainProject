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
if(session.getAttribute("AS2") != null){
	out.println((ArrayList<String>) session.getAttribute("AS2")+"<br></br>");
}

ArrayList<Station> stations = TrainProject.Stations.getAsList();



int i = 0;
while(true){
	boolean taken = false;
	for(Station s : stations){
		if(s.stationID == i){
			taken = true;
		}
	}
	if(taken){
		i++;
		continue;
	}
	break;
	
	
}
%>
The station ID is pre-filled to the lowest available station ID
<br></br>
	<form action="AddStation2.jsp" method="POST">
		Station ID: <input type="text" name="stationID" value="<%=i%>" /> 
		<br></br> 
		Name: <input type="text" name="name" placeholder="Name"/> 
		<br></br> 
		City: <input type="text" name="city" placeholder="City"/> 
		<br></br>
		State Abbreviation: <input type="text" name="state" placeholder="i.e. NJ"/> 
		<br></br>
		<input type="Submit" value="Add" /> 
	</form>
		<br></br>
		<br></br>
			<form action="RepresentativeLanding.jsp" method="POST">

			<input type="Submit" value="Cancel" /> 
		</form>
			<br></br>
				<br></br>
	<h3>List of Stations Already Added:</h3>
	<br></br>
	<%
	
	Collections.sort(stations,Station.sortByStationID);
	
	for(Station s : stations){
		out.println("StationID: " + s.stationID + ", ");
		out.println("Name: " + s.name + ", ");
		out.println("City: " + s.city + ", ");
		out.println("State: " + s.state + "<br></br>");
	}
	
	
	%>
</body>
</html>