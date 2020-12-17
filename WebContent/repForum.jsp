<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>



<%
	ArrayList<Question> Questions = TrainProject.Questions.getAsList();
	ArrayList<Answer> Answers = TrainProject.Answers.getAsList();
	String x = request.getParameter("keywords");
	ArrayList<Question> temp = new ArrayList<Question>();
	if(x !=null)
	{
		int i =0;
		for(i = 0; i<Questions.size(); i ++)
		{
			if(Questions.get(i).toString().contains(x) || Questions.get(i).descriptionText.contains(x)){
				temp.add(Questions.get(i));
			}
		}
		if(temp.size() == 0){
			response.sendRedirect("repForum.jsp");
			session.setAttribute("keywords", null);
			return;
		}
	}	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Q&A Forum</title>
</head>
<body>

<form action="RepresentativeLanding.jsp" method="GET">
	<input type="Submit" name="filter" value="RETURN TO DASHBOARD" /> <br></br>
</form> <br></br><br></br>

<% /*
	<div class="topnav">
  	<a class="active" href="http://localhost:8080/TrainProject/RepresentativeLanding.jsp">Home Page</a>
	</div>*/
%>

	Search questions by keyword: <form action="repForum.jsp" method="POST">
		<input type="text" name="keywords"/> 
		<input type="Submit" value="Search">
	</form><br></br>

	<h2>Customer Questions: </h2>
	<form name = "qID" action = "answerQuestions.jsp" method = "GET"><%
	if(x==null){ %>
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
		} 
	}else{ %>
	<%
		for(int i = 0; i < temp.size(); i ++ ){%> 
	 		<h2> <%=temp.get(i).toString()%> </h2>
	    	<p> <%=temp.get(i).descriptionText%></p>
	    
	    	<div>Posted by: <%=temp.get(i).username%> </div> <br></br><%
	    	if(temp.get(i).getAnswers().size() == 0)
	    	{
	    		%> 
	    			<input name = <%=temp.get(i).questionID %> type = "Submit" value = "Answer this question" />
	    		<%
	    	} else{
	    		for(int j = 0; j <temp.get(i).getAnswers().size(); j++) { %> 
	    			<p><%=temp.get(i).getAnswers().get(0).toString()%></p> <br></br> <%
	    		}
	    	} 
		} 
	}%>
</form>
	
</body>
</html>