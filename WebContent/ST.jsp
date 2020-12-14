<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%

System.out.println(MakeReservationPipline.getFare(0f));
	System.out.println(MakeReservationPipline.getFare(3f));
	System.out.println(MakeReservationPipline.getFare(100f));
	System.out.println(MakeReservationPipline.getFare(100.001f));
	System.out.println(MakeReservationPipline.getFare(100.775f));
	System.out.println(MakeReservationPipline.getFare(1005.7f));
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