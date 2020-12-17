<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>

<%
	ArrayList<Reservation> res = TrainProject.Reservations.getAsList();
	ArrayList<Reservation> a = new ArrayList<Reservation>();
	String mon = request.getParameter("month");
	String year = request.getParameter("year");
	int yr = Integer.parseInt(year);
	int m = Integer.parseInt(mon);
	LocalDate d = LocalDate.of(yr,m,1);
	if(res.size() == 0){
		out.println("No reservations Found");
	}
	
	for(int i = 0; i<res.size();i++)
	{
		
		if(Formatting.sameMonth(d, res.get(i).dateOfCreation.toLocalDateTime()) == true){
			
			a.add(res.get(i));
		}else{
			
			response.sendRedirect("MonthlySalesReport.jsp");
			session.setAttribute("MonthlySaleOfMonth/Year", new Object());
			return;
		}
		
	}
	HashMap<String,Float> map=new HashMap<String,Float>();
	for(int i = 0; i<res.size();i++){
		if(map.get(res.get(i).username) == null){
			map.put(res.get(i).username, res.get(i).totalFare);
		}else{
			map.put(res.get(i).username, map.get(res.get(i).username)+res.get(i).totalFare);
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
	<h1>Result:</h1>
   <% out.println("The Total Sales for "+year + "/ "+ mon + " is "); %>
   
    <form action="MonthlySalesReport.jsp" method = "POST">
	<input type="submit" value="Cancel"/>
	</form>

</body>
</html>