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
<body>
	<h1><font size ="8" color="black" face = "courier" >Home Page</font></h1>


	<p>Search For Train Schedule?</p>
	<form action="trainScheduleSearch.jsp" method = "POST">
	<input type="submit" value="Go"/>
	</form> 
	<p>Reserve New Tickets ?</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	<p>Cancel Reservation ?</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form> 
	<p>View Purchase History</p>
	<form action="" method = "POST">
	<input type="submit" value="Go"/>
	</form>
	<p>Q&A Forum</p>
	<form action="forum.jsp" method = "POST">
	<input type="submit" value="Ask a Question!"/>
	
	<input type="text" value=<%=TrainProject.Stations.getAsList().get(0).toString()%> />
	</form> 
	<p>Log Out</p>
	<form action="logout.jsp" method = "POST">
	<input type="submit" value="Log Out"/>
	</form>
	
	
	
	
</body>
</html>