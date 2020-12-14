<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.time.*, java.time.format.DateTimeFormatter"%>
    
<%

	
	ArrayList<TransitStop> ts = TrainProject.TransitLines.get("ASDF",0).getTransitStops();
	
	out.println(ts);


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