<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
    
<%
	ArrayList<Reservation> reservations = TrainProject.Reservations.getAsList();
	ArrayList<String> newRes = new ArrayList<String>(); 

	for (Reservation r : reservations) { 
    	if (!newRes.contains(r.forward_transitLineName)) { 
        	newRes.add(r.forward_transitLineName); 
    	}
    	if(r.return_transitLineName != null){
	    	if (!newRes.contains(r.return_transitLineName)) { 
	        	newRes.add(r.return_transitLineName); 
	    	}
    	}
	} 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="adminReservationList2.jsp" method="POST">

	Sort by Transit Lines
	<select name="TransitLine">
		<option selected value="0">--None--</option>
		<%for(String r : newRes){
			
			%><option value=<%=r %>><%=r%></option>
			<%
			
		} %>
	</select>
	
	<br></br>
	
	Sort by Names
	<select name="Name">
		<option selected value="0">--None--</option>
		<%for(Reservation r : reservations){
			
			%><option value=<%=r.firstName + r.lastName %>><%=r.firstName+" "+r.lastName %></option><%
			
		} %>
	</select>
	<br></br>
	<input type="submit" value="Continue"/> 
</form>
</body>
</html>