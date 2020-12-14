<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
		
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Q&A Forum</title>
</head>
<body>
	<form name = "qID" action = "answerQuestions.jsp" method = "GET">
	<%
	for(int i = 0; i < Questions.size(); i ++ ){%> 
	 	<h2> <%=Questions.get(i).toString()%> </h2>
	    <p> <%=Questions.get(i).descriptionText%></p>
	    
	    <div>Posted by: <%=Questions.get(i).username%> </div> <br></br><%
	    if(Questions.get(i).getAnswers().size() == 0)
	    {
	    	%> 
	    		<input name = <%=Questions.get(i).questionID %> type = "Submit" value = "Answer this question" />
	    	<%
	    } else{
	    	for(int j = 0; j <Questions.get(i).getAnswers().size(); j++) { %> 
	    		<p><%=Questions.get(i).getAnswers().get(0).toString()%></p> <br></br> <%
	    	}
	    } 
	} %>
</form>
	
</body>
</html>