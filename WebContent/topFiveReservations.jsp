<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
HashMap<String, Integer> topFive = new HashMap<String, Integer>();

for(Reservation r : reservations){
	int j = topFive.get(r.forward_transitLineName);
	
	topFive.put(r.forward_transitLineName, j+1);
	
}






%>
</body>
</html>