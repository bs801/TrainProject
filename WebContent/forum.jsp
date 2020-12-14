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
			response.sendRedirect("forum.jsp");
			session.setAttribute("keywords", null);
			return;
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title> Q&A Forum</title>
</head>
<body>
	<div class="topnav">
  	<a class="active" href="http://localhost:8080/TrainProject/CustomerLanding.jsp">Home Page</a>
	</div>
	<form action="forum.jsp" method="POST">
	<input type="text" name="keywords"/> <br></br>
	<input type="Submit" value="Search Questions">
	</form>
	
	<p>Want to post a new Question?</p>
	<form action="PostQuestion.jsp" method = "POST">
	<input type="submit" value="Post New Questions"/>
	</form> 
	
	<p><font size = "6" face = "courier" color ="blue"><b>History of All The Questions</b></font></p>
	<%
	if(x!=null){ %>
		<%
		for(int i = 0; i < temp.size(); i ++ )
		{%> 
			<p><font size = "10" color ="blue">------------------------------------------------ </font> </p>
	 		<h1><font size = "3" color = "red">Questions </font></h1>
	 		<% out.print("No."+(i+1)+ ""); %>
	 		<h2> <%=temp.get(i).toString()%> </h2>
	    	<p> <%=temp.get(i).descriptionText%> </p>
	    	<div>Posted by: <%=temp.get(i).username%> </div> <br></br> 
	    	
	    	<%
	    	
	  		if(temp.get(i).getAnswers().size() != 0){
	    		for(int j = 0; j <temp.get(i).getAnswers().size(); j++) { %> 
	    			<p><font size = "3" color = "red">Answers</font></p>
	    			<p><%=temp.get(i).getAnswers().get(0).toString()%></p> <br></br> <% 
	    		}
	   		 }
	    
		} %> 
	 <%}else{ %>
		<%
			for(int i = 0; i < Questions.size(); i ++ )
			{%> 
				<p><font size = "10" color ="blue">------------------------------------------------ </font></p>
				<h1><font size = "3" color = "red">Questions </font></h1>
				<% out.print("No."+(i+1)+ ""); %>
	 			<h2> <%=Questions.get(i).toString()%> </h2>
	    		<p> <%=Questions.get(i).descriptionText%></p>
	    		<div>Posted by: <%=Questions.get(i).username%> </div> <br></br> 
	    		<%
	  			if(Questions.get(i).getAnswers().size() != 0){
	    			for(int j = 0; j <Questions.get(i).getAnswers().size(); j++) { %> 
	    				<p><font size = "3" color = "red">Answers</font></p>
	    				<p><%=Questions.get(i).getAnswers().get(0).toString()%></p> <br></br> <% 
	    			}
	   		 	}
	    	
			} 
		}%>
	
	
</body>
</html>