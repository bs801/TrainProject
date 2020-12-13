<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
  
 <%  session.setAttribute("username","user1"); //we need to delete this part after
     String user = (String)session.getAttribute("username");
     String q = request.getParameter("question");
     String d = request.getParameter("description");
     System.out.println(d);
     if(d.length()>255|| q.length()>255){
    	response.sendRedirect("PostQuestions.jsp");
    	session.setAttribute("255", new Object()); 
    	return;
     }
     Question p = new Question(-1,q,user,d);
     TrainProject.Questions.insert(p);
 %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>More Question</title>
<p>Succesful! Do you have more questions?</p>

<button id="myButton" class="float-left submit-button" >Yes?</button>
<script type="text/javascript">
    document.getElementById("myButton").onclick = function () {
        location.href = "http://localhost:8080/TrainProject/PostQuestions.jsp";
    };
</script>

</head>
<body>

</body>
</html>