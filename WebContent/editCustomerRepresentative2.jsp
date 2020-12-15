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
    
    	int i = Integer.parseInt(request.getParameter("command"));
		System.out.println(i);
		ArrayList<Representative> representatives = TrainProject.Representatives.getAsList();
    	
		if(request.getParameter("D") != null){
			
			
		}
		else if(request.getParameter("E") != null){
			%>
			
			<form action="" method="POST">
				<%	out.println("Username: "+representatives.get(i).username); %>
				<br></br>
				<%	out.println("Password: "+representatives.get(i).password); %>
				<br></br>
				<%	out.println("SSN: "+representatives.get(i).SSN); %>
				<br></br>
	
				First Name: <input type="text" name="firstname" value="<%=representatives.get(i).firstName%>"/> <br></br>
				Last Name: <input type="text" name="lastname" value="<%=representatives.get(i).lastName%>"/> <br></br>
				<input type="Submit" value="Submit"/> <br></br>
			</form> 
			<form action="editCustomerRepresentative.jsp" method="POST">
				<input type="Submit" value="Cancel"/>
			</form>
			
			<%
			
		}
    	
    	
%>


</body>
</html>

