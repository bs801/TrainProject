<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>

<%
	session.setAttribute("username", "vatche");	
	Representative r = TrainProject.Representatives.get((String) session.getAttribute("username"));
	out.println("Welcome "+r.firstName+" "+r.lastName+". You are logged in as "+r.username);
%>

<body>
	<h1><font size ="8" color="black" face = "courier" >Home Page(Customer Rep)</font></h1>


	<p>Search For Train Schedule?</p>
	<form action="trainScheduleSearch.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form> 
	
	<p>Reserve New Tickets ?</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Edit or Cancel Reservation ?</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form> 
	
	<p>View Purchase History</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Edit Train Schedule</p>
	<form action="EditSchedule.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Produce A List Of Train Schedules For A Given Station</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	
	<p>Produce A List Of All Customers Who Have Reservations On A Given Transit Line
 	And Date</p>
	<form action="customerReservationsList.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	<p>Q&A Forum</p>
	<form action="repforum.jsp" method = "POST">
	<input type="submit" value="Answer Customers' Questions !"/>
	</form> 
	<p>Log Out</p>
	<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log Out"/>
	</form> 

</body>
</html>