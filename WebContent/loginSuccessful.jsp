<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>You are now logged in</title>
</head>
<body>

<%
	session.setAttribute("loggedIn","yes");
	String username = (String) session.getAttribute("username");  
	if(((Boolean) session.getAttribute("newAccount")).booleanValue()){
		out.println("Welcome to your new account, "+username+"!");
	} else {
		out.println("Welcome back, "+username+"!");
	}

%>

<br/><br/>
<form action="logout.jsp" method="POST"><input type="submit" value="Logout"></form>
</body>
</html>