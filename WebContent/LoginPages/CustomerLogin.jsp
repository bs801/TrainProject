<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.time.LocalTime, java.time.LocalDateTime"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 
if(session.getAttribute("CL2") != null){
		ArrayList<String> errors = (ArrayList<String>) session.getAttribute("CL2");
		out.println(errors+"<br></br>");
	}%>

<form action="CustomerLogin2.jsp" method="POST">
	Username: <input type="text" name="username" placeholder="username"/> <br></br>
	Password: <input type="password" name="password" placeholder="password"/> <br></br>
	<input type="Submit" value="Login"/> <br></br>
</form>
<br></br>

<form action="index.jsp" method="POST">
<input type="Submit" value="Cancel"/> <br></br>
</form>
</body>
</html>