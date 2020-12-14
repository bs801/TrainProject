<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
	
	
	int i = 0 ;
	for( i = 0; i< Questions.size(); i++)
	{
		//out.println(Questions.get(i).toString());
		if(request.getParameter(Questions.get(i).questionID+"") != null){
			// out.println(Questions.get(i).questionID);
			break;
		}
	}
	session.setAttribute("AQ1_qID", Questions.get(i).questionID+"");
	
	 // Display the question and display the discription and a text area inside a form
	// And form action should link to answerQuestion2.jsp.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<h2> <%=Questions.get(i).questionText%> </h2>
	<p> <%=Questions.get(i).descriptionText%></p>
	
	<p>Type your answers below!</p>
	<form action="answerQuestions2.jsp" method="POST">
	<textarea rows="5" type="text" name="answerText"> </textarea>
	<input type="Submit" value="Post answers">
	</form>

</body>
</html>