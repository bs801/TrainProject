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
<h1>Customer Reservations Given a Transit Line and Date</h1>
<%

ArrayList<TransitLine> transitLines = TrainProject.TransitLines.getAsList();


%>
<form action="customerReservationsList2.jsp" method="POST">

	Transit Line
	<select name="TransitLine">
		<option selected value="0">--None--</option>
		<%for(TransitLine r : transitLines){
			
			%><option value=<%=r.transitLineName %>><%=r.transitLineName%></option>
			<%
			
		} %>
	</select>
	<br></br>
	Date<input type="date" name="date">
	<input type="submit" value="Continue"/> 
</form>
<br></br>

<form action="RepresentativeLanding.jsp" method = "POST">
<input type="submit" value="Back to DashBoard"/>
</form> 

</body>
</html>