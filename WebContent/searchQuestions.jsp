<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
	ArrayList<Question> temp = new ArrayList<Question>();
	String x = request.getParameter("key words");
	int i =0;
	for(i = 0; i<Questions.size(); i ++)
	{
		if(Questions.get(i).toString().contains(x) || Questions.get(i).descriptionText.contains(x)){
			temp.add(Questions.get(i));
		}
	}
	if(temp.size() == 0){
		response.sendRedirect("forum.jsp");
		session.setAttribute("keywords", null);
		return;
	}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Result</title>
</head>
<body>
	<h1>Search Result</h1>
	<% 
	for( i = 0; i < temp.size(); i ++ )
	{%> 
	 	<h2> <%=temp.get(i).toString()%> </h2>
	    <p> <%=temp.get(i).descriptionText%></p>
	    
	    <div>Posted by: <%=temp.get(i).username%> </div> <br></br> <%
	    
	  	if(temp.get(i).getAnswers().size() != 0){
	    	for(int j = 0; j <temp.get(i).getAnswers().size(); j++) { %> 
	    		<p><%=temp.get(i).getAnswers().get(0).toString()%></p> <br></br> <%
	    	}
	    } 
	} %>






</body>
</html>