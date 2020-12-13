<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.time.*, java.time.format.DateTimeFormatter"%>


<%
String A = "33:07";
String D = request.getParameter("D"+i);
LocalTime At = LocalTime.parse(A, DateTimeFormatter.ofPattern("HH:mm"));
LocalTime AT = LocalTime.parse(D, DateTimeFormatter.ofPattern("HH:mm"));
/*
	int i;
	ArrayList<Station> interStations = (ArrayList<Station>) session.getAttribute("interStations");
	for(i=1; i < interStations.size(); i++){
		
		String A = request.getParameter("A"+i);
		String D = request.getParameter("D"+i);
		LocalTime At = LocalTime.parse(A, DateTimeFormatter.ofPattern("HH:mm"));
		LocalTime AT = LocalTime.parse(D, DateTimeFormatter.ofPattern("HH:mm"));
		int s = Integer.parseInt(v);
		Station newStation = stations.get(s);
		if(interStations.contains(newStation) || newStation.equals(orig_station) || newStation.equals(dest_station)){
			errors.add("Station "+newStation+" was added twice");
			session.setAttribute("NLT_ERRORS", errors);
			response.sendRedirect("NewTransitLineBetween.jsp");
		}
		interStations.add(newStation);
	}
*/

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