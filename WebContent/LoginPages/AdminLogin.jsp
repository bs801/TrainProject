<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Admin login information is "admin" and "password"


<br></br>
<% 
if(session.getAttribute("AL2") != null){
		ArrayList<String> errors = (ArrayList<String>) session.getAttribute("AL2");
		out.println(errors+"<br></br>");
	}%>

<form action="AdminLogin2.jsp" method="POST">
	Username: <input type="text" name="username" placeholder="username"/> <br></br>
	Password: <input type="password" name="password" placeholder="password"/> <br></br>
	<input type="Submit" value="Login"/> <br></br>
</form>
</body>
</html>