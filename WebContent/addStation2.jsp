<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
<%
int v = -1;
String state = null;
String name = null;
String city = null;
ArrayList<String> errors = new ArrayList<String>();
try{
	v = Integer.parseInt(request.getParameter("stationID"));
	if(v < 0){
		throw new Exception();
	}
	state = request.getParameter("state");
	city = request.getParameter("city");
	name = request.getParameter("name");
	if(state.length() != 2){
		errors.add("Please enter in a state abbreviation with 2 characters");
	}
	if(city.length() == 0 || city.length() > 20){
		errors.add("Please enter in a city with a name from 1 to 20 characters");
	}
	if(name.length() == 0 || name.length() > 35){
		errors.add("Please enter in a station name with 1 to 35 characters");
	}
	if(errors.size() > 0){
		session.setAttribute("AS2",errors);
		response.sendRedirect("AddStation.jsp");
		return;
	}
}catch(Exception e){
	errors.add("Please enter in a station ID that is an integer greater than 0");
	session.setAttribute("AS2",errors);
	response.sendRedirect("AddStation.jsp");
	return;
}
ArrayList<Station> stations = TrainProject.Stations.getAsList();


	for(Station s : stations){
		if(s.stationID == v){
			errors.add("Station ID "+v+" is already taken");
			session.setAttribute("AS2",errors);
			response.sendRedirect("AddStation.jsp");
			return;
		}
	}

	Station s = new Station(v, name, city, state);
	TrainProject.Stations.insert(s);
	
	out.println("Station "+v+" was successfully created <br></br>");
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<br></br>
<form action="AddStation.jsp" method="POST">
<input type="Submit" value="Add a new station"/>
</form>
<br></br>
<form action="RepresentativeLanding.jsp" method="POST">
<input type="Submit" value="Back to representative dashboard"/>
</form>

</body>
</html>