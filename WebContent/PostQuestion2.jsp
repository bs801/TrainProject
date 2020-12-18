<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
  
 <%  //session.setAttribute("username","user1"); //we need to delete this part after
     String user = (String)session.getAttribute("username");
     String q = request.getParameter("question");
     String d = request.getParameter("description");
     System.out.println(d);
     if(d.length()>255|| q.length()>255){
    	response.sendRedirect("PostQuestion.jsp");
    	session.setAttribute("255", new Object()); 
    	return;
     }
     Question p = new Question(-1,q,user,d);
     TrainProject.Questions.insert(p);
     response.sendRedirect("forum.jsp");
 %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>More Question</title>
</head>
<body>
<h1>Successful!</h1>
<p>Do you have more questions?</p>
<br></br>
<form action="PostQuestion.jsp" method = "POST">
<input type="submit" value="Yes"/>
</form>
<p>Go Back to Forum</p>
<form action="forum.jsp" method = "POST">
<input type="submit" value="Yes"/>
</form>


</body>
</html>