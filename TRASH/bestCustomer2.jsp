<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>

<%
	ArrayList<Reservation> a = TrainProject.Reservations.getAsList();
	ArrayList<Reservation> b = new ArrayList<Reservation>();
	String mon = request.getParameter("month");
	String year = request.getParameter("year");
	int y = Integer.parseInt(year);
	int z = Integer.parseInt(mon);
	LocalDate x = LocalDate.of(y,z,1);
	if(a.size() == 0){
		out.println("0 reservation Found");
	}
	
	for(int i = 0; i<a.size();i++)
	{
		// out.println(a.get(i).dateOfCreation.toString());
		if(Formatting.sameMonth(x, a.get(i).dateOfCreation.toLocalDateTime()) == true){
			//out.println("1 reservation Found");
			b.add(a.get(i));
		}else{
			//out.println("0 reservation Found");
			response.sendRedirect("bestCustomer.jsp");
			session.setAttribute("bestCustomerOfMonth/Year", new Object());
			return;
		}
		
	}
	HashMap<String,Float> map=new HashMap<String,Float>();
	for(int i = 0; i<a.size();i++){
		if(map.get(a.get(i).username) == null){
			map.put(a.get(i).username, a.get(i).totalFare);
		}else{
			map.put(a.get(i).username, map.get(a.get(i).username)+a.get(i).totalFare);
		}
	}
	float max = 0;
	String name = "";
	for (Map.Entry<String, Float> entry : map.entrySet()) {
	    String key = entry.getKey();
	    Float value = entry.getValue();
	    if(value > max){
	    	max = value;
	    	name += key + "  ";
	    	
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
   <% out.println("The best customer of "+year + "/ "+ mon + " is " + name ); %>
   
   

</body>
</html>