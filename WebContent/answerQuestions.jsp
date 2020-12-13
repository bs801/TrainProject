<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
	int i = 0;
	for( i = 0; i< Questions.size(); i++)
	{
		if(request.getParameter(Questions.get(i).questionID+"") != null){
			out.println(Questions.get(i).questionID);
		}
	} // Display the question and display the discription and a text area inside a form
	// And form action should link to answerQuestion2.jsp.
	
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