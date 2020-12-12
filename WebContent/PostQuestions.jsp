<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
	if(session.getAttribute("255") != null)
	{
		out.println("Please make description text less than 255");
		session.setAttribute("255", null);
	}
    ArrayList<Question> Questions = TrainProject.Questions.getAsList();
    out.println(Questions);
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Post Questions</title>
</head>
<body>
<p>Type your questions and descriptions below!</p>
<form action="PostQuestion2.jsp" method="POST">
	<input type="text" name="question"/> <br></br>
	<textarea rows="5" type="text" name="description"> </textarea>
	<input type="Submit" value="Post question">
</form>



</body>
</html>

