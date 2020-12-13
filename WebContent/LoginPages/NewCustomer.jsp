<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Sign-Up</title>
</head>
<body>
<h1>Customer Sign-Up</h1>

<%
	if(session.getAttribute("NC2") != null){
		ArrayList<String> errors = (ArrayList<String>) session.getAttribute("NC2");
		out.println(errors+"<br></br>");
	}
%>

<form action="NewCustomer2.jsp" method="POST">
	Username: <input type="text" name="username" placeholder="username"/> <br></br>
	Password: <input type="password" name="password" placeholder="password"/> <br></br>
	Email: <input type="text" name="email" placeholder="email@website.com"/> <br></br>
	First Name: <input type="text" name="firstname" placeholder="First Name"/> <br></br>
	Last Name: <input type="text" name="lastname" placeholder="Last Name"/> <br></br>
	<input type="Submit" value="Sign up"/> <br></br>
</form>
<br></br>

<form action="index.jsp" method="POST">
<input type="Submit" value="Cancel"/> <br></br>
</form>

</body>
</html>