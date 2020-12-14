<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.time.LocalTime, java.time.LocalDateTime"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	
	String username = request.getParameter("username");   
	String password = request.getParameter("password");
	ArrayList<String> errors = new ArrayList<String>();
	session.setAttribute("AL2", errors);

		if("admin".equalsIgnoreCase(username)){
			if("password".equals(password)){
				session.setAttribute("username", username);
				response.sendRedirect("../AdminLanding.jsp");
				return;
			} else {
				errors.add("Incorrect password for "+username);
				response.sendRedirect("AdminLogin.jsp");
				return;
			}
		}
	
	errors.add("No admin account with username "+username+" was found");
	response.sendRedirect("AdminLogin.jsp");

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