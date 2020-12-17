<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
 
 <%  
 	
 
 	session.setAttribute("username","user2"); //we need to delete this part after
     String user = (String) session.getAttribute("username");
     String s = request.getParameter("answerText");
     String qid = (String) session.getAttribute("AQ1_qID");
     System.out.println(qid);
  	int intqid = Integer.parseInt(qid);
     
     System.out.println(s);
     if(s.length()>255){
    	response.sendRedirect("answerQuestions.jsp");
    	session.setAttribute("255", new Object()); 
    	return;
     }
     
     Answer p = new Answer(-1,s,intqid,user);
     
 	 
     
     TrainProject.Answers.insert(p);
 %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<p>Succesful!</p>


<form action="forum.jsp" method="POST">
	<input type="Submit" value="Go Back to Forum"/>
</form>

<form action="answerQuestions.jsp" method = "POST">
<input type="submit" value="Ask Another Question"/>
</form>	



</body>
</html>