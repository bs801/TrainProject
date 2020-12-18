<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.time.LocalTime, java.time.LocalDateTime"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	
	String username = request.getParameter("username");   
	String password = request.getParameter("password");
	ArrayList<String> errors = new ArrayList<String>();
	session.setAttribute("RL2", errors);
	for(Representative u : TrainProject.Representatives.getAsList()){
		if(u.username.equalsIgnoreCase(username)){
			if(u.password.equals(password)){
				session.setAttribute("username", u.username);
				session.setAttribute("representative",u);
				response.sendRedirect("../RepresentativeLanding.jsp");
				return;
			} else {
				
				errors.add("Incorrect password for "+username);
				response.sendRedirect("RepresentativeLogin.jsp");
				return;
			}
		}
	}
	errors.add("No account with username "+username+" was found");
	response.sendRedirect("RepresentativeLogin.jsp");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>