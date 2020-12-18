<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
    
<%
	if(session.getAttribute("EU") != null){
		out.println((String) session.getAttribute("EU"));
		session.setAttribute("EU", null);
	}

%> 


    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>


</head>
<body>




<h2>Select Customer Representative to Edit</h2>
    <form action="editCustomerRepresentative2.jsp" method="POST">
    <%  
    
    ArrayList<Representative> representatives = TrainProject.Representatives.getAsList();

    int i = 0;
    for(Representative r : representatives){ %>
  	    <input type="radio" name="command" value=<%=i++%> /> <%=r.username%>
  	    <br></br> 
    <% } %>
     <br></br> 
     <input type="submit" name="D" value="Delete"/>
     <input type="submit" name="E" value="Edit"/>
    </form>
    <br></br> 
    <form action="AdminLanding.jsp" method="POST">
<input type="Submit" value="Back to Admin Page"/>
</form>
</body>
</html>

