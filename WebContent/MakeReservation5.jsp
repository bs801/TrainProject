<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>

<%
	Reservation newRes = (Reservation) session.getAttribute("mr4");
		
	TrainProject.loadApplicationDB();
	Connection con = TrainProject.con;
	
	String title = request.getParameter("Title");
	String fname = request.getParameter("firstName");
	String lname = request.getParameter("lastName");
	
	if(title.length() == 0){
		
	}
%>


<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>