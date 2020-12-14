<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDate"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>

<%
	Reservation newRes = (Reservation) session.getAttribute("mr4");
		
	String title = request.getParameter("Title");
	String fname = request.getParameter("firstName");
	String lname = request.getParameter("lastName");
	
	ArrayList<String> errors = new ArrayList<String>();
	session.setAttribute("mr5errors", errors);
	if(title.length() > 10){
		errors.add("Title must be 10 characters or less");
	}
	if(fname.length() == 0 || fname.length() > 20){
		errors.add("First name must be between 0 and 20 charcters");
	}
	if(lname.length() == 0 || lname.length() > 20){
		errors.add("Last name must be between 0 and 20 charcters");
	}
	if(errors.size() > 0){
		response.sendRedirect("MakeReservation4.jsp");
		return;
	}
	newRes.firstName = fname;
	newRes.lastName = lname;
	newRes.title = title;
	
	TrainProject.Reservations.insert(newRes);
	
	
%>


<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>