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
    // out.println(Questions);
%>	
	
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Post Questions</title>
</head>
<body>
<h2>Post a new question</h2>
<form action="PostQuestion2.jsp" method="POST">
	Question Title: <br></br> <input type="text" name="question"/>  <br></br>
	Post Body: <br></br> <textarea rows="5" type="text" name="description"> </textarea>
	 <br></br>
	<input type="Submit" value="Post question">
</form>
 <br></br>
  <br></br>

<form action="forum.jsp" method="POST">
	<input type="Submit" value="Cancel">
</form>



</body>
</html>

