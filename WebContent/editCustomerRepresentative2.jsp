<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		int i=-1;
    	if(session.getAttribute("EC3") != null){
    		session.setAttribute("EC3", null);
    		i = (Integer) session.getAttribute("EC2i");
    		out.println((String) session.getAttribute("EC3"));
    	} else {
    		i = Integer.parseInt(request.getParameter("command"));
    	}
    	session.setAttribute("EC2i", i);
		System.out.println(i);
		ArrayList<Representative> representatives = TrainProject.Representatives.getAsList();
    	
		if(request.getParameter("D") != null){
			String u = representatives.get(i).username;
			TrainProject.Representatives.delete(representatives.get(i));
			session.setAttribute("EU", "Representative with username was deleted <br></br>");
			response.sendRedirect("editCustomerRepresentative.jsp");
			return;
		}
		else if(request.getParameter("E") != null){
			%>
			
			<form action="EditCustomerRepresentative3.jsp" method="POST">
				<%	out.println("Username: "+representatives.get(i).username); %>
				<br></br>
				<%	out.println("Password: "+representatives.get(i).password); %>
				<br></br>
				<%	out.println("SSN: "+representatives.get(i).SSN); %>
				<br></br>
	
				First Name: <input type="text" name="firstname" value="<%=representatives.get(i).firstName%>"/> <br></br>
				Last Name: <input type="text" name="lastname" value="<%=representatives.get(i).lastName%>"/> <br></br>
				<input type="Submit" value="Update Representative Information"/> <br></br>
			</form> 
			<br></br>
			<form action="editCustomerRepresentative.jsp" method="POST">
				<input type="Submit" value="Cancel"/>
			</form>
			
			<%
			
		}
    	
    	
%>


</body>
</html>

