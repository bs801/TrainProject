<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.util.*"%>
    
<%
    
    	String varname = (String) request.getParameter("command");
    	int v = Integer.parseInt(varname);
    	out.println(v);
    	TrainProject.Questions.get(v);
    	
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>We are now on page B</title>
</head>
<body>

</body>
</html>

