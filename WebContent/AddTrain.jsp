<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.time.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Train</title>
</head>
<body>
<h1>Add a Train Here</h1>
<%
ArrayList<Train> train = TrainProject.Trains.getAsList();

if(session.getAttribute("AT2") != null){
	out.println((ArrayList<String>) session.getAttribute("AT2")+"<br></br>");
}

int i = 0;
while(true){
	boolean taken = false;
	for(Train t : train){
		if(t.trainID == i){
			taken = true;
		}
	}
	if(taken){
		continue;
	}
	break;
}
%>
The lowest available trainID is pre-filled into the form.
Zeros will automatically be tacked on to IDs with less than 3 digits.

<br></br> 
<form action="AddTrain2.jsp" method="POST">
TrainID: <input type="text" name="trainID" value=<%=Formatting.getTrainID(i)%> /> 
		
<br></br> 
<input type="Submit" value="Add train"/>
</form>

<br></br> 
	
<form action="RepresentativeLanding.jsp" method="POST">
<input type="Submit" value="Cancel"/>
</form>
</body>
</html>