<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.time.*, java.time.format.DateTimeFormatter"%>
    
<%
	ArrayList<Schedule> Schedules = TrainProject.Schedules.getAsList();
	for(Schedule s : Schedules){
		out.println(s);
	}
	
	Schedule ns = new Schedule("ASDF", 0, Timestamp.valueOf(LocalDateTime.now()), 333);
	TrainProject.Schedules.insert(ns);
	


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