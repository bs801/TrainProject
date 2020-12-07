<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
    
<%

//request
//response
//sesssion

	out.println(session.getAttribute("keyABC"));
	out.println(request.getParameter("Key123"));
	if(((String) request.getParameter("Key123")).equals("asdf")){
		response.sendRedirect("X.jsp");
	}
	out.println(request.getParameter("Key234"));
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